(export #t)
(import :drewc/ftw :std/misc/uuid :std/sugar
        :drewc/db/postgresql :drewc/db/dbi
        :drewc/pg/connect :std/error)

(def pg-connect-args [host: "ecm.maxwellclaims.net"
                            user: "maxclaims"])

(defvalues (login-db reset-login-db)
  (let (db #f)
    (let l ()
      (def (login-db)
        (or db
            (begin (set! db (apply connect pg-connect-args))
                   db)))
      (def (reset-login-db) (set! db #f))
      (values login-db reset-login-db))))

(def (role<-username username)
  (def un (sql-eval-query
           (login-db) "SELECT usename FROM app_user
            LEFT JOIN pg_shadow ON (username = usename::text)
            WHERE username = $1" username))
  (or (car un)
      (car (sql-eval-query
            (login-db) "SELECT usename FROM app_user
             LEFT JOIN pg_shadow ON (usename = 'mu_' || app_user_id::text)
             WHERE username = $1" username))))

(def username->role role<-username)

(def (authenticate-user username password)
  (def role (role<-username username))
  (def q "SELECT passwd = 'md5' || md5($1||$2) from pg_shadow WHERE usename = $2")
  (car (sql-eval-query (login-db) q password role)))

(defstruct ecm-user (id name role))

(def (ecm-user<-username username)
  (def id
    (try
     (car
      (sql-eval-query
       (login-db)
       "SELECT app_user_id FROM app_user WHERE username = $1" username))
     (catch _ #f)))

  (def role (and id (role<-username username)))
  (and role (make-ecm-user id username role)))

(def default-ecm-user-table (make-hash-table))
(def current-ecm-user-table (make-parameter default-ecm-user-table))

(begin
  (def (ecm-user<-uuid uuid)
    (hash-get (current-ecm-user-table) uuid))

  (def uuid->ecm-user ecm-user<-uuid))

(def (login-user username password)
  (def uuid (uuid->string (random-uuid)))
  (def auth (authenticate-user username password))
  (def u (and auth (ecm-user<-username username)))
  (if (not u) #f
      (begin (hash-put! (current-ecm-user-table) uuid u)
             uuid)))

(define-json-endpoint login "/rpc/login")

(def (with-try-db thunk)
  (let givr ((again? #t))
    (unless again? (reset-login-db))
    (try (thunk)
         (catch (e) (if again? (givr #f) (raise e))))))
(def (login/POST)
  (def jso (http-request-body-json*))
  (def u (try (let-hash jso (with-try-db (cut login-user .u .p)))
              (catch _ #f)))
  (let* ((uuid u)
         (user (and uuid (ecm-user<-uuid uuid)))
         (name (and user (ecm-user-name user)))
         (id (and user (ecm-user-id user)))
         (role (and user (ecm-user-role user))))
  (respond/JSON (and user
                     (hash (uuid uuid)
                      (name name)
                      (id id)
                      (role role))))))

(def (login/GET)
  (let* ((uuid (assget "ecm-login-uuid" (http-request-cookies*)))
         (user (and uuid (ecm-user<-uuid uuid)))
         (name (and user (ecm-user-name user)))
         (id (and user (ecm-user-id user)))
         (role (and user (ecm-user-role user))))
  (respond/JSON (and id (hash (uuid uuid)
                      (name name)
                      (id id)
                      (role role))))))
