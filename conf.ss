(export #t)
(def conf-table (make-hash-table))
(def conf-ref (cut hash-get conf-table <>))
(def conf-ref-set! (cut hash-put! conf-table <> <>))
(def default-conf-values
  '((address . "0.0.0.0")
    (port . 8988)
    (wwwroot . "/srv/ecm-gui/wwwroot")))
(for-each (cut match <> ([k . v] (set! (conf-ref k) v)))
          default-conf-values)

(import :std/format :std/os/pid :std/logger :gerbil/gambit/ports)
(def (find-pid-exe (pid (getpid)))
  (def path (format "/proc/~a/exe" pid))
  (read-line (open-process [path: "readlink" arguments: ["-n" path]])))

(def (find-wwwroot)
  (def v (conf-ref 'wwwroot))
  (if (file-exists? v) v
      (let d ()
        (def p (path-expand "../dist/"
                            (path-directory (find-pid-exe))))
        (if (file-exists? p) p
            (warnf "Cannot find wwwroot in ~a or ~a" p v)))))
