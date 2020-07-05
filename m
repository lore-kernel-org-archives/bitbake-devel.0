Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com [209.85.160.193])
 by mx.groups.io with SMTP id smtpd.web11.42888.1593975870128518690
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 05 Jul 2020 12:04:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=hj059kH7;
 spf=pass (domain: gmail.com, ip: 209.85.160.193, mailfrom: mostthingsweb@gmail.com)
Received: by mail-qt1-f193.google.com with SMTP id u12so27443231qth.12
        for <bitbake-devel@lists.openembedded.org>; Sun, 05 Jul 2020 12:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O/4LDZewoUzHkHmTXmxym4Ae6SM/2xjqSh1tkNqvy7o=;
        b=hj059kH7xFOZEQnJVbXd6jKi/gY+5Jj01XFAFaIACPReVsfjmmynn6KU+wqXVOeKCV
         jzOlTZOtk3zWjIqgm6DB+mcKF7RpaC4m/K0MMJR8kSqJpxv3PpxOUvWMJEEYYK+yLVmm
         VHHYPE/1IcB9KwTYq/4BHCA/qzEYR5Rqo0a3IkdUOpjAGvIkLaDxqRjsc3BdkePFgnKn
         fPobAAad2b/Pg6DnzHGND9WoiUFG+xP14Z7cnFV/f80xJ9GyUiJ5EOCL/M7lC4zGoXyE
         mYMEB+JQhwhWXaberuvdxPSgt+OvK05nzpBK+lUGJgvsSeyNnRbrn2Twxk5V+bpDLYMr
         ZvMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O/4LDZewoUzHkHmTXmxym4Ae6SM/2xjqSh1tkNqvy7o=;
        b=igqt9RMkCi0HNbLdZU4X8TdJzBenBBreHgBMI+pvE+yFmmrIUePWeyRjJhSeSpUqkW
         gTyDRohirzkuBRdd4K1NTx9GYEnAYrY5pzSt9mNboKFw29kEbZh04ziMbC7RKCL0MoUz
         QhfiwrgAhBu6t3SzAlhCXn1XfPiaogK5v1LMbgVdItcCdk1dzegXOBopGPy6oE5JAjdH
         bmNuT6dULE5c9QGJMi0aVVuh/yKUcwmEiCl6XQDCGPmM+ST9biMoE3Rnv+mgdjppWMUR
         iQcU3VICUIVWmMhb72sZcjHd3zaN7FHMSLFKXJBtgQ3Dgv0LeGMDq/b4u3EAie2O4T1y
         Rfng==
X-Gm-Message-State: AOAM530qE07tfjM8Etb+pchkvg6yMMmAu1QMRr3vlrIu/q9jQ41J/Ug3
	pkgmHgXnPwcvN4x1s+x9KNIgpxGQdzNp7A==
X-Google-Smtp-Source: ABdhPJy16/bAq25K0aAW/gB+RS33TCYzHYPoME1YX+uxCVy8uKyaVnplsYRK2r+qUWtlTUDCfW4c4Q==
X-Received: by 2002:aed:2199:: with SMTP id l25mr25250272qtc.309.1593975868569;
        Sun, 05 Jul 2020 12:04:28 -0700 (PDT)
Return-Path: <mostthingsweb@gmail.com>
Received: from localhost.localdomain (84.185.2.69.cable.dhcp.goeaston.net. [69.2.185.84])
        by smtp.gmail.com with ESMTPSA id e37sm19087515qtk.94.2020.07.05.12.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2020 12:04:27 -0700 (PDT)
