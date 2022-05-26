;; -*- no-byte-compile: t; -*-

;; NOTE This file is generated from the README.org file. Do not alter
;; packages.el directly and only modify the README.org file in emacs by
;; 'M-x' 'org-babel-tangle' RET and run $ '~/.emacs.d/bin/doom sync'

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-refresh-contents)
(package-initialize)

(package! nose :disable t)

;; Help finding the cursor
(package! beacon)

(package! visual-fill-column)
