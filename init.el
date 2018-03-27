;;;; init.el

;; Author: n-bar
;; Created: 02-08-2016
;; Version: 0.6

;; INSTALL PACKAGES
(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(better-defaults
    exec-path-from-shell
    neotree
    powerline
    paredit
    clojure-mode-extra-font-locking
    cider
    rainbow-delimiters
    elpy
    julia-mode
    go-mode
    company-go
    go-eldoc
    ))

(mapc 
 #'(lambda (package)
     (unless 
         (package-installed-p package)
       (package-install package)))
 myPackages)

;;;; Поведение
(add-to-list 'default-frame-alist '(width  . 110))
(add-to-list 'default-frame-alist '(height  . 35))
(setq-default mouse-wheel-scroll-amount
                             '(3 ((shift) . 1))) ;; шаг прокрутки
(setq-default mouse-wheel-progressive-speed nil) ;; ускорение прокрутки
(setq inhibit-startup-message                 t) ;; приветственный буффер
(setq-default auto-save-default             nil) ;; автосохранение
(setq-default truncate-lines                 -1) ;; перенос строк
(setq-default redisplay-dont-pause            t) ;; лучшая отрисовка буфера
(setq-default ring-bell-function        'ignore) ;; звуковой сигнал
(global-linum-mode                            1) ;; нумерация строк
;; (column-number-mode                           t) ;; номер столбца в mode-line
(delete-selection-mode                        t) ;; вставка с заменой
(setq-default tab-width                       4) ;; размер <TAB>
(setq-default standart-indent                 4) ;; размер отступа в <SPC>
(setq-default lisp-body-indent                2) ;; отступ в lisp-body



;;; Шрифт и кодировка
(set-language-environment               'UTF-8)
(setq default-buffer-file-coding-system 'utf-8)
(setq coding-system-for-read            'utf-8)
(setq file-name-coding-system           'utf-8)
(set-selection-coding-system            'utf-8)
(set-keyboard-coding-system        'utf-8-unix)
(set-terminal-coding-system             'utf-8)
(prefer-coding-system                   'utf-8)

;; font
;;(custom-set-faces
;; '(default ((t (:height 50 :family "Ubuntu"))))
;; )
(set-face-attribute 'default nil :height 90)
;; desktop-mode
(desktop-save-mode 1)


;;; Color Themes
;; Read http://batsov.com/articles/2012/02/19/color-theming-in-emacs-reloaded/
;; for a great explanation of emacs color themes.
;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Custom-Themes.html
;; for a more technical explanation.
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(add-to-list 'load-path "~/.emacs.d/themes")
(load-theme 'material t) ;; themes from https://github.com/ecerulm/dotfiles/tree/master/emacs.d/themes and https://github.com/cpaulik/emacs-material-theme

;;; comments
(defun toggle-comment-on-line ()
  "comment or uncomment current line"
  (interactive)
  (comment-or-uncomment-region (line-beginning-position) (line-end-position)))
(global-set-key (kbd "C-;") 'toggle-comment-on-line)

;;; PATH ENV FIX
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-env "GOPATH")
  )

;;;; Плагины
;;; IDO подскази в буфере
(icomplete-mode                t)
(ido-everywhere                t)
(setq ido-vitrual-buffers      t)
(setq ido-enable-flex-matching t)

;;; NEOTREE
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)
(setq neo-autorefresh nil)

;;; POWERLINE
(require 'powerline)
(powerline-default-theme)

;;; CLOJURE
(require 'cider)
(require 'clojure-mode-extra-font-locking)

(add-hook 'clojure-mode-hook     'enable-paredit-mode)
(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)

(add-hook 'cider-repl-mode-hook         'paredit-mode)
(add-hook 'cider-repl-mode-hook          #'eldoc-mode)
(add-hook 'cider-repl-mode-hook        #'company-mode)

(add-hook 'cider-mode-hook               #'eldoc-mode)
(add-hook 'cider-mode-hook             #'company-mode)

;;; PYTHON
(defun nbar-python-mode ()
  (progn
    (elpy-enable)
    (elpy-use-ipython)))

(add-hook 'python-mode-hook         'nbar-python-mode)

;;;ELISP
(add-hook 'emacs-lisp-mode-hook         'company-mode)

;;;;JULIA
(require 'julia-mode)

;;;;GOLANG

