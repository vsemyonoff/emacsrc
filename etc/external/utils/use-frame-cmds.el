;;; use-frame-cmds.el --- frame commands/functions. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(if (not (straight-use-package 'frame-cmds))
    (warn "===> Can't install 'frame-cmds'")

  ;; (defun vs|sunrise/save-frame ()
  ;;   "Save frame configuration and then maximise frame for sunrise commander."
  ;;   (save-frame-config)
  ;;   (maximize-frame)
  ;;   )
  ;; (advice-add 'sunrise :before #'vs|sunrise/save-frame)

  ;; (defun vs|sunrise/restore-frame ()
  ;;   "Restore frame configuration saved prior to launching sunrise commander."
  ;;   (interactive)
  ;;   (jump-to-frame-config-register)
  ;;   )
  ;; (advice-add 'sr-quit :after #'vs|sunrise/restore-frame)
  )

(provide 'use-frame-cmds)
;;; use-frame-cmds.el ends here
