;;; use-notmuch.el --- Notmuch mail user agent. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(if (not (straight-use-package 'notmuch))
    (warn "===> Can't install 'notmuch'")

  (global-set-key (kbd "C-c m") #'notmuch)

  (with-eval-after-load 'notmuch
    (setq mm-text-html-renderer 'lynx
          notmuch-hello-hide-tags '("attachment" "replied" "unread")
          notmuch-hello-sections '(notmuch-hello-insert-header
                                   notmuch-hello-insert-saved-searches
                                   notmuch-hello-insert-search
                                   notmuch-hello-insert-alltags
                                   notmuch-hello-insert-footer)
          notmuch-search-oldest-first nil
          notmuch-show-all-tags-list t
          notmuch-show-logo nil
          )

    (setq notmuch-saved-searches
          '(
            (:name "Unread"  :query "tag:unread"                   :key "u")
            (:name "Archive" :query "folder:\"/[^\/]+\/Archive/\"" :key "a")
            (:name "Inbox"   :query "folder:\"/[^\/]+\/Inbox/\""   :key "i")
            (:name "Drafts"  :query "folder:\"/[^\/]*\/Drafts/\""  :key "d")
            (:name "Sent"    :query "folder:\"/[^\/]+\/Sent/\""    :key "s")
            (:name "Spam"    :query "folder:\"/[^\/]+\/Spam/\""    :key "S")
            (:name "Trash"   :query "folder:\"/[^\/]+\/Trash/\""   :key "t")
            )
          )

    (defun vs|notmuch|tree-toggle-deleted ()
      "Toggle 'deleted' tag for message"
      (interactive)
      (notmuch-tree-tag
       (if (member "deleted" (notmuch-tree-get-tags))
           (list "-deleted")
         (list "+deleted")
         )
       )
      )
    (define-key notmuch-tree-mode-map   "d" #'vs|notmuch|tree-toggle-deleted)
    (define-key notmuch-show-mode-map   "d" #'vs|notmuch|tree-toggle-deleted)

    (defun vs|notmuch|search-toggle-deleted ()
      "Toggle 'deleted' tag for message."
      (interactive)
      (notmuch-search-tag
       (if (member "deleted" (notmuch-search-get-tags))
           (list "-deleted")
         (list "+deleted")
         )
       )
      )
    (define-key notmuch-search-mode-map "d" #'vs|notmuch|search-toggle-deleted)

    (defun vs|notmuch|search-toggle-unread ()
      "Toggle 'unread' tag for message."
      (interactive)
      (notmuch-search-tag
       (if (member "unread" (notmuch-search-get-tags))
           (list "-unread")
         (list "+unread")
         )
       )
      )
    (define-key notmuch-search-mode-map (kbd "<tab>") #'vs|notmuch|search-toggle-unread)

    )
  )

(provide 'use-notmuch)
;;; use-notmuch.el ends here
