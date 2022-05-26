;; NOTE This file is generated from the README.org file. Do not alter
;; config.el directly and only modify the README.org file in emacs by
;; 'M-x' 'org-babel-tangle' RET and reload by 'M-x' 'doom/reload' RET

;; Hide the toolbar
;; (tool-bar-mode -1)

;; Restoring to behavior of VIM (Y:yank the whole line, independent on position)
(setq! evil-want-Y-yank-to-eol nil)

(setq fancy-splash-image "~/.doom.d/doom-emacs.png")

(set-frame-parameter (selected-frame) 'alpha '(95 90))
(add-to-list 'default-frame-alist '(alpha 95 90))

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

;; Set the font
(set-frame-font "Hack 12" t t)
(setq default-frame-alist '((font . "Hack 13")))

;; Center to the middle of the screen + set fill column to break the lines
;; Related: visual-fill-column-mode, global-visual-line =set-fill-column 80=
(setq-default fill-column 110)
(global-display-fill-column-indicator-mode)
(add-hook 'visual-line-mode-hook 'visual-fill-column-mode)
(setq-default visual-fill-column-center-text t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                               Other                               :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Set relative numbering. 'SPC' 't'  'l'
(global-display-line-numbers-mode)
(setq display-line-numbers-type 'relative)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                       Custom keybindings                          :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; List of recently opened files:
(global-set-key "\C-h" 'recentf-open-more-files)

;; org babel tangle
;;(global-set-key "\C-h" 'recentf-open-more-files)
