;; NOTE This file is generated from the README.org file. Do not alter the
;; config.el directly and only modify the README.org file, then Alt-x and type:
;; 'org-babel-tangle' in emacs and run 'doom sync' in the terminal.
;; Happy hacking :-)

;; Evil Mode
(use-package evil
  :ensure t
  :config
)

;; Add this image to my splash screen
(setq fancy-splash-image "~/.doom.d/doom-emacs.png")

;; Style of line numbering, set to `relative' for relative number.
;; Or keycord: SPC t l, or SPC u SPC t l
(global-display-line-numbers-mode)
(setq display-line-numbers-type 'relative)

;; Restoring old Y behavior of VIM (yank the whole line)
(setq! evil-want-Y-yank-to-eol nil)

;; Highlight the parenthesis pair ([{
(setq show-paren-mode 1)

;; Rainbow delimiters, to find the matching parenthesis
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode)
  :hook (org-mode . rainbow-delimiters-mode)
  )

;; Change the theme
;;(setq doom-theme 'doom-moonlight)
;;(setq doom-theme 'doom-vibrant)
(setq doom-theme 'doom-tokyo-night)
;;(setq doom-theme 'doom-material-dark)
;;(setq doom-theme 'doom-xcode)

;; Help to find the cursor by beacon blink
(beacon-mode 1)
(setq beacon-blink-duration 3)

;; Make the normal/insert/visual states more apparent by changing cursor:
(setq evil-normal-state-cursor '(box "tomato")
      evil-insert-state-cursor '(bar "white")
      evil-visual-state-cursor '(hollow "orange"))

;; Nice bullets instead of boring *. Requires (org +pretty)
(setq org-superstar-headline-bullets-list '("◉" "○" "✿" "✸" "⁖" ))

;; Show the 80 column (Fill Column Indicator)
;; FIXME: does not work in combination with visual-fill-column-mode....
(global-display-fill-column-indicator-mode)

;; Visual fill column, to break the lines that otherwise will keep on going
;; to the end of the window, to improve readability. Related:
;; visual-fill-column-mode, global-visual-line-mode.
;; Can be set manually per buffer by: set-fill-column 80
(setq-default fill-column 110)
(add-hook 'visual-line-mode-hook #'visual-fill-column-mode)
;; Center to the middle of the screen
(setq-default visual-fill-column-center-text t)

;; Transparency
(set-frame-parameter (selected-frame) 'alpha '(95 90))
(add-to-list 'default-frame-alist '(alpha 95 90))

;; use mu4e for e-mail in emacs
(setq mail-user-agent 'mu4e-user-agent)
(set-email-account!
 "transip"
 '((mu4e-sent-folder       . "/transip/Sent Mail")
   (mu4e-trash-folder      . "/transip/Bin")
   (smtpmail-smtp-user     . "email@adress.com"))
 t)
(setq mu4e-get-mail-command "mbsync transip"
      ;; get emails and index every 5 minutes
      mu4e-update-interval 300
      ;; send emails with format=flowed
      mu4e-compose-format-flowed t
      ;; no need to run cleanup after indexing for gmail
      mu4e-index-cleanup nil
      mu4e-index-lazy-check t
      ;; more sensible date format
      mu4e-headers-date-format "%d.%m.%y")
;; FIXME: smtpmail werkt nog niet, onderstaande verbeteren....
;; tell message-mode how to send mail
(setq message-send-mail-function 'smtpmail-send-it)
;; if our mail server lives at smtp.example.org; if you have a local
;; mail-server, simply use 'localhost' here.
(setq smtpmail-smtp-server "smtp.transip.email")
