(require 'package)
(setq package-enable-at-startup nil)
;; (setq package-archives '(("org"  . "http://orgmode.org/elpa/")
;; 					  ("gnu"   . "http://elpa.gnu.org/packages/")
;; 					  ("melpa" . "http://melpa.org/packages/")))

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cua-mode t nil (cua-base))
 '(custom-enabled-themes '(leuven))
 '(custom-safe-themes
   '("e6df46d5085fde0ad56a46ef69ebb388193080cc9819e2d6024c9c6e27388ba9" "2809bcb77ad21312897b541134981282dc455ccd7c14d74cc333b6e549b824f3" "d14f3df28603e9517eb8fb7518b662d653b25b26e83bd8e129acea042b774298" "ae5b216c8bf4c27e6de9cc7627e5fac03915fe1a5ce5c35eacb8860fa4a4cb94" "36d890facd489128e70af97d73899d0a4cbab7c8e6971f7dba64a6e7764fcaa0" "51ba8411a3c669279cba2e3d35d6a260986e95e57a9734bdd6c23af658117429" default))
 '(horizontal-scroll-bar-mode nil)
 '(package-selected-packages
   '(ccls magit zenburn-theme solarized-theme gruvbox-theme rainbow-delimiters highlight-numbers plantuml-mode org-download org-superstar org-ref ox-twbs org-bullets yasnippet-snippets lsp-ui evil company-lsp use-package treemacs naysayer-theme clang-format))
 '(scroll-bar-mode nil)
 '(scroll-conservatively 10)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Consolas for Powerline" :foundry "MS  " :slant normal :weight normal :height 103 :width normal))))
 '(minibuffer-prompt ((t (:background "black" :foreground "#F0DFAF" :weight bold)))))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))
(package-install-selected-packages)

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

;; Insert tab whilst in a code block in org mode
;; M-i (ALT + i)

;; Find references to function
;; M-?

;; Changing a code block in a temporary buffer in org mode
;; C-c '

;; Enable inline images in org mode
;; M-x org-toggle-inline-images RET or with the key-binding C-c C-x C-v.

;; Run code inside org mode
;; C-c C-c

;; Evaluate expression
;; c-u M-: (/ 100 (float 3)) RET

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

(add-to-list 'auto-mode-alist '("\\.gsc\\'" . c-mode))

