;;; use-expand-region.el ---  expand region mode. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package expand-region
  :general
  ("C-="   'er/expand-region
   "C-M-=" 'er/contract-region))


(provide 'use-expand-region)
;;; use-expand-region.el ends here
