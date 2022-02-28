;; -*- no-byte-compile: t; -*-

;; NOTE This file is generated from the README.org file. Do not alter this
;; packages.el directly and only modify the REAME.org file then Alt-x and type:
;; 'org-babel-tangle' in emacs and run 'doom sync' in the terminal. Happy hacking :-)

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-refresh-contents)
(package-initialize)

;; Disable the nose package, because is not maintained and giving :lang python error
(package! nose           :disable t)

(package! mu4e)
(package! powerline)
;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
;(package! some-package)