;; https://stackoverflow.com/questions/24344611/emacs-weirdness-when-trying-to-comment-in-assembly
(defun my-hook ()
  (local-set-key ";" 'self-insert-command))

(add-hook 'asm-mode-hook 'my-hook)

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

;; some helper functions
;; http://ergoemacs.org/emacs/emacs_kill-ring.html

(defun my-delete-word (arg)
  "Delete characters forward until encountering the end of a word.
With argument, do this that many times.
This command does not push text to `kill-ring'."
  (interactive "p")
  (delete-region
   (point)
   (progn
     (forward-word arg)
     (point))))

(defun my-backward-delete-word (arg)
  "Delete characters backward until encountering the beginning of a word.
With argument, do this that many times.
This command does not push text to `kill-ring'."
  (interactive "p")
  (my-delete-word (- arg)))

(defun my-delete-line ()
  "Delete text from current position to end of line char.
This command does not push text to `kill-ring'."
  (interactive)
  (delete-region
   (point)
   (progn (end-of-line 1) (point)))
  (delete-char 1))

(defun my-delete-line-backward ()
  "Delete text between the beginning of the line to the cursor position.
This command does not push text to `kill-ring'."
  (interactive)
  (let (p1 p2)
    (setq p1 (point))
    (beginning-of-line 1)
    (setq p2 (point))
    (delete-region p1 p2)))

; bind them to emacs's default shortcut keys:
;; (global-set-key (kbd "C-S-k") 'my-delete-line-backward) ; Ctrl+Shift+k
;; (global-set-key (kbd "C-k") 'my-delete-line)
;; (global-set-key (kbd "M-d") 'my-delete-word)
;; (global-set-key (kbd "<M-backspace>") 'my-backward-delete-word)

(global-set-key [(control w)] 'my-backward-delete-word)
;; (global-set-key [(control w)] 'backward-kill-word)
(define-key isearch-mode-map [(control f)] 'isearch-repeat-forward)
(define-key global-map [?\s-g] 'goto-line)

(setq inhibit-eol-conversion t)
(setq mouse-wheel-progressive-speed nil)
(set-face-attribute 'region nil :background "#666")
(setq-default cursor-type 'bar)
;; (set-cursor-color "#000000")

;; this disables auto saving files
;; (setq auto-save-default nil)
;; or add [#]*[#] to .gitignore

(setq backup-directory-alist
      `((".*" . "~/.saves")))
(setq auto-save-file-name-transforms
      `((".*" "~/.saves" t)))

(setq org-support-shift-select t)

(require 'org-superstar)
(add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))
(setq org-startup-with-inline-images t)
(setq org-image-actual-width 400)

(setq-default indent-tabs-mode nil)
(setq org-src-preserve-indentation t)
;; (setq org-edit-src-content-indentation 0)

(require 'org-download)

;; Drag-and-drop to `dired`
(add-hook 'dired-mode-hook 'org-download-enable)

;; enable some modes
;; (superword-mode)
(add-hook 'c-mode-common-hook 'superword-mode)
;; (which-key-mode)
;; (global-linum-mode)
(add-hook 'c-mode-common-hook 'global-linum-mode)
(require 'rainbow-delimiters)
;; (add-hook 'c-mode-common-hook 'rainbow-delimeters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

(menu-bar-mode -1) 
(toggle-scroll-bar -1)

(customize-set-variable 'scroll-bar-mode nil)
(customize-set-variable 'horizontal-scroll-bar-mode nil)

(tool-bar-mode -1)

;; https://stackoverflow.com/questions/3631220/fix-to-get-smooth-scrolling-in-emacs
(setq scroll-conservatively 10)
;; (setq scroll-margin 7)

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

(add-to-list 'org-latex-classes
             '("beamer"
               "\\documentclass\[presentation\]\{beamer\}"
               ("\\section\{%s\}" . "\\section*\{%s\}")
               ("\\subsection\{%s\}" . "\\subsection*\{%s\}")
               ("\\subsubsection\{%s\}" . "\\subsubsection*\{%s\}")))

;; (require 'ox-html5slide)
;; getting a error, maybe wrong version...

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

(with-eval-after-load 'org
(org-babel-do-load-languages 'org-babel-load-languages '((ruby . t)
(plantuml . t)
)))

;; For reference how to create diagram flow https://plantuml.com/activity-diagram-legacy
;; http://www.alvinsim.com/diagrams-with-plantuml-and-emacs/
;; https://lgfang.github.io/computer/2015/12/11/org-diagram

(setq org-plantuml-jar-path (expand-file-name "/usr/share/plantuml/plantuml.jar"))

(defun org-insert-image-clipboard ()
  (interactive)
  (setq imageName (concat "screenshot_" (format-time-string "%Y_%m_%d__%H_%M_%S") ".png"))
  (setq file (concat "~/Pictures/Emacs/" imageName))
  (shell-command (concat "xclip -selection clipboard -t image/png -o > " file))
  (insert (concat "[[" file "]]"))
  (org-display-inline-images))

(global-set-key (kbd "C-x p") 'org-insert-image-clipboard)

(global-set-key (kbd "C-c m d") 'magit-diff-buffer-file)
;; use 1 through 4 to expand the sections
;; and s to stage files, c c to commit C-c C-c and b b to switch to another branch
;; https://www.emacswiki.org/emacs/Magit
;; P u to git push
;; F u to git pull
(global-set-key (kbd "C-c m s") 'magit-status)

(desktop-save-mode 1) ; 0 for off
(setq desktop-save t)

(server-start) ;; so we can use a bash script and windmove using emacsclient

(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings 'super))

;; (global-set-key (kbd "M-<left>")  'windmove-left)
;; (global-set-key (kbd "M-<right>") 'windmove-right)
;; (global-set-key (kbd "M-<up>")    'windmove-up)
;; (global-set-key (kbd "M-<down>")  'windmove-down)

;; Open split terminal on launch
;; (add-hook 'emacs-startup-hook
;;   (lambda ()
;;     (let ((w (split-window-below 2)))
;;       (select-window w)
;;       (minimize-window)
;; 	  (enlarge-window 5)
;;       (term "/bin/bash"))
;;       (switch-to-buffer "*terminal*")))

(defadvice split-window (after move-point-to-new-window activate)
  "Moves the point to the newly created window after splitting."
  (other-window 1))

;; (add-hook 'after-init-hook
;;           (lambda ()
;;             ;; No splash screen
;;             (setq inhibit-startup-screen t)
;; 
;;             ;; If the *scratch* buffer is the current one, then create a new
;;             ;; empty untitled buffer to hide *scratch*
;;             (if (string= (buffer-name) "*scratch*")
;;                 (new-empty-buffer))
;;             )
;;           t) ;; append this hook to the tail

(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
  backup-by-copying t    ; Don't delink hardlinks
  version-control t      ; Use version numbers on backups
  delete-old-versions t  ; Automatically delete excess backups
  kept-new-versions 20   ; how many of the newest versions to keep
  kept-old-versions 5    ; and how many of the old
  )

(scroll-bar-mode t)
(highlight-numbers-mode t)
