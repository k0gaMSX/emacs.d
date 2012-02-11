;;*****************************************************************************
;; Ediff
;;*****************************************************************************

(require 'ediff)

;; Ediff
;; =====
;; When you run Ediff on the Develock'ed buffers, you may feel
;; everything is in confusion.	For such a case, the following hooks
;; may help you see diffs clearly.
;;

(defvar develock-mode-suspended nil)

(add-hook
 'ediff-prepare-buffer-hook
 (lambda nil
   (if (and (boundp 'font-lock-mode) font-lock-mode
	    (boundp 'develock-mode) develock-mode)
       (progn
	 (develock-mode 0)
	 (set (make-local-variable 'develock-mode-suspended) t)))))

(add-hook
 'ediff-cleanup-hook
 (lambda nil
   (let ((buffers (list ediff-buffer-A ediff-buffer-B ediff-buffer-C)))
     (save-excursion
       (while buffers
	 (if (buffer-live-p (car buffers))
	     (progn
	       (set-buffer (car buffers))
	       (if (and (boundp 'develock-mode-suspended)
			develock-mode-suspended)
		   (progn
		     (develock-mode 1)
		     (makunbound 'develock-mode-suspended)))))
	 (setq buffers (cdr buffers)))))))
