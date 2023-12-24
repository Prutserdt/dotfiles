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

(defun set-line-number-color-according-to-evil-state ()
  (when (and evil-mode (not buffer-read-only))
    (set-face-foreground 'line-number
                         (cond ((evil-insert-state-p) "#FFAD99")
                               ((evil-visual-state-p) "#B978C4")
                               (t "#4C6985")))))

(add-hook 'doom-switch-buffer-hook 'set-line-number-color-according-to-evil-state)
(add-hook 'doom-first-buffer-hook 'set-line-number-color-according-to-evil-state)
(add-hook 'evil-insert-state-entry-hook 'set-line-number-color-according-to-evil-state)
(add-hook 'evil-normal-state-entry-hook 'set-line-number-color-according-to-evil-state)
(add-hook 'evil-visual-state-entry-hook 'set-line-number-color-according-to-evil-state)

(custom-set-faces!
  '(line-number-current-line :foreground "#EF7168"))

(scroll-bar-mode -1)

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
                  (reusable-frames . visible)
                  (window-height . 0.5))))

(use-package! gptel
 :config
(with-temp-buffer
  (insert-file-contents "~/Stack/Code/OpenAI/api_key")
  (setq! gptel-api-key (string-trim (buffer-string)))))
(setq gpt-openai-engine "gpt-4-1106-preview") ;; "gpt-4"does not work yet

