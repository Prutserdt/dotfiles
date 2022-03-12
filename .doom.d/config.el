;; NOTE This file is generated from the README.org file. Do not alter this
;; config.el directly and only modify the REAME.org file, then Alt-x and type:
;; 'org-babel-tangle' in emacs and run 'doom sync' in the terminal.
;; Happy hacking :-)

;; Evil Mode
(use-package evil
  :ensure t
  :config
)

;; Style of line numbering, set to `relative' for relative number.
;; Or keycord: SPC t l, or SPC u SPC t l
;; FIXME: dit werkt niet na een reboot. vreemd...
;;(setq display-line-numbers-mode `relative)
;;(setq display-line-numbers-mode relative)
;;(setq doom-line-numbers-style 'relative)
;;(setq doom-line-numbers-style 'relative)
;;(setq display-line-numbers-mode)
(global-display-line-numbers-mode)
(setq display-line-numbers-type 'relative)

;; Restoring old Y behavior of VIM (yank the whole line)
(setq! evil-want-Y-yank-to-eol nil)

;; Make the normal/insert/visual states more apparent by changing cursor:
(setq evil-normal-state-cursor '(box "tomato")
      evil-insert-state-cursor '(bar "white")
      evil-visual-state-cursor '(hollow "orange"))

;; Nice bullets instead of boring *. Requires (org +pretty)
(setq     org-superstar-headline-bullets-list '("◉" "○" "✿" "✸" "⁖" ))

;; FIXME: ik wil een ander font instellen. Hack font geeft problemen
;; LIJKT het. Na een reboot is de tekst onleesbaar klein wat DENK
;; ik komt door onderstaande fontinstelling. Even kijken hoe ik dit
;; ga oplossen...
;;(set-frame-font "Hack 12" nil t)

;; Add closing parenthesis of [{"'
(show-paren-mode 1)

;; Add this image to my splash screen
(setq fancy-splash-image "~/.doom.d/doom-emacs.png")

;; Change the theme (other pleasing ones: moonlight,)
;;(setq doom-theme 'doom-moonlight)
;;(setq doom-theme 'doom-vibrant)
;;(setq doom-theme 'doom-material-dark)
;;(setq doom-theme 'doom-acario-dark) ;; donker, hoog contrast
(setq doom-theme 'doom-xcode)

;; Transparency... werkt niet..!!
(set-frame-parameter (selected-frame) 'alpha '(95 90))
(add-to-list 'default-frame-alist '(alpha 95 90))

;; FIXME: ik wil dat flash highligting langer duurd, bijv 1 sec
;;(setq hl-line-mode  5)

;; Help to find the cursor by beacon blink
(setq beacon-mode 1)
(setq beacon-blink-duration 3)

;; use mu4e for e-mail in emacs
(setq mail-user-agent 'mu4e-user-agent)
(set-email-account!
 "transip"
 '((mu4e-sent-folder       . "/transip/Sent Mail")
   (mu4e-trash-folder      . "/transip/Bin")
   (smtpmail-smtp-user     . "walter@elffrink.nl"))
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
