;;; use-org-vcard.el --- Org mode contacts (vcard) import/export. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package org-vcard
  :init
  (setq org-vcard-custom-styles-dir (vs:emacs/data "vcard"))
  )

(provide 'use-org-vcard)
;;; use-org-vcard.el ends here
