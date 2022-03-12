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
(package! nose :disable t)

;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
(package! mu4e)
;; FIXME: ik wil dat bij column 80 een grijze lijn komt te staan
;;       hetzelfde als ik in Vim heb staan (colorcolumn 80)
;;(package! column-marker)
;;(require 'column-marker)

;; Help finding the cursor
(package! beacon)