From: mostthingsweb@gmail.com
To: bitbake-devel@lists.openembedded.org
Cc: Chris Laplante <mostthingsweb@gmail.com>
Subject: [PATCH] contrib/vim: synchronize from kergoth/vim-bitbake rev 4225ee8b4818d7e4696520567216a3a031c26f7d
Date: Sun,  5 Jul 2020 15:04:26 -0400
Message-Id: <20200705190426.5425-1-mostthingsweb@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Chris Laplante <mostthingsweb@gmail.com>
---
 contrib/vim/LICENSE.txt            | 18 ++++++++++++
 contrib/vim/ftdetect/bitbake.vim   |  4 +--
 contrib/vim/ftplugin/bitbake.vim   | 15 ++++++++--
 contrib/vim/plugin/newbb.vim       | 14 +++++----
 contrib/vim/plugin/newbbappend.vim | 46 ++++++++++++++++++++++++++++++
 contrib/vim/syntax/bitbake.vim     | 16 +++++------
 6 files changed, 96 insertions(+), 17 deletions(-)
 create mode 100644 contrib/vim/LICENSE.txt
 mode change 100755 => 100644 contrib/vim/plugin/newbb.vim
 create mode 100644 contrib/vim/plugin/newbbappend.vim

diff --git a/contrib/vim/LICENSE.txt b/contrib/vim/LICENSE.txt
new file mode 100644
index 00000000..c7d91502
--- /dev/null
+++ b/contrib/vim/LICENSE.txt
@@ -0,0 +1,18 @@
+The MIT License (MIT)
+
+Permission is hereby granted, free of charge, to any person obtaining a copy of
+this software and associated documentation files (the "Software"), to deal in
+the Software without restriction, including without limitation the rights to
+use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
+the Software, and to permit persons to whom the Software is furnished to do so,
+subject to the following conditions:
+
+The above copyright notice and this permission notice shall be included in all
+copies or substantial portions of the Software.
+
+THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
+FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
+COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
+IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
diff --git a/contrib/vim/ftdetect/bitbake.vim b/contrib/vim/ftdetect/bitbake.vim
index 200f8ae4..09fc4dc7 100644
--- a/contrib/vim/ftdetect/bitbake.vim
+++ b/contrib/vim/ftdetect/bitbake.vim
@@ -6,12 +6,12 @@
 "
 " This sets up the syntax highlighting for BitBake files, like .bb, .bbclass and .inc
 
-if &compatible || version < 600
+if &compatible || version < 600 || exists("b:loaded_bitbake_plugin")
     finish
 endif
 
 " .bb, .bbappend and .bbclass
-au BufNewFile,BufRead *.{bb,bbappend,bbclass}	set filetype=bitbake
+au BufNewFile,BufRead *.{bb,bbappend,bbclass}  set filetype=bitbake
 
 " .inc
 au BufNewFile,BufRead *.inc		set filetype=bitbake
diff --git a/contrib/vim/ftplugin/bitbake.vim b/contrib/vim/ftplugin/bitbake.vim
index db0d7531..9e8d3e13 100644
--- a/contrib/vim/ftplugin/bitbake.vim
+++ b/contrib/vim/ftplugin/bitbake.vim
@@ -1,2 +1,13 @@
-set sts=4 sw=4 et
-set cms=#%s
+" Only do this when not done yet for this buffer
+if exists("b:did_ftplugin")
+  finish
+endif
+
+" Don't load another plugin for this buffer
+let b:did_ftplugin = 1
+
+let b:undo_ftplugin = "setl cms< sts< sw< et< sua<"
+
+setlocal commentstring=#\ %s
+setlocal softtabstop=4 shiftwidth=4 expandtab
+setlocal suffixesadd+=.bb,.bbclass
diff --git a/contrib/vim/plugin/newbb.vim b/contrib/vim/plugin/newbb.vim
old mode 100755
new mode 100644
index 874e3380..3a420273
--- a/contrib/vim/plugin/newbb.vim
+++ b/contrib/vim/plugin/newbb.vim
@@ -10,7 +10,7 @@
 "
 " Will try to use git to find the user name and email
 
-if &compatible || v:version < 600
+if &compatible || v:version < 600 || exists("b:loaded_bitbake_plugin")
     finish
 endif
 
@@ -25,7 +25,7 @@ endfun
 fun! <SID>GetUserEmail()
     let l:user_email = system("git config --get user.email")
     if v:shell_error
-        return "unknow@user.org"
+        return "unknown@user.org"
     else
         return substitute(l:user_email, "\n", "", "")
 endfun
@@ -41,6 +41,10 @@ fun! BBHeader()
 endfun
 
 fun! NewBBTemplate()
