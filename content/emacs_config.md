+++
title = "Emacs Configuration"
date = 2022-02-10T00:00:00-06:00
tags = ["Emacs"]
draft = false
+++

## Meta {#meta}

Information related to this document.


### why Emacs {#why-emacs}

Personally for me I like Emacs due to it being a integrated computing environment that is very malleable and discoverable.

-   [5 things i appreciate about emacs](https://www.johndcook.com/blog/2020/04/28/working-locally/)
-   <https://ryanfaulhaber.com/posts/try-emacs/>
-   [memory usage](http://ergoemacs.org/misc/i/emacs_vs_vscode_memory_2020-11-18.png?utm_source=feedburner&utm_medium=feed&utm_campaign=Feed%3A+XahsEmacsBlog+%28Xah%27s+Emacs+Blog%29)
-   <http://stormrider.io/ninety-pct.html>
-   <https://www.youtube.com/watch?v=bEfYm8sAaQg>
-   <https://www.youtube.com/watch?v=fgizHHd7nOo>
-   [r/emacs comment](https://www.reddit.com/r/emacs/comments/l22dmh/i_use_emacs_for_just/?sort=new)
-   <https://hongchao.me/cli-and-emacs/>


### Version {#version}

I am running `GNU Emacs 29.0.50 (build 1, x86_64-pc-linux-gnu, GTK+ Version 3.24.24, cairo version 1.16.0) of 2022-02-01`. You can get this by compiling Emacs from master. Some guides on this from [Batsov](https://batsov.com/articles/2021/12/19/building-emacs-from-source-with-pgtk/) and [Xah Lee](http://xahlee.info/emacs/emacs/building_emacs_from_git_repository.html) (notes these are Debian specific but should work for most distros with some modifications). If you are using nixOS use the [Emacs overlay](https://github.com/nix-community/emacs-overlay), on Mac use [Emacs Plus](https://github.com/d12frosted/homebrew-emacs-plus). I think on Guix their is Emacs Next?

Other then getting the most usable Emacs you also have access to Emacs internals which is useful in understanding the whole system.


### why make it literate? {#why-make-it-literate}

-   selfish:
    -   I want to be able to collects notes on Emacs in the same file that
        I configure it (making it easier to learn it in the end)
    -   I find it easier to work with one file
    -   if I abandon / take a long hiatus. I will have history to go back to.
    -   it is integrated with all my notes.
    -   I find the outlining of org-mode to be superior to that of outline-minor-mode (add with the added benefit of org-speed-mode!).
-   altruistic:
    -   I want to be helpful to other people who are going to configure Emacs. How should they structure it? What should they include? What makes life easier and more enjoyable?


### style guide {#style-guide}

style guide for the actual Org-mode file.

-   no `adapt-indentation`, I am not a fan of indentation.
-   yes `visual-line-mode`, maks handling links easier.
-   blank lines are good. It makes the content easier to digest and provides consistency.


### On learning Emacs {#on-learning-emacs}

1.  C-h t [tutorial]: To learn the basics of movement
2.  C-h i [info] or C-h r [read]: To understand the Emacs environment
3.  when it comes to writing Emacs Lisp and configuring:
    1.  C-h f [functions] and v [variable]: To find documentation.
    2.  C-h a [apropos] to find anything
4.  C-h m [mode] To understand a particular mode (e.g org-mode, emacs-lisp-mode, elfeed-show-entry)

Keep the menu-bar, use customize [Atleast for fonts and themes].


### Issues {#issues}


#### <span class="org-todo done CLOSED">CLOSED</span> tab bar issues (not displaying) {#tab-bar-issues--not-displaying}

-   State "CLOSED"     from "OPEN"       <span class="timestamp-wrapper"><span class="timestamp">[2022-02-10 Thu 11:00]</span></span>

I disabled my heavy modifications on it. Everything works fine.


#### <span class="org-todo done CLOSED">CLOSED</span> emacsql binary {#emacsql-binary}

-   State "CLOSED"     from "OPEN"       <span class="timestamp-wrapper"><span class="timestamp">[2022-02-10 Thu 04:10]</span></span>

I manually specified the emacsql and emacsqlite packages. I also ran `org-roam-db-sync` immediately. It compiled and everything worked.


## Core {#core}


### package management using straight {#package-management-using-straight}

straight.el allows installation from non-packaged git repositories. This allows you to download more code and makes it easier to contribute. The codebase is heavily documented and modern. I am a big fan of straight.el.&nbsp;[^fn:1]

```emacs-lisp
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
	(url-retrieve-synchronously
	 "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
	 'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(setq package-enable-at-startup nil)
(setq straight-repository-branch "develop")
```


### use-package {#use-package}

use-package allows for more declarative configuration. It makes it easy to encapsulate everything.

```emacs-lisp
(straight-use-package 'use-package)
(defvar straight-use-package-by-default)
(setq straight-use-package-by-default t)
```


### general.el {#general-dot-el}

Status: uncertain

General is used to ease configuration of key bindings. Currently only easing it to ease up setting up configuration on some global commands.

```emacs-lisp
(use-package general
  :straight t
  :config
  (global-unset-key (kbd "M-SPC"))
  (general-create-definer pxoq-vc
    :prefix "C-x v")
  (general-create-definer pxoq-roam
    :prefix "C-c n"))
```


### defaults {#defaults}

this `:init` part is not optimal for beginners. I recommend you keep them when your starting. My choice is that I don't need them  anymore and I don't find it aesthetic. However the `:custom` part you should add. You expect editors to wrap lines, be able to jump between sentences, not bleep at you etc.

```emacs-lisp
(use-package emacs
  :init
  (tool-bar-mode -1)
  (menu-bar-mode -1)
  (toggle-scroll-bar -1)
  :custom
  (global-auto-revert-mode t)
  (global-visual-line-mode 1)
  (sentence-end-double-space nil)
  (auto-save-default nil)
  (ring-bell-function (quote ignore))
  (use-short-answers)
  (initial-buffer-choice t)
  (make-backup-files nil)
  :config
  (defun my-fill-or-unfill ()
    "Like `fill-paragraph', but unfill if used twice."
    (interactive)
    (let ((fill-column
	   (if (eq last-command 'my-fill-or-unfill)
	       (progn (setq this-command nil)
		      (point-max))
	     fill-column)))
      (call-interactively 'fill-paragraph nil (vector nil t))))
  (load-theme 'modus-operandi t)
  (add-to-list 'load-path "~/.emacs.d/dotfiles/emacs/.emacs.d/prot-lisp")
  (put 'dired-find-alternate-file 'disabled nil)
  (put 'overwrite-mode 'disabled t)
  (recentf-mode 1)
  (setq recentf-max-menu-items 25)
  :bind (("M-q" . my-fill-or-unfill)))
```


### customize (for appearance) {#customize--for-appearance}

Customize provides a graphical interface to change Emacs Variables. I find it very useful when it comes to font and appearance related things (`face` in Emacs parlance), I only use it for that.

In regards to what Font I use. I use IBM Plex family since its available in most package managers. I use IBM Plex Mono in general. I use IBM Plex Sans as my variable-width font, which I use for reading articles (EWW, Elfeed).

```emacs-lisp
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file 'noerror)
```


### crux {#crux}

Crux provides a slew of useful interactive functions for Emacs. Basically it is a better defaults package. Note I have barely used it.

```emacs-lisp
(use-package crux
  :straight t)
```


### repeat {#repeat}

Available by default in Emacs 28+. You save keyclicks. This makes the window management commands (like `C-x o` or `C-x {`) way easier to use. You don't have to click that key sequence every single time.

```emacs-lisp
(use-package repeat
  :straight nil
  :custom
  (repeat-on-final-keystroke t)
  (set-mark-command-repeat-pop t)
  :config
  (repeat-mode 1))
```


### completion {#completion}

Completion is a huge topic in Emacs. There are numerous options and combinations:

-   helm
-   ivy
-   mct
-   vertico
-   selectrum
-   consult
-   orderless
-   marginalia
-   fido (and fido-vertical)
-   ido

Sorry for overwhelming. I personally settled on the most flexible and versatile solution. I rely on extensions that rely on the default Emacs Completion API (`completing-read`). So Marginalia, orderless, vertico (with extensions) and consult.

Completion is one of the main ways we interact with Emacs. So its important to sort this out first.

```emacs-lisp
(use-package orderless
  :straight t
  :init
  ;; Configure a custom style dispatcher (see the Consult wiki)
  ;; (setq orderless-style-dispatchers '(+orderless-dispatch))
  (setq completion-styles '(orderless)
	completion-category-defaults nil
	completion-category-overrides '((file (styles . (partial-completion))))))

;; gives you useful information on the side
(use-package marginalia
  :straight t
  :config
  (marginalia-mode))

(straight-use-package '( vertico :files (:defaults "extensions/*")
				 :includes (vertico-buffer
					     vertico-directory
					     vertico-flat
					     vertico-indexed
					     vertico-mouse
					     vertico-quick
					     vertico-repeat
					     vertico-reverse)))

(use-package vertico
  :straight t
  :init
  (vertico-mode)
  :custom
  (vertico-cycle t)
  :config
  ;; (provide vertico-directory)
  (define-key vertico-map (kbd "C-j") 'vertico-directory-enter)
  (define-key vertico-map (kbd "C-l") 'vertico-directory-up))

(use-package consult
  :straight t
  ;; Replace bindings. Lazily loaded due by `use-package'.
  :bind (;; C-c bindings (mode-specific-map)
	 ;;         ("C-c m" . consult-mode-command)
	 ("C-c b" . consult-bookmark)
	 ("C-x r b" . consult-bookmark)
	 ("C-c k" . consult-kmacro)
	 ;; C-x bindings (ctl-x-map)
	 ("C-x M-:" . consult-complex-command)     ;; orig. repeat-complex-command
	 ("C-x b" . consult-buffer)                ;; orig. switch-to-buffer
	 ("C-x 4 b" . consult-buffer-other-window) ;; orig. switch-to-buffer-other-window
	 ("C-x 5 b" . consult-buffer-other-frame)  ;; orig. switch-to-buffer-other-frame
	 ;; Custom M-# bindings for fast register access
	 ("M-#" . consult-register-load)
	 ("M-'" . consult-register-store)          ;; orig. abbrev-prefix-mark (unrelated)
	 ("C-M-#" . consult-register)
	 ;; Other custom bindings
	 ("C-c C-r" . consult-recent-file)
	 ("M-y" . consult-yank-pop)                ;; orig. yank-pop
	 ("<help> a" . consult-apropos)            ;; orig. apropos-command
	 ;; M-g bindings (goto-map)
	 ("M-g e" . consult-compile-error)
	 ("M-g f" . consult-flymake)               ;; Alternative: consult-flycheck
	 ("M-g g" . consult-goto-line)             ;; orig. goto-line
	 ("M-g M-g" . consult-goto-line)           ;; orig. goto-line
	 ("M-g o" . consult-outline)               ;; Alternative: consult-org-heading
	 ("M-g m" . consult-mark)
	 ("M-g k" . consult-global-mark)
	 ("M-g i" . consult-imenu)
	 ("M-g I" . consult-imenu-multi)
	 ;; M-s bindings (search-map)
	 ("M-s f" . consult-find)
	 ("M-s F" . consult-locate)
	 ("M-s g" . consult-grep)
	 ("M-s G" . consult-git-grep)
	 ("M-s r" . consult-ripgrep)
	 ("M-s l" . consult-line)
	 ("M-s L" . consult-line-multi)
	 ("M-s m" . consult-multi-occur)
	 ("M-s k" . consult-keep-lines)
	 ("M-s u" . consult-focus-lines)
	 ;; Isearch integration
	 ("M-s e" . consult-isearch)
	 :map isearch-mode-map
	 ("M-e" . consult-isearch)                 ;; orig. isearch-edit-string
	 ("M-s e" . consult-isearch)               ;; orig. isearch-edit-string
	 ("M-s l" . consult-line)                  ;; needed by consult-line to detect isearch
	 ("M-s L" . consult-line-multi))           ;; needed by consult-line to detect isearch

  ;; Enable automatic preview at point in the *Completions* buffer.
  ;; This is relevant when you use the default completion UI,
  ;; and not necessary for Vertico, Selectrum, etc.
  :hook (completion-list-mode . consult-preview-at-point-mode)

  ;; The :init configuration is always executed (Not lazy)
  :init

  ;; Optionally configure the register formatting. This improves the register
  ;; preview for `consult-register', `consult-register-load',
  ;; `consult-register-store' and the Emacs built-ins.
  (setq register-preview-delay 0
	register-preview-function #'consult-register-format)

  ;; Optionally tweak the register preview window.
  ;; This adds thin lines, sorting and hides the mode line of the window.
  (advice-add #'register-preview :override #'consult-register-window)

  ;; Optionally replace `completing-read-multiple' with an enhanced version.
  (advice-add #'completing-read-multiple :override #'consult-completing-read-multiple)

  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
	xref-show-definitions-function #'consult-xref)

  ;; Configure other variables and modes in the :config section,
  ;; after lazily loading the package.
  :config

  ;; Optionally configure preview. The default value
  ;; is 'any, such that any key triggers the preview.
  ;; (setq consult-preview-key 'any)
  ;; (setq consult-preview-key (kbd "M-."))
  ;; (setq consult-preview-key (list (kbd "<S-down>") (kbd "<S-up>")))
  ;; For some commands and buffer sources it is useful to configure the
  ;; :preview-key on a per-command basis using the `consult-customize' macro.
  (consult-customize
   consult-theme
   :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep
   consult-bookmark consult-recent-file consult-xref
   consult--source-file consult--source-project-file consult--source-bookmark
   :preview-key (kbd "M-."))

  ;; Optionally configure the narrowing key.
  ;; Both < and C-+ work reasonably well.
  (setq consult-narrow-key "<") ;; (kbd "C-+")

  ;; Optionally make narrowing help available in the minibuffer.
  ;; You may want to use `embark-prefix-help-command' or which-key instead.
  ;; (define-key consult-narrow-map (vconcat consult-narrow-key "?") #'consult-narrow-help)

  ;; Optionally configure a function which returns the project root directory.
  ;; There are multiple reasonable alternatives to chose from.
  ;;;; 1. project.el (project-roots)
  (setq consult-project-root-function
	(lambda ()
	  (when-let (project (project-current))
	    (car (project-roots project)))))
  ;;;; 2. projectile.el (projectile-project-root)
  ;; (autoload 'projectile-project-root "projectile")
  ;; (setq consult-project-root-function #'projectile-project-root)
  ;;;; 3. vc.el (vc-root-dir)
  ;; (setq consult-project-root-function #'vc-root-dir)
  ;;;; 4. locate-dominating-file
  ;; (setq consult-project-root-function (lambda () (locate-dominating-file "." ".git")))
  )
```


### additional themes {#additional-themes}

Overall you should use `modus-themes` (which is built-in since Emacs 28) since it supports the most modes that I've seen out of any theme. But you get bored with things eventually.

```emacs-lisp
(use-package zenburn-theme
  :straight t)

(use-package doom-themes
  :straight t)

;; Error (use-package): Cannot load spacemacs-theme
;; (use-package spacemacs-
;;   :straight t)
```


### window management {#window-management}

Windmove allows to hit the keyboard arrow to a direction you jump to it. Unfortunatly it conflicts with org-mode but I give windmove more importance so I disable those org shortcuts and call those org-mode functions manually.

```emacs-lisp
(use-package windmove
  :straight nil
  :config
  (windmove-default-keybindings)
  (add-hook 'org-shiftup-final-hook 'windmove-up)
  (add-hook 'org-shiftleft-final-hook 'windmove-left)
  (add-hook 'org-shiftdown-final-hook 'windmove-down)
  (add-hook 'org-shiftright-final-hook 'windmove-right))
```


### embark {#embark}

Provides the equivalent of a right click context menu.

```emacs-lisp
(use-package embark
  :straight t
  :bind
  (("C-." . embark-act)         ;; pick some comfortable binding
   ("C-;" . embark-dwim)        ;; good alternative: M-.
   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'
  :init
  ;; Optionally replace the key help with a completing-read interface
  (setq prefix-help-command #'embark-prefix-help-command)
  :config
  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
	       '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
		 nil
		 (window-parameters (mode-line-format . none)))))
```


### search {#search}

isearch is powerful and you should use it. These add extensions that slightly change the behavior like showing the number.

```emacs-lisp
(use-package prot-search
  :straight nil
  :load-path "~/.emacs.d/dotfiles/emacs/.emacs.d/prot-lisp/")

(use-package isearch
  :straight nil
  :custom
  (search-highlight t)
  (search-whitespace-regexp ".*?")
  (isearch-lax-whitespace t)
  (isearch-regexp-lax-whitespace nil)
  (isearch-lazy-highlight t)
  ;; All of the following variables were introduced in Emacs 27.1.
  (isearch-lazy-count t)
  (lazy-count-prefix-format nil)
  (lazy-count-suffix-format " (%s/%s)")
  (isearch-yank-on-move 'shift)
  (isearch-allow-scroll 'unlimited)
  ;; These variables are from Emacs 28
  (isearch-repeat-on-direction-change t)
  (lazy-highlight-initial-delay 0.5)
  (lazy-highlight-no-delay-length 3)
  (isearch-wrap-pause t)
  :bind (:map isearch-mode-map
	      ("C-g" . isearch-cancel)
	      ("M-/" . isearch-complete)))
```


### project based management {#project-based-management}

Projectile has more features then project.el.

```emacs-lisp
(use-package projectile
  :straight t
  :init
  (setq projectile-project-search-path '("~/projects/" "~/.emacs.d/straight/repos/"))
  :config
  ;; I typically use this keymap prefix on macOS
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  ;; On Linux, however, I usually go with another one
  ;; (define-key projectile-mode-map (kbd "C-c C-p") 'projectile-command-map)
  (global-set-key (kbd "C-c p") 'projectile-command-map)
  (projectile-mode +1))
```


## Uses {#uses}


### Templates {#templates}

Yas-snippets provide programmable multi-line snippets. This is something that is not available by default in VS Code.

```emacs-lisp
(use-package yasnippet
  :straight t
  :hook
  (after-init . yas-global-mode))
```


### Text operations {#text-operations}


#### move text {#move-text}

Status: uncertain

Some more convience. This is standard behvaior across many text behvaiors and I haven't seen anything wrong with ti.

```emacs-lisp
(use-package move-text
  :straight nil
  :straight t
  :bind
  (([(meta shift up)] . move-text-up)
   ([(meta shift down)] . move-text-down)))
```


### In line text completion {#in-line-text-completion}

Status: Uncertain

The defaults that do not show a overlay are `dabbrev` and `hippie-expand`.

Corfu and Company are the overlay showing text completions. An explantion and pontential benefit of Corfu:

> Corfu’s package is one .el file at 1220 lines of code and comments. Whereas Company’s package is many .el files, the company.el file alone is 3916 lines of code and comments.
>
> That’s not to say that that is intrinsically bad, but Corfu’s narrow focus and adherence to the Emacs API means that the long-term maintenance of Corfu is likely easier.
>
> But that is somewhat ideological. I primarily write Ruby on Rails software; a gigantic code-base. So as with all things ideological, I look towards pragmatism.
>
> The actual “killer” feature of Corfu, which I’m sure I could implement in Company, is the export the popup completion candidates to the mini-buffer. - [fniessen](https://takeonrules.com/2022/01/17/switching-from-company-to-corfu-for-emacs-completion/)

```emacs-lisp
(use-package dabbrev
  ;; Swap M-/ and C-M-/
  :straight nil
  :bind (("M-/" . dabbrev-completion)
	 ("C-M-/" . dabbrev-expand)))

(use-package corfu
  :straight t
  ;; Optional customizations
  :custom
  ;; (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  (corfu-auto t)                 ;; Enable auto completion
  ;; (corfu-commit-predicate nil)   ;; Do not commit selected candidates on next input
  ;; (corfu-quit-at-boundary t)     ;; Automatically quit at word boundary
  ;; (corfu-quit-no-match t)        ;; Automatically quit if there is no match
  ;; (corfu-echo-documentation nil) ;; Do not show documentation in the echo area

  ;; Optionally use TAB for cycling, default is `corfu-complete'.
  ;; :bind (:map corfu-map
  ;;        ("TAB" . corfu-next)
  ;;        ([tab] . corfu-next)
  ;;        ("S-TAB" . corfu-previous)
  ;;        ([backtab] . corfu-previous))

  ;; You may want to enable Corfu only for certain modes.
  :hook ((prog-mode . corfu-mode)
	 (shell-mode . corfu-mode)
	 (eshell-mode . corfu-mode))
  ;; Recommended: Enable Corfu globally.
  ;; This is recommended since dabbrev can be used globally (M-/).
  :init
  (corfu-global-mode))
```


### Avy {#avy}

See the article [Avy Can Do Anything](https://karthinks.com/software/avy-can-do-anything/) which demonstrates the power of Avy. Most of the code here is adapted from that article.

I still rarely use it but it is really nice to have.

```emacs-lisp
(use-package avy
  :straight t
  :custom
  (avy-keys '(?q ?e ?r ?u ?o ?p
		    ?a ?s ?d ?f ?g ?h ?j
		    ?k ?l ?' ?x ?c ?v ?b
		    ?n ?, ?/))
  :config
  (defun avy-show-dispatch-help ()
    (let* ((len (length "avy-action-"))
	   (fw (frame-width))
	   (raw-strings (mapcar
			 (lambda (x)
			   (format "%2s: %-19s"
				   (propertize
				    (char-to-string (car x))
				    'face 'aw-key-face)
				   (substring (symbol-name (cdr x)) len)))
			 avy-dispatch-alist))
	   (max-len (1+ (apply #'max (mapcar #'length raw-strings))))
	   (strings-len (length raw-strings))
	   (per-row (floor fw max-len))
	   display-strings)
      (cl-loop for string in raw-strings
	       for N from 1 to strings-len do
	       (push (concat string " ") display-strings)
	       (when (= (mod N per-row) 0) (push "\n" display-strings)))
      (message "%s" (apply #'concat (nreverse display-strings)))))
  (global-set-key (kbd "M-j") 'avy-goto-char-timer)
  (defun avy-action-kill-whole-line (pt)
    (save-excursion
      (goto-char pt)
      (kill-whole-line))
    (select-window
     (cdr
      (ring-ref avy-ring 0)))
    t)
  ;; Copy text
  (defun avy-action-copy-whole-line (pt)
    (save-excursion
      (goto-char pt)
      (cl-destructuring-bind (start . end)
	  (bounds-of-thing-at-point 'line)
	(copy-region-as-kill start end)))
    (select-window
     (cdr
      (ring-ref avy-ring 0)))
    t)
  ;; Yank text
  (defun avy-action-yank-whole-line (pt)
    (avy-action-copy-whole-line pt)
    (save-excursion (yank))
    t)

  ;; Transpose/Move text
  (defun avy-action-teleport-whole-line (pt)
    (avy-action-kill-whole-line pt)
    (save-excursion (yank)) t)

  ;; Mark text
  (defun avy-action-mark-to-char (pt)
    (activate-mark)
    (goto-char pt))

  ;; Flyspell words
  (defun avy-action-flyspell (pt)
    (save-excursion
      (goto-char pt)
      (when (require 'flyspell nil t)
	(flyspell-auto-correct-word)))
    (select-window
     (cdr (ring-ref avy-ring 0)))
    t)

  ;; Bind to semicolon (flyspell uses C-;)
  (setf (alist-get ?\; avy-dispatch-alist) 'avy-action-flyspell)
  (setf (alist-get ?w avy-dispatch-alist) 'avy-action-copy
	(alist-get ?W avy-dispatch-alist) 'avy-action-copy-whole-line)
  (setf (alist-get ?  avy-dispatch-alist) 'avy-action-mark-to-char)
  (setf (alist-get ?t avy-dispatch-alist) 'avy-action-teleport
	(alist-get ?T avy-dispatch-alist) 'avy-action-teleport-whole-line)
  (setf (alist-get ?K avy-dispatch-alist) 'avy-action-kill-whole-line)
  (setf (alist-get ?y avy-dispatch-alist) 'avy-action-yank
	(alist-get ?Y avy-dispatch-alist) 'avy-action-yank-whole-line))
```


### Writing {#writing}


#### spellcheck {#spellcheck}

Recomplete is the best solution I have found. The first guess is nearly always the correct one.

```emacs-lisp
(use-package recomplete
  :straight t
  :bind (("M-p" . recomplete-ispell-word)
	 ("M-P" . (lambda ()
		    (interactive)
		    (let ((current-prefix-arg '(-1)))
		      (call-interactively 'recomplete-ispell-word))))))
```


#### org {#org}

I use Org Mode as my prefererd mark up medium. I find it extremly capabale and a lot more natural to use then markdown.

```emacs-lisp
(use-package org
  :straight t
  :bind (("C-c c" . org-capture))
  ;; :hook ((org-mode . visual-line-mode))
  :custom
  (org-goto-interface 'outline-path-completionp)
  (org-outline-path-complete-in-steps nil)
  (org-confirm-babel-evaluate nil)
  (org-cycle-separator-lines 0)
  (org-descriptive-links t)
  (org-edit-src-content-indentation 0)
  (org-edit-src-persistent-message nil)
  (org-fontify-done-headline t)
  (org-fontify-quote-and-verse-blocks t)
  (org-return-follows-link t)
  (org-src-tab-acts-natively t)
  (org-src-window-setup 'current-window)
  (org-startup-folded 'nil)
  (org-startup-truncated nil)
  (org-support-shift-select 'always)
  (org-ellipsis "⋯")
  (org-use-speed-commands t)
  (inhibit-compacting-font-caches t) ; might help preformance?
  (org-adapt-indentation nil) ; this is now nil in current org-mode but I usually like it.
  (org-capture-templates
   ;; Need to revamp edit with Emacs. Make it overall smarter (and maybe integrate with VC!)
   '(("e" "Edit with Emacs" entry (file+olp+datetree "~/writings/private/cpb.org") "* %U\n%i\n\n" :immediate-finish t)
     ("j" "Journal" entry (file+olp+datetree "~/writings/private/cpb.org") "* %? :journal:\n")))
  (org-special-ctrl-k t))
```


#### roam {#roam}

Status: uncertain

I use both regular large org-files and org-roam. Ive decided that both are great. large org-files I use for collecting notes on everything and org-roam for specialized, idea driven, production driven notes (on technology and programming).

See how [JethroKuan](https://jethrokuan.github.io/org-roam-guide/) the creator uses it.

```emacs-lisp
;; (use-package org-roam
;;   :straight t
;;   :init
;;   (setq org-roam-v2-ack t)
;;   :custom
;;   (org-roam-directory "~/writings/roamNotes")
;;   (org-roam-completion-everywhere t)
;;   (setq org-roam-capture-templates
;;       '(("m" "main" plain
;;          "%?"
;;          :if-new (file+head "main/${slug}.org"
;;                             "#+title: ${title}\n")
;;          :immediate-finish t
;;          :unnarrowed t)

;; ("t" "tag" plain
;;          "%?"
;;          :if-new (file+head "${slug}/_index.org"
;;                             "#+title: ${title}\n")
;;          :immediate-finish t
;;          :unnarrowed t)


	;; ("r" "reference" plain "%?"
	;;  :if-new
	;;  (file+head "reference/${title}.org" "#+title: ${title}\n")
	;;  :immediate-finish t
	;;  :unnarrowed t)
;;         ("a" "article" plain "%?"
;;          :if-new
;;          (file+head "articles/${title}.org" "#+title: ${title}\n#+filetags: :article:\n")
;;          :immediate-finish t
;;          :unnarrowed t)))
;;   :bind (("C-c n l" . org-roam-buffer-toggle)
;;          ("C-c n f" . org-roam-node-find)
;;          ("C-c n i" . org-roam-node-insert)
;; 	 ("C-c n I" . org-roam-node-insert-immediate)
;; 	 ("C-c n p" . my/org-roam-find-project)
;; 	 ("C-c n b" . my/org-roam-capture-inbox)
;;          :map org-mode-map
;;          ("C-M-i" . completion-at-point)
;;          :map org-roam-dailies-map
;;          ("Y" . org-roam-dailies-capture-yesterday)
;;          ("T" . org-roam-dailies-capture-tomorrow))
;;   :config
;;   (require 'org-roam-dailies) ;; Straight the keymap is available
;;   (org-roam-db-autosync-mode))

;; (use-package org-roam
;;   :ensure t
;;   :init
;;   (setq org-roam-v2-ack t)
;;   :custom
;;   (org-roam-directory "~/writings/roamNotes")
;;   (org-roam-completion-everywhere t)
;;   (org-roam-capture-templates
;;    '(
;;      ("l" "programming language" plain
;;  "* Characteristics\n\n- Family: %?\n- Inspired by: \n\n* Reference:\n\n"
;;  :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
;;  :unnarrowed t)
;;      ("m" "main" plain
;;          "%?"
;;          :if-new (file+head "main/${slug}.org"
;;                             "#+title: ${title}\n")
;;          :immediate-finish t
;;          :unnarrowed t)
;;      ("r" "reference" plain "%?"
;;       :if-new
;;       (file+head "reference/${title}.org" "#+title: ${title}\n")
;;       :immediate-finish t
;;       :unnarrowed t)
;;      ))
;;   :bind (("C-c n l" . org-roam-buffer-toggle)
;;          ("C-c n f" . org-roam-node-find)
;;          ("C-c n i" . org-roam-node-insert)
;;          :map org-mode-map
;;          ("C-M-i" . completion-at-point))
;;   :config
;;   (org-roam-setup))

(defun bms/org-roam-rg-search ()
  "Search org-roam directory using consult-ripgrep. With live-preview."
  (interactive)
  (let ((consult-ripgrep-command "rg --null --ignore-case --type org --line-buffered --color=always --max-columns=500 --no-heading --line-number . -e ARG OPTS"))
    (consult-ripgrep org-roam-directory)))
(global-set-key (kbd "C-c rr") 'bms/org-roam-rg-search)



  (setq org-roam-capture-templates
      '(("m" "main" plain
	 "%?"
	 :if-new (file+head "main/${slug}.org"
			    "#+title: ${title}\n#+date:%T\n#+STARTUP: overview\n#+hugo_base_dir: /home/jane/projects/test-website/\n#+hugo_section: ./\n")
	 :immediate-finish t
	 :unnarrowed t)
	("r" "reference" plain "%?"
	 :if-new
	 (file+head "reference/${title}.org" "#+title: ${title}\n#+")
	 :immediate-finish t
	 :unnarrowed t)
	("a" "article" plain "%?"
	 :if-new
	 (file+head "articles/${title}.org" "#+title: ${title}\n#+filetags: :article:\n")
	 :immediate-finish t
	 :unnarrowed t)))
```

```emacs-lisp
(use-package org-roam
  :straight t
  :init
  (setq org-roam-v2-ack t)
  :config
  ;; (defun artyn/publish-to-vercel ()
  ;;   "publish Hugo website to vercel with one key command"
  ;;   (interactive)
  ;;   (async-shell-command "cd ~/projects/copy/intergalatic-love && vercel --prod")
  ;;   (message "website published"))
  (defun artyn/publish-to-vercel ()
    "publish Hugo website to vercel with one key command"
    (interactive)
    ;; (async-shell-command "cd ~/projects/copy/intergalatic-love && vercel --prod")
    (call-process-shell-command "cd ~/projects/copy/intergalatic-love && vercel --prod" nil 0)
    (message "website published"))
  (defun bms/org-roam-rg-search ()
    "Search org-roam directory using consult-ripgrep. With live-preview."
    (interactive)
    (let ((consult-ripgrep-command "rg --null --ignore-case --type org --line-buffered --color=always --max-columns=500 --no-heading --line-number . -e ARG OPTS"))
      (consult-ripgrep org-roam-directory)))
  (setq org-roam-capture-templates '(("d" "default" plain "%?"
     :target (file+head "${slug}.org"
			"#+title: ${title}\n
#+date: %T\n")
     :unnarrowed t)))
  (global-set-key (kbd "C-c rr") 'bms/org-roam-rg-search)
  :custom
  (org-roam-directory "~/writings/roamNotes")
  (org-roam-completion-everywhere t)
  :general
  (pxoq-roam
    "f" #'org-roam-node-find
    "l" #'org-roam-buffer-toggle
    "i" #'org-roam-node-insert
    "t" #'org-roam-tag-add
    "p" #'org-hugo-export-to-md
    "r" #'bms/org-roam-rg-search
    "w" #'artyn/publish-to-vercel
    )
  :bind (:map org-mode-map
	 ("C-M-i" . completion-at-point)))

(use-package emacsql
  :straight t)

(use-package emacsql-sqlite
  :straight t)
```


#### visual {#visual}

```emacs-lisp
(use-package olivetti
  :straight t
  :custom
  (olivetti-body-width 0.5)
  (olivetti-minimum-body-width 65)
  (olivetti-recall-visual-line-mode-entry-state t))
```


### Programming {#programming}


#### emacs lisp {#emacs-lisp}

<!--list-separator-->

-  find definition

    This is the built-in way. See as an alternative `elisp-slime-nav`

    ```emacs-lisp
    (use-package xref
      :straight nil
      :custom
      ;; All those have been changed for Emacs 28
      (xref-show-definitions-function #'xref-show-definitions-completing-read) ; for M-.
      (xref-show-xrefs-function #'xref-show-definitions-buffer) ; for grep and the like
      (xref-file-name-display 'project-relative)
      (xref-search-program 'grep))
    ```

<!--list-separator-->

-  emacs lisp libraries

    Mostly for scripting reasons. Emacs lisp can be used as a bash replacement and s.el and f.el are quite featureful for this.

    ```emacs-lisp
    (use-package s
      :straight t)

    (use-package ox-rss
      :straight t)

    (use-package htmlize
      :straight t)

    (use-package f
      :straight t)
    ```


#### version control {#version-control}

<!--list-separator-->

-  VC

    VC has support for SCCS, CSSC, RCS, SRC, CVS, SVN, hg, git and bzr. Its basically the equivalent of a multi-chat protocol of version control software.

    It takes a different approach to Magit. it is very background oriented and not visual in your face. I find the prot-vc extensions to be sorely needed.

    VC has a excellent manual that provides a very good introduction on version control in general.

    ```emacs-lisp
    (use-package vc
      :straight nil
      :general
      (pxoq-vc
        "b" #'vc-retrieve-tag ; "branch" switch
        "t" #'vc-create-tag
        "f" #'vc-log-incoming  ; the actual git fetch
        "o" #'vc-log-outgoing
        "F" #'vc-update        ; "F" because "P" is push
        "d" #'vc-diff
        )
      :config
      ;; Those offer various types of functionality, such as blaming,
      ;; viewing logs, showing a dedicated buffer with changes to affected
      ;; files.
      (require 'vc-annotate)
      (require 'vc-dir)
      (require 'vc-git)
      (require 'add-log)
      (require 'log-view)

      ;; This one is for editing commit messages.
      (require 'log-edit)
      :custom
      (log-edit-confirm 'changed)
      (log-edit-keep-buffer nil)
      (log-edit-require-final-newline t)
      (log-edit-setup-add-author nil)
      (vc-find-revision-no-save t)
      (vc-annotate-display-mode 'scale) ; scale to oldest
      (add-log-mailing-address "swbvty@gmail.com")
      (add-log-keep-changes-together t)
      (vc-git-diff-switches '("--patch-with-stat" "--histogram"))
      (vc-git-print-log-follow t)
      (vc-git-revision-complete-only-branches nil)
      (vc-git-root-log-format
    	'("%d %h %ad %an: %s"
    	  ;; The first shy group matches the characters drawn by --graph.
    	  ;; We use numbered groups because `log-view-message-re' wants the
    	  ;; revision number to be group 1.
    	  "^\\(?:[*/\\|]+\\)\\(?:[*/\\| ]+\\)?\
    \\(?2: ([^)]+) \\)?\\(?1:[0-9a-z]+\\) \
    \\(?4:[0-9]\\{4\\}-[0-9]\\{2\\}-[0-9]\\{2\\}\\) \
    \\(?3:.*?\\):"
    	  ((1 'log-view-message)
    	   (2 'change-log-list nil lax)
    	   (3 'change-log-name)
    	   (4 'change-log-date))))
      :hook ((log-view-mode . hl-line-mode)) ; -hook?
      :bind (
    ;;    ("C-x v b" . vc-retrieve-tag)  ; "branch" switch
        ;; ("C-x v t" . vc-create-tag)
        ;; ("C-x v f" . vc-log-incoming)  ; the actual git fetch
        ;; ("C-x v o" . vc-log-outgoing)
        ;; ("C-x v F" . vc-update)        ; "F" because "P" is push
        ;; ("C-x v d" . vc-diff)
        :map vc-dir-mode-map
        ("b" . vc-retrieve-tag)
        ("t" . vc-create-tag)
        ("O" . vc-log-outgoing)
        ("o" . vc-dir-find-file-other-window)
        ("f" . vc-log-incoming) ; replaces `vc-dir-find-file' (use RET)
        ("F" . vc-update)       ; symmetric with P: `vc-push'
        ("d" . vc-diff)         ; parallel to D: `vc-root-diff'
        ("k" . vc-dir-clean-files)
        ("G" . vc-revert)
        :map vc-git-stash-shared-map
        ("a" . vc-git-stash-apply-at-point)
        ("c" . vc-git-stash) ; "create" named stash
        ("D" . vc-git-stash-delete-at-point)
        ("p" . vc-git-stash-pop-at-point)
        ("s" . vc-git-stash-snapshot)
        :map vc-annotate-mode-map
        ("M-q" . vc-annotate-toggle-annotation-visibility)
        ("C-c C-c" . vc-annotate-goto-line)
        ("<return>" . vc-annotate-find-revision-at-line)
        :map log-view-mode-map
        ("<tab>" . log-view-toggle-entry-display)
        ("<return>" . log-view-find-revision)
        ("s" . vc-log-search)
        ("o" . vc-log-outgoing)
        ("f" . vc-log-incoming)
        ("F" . vc-update)
        ("P" . vc-push)))

    (use-package prot-vc
      :straight nil
      :demand t
      :load-path "~/.emacs.d/dotfiles/emacs/.emacs.d/prot-lisp/"
      :general
      (pxoq-vc
        "i" #'prot-vc-git-log-insert-commits
        "p" #'prot-vc-project-or-dir
        "SPC" #'prot-vc-custom-log
        "g" #'prot-vc-git-grep
        "G" #'prot-vc-git-log-grep
        "a" #'prot-vc-git-patch-apply
        "c" #'prot-vc-git-patch-create-dwim
        "s" #'prot-vc-git-show
        "r" #'prot-vc-git-find-revision
        "B" #'prot-vc-git-blame-region-or-file
        "R" #'prot-vc-git-reset)
      :custom
      (prot-vc-log-limit 100)
      (prot-vc-log-bulk-action-limit 50)
      (prot-vc-git-log-edit-show-commits t)
      (prot-vc-git-log-edit-show-commit-count 10)
      (prot-vc-shell-output "*prot-vc-output*")
      (prot-vc-patch-output-dirs (list "~/" "~/projects/patches"))
      :config
      (prot-vc-git-setup-mode 1)
      :bind (
        ;; ("C-x v i" . prot-vc-git-log-insert-commits)
        ;; ("C-x v p" . prot-vc-project-or-dir)
        ;; ("C-x v SPC" . prot-vc-custom-log)
        ;; ("C-x v g" . prot-vc-git-grep)
        ;; ("C-x v G" . prot-vc-git-log-grep)
        ;; ("C-x v a" . prot-vc-git-patch-apply)
        ;; ("C-x v c" . prot-vc-git-patch-create-dwim)
        ;; ("C-x v s" . prot-vc-git-show)
        ;; ("C-x v r" . prot-vc-git-find-revision)
        ;; ("C-x v B" . prot-vc-git-blame-region-or-file)
        ;; ("C-x v R" . prot-vc-git-reset)

        :map vc-git-log-edit-mode-map
        ("C-c C-n" . prot-vc-git-log-edit-extract-file-name)
        ("C-c C-i" . prot-vc-git-log-insert-commits)
        ;; Also done by `prot-vc-git-setup-mode', but I am putting it here
        ;; as well for visibility.
        ("C-c C-c" . prot-vc-git-log-edit-done)
        ("C-c C-a" . prot-vc-git-log-edit-toggle-amend)
        ("M-p" . prot-vc-git-log-edit-previous-comment)
        ("M-n" . prot-vc-git-log-edit-next-comment)
        ("M-s" . prot-vc-git-log-edit-complete-comment)
        ("M-r" . prot-vc-git-log-edit-complete-comment)

        :map log-view-mode-map
        ("<C-tab>" . prot-vc-log-view-toggle-entry-all)
        ("a" . prot-vc-git-patch-apply)
        ("c" . prot-vc-git-patch-create-dwim)
        ("R" . prot-vc-git-log-reset)
        ("w" . prot-vc-log-kill-hash)))
    ```

<!--list-separator-->

-  Magit

    Magit is the most developed version control software for Emacs and one of the most thoroughly developed Git front-ends. You can do all the advanced features of Git like interactive rebasing.

    Magit is also complemented with the Forge package. Which provides acess to the features of Github and similar websites (issues, forking, pull-requests). This is much less developed then Magit and still under heavy development. I have very little experience with it and can barely get it to work. I find it a bit confusing to set up since you have to constantly jump from the Ghub manual (back-end of forge) to the forge manual.

    Magit provides a visual in-your-face experience with a intuitive and overall mnemonic UI. It is massive improvement over Git CLI UI.

    ```emacs-lisp
    (setq auth-sources '("~/.authinfo"))

    (use-package magit
      :straight t
      :custom
      ;; useful for prose
      (magit-diff-refine-hunk t))

    ;; currently not working
    (use-package forge
      :straight t)
    ```


#### Common Lisp {#common-lisp}

SLY or SLIME are needed for common lisp. SLY is a fork of SLIME, it is more customizable. But SLIME is more standard both provide great REPL access.

```emacs-lisp
(use-package slime
  :straight t
  :config
  (setq inferior-lisp-program "sbcl"))
```


#### Nix {#nix}

```emacs-lisp
(use-package nix-mode
  :straight t)
```


#### web {#web}

```emacs-lisp
(use-package sass-mode
  :straight t)
```


### Shell {#shell}

the benefits of it as a eshell as a shell

-   manual is good for eshell, read it.
-   it can interpret emacs lisp.
-   as programmable as the rest of Emacs
-   deeply integrated with Emacs ("its a seamless bridge")

I would say the best way to invoke eshell is either with project.el / projectile or as a bookmark.

BTW eshell has for loops and buffer redirection, it is a real shell.

```emacs-lisp
(use-package eshell
  :straight nil
  :config
  (require 'esh-mode)
  (require 'esh-module)
  (setq eshell-modules-list
	'(eshell-alias
	  eshell-basic
	  eshell-cmpl
	  eshell-dirs
	  eshell-glob
	  eshell-hist
	  eshell-ls
	  eshell-pred
	  eshell-prompt
	  eshell-script
	  eshell-term
	  eshell-tramp
	  eshell-unix))
  (setenv "PAGER" "cat") ; solves issues, such as with 'git log' and the default 'less'
  (require 'em-cmpl)
  (require 'em-dirs)
  (setq eshell-cd-on-directory t)

  (require 'em-tramp)
  (setq password-cache t)
  (setq password-cache-expiry 600)

  (require 'em-hist)
  (setq eshell-hist-ignoredups t)
  (setq eshell-save-history-on-exit t)
  ;; invoke the home directory (this is the ~ key)
  :bind (("C-`" . eshell)))

(use-package prot-eshell
  :straight nil
  :load-path "~/.emacs.d/dotfiles/emacs/.emacs.d/prot-lisp/"
  :config
  (setq prot-eshell-output-buffer "*Exported Eshell output*")
  (setq prot-eshell-output-delimiter "* * *")
  (let ((map eshell-mode-map))
    ;; more intuitive prompt deletion for eshell
    (define-key map (kbd "M-k") #'eshell-kill-input)
    (define-key map (kbd "C-c C-f") #'prot-eshell-ffap-find-file)
    (define-key map (kbd "C-c C-j") #'prot-eshell-ffap-dired-jump)
    ;; copy full path of thing at point
    (define-key map (kbd "C-c C-w") #'prot-eshell-ffap-kill-save)
    (define-key map (kbd "C-c C->") #'prot-eshell-redirect-to-buffer)
    ;; Produce a buffer with output of the last Eshell command
    (define-key map (kbd "C-c C-e") #'prot-eshell-export)
    ;; go to root of Git repo
    (define-key map (kbd "C-c C-r") #'prot-eshell-root-dir))
  (let ((map eshell-cmpl-mode-map))
    ;; cat / output a file
    (define-key map (kbd "C-c TAB") #'prot-eshell-ffap-insert) ; C-c C-i
    ;; highlight (regexp) the part you need or think is important from a file
    (define-key map (kbd "C-c M-h") #'prot-eshell-narrow-output-highlight-regexp))
  (let ((map eshell-hist-mode-map))
    ;; I use this prefix for lots of more useful commands
    (define-key map (kbd "M-s") #'nil)
    ;; a completion menu for the rest of your history
    (define-key map (kbd "M-r") #'prot-eshell-complete-history)
    ;; go to recent directory with completion
    (define-key map (kbd "C-c C-d") #'prot-eshell-complete-recent-dir)
    ;; go to any subdirectoy starting from the location your currently in. Note slow on big directories.
    (define-key map (kbd "C-c C-s") #'prot-eshell-find-subdirectory-recursive)))
```


### Text browsing {#text-browsing}


#### EWW {#eww}

the main advantages

-   integrated with Emacs
-   It is scriptable (all the scriptability of Emacs)
-   Unified interface
-   keyboard controls

I personally really like the keyboard controls of EWW. I find it intuitive.

I would as a rule of thumb say the websites it can handle:

-   All blogs
-   most news websites
-   most encyclopedia style websites
-   some database websites
-   no interactive website

To use EWW efficently you should use prots-eww extensions. Though I am having problems getting some of it working. I find the main benefit is the readability modifications it provides.

```emacs-lisp
(use-package eww
  :straight nil
  :demand t
  :config
  ;; (require 'org-eww)
  ;; TODO this
  (defvar org-website-page-archive-file "~/writings/private/websites.org")
  (defun org-website-clipper ()
  "When capturing a website page, go to the right place in capture file,
   but do sneaky things. Because it's a w3m or eww page, we go
   ahead and insert the fixed-up page content, as I don't see a
   good way to do that from an org-capture template alone. Requires
   Emacs 25 and the 2017-02-12 or later patched version of org-eww.el."
 (interactive)

  ;; Check for acceptable major mode (w3m or eww) and set up a couple of
  ;; browser specific values. Error if unknown mode.

  (cond
   ((eq major-mode 'w3m-mode)
     (org-w3m-copy-for-org-mode))
   ((eq major-mode 'eww-mode)
     (org-eww-copy-for-org-mode))
   (t
     (error "Not valid -- must be in w3m or eww mode")))

  ;; Check if we have a full path to the archive file.
  ;; Create any missing directories.

  (unless (file-exists-p org-website-page-archive-file)
    (let ((dir (file-name-directory org-website-page-archive-file)))
      (unless (file-exists-p dir)
	(make-directory dir))))

  ;; Open the archive file and yank in the content.
  ;; Headers are fixed up later by org-capture.

  (find-file org-website-page-archive-file)
  (goto-char (point-max))
  ;; Leave a blank line for org-capture to fill in
  ;; with a timestamp, URL, etc.
  (insert "\n\n")
  ;; Insert the web content but keep our place.
  (save-excursion (yank))
  ;; Don't keep the page info on the kill ring.
  ;; Also fix the yank pointer.
  (setq kill-ring (cdr kill-ring))
  (setq kill-ring-yank-pointer kill-ring)
  ;; Final repositioning.
  (forward-line -1))
  :custom
  (eww-restore-desktop t)
  (eww-desktop-remove-duplicates t)
  (eww-header-line-format nil)
  (eww-search-prefix "https://duckduckgo.com/html/?q=")
  (eww-download-directory (expand-file-name "~/Downloads/eww-downloads"))
  (eww-suggest-uris
	'(eww-links-at-point
	  thing-at-point-url-at-point))
  (eww-bookmarks-directory (locate-user-emacs-file "eww-bookmarks/"))
  (eww-history-limit 150)
  (eww-use-external-browser-for-content-type
	"\\`\\(video/\\|audio\\)") ; On GNU/Linux check your mimeapps.list
  (eww-browse-url-new-window-is-tab nil)
  (eww-form-checkbox-selected-symbol "[X]")
  (eww-form-checkbox-symbol "[ ]")
  ;; NOTE `eww-retrieve-command' is for Emacs28.  I tried the following
  ;; two values.  The first would not render properly some plain text
  ;; pages, such as by messing up the spacing between paragraphs.  The
  ;; second is more reliable but feels slower.  So I just use the
  ;; default (nil), though I find wget to be a bit faster.  In that case
  ;; one could live with the occasional errors by using `eww-download'
  ;; on the offending page, but I prefer consistency.
  ;;
  ;; '("wget" "--quiet" "--output-document=-")
  ;; '("chromium" "--headless" "--dump-dom")
  (eww-retrieve-command nil)
  :bind (:map eww-link-keymap
	      ("v" . nil)
	 :map eww-mode-map
	      ("L" . eww-list-bookmarks)
	 ;; :map dired-mode-map
	 ;;      ("E" . eww-open-file)
	 :map eww-buffers-mode-map
	      ("d" . eww-bookmark-kill)
	 :map eww-bookmark-mode-map
	      ("d" . eww-bookmark-kill)))

(use-package prot-eww
  :straight nil
  :demand t
  :load-path "~/.emacs.d/dotfiles/emacs/.emacs.d/prot-lisp/"
  :custom
  ;; (prot-eww-save-history-file "~/.emacs.d/prot-eww-visited-history")
  ;; (prot-eww-save-history-file
  ;;       (locate-user-emacs-file "prot-eww-visited-history"))
  ;; (prot-eww-save-visited-history nil)
  ;; (prot-eww-save-visited-history t)
  (prot-eww-bookmark-link nil)
  ;; :hook ((prot-eww-history-mode . hl-line-mode))
  ;; ERROR no history is defined?
  :bind (("C-c w b" . prot-eww-visit-bookmark)
	 ("C-c w e" . prot-eww-browse-dwim)
	 ("C-c w s" . prot-eww-search-engine)
	 :map eww-mode-map
	 ("B" . prot-eww-bookmark-page)
	 ("D" . prot-eww-download-html)
	 ("F" . prot-eww-find-feed)
	 ;; ("H" . prot-eww-list-history)
	 ("b" . prot-eww-visit-bookmark)
	 ("e" . prot-eww-browse-dwim)
	 ("o" . prot-eww-open-in-other-window)
	 ("E" . prot-eww-visit-url-on-page)
	 ("J" . prot-eww-jump-to-url-on-page)
	 ("R" . prot-eww-readable)
	 ("Q" . prot-eww-quit)))
```


#### Elpher {#elpher}

I want to make this experience more like EWW, so I think I need to write some code and functions for it.

My TODO list

1.  [ ] create a elpher-forward / elpher-visit-next-page command
    1.  elpher now uses a stack based history, so it should be easier to implement? The annoying thing I find about this is that it seems to delete the history when you go back. I don't get this design choice. I maybe need to change the behavior of the elpher-back command as well. I think making history a text file makes sense?
        1.  understand \`elpher-history' and \`elpher-visit-page'

<!--listend-->

```emacs-lisp
(defun eww-forward-url ()
  "Go to the next displayed page."
  (interactive nil eww-mode)
  (when (zerop eww-history-position)
    (user-error "No next page"))
  (eww-save-history)
  (eww-restore-history (elt eww-history (1- eww-history-position))))
```

1.  [ ] bookmark completion

<!--listend-->

```emacs-lisp
(use-package elpher
  :straight t
  :custom
  (elpher-history t)
  (elpher-current-page t)
  :bind (
	 :map elpher-mode-map
	      ;; ^
	      ("l" . elpher-back)
	      ;; what is the equivalent for eww forward URL?
	 ))
```


### Email {#email}

Gnus is the oldest currently used emacs email client, it now comes with Emacs. And it has been the Emacs choice for (se my [thoughts on Usenet)]({{< relref "thoughts_on_usenet.md" >}}) and E-mail for quite a while.


### Book reading {#book-reading}

```emacs-lisp
(use-package pdf-tools
  :straight t
  :custom
  (pdf-view-resize-factor 1.1)
  (pdf-view-display-size 'fit-page)
  :config
  (pdf-tools-install))

(use-package nov
  :straight t
  :custom
  (nov-text-width 80)
  :config
  (add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode)))
```


### File management {#file-management}

Dired is the way. It is one of the oldest file management software, dating to the mid 70s! So it is one of the oldest file managers ever made. Despite its age its very capable.

I would say the most essential packages to add to dired.

-   DWIM behavior (so dual panes work naturally) set on dired
-   prot dired
-   dired-x
-   dired-aux
-   wdired
-   dired subtree

All these packages add additonal functions to dired which make it much more useful.

```emacs-lisp
(use-package dired
  :straight nil
  :demand t
  :custom
  (dired-recursive-copies 'always)
  (dired-recursive-deletes 'always)
  (delete-by-moving-to-trash t)
  (dired-listing-switches
   "-AGFhlv --group-directories-first --time-style=long-iso")
  (dired-dwim-target t)
  ;; also see `dired-do-revert-buffer'
  (dired-auto-revert-buffer #'dired-directory-changed-p)
  :hook ((dired-mode . dired-hide-details-mode)
	 (dired-mode . hl-line-mode)))

(use-package prot-dired
  :straight nil
  :demand nil
  :load-path "~/.emacs.d/dotfiles/emacs/.emacs.d/prot-lisp/"
  :custom
  (prot-dired-image-viewers '("feh" "sxiv"))
  (prot-dired-media-players '("mpv" "vlc"))
  (prot-dired-media-extensions
   "\\.\\(mp[34]\\|ogg\\|flac\\|webm\\|mkv\\)")
  (prot-dired-image-extensions
   "\\.\\(png\\|jpe?g\\|tiff\\)")
  (dired-guess-shell-alist-user ; those are the defaults for ! and & in Dired
   `((,prot-dired-image-extensions (prot-dired-image-viewer))
     (,prot-dired-media-extensions (prot-dired-media-player))))
  :hook ((dired-mode .  prot-dired-setup-imenu))
  :bind (:map dired-mode-map
	      ("i" . prot-dired-insert-subdir)
	      ("/" . prot-dired-limit-regexp)
	      ("C-c C-l" . prot-dired-limit-regexp)
	      ("M-n" . prot-dired-subdirectory-next)
	      ("C-c C-n" . prot-dired-subdirectory-next)
	      ("C-c C-u" . dired-subtree-up)
	      ("C-c C-d" . dired-subtree-down)
	      ("M-p" . prot-dired-subdirectory-previous)
	      ("C-c C-p" . prot-dired-subdirectory-previous)))

;; built in extensions to dired
(use-package dired-aux
  :straight nil
  :demand t
  :custom
  (dired-isearch-filenames 'dwim "search matches file names when initial point position is on a file name")
  (dired-create-destination-dirs 'ask)
  (dired-vc-rename-file t "this causes less conflict version contro systems")
  (dired-do-revert-buffer (lambda (dir) (not (file-remote-p dir))))
  :bind (:map dired-mode-map
	      ("C-+" . dired-create-empty-file)
	      ;; better search dired tools available like `consult-find', `consult-grep', `project-find-file',
	      ;; `project-find-regexp', `prot-vc-git-grep'
	      ("M-s f" . nil)
	      ;; note this command in position and context sensitive
	      ("C-x v v" . dired-vc-next-action)))

;; more dired extensions
(use-package dired-x
  :straight nil
  :demand t
  :custom
  (dired-clean-up-buffers-too t)
  (dired-clean-confirm-killing-deleted-buffers t)
  (dired-x-hands-off-my-keys t)    ; easier to show the keys I use
  (dired-bind-man nil)
  (dired-bind-info nil)
  :bind (:map dired-mode-map
	      ("I" . dired-info)))

(use-package dired-subtree
  :demand t
  :straight t
  :custom
  (dired-subtree-use-backgrounds nil)
  :bind (:map dired-mode-map
	      ("<tab>" . dired-subtree-toggle)
	      ;; shift tab?
	      ("<backtab>" . dired-subtree-remove)))

;; dired write-mode (C-x C-q)
(use-package wdired
  :straight nil
  :demand t
  :custom
  (wdired-allow-to-change-permissions t)
  (wdired-create-parent-directories t))

(use-package dired-hide-dotfiles
  :straight t
  :hook (dired-mode . dired-hide-dotfiles-mode))
```


### Feed reading {#feed-reading}

`elfeed` is a wonderful tool for RSS/ATOM reading. It is much more easily
customizable then newsbeuter and has all the same features (and more). Nearly
all WordPress websites, all substacks and all youtube channels have feeds you
can subscribe to. It has a "river of news" style view.

```emacs-lisp
(use-package elfeed
  :straight t
  :custom
  ;; (elfeed-search-clipboard-type 'CLIPBOARD)
  ;; (elfeed-search-title-max-width 100)
  ;; (elfeed-search-title-min-width  30)
  ;; (elfeed-search-trailing-width  25)
  (elfeed-use-curl t)
  (elfeed-curl-max-connections 10)
  (elfeed-db-directory (concat user-emacs-directory "elfeed/"))
  (elfeed-enclosure-default-dir "~/Downloads/")
  (elfeed-search-filter "@4-months-ago +unread")
  (elfeed-sort-order 'descending)
  (elfeed-search-clipboard-type 'CLIPBOARD)
  (elfeed-search-title-max-width 100)
  (elfeed-search-title-min-width 30)
  (elfeed-search-trailing-width 25)
  (elfeed-show-truncate-long-urls t)
  (elfeed-show-unique-buffers t)
  (elfeed-search-date-format '("%F %R" 16 :left))
  ;; (elfeed-feeds (quote
  ;; 		 (("https://drewdevault.com/blog/index.xml" foss)
  ;; 		  ("https://planet.emacslife.com/atom.xml" emacs foss)
  ;; 		  ("https://www.youtube.com/feeds/videos.xml?channel_id=UCM2b9WKkanSBY1x70LFX2xg" music)
  ;; 		  ("https://www.youtube.com/feeds/videos.xml?channel_id=UCkfmbKrdAH3_NHkbAZhWqIw" music))))
  :config
  (add-hook 'elfeed-show-mode-hook
	    (lambda () (setq-local shr-width (current-fill-column))))
  :bind (("C-c e" . elfeed)
	 :map elfeed-search-mode-map
	 ("g" . elfeed-update)
	 ("f" . elfeed-search-untag-all-unread)
	 ("j" . elfeed-search-untag-all-unread)
;;	 ("o" . elfeed-search-show-entry)
	 ("w" . elfeed-search-yank)
	 ("G" . elfeed-search-update--force)
	 ("b" . prot-elfeed-bongo-insert-item)
	 ("h" . prot-elfeed-bongo-switch-to-playlist)
	 :map elfeed-show-mode-map
	 ("w" . elfeed-show-yank)
	 ("b" . prot-elfeed-bongo-insert-item)))

(use-package prot-elfeed
  :straight nil
  :demand t
  :load-path "~/.emacs.d/dotfiles/emacs/.emacs.d/prot-lisp/"
  :custom
  (prot-elfeed-tag-faces t)
  :bind (:map elfeed-search-mode-map
	      ;; ("s" . prot-elfeed-search-tag-filter)
	      ("o" . prot-elfeed-search-open-other-window)
	      ("q" . prot-elfeed-kill-buffer-close-window-dwim)
	      ("v" . prot-elfeed-vlc-dwim)
	      ("+" . prot-elfeed-toggle-tag)
	      :map elfeed-show-mode-map
	      ("a" . prot-elfeed-show-archive-entry)
	      ("e" . prot-elfeed-show-eww)
	      ("q" . prot-elfeed-kill-buffer-close-window-dwim)
	      ("v" . prot-elfeed-vlc-dwim)
	      ("+" . prot-elfeed-toggle-tag)))

(use-package elfeed-org
  :straight t
  :custom
  (rmh-elfeed-org-files (list "~/writings/roamNotes/elfeed.org"))
  :init
  (elfeed-org))

(use-package elfeed-dashboard
  :straight (elfeed-dashboard :type git
			      :host github
			      :repo "Manoj321/elfeed-dashboard")
  :config
  (setq elfeed-dashboard-file "~/.emacs.d/elfeed-dashboard.org")
  ;; update feed counts on elfeed-quit
  (advice-add 'elfeed-search-quit-window :after #'elfeed-dashboard-update-links))
```


### Music {#music}

Status: uncertain

The division is between those that rely on MPD as a back-end (mpc, mingus simple-mpc) and those that rely on mpv/vlc as back-end (EMMS, Bongo).

I personally want one that has dired as a library. So Bongo (which Prot has done) and possibly Mingus (though I haven't tried it and have to go through the shenanigans of setting up a MPD server). Dired is powerful and it is great to levage those powers (file management and music combined!).

Bongo is suppose to be a more in your face EMMS (which it is a fork of). Bongo is suppose to be more user friendly EMMS?

-   bongo has two types of buffers that help you manage music
    -   library buffer: Hold your media collection / music files
    -   playlist buffer: take files from library to enque for playback

You can make dired the Bongo library buffer. You can many type of buffers the library buffer. Some have made elfeed the library buffer.

Prot likes Artist/Album/Track, structure, no other metadata. This is all he thinks you need. I would maybe add year?

prot has a bespoke delimiter for the playlist (seperating logical divisions). Which is very nice

Note many things are broken for me with this. I had to make patches, and some things still don't work. I think I might try mingus.

I personally just want the benefits of used dired as the library buffer.

```emacs-lisp
(use-package bongo
  :straight t
  :custom
  (bongo-default-directory "~/Music")
  (bongo-prefer-library-buffers nil)
  (bongo-insert-whole-directory-trees t)
  (bongo-logo nil)
  (bongo-display-track-icons nil)
  (bongo-display-track-lengths nil)
  (bongo-display-header-icons nil)
  (bongo-display-playback-mode-indicator t)
  (bongo-display-inline-playback-progress nil) ; t slows down the playlist buffer
  (bongo-join-inserted-tracks nil)
  (bongo-field-separator (propertize " · " 'face 'shadow))
  (bongo-mark-played-tracks t)
  (bongo-mpv-program-name "vlc")
  :config
  (bongo-mode-line-indicator-mode -1)
  (bongo-header-line-mode -1)
  :bind (("C-c b" . bongo)
	 :map bongo-playlist-mode-map
	 ("n" . bongo-next-object)
	 ("p" . bongo-previous-object)
	 ("R" . bongo-rename-line)
	 ("j" . bongo-dired-line) ; Jump to dir of file at point
	 ("J" . dired-jump) ; Jump to library buffer
	 ("I" . bongo-insert-special)))

(use-package prot-bongo
  :straight nil
  :demand t
  :load-path "~/.emacs.d/dotfiles/emacs/.emacs.d/prot-lisp/"
  :custom
  (prot-bongo-enabled-backends '(vlc))
  (prot-bongo-playlist-section-delimiter (make-string 30 ?*))
  (prot-bongo-playlist-heading-delimiter "§")
  (prot-bongo-playlist-directory
   (concat
    (file-name-as-directory bongo-default-directory)
    (file-name-as-directory "playlists")))
  :config
  (prot-bongo-enabled-backends)
  (prot-bongo-remove-headers)
  (prot-bongo-imenu-setup)
  :hook ((dired-mode . prot-bongo-dired-library-enable)
	 (wdired-mode . prot-bongo-dired-library-disable)
	 (prot-bongo-playlist-change-track-hook . prot-bongo-playlist-recenter))
  :bind (
	 :map bongo-playlist-mode-map
	 ("C-c C-n" . prot-bongo-playlist-heading-next)
	 ("C-c C-p" . prot-bongo-playlist-heading-previous)
	 ("M-n" . prot-bongo-playlist-section-next)
	 ("M-p" . prot-bongo-playlist-section-previous)
	 ("M-h" . prot-bongo-playlist-mark-section)
	 ("M-d" . prot-bongo-playlist-kill-section)
	 ("g" . prot-bongo-playlist-reset)
	 ("D" . prot-bongo-playlist-reset)
	 ("r" . prot-bongo-playlist-random-toggle)
	 ("i" . prot-bongo-playlist-insert-playlist-file)
	 :map bongo-dired-library-mode-map
	 ("<C-return>" . prot-bongo-dired-insert)
	 ("C-c SPC" . prot-bongo-dired-insert)
	 ("C-c +" . prot-bongo-dired-make-playlist-file)))
```


### Experimental {#experimental}


#### pocket {#pocket}

This is a client for Pocket (getpocket.com). It allows you to manage your reading list: add, remove, delete, tag, view, favorite, etc. Doing so in Emacs with the keyboard is fast and efficient. Links can be opened in Emacs with any function, or in external browsers, and specific sites/URLs ncan be opened with specific browser functions. Views can be sorted by date, title, domain, tags, favorite, etc, and “limited” mutt-style. Items can be searched for using keywords, tags, favorite status, unread/archived status, etc. Items can optionally be colorized by site, making it easy to tell which items come from different sites. Items are grouped depending on the sort column.

<https://github.com/alphapapa/pocket-reader.el#installation>

default keys

RET: Open with default browse function.
TAB: Open with default pop-to function.
b: Open with external browser function.
a: Toggle archived/unread status.
c: Copy URL to the kill ring.
d: Show default view.
D: Delete item.
e: Show excerpt.
E: Show excerpt for all items.
\*, f: Toggle favorite status.
F: Show unread, favorite items.
g: Re-sort list.
G: Refresh list using last query (or default query).
s: Search for items (or display default view if no query is entered). With prefix, add items instead of replacing (this can
e used in lieu of boolean OR searches, since Pocket doesn’t support them).
m: Toggle mark of current item.
M: Mark all items.
U: Unmark all items.
o: Show more items (using the current count limit).
l: Limit current view to items matching string (this does not run a new search).
R: Open random item from current items. With prefix, read a key and call command bound to it instead of using the
efault opening function (e.g. use b to open in external browser).
ta: Add tags.
tr: Remove tags.
tt: Set tags.
ts: Search for a tag.

```emacs-lisp
(use-package pocket-reader
  :straight t
  :bind (("C-c f" . pocket-reader)))
```


#### fennel {#fennel}

```emacs-lisp
(use-package fennel-mode
  :straight (fennel-mode :type git :host gitlab :repo "technomancy/fennel-mode"))
```


#### wisp {#wisp}

```emacs-lisp
(use-package wisp-mode
  :straight t)
```


#### misc {#misc}

```emacs-lisp
;; (defun org-hugo--tag-processing-fn-remove-tags-maybe (tags-list info)
;;   "Remove user-specified tags/categories.
;; See `org-hugo-tag-processing-functions' for more info."
;;   ;; Use tag/category string (including @ prefix) exactly as used in Org file.
;;   (let ((tags-categories-to-be-removed '("tech" "elfeed"))) ;"my_tag" "@my_cat"
;;     (cl-remove-if (lambda (tag_or_cat)
;;                     (member tag_or_cat tags-categories-to-be-removed))
;;                   tags-list)))
;; (add-to-list 'org-hugo-tag-processing-functions
;;              #'org-hugo--tag-processing-fn-remove-tags-maybe)

```


### Blogging {#blogging}

```emacs-lisp
(use-package ox-hugo
  :straight t
  :custom
  (org-hugo-base-base-dir "/home/jane/projects/artyns-garden"))

;; (setq org-id-extra-files (org-roam--list-files org-roam-directory))
```

[^fn:1]: See also Quelpa which offers similar functionality. Quelpa is older if I recall.