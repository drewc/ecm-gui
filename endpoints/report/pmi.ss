(export #t)
(import :drewc/ftw
        :std/sugar
        :drewc/db/dbi :std/srfi/13
        :ecm/gui/auth :ecm/gui/database
        )
(declare (not optimize-dead-definitions))


(define-json-endpoint pmi "/rpc/report/pmi")

(def-auth (pmi/GET)
  (def syns (ecm-sql-e*
             sql-eval-query "
SELECT json_build_object('syndicates', syna)
 FROM (SELECT json_agg(row_to_json(syns)) AS syna
     FROM (SELECT
            person_name(syndicate_id) AS name,
            syndicate_id,
            max(effective_date) AS latest_effective,
            count(*) AS number_of_contracts
            FROM contract
            WHERE syndicate_id IS NOT NULL
           GROUP BY syndicate_id
           ORDER BY number_of_contracts DESC,
           latest_effective DESC, name) syns) moresyns"))
  (respond/JSON (car syns)))

(def-auth (pmi/POST)
  (def jso (http-request-body-json*))
  (def res
    (let-hash jso
      ;;(error "Hey now" .line_of_business .syndicate_id (substring .start_date 0 10))
      (car (ecm-sql-e*
            sql-eval-query
            #<<EOF
            SELECT row_to_json(rep) FROM (SELECT "Volume of Claims" as "B2",
                   "Volume of Closed Claims" as "B3", 
                   "Volume of Re-Opened Claims" AS "B4", 
                   "Volume of New Claims" AS "B5", 
                   "Value of open claims"::numeric AS "B6",
                   "% of work referred to London?" / 100 AS "B7",
                   "Volume of files held open for recovery/subrogation" AS "B8", 
                   "% Open claims referred to UW's outside of Market 5 day SLA"
                     / 100 AS "B10", 
                   "Volume of Claims not acknowledged within Market 48 hours SLA" AS "B11", 
                   "Volume of Overdue Diary Items" AS "B12", 
                   "% of Open Claims Peer Reviewed"
                    / 100 AS "B13", 
                   "Average days from 1st notification to 1st indemnity payment" AS "B14",
                   "Average days from 1st notification to closed" AS "B15", 
                   "Average days to establish initial reserve from notice of claim" AS "B16", 
                   "Variance of final to initial reserve (as %)"
                    / 100 AS "B17", 
                   "Volume of nil reserve claims older than 6 months (as %)" AS "B18", 
                   "Response time for acknowledging new claims" AS "B20", 
                   "How many full time Claims Examiners do you have?" AS "B30" 
            FROM mi_report($1, $2, $3, $4)) rep ;
EOF
            (substring .start_date 0 10)
            (substring .end_date 0 10) .syndicate_id
            (and (not (void? .line_of_business))
                 .line_of_business)))))
  (respond/JSON res))
