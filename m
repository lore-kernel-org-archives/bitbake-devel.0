Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E40FDEE44
	for <webhook@archiver.kernel.org>; Thu, 23 Apr 2026 18:41:13 +0000 (UTC)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4891.1776969666352030673
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 23 Apr 2026 11:41:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=gWGSFcgN;
 spf=pass (domain: gmail.com, ip: 209.85.219.51, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8a151012558so75192836d6.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 23 Apr 2026 11:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776969665; x=1777574465; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hVzuzOoMCPAkWuirkJAmWv988q9eobGLcJNKe/DeQcU=;
        b=gWGSFcgNwmimOH1lH94Fh5Ac5n54uamieOZNMAxx0mvEBrJlTfMWXPA97I3QBD/VM3
         /Z8S040XqXB7PdiJyBOa8xAbHDU231qWUtt9D/PmRkFvC2B5S3sEJL57tRXC8XSZYOBp
         qjjZFfkC5HFx8lEevIydgtBH3ATYvbB28TDMh05tgRKungeEEoTvrbpvcrunelt3OwYZ
         oV6KXGPRtaJBtrtiSYqJQYEKsbpG85A4ntJ2mMoz+QsIu6ZbkhWMydEVfo6old1bA1s+
         acDmhsHPtG+0gLz6oESySisgzKYMrs0jV5qHG8OuGNu4GlLOwzP7WPOlzwTn7DNBJgY+
         7gBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776969665; x=1777574465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hVzuzOoMCPAkWuirkJAmWv988q9eobGLcJNKe/DeQcU=;
        b=TxxFAO4dnMODfj9aY12Helmc4RcpqCtCDmFuB9j8ZkhhTe3jmQcdaWxWc7FpaKUr5r
         fddYK9COaKZlXuL/W9l8l05Ha/KTRrJwgQR5jTreLCyaEPVDOcPGxKEPPPqnGjVWvq2U
         E0xYg6BK+hxxVxxPZ2+JE0+DZ3wFKbHOjMCiaeFHh6fn6xUmXBfW5WURW5hAvKCLqnBa
         sbePFoVHiDGfe+7+MaGtFbKfa8DzH7AwemW5evCkY7U9XFurvbcsAkEA3BPDM5iRIQCJ
         5u6Ds6Mj5oSuujCLDRGQ2d9pMBaU123QMssdaLZmbCbdPyFKadpKY0EmwQycp3kiD+zb
         LpcQ==
X-Gm-Message-State: AOJu0YxDzrn/Cu/JL++yL/+TmD7Au0he5131ItM1Ssj4gqjArshpfOZY
	G+n816K783KAoY0gf72C9XKWidOezSYJkbzSbCCI7ozVAODnARypGkEWOc5Rdw==
X-Gm-Gg: AeBDieuQV3T7virX1EUMSvCY2r7d/7rLa06o9TpFvJIo92Y3zSaz869ASyPs/U8dNje
	gUtZM9Gyfj9ulfCaSrhjuIT4B1udtTu/sbiytWm8Sj6YKqA8hhgTOOMjK+V0sxuQ5v0mh0+EJGd
	dBheCbar4Wxl9w0DsSDrze4e9DjpJ450NRXDWzdDi5Ot+zHnkbu3UUA4Xyhl28rFDIXJK7X3LLP
	ekL9WmfaC5ewIUl9K/Vgwu/5p5rzQl80Q5fKJfKKfaE2K02xu4wIE2CanS7I5x8MJ2q10z7Pidr
	mMw0+/GIJbU2xhebE5x1HhxdiTPuCBJbdJR3olPYFxB+XUsQZ8Lj6V3OLUwxSai7DUvBX7rJ9nE
	LX2i+QTUdwJx1A6phWatYbvUVNIxUysOG+gri6Wk/rcSJSJlmDlOzYKb8c1nnG+rBjNvixnPHy5
	EofSCYXbipTsT5sM8sKoI9hJl5WI6c/iANLj5dJXmJm26AHLevW8k6vJc6sSyoViXM6Ttph/mO2
	hn2
X-Received: by 2002:a05:6214:5d82:b0:8ac:ae4d:7de3 with SMTP id 6a1803df08f44-8b02808005emr460803876d6.22.1776969664187;
        Thu, 23 Apr 2026 11:41:04 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ae5c4b9sm221759596d6.28.2026.04.23.11.41.02
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 11:41:02 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] contrib/vim: remove
Date: Thu, 23 Apr 2026 14:40:57 -0400
Message-ID: <20260423184057.2099941-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 23 Apr 2026 18:41:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19384

