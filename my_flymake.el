
;; ***************************************************************************
;; Flymake
;; ***************************************************************************

(require 'flymake)
(require 'rfringe)


(defun flymake-create-temp-intemp (file-name prefix)
  "Return file name in temporary directory for checking FILE-NAME.
This is a replacement for `flymake-create-temp-inplace'. The
difference is that it gives a file name in
`temporary-file-directory' instead of the same directory as
FILE-NAME.

For the use of PREFIX see that function.

Note that not making the temporary file in another directory
\(like here) will not if the file you are checking depends on
relative paths to other files \(for the type of checks flymake
makes)."
  (unless (stringp file-name)
    (error "Invalid file-name"))
  (or prefix
      (setq prefix "flymake"))
  (let* ((name (concat
		(file-name-nondirectory
		 (file-name-sans-extension file-name))
		"_" prefix))
	 (ext  (concat "." (file-name-extension file-name)))
	 (temp-name (make-temp-file name nil ext)))
    (flymake-log 3 "create-temp-intemp: file=%s temp=%s" file-name temp-name)
    temp-name))


(defun my-flymake-display-err-popup-el-for-current-line ()
  "Display a menu with errors/warnings for current line if it has
errors and/or warnings."
  (interactive)
  (let* ((line-no
	  (flymake-current-line-no))
	 (line-err-info-list
	  (nth 0 (flymake-find-err-info flymake-err-info line-no)))
	 (menu-data
	  (flymake-make-err-menu-data line-no line-err-info-list)))
    (if menu-data
	(popup-tip (mapconcat #'(lambda (e) (nth 0 e))
			      (nth 1 menu-data)
			      "\n")))))


(defadvice flymake-mode (before post-command-stuff activate compile)
  "Add functionality to the post command hook so that if the
cursor is sitting on a flymake error the error information is
showed in a popup."
  (set (make-local-variable 'post-command-hook)
       (cons
	'my-flymake-display-err-popup-el-for-current-line post-command-hook)))


(add-hook 'find-file-hook
	  '(lambda ()
	     (when (locate-dominating-file default-directory "proj.el")
	       (flymake-find-file-hook))))
