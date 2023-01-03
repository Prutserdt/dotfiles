;; NOTE: This file is generated from ~/.doom.d/README.org
;;      Please only edit that file and org-babel-tangle (emacs)

(setq! evil-want-Y-yank-to-eol nil)

(setq fancy-splash-image "~/.doom.d/doom-emacs.png")
(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)
(add-hook! '+doom-dashboard-functions :append
  (insert "\n" (+doom-dashboard--center +doom-dashboard--width "A melodramatic vimmer spirals into despair before he succumbs to the dark side: this config.")))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((sql . t)))

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

(setq org-hide-emphasis-markers t)

(setq-default fill-column 110)
(global-display-fill-column-indicator-mode)
(add-hook 'visual-line-mode-hook 'visual-fill-column-mode)
(setq-default visual-fill-column-center-text t)

(global-display-line-numbers-mode)
(setq display-line-numbers-type 'relative)

(map! :leader
      (:prefix ("d" . "Personal Bindings")
          (:prefix ("b" . "Buffer options")
                :desc "Kill current buffer"     "k" #'kill-this-buffer
                :desc "Kill some buffers"       "K" #'kill-some-buffers
                :desc "Open a buffer"           "o" #'buffer-menu)
       :desc "Search hotkey key briefly"        "d" #'describe-key-briefly
       :desc "Describe function"                "h" #'describe-function
       :desc "Increase font size"               "i" #'doom/increase-font-size
       :desc "Find a file"                      "f" #'find-file
;      :desc "Open recent files"                "o" #'recentf-open-more-files
       :desc "Open recent files"                "o" #'counsel-recentf
       :desc "Reload Doom: doom/reload"         "r" #'doom/reload
       :desc "Tangling: org-babel-tangle"       "t" #'org-babel-tangle
       :desc "Hide org blocks"                  "L" #'org-fold-hide-block-all
       :desc "Laat zien org blocks"             "l" #'org-fold-show-all
       :desc "Plak keuze uit kill ring"         "p" #'consult-yank-from-kill-ring
       :desc "Huidige org block aan/uit"        "s" #'org-fold-hide-block-toggle
       :desc "Treemacs file navigation"         "." #'treemacs
       :desc "Write this buffer to file"        "w" #'write-file)
                )

(add-to-list 'auto-mode-alist '("\\.ino\\'" . c-mode))

(set-frame-parameter (selected-frame) 'alpha '(95 90))
(add-to-list 'default-frame-alist '(alpha 95 90))

(scroll-bar-mode -1)

(global-set-key (kbd "<mouse-2>") 'clipboard-yank)
;; misschien is deze ook nodig:...
(delete-selection-mode)
;; https://www.emacswiki.org/emacs/CopyAndPaste

(setq confirm-kill-emacs nil)
