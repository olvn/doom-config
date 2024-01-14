;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!
(setq parinfer-rust-library "~/.emacs.d/parinfer-rust/libparinfer_rust.so")

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one-light)

(setq doom-localleader-key ",")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(autoload 'fennel-mode "~/.doom.d/fennel-mode/fennel-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.fnl\\'" . fennel-mode))

(autoload 'fennel-proto-repl "~/.doom.d/fennel-mode/fennel-proto-repl.el" nil t)
(add-hook 'fennel-mode-hook 'fennel-proto-repl-minor-mode)

(defun my/run-fennel-with-love ()
  (interactive)
  (let ((current-prefix-arg '(4)) ; Emulate C-u
        (output-buffer-name "*run-lisp output*"))
    (switch-to-buffer-other-window (get-buffer-create output-buffer-name))
    (fennel-repl "love .")))

(add-hook 'fennel-mode-hook
          (lambda ()
            (map! :localleader
                  :map fennel-mode-map
                  "'" #'my/run-fennel-with-love
                  "q" #'fennel-repl-quit
                  "ed" #'lisp-eval-defun
                  "ee" #'fennel-reload)))

(add-hook 'fennel-repl-mode-hook
          (lambda ()
            (map! :localleader
                  :map fennel-mode-map
                  "q" #'fennel-repl-quit)))

(after! winum
  (map! :leader
        "1" #'winum-select-window-1
        "2" #'winum-select-window-2
        "3" #'winum-select-window-3
        "4" #'winum-select-window-4
        "5" #'winum-select-window-5))

(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
    :after org-roam ;; or :after org
;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;         a hookable mode anymore, you're advised to pick something yourself
;;         if you don't care about startup time, use
;;  :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))

(use-package! org-roam-timestamps
  :after org-roam
  :config (org-roam-timestamps-mode))

(use-package! magit-delta
  :hook (magit-mode . magit-delta-mode))

(after! git-gutter
  (global-git-gutter-mode +1))

(after! hyperbole
  (hyperbole-mode 1))

(use-package! hyperbole)


(after! dumb-jump
  (map! :leader
        :desc "Dumb Jump"
        "d d" #'dumb-jump-go
        "d b" #'dumb-jump-back))
