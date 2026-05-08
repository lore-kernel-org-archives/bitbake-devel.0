Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE0BCD342F
	for <webhook@archiver.kernel.org>; Fri,  8 May 2026 07:13:51 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8202.1778224426441782340
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 08 May 2026 00:13:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=3YawqAJH;
 spf=pass (domain: smile.fr, ip: 209.85.128.41, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488b0046078so13735595e9.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 08 May 2026 00:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1778224425; x=1778829225; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yZcJWn8fvc6NJVXkjMvbFQGSAG9BIpR6NbCMSkYRnAU=;
        b=3YawqAJH7D+IwB5xzhWWNI7vFgHNuetwTJtNU/yCkYYLl1m+qZLGVGCI8U1MyPVyv8
         cameBMzgkbPk7Q2ZxeUMxbWyhiByypCLFUfmq9U3vg4/Qors0dSkGUzuAHIo5tquTM9C
         wdASfPOnGIWBoIaHocR+4ON6w4dX/djq68SzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778224425; x=1778829225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yZcJWn8fvc6NJVXkjMvbFQGSAG9BIpR6NbCMSkYRnAU=;
        b=GDH1dNrkfPc7IkipE0rvG2RdASCNIQ+z4pNJiTtNETslccAH779IqH2lP5nYoe2/yB
         K/UskskqnmgLBZXHAX3RGFdNIEa4LYhogknnf5sT8rrIXuf6TN8K+L20rgH8o8YWM7hA
         JnPoRrYUs+ZN2q8JU2y9rrdCRIc5KkFtzOmtBnKAbDJ4WbGruIUiVPDkBgo6bzCbdBVi
         DgoOpjIY9kAyuprJPuXHpzpfF3hGCpjW5aEAl/W11FitxFgBgUVc2IMDObX/FnVOEreC
         X9DdoNbq6OZ1OFuL/1HTjKj+2DDQvi9YaTl4r21elje8rChRsAPYk1kzIzJdb4gZQyP5
         6Q6Q==
X-Gm-Message-State: AOJu0Yw6hqPonEKWmdVRhiKXJLM9zEp7SUUz+t6SdF8R6ZOW2ql/BJ5Z
	PI+BzOXMSZNzuKQLMlaM6WBwJ31doj0xw0F/h1wSo63R7clmN+sveNtYtKBO/dldoPqR4wUhFOo
	77Fza8pE=
X-Gm-Gg: AeBDiesOMH0KfYMv3rYr9WtUzIbHgpU8Dw9Gm0sJQfsDXFKUckSar/wfOWv4RbE96hd
	gN82ZGAUcae4WssOUPxg6BqijwZoIDJT0aJ9kZgGnBHx3xbaa3TgyHU9AJU7eGxkxW9ZdfdPvXA
	85sSHh4KMhTUVw8LYpCTPEyCE/Sbnmq+z+Lp1UV0ZL1APoJa35WQBssqktsFfvfCdt0o+Plhhh/
	8oB35hOyKyZYDBH3B2pY4AkEyoEoUEuWIC44mvO+NfYfvLWuQr598Sg6lnJxxgKhwwEfNMLPYV0
	USNo2xWU2pJPxyj8pTDpBtFrSfHMjX8RknIf4DvI4Q1mx+LtZguYF0xSxrZkEM1c9E1nEiWbuos
	lZy0BsW/XhjICxCcHKeAHG6hjGslgr7kuiI44NxdrDd330cKF2mMDRQdEo2ffEZu66UYkCI9HDP
	ONs/Zt3Pmo6hpVR6vQxq8WwmTH4pK3m4na7rlH6jRPUkH4SPro04my5UEb2MRM6ZcFuuIbh9sKL
	TSfKXkfpKrtgy8YQeAKpcKImYc=
X-Received: by 2002:a05:600c:608f:b0:489:1ba8:5be9 with SMTP id 5b1f17b1804b1-48e51f4b0e1mr182006565e9.29.1778224424125;
        Fri, 08 May 2026 00:13:44 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e68edcc3asm26363195e9.6.2026.05.08.00.13.43
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 00:13:43 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][wrynose][2.18][PATCH 3/3] lib: Replace codegen with ast.unparse()
Date: Fri,  8 May 2026 09:13:21 +0200
Message-ID: <87dcc2935137558ac236676ab7bcbc3cc4883c2c.1778197991.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1778197991.git.yoann.congal@smile.fr>
References: <cover.1778197991.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 08 May 2026 07:13:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19477

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Since python 3.9, ast can generate code from an ast. We can therefore
drop codegen.py and use python's internal functionality for this.

