

<a id="TITLE:VAULT-DOCS:TAG1"></a>
# Vault

Welcome to Vault\! \:D

* [Introduction](/README.md#TITLE:VAULT-DOCS:TAG2)
* [Using Vault](/README.md#TITLE:VAULT-DOCS:TAG3)
  * [Defining functions](/README.md#TITLE:VAULT-DOCS:TAG4)
  * [Defining variables](/README.md#TITLE:VAULT-DOCS:TAG5)
  * [Different namespaces](/README.md#TITLE:VAULT-DOCS:TAG6)
* [Reference](/README.md#TITLE:VAULT-DOCS:TAG7)


<a id="TITLE:VAULT-DOCS:TAG2"></a>
## Introduction

A vault is a container of functions and symbols\. A vault is denoted by a symbol\. So\, a vault is a symbol that works like a namespace for variables and functions\.

¿But why\?

This is needed if we want to name new functions or variables without polluting a package\.
This is handy for making complex macros where the user could define an extension for such macro and give it a name\.

<a id="TITLE:VAULT-DOCS:TAG3"></a>
## Using Vault

First we define a vault using [vault\:defvault](/README.md#FUNCTION:VAULT:DEFVAULT)\:

`````common-lisp
(defvault super-vault)
`````
`````common-lisp
;; Returns
SUPER-VAULT
`````

Now ```super-vault``` is a new namespace for functions and variables\.

We can check if a symbol denotes a vault with [vault\:vaultp](/README.md#FUNCTION:VAULT:VAULTP)\:

`````common-lisp
(vaultp 'super-vault)
`````
`````common-lisp
;; Returns
T
`````

<a id="TITLE:VAULT-DOCS:TAG4"></a>
### Defining functions

We define a new function using [vault\:define\-vault\-function](/README.md#FUNCTION:VAULT:DEFINE-VAULT-FUNCTION)\:

`````common-lisp
(define-vault-function super-vault super-function (x)
  "A super function"
  (+ x 10))
`````
`````common-lisp
;; Returns
SUPER-FUNCTION
`````

Now ```super-function``` is a function defined inside the vault ```super-vault```\.

We can check if a function belongs to a vault using [vault\:vault\-function\-p](/README.md#FUNCTION:VAULT:VAULT-FUNCTION-P)\:

`````common-lisp
(vault-function-p 'super-vault 'super-function)
`````
`````common-lisp
;; Returns
T
`````

We can retrieve the function with [vault\:vault\-function](/README.md#FUNCTION:VAULT:VAULT-FUNCTION)\:

`````common-lisp
(vault-function 'super-vault 'super-function)
`````
`````common-lisp
;; Returns
#<FUNCTION (LAMBDA (X)) {B800DEEC0B}>
`````

And we can call it using [vault\:vault\-funcall](/README.md#FUNCTION:VAULT:VAULT-FUNCALL) or [vault\:vault\-apply](/README.md#FUNCTION:VAULT:VAULT-APPLY)\:

`````common-lisp
(vault-funcall 'super-vault 'super-function 3)
`````
`````common-lisp
;; Returns
13
`````

`````common-lisp
(vault-apply 'super-vault 'super-function '(3))
`````
`````common-lisp
;; Returns
13
`````

Lastly\, we can update a function using [vault\:vault\-function](/README.md#FUNCTION:VAULT:VAULT-FUNCTION) with [setf](http://www.lispworks.com/reference/HyperSpec/Body/a_setf.htm)\:

`````common-lisp
(setf (vault-function 'super-vault 'super-function) (lambda (x) (+ x 7)))
(vault-funcall 'super-vault 'super-function 4)
`````
`````common-lisp
;; Returns
11
`````

<a id="TITLE:VAULT-DOCS:TAG5"></a>
### Defining variables

We define variables using [vault\:define\-vault\-variable](/README.md#FUNCTION:VAULT:DEFINE-VAULT-VARIABLE)\:

`````common-lisp
(define-vault-variable super-vault super-variable 5)
`````
`````common-lisp
;; Returns
SUPER-VARIABLE
`````

We can check if a variable belongs to a vault with [vault\:vault\-variable\-p](/README.md#FUNCTION:VAULT:VAULT-VARIABLE-P)\:

`````common-lisp
(vault-variable-p 'super-vault 'super-variable)
`````
`````common-lisp
;; Returns
T
`````

We can retrieve or update a variable using [vault\:vault\-variable](/README.md#FUNCTION:VAULT:VAULT-VARIABLE)\:

`````common-lisp
(vault-variable 'super-vault 'super-variable)
`````
`````common-lisp
;; Returns
5
`````

`````common-lisp
(setf (vault-variable 'super-vault 'super-variable) 6)
(vault-variable 'super-vault 'super-variable)
`````
`````common-lisp
;; Returns
6
`````

<a id="TITLE:VAULT-DOCS:TAG6"></a>
### Different namespaces

Functions and variables are in different namespaces\. So\, we can have a function and a variable both being denoted by the same symbol\:

`````common-lisp
(define-vault-function super-vault some-value ()
  5)

(define-vault-variable super-vault some-value 8)

(values (vault-funcall 'super-vault 'some-value) (vault-variable 'super-vault 'some-value))
`````
`````common-lisp
;; Returns
5
8
`````

<a id="TITLE:VAULT-DOCS:TAG7"></a>
## Reference

<a id="FUNCTION:VAULT:DEFINE-VAULT-FUNCTION"></a>
<a id="FUNCTION:VAULT-DOCS:TAG17"></a>
#### Macro: vault\:define\-vault\-function \(vault name \(\&rest args\) \&body body\)

`````text
Define and insert a function into VAULT. If used at top level the function will be defined at
compile time. NAME must be a symbol denoting the new function. ARGS is an ordinary lambda list.
`````

<a id="FUNCTION:VAULT:DEFINE-VAULT-VARIABLE"></a>
<a id="FUNCTION:VAULT-DOCS:TAG11"></a>
#### Macro: vault\:define\-vault\-variable \(vault name value\)

`````text
Define and insert a variable into VAULT. If used at top level the variable will be defined at
compile time. NAME must be a symbol denoting the new variable.
`````

<a id="FUNCTION:VAULT:DEFVAULT"></a>
<a id="FUNCTION:VAULT-DOCS:TAG10"></a>
#### Macro: vault\:defvault \(vault\)

`````text
Define a vault represented by the symbol SYM.
If used at top level the expander will be defined at compile time.
`````

<a id="FUNCTION:VAULT:VAULT-APPLY"></a>
<a id="FUNCTION:VAULT-DOCS:TAG16"></a>
#### Function: vault\:vault\-apply \(vault name \&rest args\)

`````text
Apply the function NAME from VAULT with ARGS.
`````

<a id="FUNCTION:VAULT:VAULT-FUNCALL"></a>
<a id="FUNCTION:VAULT-DOCS:TAG9"></a>
#### Function: vault\:vault\-funcall \(vault name \&rest args\)

`````text
Call the function NAME from VAULT with ARGS.
`````

<a id="FUNCTION:VAULT:VAULT-FUNCTION"></a>
<a id="FUNCTION:VAULT-DOCS:TAG13"></a>
#### Function: vault\:vault\-function \(vault name\)

`````text
Retrieve the function NAME from VAULT.
`````

<a id="FUNCTION:VAULT:VAULT-FUNCTION-P"></a>
<a id="FUNCTION:VAULT-DOCS:TAG15"></a>
#### Function: vault\:vault\-function\-p \(vault name\)

`````text
Check if NAME denotes a function in VAULT.
`````

<a id="FUNCTION:VAULT:VAULT-VARIABLE"></a>
<a id="FUNCTION:VAULT-DOCS:TAG8"></a>
#### Function: vault\:vault\-variable \(vault name\)

`````text
Retrieve the value of the variable NAME from VAULT.
`````

<a id="FUNCTION:VAULT:VAULT-VARIABLE-P"></a>
<a id="FUNCTION:VAULT-DOCS:TAG12"></a>
#### Function: vault\:vault\-variable\-p \(vault name\)

`````text
Check if NAME denotes a variable in VAULT.
`````

<a id="FUNCTION:VAULT:VAULTP"></a>
<a id="FUNCTION:VAULT-DOCS:TAG14"></a>
#### Function: vault\:vaultp \(vault\)

`````text
Check if a symbol denotes a vault.
`````