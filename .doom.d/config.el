;; NOTE: This file is generated from the README.org file. Do not alter
;; config.el directly and only modify the README.org file in emacs and
;; 'M-x' 'org-babel-tangle' and reload by 'M-x' 'doom/reload'

(setq! evil-want-Y-yank-to-eol nil)

(setq fancy-splash-image "~/.doom.d/doom-emacs.png")

(beacon-mode 1)
(setq beacon-blink-duration 3)

(setq evil-normal-state-cursor '(box "tomato")
      evil-insert-state-cursor '(bar "white")
      evil-visual-state-cursor '(hollow "orange"))

(setq org-superstar-headline-bullets-list '("◉" "○" "✿" "✸" "⁖" ))

(setq evil-goggles-duration 1.0)

(use-package rainbow-delimiters)

(set-frame-font "Hack 12" t t)
(setq default-frame-alist '((font . "Hack 13")))

(setq-default fill-column 110)
(global-display-fill-column-indicator-mode)
(add-hook 'visual-line-mode-hook 'visual-fill-column-mode)
(setq-default visual-fill-column-center-text t)

(global-display-line-numbers-mode)
(setq display-line-numbers-type 'relative)

(map! :leader
      (:prefix ("d" . "Personal Bindings")
       :desc "Switch to buffer"
       "b" #'switch-to-buffer
       :desc "Kill current buffer"
       "k" #'kill-buffer
       :desc "Open recent files"
       "o" #'recentf-open-more-files
       :desc "Reload Doom: doom/reload"
       "r" #'doom/reload
       :desc "Tangling: org-babel-tangle"
       "t" #'org-babel-tangle)
                )

(set-frame-parameter (selected-frame) 'alpha '(95 90))
(add-to-list 'default-frame-alist '(alpha 95 90))

(scroll-bar-mode -1)
