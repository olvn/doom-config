(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(magit-todos-insert-after '(bottom) nil nil "Changed by setter of obsolete option `magit-todos-insert-at'")
 '(safe-local-variable-values
   '((eval add-hook 'before-save-hook 'py-isort-before-save)
     (lsp-pylsp-plugins-pydocstyle-enabled)
     (lsp-pylsp-plugins-isort-enabled . t)
     (lsp-pylsp-plugins-flake8-enabled . t)
     (lsp-pylsp-plugins-yapf-enabled)
     (hsys-org-enable-smart-keys . t)
     (org-cycle-global-at-bob . t)
     (eval with-eval-after-load 'cider
      (cider-register-cljs-repl-type 'bro "(do (user/run) (user/browser-repl))")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
