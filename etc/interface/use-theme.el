;;; use-theme.el ---  theme settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package doom-themes
  :config
  (setq doom-one-brighter-modeline t
        doom-one-padded-modeline   nil
        doom-themes-enable-bold    t
        doom-themes-enable-italic  t)

  (defun vs/load-theme ()
    (interactive)
    (load-theme 'doom-one t)
    (doom-themes-treemacs-config)
    (doom-themes-org-config))


  :hook (vs-config-ui . vs/load-theme)
  )

(provide 'use-theme)
;;; use-theme.el ends here
