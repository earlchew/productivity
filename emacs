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
     '("ellemtel" (c-basic-offset . 4)
                  (c-offsets-alist . ((member-init-intro . 0)
                                      (case-label        . 0)
                                      (substatement-open . 0)))))
(setq c-default-style
    '((c-mode   . "Personal")
      (c++-mode . "Personal")))

;;; ****************************************************************************
;;; ;;; http://permalink.gmane.org/gmane.emacs.help/65857
;;;
(add-hook 'c-initialization-hook
    '(lambda() (modify-syntax-entry ?_ "w" c-mode-syntax-table)))

;;; ****************************************************************************
;;; https://www.gnu.org/software/emacs/manual/html_node/
;;;    ccmode/Subword-Movement.html
;;; http://fossies.org/linux/misc/emacs-24.3.tar.gz/emacs-24.3/
;;;    lisp/progmodes/subword.el

(add-hook 'c-mode-common-hook
    (lambda () (subword-mode 1)))

(require 'subword)

(setq subword-forward-regexp
    (concat
     "\\(?:"
         "\\(?1:[[:alnum:]]+_+\\)" "\\|"
         "\\(?1:[[:alnum:]]+\\)\\W" "\\|"
         "\\(?1:[[:upper:]]+[[:lower:][:digit:]]*_*\\)"
     "\\)"))

(setq subword-forward-function
    (lambda ()
        (if
            (and
                (save-excursion
                    (let
                        ((case-fold-search nil))
                        (re-search-forward subword-forward-regexp nil t)))
                (> (match-end 0) (point)))
            (goto-char (match-end 1))
            (forward-word 1))))

(setq subword-backward-regexp
    (concat
     "\\(?:"
         "\\(?:\\W\\|_+\\)\\(?1:[[:alnum:]]+\\)" "\\|"
         "\\(?:\\W\\|[[:lower:][:digit:]]+\\)_*"
             "\\(?1:[[:upper:]]+[[:lower:][:digit:]]*_*\\)"
     "\\)"))

(setq subword-backward-function
    (lambda ()
        (if
            (and
                (save-excursion
                    (let ((case-fold-search nil))
                        (re-search-backward subword-backward-regexp nil t)))
                (< (match-beginning 0) (point)))
            (goto-char (match-beginning 1))
            (backward-word 1))))

(defun next-word (&optional arg)
    (interactive "p")
    (let
        (
            (fwd
                (if (bound-and-true-p subword-mode)
                    'subword-forward
                    'forward-word))
            (bwd
                (if (bound-and-true-p subword-mode)
                    'subword-backward
                    'backward-word)))
        (cond
            ((< arg 0) (prev-word (- arg)))
            ((> arg 0)
                (dotimes (iter arg)
                    (let
                        (
                            (here (point)))
                        (funcall fwd)
                        (funcall bwd)
                        (if (= here (point))
                            (progn
                                (funcall fwd 2)
                                (funcall bwd)))))))))

(defun prev-word (&optional arg)
    (interactive "p")
    (let
        (
            (fwd
                (if (bound-and-true-p subword-mode)
                    'subword-forward
                    'forward-word))
            (bwd
                (if (bound-and-true-p subword-mode)
                    'subword-backward
                    'backward-word)))
        (cond
            ((< arg 0) (next-word (- arg)))
            ((> arg 0) (funcall bwd arg)))))

(global-set-key "\M-f" 'next-word)
(global-set-key "\M-b" 'prev-word)

;;; ****************************************************************************
;;; http://www.emacswiki.org/emacs/FrameSize
;;; http://www.emacswiki.org/emacs/FrameModes
;;; http://www.emacswiki.org/emacs/frame-cmds.el
;;; http://www.emacswiki.org/emacs/frame-fns.el
;;;
(when (display-graphic-p)
    (load-file "~/Local/emacs/frame-cmds/frame-fns.el")
    (load-file "~/Local/emacs/frame-cmds/frame-cmds.el")
    (add-to-list 'default-frame-alist '(width . 80))
    (maximize-frame-vertically)
    (set-frame-size (selected-frame) (frame-width) (frame-height))
    (add-to-list 'default-frame-alist (cons 'height (frame-height))))

;;; ****************************************************************************
;;; http://stackoverflow.com/questions/
;;;    3170947/can-i-modify-the-color-of-emacs-mini-buffer
;;;
(when (not (display-graphic-p))
    (set-face-foreground 'minibuffer-prompt "white"))

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
;;; http://stackoverflow.com/questions/
;;;    4096580/how-to-make-emacs-reload-the-tags-file-automatically
;;;
(setq tags-revert-without-query 1)

;;; ****************************************************************************
;;; http://www.gnu.org/software/global/globaldoc.html
;;;
(if (file-exists-p "~/Local/global/bin/global")
  (progn
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
  ))

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
;;; http://stackoverflow.com/questions/7874548/emacs-23-3-1-whitespace-style
;;; http://stackoverflow.com/questions/
;;;    6378831/emacs-globally-enable-whitespace-mode
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

;;; ****************************************************************************
;;; http://www.emacswiki.org/emacs/DeleteSelectionMode
;;;
(delete-selection-mode 1)

;;; ****************************************************************************
;;; http://www.emacswiki.org/emacs/EmacsCrashCode
;;;
(setq confirm-kill-emacs 'yes-or-no-p)

;;; ****************************************************************************
;;; http://www.delorie.com/gnu/docs/emacs/emacs_221.html
;;;
(setq inhibit-eol-conversion t)

;;; ****************************************************************************
;;; http://stackoverflow.com/questions/3124844/
;;;    what-are-your-favorite-global-key-bindings-in-emacs
;;;
(global-set-key   "\M-%"    'query-replace-regexp)
(global-set-key   "\C-s"    'isearch-forward-regexp)
(global-set-key   "\C-r"    'isearch-backward-regexp)
(global-unset-key "\C-\M-s")
(global-unset-key "\C-\M-r")
