(import ;; :drewc/ftw
        ;;:ecm/gui/endpoints/login
        ;:ecm/gui/endpoints/report/pmi
        ;:ecm/gui/server/httpd
        ;:gerbil/gambit/threads
        )
#;(import :drewc/ftw :std/misc/uuid :std/sugar
        :drewc/db/postgresql ;;:drewc/db/dbi
        ;;:drewc/pg/connect ;; :std/error

        )

;; (import :drewc/ftw/httpd/handler
;;         :drewc/ftw/httpd/endpoint
;;         :drewc/ftw/httpd/cookies
;;         :drewc/ftw/httpd/parameters
;;         :std/net/httpd
;;         :std/net/socket
;;         :std/os/socket
;;        ; :drewc/ftw
;;         )
(import ;:drewc/ftw ; :std/misc/uuid :std/sugar
         :drewc/db/postgresql ;; :drewc/db/dbi
        ;; :drewc/pg/connect :std/error
        )
(export main)

(def (main . args)
  (display "ECM Gui v2.1.42")
  ;(thread-join! (ensure-ecm-httpd!))
  )
