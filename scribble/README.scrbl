
(in-package #:vault-docs)

@output-file["/README.md"]

@title[:toc nil]{Vault}

Welcome to Vault! :D

@table-of-contents[]

@subtitle{Introduction}

A vault is a container of functions and symbols. A vault is denoted by a symbol. So, a vault is a symbol that works like a namespace for variables and functions.

¿But why?

This is needed if we want to name new functions or variables without polluting a package.
This is handy for making complex macros where the user could define an extension for such macro and give it a name.

@subtitle{Using Vault}

First we define a vault using @fref[defvault]:

@example{
(defvault super-vault)
}

Now @code{super-vault} is a new namespace for functions and variables.

We can check if a symbol denotes a vault with @fref[vaultp]:

@example{
(vaultp 'super-vault)
}

@subsubtitle{Defining functions}

We define a new function using @fref[define-vault-function]:

@example{
(define-vault-function super-vault super-function (x)
  "A super function"
  (+ x 10))
}

Now @code{super-function} is a function defined inside the vault @code{super-vault}.

We can check if a function belongs to a vault using @fref[vault-function-p]:

@example{
(vault-function-p 'super-vault 'super-function)
}

We can retrieve the function with @fref[vault-function]:

@example{
(vault-function 'super-vault 'super-function)
}

And we can call it using @fref[vault-funcall] or @fref[vault-apply]:

@example{
(vault-funcall 'super-vault 'super-function 3)
}

@example{
(vault-apply 'super-vault 'super-function '(3))
}

Lastly, we can update a function using @fref[vault-function] with @clref[setf]:

@example{
(setf (vault-function 'super-vault 'super-function) (lambda (x) (+ x 7)))
(vault-funcall 'super-vault 'super-function 4)
}

@subsubtitle{Defining variables}

We define variables using @fref[define-vault-variable]:

@example{
(define-vault-variable super-vault super-variable 5)
}

We can check if a variable belongs to a vault with @fref[vault-variable-p]:

@example{
(vault-variable-p 'super-vault 'super-variable)
}

We can retrieve or update a variable using @fref[vault-variable]:

@example{
(vault-variable 'super-vault 'super-variable)
}

@example{
(setf (vault-variable 'super-vault 'super-variable) 6)
(vault-variable 'super-vault 'super-variable)
}

@subsubtitle{Different namespaces}

Functions and variables are in different namespaces. So, we can have a function and a variable both being denoted by the same symbol:

@example{
(define-vault-function super-vault some-value ()
  5)

(define-vault-variable super-vault some-value 8)

(values (vault-funcall 'super-vault 'some-value) (vault-variable 'super-vault 'some-value))
}

@subtitle{Reference}

@function-glossary[#:vault]
