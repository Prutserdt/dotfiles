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

(setq! evil-want-Y-yank-to-eol nil)

(after! evil
  (define-key evil-normal-state-map "U" 'undo-redo))

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
                  (reusable-frames . visible)
                  (window-height . 0.5))))

(use-package! gptel
 :config
;; (setq! gptel-api-key "write out api key here")) ; alternatively the api key can be added here
(with-temp-buffer
  (insert-file-contents "~/Stack/Code/OpenAI/api_key")
  (setq! gptel-api-key (string-trim (buffer-string)))))

(map! :leader
    (:prefix ("d" . "Prutserdt Bindings")
        :desc "Vterm toggle"                   "SPC" #'vterm-toggle
        (:prefix ("a" . "Arduino IDE")
            :desc "ESP32 PWRSTRK upload"         "p" #'my-PowerStrike-upload
            :desc "README.org, het epistel"      "r" #'my-PowerStrike-README-org-file
            :desc "ESP32 serial"                 "s" #'my-serial-ttyUSB0-115200
            :desc "ESP32 PWRSTRK testing upload" "t" #'my-PowerStrike-testing-upload)
        (:prefix ("c" . "Cloud stuff")
            (:prefix ("b" . "Backup to cloud")
            :desc "Thinkpad backup to cloud"     "t" #'doom/tangle
            :desc "VBox Arch backup to cloud"    "v" #'doom/tangle))
        :desc "redox kb reset xmod"              "d" #'my-keyboard-reset
        (:prefix ("f" . "Financial stuff")
            :desc "Show my capital"              "c" #'my-asset-allocation-in-time)
        :desc "Reload Doom: doom/reload"         "r" #'doom/reload
        :desc "Tangling: org-babel-tangle"       "t" #'org-babel-tangle
        :desc "Plak keuze uit kill ring"         "p" #'consult-yank-from-kill-ring
        :desc "Write this buffer to file"        "w" #'write-file)
    (:desc "Open my Emacs config" :ng "e" (cmd! (find-file (expand-file-name "README.org" doom-user-dir))))
    (:prefix ("r" . "org-roam") ;; similar to Doom default, SPC n r. Slightly shorter as: SPC r
        :desc "Open random node"                 "a" #'org-roam-node-random
        (:prefix ("c" . "Change to anoter notes dir")
            :desc "Goto default notes"           "d" #'my-org-roam-default
            :desc "Goto Thinkpad notes"          "t" #'my-org-roam-thinkpad
            :desc "Goto work notes @ home"       "w" #'my-org-roam-work
            :desc "Goto work notes @ work"       "W" #'my-org-roam-at-work-about-work)
        (:prefix ("d" . "dailies")
            :desc "Find daily dir"               "-" #'org-roam-find-directory
            :desc "Goto previous note"           "b" #'org-roam-dailies-goto-previous-note
            :desc "Open new daily"               "d" #'org-roam-dailies-capture-today
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
        :desc "Message: show roam dir info"      "m" #'my-show-org-roam-directory-info
        :desc "Capture to node"                  "n" #'org-roam-capture
        :desc "Select dailies calendar"          "o" #'org-roam-dailies-goto-date
        :desc "Toggle roam buffer"               "r" #'org-roam-buffer-toggle
        :desc "Launch roam buffer"               "R" #'org-roam-buffer-display-dedicated
        :desc "Search Roam dir"                  "s" #'my-counsel-rg-roam-dir
        :desc "Sync database"                    "S" #'org-roam-db-sync
        :desc "UI in browser"                    "u" #'org-roam-ui-mode)
    (:prefix ("s") ;; Default Doom keybinding
        (:prefix ("c" . "ChatGPT options")
            :desc "ChatGPT"                      "c" #'gptel
        ;;    :desc "chat with personal notes"     "k" #'khoj
            :desc "menu"                         "m" #'gptel-menu
            :desc "rewrite"                      "r" #'gptel-rewrite-menu
            :desc "send"                         "s" #'gptel-send)))

(global-set-key (kbd "<escape>")      'keyboard-escape-quit)

;;(org-babel-do-load-languages
;; 'org-babel-load-languages
;; '((sql . t)))

(setq org-superstar-headline-bullets-list '("◉" "○" "✿" "✸" "⁖" ))

(custom-set-faces
  '(org-level-1 ((t (:inherit outline-1 :height 1.5))))
  '(org-level-2 ((t (:inherit outline-2 :height 1.4))))
  '(org-level-3 ((t (:inherit outline-3 :height 1.3))))
  '(org-level-4 ((t (:inherit outline-4 :height 1.2))))
  '(org-level-5 ((t (:inherit outline-5 :height 1.1))))
  '(org-document-title ((t (:inherit org-level-1 :height 1.6)))))

(setq org-hide-emphasis-markers t)

(setq org-ellipsis "⚡⚡⚡") ;; alternatives: ⤵↖↩ ⤵)⥆,⬎ ↴, ⬎,↻ ⤷

(use-package org-auto-tangle
  :load-path "site-lisp/org-auto-tangle/"    ;; this line is necessary only if you cloned the repo in your site-lisp directory
  :defer t
  :hook (org-mode . org-auto-tangle-mode))

(setq org-agenda-files
;;  '("~/Shared_directory/RoamNotes/daily"))   ;; Virtual machine Arch dir
    '("~/Stack/Command_line/RoamNotes/daily")) ;; default location

(use-package org-roam
    :custom
    (org-roam-directory "~/Stack/Command_line/RoamNotes")  ;; desktop normal location
;;  (org-roam-directory "~/Shared_directory/RoamNotes")    ;; Virtual machine Arch dir
    (org-roam-dailies-directory "daily/")                  ;; the subdir for dailies in roam-dir
    (org-roam-completion-everywhere t)
    :config
    (org-roam-db-autosync-enable))

(setq org-roam-dailies-capture-templates
    (let ((head
           (concat "#+title: %<%Y-%m-%d (%A)>\n#+startup: showall\n"
                    "* Aantekeningen van vandaag\n\n* TODO van vandaag [/]\n")))
         `(("a" "Aantekeningen van vandaag" entry
           "* %<%H:%M> %?"
           :if-new (file+head+olp "%<%Y-%m-%d>.org" ,head ("Aantekeningen van vandaag")))
          ("t" "TODO van vandaag" item
           "[ ] %?"
           :if-new (file+head+olp "%<%Y-%m-%d>.org" ,head ("TODO van vandaag"))))))

(defun my-counsel-rg-roam-dir ()
    "Search using `counsel-rg` in the set org-roam-directory"
    (interactive)
    (counsel-rg nil org-roam-directory))

(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
    :after org-roam ;; or :after org
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))

(defun my-PowerStrike-testing-upload ()
    "Upload arduino Powerstrike code to ESP32"
    (interactive)
    (async-shell-command "arduino --board esp32:esp32:esp32 --port /dev/ttyUSB0 --upload ~/Stack/Code/git/PowerStrike_code/testing/testing.ino")
    (doom/window-maximize-buffer)
    (split-window-horizontally)
    (switch-to-buffer "*Async Shell Command*")
    (windmove-right))

(defun my-serial-ttyUSB0-115200 ()
   "Serial monitor to ttyUSB0 115200 baudrate"
    (interactive)
    (split-window-horizontally)
    (serial-term "/dev/ttyUSB0" 115200)
    (switch-to-buffer "/dev/ttyUSB0")
    (windmove-right))

(defun my-PowerStrike-README-org-file ()
  "Open the README.org of my PowerStrike ESP32 project"
  (interactive)
  (find-file (expand-file-name "README.org" "~/Stack/Code/git/PowerStrike_code")))

(defun my-keyboard-reset ()
  "Change Esc/caps, right mod, right alt, for my redox keyboard."
  (interactive)
  (shell-command "xmodmap $HOME/.config/rdxswitch && xmodmap $HOME/.config/rdxswitch && xmodmap $HOME/.config/kbswitch && xset r rate 300 80 && notify-send -t 6000 'The keyboard was reset by Emacs'"))
;;(shell-command (xmodmap $HOME/.config/rdxswitch && xset r rate 300 80))

(defun my-thunar-cloud-connection ()
  "Connect my cloud to Thunar filebrowser."
  (interactive)
  (with-temp-buffer
  (insert-file-contents "~/Stack/Command_line/myThunarCloud")
  (shell-command (string-trim (buffer-string)))))

(defun my-asset-allocation-in-time ()
  "Show my asset allocation vs time in a chart"
  (interactive)
  (let ((script-path "~/Stack/Documenten/Aandelen/Plotten_AA_in_de_tijd.py"))
    (setq default-directory (file-name-directory script-path))
    (shell-command (concat "notify-send -t 6000 'Displaying my AA plot: " script-path "'"))
    (shell-command (concat "python3 " script-path)
                   "*Python Output*")
    (message (concat "Python script executed: " script-path))))

(defun my-org-roam-switch (roam-dir)
  "Switch to the roam notes in the specified directory"
  (interactive "DSet Roam Directory:")
  (if (string= org-roam-directory roam-dir)
      (message (format "Roam directory not changed because it is already set to '%s'" roam-dir))
    (progn
      (setq org-roam-directory roam-dir)
      (setq org-roam-dailies-directory "daily/")
      (org-roam-db-sync)
      (message (format "Switched to %s" roam-dir))
      (my-show-org-roam-directory-info))))

(defun my-org-roam-default ()
  "Switch to my default desktop roam notes"
  (interactive)
  (my-org-roam-switch "~/Stack/Command_line/RoamNotes"))

(defun my-org-roam-thinkpad ()
  "Switch to the roam notes of my Thinkpad, on my desktop"
  (interactive)
  (my-org-roam-switch "~/Stack/Thinkpad/RoamNotes"))

(defun my-org-roam-work ()
  "Switch to the roam notes of my work (not at work)"
  (interactive)
  (my-org-roam-switch "~/Stack/VBox_Arch/RoamNotes"))

(defun my-org-roam-at-work-about-work ()
  "Switch to the work roam notes on VirtualBox (at work)"
  (interactive)
  (my-org-roam-switch "~/Shared_directory/RoamNotes"))

(defun my-show-org-roam-directory-info ()
  "Show information about the current org-roam directory and its 'daily' subdirectory."
  (interactive)
  (let* ((roam-dir org-roam-directory)
         (daily-dir (expand-file-name "daily" roam-dir))
         (all-files-roam (directory-files roam-dir nil))
         (org-files-roam (cl-remove-if-not #'(lambda (file) (string-match-p "\\.org$" file)) all-files-roam))
         (non-org-files-roam (cl-remove-if #'(lambda (file) (string-match-p "\\.org$" file)) all-files-roam))
         (all-files-daily (directory-files daily-dir nil))
         (org-files-daily (cl-remove-if-not #'(lambda (file) (string-match-p "\\.org$" file)) all-files-daily))
         (non-org-files-daily (cl-remove-if #'(lambda (file) (string-match-p "\\.org$" file)) all-files-daily))
         (org-file-count-roam (length org-files-roam))
         (org-file-count-daily (length org-files-daily))
         (org-file-count-total (+ org-file-count-roam org-file-count-daily))
         (total-lines-org 0)
         (total-words-org 0)
         (total-lines-daily 0)
         (total-words-daily 0))

    ;; Calculate lines and words for org files in the 'daily' directory
    (dolist (file (directory-files daily-dir nil "\\.org$"))
      (with-temp-buffer
        (insert-file-contents (expand-file-name file daily-dir))
        (setq total-lines-daily (+ total-lines-daily (count-lines (point-min) (point-max))))
        (setq total-words-daily (+ total-words-daily (count-words (point-min) (point-max))))))

    ;; Calculate lines and words for org files in the main directory
    (dolist (file org-files-roam)
      (with-temp-buffer
        (insert-file-contents (expand-file-name file roam-dir))
        (setq total-lines-org (+ total-lines-org (count-lines (point-min) (point-max))))
        (setq total-words-org (+ total-words-org (count-words (point-min) (point-max))))))
    (message "Statistics about my second brain 🤓
Brain shelve: %s.

             Roam dir, daily dir, total
org files    %d, %d, %d
line numbers %d, %d, %d
word count   %d, %d, %d"
             roam-dir
             org-file-count-roam org-file-count-daily org-file-count-total
             total-lines-org total-lines-daily (+ total-lines-org total-lines-daily)
             total-words-org total-words-daily (+ total-words-org total-words-daily))))

(defun my-elisp-mode-eval-buffer ()
  (interactive)
  (message "Evaluated buffer")
  (eval-buffer))

(define-key emacs-lisp-mode-map (kbd "C-c C-c") #'mp-elisp-mode-eval-buffer)
(define-key lisp-interaction-mode-map (kbd "C-c C-c") #'mp-elisp-mode-eval-buffer)

(defun my-redox-directory ()
  "Open the keymap.c of my Redox qmk firmware"
  (interactive)
  (find-file (expand-file-name "" "~/qmk_firmware/keyboards/redox/keymaps/Prutserdt")))

(defun my-redox-config-qmk-file ()
  "Open the keymap.c of my Redox qmk firmware"
  (interactive)
  (find-file (expand-file-name "keymap.c" "~/qmk_firmware/keyboards/redox/keymaps/Prutserdt")))

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
