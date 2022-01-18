(export #t)

(import :drewc/ftw :std/format ../conf :std/srfi/13)

(def ecm-http-server #f)

(def (ensure-ecm-httpd! address: (address "0.0.0.0") port: (port 8988))
  (def saddress (format "~a:~a" address port))
  (or ecm-http-server
      (let ((s (start-ftw-http-server! saddress)))
        (set! ecm-http-server s)
        s)))

(def (match-file req)
  (def fn (string-trim (http-request-path req) #\/))
  (when (string= fn "") (set! fn "index.html"))
  (def wwwroot (conf-ref 'wwwroot))
  (def filename (path-expand fn wwwroot))
  (displayln "Searchgn for " filename)
  (and (file-exists? filename)
       [filename]))

(define-endpoint client-files match-file priority: 50)
(def client-files/GET (cut http-response-static-file* <>))


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
