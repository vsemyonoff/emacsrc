;;; use-org-jira.el --- Org mode Jira integration. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
;; (if (not (straight-use-package 'org-jira))
;;     (warn "===> Can't install 'org-jira'")

;;   (with-eval-after-load 'org-jira
;;     (setq jiralib-token        `("Cookie" . ,(auth-source-pass-get "cookie" "work/bt.smartling.net"))
;;           jiralib-url          "https://bt.smartling.net"
;;           org-jira-working-dir (expand-file-name "Documents/Jira" vs-user-home-dir)
;;           )
;;     )
;;   )

;; (with-eval-after-load 'request
;;   (setq request-storage-directory (vs:emacs/cache "request"))
;;   )

(provide 'use-org-jira)
;;; use-org-jira.el ends here
