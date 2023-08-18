;; -*- no-byte-compile: t; -*-

;; NOTE: This file is generated from ~/.doom.d/README.org
;;      Please only edit that file and org-babel-tangle (emacs)

(package! visual-fill-column)

(package! web-mode)

(package! arduino-cli-mode)
(package! arduino-mode)

(package! org-babel-eval-in-repl)
(package! eval-in-repl)
(package! jupyter)
(package! phpactor)

(package! org-auto-tangle)

(package! vterm-toggle)

(package! gptel)

(package! org-ai
  :recipe (:host github
           :repo "rksm/org-ai"
           :files ("*.el" "README.md" "snippets")))

(unpin! org-roam) ; unpinning is necessary for Room emacs according to de developer of org-roam-ui
(package! org-roam-ui)
