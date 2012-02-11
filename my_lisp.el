;; ****************************************************************************
;; Lisp
;; ****************************************************************************

(require 'compile)
(require 'bytecomp)


(global-set-key "\C-ci"
		'(lambda nil
		   (interactive)
		   (find-file "~/.emacs.d/init.el")))

(add-hook 'after-save-hook
	  '(lambda nil
	     (if (or (string= (buffer-file-name)
			      (expand-file-name
			       (concat default-directory ".emacs")))
		     (string= (buffer-file-name)
			      (expand-file-name
			       (concat default-directory "init.el"))))
		 (byte-compile-file (buffer-file-name)))))


(add-hook 'emacs-lisp-mode-hook
	  (lambda ()
	    (local-set-key [(return ) ] 'newline-and-indent)
	    (eldoc-mode)
	    (auto-fill-mode t)))
