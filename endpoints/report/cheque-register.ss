(export #t)
(import :drewc/ftw
        :std/sugar
        :drewc/db/dbi :std/srfi/13
        ../../auth ../../database
        :std/text/json
        )
(declare (not optimize-dead-definitions))

(def cr-text
  "SELECT * FROM cheque_register_report($1)")

(def (json-object<-cheque-register jso)
  (json-object<-ecm-sql-eval-query*
   cr-text (json-object->string jso)))

(define-json-endpoint cheque-register "/rpc/report/cheque-register")

(def-auth (cheque-register/POST)
  (def jso (http-request-body-json*))
  (def res (json-object<-cheque-register jso))
  (respond/JSON res))
