;;; use-savehist.el ---  savehist mode settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package savehist
  :config (setq savehist-additional-variables '(search-ring regexp-search-ring)
                savehist-autosave-interval 60
                savehist-file (expand-file-name "history.el" vs-cache-dir))
  :hook (vs-config . savehist-mode)
  )

(provide 'use-savehist)
;;; use-savehist.el ends here
