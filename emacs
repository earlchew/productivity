(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["black" "#d55e00" "#009e73" "#f8ec59" "#0072b2" "#cc79a7" "#56b4e9" "white"])
 '(custom-enabled-themes (quote (wheatgrass)))
 '(show-paren-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;; ****************************************************************************
;;; http://www.emacswiki.org/emacs/IndentingC
;;;
(c-add-style
 "Personal"
 '("ellemtel" (c-basic-offset . 4)))

(add-hook 'c-mode-common-hook
	  '(lambda () (c-set-style "Personal")))

;;; ****************************************************************************
;;; http://www.emacswiki.org/emacs/FrameSize
;;; http://www.emacswiki.org/emacs/FrameModes
;;; http://www.emacswiki.org/emacs/frame-cmds.el
;;; http://www.emacswiki.org/emacs/frame-fns.el
;;;
(load-file "~/Local/emacs/frame-cmds/frame-fns.el")
(load-file "~/Local/emacs/frame-cmds/frame-cmds.el")
(add-to-list 'default-frame-alist '(width . 80))
(maximize-frame-vertically)
(add-to-list 'default-frame-alist (cons 'height (frame-height)))

;;; ****************************************************************************
;;; http://www.masteringemacs.org/articles/2010/10/10/introduction-to-ido-mode/
;;;
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;;; ****************************************************************************
;;; http://www.emacswiki.org/emacs/YesOrNoP
;;;
(defalias 'yes-or-no-p 'y-or-n-p)

;;; ****************************************************************************
;;; http://www.emacswiki.org/emacs/BufferMenu
;;;
(global-set-key (kbd "\C-x\C-b") 'buffer-menu)

;;; ****************************************************************************
;;; http://stackoverflow.com/questions/4096580/how-to-make-emacs-reload-the-tags-file-automatically
;;;
(setq tags-revert-without-query 1)

;;; ****************************************************************************
;;; http://www.gnu.org/software/global/globaldoc.html
;;;
(add-to-list 'load-path "~/Local/global/current")
(eval-after-load "gtags"
  '(progn
     (setq gtags-global-command "~/Local/global/bin/global")))
(setq gtags-suggested-key-mapping t)
(setq gtags-prefix-key "\C-c")
;;(autoload 'gtags-mode "gtags" nil t)
(require 'gtags)
(add-hook 'c-mode-hook '(lambda() (gtags-mode 1)))
(add-hook 'c++-mode-hook '(lambda() (gtags-mode 1)))
(define-key gtags-mode-map "\C-t" nil) ; Recover \C-t
(define-key gtags-mode-map "\C-m" nil) ; Recover \C-m

;;; ****************************************************************************
;;; http://www.emacswiki.org/emacs/ElectricBufferList
;;;
(global-set-key "\C-x\C-b" 'electric-buffer-list)

;;; ****************************************************************************
;;; http://www.emacswiki.org/emacs/CompileCommand
;;;
(global-set-key "\C-cc" 'compile-again)

(setq compilation-last-buffer nil)
(defun compile-again (pfx)
  """Run the same compile as the last time.

If there was no last time, or there is a prefix argument, this acts like
M-x compile.
"""
 (interactive "p")
 (if (and (eq pfx 1)
	  compilation-last-buffer)
     (progn
       (set-buffer compilation-last-buffer)
       (revert-buffer t t))
   (call-interactively 'compile)))

;;; ****************************************************************************
;;; http://www.emacswiki.org/emacs/GotoLine
;;;
(global-set-key "\M-g" 'goto-line)

;;; ****************************************************************************
;;; http://www.emacswiki.org/emacs/ThingAtPoint
;;;
(require 'thingatpt)
(global-set-key [M-right] 'right-word)
(global-set-key [M-left]  'left-word)
(global-set-key [C-right] 'forward-whitespace)
(global-set-key [C-left]  '(lambda() (interactive)
			     (forward-whitespace -1)))

;;; ****************************************************************************
;;; http://www.emacswiki.org/emacs/KillingBuffers
;;; http://www.emacswiki.org/emacs/CleanBufferList
;;;
(require 'midnight)
(setq midnight-period (* 60 60))
(midnight-delay-set 'midnight-delay "0100")

;;; ****************************************************************************
;;; http://lists.gnu.org/archive/html/help-gnu-emacs/2010-01/msg00141.html
;;;
(add-hook 'post-command-hook '(lambda()
				(setq cursor-type (if (eolp) '(bar . 6) t))))

;;; ****************************************************************************
;;; http://www.emacswiki.org/emacs/WhiteSpace
;;; http://stackoverflow.com/questions/6378831/emacs-globally-enable-whitespace-mode
;;; http://stackoverflow.com/questions/7874548/emacs-23-3-1-whitespace-style
;;;
(require 'whitespace)
(setq-default whitespace-line-column 80)
(setq-default whitespace-style
       '( face trailing lines empty space-before-tab::space ))
(global-whitespace-mode 1)

;;; ****************************************************************************
;;; http://www.emacswiki.org/emacs/NoTabs
;;;
(setq-default indent-tabs-mode nil)

;;; ****************************************************************************
;;; http://www.emacswiki.org/emacs/Scrolling
;;; http://www.gnu.org/software/emacs/manual/html_node/emacs/Scrolling.html
;;;
(setq-default scroll-preserve-screen-position t)
