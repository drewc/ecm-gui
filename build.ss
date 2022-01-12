#!/usr/bin/env gxi
;; -*- Gerbil -*-

(import :std/build-script)

(defbuild-script
  '("server/httpd" "endpoints/login" "auth" "database"
    "endpoints/report/pmi"))