Vim already includes support for bitbake syntax highlighting. This
support was first added in vim commit b529cfb[1] and has been kept
up-to-date ever since:

  - 2041478e2a4f 2026-04-15 "support forward-slashes in bitbake varflags"
  - 15e988810e7f 2026-04-07 "Update syntax script"
  - 5fe4faa711b5 2025-10-13 "fix multiline Python function parameter syntax"
  - b529cfbd04c0 2022-07-25 initial import

Initial support for bitbake syntax highlighting in upstream vim made it
into release 9.0.0067; major release 9.1.0000.

Features that bitbake's code supports that upstream vim does not:

  - bbStatementRestCont: a dedicated region that highlights addtask /
    EXPORT_FUNCTIONS / etc. lines that wrap with trailing \. Vim's
    runtime collapsed this back to a single-line rule, so multi-line
    statement lines do not highlight properly there.
  - bbIncludeRest still contains bbVarPyValue (so ${@…} python
    expressions inside inherit/require/include paths get
    highlighted). Vim's runtime dropped that, leaving only
    bbString,bbVarDeref.

[1] https://github.com/vim/vim/commit/b529cfbd04c02e31cfa88f2c8d88b5ff532d4f7d

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 contrib/vim/LICENSE.txt            |  18 --
 contrib/vim/ftdetect/bitbake.vim   |  32 ---
 contrib/vim/ftplugin/bitbake.vim   |  13 --
 contrib/vim/indent/bitbake.vim     | 343 -----------------------------
 contrib/vim/plugin/newbb.vim       |  88 --------
 contrib/vim/plugin/newbbappend.vim |  46 ----
 contrib/vim/syntax/bitbake.vim     | 131 -----------
 7 files changed, 671 deletions(-)
 delete mode 100644 contrib/vim/LICENSE.txt
 delete mode 100644 contrib/vim/ftdetect/bitbake.vim
 delete mode 100644 contrib/vim/ftplugin/bitbake.vim
 delete mode 100644 contrib/vim/indent/bitbake.vim
 delete mode 100644 contrib/vim/plugin/newbb.vim
 delete mode 100644 contrib/vim/plugin/newbbappend.vim
 delete mode 100644 contrib/vim/syntax/bitbake.vim

