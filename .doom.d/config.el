;; NOTE This file is generated from the README.org file. Do not alter the
;; config.el directly and only modify the README.org file, then Alt-x and type:
;; 'org-babel-tangle' in emacs and run 'doom sync' in the terminal.

;; Evil Mode
(use-package evil
  :ensure t
  :config
)

;; Add this image to my splash screen
(setq fancy-splash-image "~/.doom.d/doom-emacs.png")

;; Set relative numbering. 'SPC' 't'  'l'
(global-display-line-numbers-mode)
(setq display-line-numbers-type 'relative)

;; Restoring to behavior of VIM (Y:yank the whole line, independent on position)
(setq! evil-want-Y-yank-to-eol nil)

;; Highlight the matching parenthesis pair
(setq show-paren-mode 1)

;; Rainbow delimiters, to find the matching parenthesis
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode)
  :hook (org-mode . rainbow-delimiters-mode)
  )

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

;; Set flashing yanked text longer, default is 0.2
(setq evil-goggles-duration 0.6)

;; Visual fill column, to break the lines that otherwise will keep on going
;; Related: visual-fill-column-mode, global-visual-line-mode.
;; Can be set manually per buffer by: set-fill-column 80
(setq-default fill-column 110)
(add-hook 'visual-line-mode-hook 'visual-fill-column-mode)
;; Center to the middle of the screen
(setq-default visual-fill-column-center-text t)

(set-frame-font "Hack 10" nil t)

;; Transparency
(set-frame-parameter (selected-frame) 'alpha '(95 90))
(add-to-list 'default-frame-alist '(alpha 95 90))
