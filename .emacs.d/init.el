;; TODO
;; Try out treemacs or neotree (treemacs looks nice)
;; magit looks very interesting aswell

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

;; indent c with tabs width
(setq-default c-basic-offset 4)
;; https://emacs.stackexchange.com/questions/22673/c-brace-indentation
(setq c-default-style "bsd")

;; replace C-x b with ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)

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
(setq cua-keep-region-after-copy t)
(define-key evil-insert-state-map (kbd "C-c") 'cua-copy-region)
(define-key evil-insert-state-map (kbd "C-v") 'cua-paste)
;; (define-key evil-insert-state-map (kbd "C-x") 'cua-cut-region)
(define-key evil-insert-state-map (kbd "C-z") 'undo-tree-undo)
(define-key evil-insert-state-map (kbd "C-y") 'undo-tree-redo)
(define-key evil-insert-state-map (kbd "C-d") 'duplicate-line)
;; (global-set-key (kbd "C-d") 'duplicate-line)

;; show which keycombos and their commands
(which-key-mode)

;; show line numbers
(global-linum-mode)

;; set visual select color
(set-face-attribute 'region nil :background "#666")

;; enable c autocomplete stuff
(use-package lsp-mode :commands lsp)
(use-package lsp-ui :commands lsp-ui-mode)
(use-package company-lsp :commands company-lsp)

(use-package ccls
  :hook ((c-mode c++-mode objc-mode cuda-mode) .
         (lambda () (require 'ccls) (lsp))))

(setq ccls-executable "/usr/bin/ccls")
;; (setq ccls-args '("--log-file=/tmp/ccls.log"))

;; save/restore opened files and windows config
(desktop-save-mode 1) ; 0 for off

;; load custom theme
(load-theme 'leuven t)

;; disable auto / smart indentation..
;; (when (fboundp 'electric-indent-mode) (electric-indent-mode -1))

;; disables some parentheses mode autocomplete
;; (smartparens-global-mode -1)

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
        (insert "    ") ; else insert four spaces as expected
    )))
)

(global-set-key (kbd "<backtab>") 'untab-region)
(global-set-key (kbd "<tab>") 'tab-region)

;; custom variables set by emacs self

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cua-mode t nil (cua-base))
 '(custom-safe-themes
   '("3957edd5051733cf0f50c184f3ef41fa181706fbc7ac2043d1f3b4d0034b2fe3" "f08d2081f6783a5712cdce418f3962bd97a2054e8960609aad53f013a8b6f1cc" default))
 '(package-selected-packages
   '(vscode-dark-plus-theme vs-light-theme expand-region yasnippet-snippets lsp-ui evil company-lsp which-key use-package ccls ac-php)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Consolas for Powerline" :foundry "MS  " :slant normal :weight normal :height 97 :width normal)))))
