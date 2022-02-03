(export #t)
(import :drewc/ftw
        :std/sugar
        :drewc/db/dbi :std/srfi/13
        :ecm/gui/auth :ecm/gui/database
        )
(declare (not optimize-dead-definitions))

(def pillar3-query-text "SELECT * from pillar_3(
  $1::int,
  $2::timestamp without time zone,
  $3::timestamp without time zone)")

(def (json-object<-pillar3 syndicate-id start-date end-date)
  (json-object<-ecm-sql-eval-query*
   pillar3-query-text syndicate-id start-date end-date))

(define-json-endpoint pillar3 "/rpc/report/pillar3")

(def-auth (pillar3/POST)
  (def jso (http-request-body-json*))
  (def res
    (let-hash jso
      (json-object<-pillar3
       .syndicate_id
            (substring .start_date 0 10)
            (substring .end_date 0 10))))
  (respond/JSON res))
