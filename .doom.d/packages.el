;; -*- no-byte-compile: t; -*-

;; NOTE This file is generated from the README.org file. Do not alter this
;; packages.el fle directly and only modify the REAME.org file then Alt-x and type:
;; 'org-babel-tangle' in emacs and run 'doom sync' in the terminal. Happy hacking :-)

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-refresh-contents)
(package-initialize)

;; Disable the nose package. Not maintained and leading to :lang python error
(package! nose :disable t)

;; The email package MU for emacs
(package! mu4e)

;; Help finding the cursor
(package! beacon)
