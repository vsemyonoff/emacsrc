;;; use-pdf-tools.el ---  PDF mode settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package pdf-tools
  :magic ("%PDF" . pdf-view-mode)
  :bind
  (:map pdf-view-mode-map
        ("<spc>" .  pdf-view-scroll-down-or-next-page)
        ("g"  . pdf-view-first-page)
        ("G"  . pdf-view-last-page)
        ("l"  . image-forward-hscroll)
        ("h"  . image-backward-hscroll)
        ("j"  . pdf-view-next-page)
        ("k"  . pdf-view-previous-page)
        ("e"  . pdf-view-goto-page)
        ("u"  . pdf-view-revert-buffer)
        ("al" . pdf-annot-list-annotations)
        ("ad" . pdf-annot-delete)
        ("aa" . pdf-annot-attachment-dired)
        ("am" . pdf-annot-add-markup-annotation)
        ("at" . pdf-annot-add-text-annotation)
        ("y"  . pdf-view-kill-ring-save)
        ("i"  . pdf-misc-display-metadata)
        ("s"  . pdf-occur)
        ("b"  . pdf-view-set-slice-from-bounding-box)
        ("r"  . pdf-view-reset-slice))
  :init (setq-default pdf-view-display-size 'fit-page)
  :config (pdf-tools-install :no-query)
  )

(provide 'use-pdf-tools)
;;; use-pdf-tools.el ends here
