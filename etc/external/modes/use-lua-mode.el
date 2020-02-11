;;; use-lua-mode.el ---  Lua editing mode. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package lua-mode
  :mode "\\.lua\\'"
  :interpreter "lua"
  :config
  (setq lua-prefix-key             nil
        lua-indent-level           4
        lua-indent-string-contents t)
  )

(provide 'use-lua-mode)
;;; use-lua-mode.el ends here
