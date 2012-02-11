
;; ****************************************************************************
;; doxymacs
;; ****************************************************************************


(require 'doxymacs)
(require 'tempo)



(defun my-inside-javadoc-comment ()
  "Return t if the cursor is inside a comment."
  (let* ((last (point))
	 (is-inside
	  (if (search-backward "*/" nil t)
	      ;; there are some comment endings - search forward
	      (if (search-forward "/**" last t)
		  't
		'nil)

	    ;; it's the only comment - search backward
	    (goto-char last)
	    (if (search-backward "/**" nil t)
		't
	      'nil))))
    (goto-char last)
    is-inside))



(defun my-doxymacs-font-lock-hook ()
  (if (or (eq major-mode 'c-mode)
	  (eq major-mode 'c++-mode))
      (doxymacs-font-lock)))

(add-hook 'font-lock-mode-hook 'my-doxymacs-font-lock-hook)
