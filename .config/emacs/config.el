(defvar elpaca-installer-version 0.12)
(defvar elpaca-directory (expand-file-name "elpaca/" user-emacs-directory))
(defvar elpaca-builds-directory (expand-file-name "builds/" elpaca-directory))
(defvar elpaca-sources-directory (expand-file-name "sources/" elpaca-directory))
(defvar elpaca-order '(elpaca :repo "https://github.com/progfolio/elpaca.git"
                              :ref nil :depth 1 :inherit ignore
                              :files (:defaults "elpaca-test.el" (:exclude "extensions"))
                              :build (:not elpaca-activate)))
(let* ((repo  (expand-file-name "elpaca/" elpaca-sources-directory))
       (build (expand-file-name "elpaca/" elpaca-builds-directory))
       (order (cdr elpaca-order))
       (default-directory repo))
  (add-to-list 'load-path (if (file-exists-p build) build repo))
  (unless (file-exists-p repo)
    (make-directory repo t)
    (when (<= emacs-major-version 28) (require 'subr-x))
    (condition-case-unless-debug err
        (if-let* ((buffer (pop-to-buffer-same-window "*elpaca-bootstrap*"))
                  ((zerop (apply #'call-process `("git" nil ,buffer t "clone"
                                                  ,@(when-let* ((depth (plist-get order :depth)))
                                                      (list (format "--depth=%d" depth) "--no-single-branch"))
                                                  ,(plist-get order :repo) ,repo))))
                  ((zerop (call-process "git" nil buffer t "checkout"
                                        (or (plist-get order :ref) "--"))))
                  (emacs (concat invocation-directory invocation-name))
                  ((zerop (call-process emacs nil buffer nil "-Q" "-L" "." "--batch"
                                        "--eval" "(byte-recompile-directory \".\" 0 'force)")))
                  ((require 'elpaca))
                  ((elpaca-generate-autoloads "elpaca" repo)))
            (progn (message "%s" (buffer-string)) (kill-buffer buffer))
          (error "%s" (with-current-buffer buffer (buffer-string))))
      ((error) (warn "%s" err) (delete-directory repo 'recursive))))
  (unless (require 'elpaca-autoloads nil t)
    (require 'elpaca)
    (elpaca-generate-autoloads "elpaca" repo)
    (let ((load-source-file-function nil)) (load "./elpaca-autoloads"))))
(add-hook 'after-init-hook #'elpaca-process-queues)
(elpaca `(,@elpaca-order))

;; Install a package via the elpaca macro
  ;; See the "recipes" section of the manual for more details.

  ;; (elpaca example-package)

  ;; Install use-package support
  (elpaca elpaca-use-package
    ;; Enable use-package :ensure support for Elpaca.
    (elpaca-use-package-mode))

  ;;When installing a package used in the init file itself,
  ;;e.g. a package which adds a use-package key word,
  ;;use the :wait recipe keyword to block until that package is installed/configured.
  ;;For example:
  ;;(use-package general :ensure (:wait t) :demand t)

  ;; Expands to: (elpaca evil (use-package evil :demand t))
;;  (use-package evil :ensure t :demand t)
    (use-package evil
    :ensure t
    :demand t
    :init      ;; tweak evil's configuration before loading it
    (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
    (setq evil-want-keybinding nil)
    (setq evil-vsplit-window-right t)
    (setq evil-split-window-below t)
    ;; (setq evil-undo-system 'undo-redo)
    :config
    (evil-mode)
    (evil-set-undo-system 'undo-redo))

  (use-package evil-collection
    :ensure t
    :after evil
    :config
    (setq evil-collection-mode-list '(dashboard dired ibuffer))
    (evil-collection-init))
  (use-package evil-tutor 
  :ensure t)
 

  ;;Turns off elpaca-use-package-mode current declaration
  ;;Note this will cause evaluate the declaration immediately. It is not deferred.
  ;;Useful for configuring built-in emacs features.
  (use-package emacs :ensure nil :config (setq ring-bell-function #'ignore))

(use-package general
  :ensure t
    :config
    (general-evil-setup)

    ;; set up 'SPC' as the global leader key
   (general-create-definer dt/leader-keys
     :states '(normal insert visual emacs)
     :keymaps 'override
     :prefix "SPC"
     :global-prefix "C-SPC")


  (general-define-key
   :states '(normal visual)
   "C-/" 'comment-line
   "C-r" 'evil-redo
   "C-u" 'evil-scroll-up)

;; Map C-h to Backspace at the translation level
(define-key key-translation-map (kbd "C-h") (kbd "DEL"))


  ;; (with-eval-after-load 'evil
  ;; (define-key evil-insert-state-map (kbd "C-h") #'delete-backward-char)
  ;; (define-key evil-emacs-state-map  (kbd "C-h") #'delete-backward-char)
  ;; (define-key evil-replace-state-map (kbd "C-h") #'delete-backward-char)
  ;; (define-key evil-operator-state-map (kbd "C-h") #'delete-backward-char))

    (dt/leader-keys
    "." '(find-file :wk "Find file")
    "SPC" '(counsel-M-x :wk "Run function")
    "f c" '((lambda () (interactive) (find-file "~/.config/emacs/config.org")) :wk "Edit emacs config")
    "f r" '(counsel-recentf :wk "Recent files")
    "f l" '(counsel-linux-app :wk "App launcher")
    "TAB TAB" '(comment-line :wk "Comment lines")
    )
    (general-define-key
    "C-c c" 'shell-command         ;; 'c' for Command (Wait)
    "C-c a" 'async-shell-command)  ;; 'a' for Async (Background)

    (dt/leader-keys
      "j" '(:ignore t :wk "buffer")
      "j j" '(switch-to-buffer :wk "Switch buffer")
      "j i" '(ibuffer :wk "ibuffer")
      "x" '(kill-buffer :which-key "Kill this buffer")
      "j n" '(next-buffer :wk "Next buffer")
      "j p" '(previous-buffer :wk "Previous buffer")
      "j r" '(revert-buffer :wk "Reload buffer")
      "j l" '(my/switch-to-last-buffer :wk "Last buffer"))

  (defun my/switch-to-last-buffer ()
      (interactive)
      (switch-to-buffer (other-buffer (current-buffer) 1)))

   (dt/leader-keys
      "s" '(save-buffer :wk "Save file"))

   (dt/leader-keys
    "e" '(:ignore t :wk "Evaluate/eshell")    
    "e b" '(eval-buffer :wk "Evaluate elisp in buffer")
    "e d" '(eval-defun :wk "Evaluate defun containing or after point")
    "e e" '(eval-expression :wk "Evaluate and elisp expression")
    "e l" '(eval-last-sexp :wk "Evaluate elisp expression before point")
    "e r" '(eval-region :wk "Evaluate elisp in region")

    ;; eshell configs
    "e h" '(counsel-esh-history :which-key "Eshell history")
    "e s" '(eshell :which-key "Eshell"))

   (defun reload-init-file ()
  (interactive)
  (load-file user-init-file)
  (load-file user-init-file))

   (dt/leader-keys
    "h" '(:ignore t :wk "Help")
    "h f" '(describe-function :wk "Describe function")
    "h v" '(describe-variable :wk "Describe variable")
     "h r r" '((lambda () (interactive) (load-file "~/.config/emacs/init.el")) :wk "Reload emacs config"))
    ;; "h r r" '(reload-init-file :wk "Reload emacs config"))
  )

(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

(use-package all-the-icons
  :ensure t
  :if (display-graphic-p))

(use-package all-the-icons-dired
  :ensure t
  :hook (dired-mode . (lambda () (all-the-icons-dired-mode t))))

(set-face-attribute 'default nil
    :font "FiraCode Nerd Font Mono"
    :height 140
    :weight 'medium)

(set-face-attribute 'font-lock-comment-face nil
  :slant 'italic)

(set-face-attribute 'font-lock-keyword-face nil
  :slant 'italic)

 ;; (add-to-list 'default-frame-alist '(font . "FiraCodeNerdFontMono"))

  (setq-default line-spacing 0.12)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)
(global-font-lock-mode 1)

(use-package toc-org
  :ensure t
  :hook (org-mode . toc-org-enable))

(use-package org-bullets
  :ensure t
  :hook (org-mode . org-bullets-mode))

;; (setq org-startup-indented t)

(add-hook 'org-mode-hook
  (lambda ()
    (display-line-numbers-mode 1)))

(electric-indent-mode -1)

(require 'org-tempo)

(blink-cursor-mode -1)
(setq-default evil-scroll-count 10)
;; (setq maximum-scroll-margin 0.3)
;; (setq scroll-preserve-screen-position t)
(setq scroll-margin 8)
(setq scroll-conservatively 101)
;; Make startup faster by reducing the frequency of garbage collection
(setq gc-cons-threshold (* 50 1000 1000)) ;; 50MB

(use-package sudo-edit
  :ensure t
  :config
    (dt/leader-keys
      "fu" '(sudo-edit-find-file :wk "Sudo find file")
      "fU" '(sudo-edit :wk "Sudo edit file")))

(setq kill-buffer-query-functions
      (remq 'process-kill-buffer-query-function kill-buffer-query-functions))

(use-package which-key
:ensure t
  :init
    (which-key-mode 1)
  :config
  (setq which-key-side-window-location 'bottom
	  which-key-sort-order #'which-key-key-order-alpha
	  which-key-sort-uppercase-first nil
	  which-key-add-column-padding 1
	  which-key-max-display-columns nil
	  which-key-min-display-lines 6
	  which-key-side-window-slot -10
	  which-key-side-window-max-height 0.75
	  which-key-idle-delay 0.3
	  which-key-max-description-length 25
	  which-key-allow-imprecise-window-fit nil
	  which-key-separator " → " ))

(use-package treesit
  :ensure t
  :mode (("\\.tsx\\'" . tsx-ts-mode))
  :preface
  (defun mp-setup-install-grammars ()
    "Install Tree-sitter grammars if they are absent."
    (interactive)
    (dolist (grammar
             ;; Note the version numbers. These are the versions that
             ;; are known to work with Combobulate *and* Emacs.
             '((css . ("https://github.com/tree-sitter/tree-sitter-css" "v0.20.0"))
               (go . ("https://github.com/tree-sitter/tree-sitter-go" "v0.20.0"))
               (html . ("https://github.com/tree-sitter/tree-sitter-html" "v0.20.1"))
               (javascript . ("https://github.com/tree-sitter/tree-sitter-javascript" "v0.20.1" "src"))
               (json . ("https://github.com/tree-sitter/tree-sitter-json" "v0.20.2"))
               (markdown . ("https://github.com/ikatyang/tree-sitter-markdown" "v0.7.1"))
               (python . ("https://github.com/tree-sitter/tree-sitter-python" "v0.20.4"))
               (rust . ("https://github.com/tree-sitter/tree-sitter-rust" "v0.21.2"))
               (toml . ("https://github.com/tree-sitter/tree-sitter-toml" "v0.5.1"))
               (tsx . ("https://github.com/tree-sitter/tree-sitter-typescript" "v0.20.3" "tsx/src"))
               (typescript . ("https://github.com/tree-sitter/tree-sitter-typescript" "v0.20.3" "typescript/src"))
               (yaml . ("https://github.com/ikatyang/tree-sitter-yaml" "v0.5.0"))
               (ocaml . ("https://github.com/tree-sitter/tree-sitter-ocaml" "v0.24.2" "grammars/ocaml/src"))
               (ocaml_interface . ("https://github.com/tree-sitter/tree-sitter-ocaml" "v0.24.2" "grammars/interface/src"))))
      (add-to-list 'treesit-language-source-alist grammar)
      ;; Only install `grammar' if we don't already have it
      ;; installed. However, if you want to *update* a grammar then
      ;; this obviously prevents that from happening.
      (unless (treesit-language-available-p (car grammar))
        (treesit-install-language-grammar (car grammar)))))

  ;; Optional. Combobulate works in both xxxx-ts-modes and
  ;; non-ts-modes.

  ;; You can remap major modes with `major-mode-remap-alist'. Note
  ;; that this does *not* extend to hooks! Make sure you migrate them
  ;; also
  (dolist (mapping
           '((python-mode . python-ts-mode)
             (css-mode . css-ts-mode)
             (typescript-mode . typescript-ts-mode)
             (js2-mode . js-ts-mode)
             (bash-mode . bash-ts-mode)
             (conf-toml-mode . toml-ts-mode)
             (go-mode . go-ts-mode)
             (css-mode . css-ts-mode)
             (json-mode . json-ts-mode)
             (js-json-mode . json-ts-mode)))
    (add-to-list 'major-mode-remap-alist mapping))
  :config
  (mp-setup-install-grammars)
  ;; Do not forget to customize Combobulate to your liking:
  ;;
  ;;  M-x customize-group RET combobulate RET
  ;;
  (use-package combobulate
    :ensure t
    :custom
    ;; You can customize Combobulate's key prefix here.
    ;; Note that you may have to restart Emacs for this to take effect!
    (combobulate-key-prefix "C-c o")
    :hook ((prog-mode . combobulate-mode))
    ;; Amend this to the directory where you keep Combobulate's source
    ;; code.
    :load-path ("path-to-git-checkout-of-combobulate")))

(use-package counsel
      :ensure t
      :after ivy
      :config (counsel-mode))

(use-package ivy
  :ensure t
  :bind
  ;; ivy-resume resumes the last Ivy-based completion.
  (("C-c C-r" . ivy-resume)
   ("C-x B" . ivy-switch-buffer-other-window))
  :custom
  (ivy-use-virtual-buffers t)
  (ivy-count-format "(%d/%d) ")
  (enable-recursive-minibuffers t)
  :config
  (ivy-mode 1))

(use-package all-the-icons-ivy-rich
  :ensure t
  :init
  (all-the-icons-ivy-rich-mode 1))
(setq inhibit-compacting-font-caches t)

(use-package ivy-rich
  :after ivy
  :ensure t
  :init
  (ivy-rich-mode 1)
  ;; this gets us descriptions in M-x.
  :custom
  (ivy-virtual-abbreviate 'full)
  (ivy-rich-switch-buffer-align-virtual-buffer t)
  (ivy-rich-path-style 'abbrev))

(use-package eshell-syntax-highlighting
:ensure t
:after esh-mode
:config
(eshell-syntax-highlighting-global-mode +1))

;; eshell-syntax-highlighting -- adds fish/zsh-like syntax highlighting.
;; eshell-rc-script -- your profile for eshell; like a bashrc for eshell.
;; eshell-aliases-file -- sets an aliases file for the eshell.
  
(setq eshell-rc-script (concat user-emacs-directory "eshell/profile")
      eshell-aliases-file (concat user-emacs-directory "eshell/aliases")
      eshell-history-size 5000
      eshell-buffer-maximum-lines 5000
      eshell-hist-ignoredups t
      eshell-scroll-to-bottom-on-input t
      eshell-destroy-buffer-when-process-dies t
      eshell-visual-commands '("bash" "fish" "htop" "ssh" "top" "zsh"))

(use-package vterm
:ensure t
:config
(setq shell-file-name "/bin/sh"
      vterm-max-scrollback 5000))

(use-package vterm-toggle
  :ensure t
  :after vterm
  :config
  (setq vterm-toggle-fullscreen-p nil)
  (setq vterm-toggle-scope 'project)
  (add-to-list 'display-buffer-alist
               '((lambda (buffer-or-name _)
                     (let ((buffer (get-buffer buffer-or-name)))
                       (with-current-buffer buffer
                         (or (equal major-mode 'vterm-mode)
                             (string-prefix-p vterm-buffer-name (buffer-name buffer))))))
                  (display-buffer-reuse-window display-buffer-at-bottom)
                  ;;(display-buffer-reuse-window display-buffer-in-direction)
                  ;;display-buffer-in-direction/direction/dedicated is added in emacs27
                  ;;(direction . bottom)
                  ;;(dedicated . t) ;dedicated is supported in emacs27
                  (reusable-frames . visible)
                  (window-height . 0.3))))

(use-package rainbow-mode
  :ensure t
  :hook 
  ((org-mode prog-mode) . rainbow-mode))

(use-package dashboard
  :ensure t 
  :init
  (setq initial-buffer-choice 'dashboard-open)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-banner-logo-title "Emacs Is More Than A Text Editor!")
  (setq dashboard-startup-banner 'logo) ;; use standard emacs logo as banner
  ;; (setq dashboard-startup-banner "/home/dt/.config/emacs/images/emacs-dash.png")  ;; use custom image as banner
  (setq dashboard-center-content t) ;; set to 't' for centered content
  (setq dashboard-items '((recents . 5)
                          ;; (agenda . 5 )
                          ;; (bookmarks . 3)
                          (projects . 3)
                          (registers . 3)))
  :custom
  (dashboard-modify-heading-icons '((recents . "file-text")
                                    (bookmarks . "book")))
  :config
  (dashboard-setup-startup-hook))

(add-to-list 'custom-theme-load-path "~/.config/emacs/themes/")
  (load-theme 'noctalia t)
  (set-frame-parameter nil 'alpha-background 85)
  (add-to-list 'default-frame-alist '(alpha-background . 85))
;; Silence background native-compilation warnings
(when (boundp 'native-comp-async-report-warnings-errors)
  (setq native-comp-async-report-warnings-errors 'silent))
