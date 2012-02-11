
;; ****************************************************************************
;; yasnippet
;; ****************************************************************************

(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/yasnippets/")

;;Modification for allowing flymake and yasnippet runnit at same time


(defvar flymake-is-active-flag nil)

(defadvice yas/expand-snippet
  (before inhibit-flymake-syntax-checking-while-expanding-snippet activate)
  (setq flymake-is-active-flag
	(or flymake-is-active-flag
	    (assoc-default 'flymake-mode (buffer-local-variables))))
  (when flymake-is-active-flag
    (flymake-mode-off)))


(add-hook 'yas/after-exit-snippet-hook
	  '(lambda ()
	     (when flymake-is-active-flag
	       (flymake-mode-on)
	       (setq flymake-is-active-flag nil))))