[YOCTO #16229]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 76dd6d69c59c1686be2dfb3fc5b72c2a9df34871)
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/bb/codeparser.py |   5 +-
 lib/codegen.py       | 564 -------------------------------------------
 2 files changed, 2 insertions(+), 567 deletions(-)
 delete mode 100644 lib/codegen.py

diff --git a/lib/bb/codeparser.py b/lib/bb/codeparser.py
index 4f70cf7fe..f906afab4 100644
--- a/lib/bb/codeparser.py
+++ b/lib/bb/codeparser.py
@@ -25,7 +25,6 @@ recipe caches don't trigger "Taskhash mismatch" errors.
 
 import ast
 import sys
-import codegen
 import logging
 import inspect
 import bb.pysh as pysh
@@ -263,8 +262,8 @@ class PythonParser():
         """
 
         try:
-            funcstr = codegen.to_source(func)
-            argstr = codegen.to_source(arg)
+            funcstr = ast.unparse(func)
+            argstr = ast.unparse(arg)
         except TypeError:
             self.log.debug2('Failed to convert function and argument to source form')
         else:
diff --git a/lib/codegen.py b/lib/codegen.py
deleted file mode 100644
index 018b28317..000000000
--- a/lib/codegen.py
+++ /dev/null
@@ -1,564 +0,0 @@
-# -*- coding: utf-8 -*-
-"""
-    codegen
-    ~~~~~~~
-
-    Extension to ast that allow ast -> python code generation.
-
-    :copyright: Copyright 2008 by Armin Ronacher.
-    :license: BSD.
-"""
-from ast import *
-
-BOOLOP_SYMBOLS = {
-    And:        'and',
-    Or:         'or'
-}
-
-BINOP_SYMBOLS = {
-    Add:        '+',
-    Sub:        '-',
-    Mult:       '*',
-    Div:        '/',
-    FloorDiv:   '//',
-    Mod:        '%',
-    LShift:     '<<',
-    RShift:     '>>',
-    BitOr:      '|',
-    BitAnd:     '&',
-    BitXor:     '^'
-}
-
-CMPOP_SYMBOLS = {
-    Eq:         '==',
-    Gt:         '>',
-    GtE:        '>=',
-    In:         'in',
-    Is:         'is',
-    IsNot:      'is not',
-    Lt:         '<',
-    LtE:        '<=',
-    NotEq:      '!=',
-    NotIn:      'not in'
-}
-
-UNARYOP_SYMBOLS = {
-    Invert:     '~',
-    Not:        'not',
-    UAdd:       '+',
-    USub:       '-'
-}
-
-ALL_SYMBOLS = {}
-ALL_SYMBOLS.update(BOOLOP_SYMBOLS)
-ALL_SYMBOLS.update(BINOP_SYMBOLS)
-ALL_SYMBOLS.update(CMPOP_SYMBOLS)
-ALL_SYMBOLS.update(UNARYOP_SYMBOLS)
-
-def to_source(node, indent_with=' ' * 4, add_line_information=False):
-    """This function can convert a node tree back into python sourcecode.
-    This is useful for debugging purposes, especially if you're dealing with
-    custom asts not generated by python itself.
-
-    It could be that the sourcecode is evaluable when the AST itself is not
-    compilable / evaluable.  The reason for this is that the AST contains some
-    more data than regular sourcecode does, which is dropped during
-    conversion.
-
-    Each level of indentation is replaced with `indent_with`.  Per default this
-    parameter is equal to four spaces as suggested by PEP 8, but it might be
-    adjusted to match the application's styleguide.
-
-    If `add_line_information` is set to `True` comments for the line numbers
-    of the nodes are added to the output.  This can be used to spot wrong line
-    number information of statement nodes.
-    """
-    generator = SourceGenerator(indent_with, add_line_information)
-    generator.visit(node)
-    return ''.join(generator.result)
-
-
-class SourceGenerator(NodeVisitor):
-    """This visitor is able to transform a well formed syntax tree into python
-    sourcecode.  For more details have a look at the docstring of the
-    `node_to_source` function.
-    """
-
-    def __init__(self, indent_with, add_line_information=False):
-        self.result = []
-        self.indent_with = indent_with
-        self.add_line_information = add_line_information
-        self.indentation = 0
-        self.new_lines = 0
-
-    def write(self, x):
-        if self.new_lines:
-            if self.result:
-                self.result.append('\n' * self.new_lines)
-            self.result.append(self.indent_with * self.indentation)
-            self.new_lines = 0
-        self.result.append(x)
-
-    def newline(self, node=None, extra=0):
-        self.new_lines = max(self.new_lines, 1 + extra)
-        if node is not None and self.add_line_information:
-            self.write('# line: %s' % node.lineno)
-            self.new_lines = 1
-
-    def body(self, statements):
-        self.new_line = True
-        self.indentation += 1
-        for stmt in statements:
-            self.visit(stmt)
-        self.indentation -= 1
-
-    def body_or_else(self, node):
-        self.body(node.body)
-        if node.orelse:
-            self.newline()
-            self.write('else:')
-            self.body(node.orelse)
-
-    def signature(self, node):
-        want_comma = []
-        def write_comma():
-            if want_comma:
-                self.write(', ')
-            else:
-                want_comma.append(True)
-
-        padding = [None] * (len(node.args) - len(node.defaults))
-        for arg, default in zip(node.args, padding + node.defaults):
-            write_comma()
-            self.visit(arg)
-            if default is not None:
-                self.write('=')
-                self.visit(default)
-        if node.vararg is not None:
-            write_comma()
-            self.write('*' + node.vararg)
-        if node.kwarg is not None:
-            write_comma()
-            self.write('**' + node.kwarg)
-
-    def decorators(self, node):
-        for decorator in node.decorator_list:
-            self.newline(decorator)
-            self.write('@')
-            self.visit(decorator)
-
-    # Statements
-
-    def visit_Assign(self, node):
-        self.newline(node)
-        for idx, target in enumerate(node.targets):
-            if idx:
-                self.write(', ')
-            self.visit(target)
-        self.write(' = ')
-        self.visit(node.value)
-
-    def visit_AugAssign(self, node):
-        self.newline(node)
-        self.visit(node.target)
-        self.write(BINOP_SYMBOLS[type(node.op)] + '=')
-        self.visit(node.value)
-
-    def visit_ImportFrom(self, node):
-        self.newline(node)
-        self.write('from %s%s import ' % ('.' * node.level, node.module))
-        for idx, item in enumerate(node.names):
-            if idx:
-                self.write(', ')
-            self.write(item)
-
-    def visit_Import(self, node):
-        self.newline(node)
-        for item in node.names:
-            self.write('import ')
-            self.visit(item)
-
-    def visit_Expr(self, node):
-        self.newline(node)
-        self.generic_visit(node)
-
-    def visit_FunctionDef(self, node):
-        self.newline(extra=1)
-        self.decorators(node)
-        self.newline(node)
-        self.write('def %s(' % node.name)
-        self.signature(node.args)
-        self.write('):')
-        self.body(node.body)
-
-    def visit_ClassDef(self, node):
-        have_args = []
-        def paren_or_comma():
-            if have_args:
-                self.write(', ')
-            else:
-                have_args.append(True)
-                self.write('(')
-
-        self.newline(extra=2)
-        self.decorators(node)
-        self.newline(node)
-        self.write('class %s' % node.name)
-        for base in node.bases:
-            paren_or_comma()
-            self.visit(base)
-        # XXX: the if here is used to keep this module compatible
-        #      with python 2.6.
-        if hasattr(node, 'keywords'):
-            for keyword in node.keywords:
-                paren_or_comma()
-                self.write(keyword.arg + '=')
-                self.visit(keyword.value)
-            if hasattr(node, 'starargs') and node.starargs is not None:
-                paren_or_comma()
-                self.write('*')
-                self.visit(node.starargs)
-            if hasattr(node, 'kwargs') and node.kwargs is not None:
-                paren_or_comma()
-                self.write('**')
-                self.visit(node.kwargs)
-        self.write(have_args and '):' or ':')
-        self.body(node.body)
-
-    def visit_If(self, node):
-        self.newline(node)
-        self.write('if ')
-        self.visit(node.test)
-        self.write(':')
-        self.body(node.body)
-        while True:
-            else_ = node.orelse
-            if len(else_) == 1 and isinstance(else_[0], If):
-                node = else_[0]
-                self.newline()
-                self.write('elif ')
-                self.visit(node.test)
-                self.write(':')
-                self.body(node.body)
-            else:
-                self.newline()
-                self.write('else:')
-                self.body(else_)
-                break
-
-    def visit_For(self, node):
-        self.newline(node)
-        self.write('for ')
-        self.visit(node.target)
-        self.write(' in ')
-        self.visit(node.iter)
-        self.write(':')
-        self.body_or_else(node)
-
-    def visit_While(self, node):
-        self.newline(node)
-        self.write('while ')
-        self.visit(node.test)
-        self.write(':')
-        self.body_or_else(node)
-
-    def visit_With(self, node):
-        self.newline(node)
-        self.write('with ')
-        self.visit(node.context_expr)
-        if node.optional_vars is not None:
-            self.write(' as ')
-            self.visit(node.optional_vars)
-        self.write(':')
-        self.body(node.body)
-
-    def visit_Pass(self, node):
-        self.newline(node)
-        self.write('pass')
-
-    def visit_Print(self, node):
-        # XXX: python 2.6 only
-        self.newline(node)
-        self.write('print ')
-        want_comma = False
-        if node.dest is not None:
-            self.write(' >> ')
-            self.visit(node.dest)
-            want_comma = True
-        for value in node.values:
-            if want_comma:
-                self.write(', ')
-            self.visit(value)
-            want_comma = True
-        if not node.nl:
-            self.write(',')
-
-    def visit_Delete(self, node):
-        self.newline(node)
-        self.write('del ')
-        for idx, target in enumerate(node):
-            if idx:
-                self.write(', ')
-            self.visit(target)
-
-    def visit_TryExcept(self, node):
-        self.newline(node)
-        self.write('try:')
-        self.body(node.body)
-        for handler in node.handlers:
-            self.visit(handler)
-
-    def visit_TryFinally(self, node):
-        self.newline(node)
-        self.write('try:')
-        self.body(node.body)
-        self.newline(node)
-        self.write('finally:')
-        self.body(node.finalbody)
-
-    def visit_Global(self, node):
-        self.newline(node)
-        self.write('global ' + ', '.join(node.names))
-
-    def visit_Nonlocal(self, node):
-        self.newline(node)
-        self.write('nonlocal ' + ', '.join(node.names))
-
-    def visit_Return(self, node):
-        self.newline(node)
-        self.write('return ')
-        self.visit(node.value)
-
-    def visit_Break(self, node):
-        self.newline(node)
-        self.write('break')
-
-    def visit_Continue(self, node):
-        self.newline(node)
-        self.write('continue')
-
-    def visit_Raise(self, node):
-        # XXX: Python 2.6 / 3.0 compatibility
-        self.newline(node)
-        self.write('raise')
-        if hasattr(node, 'exc') and node.exc is not None:
-            self.write(' ')
-            self.visit(node.exc)
-            if node.cause is not None:
-                self.write(' from ')
-                self.visit(node.cause)
-        elif hasattr(node, 'type') and node.type is not None:
-            self.visit(node.type)
-            if node.inst is not None:
-                self.write(', ')
-                self.visit(node.inst)
-            if node.tback is not None:
-                self.write(', ')
-                self.visit(node.tback)
-
-    # Expressions
-
-    def visit_Attribute(self, node):
-        self.visit(node.value)
-        self.write('.' + node.attr)
-
-    def visit_Call(self, node):
-        want_comma = []
-        def write_comma():
-            if want_comma:
-                self.write(', ')
-            else:
-                want_comma.append(True)
-
-        self.visit(node.func)
-        self.write('(')
-        for arg in node.args:
-            write_comma()
-            self.visit(arg)
-        for keyword in node.keywords:
-            write_comma()
-            self.write(keyword.arg + '=')
-            self.visit(keyword.value)
-        if hasattr(node, 'starargs') and node.starargs is not None:
-            write_comma()
-            self.write('*')
-            self.visit(node.starargs)
-        if hasattr(node, 'kwargs') and node.kwargs is not None:
-            write_comma()
-            self.write('**')
-            self.visit(node.kwargs)
-        self.write(')')
-
-    def visit_Name(self, node):
-        self.write(node.id)
-
-    def visit_Constant(self, node):
-        self.write(repr(node.value))
-
-    def visit_Tuple(self, node):
-        self.write('(')
-        idx = -1
-        for idx, item in enumerate(node.elts):
-            if idx:
-                self.write(', ')
-            self.visit(item)
-        self.write(idx and ')' or ',)')
-
-    def sequence_visit(left, right):
-        def visit(self, node):
-            self.write(left)
-            for idx, item in enumerate(node.elts):
-                if idx:
-                    self.write(', ')
-                self.visit(item)
-            self.write(right)
-        return visit
-
-    visit_List = sequence_visit('[', ']')
-    visit_Set = sequence_visit('{', '}')
-    del sequence_visit
-
-    def visit_Dict(self, node):
-        self.write('{')
-        for idx, (key, value) in enumerate(zip(node.keys, node.values)):
-            if idx:
-                self.write(', ')
-            self.visit(key)
-            self.write(': ')
-            self.visit(value)
-        self.write('}')
-
-    def visit_BinOp(self, node):
-        self.visit(node.left)
-        self.write(' %s ' % BINOP_SYMBOLS[type(node.op)])
-        self.visit(node.right)
-
-    def visit_BoolOp(self, node):
-        self.write('(')
-        for idx, value in enumerate(node.values):
-            if idx:
-                self.write(' %s ' % BOOLOP_SYMBOLS[type(node.op)])
-            self.visit(value)
-        self.write(')')
-
-    def visit_Compare(self, node):
-        self.write('(')
-        self.write(node.left)
-        for op, right in zip(node.ops, node.comparators):
-            self.write(' %s %%' % CMPOP_SYMBOLS[type(op)])
-            self.visit(right)
-        self.write(')')
-
-    def visit_UnaryOp(self, node):
-        self.write('(')
-        op = UNARYOP_SYMBOLS[type(node.op)]
-        self.write(op)
-        if op == 'not':
-            self.write(' ')
-        self.visit(node.operand)
-        self.write(')')
-
-    def visit_Subscript(self, node):
-        self.visit(node.value)
-        self.write('[')
-        self.visit(node.slice)
-        self.write(']')
-
-    def visit_Slice(self, node):
-        if node.lower is not None:
-            self.visit(node.lower)
-        self.write(':')
-        if node.upper is not None:
-            self.visit(node.upper)
-        if node.step is not None:
-            self.write(':')
-            if not (isinstance(node.step, Name) and node.step.id == 'None'):
-                self.visit(node.step)
-
-    def visit_ExtSlice(self, node):
-        for idx, item in node.dims:
-            if idx:
-                self.write(', ')
-            self.visit(item)
-
-    def visit_Yield(self, node):
-        self.write('yield ')
-        self.visit(node.value)
-
-    def visit_Lambda(self, node):
-        self.write('lambda ')
-        self.signature(node.args)
-        self.write(': ')
-        self.visit(node.body)
-
-    def visit_Ellipsis(self, node):
-        self.write('Ellipsis')
-
-    def generator_visit(left, right):
-        def visit(self, node):
-            self.write(left)
-            self.visit(node.elt)
-            for comprehension in node.generators:
-                self.visit(comprehension)
-            self.write(right)
-        return visit
-
-    visit_ListComp = generator_visit('[', ']')
-    visit_GeneratorExp = generator_visit('(', ')')
-    visit_SetComp = generator_visit('{', '}')
-    del generator_visit
-
-    def visit_DictComp(self, node):
-        self.write('{')
-        self.visit(node.key)
-        self.write(': ')
-        self.visit(node.value)
-        for comprehension in node.generators:
-            self.visit(comprehension)
-        self.write('}')
-
-    def visit_IfExp(self, node):
-        self.visit(node.body)
-        self.write(' if ')
-        self.visit(node.test)
-        self.write(' else ')
-        self.visit(node.orelse)
-
-    def visit_Starred(self, node):
-        self.write('*')
-        self.visit(node.value)
-
-    def visit_Repr(self, node):
-        # XXX: python 2.6 only
-        self.write('`')
-        self.visit(node.value)
-        self.write('`')
-
-    # Helper Nodes
-
-    def visit_alias(self, node):
-        self.write(node.name)
-        if node.asname is not None:
-            self.write(' as ' + node.asname)
-
-    def visit_comprehension(self, node):
-        self.write(' for ')
-        self.visit(node.target)
-        self.write(' in ')
-        self.visit(node.iter)
-        if node.ifs:
-            for if_ in node.ifs:
-                self.write(' if ')
-                self.visit(if_)
-
-    def visit_excepthandler(self, node):
-        self.newline(node)
-        self.write('except')
-        if node.type is not None:
-            self.write(' ')
-            self.visit(node.type)
-            if node.name is not None:
-                self.write(' as ')
-                self.visit(node.name)
-        self.write(':')
-        self.body(node.body)

