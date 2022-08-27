
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))


;; Bootstrap benchmarking
(use-package benchmark-init
  :ensure t
  :config
  (add-hook 'after-init-hook 'benchmark-init/deactivate))




(org-babel-load-file (expand-file-name "~/.emacs.d/myinit.org"))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "78e6be576f4a526d212d5f9a8798e5706990216e9be10174e3f3b015b8662e27" "816bacf37139d6204b761fea0d25f7f2f43b94affa14aa4598bce46157c160c2" default)))
 '(org-agenda-files (quote ("~/todo.org")))
 '(org-modules
   (quote
    (org-bbdb org-bibtex org-docview org-habit org-info org-irc org-w3m)))
 '(package-selected-packages
   (quote
    (org-pdftools auctex pdf-tools spacemacs-theme olivetti quelpa-use-package org-superstar darkroom flycheck yaml-mode ox-reveal which-key use-package try smart-compile skewer-mode processing-mode orgalist org-multiple-keymap multiple-cursors impatient-mode exec-path-from-shell elpy elfeed-org csharp-mode counsel auto-complete ace-window))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(aw-leading-char-face ((t (:inherit ace-jump-face-foreground :height 3.0)))))
