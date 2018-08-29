;;; use-winner.el ---  winner mode. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package winner
  :commands winner-mode
  :hook (vs-emacs-config . winner-mode))

(provide 'use-winner)
;;; use-winner.el ends here
