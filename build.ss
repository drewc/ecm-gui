#!/usr/bin/env gxi
;; -*- Gerbil -*-

(import :std/build-script)

(import :std/build-script :std/make
        :gerbil/gambit/ports :gerbil/compiler/driver)

(def gerbil-path (getenv "GERBIL_PATH" "~/.gerbil"))
(def gerbil-home (getenv "GERBIL_HOME" gxc#default-gerbil-home))
(def gerbil-gsc std/make#gerbil-gsc)
(def gambcsharp (path-expand "lib/static/gx-gambc#.scm" gerbil-home))

(def (g-compile-static-exe file)
  (def fn (path-strip-extension file))
  (def scmx (string-append fn ".scmx"))
  (def bin (path-expand (path-strip-directory fn) "./bin/"))
  (def -e (string-append "(include \"" gambcsharp "\")"))
  (def (gxcomp)
    (compile-static-exe
     (string-append fn ".ss")
     [ verbose: #t
       invoke-gsc: #f
       output-file: file keep-scm: #t
     ]))
  (def (gscomp)
    (let* ((proc (open-process
                  [path: (gerbil-gsc)
                   arguments: [ #;"-:i8,f8,-8,t8" "-verbose" "-exe" "-o" bin "-e" -e scmx]
                   stdout-redirection: #f]))
         (status (process-status proc)))
    (close-port proc)
    (unless (zero? status)
      (error "Compilation error; gsc exited with nonzero status" status)))
    )
  (gxcomp)
  #;(shell-command (string-append
                  "sed 's/(optimize-dead-definitions)//g' -i "
                  scmx))
  (gscomp))

(def srcdir
  (path-normalize (path-directory (this-source-file))))

(def (build-lib)
(defbuild-script
  '("server/httpd" "endpoints/login" "auth" "conf" "database"
   "endpoints/report/pmi" "ecm-gui")
  
  ;'("test-dep" "test-uep" "test-jep" "endpoints/report/pmi")
    verbose: 1
    ;bindir: srcdir
    ; libdir: srcdir
    static: #t)
  (main))

(def (build-static)
  (defbuild-script
    '((static-exe: "ecm-gui" #;"-verbose" "-cc-options" "-v"))
    static: #t
    bindir: (path-expand "bin/" srcdir)
    optimize: #t
    debug: #f
                                        ; libdir: srcdir
    build-deps: "build-deps-bin" ; importantly, pick a file that differs from above
    ;verbose: 10
    )
  (main)
 ;;(g-compile-static-exe "ecm-gui")
                                        ;(display (gx#current-expander-module-library-path))
  )

(def (main . args) (build-lib) (build-static)
  )
