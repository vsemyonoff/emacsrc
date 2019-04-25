;;; use-slack.el --- Slack messenger. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(if (not (straight-use-package 'slack))
    (warn "===> Can't install 'slack'")

  (ignore "Config will go here")
  )

(provide 'use-slack)
;;; use-slack.el ends here
