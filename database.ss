(export #t)
(import :drewc/ftw :std/misc/uuid :std/sugar
        :drewc/db/postgresql :drewc/db/dbi
        :drewc/pg/connect :std/error
        :std/db/conpool :std/format :ecm/gui/auth)

(def ecm-pg-connect-args [ host: "ecm.maxwellclaims.net"
                           user: "maxclaims" ])
(def ecm-sql-conpool
  (make-conpool (cut apply connect ecm-pg-connect-args)
                100))

(def (ecm-sql-e role: (role "mr_read")
                fn . args)
  (def con (conpool-get ecm-sql-conpool 5))
  (def err #f)
  (try
   (sql-eval con (format "SET SESSION AUTHORIZATION \"~a\""
                         role))
   (apply fn con args)
   (catch (e) (set! err e))
   (finally
    (cond (err
           (conpool-release ecm-sql-conpool con)
           (raise err))
          (else
           (sql-eval con "RESET SESSION AUTHORIZATION")
           (conpool-put ecm-sql-conpool con))))))

(def (ecm-sql-e* fn . args)
  (def u (current-auth-user))
  (unless u (raise-auth-error 'ecm-sql-* "Auth user required"))
  (def r (ecm-user-role u))
  (apply ecm-sql-e role: r fn args))