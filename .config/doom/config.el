;; NOTE: This file is generated from ~/.config/doom/README.org
;;      Please only edit that file and org-babel-tangle (emacs)

;;(with-eval-after-load 'eglot
;;  (add-to-list 'eglot-server-programs
;;               '(text-mode . ("harper-ls" "--stdio"))))

(setq doom-theme 'doom-tokyo-night)

(use-package rainbow-delimiters)

(set-face-attribute 'default nil :height 130)
(setq default-frame-alist '((font . "Hack 13")))

(define-globalized-minor-mode my-global-hl-todo-mode hl-todo-mode
    (lambda () (hl-todo-mode 1)))
(my-global-hl-todo-mode 1)

(setq-default fill-column 110)
(global-display-fill-column-indicator-mode)
(setq-default visual-fill-column-center-text t)
(add-hook 'visual-line-mode-hook 'visual-fill-column-mode)

(defun my-prog-mode-hook ()
  (setq-local fill-column 140)
  (toggle-truncate-lines 0)
  (visual-fill-column-mode))

(add-hook 'prog-mode-hook 'my-prog-mode-hook)

(add-hook 'vterm-mode-hook
          (lambda ()
            (setq-local fill-column 110)
            (visual-fill-column-mode)
            (setq-local visual-fill-column-center-text t)))

(set-frame-parameter (selected-frame) 'alpha '(85 80))
(add-to-list 'default-frame-alist '(alpha 85 80))

(global-display-line-numbers-mode)
(setq display-line-numbers-type 'relative)

(defvar my-color-visual-state    "#765825") ;; dark yellow brown
(defvar my-color-insert-state    "#3e6752") ;; pale grey green
(defvar my-color-grey-green      "#505753") ;; grey green
(defvar my-color-normal-state    "#453a39") ;; brown terra
(defvar my-color-current-line    "#EF7168") ;; orange red

(defun my-line-number-color-according-to-evil-state ()
  (when (and evil-mode (not buffer-read-only))
    (let ((font-weight (if (or (evil-insert-state-p) (evil-visual-state-p))
                          'bold
                        'normal))
          (line-number-color (if (string= (buffer-name) "scratch.org")
                                my-color-current-line
                              (cond ((evil-insert-state-p) my-color-insert-state)
                                    ((evil-visual-state-p) my-color-visual-state)
                                    (t my-color-normal-state))))
          (line-number-current-line-color (if (string= (buffer-name) "scratch.org")
                                           my-color-insert-state
                                           my-color-current-line)))
      (set-face-foreground 'line-number line-number-color)
      (set-face-foreground 'line-number-current-line line-number-current-line-color)
      (set-face-attribute 'line-number nil :weight font-weight))))

(dolist (hook '(doom-switch-buffer-hook
                doom-first-buffer-hook
                evil-insert-state-entry-hook
                evil-normal-state-entry-hook
                evil-visual-state-entry-hook))
  (add-hook hook 'my-line-number-color-according-to-evil-state))

(custom-set-faces!
  '(line-number-current-line :foreground "#EF7168"))

(scroll-bar-mode -1)

(defun my-beach-or-dark-theme-switch ()
  "Switch between my-beach-theme and my-dark-theme."
  (interactive)
  (if (eq (car custom-enabled-themes) 'doom-tokyo-night)
      (progn
        (load-theme 'leuven t)
        (set-frame-parameter (selected-frame) 'alpha '(100 100))
        (message "Theme switched for beach settings; in bright light conditions."))
    (progn
      (load-theme 'doom-tokyo-night t)
      (set-frame-parameter (selected-frame) 'alpha '(85 80))
      (message "Theme switched to my dark theme."))))

(defun my-transparency-toggle ()
  "Switch transparency back and forth."
  (interactive)

  (if (equal (frame-parameter (selected-frame) 'alpha) '(100 100))
      (progn
        (set-frame-parameter (selected-frame) 'alpha '(85 80))
        (add-to-list 'default-frame-alist '(alpha 85 80)))
    (set-frame-parameter (selected-frame) 'alpha '(100 100))))

(defvar modeline-hidden nil)

(setq-default mode-line-format (default-value 'mode-line-format))

(defun my-modeline-toggle ()
  "Switch modeline on/off."
  (interactive)

  (if (equal mode-line-format nil)
      (setq mode-line-format (default-value 'mode-line-format))
    (setq mode-line-format nil)))

(defun my-line-numbers-toggle ()
  "Switch line numbers on/off."
  (interactive)

  (if display-line-numbers-mode
      (display-line-numbers-mode 0)
    (display-line-numbers-mode 1)))

(defun my-distractionfree-toggle ()
  "Switch from my normal environment to distraction free and back."
  (interactive)

  (my-line-numbers-toggle)
  (my-modeline-toggle)
  (my-transparency-toggle))

(defun my-column-width-toggle ()
  "Toggle the width of the characters."
  (interactive)

  (if (equal fill-column 110)
      (setq fill-column 140)
    (setq fill-column 110)))

(setq! evil-want-Y-yank-to-eol nil)

(setq evil-normal-state-cursor '(box "tomato")
      evil-insert-state-cursor '(bar "white")
      evil-visual-state-cursor '(hollow "orange"))

(setq evil-goggles-duration 1.0)

(unless (file-exists-p "~/.config/doom/scratch.org")
  (with-temp-file "~/.config/doom/scratch.org"
  (insert "* ❗ An _org-mode_ ~scratch buffer~ /for/ *hacking* ❗\n Just delete this text, this doesn't need to be sticky!")))

(eval-after-load 'org
  '(find-file "~/.config/doom/scratch.org"))

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
           (display-buffer-reuse-window display-buffer-same-window))))

(use-package! gptel
 :config
(with-temp-buffer
  (insert-file-contents "~/Stack/Code/OpenAI/api_key")
  (setq! gptel-api-key (string-trim (buffer-string)))))
(setq gpt-openai-engine "gpt-4")

(defun my-region-select-gptel-send ()
  "Select text at point to the end of buffer and send this to the LLM (gptel-send). The output will be generated at the bottom of the buffer."
  (interactive)
  (beginning-of-line)      ; Save the current point position as the starting point of the selection
  (let ((start (point)))
    (goto-char (point-max)); Move the cursor to the end of the buffer
    (setq my-end (point))  ; Remember the end of the selection
    (goto-char start)      ; Set the mark at the starting point
    (set-mark (point))
    (goto-char my-end)     ; Move the cursor to the end of the buffer and execute 'gptel-send'
    (call-interactively 'gptel-send)
    (deactivate-mark)))    ; Deselect the region

(require 'smartparens)

;; Enable smartparens only in org mode
(sp-local-pair 'org-mode "=" "=" :post-handlers '(:add ("||_" "SPC")))
(sp-local-pair 'org-mode "~" "~" :post-handlers '(:add ("||_" "SPC")))

(defun sp-insert-equal ()
  "Insert '==' and place the cursor in the middle."
  (interactive)
  (insert "==")
  (backward-char 1))

(defun sp-insert-tilde ()
  "Insert '~~' and place the cursor in the middle."
  (interactive)
  (insert "~~")
  (backward-char 1))

;; Bind the functions to the = and ~ keys in org mode
(with-eval-after-load 'smartparens
  (define-key smartparens-mode-map (kbd "=") 'sp-insert-equal)
  (define-key smartparens-mode-map (kbd "~") 'sp-insert-tilde))

(add-hook 'org-mode-hook 'smartparens-mode)

(after! evil
  (define-key evil-normal-state-map "U" 'undo-redo)
  (define-key evil-normal-state-map "]" 'next-buffer)
  (define-key evil-normal-state-map "[" 'previous-buffer))

;FIXME dit is een test voor jump to functionaliteit. Dit al door gi en '' te gebruiken. C-o zou werken met onderstaande command. Nog testen
(evil-add-command-properties #'foo :jump t)

(map! :leader
      :desc "Scratch buffer" "[" (lambda () (interactive) (switch-to-buffer "scratch.org"))

    (:prefix ("b") ;; Default Doom keybinding
         :desc "Switch to another buffer"        "b" #'counsel-switch-buffer)

    (:prefix ("c") ;; Default Doom keybinding
        (:prefix ("h" . "ChatGPT, GPTel options")
            :desc "At point to bottom ChatGPT"   "a" #'my-region-select-gptel-send
            :desc "ChatGPT of selected region"   "A" #'gptel-send
            :desc "Open ChatGPT in new buffer"   "c" #'gptel
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
        :desc "Beach mode/dark mode toggle"      "b" #'my-beach-or-dark-theme-switch
        (:prefix ("d" . "Distraction free")
            :desc "Toggle distraction free"      "d" #'my-distractionfree-toggle
            :desc "Transparency togglee"         "t" #'my-transparency-toggle
            :desc "Modeline toggle"              "m" #'my-modeline-toggle
            :desc "Line numbers toggle"          "l" #'my-line-numbers-toggle
            :desc "Column width toggle"          "c" #'my-column-width-toggle)
        (:prefix ("e" . "Excel table stuff")
            :desc "At point org tbl to exl"      "a" #'my-export-org-table-to-system-clipboard
            :desc "Clipb.: org to exl"           "e" #'my-convert-tabs-to-org-table-in-clipboard
            :desc "Clipb.: exl to org"           "o" #'my-convert-tabs-to-org-table-in-clipboard)
        (:prefix ("f" . "Financial stuff")
            :desc "Show my capital"              "c" #'my-asset-allocation-in-time)
        :desc "Toggle hacking mode"              "h" #'my-toggle-hacking-layout
        :desc "Insert key words"                 "i" #'my-insert-characters-and-text
        :desc "Keyboard reset"                   "k" #'my-keyboard-reset
        :desc "Watch images via org links"       "l" #'my-generate-org-links-to-pictures-subdir
        :desc "Reload Doom: doom/reload"         "r" #'doom/reload
        :desc "Update emacs README.org!!!"       "o" #'my-emacs-config-download-overwrite
        (:prefix ("p" . "pdf helpers")
            :desc "Select pdf to org buffer"     "b" #'my-open-pdf-as-org-text
            :desc "Convert image to pdf"         "i" #'my-image-to-pdf
            :desc "Select pdf ocrtext to org buffer" "o" #'my-open-pdf-to-org-as-text-with-ocr
            :desc "Remove password from pdf"     "z" 'my-pdf-password-removal)
        :desc "Plak keuze uit kill ring"         "P" #'counsel-yank-pop
        :desc "Tangling: org-babel-tangle"       "t" #'org-babel-tangle
        (:prefix ("s" . "SMILES chemistry")
            :desc "Insert image under Smiles"    "i" #'my-obabel-smiles-insert-image
            :desc "Show image in sxiv"           "s" #'my-obabel-smiles-show-image)
        :desc "Visualized undo: vundo"           "v" #'vundo
        :desc "Write this buffer to file"        "w" #'write-file
        :desc "Run python async"                 "z" #'my-run-python-code-in-new-frame-select-manually)

    (:desc "Open files in emacs" "e" #'recentf-open-files)

    (:prefix ("j" . "Jump around");; An addition to the default Doom keybinding (j is not present!)
            :desc "jump backward one step"       "j" #'evil-jump-backward
            :desc "jump forward one step"        "k" #'evil-jump-forward
; FIXME: the jump forward to end does not seem to work yet...
            :desc "jump forward completely"      "K" #'my-evil-jump-forward-to-end
            :desc "jump list"                    "l" #'+ivy/jump-list)

    (:prefix ("r" . "org-roam") ;; Similar to the Doom default, SPC n r, but shorter
        :desc "Open random node"                 "a" #'org-roam-node-random
        (:prefix ("d" . "dailies")
            :desc "Previous daily (from daily)"  "<" #'org-roam-dailies-goto-previous-note
            :desc "Next daily (from daily)"      ">" #'org-roam-dailies-goto-next-note
            :desc "Capture date"                 "D" #'org-roam-dailies-capture-date
            :desc "Goto the last daily"          "l" #'my-open-latest-org-roam-daily
            :desc "Goto tomorrow"                "m" #'org-roam-dailies-goto-tomorrow
            :desc "Capture tomorrow"             "M" #'org-roam-dailies-capture-tomorrow
            :desc "Select dailies calendar"      "o" #'org-roam-dailies-goto-date
           ;:desc "Goto today"                   "t" #'org-roam-dailies-goto-today
            :desc "Goto today, paste previous"   "t" #'my-goto-today-paste-previous-daily
            :desc "Capture today"                "T" #'org-roam-dailies-capture-today
            :desc "Goto yesterday"               "y" #'org-roam-dailies-goto-yesterday
            :desc "Capture yesterday"            "Y" #'org-roam-dailies-capture-yesterday)
        :desc "Database sync"                    "D" #'org-roam-db-sync
        :desc "Find node"                        "f" #'org-roam-node-find
        :desc "Find ref"                         "F" #'org-roam-ref-find
        :desc "Insert node"                      "i" #'org-roam-node-insert
        :desc "Message: show roam dir info"      "m" #'my-org-roam-info
        :desc "Capture to node"                  "n" #'org-roam-capture
        :desc "Toggle roam buffer"               "r" #'org-roam-buffer-toggle
        :desc "Launch roam buffer"               "R" #'org-roam-buffer-display-dedicated
        :desc "Search text"                      "s" #'my-search-roam-files
        :desc "Search filename"                  "S" #'my-search-roam-filename
        :desc "UI in browser"                    "u" #'org-roam-ui-mode))

(global-set-key (kbd "<escape>")      'keyboard-escape-quit)

(global-set-key (kbd "M-T") (lambda () (interactive) (transpose-words -1)))

(defun my-evil-jump-forward-to-end ()
  "Jump right to the most forward evil-jump."
  (interactive)
  (with-temp-buffer
            (+ivy/jump-list)))

(setq org-superstar-headline-bullets-list '("◉" "○" "✿" "✸" "⁖" ))

(custom-set-faces
  '(org-level-1 ((t (:inherit outline-1 :height 1.5))))
  '(org-level-2 ((t (:inherit outline-2 :height 1.4))))
  '(org-level-3 ((t (:inherit outline-3 :height 1.3))))
  '(org-level-4 ((t (:inherit outline-4 :height 1.2))))
  '(org-level-5 ((t (:inherit outline-5 :height 1.1))))
  '(org-document-title ((t (:inherit org-level-1 :height 1.6)))))

(setq org-hide-emphasis-markers t)
;;(setq org-ellipsis "⚡⚡⚡")
(setq org-ellipsis " ▼ ") ; Use a different symbol
(setq org-startup-with-inline-images t)
(setq org-hidden-keywords '(title))

(use-package org-auto-tangle
  :load-path "site-lisp/org-auto-tangle/"
  :defer t
  :hook (org-mode . org-auto-tangle-mode))

(defun my-export-org-table-to-system-clipboard ()
  "Export the org-mode table at point as a CSV file in system memory and copy to clipboard."
  (interactive)
  (let* ((temp-dir "/dev/shm/temp/")
         (file (concat temp-dir "wismij.csv")))
    (unless (file-directory-p temp-dir)
      (make-directory temp-dir t))
    (org-table-export file "orgtbl-to-csv")
    (with-temp-buffer
      (insert-file-contents file)
      (clipboard-kill-region (point-min) (point-max))))
    (my-convert-comma-to-tab-in-clipboard))

(defun my-convert-tabs-to-org-table-in-clipboard ()
  "Convert tabs to org table format in clipboard contents."
  (interactive)
  (with-temp-buffer
    (clipboard-yank)
    (goto-char (point-min))
    (while (search-forward "\t" nil t)
      (replace-match " | "))
    (goto-char (point-min))
    (insert "| ")
    (while (search-forward "\n" nil t)
      (replace-match " |\n| "))
    (goto-char (point-max))
    (insert " |")
    (clipboard-kill-region (point-min) (point-max))))

(defun my-convert-comma-to-tab-in-clipboard ()
  "Convert commas to tabs in clipboard contents."
  (interactive)
  (with-temp-buffer
    (clipboard-yank)
    (goto-char (point-min))
    (while (search-forward "," nil t)
      (replace-match "\t" nil nil))
    (clipboard-kill-region (point-min) (point-max))))

(setq org-roam-dailies-capture-templates
    (let ((head
           (concat "#+title: %<%Y-%m-%d (%A)>\n"
                    "* TODO van vandaag [/]\n")))
         `(("a" "Aantekeningen van vandaag" entry
           "* %<%H:%M> %?"
           :if-new (file+head+olp "%<%Y-%m-%d>.org" ,head (""))))))

(use-package org-roam
  :custom
  (org-roam-directory (if (string-equal system-name "work")
                         "~/Shared_directory/RoamNotes"
                       "~/Stack/Command_line/RoamNotes"))
  (org-roam-dailies-directory "daily/")
  (org-roam-completion-everywhere t)
  :config
  (org-roam-db-autosync-enable))

(defun my-search-roam-files ()
    "Search using `counsel-rg` in the set org-roam-directory."
    (interactive)
    (counsel-rg nil org-roam-directory))

(defun my-search-roam-filename ()
    "Search filenames using `counsel-find-file` in the set org-roam-directory."
    (interactive)
    (counsel-find-file org-roam-directory))

(defun my-org-roam-info ()
  "Show info of current org-roam dir and `daily` subdirectory."
  (interactive)
  (let* ((daily-dir (expand-file-name "daily" org-roam-directory))
         (all-files-roam (directory-files org-roam-directory nil))
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
        (insert-file-contents (expand-file-name file org-roam-directory))
        (setq total-lines-org (+ total-lines-org (count-lines (point-min) (point-max))))
        (setq total-words-org (+ total-words-org (count-words (point-min) (point-max))))))
    (message "Statistics about my second brain 🤓.
Brain shelve: %s.

+------------+--------+--------+-------+
|            | Total  | Roam   | Daily |
+------------+--------+--------+-------+
|org files   |  %5d |  %5d | %5d |
|line numbers|  %5d |  %5d | %5d |
|word count  | %5d | %5d | %5d |
+------------+--------+--------+-------+"
             org-roam-directory
             org-file-count-total org-file-count-roam org-file-count-daily
             (+ total-lines-org total-lines-daily) total-lines-org total-lines-daily
             (+ total-words-org total-words-daily) total-words-org total-words-daily)))

(defun my-open-latest-org-roam-daily ()
  (interactive)
  (setq my-org-roam-dailies-dir (concat org-roam-directory org-roam-dailies-directory))
  (let ((files (directory-files my-org-roam-dailies-dir nil "^[0-9]\\{4\\}-[0-9]\\{2\\}-[0-9]\\{2\\}\\.org$")))
    (when files
      (find-file (expand-file-name (car (last (sort files #'string<))) my-org-roam-dailies-dir)))))

(defun my-goto-today-paste-previous-daily ()
  "Create a new daily containg previous daily note data"
  (interactive)

  ; Go to today's daily note
  (org-roam-dailies-goto-today)

  ; Set the dailies directory
  (setq my-org-roam-dailies-dir (concat org-roam-directory "/" org-roam-dailies-directory))
  ; Get the list of files in the org-roam-dailies directory named YYYY-MM-DD.org
  (let* ((files (directory-files my-org-roam-dailies-dir nil "^[0-9]\\{4\\}-[0-9]\\{2\\}-[0-9]\\{2\\}\\.org$"))
         ; Filter only the daily notes files
         (last-file (car (last (sort files #'string<))))
         ; Get the last daily note file
         (file-path (expand-file-name last-file my-org-roam-dailies-dir)))

    ; If we found a daily note file
    (when last-file
      ; Open the file in a hidden buffer
      (with-current-buffer (find-file-noselect file-path)
        ; Save the position to preserve point position
        (save-excursion
          ; Go to the beginning of the buffer
          (goto-char (point-min))
          ; Skip the first header lines
          (forward-line 5)
          ; Copy the content of the daily note from there
          (copy-region-as-kill (point) (point-max)))))

    ; Paste the copied content in the current buffer
    (yank)))

(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
    :after org-roam
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))

(defun my-toggle-hacking-layout ()
  "Toggle between a single buffer screen and layout with message window and scratch buffer."
  (interactive)
  (if (= (count-windows) 1)
      (progn
        ;; Setting up complex hacking layout
        (split-window-right)
        (switch-to-buffer "*Messages*")
        (split-window-right)
        (switch-to-buffer "scratch.org")
        (+evil/window-move-right)
        (+evil/window-move-right)
        (windmove-left)
        (balance-windows)
        (windmove-left)
        (enlarge-window -30 t)
        (windmove-right)
        (message "Changed to complex hacking layout"))
    (progn
      ;; Restore to a simple single buffer layout
        (doom/window-maximize-buffer))))

(defun my-emacs-config-download-overwrite ()
  "Use Github version of my Doom Emacs config, the README.org, and make backup."
  (interactive)
  (let ((current-readme-org "~/.config/doom/README.org")
        (backup-readme-org (concat "~/.config/doom/README_" (format-time-string "%Y-%m-%d") ".org"))
        (online-readme-org "https://raw.githubusercontent.com/Prutserdt/dotfiles/refs/heads/master/.config/doom/README.org"))
    (if (yes-or-no-p "Are you sure you want to overwrite README.org? ")
        (progn
          (copy-file current-readme-org backup-readme-org t)
          (url-copy-file online-readme-org current-readme-org t)
          (message "README.org updated and backup saved as %s" backup-readme-org))
      (message "Operation aborted"))))

(defun my-generate-org-links-to-pictures-subdir (dir)
  "Create Org-mode links for displaying images in `nsxiv` of subdirectories."
  (interactive "DDirectory: ")
  (dolist (subdir (seq-filter 'file-directory-p (directory-files dir t "^[^.].*\\.?$")))
    (when (seq-find (lambda (f) (member (file-name-extension f) '("jpeg" "jpg" "png" "gif")))
                    (directory-files subdir t "^[^.].*\\(jpeg\\|jpg\\|png\\|gif\\)$"))
      ;; Extract the last directory name from the full path, used for the hyperlink
      (let ((last-dir (file-name-nondirectory (directory-file-name subdir))))
        ;; Insert an Org-mode link with a shell command to display images using `nsxiv`
        (insert (concat "[[shell: cd " subdir "; find . -maxdepth 1 -type f -iname '*.jpeg' -o -iname '*.jpg' -o -iname '*.png' -o -iname '*.gif' | sort | nsxiv -ftio][" last-dir "]]\n"))))))

(defun my-run-python-buffer ()
  "Run the current buffer as a Python script and display output in a new buffer."
  (interactive)
  (let ((python-script (buffer-file-name))
        (output-buffer "*Python Output*"))
    (if python-script
        (progn
          (with-current-buffer (get-buffer-create output-buffer)
            (read-only-mode -1)
            (erase-buffer)
            (insert (format "Running %s...\n\n" python-script))
            (display-buffer (current-buffer)))
          (start-process "python-process" output-buffer "python" python-script))
      (message "Buffer is not visiting a file."))))

(defun my-run-python-code-in-new-frame-select-manually ()
  "Run a Python script in a new frame after selecting it manually."
  (interactive)
  (let ((file-path (read-file-name "Select a Python file: "))
        (new-frame (make-frame))
        (new-frame-name "my-python-frame"))
    (select-frame-set-input-focus new-frame)
    (if (equal (selected-frame) new-frame)
        (progn
          (vterm)
          (async-shell-command (format "python3 %s" file-path) "*test_code output*")
          (pop-to-buffer "*test_code output*"))
      (message "Failed to select the new frame")
      (delete-frame new-frame))))

(defun my-run-python-code-in-new-frame ()
  "Run a test python script in a name frame (window)."
  (interactive)
  (let ((new-frame (make-frame)))
    (with-selected-frame new-frame
      (vterm)
      (async-shell-command "python3 ~/Downloads/test_code.py" "*test_code output*"))))

(defun my-run-python-code-results-to-clipboard-test ()
  "Run a selected Python script in the current directory and copy the output to clipboard."
  (interactive)
  (let* ((directory default-directory)
         (file-path (read-file-name "Select a Python file: " directory nil t "\.py"))
         (output (shell-command-to-string (concat "python " file-path))))
    (kill-new output)
    (message "Output copied to Emacs kill-ring and can be pasted now.")))

(defun my-asset-allocation-in-time ()
  "Show my asset allocation vs time in a chart. Done by running a Python script."
  (interactive)
  (let ((script-path "~/Stack/Documenten/Aandelen/Plotten_AA_in_de_tijd.py"))
    (setq default-directory (file-name-directory script-path))
    (shell-command (concat "notify-send -t 1000 'Displaying my AA plot: " script-path "'"))
    (shell-command (concat "python3 " script-path)
                   "*Python Output*")
    (message (concat "Python script executed: " script-path))))

(defun my-keyboard-reset ()
  "Right meta/super/control for my Sweep keyboard. Plus quick key repeats."
  (interactive)
  (comint-send-string (get-buffer-process (shell)) "e\nk\nq\n")
  (kill-buffer (current-buffer)))

(defun my-redox-directory ()
  "Open the keymap.c file of my Redox qmk firmware."
  (interactive)
  (find-file (expand-file-name "" "~/qmk_firmware/keyboards/redox/keymaps/Prutserdt")))

(defun my-redox-config-qmk-file ()
  "Open the keymap.c file of my Redox qmk firmware."
  (interactive)
  (find-file (expand-file-name "keymap.c" "~/qmk_firmware/keyboards/redox/keymaps/Prutserdt")))

(defun my-open-pdf-as-org-text (pdf-file)
  "Insert text from a PDF file into a new Org mode buffer using pdftotext."
  (interactive "fSelect PDF file: ")
  (let ((buf (generate-new-buffer "*PDF Text*")))
    (with-current-buffer buf
      (org-mode)
      (start-process
       "pdftotext" buf "pdftotext" pdf-file "-"))
    (switch-to-buffer buf)))

(defun my-open-pdf-to-org-as-text-with-ocr ()
  "Convert a PDF with OCR and open the text in a new Org mode buffer."
  (interactive)
  (let ((pdf-file (read-file-name "Select PDF file: "))
        (ocr-output (make-temp-file "ocr-output" nil ".pdf"))
        (text-output (make-temp-file "ocr-text" nil ".txt")))
    (shell-command (format "ocrmypdf -l eng %s %s" pdf-file ocr-output))
    (shell-command (format "pdftotext %s %s" ocr-output text-output))
    (with-temp-buffer
      (insert-file-contents text-output)
      (org-mode)
      (switch-to-buffer (current-buffer))
      (rename-buffer "*OCR Output*" t))
    (delete-file ocr-output)
    (delete-file text-output)
    (message "Text extracted from %s" pdf-file)))

(defun my-pdf-password-removal ()
  "Remove password of pdf and save under another name."
  (interactive)
  (let* ((pdf-file (read-file-name "PDF file: "))
         (dir (file-name-directory pdf-file))
         (base-name (file-name-base pdf-file))
         (pass-ps (concat dir base-name ".ps"))
         (password-removed-pdf (concat dir base-name "_password_removed.pdf")))
    (shell-command (format "pdftops %s %s" (shell-quote-argument pdf-file) (shell-quote-argument pass-ps)))
    (shell-command (format "ps2pdf %s %s" (shell-quote-argument pass-ps) (shell-quote-argument password-removed-pdf)))
    (delete-file pass-ps)
    (message "PDF file converted to unlocked PDF: %s" password-removed-pdf)))

(setq default-input-method "latin-prefix")
;;(add-hook 'org-mode-hook 'toggle-input-method)

(defun my-insert-characters-and-text ()
  "Inserts a character at point and switches to insert state in Evil mode when in normal state."
  (interactive)
  (let* ((characters '(
                       ("K€ KEuro"          . "K€")
                       ("€ Euro"            . "€")
                       ("° Graad"           . "°")
                       ("µ micro"           . "µ")
                       ("¹ Tot de macht 1"  . "¹")
                       ("² Tot de macht 2"  . "²")
                       ("³ Tot de macht 3"  . "³")
                       ("Ä A met trema"     . "Ä")
                       ("Correct title"     . "The Äkta overlords")
                       ("Note: Ctrl \\ to toggle-input-method" . "")))
         (chosen-character (cdr (assoc (completing-read "Select a character: " characters)
                                      characters))))
    (when chosen-character
      (evil-change-state 'insert)
      (insert chosen-character))))

(defun my-obabel-smiles-show-image ()
  "Show molecular structure from SMILES at point. This requires the command line program 'obable'  and 'nsxiv'. The image is shown in a terminal in emacs"
  (interactive)
  (let ((temp-dir "/dev/shm/temp")
        (smiles (thing-at-point 'line)))
    ;; Create the temp directory if it doesn't exist
    (unless (file-exists-p temp-dir)
      (make-directory temp-dir t))
    (let ((output-file (expand-file-name "output_file.png" temp-dir)))
      (shell-command (concat "obabel -xb -:" (shell-quote-argument smiles) " -O " (shell-quote-argument output-file) " -xp 400 &"))
      (sleep-for 0.5)
      (shell-command (concat "nsxiv " (shell-quote-argument output-file)))))
    (sleep-for 1)
    (doom/window-maximize-buffer))

(defun my-obabel-smiles-insert-image (output-file)
  "Insert image of molecular structure from a text line consisting of SMILES code at point, and paste the image the line below that. This requires the command line package 'obabel' and the image needs to be saved somewhere."
  (interactive "FOutput file location:")
  (let ((smiles (thing-at-point 'line)))
    ;; Generate image from SMILES using Open Babel
    (shell-command
     (concat "obabel -xb -:" (shell-quote-argument smiles)
             " -O " (shell-quote-argument output-file)
             " -xp 400 &"))
    (doom/window-maximize-buffer) ; Maximize buffer window
    (forward-line) ; Move to the next line
    (insert (format "[[file:%s]]" output-file))
    (newline)
    (previous-line)
    (sleep-for 0.5)
    (execute-kbd-macro (kbd "RET"))))

(setq fancy-splash-image (if (zerop (random 2))
                           "~/.config/doom/doom-emacs.png"
                           "~/.config/doom/doom-emacs-stallman.png"))
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
        :desc "Open my Emacs config; README.org" :ng "e" (cmd! (find-file (expand-file-name "README.org" doom-user-dir)))
        :desc "Exiting via Evil-mode" :ng "ZZ" #'save-buffers-kill-terminal))
(add-transient-hook! #'+doom-dashboard-mode (+doom-dashboard-setup-modified-keymap))
(add-transient-hook! #'+doom-dashboard-mode :append (+doom-dashboard-setup-modified-keymap))
(add-hook! 'doom-init-ui-hook :append (+doom-dashboard-setup-modified-keymap))

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
    "My IDE of arduino Powerstrike uploading to ESP32."
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
