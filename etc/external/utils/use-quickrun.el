;;; use-quickrun.el --- evaluate code in buffer. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(if (not (straight-use-package 'quickrun))
    (warn "===> Can't install 'quickrun'")

  (ignore "Config will go here")
  )

(provide 'use-quickrun)
;;; use-quickrun.el ends here
