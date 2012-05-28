;; ****************************************************************************
;; CEDET configuration.
;; ****************************************************************************



(require 'semantic-load)
(require 'semanticdb-system)
(require 'semantic-gcc)
(require 'semantic-ia)
(require 'ede)
(require 'ede-locate)

(semantic-gcc-setup)
(setq semantic-load-turn-everything-on t)
(semantic-load-enable-excessive-code-helpers)
(semanticdb-load-system-caches)
(global-ede-mode 1)
(global-semantic-idle-completions-mode nil) ;This mode doesn't work very well


(defvar semantic-tags-location-ring (make-ring 20))



(defun semantic-goto-definition (point)
  "Goto definition using semantic-ia-fast-jump
save the pointer marker if tag is found"
  (interactive "d")
  (condition-case err
      (progn
	(ring-insert semantic-tags-location-ring (point-marker))
	(let* ((ctxt (semantic-analyze-current-context point))
	       (pf (and ctxt (reverse (oref ctxt prefix))))
	       (first (car pf)))
	  (if (semantic-tag-p first)
	      (semantic-ia--fast-jump-helper first)
	    (semantic-complete-jump))))
    (error
     ;;if not found remove the tag saved in the ring
     (set-marker (ring-remove semantic-tags-location-ring 0) nil nil)
     (signal (car err) (cdr err)))))


(defun semantic-pop-tag-mark ()
  "popup the tag save by semantic-goto-definition"
  (interactive)
  (if (ring-empty-p semantic-tags-location-ring)
      (message "%s" "No more tags available")
    (let* ((marker (ring-remove semantic-tags-location-ring 0))
	      (buff (marker-buffer marker))
		 (pos (marker-position marker)))
      (if (not buff)
	    (message "Buffer has been deleted")
	(switch-to-buffer buff)
	(goto-char pos)))))

(when (cedet-gnu-global-version-check t)
  (require 'semanticdb-global)
  (add-to-list 'ede-locate-setup-options 'ede-locate-global)
  (semanticdb-enable-gnu-global-databases 'c-mode)
  (semanticdb-enable-gnu-global-databases 'c++-mode))

(when (cedet-cscope-version-check t)
  (require 'semanticdb-cscope)
  (semanticdb-enable-cscope-databases)
  (add-to-list 'ede-locate-setup-options 'ede-locate-cscope))

(when (cedet-idutils-version-check t)
  (add-to-list 'ede-locate-setup-options 'ede-locate-idutils))

(require 'semanticdb-ectag)
(when (semantic-ectag-version)
  (semantic-load-enable-primary-exuberent-ctags-support)
  (semantic-load-enable-secondary-exuberent-ctags-support))

(when (executable-find "locate")
  (add-to-list 'ede-locate-setup-options 'ede-locate-locate))



(global-set-key "\C-\M-x" 'semantic-analyze-proto-impl-toggle)
(global-set-key [(control  <)] 'semantic-goto-definition)
(global-set-key [(control  >)] 'semantic-pop-tag-mark)
