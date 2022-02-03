(export #t)
(import :drewc/ftw
        :std/sugar
        :drewc/db/dbi :std/srfi/13
        ../../auth ../../database
        :std/text/json
        )
(declare (not optimize-dead-definitions))

(def d-text
  "SELECT * FROM diary_report($1, $2, $3, $4)")

(def (json-object<-diary deadline user-id overdue start-date)
  (json-object<-ecm-sql-eval-query*
   d-text deadline user-id overdue start-date))

(define-json-endpoint diary "/rpc/report/diary")

(def-auth (diary/POST)
  (def jso (http-request-body-json*))
  (def res (let-hash jso (json-object<-diary
                          .deadline .user_id .overdue .start_date)))
  (respond/JSON res))
