(import :drewc/ftw
        :ecm/gui/endpoints/login
        :ecm/gui/endpoints/report/pmi
        :ecm/gui/server/httpd
        :gerbil/gambit/threads
        :std/sugar
        ./conf
        :std/getopt
        )
(export main)

(extern namespace: #f replx macro-thread-tgroup)
(extern (display-exception display-exception))

(##current-input-port (##repl-input-port))
(##current-output-port (##repl-output-port))

(define (##repl-no-banner)
  (##repl-debug
   (lambda (first port) #f)
   #t))

(def main-opts
  (getopt
   (option '--wwwroot "--wwwroot"
           help: "The root for the http file server")))

#;(define (##new-repl)
  (declare (not interrupts-enabled))
  (##thread-start!
   (let* ((primordial-tgroup
           (macro-thread-tgroup ##primordial-thread))
          (input-port ##stdin-port)
          (output-port ##stdout-port)
          (thread
           (##make-root-thread
            (lambda ()
                (let ((input-port (##repl-input-port))
                      (output-port (##repl-output-port)))
                  (##parameterize ((##current-input-port input-port)
                                   (##current-output-port output-port))
                    ;; start REPL
                    (##repl-no-banner))))
            (##void) ;; no name
            primordial-tgroup
            input-port
            output-port)))
     thread)))

(def (main . args)
  (def httpd (ensure-ecm-httpd!))
  (set! args (getopt-parse main-opts args))
  (def wwwroot (or (hash-get args '--wwwroot) (find-wwwroot)))
  (set! (conf-ref 'wwwroot) wwwroot)

  (displayln wwwroot)
  (display "ECM Gui v2.a4a.42\n")

  (##repl-no-banner)
  (display "\nJoining httpd thread")
   (thread-join! httpd))
