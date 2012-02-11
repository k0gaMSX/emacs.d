;; ****************************************************************************
;; ECB
;; ****************************************************************************

(require 'ecb)
(ecb-winman-winring-enable-support)	;Must be called before of requiring
					;winring

(global-set-key [f2] 'ecb-toggle-ecb-windows)
(global-set-key [f3] '(lambda()
			(interactive)
			(iy/winring-jump-or-create "ECB")))
