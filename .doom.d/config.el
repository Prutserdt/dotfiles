;; NOTE: This file is generated from ~/.doom.d/README.org
;;      Please only edit that file and org-babel-tangle (emacs)

(setq doom-theme 'doom-tokyo-night)

(setq fancy-splash-image "~/.doom.d/doom-emacs.png")
(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)
(add-hook! '+doom-dashboard-functions :append
    (insert "\n" (+doom-dashboard--center +doom-dashboard--width "A melodramatic vimmer spirals into despair before he succumbs to the dark side: this config.")))

(beacon-mode 1)
(setq beacon-blink-duration 3)

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

(setq! evil-want-Y-yank-to-eol nil)

(setq evil-normal-state-cursor '(box "tomato")
      evil-insert-state-cursor '(bar "white")
      evil-visual-state-cursor '(hollow "orange"))

(setq evil-goggles-duration 1.0)

(add-to-list 'auto-mode-alist '("\\.ino\\'" . c-mode))

(setq confirm-kill-emacs nil)

(use-package! gptel
 :config
; (setq! gptel-api-key "write out api key here")) ; alternatively the api key can be added here
(with-temp-buffer
  (insert-file-contents "~/Stack/Code/OpenAI/api_key")
  (setq! gptel-api-key (string-trim (buffer-string)))))

(map! :leader
;;    (:prefix ("b") ;; default Doom keybinding
;;        :desc "Open a buffer"                    "o" #'buffer-menu)
    (:prefix ("d" . "Prutserdt Bindings")
        (:prefix ("a" . "Aduino IDE")
            :desc "ESP32 PWRSTRK testing upload" "t" #'PowerStrike-testing-upload
            :desc "ESP32 PWRSTRK upload"         "p" #'PowerStrike-upload
            :desc "ESP32 serial"                 "s" #'serial-ttyUSB0-115200)
    :desc "Reload Doom: doom/reload"             "r" #'doom/reload
    :desc "Tangling: org-babel-tangle"           "t" #'org-babel-tangle
    :desc "Plak keuze uit kill ring"             "p" #'consult-yank-from-kill-ring
    :desc "Write this buffer to file"            "w" #'write-file)
;; Remove since SPC f r is the default doom keybinding to find a recent file...
;;    (:prefix ("o") ;; default Doom keybinding
;;        :desc "Open recent files"                "o" #'counsel-recentf)
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
        :desc "Toggle roam buffer"               "r" #'org-roam-buffer-toggle
        :desc "Launch roam buffer"               "R" #'org-roam-buffer-display-dedicated
        :desc "Search directory"                 "s" #'counsel-rg ;;NOTE: this is not the right place!
        :desc "Sync database"                    "S" #'org-roam-db-sync
        :desc "UI in browser"                    "u" #'org-roam-ui-mode)
    (:prefix ("s") ;; Default Doom keybinding
        (:prefix ("c" . "ChatGPT options")
            :desc "ChatGPT"                      "c" #'gptel
            :desc "send"                         "s" #'gptel-send
            :desc "rewrite"                      "r" #'gptel-rewrite-menu
            :desc "menu"                         "m" #'gptel-menu)))

(use-package org-roam
;;  :ensure t
;;  :init
;;  (setq org-roam-v2-ack t)
    :custom
 ;(org-roam-directory "~/Shared_directory/RoamNotes")    ; directory on Virtualbox Arch image
    (org-roam-directory "~/Stack/Command_line/RoamNotes")  ; directory on Arch linux
    (org-roam-dailies-directory "daily/")                  ; the subdir for dailies in roam-dir
    (org-roam-completion-everywhere t)
    :config
    (org-roam-setup))

(setq org-roam-capture-templates
    '(("d" "default" plain
       "%?"
       :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
       :unnarrowed t)
      ("t" "todo notes" plain
       "\n* TODO list [0/2]\n- [ ] %?\n- [ ] "
       :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
       :unnarrowed t)))

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
