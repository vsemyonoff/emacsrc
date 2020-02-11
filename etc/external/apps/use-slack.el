;;; use-slack.el --- Slack messenger. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(with-eval-after-load 'emojify
  (setq emojify-emojis-dir (vs:emacs/data "emojis"))
  )

;; (if (not (straight-use-package 'slack))
;;     (warn "===> Can't install 'slack'")

;;   (let ((downloads-dir (expand-file-name "Downloads/" vs-user-home-dir))
;;         (tmp-dir       (vs:emacs/runtime "slack/")))
;;     (setq slack-buffer-emojify               t
;;           slack-file-dir                     downloads-dir
;;           slack-image-file-directory         tmp-dir
;;           slack-profile-image-file-directory tmp-dir
;;           slack-prefer-current-team          t
;;           )

;;     (unless (file-exists-p downloads-dir)
;;       (make-directory downloads-dir t)
;;       )

;;     (unless (file-exists-p tmp-dir)
;;       (make-directory tmp-dir t)
;;       )
;;     )

;;   (require 'slack)

;;   (let ((client-id     (auth-source-pass-get "client-id"     "work/smartling.slack.com"))
;;         ;; (client-secret (auth-source-pass-get "client-secret" "work/smartling.slack.com"))
;;         (token         (auth-source-pass-get "token"         "work/smartling.slack.com")))
;;     (slack-register-team
;;      :name                                   "Smartling"
;;      :client-id                              client-id
;;      ;; :client-secret                          client-secret
;;      :token                                  token
;;      :subscribed-channels                    '(pinch ask-devops ask-itops)
;;      :animate-image                          nil
;;      :default                                t
;;      :full-and-display-names                 t
;;      )
;;     )

;;   (slack-start)
;;   (slack-im-list-update)
;;   (slack-user-list-update)
;;   (slack-group-list-update)
;;   (slack-channel-list-update)

;;   )

(provide 'use-slack)
;;; use-slack.el ends here
