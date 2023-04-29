;; NOTE: This file is generated from ~/.doom.d/README.org
;;      Please only edit that file and org-babel-tangle (emacs)

(setq doom-theme 'doom-tokyo-night)

(setq fancy-splash-image "~/.doom.d/doom-emacs.png")
(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)
(add-hook! '+doom-dashboard-functions :append
  (insert "\n" (+doom-dashboard--center +doom-dashboard--width "A melodramatic vimmer spirals into despair before he succumbs to the dark side: this config.")))

(beacon-mode 1)
(setq beacon-blink-duration 3)

(use-package centered-cursor-mode
  :demand
  :config
  ;; Optional, enables centered-cursor-mode in all buffers.
  (global-centered-cursor-mode))

(use-package rainbow-delimiters)

(set-frame-font "Hack 12" t t)
(setq default-frame-alist '((font . "Hack 13")))

(define-globalized-minor-mode my-global-hl-todo-mode hl-todo-mode
  (lambda () (hl-todo-mode 1)))
(my-global-hl-todo-mode 1)

(setq-default fill-column 110)
(global-display-fill-column-indicator-mode)
(add-hook 'visual-line-mode-hook 'visual-fill-column-mode)
(setq-default visual-fill-column-center-text t)

;(set-frame-parameter (selected-frame) 'alpha '(95 90))
;(add-to-list 'default-frame-alist '(alpha 95 90))
(set-frame-parameter (selected-frame) 'alpha '(85 80))
(add-to-list 'default-frame-alist '(alpha 85 80))

(global-display-line-numbers-mode)
(setq display-line-numbers-type 'relative)

(scroll-bar-mode -1)

(setq! evil-want-Y-yank-to-eol nil)

(setq evil-normal-state-cursor '(box "tomato")
      evil-insert-state-cursor '(bar "white")
      evil-visual-state-cursor '(hollow "orange"))

(setq evil-goggles-duration 1.0)

(add-to-list 'auto-mode-alist '("\\.ino\\'" . c-mode))

(setq confirm-kill-emacs nil)

(map! :leader
      (:prefix ("d" . "Prutserdt Bindings")
          (:prefix ("a" . "Aduino IDE")
                :desc "ESP32 PWRSTRK testing upload" "t" #'PowerStrike-testing-upload
                :desc "ESP32 PWRSTRK upload"         "p" #'PowerStrike-upload
                :desc "ESP32 serial"                 "s" #'serial-ttyUSB0-115200)
          (:prefix ("b" . "Buffer options")
                :desc "Kill current buffer"       "k" #'kill-this-buffer
                :desc "Kill some buffers"         "K" #'kill-some-buffers
                :desc "Open a buffer"             "o" #'buffer-menu)
       :desc "Search hotkey key briefly"          "d" #'describe-key-briefly
       :desc "Describe function"                  "h" #'describe-function
       :desc "Increase font size"                 "i" #'doom/increase-font-size
       :desc "Find a file"                        "f" #'find-file
       :desc "Open recent files"                  "o" #'counsel-recentf
       :desc "Reload Doom: doom/reload"           "r" #'doom/reload
       :desc "Tangling: org-babel-tangle"         "t" #'org-babel-tangle
       :desc "Hide org blocks"                    "L" #'org-fold-hide-block-all
       :desc "Laat zien org blocks"               "l" #'org-fold-show-all
       :desc "Plak keuze uit kill ring"           "p" #'consult-yank-from-kill-ring
       :desc "Huidige org block aan/uit"          "s" #'org-fold-hide-block-toggle
       :desc "Treemacs file navigation"           "." #'treemacs
          (:prefix ("w" . "windows op scherm")
                :desc "Cursor to left window"     "h" #'evil-window-left
                :desc "Cursor to right window"    "l" #'evil-window-right
                :desc "Close the window"          "k" #'delete-window
                :desc "Maximize buffer to window" "m" #'doom/window-maximize-buffer
                :desc "split window horizontally" "s" #'split-window-horizontally)
       :desc "Write this buffer to file"        "z" #'write-file))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((sql . t)))

(setq org-superstar-headline-bullets-list '("◉" "○" "✿" "✸" "⁖" ))

(custom-set-faces
  '(org-level-1 ((t (:inherit outline-1 :height 1.5))))
  '(org-level-2 ((t (:inherit outline-2 :height 1.4))))
  '(org-level-3 ((t (:inherit outline-3 :height 1.3))))
  '(org-level-4 ((t (:inherit outline-4 :height 1.2))))
  '(org-level-5 ((t (:inherit outline-5 :height 1.1))))
)

(setq org-hide-emphasis-markers t)

(use-package org-auto-tangle
  :load-path "site-lisp/org-auto-tangle/"    ;; this line is necessary only if you cloned the repo in your site-lisp directory
  :defer t
  :hook (org-mode . org-auto-tangle-mode))

(setq org-agenda-files
      '("~/Stack/Code/Emacs/Tasks.org"))

(defun PowerStrike-testing-upload ()
  (interactive)
  (async-shell-command "arduino --board esp32:esp32:esp32 --port /dev/ttyUSB0 --upload ~/Stack/Code/git/PowerStrike_code/testing/testing.ino"
  (doom/window-maximize-buffer)
  (split-window-horizontally)
  (switch-to-buffer "*Async Shell Command*")
  (windmove-right)))

(defun serial-ttyUSB0-115200 ()
  (interactive)
  (split-window-horizontally)
  (serial-term "/dev/ttyUSB0" 115200)
;;(switch-to-buffer "/dev/ttyUSB0")
  (windmove-right))
