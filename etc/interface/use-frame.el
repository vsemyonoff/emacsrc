;;; use-frame.el ---  various frame settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package frame :ensure nil
  :config (setq window-divider-default-places t
                window-divider-default-bottom-width 0
                window-divider-default-right-width 1)
  :hook (vs-config-ui . window-divider-mode)
  )

(provide 'use-frame)
;;; use-frame.el ends here
