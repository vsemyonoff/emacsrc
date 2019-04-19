;;; set-xwidget.el ---  XWidget settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(with-eval-after-load 'xwidget
  (define-key xwidget-webkit-mode-map (kbd "<down>") #'xwidget-webkit-scroll-down)
  (define-key xwidget-webkit-mode-map (kbd "<up>")   #'xwidget-webkit-scroll-up)
  (define-key xwidget-webkit-mode-map [mouse-4]      #'xwidget-webkit-scroll-down)
  (define-key xwidget-webkit-mode-map [mouse-5]      #'xwidget-webkit-scroll-up)
  )

(provide 'set-xwidget)
;;; set-xwidget.el ends here
