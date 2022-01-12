(export #t)

(import :drewc/ftw :std/format)

(def ecm-http-server #f)

(def (ensure-ecm-httpd! address: (address "127.0.0.1") port: (port 8988))
  (def saddress (format "~a:~a" address port))
  (or ecm-http-server
      (let ((s (start-ftw-http-server! saddress)))
        (set! ecm-http-server s)
        s)))

;; (def static-root-dir (current-directory))

;; (define-endpoint js-files "^/js/(.*)$" priority: 1024)
;; (define-endpoint css-files "^/css/(.*)$" priority: 1024)
;; (define-endpoint html-files "^/html/(.*)$" priority: 1024)

;; (def (make-getter where)
;;   (lambda (filename)
;;     (http-response-static-file*
;;      (path-expand (string-append where filename)
;;                   static-root-dir))))

;; (def js-files/GET (make-getter "js/"))
;; (def css-files/GET (make-getter "css/"))
;; (def html-files/GET (make-getter "html/"))
