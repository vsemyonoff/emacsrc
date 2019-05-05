;;; easymail-init.el --- Notmuch mail user agent configuration. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(require 'notmuch)

(setq notmuch-hello-hide-tags '("Archive" "attachment" "Drafts" "Inbox" "replied" "Sent" "Spam" "Trash" "unread")
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
        (:name "Drafts"  :query "folder:\"/[^\/]*\/Drafts/\""  :key "d")
        (:name "Inbox"   :query "folder:\"/[^\/]+\/Inbox/\""   :key "i")
        (:name "Sent"    :query "folder:\"/[^\/]+\/Sent/\""    :key "s")
        (:name "Spam"    :query "folder:\"/[^\/]+\/Spam/\""    :key "S")
        (:name "Trash"   :query "folder:\"/[^\/]+\/Trash/\""   :key "t")
        )
      )

(defun vs|easymail/refresh-complete (&rest _)
  "Refresh all biffers when 'easymail index' completed."
   (notmuch-refresh-all-buffers)
  )

(defun vs|easymail/refresh ()
 "Call 'easymail index' to give a chance for `pre-new' hook."
 (let ((process-connection-type nil))
   (set-process-sentinel
    (start-process "easymail" nil "easymail" "index")
    #'vs|easymail/refresh-complete
    )
   )
 )

(advice-add 'notmuch-bury-or-kill-this-buffer :after #'vs|easymail/refresh)

;; Tree mode
(defun vs|easymail|tree-toggle-trashed ()
  "Toggle 'trashed' tag for message."
  (interactive)
  (notmuch-tree-tag
   (if (member "trashed" (notmuch-tree-get-tags))
       (list "-trashed")
     (list "+trashed")
     )
   )
  )

(define-key notmuch-tree-mode-map   "d" #'vs|easymail|tree-toggle-trashed)

(defun vs|easymail|tree-toggle-unread ()
  "Toggle 'unread' tag for message."
  (interactive)
  (notmuch-tree-tag
   (if (member "unread" (notmuch-tree-get-tags))
       (list "-unread" "+readed")
     (list "+unread" "-readed")
     )
   )
  )

(define-key notmuch-search-mode-map (kbd "<tab>") #'vs|easymail|tree-toggle-unread)

;; Search mode
(defun vs|easymail|search-toggle-trashed ()
  "Toggle 'trashed' tag for message."
  (interactive)
  (notmuch-search-tag
   (if (member "trashed" (notmuch-search-get-tags))
       (list "-trashed")
     (list "+trashed")
     )
   )
  )

(define-key notmuch-search-mode-map "d" #'vs|easymail|search-toggle-trashed)

(defun vs|easymail|search-toggle-unread ()
  "Toggle 'unread' tag for message."
  (interactive)
  (notmuch-search-tag
   (if (member "unread" (notmuch-search-get-tags))
       (list "-unread" "+readed")
     (list "+unread" "-readed")
     )
   )
  )

(define-key notmuch-search-mode-map (kbd "<tab>") #'vs|easymail|search-toggle-unread)

(provide 'easymail-init)
;;; easymail-init.el ends here
