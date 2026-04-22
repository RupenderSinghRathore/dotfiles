;; (setq doom-theme 'doom-rne)

(setq doom-font (font-spec :family "FiraCode Nerd Font" :size 18))
(custom-set-faces
 '(font-lock-comment-face ((t (:slant italic))))
 '(font-lock-keyword-face ((t (:slant italic)))))


(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)

;; Scroll
(setq-default evil-scroll-count 10)
(setq scroll-margin 8)
(setq scroll-conservatively 101)

;; no confirm
(setq confirm-kill-emacs nil)
(setq confirm-kill-processes nil)

(setq gc-cons-threshold (* 50 1000 1000)) ;; 50MB

(setq compile-command "")
(add-hook 'find-file-hook #'my/set-compile-based-on-file)

;; default terminal
;; (after! vterm
;;   (setq shell-file-name "/bin/zsh"))
;; (setq +term-shell "/bin/zsh")
;; (setq +term-default-terminal 'vterm)

;; (add-hook 'find-file-hook
;;           (lambda ()
;;             (when (eq major-mode 'fundamental-mode)
;;               (conf-mode))))

(map! :desc "comment line" "C-/" #'comment-line)
(map! :leader :desc "Save file" "s a" #'save-buffer)

;; (map! :leader :desc "Toggle shell" "t t" #'project-eshell)
(map! :leader :desc "Toggle shell" "t t" #'my/toggle-project-eshell)

(map! :leader :desc "lsp disable" "l d" #'eglot-shutdown)

(map! :leader :desc "Toggle markdown view" "m v" #'my/toggle-markdown-view-mode)
(map! :leader :desc "counsel command" "SPC" #'execute-extended-command)

(map! :leader
      (:prefix ("j" . "buffer")
       :desc "Switch buffer" "j" #'switch-to-buffer
       :desc "ibuffer" "i" #'ibuffer
       :desc "Next buffer" "n" #'next-buffer
       :desc "Previous buffer" "p" #'previous-buffer
       :desc "Reload buffer" "r" #'revert-buffer
       :desc "Last buffer" "l" #'my/switch-to-last-buffer))

(map! :leader :desc "Kill current buffer" "x" #'kill-current-buffer)

;; (map! :leader :desc "format buffer" "n f" #'eglot-format-buffer)
(map! :leader
      :desc "format and buffer"
      "n f" #'my/smart-format-buffer)

(map! :leader
      (:prefix ("f" . "buffer")
       :desc "Edit emacs config"  "c"  (lambda ()
                                         (interactive)
                                         (+workspace-switch "emacs config" t)
                                         (find-file "~/dotfiles/.doom.d/config.org"))
       :desc "Find project files" "f" #'project-find-file
       ))

;; Map C-h to Backspace at the translation level
(define-key key-translation-map (kbd "C-h") (kbd "DEL"))

(map! :leader
      :desc "Fuzzy cd" "f J" #'my/fuzzy-cd)

(map! :leader
      :desc "Fuzzy cd" "f j" #'my/fuzzy-cd-ws)

(map! :leader
      :desc "Fuzzy find file" "f F" #'my/fuzzy-find-file)

;; tui programs
(map! :leader
      :desc "LazyGit" "g z" #'my/open-lazygit)

(add-to-list 'custom-theme-load-path "~/.config/emacs/themes/")
(load-theme 'noctalia t)

(set-frame-parameter nil 'alpha-background 85)
(add-to-list 'default-frame-alist '(alpha-background . 85))

;; terminal only
(unless (display-graphic-p)
  (set-face-attribute 'default nil :background "unspecified-bg")
  )

(defun my/fuzzy-find-file ()
  (interactive)
  (let* ((search-dirs '("~/dotfiles"))
         (expanded (mapcar #'expand-file-name search-dirs))
         (candidates
          (split-string
           (shell-command-to-string
            (concat "find "
                    (mapconcat #'identity expanded " ")
                    " -type d \\( -name '.git' -o -name '.repos' \\) -prune"
                    " -o -type f"
                    " \\( ! -name '*.png'"
                    " -a ! -name '*.pdf'"
                    " -a ! -name '*.epub'"
                    " -a ! -name '*.zip'"
                    " -a ! -name '*.svg' \\) -print"
                    " 2>/dev/null | awk '!seen[$0]++'"))
           "\n" t))
         (file (completing-read "Select file: " candidates nil t)))
    (when file
      (find-file file))))

(defun my/fuzzy-cd ()
  (interactive)
  (let* ((search-dirs '("~/dotfiles" "~/lunaar" "~/Documents"
                        "~/Downloads" "~/lunaar/languages/go" "~/Notes"))
         (expanded (mapcar #'expand-file-name search-dirs))
         (candidates
          (split-string
           (shell-command-to-string
            (concat "find "
                    (mapconcat #'identity expanded " ")
                    " -maxdepth 2 -type d "
                    "\\( -name '.git' -o -name '.cache' -o -name '.obsidian' \\) -prune "
                    "-o -type d -print 2>/dev/null | awk '!seen[$0]++'"))
           "\n" t))
         (dir (completing-read "Jump to: " candidates nil t)))
    (when dir
      (setq default-directory (file-name-as-directory dir))
      (dired dir))))

(defun my/fuzzy-cd-ws ()
  (interactive)
  (let* ((search-dirs '("~/dotfiles" "~/lunaar" "~/Documents"
                        "~/Downloads" "~/lunaar/languages/go" "~/Notes"))
         (expanded (mapcar #'expand-file-name search-dirs))
         (candidates
          (split-string
           (shell-command-to-string
            (concat "find "
                    (mapconcat #'identity expanded " ")
                    " -maxdepth 2 -type d "
                    "\\( -name '.git' -o -name '.cache' -o -name '.obsidian' \\) -prune "
                    "-o -type d -print 2>/dev/null | awk '!seen[$0]++'"))
           "\n" t))
         (dir (completing-read "Jump to: " candidates nil t)))
    (when dir
      (let ((name (file-name-nondirectory
                   (directory-file-name dir)))
            (default-directory dir))
        (+workspace/new name)
        (dired dir)))))

(defun my/switch-to-last-buffer ()
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))

(defun my/toggle-markdown-view-mode ()
  "Toggle between `markdown-mode' and `markdown-view-mode'."
  (interactive)
  (if (eq major-mode 'markdown-view-mode)
      (markdown-mode)
    (markdown-view-mode)))

(defun my/doom-sync ()
  (interactive)
  (compile "~/.config/emacs/bin/doom sync"))

(defun my/set-compile-based-on-file ()
  (when buffer-file-name
    (let* ((file buffer-file-name)
           (ext  (file-name-extension file)))
      (setq-local
       compile-command
       (cond
        ((equal ext "c")
         (format "gcc -o run %s && ./run && rm ./run"
                 (shell-quote-argument file)))

        ((equal ext "py")
         (format "python3 %s"
                 (shell-quote-argument file)))

        ((equal ext "go")
         (if (locate-dominating-file file "go.mod")
             "go run ."
           (format "go run %s"
                   (shell-quote-argument file))))

        ((equal ext "rs")
         "cargo run")

        ((equal ext "java")
         (format "javac %s && java %s"
                 (file-name-nondirectory file)
                 (file-name-base file)))

        (t ""))))))
;; (defun my/set-compile-based-on-file ()
;;   (when buffer-file-name
;;     (setq-local compile-command
;;                 (cond
;;                  ((derived-mode-p 'c-mode)
;;                   (format "gcc -o run %s && ./run && rm ./run"
;;                           (shell-quote-argument buffer-file-name)))

;;                  ((derived-mode-p 'python-mode)
;;                   (format "python3 %s"
;;                           (shell-quote-argument buffer-file-name)))

;;                  ((derived-mode-p 'go-mode)
;;                   (if (locate-dominating-file buffer-file-name "go.mod")
;;                       "go run ."
;;                     (format "go run %s"
;;                             (shell-quote-argument buffer-file-name))))

;;                  ((derived-mode-p 'rust-mode)
;;                   "cargo run")

;;                  ((derived-mode-p 'java-mode)
;;                   (format "javac %s && java %s"
;;                           (file-name-nondirectory buffer-file-name)
;;                           (file-name-base buffer-file-name)))

;;                  (t "")))))

(defun my/toggle-project-eshell ()
  (interactive)
  (let ((win (get-window-with-predicate
              (lambda (w) (eq (buffer-local-value 'major-mode (window-buffer w)) 'eshell-mode)))))
    (if win
        (previous-buffer)
      (project-eshell))))

(defun my/toggle-project-vterm ()
  (interactive)
  (let ((win (get-window-with-predicate
              (lambda (w) (eq (buffer-local-value 'major-mode (window-buffer w)) 'vterm-mode)))))
    (if win
        (previous-buffer)
      (projectile-run-vterm))))


(defun my/smart-format-buffer ()
  (interactive)
  (condition-case nil
      (apheleia-format-buffer)
    (error
     (indent-region (point-min) (point-max))))
  (save-buffer))

(defun my/open-lazygit ()
  (interactive)
  (start-process "lazygit" nil "alacritty" "-e" "lazygit"))

(after! leetcode
  (setq leetcode-prefer-language "golang"
        leetcode-submit-timeout 10
        leetcode-save-solutions t)
  )

;; (tab-bar-mode 1)

(after! which-key
  (setq which-key-max-display-columns nil
        which-key-idle-delay 0.5
        which-key-allow-imprecise-window-fit nil
        which-key-separator " → "))

(use-package! exec-path-from-shell
  :config
  (when (memq window-system '(mac ns x pgtk))
    (exec-path-from-shell-initialize)))

(after! eshell
  ;; Save more history
  (setq eshell-history-size 5000
        eshell-save-history-on-exit t
        eshell-hist-ignoredups t
        eshell-scroll-to-bottom-on-input t
        eshell-buffer-maximum-lines 10000)

  ;; Better TAB completion
  (setq eshell-cmpl-ignore-case t
        completion-ignore-case t)

  (add-hook 'eshell-mode-hook
            (lambda ()
              (eshell/alias "lgit" "alacritty -e lazygit $*"))))
;; (eshell/alias "lgit" "alacritty -e lazygit $*"))


(use-package! capf-autosuggest
  :hook (eshell-mode . capf-autosuggest-mode))

(map! :map eshell-mode-map
      :i "C-e" #'capf-autosuggest-accept)

(after! yasnippet
  (define-key yas-keymap (kbd "C-l") #'yas-next-field)
  (define-key yas-keymap (kbd "C-j") #'yas-prev-field))

(after! go-mode
  (map! :map go-mode-map
        :i "C-k p" (lambda ()
                     (interactive)
                     (yas-expand-snippet
                      "fmt.Printf(\"$1\\n\"$2)$0"))
        :i "C-k h" (lambda ()
                     (interactive)
                     (yas-expand-snippet
                      "func (app *application) $1(w http.ResponseWriter, r *http.Request) {\n\t$2\n}$0"))
        :i "C-k e e" (lambda ()
                       (interactive)
                       (yas-expand-snippet
                        "if err != nil {\n\t$1\n}$0"))
        :i "C-k e i" (lambda ()
                       (interactive)
                       (let* ((line (thing-at-point 'line t))
                              (code (string-trim line)))
                         (delete-region (line-beginning-position) (line-end-position))
                         (yas-expand-snippet
                          (format "if err := %s; err != nil {\n\t$0\n}" code))))))

(after! rust-mode
  (map! :map rust-mode-map
        :i "C-k p" (lambda ()
                     (interactive)
                     (yas-expand-snippet
                      "println!(\"$1\"$2);$0"))
        :i "C-k e p" (lambda ()
                       (interactive)
                       (yas-expand-snippet
                        "#[derive(Debug$1)]$0"))))

(after! c-mode
  (map! :map c-mode-map
        :i "C-k p" (lambda ()
                     (interactive)
                     (yas-expand-snippet
                      "printf(\"$1\\n\"$2);$0"))))

(after! java-mode
  (map! :map java-mode-map
        :i "C-k p" (lambda ()
                     (interactive)
                     (yas-expand-snippet
                      "System.out.printf(\"$1\\n\"$2);$0"))))

(after! js-mode
  (map! :map js-mode-map
        :i "C-k p" (lambda ()
                     (interactive)
                     (yas-expand-snippet
                      "console.log(`$1`);$0"))))

;; (after! python-mode
;;   (map! :map python-mode-map
;;         :i "C-k p" (lambda ()
;;                      (interactive)
;;                      (yas-expand-snippet
;;                       "print(f\"$1\"$2)$0"))))


(after! python
  (evil-define-key 'insert python-mode-map
    (kbd "C-k p") (lambda ()
                    (interactive)
                    (yas-expand-snippet "print(f\"$1\"$2)$0"))))

(after! web-mode
  (map! :map web-mode-map
        :i "C-k e" (lambda ()
                     (interactive)
                     (yas-expand-snippet
                      "{% block $1 %}{% endblock %}$0"))))

(after! evil-snipe
  (evil-snipe-mode -1)
  )
(after! evil
  (defmacro my/blackhole-cmd (fn)
    `(lambda () (interactive)
       (let ((evil-this-register ?_))
         (call-interactively #',fn))))

  (evil-define-key '(normal visual) 'global
    "x" (my/blackhole-cmd evil-delete-char)
    "c" (my/blackhole-cmd evil-change)
    "s" (my/blackhole-cmd evil-substitute))

  (advice-remove 'evil-open-below
                 #'+evil--insert-newline-below-and-respect-comments-a)

  ;; Override :q
  (defun my/kill-buffer-and-window ()
    (interactive)
    (kill-current-buffer)
    (delete-window))

  (defun my/save-and-kill-buffer-and-window ()
    (interactive)
    (save-buffer)
    (kill-current-buffer)
    (delete-window))

  ;; :q variants - just close
  (evil-ex-define-cmd "q"   #'my/kill-buffer-and-window)
  (evil-ex-define-cmd "q!"  #'my/kill-buffer-and-window)
  (evil-ex-define-cmd "bd"  #'my/kill-buffer-and-window)
  (evil-ex-define-cmd "bd!" #'my/kill-buffer-and-window)

  ;; :wq variants - save then close
  (evil-ex-define-cmd "wq"  #'my/save-and-kill-buffer-and-window)
  (evil-ex-define-cmd "wq!" #'my/save-and-kill-buffer-and-window)
  (evil-ex-define-cmd "x"   #'my/save-and-kill-buffer-and-window)  ;; :x is alias for :wq

  ;; :qa variants - close all / quit emacs (optional, keep default or override)
  (evil-ex-define-cmd "qa"  #'save-buffers-kill-terminal)
  (evil-ex-define-cmd "qa!" #'kill-emacs)
  (evil-ex-define-cmd "wqa" #'save-buffers-kill-terminal)
  (evil-ex-define-cmd "wqa!" #'save-buffers-kill-emacs))

;; (with-eval-after-load 'eglot
;;   (add-to-list 'eglot-server-programs
;;                '((python-mode python-ts-mode) . ("pyright-langserver" "--stdio"))))
(after! python-mode
  (add-to-list 'eglot-server-programs
               '((python-mode python-ts-mode) . ("pyright-langserver" "--stdio"))))
(add-hook 'python-mode-hook #'eglot-ensure)
(add-hook 'python-ts-mode-hook #'eglot-ensure)

(after! apheleia
  (apheleia-global-mode +1)

  (setf (alist-get 'gofumpt apheleia-formatters)
        '("gofumpt"))

  (setf (alist-get 'golines apheleia-formatters)
        '("golines" "--max-len=120"))  ; adjust line length to taste

  (setf (alist-get 'goimports apheleia-formatters)
        '("goimports"))

  ;; Chain them for go-mode — order matters: goimports → gofumpt → golines
  (setf (alist-get 'go-mode apheleia-mode-alist)
        '(goimports gofumpt golines))

  (setf (alist-get 'go-ts-mode apheleia-mode-alist)
        '(goimports gofumpt golines)))

(after! (eglot cape)
  (defun my/setup-capf ()
    (setq-local completion-at-point-functions
                (list #'eglot-completion-at-point
                      #'cape-dabbrev
                      #'yasnippet-capf)))
  (add-hook 'eglot-managed-mode-hook #'my/setup-capf))

(setq dabbrev-check-other-buffers t
      dabbrev-check-all-buffers t
      dabbrev-upcase-means-case-search t)

(add-hook 'prog-mode-hook
          (lambda ()
            (add-to-list 'completion-at-point-functions #'cape-dabbrev t)))

(global-corfu-mode)
(setq corfu-auto-prefix 2
      cape-dabbrev-min-length 2)

(after! corfu
  (setq corfu-auto t
        corfu-auto-delay 0.2
        corfu-auto-prefix 2))

(add-hook 'prog-mode-hook
          (lambda ()
            (add-to-list 'completion-at-point-functions #'cape-dabbrev t)))
