;=======================================================================
; .emacs: The Emacs initialization file.
; Emacs executes this file whenever it is launched.
;=======================================================================
(setq inhibit-startup-message t)

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package try
             :ensure t)

(use-package which-key
             :ensure t
             :config
             (which-key-mode))
;-----------------------------------------------------------------------
(defvar myPackages
  '(elpy))

(elpy-enable)

(mapc #'(lambda (package)
      (unless (package-installed-p package)
        (package-install package)))
      myPackages)


;-----------------------------------------------------------------------
(defun cpp-quick-compile()
  (interactive)
  (defvar foo)
  (setq foo (concat "g++ " (buffer-name)))
  (shell-command foo)
  )
(global-set-key [(f6)] 'cpp-quick-compile)


;-----------------------------------------------------------------------

;(set-background-color "honeydew")
(global-set-key "\C-x\C-u" 'shell)
(setq-default c-basic-offset 4)
(load-theme 'zenburn t)

;-----------------------------------------------------------------------
; Allowing mouse scrolling
(xterm-mouse-mode 1)

; Create (or don't create) backup files.
; (setq-default make-backup-files t)
(setq-default make-backup-files nil)

;-----------------------------------------------------------------------
; Set the indentation style for C code.
(setq c-default-style "ellemtel")
; (setq c-default-style "cc-mode")
; (setq c-default-style "gnu")
; (setq c-default-style "k&r")
; (setq c-default-style "bsd")
; (setq c-default-style "stroustrup")

;-----------------------------------------------------------------------
; Binding RET to newline-and-indent and switch off electric-indent0-mode
(define-key global-map (kbd "RET") 'newline-and-indent)

;-----------------------------------------------------------------------
; Setting ASM mode customizations
(require 'asm-mode)
(defun my-custom-asm-mode()
  (interactive)
  (setq indent-tabs-mode nil)
  (setq tab-width 4)
  (setq tab-always-indent nil)
  (electric-indent-mode -1)
  (setq tab-stop-list '(4 12 50)))
(add-hook 'asm-mode-hook 'my-custom-asm-mode)

(define-key asm-mode-map (kbd "<ret>") 'newline-and-ident)
(define-key asm-mode-map (kbd "M-.") 'helm-etags-select)
;-----------------------------------------------------------------------
; Set tab-always-indent
;(setq-default tab-always-indent nil)

;-----------------------------------------------------------------------
; Display (or don't display) trailing whitespace characters using an
; unusual background color so they are visible.
(setq-default show-trailing-whitespace t)
;(setq-default show-trailing-whitespace nil)

;-----------------------------------------------------------------------

; Set the "Control-x w" key sequence to call the function
; "delete-trailing-whitespace".
(global-set-key "\C-xw" 'delete-trailing-whitespace)

;-----------------------------------------------------------------------
; Autoclose brackets
(electric-pair-mode 1)

;-----------------------------------------------------------------------
; Turn on (or off) syntax highlighting.
(global-font-lock-mode t)
; (global-font-lock-mode nil)

;-----------------------------------------------------------------------

; Display (or don't display) the column number in the status bar.
(setq column-number-mode t)
; (setq column-number-mode nil)

;-----------------------------------------------------------------------

; Highlight (or don't highlight) the region bounded by the mark and
; the point.
(setq transient-mark-mode t)
;(setq transient-mark-mode nil)

;-----------------------------------------------------------------------

; Highlight (or don't highlight) matching parentheses, braces, and
; brackets.
(show-paren-mode t)
; (show-paren-mode nil)

;-----------------------------------------------------------------------

; Bind the "Control-x l" (the letter "ell") key sequence to
; the function "goto-line".
(global-set-key "\C-xl" 'goto-line)

;-----------------------------------------------------------------------

; Bind the Home and End keys for PuTTY.
(global-set-key "\C-[[1~" 'beginning-of-line)
(global-set-key "\C-[[4~" 'end-of-line)

; Bind the Home and End keys for the Linux GNOME Terminal.
(global-set-key "\C-[OH" 'beginning-of-line)
(global-set-key "\C-[OF" 'end-of-line)

;-----------------------------------------------------------------------

; Indent using spaces instead of tabs, but not in makefile-mode.
(defun myIndentUsingSpaces () (setq indent-tabs-mode nil))
(add-hook 'text-mode-hook 'myIndentUsingSpaces)
(add-hook 'c-mode-hook 'myIndentUsingSpaces)
(add-hook 'c++-mode-hook 'myIndentUsingSpaces)
(add-hook 'asm-mode-hook 'myIndentUsingSpaces)
(add-hook 'java-mode-hook 'myIndentUsingSpaces)
(add-hook 'python-mode-hook 'myIndentUsingSpaces)
(add-hook 'emacs-lisp-mode-hook 'myIndentUsingSpaces)

;-----------------------------------------------------------------------

; When using an X-Window System server, make the scroll bar appear
; on the right (or left).
(set-scroll-bar-mode `right)
; (set-scroll-bar-mode `left)

;-----------------------------------------------------------------------

; Make the Control-n and Control-p keys (and the down arrow and up
; arrow keys) scroll the current window one line at a time instead
; of one-half screen at a time.
(setq scroll-step 1)

;-----------------------------------------------------------------------

; Bind the "Control-x p" key sequence to the function "indent-all".
; The "indent-all" function indents all lines of the C program in the
; current buffer according to the selected indentation style.
(defun indent-all()
   (interactive)
   (save-excursion
      (let ()
         (goto-char (point-min))
         (while (< (point) (point-max))
            (c-indent-command)
            (next-line 1))))
   (delete-trailing-whitespace))
(global-set-key "\C-xp" 'indent-all)

;-----------------------------------------------------------------------

; Tell Emacs where to find plug-in (.el) files.
(setq load-path (cons "~cos217/lib" load-path))

;-----------------------------------------------------------------------

; Bind the "Control-x n" key sequence to call the function "linum-mode",
; thus toggling line numbering.
(require 'linum)
(global-set-key "\C-xn" 'linum-mode)
; (defun mySetLinumMode () (interactive) (linum-mode 1))
; (add-hook 'text-mode-hook 'mySetLinumMode)
; (add-hook 'c-mode-hook 'mySetLinumMode)
; (add-hook 'asm-mode-hook 'mySetLinumMode)
; (add-hook 'java-mode-hook 'mySetLinumMode)
; (add-hook 'python-mode-hook 'mySetLinumMode)
; (add-hook 'emacs-lisp-mode-hook 'mySetLinumMode)
; (add-hook 'makefile-mode-hook 'mySetLinumMode)

;-----------------------------------------------------------------------

; Display characters in columns 72 and 73 using unusual background
; colors, thus making it easy to spot lines that are longer than 72
; characters.
;(require 'column-marker)
;(defun myMarkCol ()
;   (interactive)
;   (column-marker-1 72)
;   (column-marker-2 71))
;(add-hook 'font-lock-mode-hook 'myMarkCol)

;-----------------------------------------------------------------------

; Define gdb as an alias for gud-gdb. See the emacs manual for details.
(defalias 'gdb 'gud-gdb)

;-----------------------------------------------------------------------

; Open go-mode on opening .go files
(add-to-list 'load-path "~/emacs/go-mode.el/")
(autoload 'go-mode "go-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode))

;-----------------------------------------------------------------------

; Run go fmt on save for .go files
(add-hook 'before-save-hook #'gofmt-before-save)

;-----------------------------------------------------------------------
(defun markdown-html (buffer)
  (interactive)
  (princ (with-current-buffer buffer
    (format "<!DOCTYPE html><html><title>Impatient Markdown</title><xmp theme=\"united\" style=\"display:none;\"> %s  </xmp><script src=\"http://strapdownjs.com/v/0.2/strapdown.js\"></script></html>" (buffer-substring-no-properties (point-min) (point-max))))
  (current-buffer)))
;-----------------------------------------------------------------------


;-----------------------------------------------------------------------
; Added by emacs.

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(asm-comment-char 59)
 '(column-number-mode t)
 '(custom-safe-themes
   (quote
    ("816bacf37139d6204b761fea0d25f7f2f43b94affa14aa4598bce46157c160c2" default)))
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (skewer-mode elpy impatient-mode smart-compile zenburn-theme)))
 '(show-paren-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Consolas" :foundry "outline" :slant normal :weight normal :height 102 :width normal)))))
