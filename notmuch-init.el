;;; notmuch-init.el --- Notmuch mail user agent configuration. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(require 'notmuch)

(defun vs:notmuch/refresh-complete (&rest _)
  "Refresh all biffers when 'notmuch index' completed."
  (notmuch-refresh-all-buffers)
  )

(defun vs:notmuch/refresh ()
  "Call 'notmuch index' to give a chance for `pre-new' hook."
  (let ((process-connection-type nil))
    (set-process-sentinel
     (start-process "easymail" nil "easymail" "index")
     #'vs:notmuch/refresh-complete
     )
    )
  )
(advice-add 'notmuch-bury-or-kill-this-buffer :after #'vs:notmuch/refresh)

(defun vs:notmuch/before-tag ()
  "Before message tags changed."
  (cond
   ((member "-unread" tag-changes)
    (notmuch-tag query '("+readed"))
    )
   ((member "+unread" tag-changes)
    (notmuch-tag query '("+unreaded"))
    )
   )
  )
(add-hook 'notmuch-before-tag-hook #'vs:notmuch/before-tag)

;; Tree mode
(defun vs:notmuch|tree-toggle-trashed ()
  "Toggle 'trashed' tag for message."
  (interactive)
  (notmuch-tree-tag
   (if (member "trashed" (notmuch-tree-get-tags))
       (list "-trashed")
     (list "+trashed")
     )
   )
  )
(define-key notmuch-tree-mode-map   "d" #'vs:notmuch|tree-toggle-trashed)

(defun vs:notmuch|tree-toggle-unread ()
  "Toggle 'unread' tag for message."
  (interactive)
  (notmuch-tree-tag
   (if (member "unread" (notmuch-tree-get-tags))
       (list "-unread")
     (list "+unread")
     )
   )
  )
(define-key notmuch-search-mode-map (kbd "<tab>") #'vs:notmuch|tree-toggle-unread)

;; Search mode
(defun vs:notmuch|search-toggle-trashed ()
  "Toggle 'trashed' tag for message."
  (interactive)
  (notmuch-search-tag
   (if (member "trashed" (notmuch-search-get-tags))
       (list "-trashed")
     (list "+trashed")
     )
   )
  )
(define-key notmuch-search-mode-map "d" #'vs:notmuch|search-toggle-trashed)

(defun vs:notmuch|search-toggle-unread ()
  "Toggle 'unread' tag for message."
  (interactive)
  (notmuch-search-tag
   (if (member "unread" (notmuch-search-get-tags))
       (list "-unread")
     (list "+unread")
     )
   )
  )
(define-key notmuch-search-mode-map (kbd "<tab>") #'vs:notmuch|search-toggle-unread)

(setq notmuch-address-command         'internal
      notmuch-crypto-process-mime     t
      notmuch-draft-tags              '("+newdraft")
      notmuch-fcc-dirs                nil
      notmuch-hello-hide-tags         '("Archive" "attachment" "Drafts" "draft" "Inbox"
                                        "replied" "Sent" "Spam" "signed" "Trash" "unread")
      notmuch-hello-sections          '(notmuch-hello-insert-header
                                        notmuch-hello-insert-saved-searches
                                        notmuch-hello-insert-search
                                        notmuch-hello-insert-alltags
                                        notmuch-hello-insert-footer)
      notmuch-message-headers-visible nil
      notmuch-mua-cite-function       'message-cite-original-without-signature
      notmuch-search-oldest-first     nil
      notmuch-show-all-tags-list      t
      notmuch-show-logo               nil
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

(provide 'notmuch-init)
;;; notmuch-init.el ends here
