;;; use-gnus-alias.el --- multiple mail accounts with Gnus. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package gnus-alias
  :after use-notmuch
  :bind (:map message-mode-map ("<f12>" . gnus-alias-select-identity))
  :hook ((message-setup . gnus-alias-determine-identity)
         (message-setup . mml-secure-sign-pgpmime))
  :init
  (require 'notmuch)
  (require 'message)

  (defun vs:message|setup-aliases ()
    "Traverse through all accounts and fill `gnus-alias-identity-alist'."
    (interactive)
    (let* ((accounts        (split-string (shell-command-to-string "easymail list")))
           (default-account (car accounts))
           (identity-rules  (list))
           (alias-alist     (list))
           )
      (dolist (account accounts)
        (let ((name      (substring (shell-command-to-string (format "easymail get %s name" account)) 0 -1))
              (email     (substring (shell-command-to-string (format "easymail get %s email" account)) 0 -1))
              (template  (vs:xdg/config (format "easymail/%s/template.txt" account)))
              (signature (vs:xdg/config (format "easymail/%s/signature.txt" account)))
              (fcc-dir   (format "%s/Sent +newsent" account))
              )
          (when (equal email user-mail-address) (setq default-account account))
          (push `(,account ("any" ,email both) ,account) identity-rules)
          (push `(,account ; account name
                  nil     ; refer to other identity
                  ,(format "%s <%s>" name email)
                  nil     ; organization
                  (("Fcc" . ,fcc-dir))
                  ,(if (file-exists-p template) template nil)
                  ,(if (file-exists-p signature) signature nil)
                  )
                alias-alist
                )
          )
        )
      (setq gnus-alias-default-identity default-account
            gnus-alias-identity-alist   alias-alist
            gnus-alias-identity-rules   identity-rules
            gnus-alias-point-position   'empty-header-or-sig
            notmuch-draft-folder        (format "%s/Drafts" default-account))
      )
    )
  (add-hook 'message-mode-hook #'vs:message|setup-aliases)

  (setq message-citation-line-format     "On %e %B %Y %R, %f wrote:"
        message-citation-line-function   'message-insert-formatted-citation-line
        message-cite-function            'message-cite-original
        message-cite-reply-position      'above
        message-cite-style               nil
        message-fill-column              fill-column
        message-interactive              nil
        message-kill-buffer-on-exit      t
        message-send-mail-function       #'message-send-mail-with-sendmail
        message-sendmail-extra-arguments '("--read-envelope-from" "--read-recipients")
        message-sendmail-f-is-evil       t
        ;;message-signature-separator      "^--$"
        message-yank-cited-prefix        "    "
        message-yank-empty-prefix        "    "
        message-yank-prefix              "    "
        mml2015-sign-with-sender         t
        )
  )

(provide 'use-gnus-alias)
;;; use-gnus-alias.el ends here
