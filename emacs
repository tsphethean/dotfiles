;;
;; Dan amacs NOT emacs custom settings moved to
;;~/Library/Application Support/Aquamacs Emacs/site-start.el
;;user configs are in /Users/dmayer/Library/Preferences/Aquamacs\ Emacs/
;; for shared emacs/amacs add SETTINGS to this file
;;

;; No backup files!
(setq make-backup-files nil)

;; delete trailing whitespace
;; removed as this is bad when sharing git files and others don't makes code review harder
;;(add-hook 'before-save-hook 'delete-trailing-whitespace)


(setq load-path (append
                 '("/opt/local/share/emacs/site-lisp"
       "/usr/share/emacs/site-lisp"
       "~/.emacs.d/"
      )
                 load-path))

;; textmate bindings for some nicer key combos for common actions
(add-to-list 'load-path "~/.emacs.d/vendor/textmate.el")
(require 'textmate)
(textmate-mode)

;;ruby-test to help with ruby testing
;;check / port ruby-test from work mac, seems to break elsewhere... also move all my ~/.emacs.d files into dotfile or emacs starter project and reference those files...
;;(add-to-list 'load-path "~/.emacs.d/vendor/ruby-test.el")
;;(require 'ruby-test)

;; white space mode
(add-to-list 'load-path "~/.emacs.d/vendor/whitespace.el")
(require 'whitespace)
;;seems a bit to verbose / annoying with colors and $'s at least in my emacs version
;;(add-hook 'ruby-mode-hook 'whitespace-mode)


;; ruby-complexity
;; flog scores for methods http://github.com/topfunky/emacs-starter-kit/tree/master/vendor/ruby-complexity/
;;(add-to-list 'load-path "~/.emacs.d/vendor/ruby-complexity/")

;;ruby complexity
;;(require 'ruby-complexity)
;;(add-hook 'ruby-mode-hook
;;	  (function (lambda ()
;;		      (flymake-mode)
;;		      (linum-mode)
;;		      (ruby-complexity-mode))))
;; end ruby-complexity


;; http://blog.senny.ch/blog/2012/10/06/emacs-tidbits-for-ruby-developers/
;; This defines a way to jump to the rspec file for any class, I want one to jump to test unit files
;;
;; (defun senny-ruby-open-spec-other-buffer ()
;;   (interactive)
;;   (when (featurep 'rspec-mode)
;;     (let ((source-buffer (current-buffer))
;;           (other-buffer (progn
;;                           (rspec-toggle-spec-and-target)
;;                           (current-buffer))))
;;       (switch-to-buffer source-buffer)
;;       (pop-to-buffer other-buffer))))

;; (eval-after-load 'ruby-mode
;;   '(progn
;;      (define-key ruby-mode-map (kbd "C-c , ,") 'senny-ruby-open-spec-other-buffer)))

;; line numbers on the left EVERYWHERE (except ruby mode where flog scores override)
;; how to do both?
(require 'linum)
(global-linum-mode)

;;(add-to-list 'load-path "~/path/to/your/elisp/rinari")
;;(require 'rinari)


;; index selection
;; http://www.emacswiki.org/emacs/IndentingText
;; Another way is to use `C-x TAB´ to indent the region. 
;; This indents the region by one column. Use a numeric prefix argument to change this.
;; Example: `C-u 5 C-x TAB´ to indent by 5. 
;; Remember that C-u by itself is used as multiplication by 4 – thus
;; `C-u C-x TAB´ will indent by 4, and `C-u C-u C-x TAB´ will indent by 16.
;; You can “outdent” the region as well by using a negative prefix: `C-u - 3 C-x TAB´ outdents by 3.

;;sick of typing indent-region bound to C-x \, which in code needs to be escaped as \\
(global-set-key (kbd "C-x \\") 'indent-region)

;; move buffer to other window
;; after c-x 3 to split screen this lets you move buffers between sides.
;; altered code from:
;; http://stackoverflow.com/questions/1774832/how-to-swap-the-buffers-in-2-windows-emacs
(defun swap-buffer-window ()
  "Put the buffer from the selected window in next window, and vice versa"
  (interactive)
  (let* ((this (selected-window))
     (other (next-window))
     (this-buffer (window-buffer this)))
    (set-window-buffer other this-buffer)
    (tabbar-close-tab) ;;close current tab
    (other-window 1) ;;swap cursor to new buffer
    )
  )
 (global-set-key (kbd "C-x /") 'swap-buffer-window)

(setq ruby-insert-encoding-magic-comment nil)

;;auto ruby mode for rake and gemspec files
(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.Rakefile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.irbrc$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.erb$" . nxhtml-mode))

;;js indent level
(setq js-indent-level 2)

;;disable line limit / line wrap
(setq fill-column 380)
(auto-fill-mode -1)
(remove-hook 'text-mode-hook #'turn-on-auto-fill)
(turn-off-auto-fill)
(add-hook 'html-mode-hook 'turn-off-auto-fill)