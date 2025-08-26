;;; init.el -*- lexical-binding: t; -*-

;; NOTE: This file is generated from ~/.config/doom/README.org
;;      Please only edit that file and org-babel-tangle (emacs)

(doom! :completion
       company             ; the ultimate code completion backend
       (ivy +childframe)   ; a search engine for love and life

       :ui
       doom                ; what makes DOOM look the way it does
       doom-dashboard      ; a nifty splash screen for Emacs
       (emoji +unicode)    ; ð
       hl-todo             ; highlight TODO/FIXME/NOTE/DEPRECATED/HACK/REVIEW
       modeline            ; snazzy, Atom-inspired modeline, plus API
       nav-flash           ; blink the current line after jumping
       ophints             ; highlight the region an operation acts on
       (popup +defaults)   ; tame sudden yet inevitable temporary windows
       smooth-scroll     ; So smooth you won't believe it's not butter
       vi-tilde-fringe     ; fringe tildes to mark beyond EOB

       :editor
       (evil +everywhere)  ; come to the dark side, we have cookies
       file-templates      ; auto-snippets for empty files
       fold                ; (nigh) universal code folding
       snippets            ; my elves. They type so I don't have to

       :emacs
       (dired +icons)      ; making dired pretty [functional]
       electric            ; smarter, keyword-based electric-indent
       undo                ; persistent, smarter undo for your inevitable mistakes
       vc                  ; version-control and :Emacs, sitting in a tree

       :term
       vterm               ; the best terminal emulation in Emacs

       :checkers
       syntax              ; tasing you for every semicolon you forget
       ;;grammar           ; tasing grammar mistake every you make

       :tools
       debugger            ; stepping through code, to help you add bugs
       (eval +overlay)     ; run code, run (also, repls)
       lookup              ; navigate your code and its documentation
       pdf                 ; pdf enhancements
       lsp                 ; M-x vscode
       ;;evil-magit        ; An evil porcelain for Emacs

       :lang
       emacs-lisp          ; drown in parentheses
       (org                ; organize your plain life in plain text
        +pretty            ; pretty is better than ugly
        +roam2             ; wander around notes
        +dragndrop)        ; drop files/images into org
      (python +lsp +pyenv) ; beautiful is better than ugly
                           ; +pyright. Tried pyright, could not get it to work on all of my machines
       sh                  ; she sells {ba,z,fi}sh shells on the C xor

       :os
       tty                 ; zou terminal experience moeten verbeteren...

       :config
       (default +bindings +smartparens)
)
