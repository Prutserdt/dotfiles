;; NOTE This file is generated from the README.org file. Do not alter
;; config.el directly and only modify the README.org file in emacs by
;; 'M-x' 'org-babel-tangle' RET and reload by 'M-x' 'doom/reload' RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                  Revert Doom Emacs opinionated stuff              ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Hide the toolbar
(tool-bar-mode -1)

;; Restoring to behavior of VIM (Y:yank the whole line, independent on position)
(setq! evil-want-Y-yank-to-eol nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                           Visual stuff                            ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Add this image to my splash screen
(setq fancy-splash-image "~/.doom.d/doom-emacs.png")

;; Set the font
(set-frame-font "Hack 12" t t)
(setq default-frame-alist '((font . "Hack 13")))

;; Help to find the cursor by beacon blink
(beacon-mode 1)
(setq beacon-blink-duration 3)

;; Make the normal/insert/visual states more apparent by changing cursor:
(setq evil-normal-state-cursor '(box "tomato")
      evil-insert-state-cursor '(bar "white")
      evil-visual-state-cursor '(hollow "orange"))

;; Nice bullets instead of boring *. Requires (org +pretty)
(setq org-superstar-headline-bullets-list '("◉" "○" "✿" "✸" "⁖" ))

;; Set flashing of yanked text to a longer interval, default is 0.2
(setq evil-goggles-duration 1.0)

;; Rainbow delimiters, help to find the matching parenthesis
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode)
  :hook (org-mode . rainbow-delimiters-mode)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                       Custom keybindings                          :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(global-set-key "\C-h" 'recentf-open-more-files)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                               Other                               :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Set relative numbering. 'SPC' 't'  'l'
(global-display-line-numbers-mode)
(setq display-line-numbers-type 'relative)

;; Visual fill column, to break the lines that otherwise will keep on going
;; Related: visual-fill-column-mode, global-visual-line =set-fill-column 80=
;;(setq-default Fill-column 110)
;;(setq set-fill-column 110)
;;(setq set-fill-column 110)
;;(setq fill-column 110)
;;(auto-fill-mode 1)
;;(setq fill-column 110)
;;(setq-default display-fill-column-indicator-column 100)
;;(setq-default fill-column 110)
;; FIXME: the 110 column width is not set...? Weird,
;;        the other tries, pasted above, also did not work...
(setq-default visual-fill-column-width 110)
(add-hook 'visual-line-mode-hook 'visual-fill-column-mode)
;; Center to the middle of the screen
(setq-default visual-fill-column-center-text t)

;; Transparency
(set-frame-parameter (selected-frame) 'alpha '(95 90))
(add-to-list 'default-frame-alist '(alpha 95 90))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                              Old stuff                            ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; The lines below are removed and are kept here for a while and can be deleted later.

;; Show the 80 column (Fill Column Indicator)
;; NOTE: does not work in combination with visual-fill-column-mode
;;       and can be removed...
(global-display-fill-column-indicator-mode)

;; Highlight the matching parenthesis pair
;; Removed, since smartparens is already in init.el and the next line is not needed.
;; Remove this line later when it is tested and proven to be not needed.
;;(setq show-paren-mode 1)

;; There are error in the bootscreen after the first loading: no splashscreen
;; and no icons. This can be corrected by running doom/reload, this is not
;; recommended and gives a void-variable doom/reload error but it seems to work for now...
;;(doom/reload)

;; Quit immediately, without a confirmation
;;(setq confirm-kill-emacs nil)