+    if line2byte(line('$') + 1) != -1
+        return
+    endif
+
     let l:paste = &paste
     set nopaste
     
@@ -48,7 +52,7 @@ fun! NewBBTemplate()
     call BBHeader()
 
     " New the bb template
-    put ='DESCRIPTION = \"\"'
+    put ='SUMMARY = \"\"'
     put ='HOMEPAGE = \"\"'
     put ='LICENSE = \"\"' 
     put ='SECTION = \"\"'
@@ -58,7 +62,7 @@ fun! NewBBTemplate()
 
     " Go to the first place to edit
     0
-    /^DESCRIPTION =/
+    /^SUMMARY =/
     exec "normal 2f\""
 
     if paste == 1
@@ -76,7 +80,7 @@ if v:progname =~ "vimdiff"
 endif
 
 augroup NewBB
-    au BufNewFile *.bb
+    au BufNewFile,BufReadPost *.bb
                 \ if g:bb_create_on_empty |
                 \    call NewBBTemplate() |
                 \ endif
diff --git a/contrib/vim/plugin/newbbappend.vim b/contrib/vim/plugin/newbbappend.vim
new file mode 100644
index 00000000..e04174cf
--- /dev/null
+++ b/contrib/vim/plugin/newbbappend.vim
@@ -0,0 +1,46 @@
+" Vim plugin file
+" Purpose:	Create a template for new bbappend file
+" Author:	Joshua Watt <JPEWhacker@gmail.com>
+" Copyright:	Copyright (C) 2017 Joshua Watt <JPEWhacker@gmail.com>
+"
+" This file is licensed under the MIT license, see COPYING.MIT in
+" this source distribution for the terms.
+"
+
+if &compatible || v:version < 600 || exists("b:loaded_bitbake_plugin")
+    finish
+endif
+
+fun! NewBBAppendTemplate()
+    if line2byte(line('$') + 1) != -1
+        return
+    endif
+
+    let l:paste = &paste
+    set nopaste
+
+    " New bbappend template
+    0 put ='FILESEXTRAPATHS_prepend := \"${THISDIR}/${PN}:\"'
+    2
+
+    if paste == 1
+        set paste
+    endif
+endfun
+
+if !exists("g:bb_create_on_empty")
+    let g:bb_create_on_empty = 1
+endif
+
+" disable in case of vimdiff
+if v:progname =~ "vimdiff"
+    let g:bb_create_on_empty = 0
+endif
+
+augroup NewBBAppend
+    au BufNewFile,BufReadPost *.bbappend
+                \ if g:bb_create_on_empty |
+                \    call NewBBAppendTemplate() |
+                \ endif
+augroup END
+
diff --git a/contrib/vim/syntax/bitbake.vim b/contrib/vim/syntax/bitbake.vim
index fb55f910..f964621a 100644
--- a/contrib/vim/syntax/bitbake.vim
+++ b/contrib/vim/syntax/bitbake.vim
@@ -12,7 +12,7 @@
 "
 " It's an entirely new type, just has specific syntax in shell and python code
 
-if &compatible || v:version < 600
+if &compatible || v:version < 600 || exists("b:loaded_bitbake_plugin")
     finish
 endif
 if exists("b:current_syntax")
@@ -58,8 +58,8 @@ syn match bbVarValue            ".*$" contained contains=bbString,bbVarDeref,bbV
 syn region bbVarPyValue         start=+${@+ skip=+\\$+ end=+}+ contained contains=@python
 
 " Vars metadata flags
-syn match bbVarFlagDef          "^\([a-zA-Z0-9\-_\.]\+\)\(\[[a-zA-Z0-9\-_\.]\+\]\)\@=" contains=bbIdentifier nextgroup=bbVarFlagFlag
-syn region bbVarFlagFlag        matchgroup=bbArrayBrackets start="\[" end="\]\s*\(=\|+=\|=+\|?=\)\@=" contained contains=bbIdentifier nextgroup=bbVarEq
+syn match bbVarFlagDef          "^\([a-zA-Z0-9\-_\.]\+\)\(\[[a-zA-Z0-9\-_\.+]\+\]\)\@=" contains=bbIdentifier nextgroup=bbVarFlagFlag
+syn region bbVarFlagFlag        matchgroup=bbArrayBrackets start="\[" end="\]\s*\(:=\|=\|.=\|=.|+=\|=+\|?=\)\@=" contained contains=bbIdentifier nextgroup=bbVarEq
 
 " Includes and requires
 syn keyword bbInclude           inherit include require contained 
