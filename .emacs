;; Check if emacs is running as a server, if it isn't, run the server on first load
(if (not (boundp 'server-process))
    (server-start))
;; (message "server running") etc
;; big assumption above is that 'server-process is not bound to *anything* when emacs is not being run as a server
;; equivalent to check if started as a daemon is (daemonp)
;; server just allows you to send files to existing emacs from emacs client 

;; Use ido-mode everywhere
;;(require 'ido)
;;(ido-mode t)

;; After C-h i & C-h m if that doesn't find what I'm looking for in manual,
;; try helm-info-at-point

(global-set-key (kbd "C-h C-i") 'helm-info-at-point)

;; Smex is cool (from 
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; Easier to look up source code for elisp function in environment quickly
(global-set-key (kbd "C-h C-f") 'find-function)

;; so we can use skewer mode (for sending forms to browser to evaluate like Slime) in a number of modes for front-end stuff
(add-hook 'js2-mode-hook 'skewer-mode)
(add-hook 'css-mode-hook 'skewer-css-mode)
(add-hook 'html-mode-hook 'skewer-html-mode)

;; aliases for TRAMP - not working in Emacs 24.3?
;;(add-to-list tramp-default-proxy-alist
;;    	     ("moonbase0" nil "/ssh:malaparte@195.154.73.213"))


;; Amazingly fast navigation with ace-jump-mode
;; see demo at http://dl.dropboxusercontent.com/u/3254819/AceJumpModeDemo/AceJumpDemo.htm
;; usage notes at
;;(require 'ace-jump-mode)
(define-key global-map (kbd "C-c C-SPC") 'ace-jump-mode)

;; Can't be bothered using mouse to see time sometimes - display time in modeline
;; from https://www.emacswiki.org/emacs/DisplayTime
(display-time-mode 1)

(defface egoge-display-time
  '((((type x w32 mac))
     ;; #060525 is the background colour of my default face.
     (:foreground "#060525" :inherit bold)) ;TODO change to a less crappy color
    (((type tty))
     (:foreground "blue")))
  "Face used to display the time in the mode line.")

;; This causes the current time in the mode line to be displayed in
;; `egoge-display-time-face' to make it stand out visually.
(setq display-time-string-forms
      '((propertize (concat " " 24-hours ":" minutes " ")
                    'face 'egoge-display-time)))



;; So we can get back when we have heaps of windows open
(defun back-window ()
  "Opposite of move to next-window. Forward C-x o Back C-o p"
  (interactive)
  (other-window -1))
(back-window)

(global-set-key (kbd "\C-x p") 'back-window)

;; Windmove activate the keybindings
;; mostly only useful when there are heaps of windows open as with MPC mode
;; usage notes at http://www.emacswiki.org/emacs/WindMove
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))



;; On start, make an org mode scratch buffer TODO: make this for the agenda
(switch-to-buffer (get-buffer-create (generate-new-buffer-name "*org-scratch*")))
(insert "Scratch buffer with org-mode.\n\n")
(org-mode)

;; persist emacs sessions if it goes down
;; ideally we want to use this with the daemon so the only way
;; to close a file is to explicitly C-x k it (not C-c C-x)
;; Documentation at https://www.gnu.org/software/emacs/manual/html_node/emacs/Saving-Emacs-Sessions.html
;; saving desktops with M-x desktop-save is still useful for common tasks
(desktop-save-mode 1)

;; I like to know when I'm about 72-80 chars in...
;; also don't forget M-g TAB new in 24.3 to move to column
(column-number-mode 1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(custom-enabled-themes (quote (tango-dark)))
 '(custom-safe-themes
   (quote
    ("98c37cf362757a398bcfba40b14158d97db42a1e03deec839a9466c7e7431676" "8ac31e1bc1920b33d478dfafb0b45989a00ede15a2388ea16093e7d0988c48d0" "6e92ca53a22d9b0577ad0b16e07e2e020c8b621197e39fec454048e51b7954cb" default)))
 '(org-agenda-files
   (quote
    ("~/org/sundaynight_30_march_2014.org" "~/success.org")))
 '(smex-save-file "~/.emacs.d/smex-items"))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Anonymous Pro" :foundry "unknown" :slant normal :weight normal :height 113 :width normal)))))



;; Enable copy pasting between emacs and browser
(setq x-select-enable-clipboard t)

;; Purge on holy GUI elements from environment, keep holy ones. 
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; Down with the splash screen!



;; Additional packages for the package manager
;; from sachachua.com 
(require 'package) ;I suspect this is not needed after 24.3? Not sure.
;; Add the original Emacs Lisp Package Archive


(add-to-list 'package-archives
             '("elpa" . "http://tromey.com/elpa/"))
(add-to-list 'package-archives
             '("gnu" . "http://elpa.gnu.org/packages/"))
;; Add the user-contributed repository
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
;; Add Melpa
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/"))
;; Orgmodes package repo
(add-to-list 'package-archives
             '("org" . "http://orgmode.org/elpa/"))
;; The variable `package-load-list' controls which packages to load.
(package-initialize)



;(setq make-backup-files nil) ; stop creating those backup~ files

;; make backup to a designated dir, mirroring the full path

(defun my-backup-file-name (fpath)
  "Return a new file path of a given file path.
If the new path's directories does not exist, create them."
  (let* (
        (backupRootDir "~/.emacs_backup/")
        (filePath (replace-regexp-in-string "[A-Za-z]:" "" fpath )) ; remove Windows driver letter in path, ⁖ “C:”
        (backupFilePath (replace-regexp-in-string "//" "/" (concat backupRootDir filePath "~") ))
        )
    (make-directory (file-name-directory backupFilePath) (file-name-directory backupFilePath))
    backupFilePath
  )
)

(setq make-backup-file-name-function 'my-backup-file-name)


;; Add nXhtml mode which builds on xml mode
;;   (load "~/.emacs.d/nxhtml/autostart.el")

;; create a backup file directory
;; get rid of fucking annoying tildes etc
;(defun make-backup-file-name (file)
;(concat “~/.emacs_backups/” (file-name-nondirectory file) “~”))

;; change to a better buffer mode
(global-set-key (kbd "\C-x \C-b") 'ibuffer)

(global-set-key (kbd "\C-x b") 'switch-to-buffer) ;; TODO can we find a better one for tab completion?

;; keybinding for idomenu so that we can quickly navigate to headers etc with ido
(global-set-key (kbd "\C-x \C-m") 'idomenu)


;; Some configurations for mutt
;;(server-start)
;;(add-to-list 'auto-mode-alist '("/mutt" . mail-mode))


;; Saves command histories between shutdowns
(savehist-mode 1)


;; load the insert date command Wednesday, 04. September 2013
(load-file "~/src/elisp/insertdate.el")

(define-key global-map (kbd "C-c d") 'insert-date) ;; TODO this clashes with eding keybindings (german dictionary) that starts with C-c d 
(global-set-key "\C-c d" 'insert-date)

;; useful for saving open files across sessions etc... contextual
;; experiment with this more 
;;(desktop-save-mode 1)


;; Consider enabling Winner-mode ... allows you to revert back window layouts
;; using C-c LEFT and forwards using C-c right
;; nice way to 'undo' windows changes with C-c left and C-c right
;; 
;; documentation http://www.emacswiki.org/emacs/WinnerMode
(winner-mode 1)

;; For elfeed from nullprogram.com
(setq elfeed-feeds
      '(;;"http://nullprogram.com/feeds/"
        "http://www.terminally-incoherent.com/blog/feed/"
	"http://www.50ply.com/atom.xml"
	"https://guardianproject.info/feed/"
	"http://jvns.ca/atom.xml"
	"http://blog.danieljanus.pl/atom.xml"
        "http://possiblywrong.wordpress.com/feed/"
	"http://feeds.sachachua.com/sachac"
	"http://programmingisterrible.com/rss"
	"http://planet.emacsen.org/atom.xml"
	"http://blog.jr0cket.co.uk/feeds/posts/default?alt=rss"
        "http://www.devrand.org/feeds/posts/default"))


;; for org-mode global link grabbing awesome
     (global-set-key "\C-c L" 'org-insert-link-global)
     (global-set-key "\C-c o" 'org-open-at-point-global)
;; DIY style
     (define-key global-map (kbd "C-c l") 'org-store-link)
     (global-set-key "\C-c l" 'org-store-link)

;; for adding abbreviated links in org
;; eg [[tor:1234]] goes to the bug 1234 on the tor bug tracker
;; can use %s if need to replace string inside, otherwise just append to end
     (setq org-link-abbrev-alist
       '(("google"   . "http://www.google.com/search?q=")
	 ("gmap"     . "http://maps.google.com/maps?q=%s")
;	 ("transport"     . "http://maps.google.com/maps?q=%s") ;; add 131500.info shit here 
         ("tor" . "https://bugs.torproject.org/")))

;;     (setq org-link-abbrev-alist
;;       '(("bugzilla" . "http://10.1.2.9/bugzilla/show_bug.cgi?id=")
;;         ("google"   . "http://www.google.com/search?q=")
;;         ("gmap"     . "http://maps.google.com/maps?q=%s")  
;;         ("omap"     . "http://nominatim.openstreetmap.org/search?q=%s&polygon=1")
;;         ("ads"      . "http://adsabs.harvard.edu/cgi-bin/nph-abs_connect?author=%s&db_key=AST")))
;;
;;   If the replacement text contains the string `%s', it will be
;;replaced with the tag.  Otherwise the tag will be appended to the string
;;in order to create the link.  You may also specify a function that will
;;be called with the tag as the only argument to create the link.
;;
;;   With the above setting, you could link to a specific bug with
;;`[[bugzilla:129]]', search the web for `OrgMode' with
;;`[[google:OrgMode]]', show the map location of the Free Software
;;Foundation `[[gmap:51 Franklin Street, Boston]]' or of Carsten office
;;`[[omap:Science Park 904, Amsterdam, The Netherlands]]' and find out
;;what the Org author is doing besides Emacs hacking with
;;`[[ads:Dominik,C]]'.


;; Org capture, for grabbing shit to remember and deal with later
     (setq org-default-notes-file (concat org-directory "/notes.org"))
     (define-key global-map "\C-cc" 'org-capture)

;; Some custom org-capture templates 
     (setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org/todo.org" "Tasks")
             "* TODO %?\n  %i\n  %a")
	("e" "Emacs" entry (file+headline "~/org/learning/emacs_commands.org" "Emacs Commands"))
	("w" "Words" entry (file+headline "~/org/learning/new_words.org" "New words"))
	("u" "Unix" entry (file+headline "~/org/learning/unix_commands.org" "Unix Commands"))
	("c" "C" entry (file+headline "~/org/learning/c_lang.org" "C Syntax"))	
	("l" "Lua" entry (file+headline "~/org/learning/lua_syntax.org" "Lua Syntax"))
	("g" "Git" entry (file+headline "~/org/learning/git_commands.org" "Git Commands"))
	("n" "Networking" entry (file+headline "~/org/learning/networking.org" "Networking"))
	("p" "PHP" entry (file+headline "~/org/learning/PHP_syntax.org" "PHP Syntax"))
        ("j" "Journal" entry (file+datetree "~/org/journal.org")
             "* %?\nEntered on %U\n  %i\n  %a")))

;; from [[info:org#Clocking%20work%20time][info:org#Clocking work time]]
;     (setq org-clock-persist 'history)
;    (org-clock-persistence-insinuate)

;; To add key to access org-mode agenda globally
(define-key global-map (kbd "C-c a") 'org-agenda)

;; To do org-style links from anywhere 
;;(global-set-key "\C-c L" 'org-insert-link-global)
;;(global-set-key "\C-c o" 'org-open-at-point-global)


;; Make sure Gnus is used to compose mail
(setq mail-user-agent 'gnus-user-agent)

;; Custom Org TODO states
;     (setq org-todo-keywords
;       '((sequence "TODO(t)" "WAIT(w@/!)" "|" "DONE(d!)" "CANCELED(c@)")))
; [[info:org#Tracking%20TODO%20state%20changes][info:org#Tracking TODO state changes]]

;    (setq org-todo-keywords
;       '((sequence "TODO(t)" "DOING(s!)" "|" "DONE(d!)" )))



;;   If you would like a TODO entry to automatically change to DONE when
;;all children are done, you can use the following setup:
;;
;;     (defun org-summary-todo (n-done n-not-done)
;;       "Switch entry to DONE when all subentries are done, to TODO otherwise."
;;       (let (org-log-done org-log-states)   ; turn off logging
;;         (org-todo (if (= n-not-done 0) "DONE" "TODO"))))
;;
;;     (add-hook 'org-after-todo-statistics-hook 'org-summary-todo)



;; Setting Colours (faces) for todo states to give clearer view of work 
;(setq org-todo-keyword-faces
;  '(("TODO" . org-warning)
;   ("DOING" . "yellow")
;   ("BLOCKED" . "red")
;   ("REVIEW" . "orange")
;   ("DONE" . "green")
;   ("ARCHIVED" . "blue"))) 


; Friday, 13. September 2013
; Possibly create an org-table-create-or-convert-from-region shortcut


; Friday, 13. September 2013 add eding

(setq load-path
      (append (list nil "~/.eding")
	      load-path))
(load "eding")

; Monday, 16. September 2013
;; Add hook for looking up dictionary words quickly
(define-key global-map (kbd "C-c w") 'dictionary-lookup-definition)


;; Way to add keyboard macros that prompt you for input
;; gleaned from ... http://www.emacswiki.org/emacs/KeyboardMacros#toc5
(defun my-macro-query (arg)
      "Prompt for input using minibuffer during kbd macro execution.
    With prefix argument, allows you to select what prompt string to use.
    If the input is non-empty, it is inserted at point."
      (interactive "P")
      (let* ((query (lambda () (kbd-macro-query t)))
             (prompt (if arg (read-from-minibuffer "PROMPT: ") "Input: "))
             (input (unwind-protect
                        (progn
                          (add-hook 'minibuffer-setup-hook query)
                          (read-from-minibuffer prompt))
                      (remove-hook 'minibuffer-setup-hook query))))
        (unless (string= "" input) (insert input))))

(global-set-key "\C-xQ" 'my-macro-query)



;;;; Org-mode stuff
;;
;; if I leave emacs for more than 10 minutes, ask how to resolve idle time
;; (org-clock-idle-time 10)
;
;; #+PROPERTY: Effort_ALL 0 0:10 0:30 1:00 2:00 3:00 4:00 5:00 6:00 7:00
;; #+COLUMNS: %40ITEM(Task) %17Effort(Estimated Effort){:} %CLOCKSUM
;
;; or, even better, you can set up these values globally by customizing the
;; variables `org-global-properties' and `org-columns-default-format'.  In
;; particular if you want to use this setup also in the agenda, a global
;
;;; Latex Beamer (presenations) export boilerplate crap
;;
;; from... http://emacs-fu.blogspot.com.au/2009/10/writing-presentations-with-org-mode-and.html
;; #+LaTeX_CLASS: beamer in org files
(unless (boundp 'org-export-latex-classes)
  (setq org-export-latex-classes nil))
(add-to-list 'org-export-latex-classes
  ;; beamer class, for presentations
  '("beamer"
     "\\documentclass[11pt]{beamer}\n
      \\mode<{{{beamermode}}}>\n
      \\usetheme{{{{beamertheme}}}}\n
      \\usecolortheme{{{{beamercolortheme}}}}\n
      \\beamertemplateballitem\n
      \\setbeameroption{show notes}
      \\usepackage[utf8]{inputenc}\n
      \\usepackage[T1]{fontenc}\n
      \\usepackage{hyperref}\n
      \\usepackage{color}
      \\usepackage{listings}
      \\lstset{numbers=none,language=[ISO]C++,tabsize=4,
  frame=single,
  basicstyle=\\small,
  showspaces=false,showstringspaces=false,
  showtabs=false,
  keywordstyle=\\color{blue}\\bfseries,
  commentstyle=\\color{red},
  }\n
      \\usepackage{verbatim}\n
      \\institute{{{{beamerinstitute}}}}\n          
       \\subject{{{{beamersubject}}}}\n"

     ("\\section{%s}" . "\\section*{%s}")
     
     ("\\begin{frame}[fragile]\\frametitle{%s}"
       "\\end{frame}"
       "\\begin{frame}[fragile]\\frametitle{%s}"
       "\\end{frame}")))

  ;; letter class, for formal letters

  (add-to-list 'org-export-latex-classes

  '("letter"
     "\\documentclass[11pt]{letter}\n
      \\usepackage[utf8]{inputenc}\n
      \\usepackage[T1]{fontenc}\n
      \\usepackage{color}"
     
     ("\\section{%s}" . "\\section*{%s}")
     ("\\subsection{%s}" . "\\subsection*{%s}")
     ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
     ("\\paragraph{%s}" . "\\paragraph*{%s}")
     ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))




;;; Yasnippet
;(setq yas-snippet-dirs
;      '("~/.emacs.d/snippets"                 ;; personal snippets
;        "~/.emacs.d/elpa/yasnippet-20140106.1009/snippets/" ;; snippets that come with yasnippet from melpa
;        ))
;; (yas-global-mode 1) ;; or M-x yas-reload-all if you've started YASnippet already.

;(add-hook 'love-minor-mode 'love-local-doc-path)
;(defun love-local-doc-path ()
;	 (setq love-local-documentation-path "/usr/share/doc/love/html/")) ;; TODO this doesn't seem to work, the mode is outdated compared to the documentation - figure out problem and give pull request?
;;(put 'downcase-region 'disabled nil)
;;(require 'love-minor-mode)


;; hang-ups to solve
;; launch server on startup and rebind "emacs" to "emacsclient"
;; auto-save desktop file, but keep some sort of revision history, perhaps git?

;; quicker-easier buffer finding (when you forget name but just remember "that one")
;; when C-x b to change buffers, then <TAB> should sort by last used or most commonly used <C-x b <TAB> c> - look at ibuffer functionality
;;;; Useful Functions
:; on normal C-x b <TAB> it calls 
;; (minibuffer-complete)
;; the ibuffer equivalent of the most recent is the
;; (ibuffer-do-sort-by-recency)

;; auto-save desktop file, but keep some sort of revision history, perhaps git?

;; other idea is to save desktop files 

;; Way to run arbitrary shell commands on files in dired
;; see http://www.masteringemacs.org/articles/2014/04/10/dired-shell-commands-find-xargs-replacement/
(add-hook 'dired-load-hook
          (lambda ()
            (load "dired-x")))


;; required to enable color-theme-approximate to have themes safely degrade in term mode
(autoload 'color-theme-approximate-on "color-theme-approximate")
(color-theme-approximate-on)

;; For clojure code, I like to use Cider 
;; When using Cider, it's useful to add the following to ~/.lein/profiles.clj
;;       :plugins [[cider/cider-nrepl "0.6.0"]]
;; Enable eldoc in Clojure mode 
(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