(after! evil
  (define-key evil-normal-state-map "U" 'undo-redo)
  (define-key evil-normal-state-map "]" 'next-buffer)
  (define-key evil-normal-state-map "[" 'previous-buffer))

(map! :leader
      :desc "Scratch buffer" "[" #'(lambda () (interactive) (switch-to-buffer "*scratch*"))
    (:prefix ("c") ;; Default Doom keybinding,
        (:prefix ("h" . "ChatGPT, GPTel options")
            :desc "ChatGPT of selected region"   "a" #'gptel-send
            :desc "Open ChatGPT in new buffer"   "A" #'gptel
            :desc "gptel-menu"                   "m" #'gptel-menu
            :desc "API for LLM interaction"      "R" #'gptel-request
            :desc "gptel-rewrite-menu"           "r" #'gptel-rewrite-menu))
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
        :desc "Plak keuze uit kill ring"         "p" #'counsel-yank-pop
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
        :desc "Goto today"                       "t" #'org-roam-dailies-goto-today
        :desc "Capture today"                    "T" #'org-roam-dailies-capture-today
        :desc "UI in browser"                    "u" #'org-roam-ui-mode))

(global-set-key (kbd "<escape>")      'keyboard-escape-quit)

(global-set-key (kbd "M-T") (lambda () (interactive) (transpose-words -1)))

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
    "Search using `counsel-rg` in the set org-roam-directory."
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

(defun my-org-roam-switch (roam-dir)
  "Switch to the roam notes in the specified directory. This function is not intended to be used separately, although this is possible. It is used by other Elisp code which will inject the desired Roam directory."
  (interactive "DSet Roam Directory:")
  (if (string= org-roam-directory roam-dir)
      (message (format "Roam directory not changed because it is already set to '%s'" roam-dir))
    (progn
      (setq org-roam-directory roam-dir)
      (setq org-roam-dailies-directory "daily/")
      (org-roam-db-sync)
      (message (format "Switched to %s" roam-dir)))))

(defun my-org-roam-default ()
  "Switch to my default desktop roam notes. This uses the Elisp function my-org-roam-switch."
  (interactive)
  (my-org-roam-switch "~/Stack/Command_line/RoamNotes"))

(defun my-org-roam-thinkpad ()
  "Switch to the roam notes of my Thinkpad, on my desktop. This uses the Elisp function my-org-roam-switch."
  (interactive)
  (my-org-roam-switch "~/Stack/Thinkpad/RoamNotes"))

(defun my-org-roam-work ()
  "Switch to the roam notes of my work (not at work). This uses the Elisp function my-org-roam-switch."
  (interactive)
  (my-org-roam-switch "~/Stack/VBox_Arch/RoamNotes"))

(defun my-org-roam-at-work-about-work ()
  "Switch to the work roam notes on VirtualBox (at work). This uses the Elisp function my-org-roam-switch."
  (interactive)
  (my-org-roam-switch "~/Shared_directory/RoamNotes"))

(defun my-show-org-roam-directory-info ()
  "Show information about the current org-roam directory and its 'daily' subdirectory. Files are counted, number of lines and words as well."
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

(defvar data-bits nil
  "Number of data bits for the serial monitor")

(defvar my-serial-current-index 0
  "Current index of the baudrate in the list")

(defvar my-serial-baudrates '(300 600 1200 2400 4800 9600 19200 38400 57600 115200 230400 460800 57600 921600 1000000 2000000 3000000)
  "List of baudrates to cycle through")

(defvar my-serial-process nil
  "Serial process")

(defun my-serial-next-baudrate ()
  "Switch to the next baudrate in the list"
  (interactive)
  (when my-serial-process
    (delete-process my-serial-process))
  (setq my-serial-current-index (mod (1+ my-serial-current-index)
                                     (length my-serial-baudrates)))
  (let* ((baudrate (nth my-serial-current-index my-serial-baudrates))
         (command (concat "screen /dev/ttyUSB0 " (number-to-string baudrate))))
    (setq my-serial-process (start-process "serial-terminal" nil shell-file-name "-c" command))
    (message "Switched to baudrate: %s" baudrate)))

(defun my-serial-ttyUSB0 (data-bits)
  "Serial monitor to ttyUSB0 using baudrates in a cycle with specified data bits"
  (interactive "sEnter 7 or 8 for data bits: ")
  (when (not (or (string= data-bits "7") (string= data-bits "8")))
    (error "Invalid data bits specified. Please enter 7 or 8."))
  (split-window-horizontally)
  (my-serial-next-baudrate)
  (switch-to-buffer "/dev/ttyUSB0")
  (windmove-right)
  (setq my-serial-process-filter
        (lambda (proc str)
          (process-send-string proc (concat "sb " data-bits "\n"))))
  (set-process-filter my-serial-process my-serial-process-filter)
  (process-send-string my-serial-process (concat "sb " data-bits "\n")))

(global-set-key (kbd "C-c C-g") 'my-serial-next-baudrate)
(global-set-key (kbd "C-c C-m") 'my-serial-ttyUSB0)

(defun my-PowerStrike-testing-upload ()
    "Upload arduino Powerstrike code to ESP32. Opens an async shell command and runs arduino code on ESP32 and port ttyUSB0. The windows are manipulated to be a kind of an IDE."
    (interactive)
    (async-shell-command "arduino --board esp32:esp32:esp32 --port /dev/ttyUSB0 --upload ~/Stack/Code/git/PowerStrike_code/testing/testing.ino")
    (doom/window-maximize-buffer)
    (split-window-horizontally)
    (switch-to-buffer "*Async Shell Command*")
    (windmove-right))

(defun my-serial-ttyUSB0-115200 ()
   "Serial monitor to ttyUSB0 115200 baudrate is shown in a split window to the left."
    (interactive)
    (split-window-horizontally)
    (serial-term "/dev/ttyUSB0" 115200)
    (switch-to-buffer "/dev/ttyUSB0")
    (windmove-right))

(defun my-PowerStrike-README-org-file ()
  "Open the README.org of my PowerStrike ESP32 project."
  (interactive)
  (find-file (expand-file-name "README.org" "~/Stack/Code/git/PowerStrike_code")))

(defun my-keyboard-reset ()
  "Change Esc/caps, right mod, right alt, for my redox keyboard."
  (interactive)
  (shell-command "xmodmap $HOME/.config/rdxswitch && xmodmap $HOME/.config/rdxswitch && xmodmap $HOME/.config/kbswitch && xset r rate 300 80 && notify-send -t 6000 'The keyboard was reset by Emacs'"))

(defun my-thunar-cloud-connection ()
  "Connect my cloud to Thunar filebrowser."
  (interactive)
  (with-temp-buffer
  (insert-file-contents "~/Stack/Command_line/myThunarCloud")
  (shell-command (string-trim (buffer-string)))))

(defun my-asset-allocation-in-time ()
  "Show my asset allocation vs time in a chart. Done by running a Python script."
  (interactive)
  (let ((script-path "~/Stack/Documenten/Aandelen/Plotten_AA_in_de_tijd.py"))
    (setq default-directory (file-name-directory script-path))
    (shell-command (concat "notify-send -t 6000 'Displaying my AA plot: " script-path "'"))
    (shell-command (concat "python3 " script-path)
                   "*Python Output*")
    (message (concat "Python script executed: " script-path))))

(defun my-redox-directory ()
  "Open the keymap.c file of my Redox qmk firmware."
  (interactive)
  (find-file (expand-file-name "" "~/qmk_firmware/keyboards/redox/keymaps/Prutserdt")))

(defun my-redox-config-qmk-file ()
  "Open the keymap.c file of my Redox qmk firmware."
  (interactive)
  (find-file (expand-file-name "keymap.c" "~/qmk_firmware/keyboards/redox/keymaps/Prutserdt")))

;;(setq fancy-splash-image "~/.doom.d/doom-emacs.png")
(setq fancy-splash-image (if (zerop (random 2))
                           "~/.doom.d/doom-emacs.png"
                           "~/.doom.d/doom-emacs-stallman.png"))
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
