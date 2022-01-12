(export #t)
(import :drewc/ftw :std/misc/uuid :std/sugar
        :drewc/db/postgresql :drewc/db/dbi
        :drewc/pg/connect :std/error :ecm/gui/auth)


(define-json-endpoint pmi "/rpc/report/pmi")

(def-auth (pmi/GET)
  (def syns (ecm-sql-e*
             sql-eval-query "SELECT json_agg(row_to_json(syns))
     FROM (SELECT
            person_name(syndicate_id) AS syndicate,
            syndicate_id,
            max(effective_date) AS latest_effective,
            count(*) AS number_of_contracts
            FROM contract
            WHERE syndicate_id IS NOT NULL
           GROUP BY syndicate_id
           ORDER BY number_of_contracts DESC,
           latest_effective DESC, syndicate) syns"))
  (respond/JSON syns))
