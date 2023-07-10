;; NOTE: This file is generated from ~/.doom.d/README.org
;;      Please only edit that file and org-babel-tangle (emacs)

(setq doom-theme 'doom-tokyo-night)

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

(set-frame-parameter (selected-frame) 'alpha '(85 80))
(add-to-list 'default-frame-alist '(alpha 85 80))

(global-display-line-numbers-mode)
(setq display-line-numbers-type 'relative)

(scroll-bar-mode -1)

(setq fancy-splash-image "~/.doom.d/doom-emacs.png")
(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)

(add-hook! '+doom-dashboard-functions :append
    (insert "\n" (+doom-dashboard--center +doom-dashboard--width "An Emacs framework for the stubborn martian hacker, modified.\n\n")
    (+doom-dashboard--center +doom-dashboard--width "It is a story as old as time.\n")
    (+doom-dashboard--center +doom-dashboard--width "A stubborn, shell-dwelling and melodramatic\n")
    (+doom-dashboard--center +doom-dashboard--width "vimmer spirals into despair\n")
    (+doom-dashboard--center +doom-dashboard--width "before he succumbs to the dark side. \n\n")
    (+doom-dashboard--center +doom-dashboard--width "To get into the rabbit hole press 'e'")))

(defun +doom-dashboard-setup-modified-keymap ()
  (setq +doom-dashboard-mode-map (make-sparse-keymap))
  (map! :map +doom-dashboard-mode-map
        :desc "Increase font size(temporary)" :ng "+" #'doom/increase-font-size
        :desc "Decrease font size(temporary)" :ng "-" #'doom/decrease-font-size
        :desc "Change font(temporary)" :ng "f" #'menu-set-font
        :desc "Change theme(temporary)" :ng "t" #'consult-theme
        :desc "Open my Emacs config; README.org" :ng "e" (cmd! (find-file (expand-file-name "README.org" doom-user-dir)))
        :desc "Exiting via Evil-mode" :ng "ZZ" #'save-buffers-kill-terminal))
(add-transient-hook! #'+doom-dashboard-mode (+doom-dashboard-setup-modified-keymap))
(add-transient-hook! #'+doom-dashboard-mode :append (+doom-dashboard-setup-modified-keymap))
(add-hook! 'doom-init-ui-hook :append (+doom-dashboard-setup-modified-keymap))

(setq! evil-want-Y-yank-to-eol nil)

(setq evil-normal-state-cursor '(box "tomato")
      evil-insert-state-cursor '(bar "white")
      evil-visual-state-cursor '(hollow "orange"))

(setq evil-goggles-duration 1.0)

(setq initial-major-mode 'org-mode)
(setq initial-scratch-message
    (concat "* Hack away❗\n A _temporary_ *org-mode* ~scratch buffer~ /for/ *hacking*. =This buffer is *not* saved.= \n\n"))

(add-to-list 'auto-mode-alist '("\\.ino\\'" . c-mode))

(setq confirm-kill-emacs nil)

(use-package! vterm-toggle
  :after vterm
  :config
  (setq vterm-toggle-fullscreen-p nil)
  (add-to-list 'display-buffer-alist
               '((lambda (buffer-or-name _)
                     (let ((buffer (get-buffer buffer-or-name)))
                       (with-current-buffer buffer
                         (or (equal major-mode 'vterm-mode)
                             (string-prefix-p vterm-buffer-name (buffer-name buffer))))))
                  (display-buffer-reuse-window display-buffer-at-bottom)
                  ;;(display-buffer-reuse-window display-buffer-in-direction)
                  ;;display-buffer-in-direction/direction/dedicated is added in emacs27
                  ;;(direction . bottom)
                  ;;(dedicated . t) ;dedicated is supported in emacs27
                  (reusable-frames . visible)
                  (window-height . 0.5))))

(use-package! gptel
 :config
; (setq! gptel-api-key "write out api key here")) ; alternatively the api key can be added here
(with-temp-buffer
  (insert-file-contents "~/Stack/Code/OpenAI/api_key")
  (setq! gptel-api-key (string-trim (buffer-string)))))

(map! :leader
    (:prefix ("b") ;; default Doom keybinding. Another option is the build in =Spc b B=
        :desc "Open a buffer"                    "o" #'ivy-switch-buffer)
    (:prefix ("d" . "Prutserdt Bindings")
        :desc "Vterm toggle"                   "SPC" #'vterm-toggle
;;      :desc "r;r;k run"                        "d" #'vterm-toggle "r;r;k"
        :desc "r;r;k run"                        "d" #'(async-shell-command "r")
        (:prefix ("a" . "Arduino IDE")
            :desc "ESP32 PWRSTRK testing upload" "t" #'PowerStrike-testing-upload
            :desc "ESP32 PWRSTRK upload"         "p" #'PowerStrike-upload
            :desc "ESP32 serial"                 "s" #'serial-ttyUSB0-115200)
        :desc "Reload Doom: doom/reload"             "r" #'doom/reload
        :desc "Tangling: org-babel-tangle"           "t" #'org-babel-tangle
        :desc "Plak keuze uit kill ring"             "p" #'consult-yank-from-kill-ring
        :desc "Write this buffer to file"            "w" #'write-file)
    (:prefix ("r" . "org-roam") ;; similar to Doom default, SPC n r. Slightly shorter as: SPC r
        :desc "Open random node"                 "a" #'org-roam-node-random
        :desc "Open new daily"                   "d" #'org-roam-dailies-capture-today
        (:prefix ("D" . "dailies")
            :desc "Find daily dir"               "-" #'org-roam-find-directory
            :desc "Goto previous note"           "b" #'org-roam-dailies-goto-previous-note
            :desc "Goto date"                    "d" #'org-roam-dailies-goto-date
            :desc "Capture date"                 "D" #'org-roam-dailies-capture-date
            :desc "Goto next note"               "f" #'org-roam-dailies-goto-next-note
            :desc "Goto tomorrow"                "m" #'org-roam-dailies-goto-tomorrow
            :desc "Capture tomorrow"             "M" #'org-roam-dailies-capture-tomorrow
            :desc "Goto today"                   "t" #'org-roam-dailies-goto-today
            :desc "Capture today"                "T" #'org-roam-dailies-capture-today
            :desc "Goto yesterday"               "y" #'org-roam-dailies-goto-yesterday
            :desc "Capture yesterday"            "Y" #'org-roam-dailies-capture-yesterday)
        :desc "Find node"                        "f" #'org-roam-node-find
        :desc "Find ref"                         "F" #'org-roam-ref-find
        :desc "Show graph"                       "g" #'org-roam-graph
        :desc "Insert node"                      "i" #'org-roam-node-insert
        :desc "Capture to node"                  "n" #'org-roam-capture
        :desc "Select dailies calendar"          "o" #'org-roam-dailies-goto-date
        :desc "Toggle roam buffer"               "r" #'org-roam-buffer-toggle
        :desc "Launch roam buffer"               "R" #'org-roam-buffer-display-dedicated
        :desc "Search directory"                 "s" #'counsel-rg ;;NOTE: this is not the right place!
;;        :desc "Search directory"                 "s" #'counsel-rg ;;NOTE: this is not the right place!
        :desc "Goto today"                       "t" #'org-roam-dailies-goto-today
        :desc "Sync database"                    "S" #'org-roam-db-sync
        :desc "UI in browser"                    "u" #'org-roam-ui-mode)
    (:prefix ("s") ;; Default Doom keybinding
        (:prefix ("c" . "ChatGPT options")
            :desc "ChatGPT"                      "c" #'gptel
            :desc "send"                         "s" #'gptel-send
            :desc "rewrite"                      "r" #'gptel-rewrite-menu
            :desc "menu"                         "m" #'gptel-menu)))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((sql . t)))

(setq org-superstar-headline-bullets-list '("◉" "○" "✿" "✸" "⁖" ))

(custom-set-faces
  '(org-level-1 ((t (:inherit outline-1 :height 1.5))))
  '(org-level-2 ((t (:inherit outline-2 :height 1.4))))
  '(org-level-3 ((t (:inherit outline-3 :height 1.3))))
  '(org-level-4 ((t (:inherit outline-4 :height 1.2))))
  '(org-level-5 ((t (:inherit outline-5 :height 1.1)))))

(setq org-hide-emphasis-markers t)

(use-package org-auto-tangle
  :load-path "site-lisp/org-auto-tangle/"    ;; this line is necessary only if you cloned the repo in your site-lisp directory
  :defer t
  :hook (org-mode . org-auto-tangle-mode))

(setq org-agenda-files
;;      '("~/Stack/Command_line/RoamNotes/daily"))
;;      '("~/Stack/Command_line/RoamNotes"))
      '("~/Stack/Code/Emacs/Tasks.org"))

(use-package org-roam
    :custom
 ;(org-roam-directory "~/Shared_directory/RoamNotes")    ; directory on Virtualbox Arch image
    (org-roam-directory "~/Stack/Command_line/RoamNotes")  ; directory on Arch linux
    (org-roam-dailies-directory "daily/")                  ; the subdir for dailies in roam-dir
    (org-roam-completion-everywhere t)
    :config
    (org-roam-db-autosync-enable))

(setq org-roam-dailies-capture-templates
    (let ((head
           (concat "#+title: %<%Y-%m-%d (%A)>\n#+startup: showall\n"
                    "* Aantekeningen van vandaag\n\n* TODO(s) van vandaag [/]\n")))
         `(("a" "Aantekeningen van vandaag" entry
;;         "* %<%H:%M> %?"
           "* %<%H:%M> %?"
           :if-new (file+head+olp "%<%Y-%m-%d>.org" ,head ("Aantekeningen van vandaag")))
          ("t" "TODO(s) van vandaag" item
           "[ ] %?"
           :if-new (file+head+olp "%<%Y-%m-%d>.org" ,head ("TODO(s) van vandaag"))))))

(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
    :after org-roam ;; or :after org
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))

(defun PowerStrike-testing-upload ()
    (interactive)
    (async-shell-command "arduino --board esp32:esp32:esp32 --port /dev/ttyUSB0 --upload ~/Stack/Code/git/PowerStrike_code/testing/testing.ino")
    (doom/window-maximize-buffer)
    (split-window-horizontally)
    (switch-to-buffer "*Async Shell Command*")
    (windmove-right))

(defun serial-ttyUSB0-115200 ()
    (interactive)
    (split-window-horizontally)
    (serial-term "/dev/ttyUSB0" 115200)
;;(switch-to-buffer "/dev/ttyUSB0")
    (windmove-right))