@@ -67,15 +67,15 @@ syn match bbIncludeRest         ".*$" contained contains=bbString,bbVarDeref
 syn match bbIncludeLine         "^\(inherit\|include\|require\)\s\+" contains=bbInclude nextgroup=bbIncludeRest
 
 " Add taks and similar
-syn keyword bbStatement         addtask addhandler after before EXPORT_FUNCTIONS contained
+syn keyword bbStatement         addtask deltask addhandler after before EXPORT_FUNCTIONS contained
 syn match bbStatementRest       ".*$" skipwhite contained contains=bbStatement
-syn match bbStatementLine       "^\(addtask\|addhandler\|after\|before\|EXPORT_FUNCTIONS\)\s\+" contains=bbStatement nextgroup=bbStatementRest
+syn match bbStatementLine       "^\(addtask\|deltask\|addhandler\|after\|before\|EXPORT_FUNCTIONS\)\s\+" contains=bbStatement nextgroup=bbStatementRest
 
 " OE Important Functions
 syn keyword bbOEFunctions       do_fetch do_unpack do_patch do_configure do_compile do_stage do_install do_package contained
 
 " Generic Functions
-syn match bbFunction            "\h[0-9A-Za-z_-]*" display contained contains=bbOEFunctions
+syn match bbFunction            "\h[0-9A-Za-z_\-\.]*" display contained contains=bbOEFunctions
 
 " BitBake shell metadata
 syn include @shell syntax/sh.vim
@@ -83,7 +83,7 @@ if exists("b:current_syntax")
   unlet b:current_syntax
 endif
 syn keyword bbShFakeRootFlag    fakeroot contained
-syn match bbShFuncDef           "^\(fakeroot\s*\)\?\([0-9A-Za-z_${}-]\+\)\(python\)\@<!\(\s*()\s*\)\({\)\@=" contains=bbShFakeRootFlag,bbFunction,bbVarDeref,bbDelimiter nextgroup=bbShFuncRegion skipwhite
+syn match bbShFuncDef           "^\(fakeroot\s*\)\?\([\.0-9A-Za-z_${}\-\.]\+\)\(python\)\@<!\(\s*()\s*\)\({\)\@=" contains=bbShFakeRootFlag,bbFunction,bbVarDeref,bbDelimiter nextgroup=bbShFuncRegion skipwhite
 syn region bbShFuncRegion       matchgroup=bbDelimiter start="{\s*$" end="^}\s*$" contained contains=@shell
 
 " Python value inside shell functions
@@ -91,7 +91,7 @@ syn region shDeref         start=+${@+ skip=+\\$+ excludenl end=+}+ contained co
 
 " BitBake python metadata
 syn keyword bbPyFlag            python contained
-syn match bbPyFuncDef           "^\(python\s\+\)\([0-9A-Za-z_${}-]\+\)\?\(\s*()\s*\)\({\)\@=" contains=bbPyFlag,bbFunction,bbVarDeref,bbDelimiter nextgroup=bbPyFuncRegion skipwhite
+syn match bbPyFuncDef           "^\(fakeroot\s*\)\?\(python\)\(\s\+[0-9A-Za-z_${}\-\.]\+\)\?\(\s*()\s*\)\({\)\@=" contains=bbShFakeRootFlag,bbPyFlag,bbFunction,bbVarDeref,bbDelimiter nextgroup=bbPyFuncRegion skipwhite
 syn region bbPyFuncRegion       matchgroup=bbDelimiter start="{\s*$" end="^}\s*$" contained contains=@python
 
 " BitBake 'def'd python functions
-- 
2.27.0

