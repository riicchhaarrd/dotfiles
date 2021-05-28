(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives '(("org"  . "http://orgmode.org/elpa/")
					  ("gnu"   . "http://elpa.gnu.org/packages/")
					  ("melpa" . "http://melpa.org/packages/")))
(package-initialize)

(unless (package-installed-p 'use-package)
(package-refresh-contents)
(package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;; Some useful shortcut reminders

;; Reload file
;; C-x C-v

;; Find command for key
;; C-h k

;; Comment / uncomment line
;; C-x C-;

;; Indent / clang-format region
;; C-M-\ (CTRL + ALT + \)

;; Building ctags or etags
;; etags -a $(ls *.[ch])

;; Move to other window
;; C-x o

;; Find out what key combination is used
;; M-x where-is <command>

;; Search and replace (query-replace)
;; M-% (Alt + Shift + 5)

;; Begin of section

;; Useful links
;; https://orgmode.org/worg/org-tutorials/org-latex-export.html

;; Some LaTeX and org mode reminders / useful things

;; #+LaTeX_CLASS: article
;; to have superscripted references instead of [1]
;; #+LATEX_HEADER: \usepackage[superscript,biblabel]{cite}

;; use _CLASS instead
;; #+LATEX_HEADER: \documentclass{article}

;; TODO figure out how to use these, gives error when generating file
;; #+LATEX_HEADER: \usepackage{apacite}
;; #+LATEX_HEADER: \bibliographystyle{apacite}

;; Adding a reference to a website link

;; The Google Search engine\cite{google}
;; 
;; \begin{thebibliography}{1}
;; 
;; \bibitem{google}  \url{https://google.com}
;; 
;; \end{thebibliography}


;; End of section

(setq c-default-style "stroustrup")
(setq-default tab-width 4)
;; (setq-default indent-tabs-mode t)
;; (setq-default indent-tabs-mode 'only)

(cua-mode 1)
(setq cua-keep-region-after-copy t)

(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-s") 'save-buffer)

(global-undo-tree-mode)
(undo-tree-mode 1)

(global-set-key (kbd "C-z") 'undo-tree-undo)
(global-set-key (kbd "C-y") 'undo-tree-redo)
;; (global-set-key (kbd "C-f") 'isearch-forward)
(global-set-key [(control f)] 'isearch-forward)
(define-key isearch-mode-map [(control f)] 'isearch-repeat-forward)
(define-key global-map [?\s-g] 'goto-line)

(setq inhibit-eol-conversion t)
(setq mouse-wheel-progressive-speed nil)
(set-face-attribute 'region nil :background "#666")

(setq org-support-shift-select t)

;; enable some modes
(superword-mode)
;; (which-key-mode)
;; (global-linum-mode)

(menu-bar-mode -1) 
(toggle-scroll-bar -1) 
(tool-bar-mode -1) 

;; nice to have
(defun duplicate-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank)
)

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

(global-set-key (kbd "C-c t") 'treemacs)

;; Clang stuff
(require 'clang-format)
(setq clang-format-style "file")
(setq clang-format-style-option "file")
(setq clang-format-fallback-style "Microsoft")
;;(fset 'c-indent-region 'clang-format-region)
(with-eval-after-load 'cc-mode
  (fset 'c-indent-region 'clang-format-region))

;; (with-eval-after-load 'cc-mode
;;   (fset 'c-indent-region 'clang-format-region)
;;   (bind-keys :map c-mode-base-map
;;              ("<C-tab>" . company-complete)
;;              ("M-." . my-goto-symbol)
;;              ("M-," . xref-pop-marker-stack)
;;              ("C-M-\\" . clang-format-region)
;;              ("C-i" . clang-format)
;;              ("C-." . my-imenu)
;;              ("M-o" . cff-find-other-file))
;;   (when use-rtags
;;     (bind-key "M-?" 'rtags-display-summary c-mode-base-map)))

;; (set-face-attribute 'treemacs-directory-face nil :family "Consolas for Powerline")
(use-package treemacs)
(dolist (face '(treemacs-root-face
              treemacs-git-unmodified-face
              treemacs-git-modified-face
              treemacs-git-renamed-face
              treemacs-git-ignored-face
              treemacs-git-untracked-face
              treemacs-git-added-face
              treemacs-git-conflict-face
              treemacs-directory-face
              treemacs-directory-collapsed-face
              treemacs-file-face
              treemacs-tags-face))
  (set-face-attribute face nil :family "Open Sans" :height 110))

;; (treemacs-toggle-fixed-width)

;; (require 'org-ref)

  (use-package org-bullets
    :custom
    (org-hide-leading-stars t)
    :hook org)

(require 'ox-latex)

(defun org-export-latex-no-toc (depth)
    (when depth
      (format "%% Org-mode is exporting headings to %s levels.\n"
              depth)))
(setq org-export-latex-format-toc-function 'org-export-latex-no-toc)

(add-to-list 'org-latex-classes
		   '("apa6"
			 "\\documentclass{apa6}"
			 ("\\section{%s}" . "\\section*{%s}")
			 ("\\subsection{%s}" . "\\subsection*{%s}")
			 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
			 ("\\paragraph{%s}" . "\\paragraph*{%s}")
			 ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
(setq org-latex-pdf-process
	  '("latexmk -pdflatex='pdflatex -interaction nonstopmode' -pdf -bibtex -f %f"))

(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
  backup-by-copying t    ; Don't delink hardlinks
  version-control t      ; Use version numbers on backups
  delete-old-versions t  ; Automatically delete excess backups
  kept-new-versions 20   ; how many of the newest versions to keep
  kept-old-versions 5    ; and how many of the old
  )

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cua-mode t nil (cua-base))
 '(custom-enabled-themes '(naysayer))
 '(custom-safe-themes
   '("36d890facd489128e70af97d73899d0a4cbab7c8e6971f7dba64a6e7764fcaa0" default))
 '(package-selected-packages
   '(org-ref ox-twbs org-bullets yasnippet-snippets lsp-ui evil company-lsp use-package treemacs naysayer-theme clang-format))
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Consolas for Powerline" :foundry "MS  " :slant normal :weight normal :height 119 :width normal)))))
