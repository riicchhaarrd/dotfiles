;; TODO
;; Packages to test/try out
;; Treemacs / Neotree (File explorer)
;; Magit (Git workflow)
;; Projectile (Search files in projects)

;; indent c with tabs width
;;(setq-default indent-tabs-mode t)
;; https://emacs.stackexchange.com/questions/22673/c-brace-indentation
(setq c-default-style "stroustrup")
(setq-default tab-width 4)
;; (setq-default c-basic-offset 4)

;; (setq-default c-electric-flag nil)
;; (defun my-make-CR-do-indent ()
;;   (define-key c-mode-base-map "\C-m" 'c-context-line-break))
;; (add-hook 'c-initialization-hook 'my-make-CR-do-indent)

;; (setq-default indent-tabs-mode 'only)
;; (advice-add 'indent-to :around
;;   (lambda (orig-fun column &rest args)
;;     (when (eq indent-tabs-mode 'only)
;;       (setq column (* tab-width (round column tab-width))))
;;     (apply orig-fun column args)))

;; (add-hook 'c++-mode-hook
;;           (lambda ()
;;             (c-set-style "user")))
;; 
;; (add-hook 'c-mode-hook
;;           (lambda ()
;;             (c-set-style "user")))

  (defun reformat-region (&optional b e)
    (interactive "r")
    (when (not (buffer-file-name))
      (error "A buffer must be associated with a file in order to use REFORMAT-REGION."))
    (when (not (executable-find "clang-format"))
      (error "clang-format not found."))
    (shell-command-on-region b e
                                                "clang-format -style=LLVM"
                                                (current-buffer) t)
    (indent-region b e)
    )

;; do basic package loading MELPA etc

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

;; bind Shift + CTLR + arrow keys to resize split windows

;; (global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
;; (global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
;; (global-set-key (kbd "S-C-<down>") 'shrink-window)
;; (global-set-key (kbd "S-C-<up>") 'enlarge-window)

;; package-install expand-region
;; this package selects between quotes (kinda like ci" in vim or vi")
(global-set-key (kbd "C-;") 'er/expand-region)

;; bind ctrl-s to save
(global-set-key (kbd "C-s") 'save-buffer)

;; https://emacs.stackexchange.com/questions/5944/is-there-a-transparent-theme
;; set transparency
(set-frame-parameter (selected-frame) 'alpha '(85 85))
(add-to-list 'default-frame-alist '(alpha 85 85))
    
;; replace C-x b with ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)

(with-eval-after-load 'evil-maps
  (define-key evil-motion-state-map (kbd "SPC") nil)
  (define-key evil-motion-state-map (kbd "RET") nil)
  (define-key evil-insert-state-map (kbd "C-a") 'evil-beginning-of-line)
  (define-key evil-normal-state-map (kbd "C-a") 'evil-beginning-of-line)
  (define-key evil-insert-state-map (kbd "C-e") 'move-end-of-line)
  (define-key evil-normal-state-map (kbd "C-e") 'move-end-of-line)
  (define-key evil-motion-state-map (kbd "TAB") nil))

;; enable vi style keybinds
(evil-mode 1)

;; https://emacs.stackexchange.com/questions/10856/how-do-i-set-up-key-bindings-for-modes-in-a-specific-evil-state
;; example of how to define keybinds in evil-mode
;; (evil-define-key 'insert emacs-lisp-mode-map (kbd "C-c C-c") 'butterfly
;;                                             (kbd "<pause>") 'zone)

;; this is already handled by CUA-mode
;; (global-set-key (kbd "C-v") 'clipboard-yank)
;; (global-set-key (kbd "C-c") 'clipboard-kill-ring-save)
;; (global-set-key (kbd "C-x") 'clipboard-kill-region)

;; bind ctrl-d to duplicate line
;; (global-set-key "C-d" "\C-a\C- \C-n\M-w\C-y")

(defun duplicate-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank)
)
;; (global-set-key (kbd "C-d") 'duplicate-line)

;; enables ctrl-c / v / and x just like other programs
;; (cua-mode 1)

;; requires undo-tree package
;; package-install undo-tree
;; https://emacs.stackexchange.com/questions/24496/integrate-cua-mode-with-evil-insert-state

(defun copy-keep-highlight (beg end)
  (interactive "r")
  (prog1 (clipboard-kill-ring-save beg end)
    (setq deactivate-mark nil)))

(setq cua-keep-region-after-copy t)
;; (define-key evil-insert-state-map (kbd "C-c") 'clipboard-kill-ring-save)
(define-key evil-insert-state-map (kbd "C-c") 'copy-keep-highlight)
(define-key evil-insert-state-map (kbd "C-v") 'clipboard-yank)
;; (define-key evil-insert-state-map (kbd "C-a") 'mark-whole-buffer)
;; (define-key evil-normal-state-map (kbd "C-a") 'mark-whole-buffer)
;; (global-set-key (kbd "C-a") 'mark-whole-buffer)

;; (define-key evil-insert-state-map (kbd "C-x") 'cua-cut-region)
(define-key evil-insert-state-map (kbd "C-z") 'undo-tree-undo)
(define-key evil-insert-state-map (kbd "C-y") 'undo-tree-redo)
(define-key evil-insert-state-map (kbd "C-d") 'duplicate-line)

(define-key evil-normal-state-map (kbd "s-=") 'evil-numbers/inc-at-pt)
(define-key evil-visual-state-map (kbd "s-=") 'evil-numbers/inc-at-pt)
(define-key evil-normal-state-map (kbd "s--") 'evil-numbers/dec-at-pt)
(define-key evil-visual-state-map (kbd "s--") 'evil-numbers/dec-at-pt)

;; note to self
;; ctrl + o and ctrl + i for jump list (evil-mode)
;; and ctrl + ] to jump to definition

;; ctrl-z toggle evil-mode and emacs mode
;; ctrl + h + k, find out what key does what

;; uncommenting and commenting lines is Shift +V + M-;

;; this interferes with quickly typing any keys that require shift and just pressing space e.g +
;; (global-set-key (kbd "S-SPC") 'evil-normal-state)

;; vi style keybindings in evil mode

(defun kbd+ (keyrep &optional need-vector)
  (if (vectorp keyrep) keyrep (edmacro-parse-keys keyrep need-vector)))

(defun gmap (keyrep defstr)
  "Vim-style global keybinding. Uses the `global-set-key' binding function."
  (global-set-key (kbd+ keyrep) (edmacro-parse-keys defstr t)))

(defun fmap (keybind-fn keyrep defstr)
  "Vim-style keybinding using the key binding function KEYBIND-FN."
  (call keybind-fn (kbd+ keyrep) (edmacro-parse-keys defstr t)))

(defun xmap (keymap keyrep defstr)
  "Vim-style keybinding in KEYMAP. Uses the `define-key' binding function."
  (define-key keymap (kbd+ keyrep) (edmacro-parse-keys defstr t)))

(defun nmap (keyrep defstr) "Vim-style keybinding for `evil-normal-state'. Uses the `define-key' binding function."
      (xmap evil-normal-state-map keyrep defstr))
(defun imap (keyrep defstr) "Vim-style keybinding for `evil-insert-state'. Uses the `define-key' binding function."
      (xmap evil-insert-state-map keyrep defstr))
(defun vmap (keyrep defstr) "Vim-style keybinding for `evil-visual-state'. Uses the `define-key' binding function."
      (xmap evil-visual-state-map keyrep defstr))
(defun mmap (keyrep defstr) "Vim-style keybinding for `evil-motion-state'. Uses the `define-key' binding function."
      (xmap evil-motion-state-map keyrep defstr))

(defun test2()
  (interactive)
  (move-beginning-of-line 1)
  (open-line 1)
  (next-line 1)
)
(defun test3()
  (interactive)
  (move-beginning-of-line 1)
  (previous-line 1)
  (kill-line)
)
(define-key evil-normal-state-map (kbd "RET") 'test2)
(define-key evil-normal-state-map (kbd "DEL") 'test3)

;; (global-set-key (kbd "C-d") 'duplicate-line)

;; show which keycombos and their commands
(which-key-mode)

;; show line numbers
(global-linum-mode)

;; set visual select color
(set-face-attribute 'region nil :background "#666")

;; save/restore opened files and windows config
;; (desktop-save-mode 1) ; 0 for off

;; load custom theme
;; (load-theme 'leuven t)

;; disable auto / smart indentation..
;; (when (fboundp 'electric-indent-mode) (electric-indent-mode -1))

;; tab and shift tab (backtab) line indenting
;; copied from https://stackoverflow.com/questions/2249955/emacs-shift-tab-to-left-shift-the-block/2252922

(defun indent-region-custom(numSpaces)
    (progn 
        ; default to start and end of current line
        (setq regionStart (line-beginning-position))
        (setq regionEnd (line-end-position))

        ; if there's a selection, use that instead of the current line
        (when (use-region-p)
            (setq regionStart (region-beginning))
            (setq regionEnd (region-end))
        )

        (save-excursion ; restore the position afterwards            
            (goto-char regionStart) ; go to the start of region
            (setq start (line-beginning-position)) ; save the start of the line
            (goto-char regionEnd) ; go to the end of region
            (setq end (line-end-position)) ; save the end of the line

            (indent-rigidly start end numSpaces) ; indent between start and end
            (setq deactivate-mark nil) ; restore the selected region
        )
    )
)

;; custom tab indent code

(defun untab-region (N)
    (interactive "p")
    (indent-region-custom -4)
)

(defun tab-region (N)
    (interactive "p")
    (if (active-minibuffer-window)
        (minibuffer-complete)    ; tab is pressed in minibuffer window -> do completion
    ; else
    (if (string= (buffer-name) "*shell*")
        (comint-dynamic-complete) ; in a shell, use tab completion
    ; else
    (if (use-region-p)    ; tab is pressed is any other buffer -> execute with space insertion
        (indent-region-custom 4) ; region was selected, call indent-region
        (insert "\t") ; else insert four spaces as expected
    )))
)

(global-set-key (kbd "<backtab>") 'untab-region)
(global-set-key (kbd "<tab>") 'tab-region)

(setq inhibit-eol-conversion t)

;; disables some parentheses mode autocomplete
;; (smartparens-global-mode -1)

;; scrolling behavior
;; (setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil)))
(setq mouse-wheel-progressive-speed nil)

;; to disable emacs from creating backup files
;; (setq make-backup-files nil)

;; set settings for emacs backing up files
(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
  backup-by-copying t    ; Don't delink hardlinks
  version-control t      ; Use version numbers on backups
  delete-old-versions t  ; Automatically delete excess backups
  kept-new-versions 20   ; how many of the newest versions to keep
  kept-old-versions 5    ; and how many of the old
  )

;; Clang stuff
(require 'clang-format)
(setq clang-format-style "file")
(setq clang-format-style-option "file")
(setq clang-format-fallback-style "Microsoft")
(fset 'c-indent-region 'clang-format-region)

;; To be able to select identifiers with underscores easier
(superword-mode)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-quickhelp-color-background "#4F4F4F")
 '(company-quickhelp-color-foreground "#DCDCCC")
 '(custom-enabled-themes '(leuven))
 '(custom-safe-themes
   '("e6df46d5085fde0ad56a46ef69ebb388193080cc9819e2d6024c9c6e27388ba9" default))
 '(fci-rule-color "#383838")
 '(nrepl-message-colors
   '("#CC9393" "#DFAF8F" "#F0DFAF" "#7F9F7F" "#BFEBBF" "#93E0E3" "#94BFF3" "#DC8CC3"))
 '(package-selected-packages
   '(evil-numbers zenburn-theme yasnippet-snippets lsp-ui evil company-lsp which-key expand-region))
 '(pdf-view-midnight-colors '("#DCDCCC" . "#383838"))
 '(vc-annotate-background "#2B2B2B")
 '(vc-annotate-color-map
   '((20 . "#BC8383")
	 (40 . "#CC9393")
	 (60 . "#DFAF8F")
	 (80 . "#D0BF8F")
	 (100 . "#E0CF9F")
	 (120 . "#F0DFAF")
	 (140 . "#5F7F5F")
	 (160 . "#7F9F7F")
	 (180 . "#8FB28F")
	 (200 . "#9FC59F")
	 (220 . "#AFD8AF")
	 (240 . "#BFEBBF")
	 (260 . "#93E0E3")
	 (280 . "#6CA0A3")
	 (300 . "#7CB8BB")
	 (320 . "#8CD0D3")
	 (340 . "#94BFF3")
	 (360 . "#DC8CC3")))
 '(vc-annotate-very-old-color "#DC8CC3"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Noto Sans Mono" :foundry "GOOG" :slant normal :weight normal :height 119 :width normal)))))

(define-key global-map [?\s-p] 'goto-line)
