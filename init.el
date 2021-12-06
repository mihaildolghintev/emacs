(require 'package)

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
;; keep the installed packages in .emacs.d
(setq package-user-dir (expand-file-name "elpa" user-emacs-directory))
(package-initialize)
;; update the package metadata is the local cache is missing
(unless package-archive-contents
  (package-refresh-contents))

(setq load-prefer-newer t)

;; reduce the frequency of garbage collection by making it happen on
;; each 50MB of allocated data (the default is on every 0.76MB)
(setq gc-cons-threshold 50000000)

;; warn when opening files bigger than 100MB
(setq large-file-warning-threshold 100000000)

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-verbose t)

(setq use-package-always-ensure t)

(setq user-emacs-directory (expand-file-name "~/.cache/emacs/")
      url-history-file (expand-file-name "url/history" user-emacs-directory))


;; Keep customization settings in a temporary file (thanks Ambrevar!)
(setq custom-file
      (if (boundp 'server-socket-dir)
          (expand-file-name "custom.el" server-socket-dir)
        (expand-file-name (format "emacs-custom-%s.el" (user-uid)) temporary-file-directory)))
(load custom-file t)

(set-default-coding-systems 'utf-8)

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(setq comp-async-report-warnings-errors nil)


(use-package undo-tree
  :init
  (global-undo-tree-mode 1))


(use-package evil
  :init
  (setq evil-respect-visual-line-mode t)
  (setq evil-undo-system 'undo-tree)
  :config
  (evil-mode 1)

  (setq evil-show-paren-range 1)
  (setq evil-move-cursor-back nil)

  (evil-set-leader 'normal (kbd "SPC"))
  (evil-define-key 'normal 'global (kbd "<leader>ff") 'counsel-find-file)
  (evil-define-key 'normal 'global (kbd "<leader>m") 'counsel-switch-buffer)
  (evil-define-key 'normal 'global (kbd "<leader>o") 'er/mark-outside-pairs)
  (evil-define-key 'normal 'global (kbd "<leader>w") 'evil-window-map)
  (evil-define-key 'normal 'global (kbd "<leader>kc") 'kill-current-buffer)
  (evil-define-key 'normal 'global (kbd "<leader>pp") 'counsel-projectile-switch-project)
  (evil-define-key 'normal 'global (kbd "<leader>pr") 'counsel-projectile-rg)
  (evil-define-key 'normal 'global (kbd "<leader>pf") 'counsel-projectile-find-file)
  (evil-define-key 'normal 'global (kbd "<leader>pd") 'projectile-dired)

  (evil-define-key 'visual 'global (kbd "(") 'paredit-wrap-round)
  (evil-define-key 'visual 'global (kbd "[") 'paredit-wrap-square)
  (evil-define-key 'visual 'global (kbd "{") 'paredit-wrap-curly)


  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal)
  (evil-set-initial-state 'help-mode 'normal)
  (evil-set-initial-state 'dired-mode 'normal)
  (evil-set-initial-state 'compilation-mode 'normal))



(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))

(scroll-bar-mode -1)        ; Disable visible scrollbar
(menu-bar-mode -1)
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 10)
(setq use-dialog-box nil)

(setq inhibit-splash-screen t)

(fset 'yes-or-no-p 'y-or-n-p)

(setq left-margin-width 1)
(setq right-margin-width 1)

(setq mouse-yank-at-point t)

(setq truncate-lines t)
(setq scroll-conservatively 10000
      scroll-preserve-screen-position t)


(setq-default fringe-indicator-alist
              (assq-delete-all 'truncation fringe-indicator-alist))



;; tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width          2)
(setq-default c-basic-offset     2)
(setq-default standart-indent    2)
(setq-default lisp-body-indent   2)

(setq auto-save-default nil)
(setq make-backup-files nil)
(setq auto-save-list-file-name nil)

(setq ring-bell-function #'ignore)
(setq visible-bell nil)

(use-package sketch-themes)
;; (use-package darktooth-theme
;;   :init
;;   (load-theme 'darktooth t))

(use-package faff-theme
  :init
  (load-theme 'faff t))


;; (load-theme 'sketch-black t)


(set-face-attribute 'default nil
                       :font "JetBrains Mono"
                       :weight 'medium
		       :height 130)


(use-package beacon
  :ensure t
  :defer  t
  :diminish 'beacon-mode
  :init  (beacon-mode +1)
  )


(setq display-time-format "%l:%M %p %b %y"
      display-time-default-load-average nil)

(use-package minions
  :hook (doom-modeline-mode . minions-mode))

(use-package doom-modeline
  :hook (after-init . doom-modeline-init)
  :custom
  (doom-modeline-github t)
  (doom-modeline-mu4e nil)
  (doom-modeline-irc nil)
  (doom-modeline-minor-modes t)
  (doom-modeline-persp-name nil)
  (doom-modeline-buffer-file-name-style 'truncate-except-project)
  (doom-modeline-major-mode-icon t))


(use-package super-save
  :defer 1
  :diminish super-save-mode
  :config
  (super-save-mode +1)
  (setq super-save-auto-save-when-idle t))

(use-package paren
  :config
  (set-face-attribute 'show-paren-match-expression nil :background "#363e4a")
  (show-paren-mode 1))

(use-package evil-nerd-commenter
  :bind ("M-/" . evilnc-comment-or-uncomment-lines))


(use-package ivy
  :diminish
  :init
  (ivy-mode 1)
  :config
  (setq ivy-use-virtual-buffers t)
  (setq ivy-wrap t)
  (setq ivy-count-format "(%d/%d) ")
  (setq enable-recursive-minibuffers t)

  (push '(completion-at-point . ivy--regex-fuzzy) ivy-re-builders-alist) ;; This doesn't seem to work...
  (push '(swiper . ivy--regex-ignore-order) ivy-re-builders-alist)
  (push '(counsel-M-x . ivy--regex-ignore-order) ivy-re-builders-alist)

  (setf (alist-get 'counsel-projectile-ag ivy-height-alist) 15)
  (setf (alist-get 'counsel-projectile-rg ivy-height-alist) 15)
  (setf (alist-get 'swiper ivy-height-alist) 15)
  (setf (alist-get 'counsel-switch-buffer ivy-height-alist) 7))

(use-package ivy-hydra
  :defer t
  :after hydra)

(use-package ivy-rich
  :init
  (ivy-rich-mode 1)
  :after counsel)

(use-package counsel
  :demand t
  :bind (("M-x" . counsel-M-x)
         ("C-x b" . counsel-ibuffer)
         ("C-x C-f" . counsel-find-file)
         ;; ("C-M-j" . counsel-switch-buffer)
         ("M-i" . counsel-imenu)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history))
  :config
  (setq ivy-initial-inputs-alist nil)) ;; Don't start searches with ^

(use-package flx  ;; Improves sorting for fuzzy-matched results
  :after ivy
  :defer t
  :init
  (setq ivy-flx-limit 10000))


(use-package prescient
  :after counsel
  :config
  (prescient-persist-mode 1))

(use-package ivy-prescient
  :after prescient
  :config
  (ivy-prescient-mode 1))

(use-package expand-region)
(use-package all-the-icons-dired)

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :demand t
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (when (file-directory-p "~/code")
    (setq projectile-project-search-path '("~/code"))))

(use-package counsel-projectile
  :after projectile
  :config
  (counsel-projectile-mode))


(use-package inf-ruby
  :ensure t
  :config
  (add-hook 'ruby-mode-hook #'inf-ruby-minor-mode))

(use-package ruby-mode
  :config
  (setq ruby-insert-encoding-magic-comment nil))

(use-package robe
  :config
  (add-hook 'ruby-mode-hook #'robe-mode))

(use-package ruby-test-mode)
(use-package rbenv
  :init
  (global-rbenv-mode))

(use-package elec-pair
  :config
  (electric-pair-mode))

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(use-package company
  :ensure t
  :init
  (setq company-idle-delay 0)
  (setq company-echo-delay 0)
  (setq company-tooltip-limit 20)
  (setq company-minimum-prefix-length 1)
  (setq company-tooltip-align-annotations t)
  :config
  (push 'company-robe company-backends)
  (push 'company-tabnine company-backends)
  :hook
  (after-init . global-company-mode))

(use-package company-tabnine)

(use-package magit)
(use-package org)

(use-package web-mode
  :ensure t
  :custom
  (web-mode-markup-indent-offset 2)
  (web-mode-css-indent-offset 2)
  (web-mode-code-indent-offset 2)
  :config
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.hbs\\'" . web-mode)))

(use-package yaml-mode
  :ensure t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