diff --git a/contrib/vim/LICENSE.txt b/contrib/vim/LICENSE.txt
deleted file mode 100644
index c7d915024d9f..000000000000
--- a/contrib/vim/LICENSE.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-The MIT License (MIT)
-
-Permission is hereby granted, free of charge, to any person obtaining a copy of
-this software and associated documentation files (the "Software"), to deal in
-the Software without restriction, including without limitation the rights to
-use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
-the Software, and to permit persons to whom the Software is furnished to do so,
-subject to the following conditions:
-
-The above copyright notice and this permission notice shall be included in all
-copies or substantial portions of the Software.
-
-THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
-FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
-COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
-IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
-CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
diff --git a/contrib/vim/ftdetect/bitbake.vim b/contrib/vim/ftdetect/bitbake.vim
deleted file mode 100644
index 1d958fec5477..000000000000
--- a/contrib/vim/ftdetect/bitbake.vim
+++ /dev/null
@@ -1,32 +0,0 @@
-" Vim filetype detection file
-" Language:     BitBake
-" Author:       Ricardo Salveti <rsalveti@rsalveti.net>
-" Copyright:    Copyright (C) 2008  Ricardo Salveti <rsalveti@rsalveti.net>
-" Licence:      You may redistribute this under the same terms as Vim itself
-"
-" This sets up the syntax highlighting for BitBake files, like .bb, .bbclass and .inc
-
-if &compatible || version < 600 || exists("b:loaded_bitbake_plugin")
-    finish
-endif
-
-" .bb, .bbappend and .bbclass
-au BufNewFile,BufRead *.{bb,bbappend,bbclass}  setfiletype bitbake
-
-" .inc -- meanwhile included upstream
-if !has("patch-9.1.1732")
-    au BufNewFile,BufRead *.inc                call s:BBIncDetect()
-    def s:BBIncDetect()
-        var lines = getline(1) .. getline(2) .. getline(3)
-        if lines =~# '\<\%(require\|inherit\)\>' || lines =~# '[A-Z][A-Za-z0-9_:${}/]*\s\+\%(??\|[?:+.]\)\?=.\? '
-            set filetype=bitbake
-        endif
-    enddef
-endif
-
-" .conf
-au BufNewFile,BufRead *.conf
-    \ if (match(expand("%:p:h"), "conf") > 0) |
-    \     set filetype=bitbake |
-    \ endif
-
diff --git a/contrib/vim/ftplugin/bitbake.vim b/contrib/vim/ftplugin/bitbake.vim
deleted file mode 100644
index 9e8d3e13cee4..000000000000
--- a/contrib/vim/ftplugin/bitbake.vim
+++ /dev/null
@@ -1,13 +0,0 @@
-" Only do this when not done yet for this buffer
-if exists("b:did_ftplugin")
-  finish
-endif
-
-" Don't load another plugin for this buffer
-let b:did_ftplugin = 1
-
-let b:undo_ftplugin = "setl cms< sts< sw< et< sua<"
-
-setlocal commentstring=#\ %s
-setlocal softtabstop=4 shiftwidth=4 expandtab
-setlocal suffixesadd+=.bb,.bbclass
diff --git a/contrib/vim/indent/bitbake.vim b/contrib/vim/indent/bitbake.vim
deleted file mode 100644
index 7ee9d699381e..000000000000
--- a/contrib/vim/indent/bitbake.vim
+++ /dev/null
@@ -1,343 +0,0 @@
-" Vim indent file
-" Language:             BitBake
-" Copyright:            Copyright (C) 2019 Agilent Technologies, Inc.
-" Maintainer:           Chris Laplante <chris.laplante@agilent.com>
-" License:              You may redistribute this under the same terms as Vim itself
-
-
-if exists("b:did_indent")
-    finish
-endif
-
-if exists("*BitbakeIndent")
-    finish
-endif
-
-runtime! indent/sh.vim
-unlet b:did_indent
-
-setlocal indentexpr=BitbakeIndent(v:lnum)
-setlocal autoindent nolisp
-
-function s:is_bb_python_func_def(lnum)
-    let stack = synstack(a:lnum, 1)
-    if len(stack) == 0
-        return 0
-    endif
-
-    let top = synIDattr(stack[0], "name")
-    echo top
-
-    return synIDattr(stack[0], "name") == "bbPyFuncDef"
-endfunction
-
-"""" begin modified from indent/python.vim, upstream commit 7a9bd7c1e0ce1baf5a02daf36eeae3638aa315c7
-"""" This copied code is licensed the same as Vim itself.
-setlocal indentkeys+=<:>,=elif,=except
-
-let s:keepcpo= &cpo
-set cpo&vim
-
-let s:maxoff = 50	" maximum number of lines to look backwards for ()
-
-function! GetBBPythonIndent(lnum)
-
-  " If this line is explicitly joined: If the previous line was also joined,
-  " line it up with that one, otherwise add two 'shiftwidth'
-  if getline(a:lnum - 1) =~ '\\$'
-    if a:lnum > 1 && getline(a:lnum - 2) =~ '\\$'
-      return indent(a:lnum - 1)
-    endif
-    return indent(a:lnum - 1) + (exists("g:pyindent_continue") ? eval(g:pyindent_continue) : (shiftwidth() * 2))
-  endif
-
-  " If the start of the line is in a string don't change the indent.
-  if has('syntax_items')
-	\ && synIDattr(synID(a:lnum, 1, 1), "name") =~ "String$"
-    return -1
-  endif
-
-  " Search backwards for the previous non-empty line.
-  let plnum = prevnonblank(v:lnum - 1)
-
-  if plnum == 0
-    " This is the first non-empty line, use zero indent.
-    return 0
-  endif
-
-  call cursor(plnum, 1)
-
-  " Identing inside parentheses can be very slow, regardless of the searchpair()
-  " timeout, so let the user disable this feature if he doesn't need it
-  let disable_parentheses_indenting = get(g:, "pyindent_disable_parentheses_indenting", 0)
-
-  if disable_parentheses_indenting == 1
-    let plindent = indent(plnum)
-    let plnumstart = plnum
-  else
-    " searchpair() can be slow sometimes, limit the time to 150 msec or what is
-    " put in g:pyindent_searchpair_timeout
-    let searchpair_stopline = 0
-    let searchpair_timeout = get(g:, 'pyindent_searchpair_timeout', 150)
-
-    " If the previous line is inside parenthesis, use the indent of the starting
-    " line.
-    " Trick: use the non-existing "dummy" variable to break out of the loop when
-    " going too far back.
-    let parlnum = searchpair('(\|{\|\[', '', ')\|}\|\]', 'nbW',
-            \ "line('.') < " . (plnum - s:maxoff) . " ? dummy :"
-            \ . " synIDattr(synID(line('.'), col('.'), 1), 'name')"
-            \ . " =~ '\\(Comment\\|Todo\\|String\\)$'",
-            \ searchpair_stopline, searchpair_timeout)
-    if parlnum > 0
-      " We may have found the opening brace of a BitBake Python task, e.g. 'python do_task {'
-      " If so, ignore it here - it will be handled later.
-      if s:is_bb_python_func_def(parlnum)
-        let parlnum = 0
-        let plindent = indent(plnum)
-        let plnumstart = plnum
-      else
-        let plindent = indent(parlnum)
-        let plnumstart = parlnum
-      endif
-    else
-      let plindent = indent(plnum)
-      let plnumstart = plnum
-    endif
-
-    " When inside parenthesis: If at the first line below the parenthesis add
-    " two 'shiftwidth', otherwise same as previous line.
-    " i = (a
-    "       + b
-    "       + c)
-    call cursor(a:lnum, 1)
-    let p = searchpair('(\|{\|\[', '', ')\|}\|\]', 'bW',
-            \ "line('.') < " . (a:lnum - s:maxoff) . " ? dummy :"
-            \ . " synIDattr(synID(line('.'), col('.'), 1), 'name')"
-            \ . " =~ '\\(Comment\\|Todo\\|String\\)$'",
-            \ searchpair_stopline, searchpair_timeout)
-    if p > 0
-        if s:is_bb_python_func_def(p)
-          " Handle first non-empty line inside a BB Python task
-          if p == plnum
-              return shiftwidth()
-          endif
-
-          " Handle the user actually trying to close a BitBake Python task
-          let line = getline(a:lnum)
-          if line =~ '^\s*}'
-              return -2
-          endif
-
-          " Otherwise ignore the brace
-          let p = 0
-        else
-          if p == plnum
-            " When the start is inside parenthesis, only indent one 'shiftwidth'.
-            let pp = searchpair('(\|{\|\[', '', ')\|}\|\]', 'bW',
-                \ "line('.') < " . (a:lnum - s:maxoff) . " ? dummy :"
-                \ . " synIDattr(synID(line('.'), col('.'), 1), 'name')"
-                \ . " =~ '\\(Comment\\|Todo\\|String\\)$'",
-                \ searchpair_stopline, searchpair_timeout)
-            if pp > 0
-              return indent(plnum) + (exists("g:pyindent_nested_paren") ? eval(g:pyindent_nested_paren) : shiftwidth())
-            endif
-            return indent(plnum) + (exists("g:pyindent_open_paren") ? eval(g:pyindent_open_paren) : (shiftwidth() * 2))
-          endif
-          if plnumstart == p
-            return indent(plnum)
-          endif
-          return plindent
-        endif
-    endif
-
-  endif
-
-
-  " Get the line and remove a trailing comment.
-  " Use syntax highlighting attributes when possible.
-  let pline = getline(plnum)
-  let pline_len = strlen(pline)
-  if has('syntax_items')
-    " If the last character in the line is a comment, do a binary search for
-    " the start of the comment.  synID() is slow, a linear search would take
-    " too long on a long line.
-    if synIDattr(synID(plnum, pline_len, 1), "name") =~ "\\(Comment\\|Todo\\)$"
-      let min = 1
-      let max = pline_len
-      while min < max
-	let col = (min + max) / 2
-	if synIDattr(synID(plnum, col, 1), "name") =~ "\\(Comment\\|Todo\\)$"
-	  let max = col
-	else
-	  let min = col + 1
-	endif
-      endwhile
-      let pline = strpart(pline, 0, min - 1)
-    endif
-  else
-    let col = 0
-    while col < pline_len
-      if pline[col] == '#'
-	let pline = strpart(pline, 0, col)
-	break
-      endif
-      let col = col + 1
-    endwhile
-  endif
-
-  " If the previous line ended with a colon, indent this line
-  if pline =~ ':\s*$'
-    return plindent + shiftwidth()
-  endif
-
-  " If the previous line was a stop-execution statement...
-  " TODO: utilize this logic to deindent when ending a bbPyDefRegion
-  if getline(plnum) =~ '^\s*\(break\|continue\|raise\|return\|pass\|bb\.fatal\)\>'
-    " See if the user has already dedented
-    if indent(a:lnum) > indent(plnum) - shiftwidth()
-      " If not, recommend one dedent
-      return indent(plnum) - shiftwidth()
-    endif
-    " Otherwise, trust the user
-    return -1
-  endif
-
-  " If the current line begins with a keyword that lines up with "try"
-  if getline(a:lnum) =~ '^\s*\(except\|finally\)\>'
-    let lnum = a:lnum - 1
-    while lnum >= 1
-      if getline(lnum) =~ '^\s*\(try\|except\)\>'
-	let ind = indent(lnum)
-	if ind >= indent(a:lnum)
-	  return -1	" indent is already less than this
-	endif
-	return ind	" line up with previous try or except
-      endif
-      let lnum = lnum - 1
-    endwhile
-    return -1		" no matching "try"!
-  endif
-
-  " If the current line begins with a header keyword, dedent
-  if getline(a:lnum) =~ '^\s*\(elif\|else\)\>'
-
-    " Unless the previous line was a one-liner
-    if getline(plnumstart) =~ '^\s*\(for\|if\|try\)\>'
-      return plindent
-    endif
-
-    " Or the user has already dedented
-    if indent(a:lnum) <= plindent - shiftwidth()
-      return -1
-    endif
-
-    return plindent - shiftwidth()
-  endif
-
-  " When after a () construct we probably want to go back to the start line.
-  " a = (b
-  "       + c)
-  " here
-  if parlnum > 0
-    return plindent
-  endif
-
-  return -1
-
-endfunction
-
-let &cpo = s:keepcpo
-unlet s:keepcpo
-
-""" end of stuff from indent/python.vim
-
-
-let b:did_indent = 1
-setlocal indentkeys+=0\"
-
-
-function! BitbakeIndent(lnum)
-    if !has('syntax_items')
-        return -1
-    endif
-
-    let stack = synstack(a:lnum, 1)
-    if len(stack) == 0
-        return -1
-    endif
-
-    let name = synIDattr(stack[0], "name")
-
-    " TODO: support different styles of indentation for assignments. For now,
-    " we only support like this:
-    " VAR = " \
-    "     value1 \
-    "     value2 \
-    " "
-    "
-    " i.e. each value indented by shiftwidth(), with the final quote " completely unindented.
-    if name == "bbVarValue"
-        " Quote handling is tricky. kernel.bbclass has this line for instance:
-        "     EXTRA_OEMAKE = " HOSTCC="${BUILD_CC} ${BUILD_CFLAGS} ${BUILD_LDFLAGS}" " HOSTCPP="${BUILD_CPP}""
-        " Instead of trying to handle crazy cases like that, just assume that a
-        " double-quote on a line by itself (following an assignment) means the
-        " user is closing the assignment, and de-dent.
-        if getline(a:lnum) =~ '^\s*"$'
-            return 0
-        endif
-
-        let prevstack = synstack(a:lnum - 1, 1)
-        if len(prevstack) == 0
-            return -1
-        endif
-
-        let prevname = synIDattr(prevstack[0], "name")
-
-        " Only indent if there was actually a continuation character on
-        " the previous line, to avoid misleading indentation.
-        let prevlinelastchar = synIDattr(synID(a:lnum - 1, col([a:lnum - 1, "$"]) - 1, 1), "name")
-        let prev_continued = prevlinelastchar == "bbContinue"
-
-        " Did the previous line introduce an assignment?
-        if index(["bbVarDef", "bbVarFlagDef"], prevname) != -1
-            if prev_continued
-                return shiftwidth()
-            endif
-        endif
-
-        if !prev_continued
-            return 0
-        endif
-
-        " Autoindent can take it from here
-        return -1
-    endif
-
-    if index(["bbPyDefRegion", "bbPyFuncRegion"], name) != -1
-        let ret = GetBBPythonIndent(a:lnum)
-        " Should normally always be indented by at least one shiftwidth; but allow
-        " return of -1 (defer to autoindent) or -2 (force indent to 0)
-        if ret == 0
-            return shiftwidth()
-        elseif ret == -2
-            return 0
-        endif
-        return ret
-    endif
-
-    " TODO: GetShIndent doesn't detect tasks prepended with 'fakeroot'
-    " Need to submit a patch upstream to Vim to provide an extension point.
-    " Unlike the Python indenter, the Sh indenter is way too large to copy and
-    " modify here.
-    if name == "bbShFuncRegion"
-        return GetShIndent()
-    endif
-
-    " TODO:
-    "   + heuristics for de-denting out of a bbPyDefRegion? e.g. when the user
-    "       types an obvious BB keyword like addhandler or addtask, or starts
-    "       writing a shell task. Maybe too hard to implement...
-
-    return -1
-endfunction
diff --git a/contrib/vim/plugin/newbb.vim b/contrib/vim/plugin/newbb.vim
deleted file mode 100644
index 3a4202736117..000000000000
--- a/contrib/vim/plugin/newbb.vim
+++ /dev/null
@@ -1,88 +0,0 @@
-" Vim plugin file
-" Purpose:	Create a template for new bb files
-" Author:	Ricardo Salveti <rsalveti@gmail.com>
-" Copyright:	Copyright (C) 2008 Ricardo Salveti <rsalveti@gmail.com>
-"
-" This file is licensed under the MIT license, see COPYING.MIT in
-" this source distribution for the terms.
-"
-" Based on the gentoo-syntax package
-"
-" Will try to use git to find the user name and email
-
-if &compatible || v:version < 600 || exists("b:loaded_bitbake_plugin")
-    finish
-endif
-
-fun! <SID>GetUserName()
-    let l:user_name = system("git config --get user.name")
-    if v:shell_error
-        return "Unknown User"
-    else
-        return substitute(l:user_name, "\n", "", "")
-endfun
-
-fun! <SID>GetUserEmail()
-    let l:user_email = system("git config --get user.email")
-    if v:shell_error
-        return "unknown@user.org"
-    else
-        return substitute(l:user_email, "\n", "", "")
-endfun
-
-fun! BBHeader()
-    let l:current_year = strftime("%Y")
-    let l:user_name = <SID>GetUserName()
-    let l:user_email = <SID>GetUserEmail()
-    0 put ='# Copyright (C) ' . l:current_year .
-                \ ' ' . l:user_name . ' <' . l:user_email . '>'
-    put ='# Released under the MIT license (see COPYING.MIT for the terms)'
-    $
-endfun
-
-fun! NewBBTemplate()
-    if line2byte(line('$') + 1) != -1
-        return
-    endif
-
-    let l:paste = &paste
-    set nopaste
-    
-    " Get the header
-    call BBHeader()
-
-    " New the bb template
-    put ='SUMMARY = \"\"'
-    put ='HOMEPAGE = \"\"'
-    put ='LICENSE = \"\"' 
-    put ='SECTION = \"\"'
-    put ='DEPENDS = \"\"'
-    put =''
-    put ='SRC_URI = \"\"'
-
-    " Go to the first place to edit
-    0
-    /^SUMMARY =/
-    exec "normal 2f\""
-
-    if paste == 1
-        set paste
-    endif
-endfun
-
-if !exists("g:bb_create_on_empty")
-    let g:bb_create_on_empty = 1
-endif
-
-" disable in case of vimdiff
-if v:progname =~ "vimdiff"
-    let g:bb_create_on_empty = 0
-endif
-
-augroup NewBB
-    au BufNewFile,BufReadPost *.bb
-                \ if g:bb_create_on_empty |
-                \    call NewBBTemplate() |
-                \ endif
-augroup END
-
diff --git a/contrib/vim/plugin/newbbappend.vim b/contrib/vim/plugin/newbbappend.vim
deleted file mode 100644
index 3f65f79cdccb..000000000000
--- a/contrib/vim/plugin/newbbappend.vim
+++ /dev/null
@@ -1,46 +0,0 @@
-" Vim plugin file
-" Purpose:	Create a template for new bbappend file
-" Author:	Joshua Watt <JPEWhacker@gmail.com>
-" Copyright:	Copyright (C) 2017 Joshua Watt <JPEWhacker@gmail.com>
-"
-" This file is licensed under the MIT license, see COPYING.MIT in
-" this source distribution for the terms.
-"
-
-if &compatible || v:version < 600 || exists("b:loaded_bitbake_plugin")
-    finish
-endif
-
-fun! NewBBAppendTemplate()
-    if line2byte(line('$') + 1) != -1
-        return
-    endif
-
-    let l:paste = &paste
-    set nopaste
-
-    " New bbappend template
-    0 put ='FILESEXTRAPATHS:prepend := \"${THISDIR}/${PN}:\"'
-    2
-
-    if paste == 1
-        set paste
-    endif
-endfun
-
-if !exists("g:bb_create_on_empty")
-    let g:bb_create_on_empty = 1
-endif
-
-" disable in case of vimdiff
-if v:progname =~ "vimdiff"
-    let g:bb_create_on_empty = 0
-endif
-
-augroup NewBBAppend
-    au BufNewFile,BufReadPost *.bbappend
-                \ if g:bb_create_on_empty |
-                \    call NewBBAppendTemplate() |
-                \ endif
-augroup END
-
diff --git a/contrib/vim/syntax/bitbake.vim b/contrib/vim/syntax/bitbake.vim
deleted file mode 100644
index 8f39b8f95115..000000000000
--- a/contrib/vim/syntax/bitbake.vim
+++ /dev/null
@@ -1,131 +0,0 @@
-" Vim syntax file
-" Language:     BitBake bb/bbclasses/inc
-" Author:       Chris Larson <kergoth@handhelds.org>
-"               Ricardo Salveti <rsalveti@rsalveti.net>
-" Copyright:    Copyright (C) 2004  Chris Larson <kergoth@handhelds.org>
-"               Copyright (C) 2008  Ricardo Salveti <rsalveti@rsalveti.net>
-"
-" This file is licensed under the MIT license, see COPYING.MIT in
-" this source distribution for the terms.
-"
-" Syntax highlighting for bb, bbclasses and inc files.
-"
-" It's an entirely new type, just has specific syntax in shell and python code
-
-if &compatible || v:version < 600 || exists("b:loaded_bitbake_plugin")
-    finish
-endif
-if exists("b:current_syntax")
-    finish
-endif
-
-syn include @python syntax/python.vim
-if exists("b:current_syntax")
-  unlet b:current_syntax
-endif
-
-" BitBake syntax
-
-" Matching case
-syn case match
-
-" Indicates the error when nothing is matched
-syn match bbUnmatched           "."
-
-" Comments
-syn cluster bbCommentGroup      contains=bbTodo,@Spell
-syn keyword bbTodo              COMBAK FIXME TODO XXX contained
-syn match bbComment             "#.*$" contains=@bbCommentGroup
-
-" String helpers
-syn match bbQuote               +['"]+ contained 
-syn match bbDelimiter           "[(){}=]" contained
-syn match bbArrayBrackets       "[\[\]]" contained
-
-" BitBake strings
-syn match bbContinue            "\\$"
-syn region bbString             matchgroup=bbQuote start=+"+ skip=+\\$+ end=+"+ contained contains=bbTodo,bbContinue,bbVarDeref,bbVarPyValue,@Spell
-syn region bbString             matchgroup=bbQuote start=+'+ skip=+\\$+ end=+'+ contained contains=bbTodo,bbContinue,bbVarDeref,bbVarPyValue,@Spell
-
-" Vars definition
-syn match bbExport            "^export" nextgroup=bbIdentifier skipwhite
-syn keyword bbExportFlag        export contained nextgroup=bbIdentifier skipwhite
-syn match bbIdentifier          "[a-zA-Z0-9\-_\.\/\+]\+" display contained
-syn match bbVarDeref            "${[a-zA-Z0-9\-_:\.\/\+]\+}" contained
-syn match bbVarEq               "\(:=\|+=\|=+\|\.=\|=\.\|?=\|??=\|=\)" contained nextgroup=bbVarValue
-syn match bbVarDef              "^\(export\s*\)\?\([a-zA-Z0-9\-_\.\/\+][${}a-zA-Z0-9\-_:\.\/\+]*\)\s*\(:=\|+=\|=+\|\.=\|=\.\|?=\|??=\|=\)\@=" contains=bbExportFlag,bbIdentifier,bbOverrideOperator,bbVarDeref nextgroup=bbVarEq
-syn match bbVarValue            ".*$" contained contains=bbString,bbVarDeref,bbVarPyValue
-syn region bbVarPyValue         start=+${@+ skip=+\\$+ end=+}+ contained contains=@python
-
-" Vars metadata flags
-syn match bbVarFlagDef          "^\([a-zA-Z0-9\-_\.]\+\)\(\[[a-zA-Z0-9\-_\.+]\+\]\)\@=" contains=bbIdentifier nextgroup=bbVarFlagFlag
-syn region bbVarFlagFlag        matchgroup=bbArrayBrackets start="\[" end="\]\s*\(:=\|=\|.=\|=.|+=\|=+\|?=\)\@=" contained contains=bbIdentifier nextgroup=bbVarEq
-
-" Includes and requires
-syn keyword bbInclude           inherit include require contained 
-syn match bbIncludeRest         ".*$" contained contains=bbString,bbVarDeref,bbVarPyValue
-syn match bbIncludeLine         "^\(inherit\|include\|require\)\s\+" contains=bbInclude nextgroup=bbIncludeRest
-
-" Add taks and similar
-syn keyword bbStatement         addtask deltask addhandler after before EXPORT_FUNCTIONS contained
-syn match bbStatementRest       /[^\\]*$/ skipwhite contained contains=bbStatement,bbVarDeref,bbVarPyValue
-syn region bbStatementRestCont  start=/.*\\$/ end=/^[^\\]*$/ contained contains=bbStatement,bbVarDeref,bbVarPyValue,bbContinue keepend
-syn match bbStatementLine       "^\(addtask\|deltask\|addhandler\|after\|before\|EXPORT_FUNCTIONS\)\s\+" contains=bbStatement nextgroup=bbStatementRest,bbStatementRestCont
-
-" OE Important Functions
-syn keyword bbOEFunctions       do_fetch do_unpack do_patch do_configure do_compile do_stage do_install do_package contained
-
-" Generic Functions
-syn match bbFunction            "\h[0-9A-Za-z_\-\.]*" display contained contains=bbOEFunctions
-
-syn keyword bbOverrideOperator  append prepend remove contained
-
-" BitBake shell metadata
-syn include @shell syntax/sh.vim
-if exists("b:current_syntax")
-  unlet b:current_syntax
-endif
-syn keyword bbShFakeRootFlag    fakeroot contained
-syn match bbShFuncDef           "^\(fakeroot\s*\)\?\([\.0-9A-Za-z_:${}\-\.]\+\)\(python\)\@<!\(\s*()\s*\)\({\)\@=" contains=bbShFakeRootFlag,bbFunction,bbOverrideOperator,bbVarDeref,bbDelimiter nextgroup=bbShFuncRegion skipwhite
-syn region bbShFuncRegion       matchgroup=bbDelimiter start="{\s*$" end="^}\s*$" contained contains=@shell
-
-" Python value inside shell functions
-syn region shDeref         start=+${@+ skip=+\\$+ excludenl end=+}+ contained contains=@python
-
-" BitBake python metadata
-syn keyword bbPyFlag            python contained
-syn match bbPyFuncDef           "^\(fakeroot\s*\)\?\(python\)\(\s\+[0-9A-Za-z_:${}\-\.]\+\)\?\(\s*()\s*\)\({\)\@=" contains=bbShFakeRootFlag,bbPyFlag,bbFunction,bbOverrideOperator,bbVarDeref,bbDelimiter nextgroup=bbPyFuncRegion skipwhite
-syn region bbPyFuncRegion       matchgroup=bbDelimiter start="{\s*$" end="^}\s*$" contained contains=@python
-
-" BitBake 'def'd python functions
-syn keyword bbPyDef             def contained
-syn region bbPyDefRegion        start='^\(def\s\+\)\([0-9A-Za-z_-]\+\)\(\s*(.*)\s*\):\s*$' end='^\(\s\|$\)\@!' contains=@python
-
-" Highlighting Definitions
-hi def link bbUnmatched         Error
-hi def link bbInclude           Include
-hi def link bbTodo              Todo
-hi def link bbComment           Comment
-hi def link bbQuote             String
-hi def link bbString            String
-hi def link bbDelimiter         Keyword
-hi def link bbArrayBrackets     Statement
-hi def link bbContinue          Special
-hi def link bbExport            Type
-hi def link bbExportFlag        Type
-hi def link bbIdentifier	    Identifier
-hi def link bbVarDeref          PreProc
-hi def link bbVarDef            Identifier
-hi def link bbVarValue          String
-hi def link bbShFakeRootFlag    Type
-hi def link bbFunction          Function
-hi def link bbPyFlag            Type
-hi def link bbPyDef             Statement
-hi def link bbStatement         Statement
-hi def link bbStatementRest     Identifier
-hi def link bbStatementRestCont Identifier
-hi def link bbOEFunctions       Special
-hi def link bbVarPyValue        PreProc
-hi def link bbOverrideOperator  Operator
-
-let b:current_syntax = "bb"
-- 
2.51.0


