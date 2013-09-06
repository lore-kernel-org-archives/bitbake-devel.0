Return-Path: <kergoth@gmail.com>
Received: from mail-pd0-f174.google.com (mail-pd0-f174.google.com
	[209.85.192.174])
	by mail.openembedded.org (Postfix) with ESMTP id A14B4616EA
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  6 Sep 2013 19:25:37 +0000 (UTC)
Received: by mail-pd0-f174.google.com with SMTP id y13so3647762pdi.19
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 06 Sep 2013 12:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding;
	bh=6kIhXmMBrXcy62s0RsrLofnADVutjpfi/4NtKGHm3x8=;
	b=hbXQ7p6+tlxFsCLO03mJVVRmrMzwDSC0Nl1KhJNPzXMzkrF6iWCkRLWrBN4mq7J3aT
	FLizL4ao86jxSLQe1IbnuAruRQl1actYD09Dd2Sz4Lc4YLGGrZuczo0bdVqx9+JvQVko
	eZIwf52ZW17LAzFizi1D4dBWRjEdnju5JjV5yeIvC3LDqnk2NWAwEKgyi4wmOOGgdV+q
	2yVxUIQvC4jOSHzGh0aAr7ZhdL0NIUYQnrKNXVBih0b3OLA9n0ZoJ72pBR58g4iOKs0l
	STOebFoyaCGbV6sndsKvaOU7bTm7cOt7LKpbfseodsRBVd+6UQaGo+a+kDHuP41Ypjlo
	kb7g==
X-Received: by 10.66.50.131 with SMTP id c3mr5583407pao.111.1378495539568;
	Fri, 06 Sep 2013 12:25:39 -0700 (PDT)
Received: from amyr.alm.mentorg.com (nat-lmt.mentorg.com. [139.181.28.34])
	by mx.google.com with ESMTPSA id ib9sm5523679pbc.43.1969.12.31.16.00.00
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Fri, 06 Sep 2013 12:25:38 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  6 Sep 2013 12:25:32 -0700
Message-Id: <1378495532-31368-1-git-send-email-kergoth@gmail.com>
X-Mailer: git-send-email 1.8.3.4
MIME-Version: 1.0
Subject: [PATCH] contrib/vim: merge changes from vim-bitbake repo
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 06 Sep 2013 19:25:38 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

commit 00ca441614695b4261d8d4f31b7ef0e3e3784282
Merge: 8cc367d bb88c0f
Author: Christopher Larson <kergoth@gmail.com>
Date:   Thu Aug 22 16:42:42 2013 -0700

    Merge pull request #6 from staticshock/multi-line-strings

    Remove "keepend" and "excludenl" directives

commit bb88c0fd4ad2b7b9c8c4c73def2b3cb20c473ac3
Author: Anton Backer <olegov@gmail.com>
Date:   Sat Jul 13 01:24:15 2013 -0400

    Remove "keepend" and "excludenl" directives

    It looks like these were never actually used correctly, and were doing
    more harm than good. "keepend" on bbString, for instance, prevented
    proper nesting of ${@python} in strings. Similarly, a balanced pair of
    { } braces inside a shell function would force the function to terminate
    early if the closing brace was on its own line.

    So far I've seen absolutely no negative consequences from removing
    these, but a bunch of positive consequences.

    Fixes #1

commit 8cc367d01f4c699be5fcc072de59e6f2f14a138b
Merge: c58628c eec6b7f
Author: Christopher Larson <kergoth@gmail.com>
Date:   Thu Aug 22 09:46:46 2013 -0700

    Merge pull request #4 from staticshock/function-names

    Parse function names with nested vars

commit c58628ca517cd25985361fc0d27863521cc28a5d
Merge: dfb0f7c a890982
Author: Christopher Larson <kergoth@gmail.com>
Date:   Thu Aug 22 09:43:40 2013 -0700

    Merge pull request #5 from yoyko/master

    syntax: python expansion (${@...}) inside shell functions

commit a890982b7c33a6e363b12d6cb69e22b4bbc0f317
Author: Jozef Šiška <yoyo@ksp.sk>
Date:   Thu Aug 22 13:20:45 2013 +0200

    syntax: python expansion (${@...}) inside shell functions

    Signed-off-by: Jozef Šiška <jsiska@nuvotechnologies.com>

commit eec6b7f6f0472787929f424968f9a0d78ac4af08
Author: Anton Backer <olegov@gmail.com>
Date:   Fri Jul 12 22:16:01 2013 -0400

    Parse function names with nested vars

    For instance, pkg_postinst_${PN}

    Fixes #3

commit dfb0f7c0d51556448cba79b474b8c19b9cded9af
Author: Christopher Larson <chris_larson@mentor.com>
Date:   Fri Jun 1 18:57:13 2012 -0400

    syntax: add ?= flag def

    Signed-off-by: Christopher Larson <chris_larson@mentor.com>

commit 589a62a00709ca822a42327e7086008aba2d9933
Author: Christopher Larson <kergoth@gmail.com>
Date:   Fri Dec 9 22:25:47 2011 -0700

    ftplugin: set commentstring

    Signed-off-by: Christopher Larson <kergoth@gmail.com>

commit 7ffc80b3fb4ddf68cc5a69bdc63ab03d70c44f87
Author: Chris Larson <chris_larson@mentor.com>
Date:   Thu Jun 2 15:27:48 2011 -0700

    Handle +=/=+ for flags

    Signed-off-by: Chris Larson <chris_larson@mentor.com>

Signed-off-by: Christopher Larson <kergoth@gmail.com>
---
 contrib/vim/ftdetect/bitbake.vim |  2 +-
 contrib/vim/ftplugin/bitbake.vim |  1 +
 contrib/vim/syntax/bitbake.vim   | 19 +++++++++++--------
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/contrib/vim/ftdetect/bitbake.vim b/contrib/vim/ftdetect/bitbake.vim
index b9529e6..200f8ae 100644
--- a/contrib/vim/ftdetect/bitbake.vim
+++ b/contrib/vim/ftdetect/bitbake.vim
@@ -14,7 +14,7 @@ endif
 au BufNewFile,BufRead *.{bb,bbappend,bbclass}	set filetype=bitbake
 
 " .inc
-au BufNewFile,BufRead *.inc 		set filetype=bitbake
+au BufNewFile,BufRead *.inc		set filetype=bitbake
 
 " .conf
 au BufNewFile,BufRead *.conf
diff --git a/contrib/vim/ftplugin/bitbake.vim b/contrib/vim/ftplugin/bitbake.vim
index ed69d3b..db0d753 100644
--- a/contrib/vim/ftplugin/bitbake.vim
+++ b/contrib/vim/ftplugin/bitbake.vim
@@ -1 +1,2 @@
 set sts=4 sw=4 et
+set cms=#%s
diff --git a/contrib/vim/syntax/bitbake.vim b/contrib/vim/syntax/bitbake.vim
index 336e6bb..fb55f91 100644
--- a/contrib/vim/syntax/bitbake.vim
+++ b/contrib/vim/syntax/bitbake.vim
@@ -44,8 +44,8 @@ syn match bbArrayBrackets       "[\[\]]" contained
 
 " BitBake strings
 syn match bbContinue            "\\$"
-syn region bbString             matchgroup=bbQuote start=+"+ skip=+\\$+ excludenl end=+"+ contained keepend contains=bbTodo,bbContinue,bbVarDeref,bbVarPyValue,@Spell
-syn region bbString             matchgroup=bbQuote start=+'+ skip=+\\$+ excludenl end=+'+ contained keepend contains=bbTodo,bbContinue,bbVarDeref,bbVarPyValue,@Spell
+syn region bbString             matchgroup=bbQuote start=+"+ skip=+\\$+ end=+"+ contained contains=bbTodo,bbContinue,bbVarDeref,bbVarPyValue,@Spell
+syn region bbString             matchgroup=bbQuote start=+'+ skip=+\\$+ end=+'+ contained contains=bbTodo,bbContinue,bbVarDeref,bbVarPyValue,@Spell
 
 " Vars definition
 syn match bbExport            "^export" nextgroup=bbIdentifier skipwhite
@@ -55,11 +55,11 @@ syn match bbVarDeref            "${[a-zA-Z0-9\-_\.\/\+]\+}" contained
 syn match bbVarEq               "\(:=\|+=\|=+\|\.=\|=\.\|?=\|??=\|=\)" contained nextgroup=bbVarValue
 syn match bbVarDef              "^\(export\s*\)\?\([a-zA-Z0-9\-_\.\/\+]\+\(_[${}a-zA-Z0-9\-_\.\/\+]\+\)\?\)\s*\(:=\|+=\|=+\|\.=\|=\.\|?=\|??=\|=\)\@=" contains=bbExportFlag,bbIdentifier,bbVarDeref nextgroup=bbVarEq
 syn match bbVarValue            ".*$" contained contains=bbString,bbVarDeref,bbVarPyValue
-syn region bbVarPyValue         start=+${@+ skip=+\\$+ excludenl end=+}+ contained contains=@python
+syn region bbVarPyValue         start=+${@+ skip=+\\$+ end=+}+ contained contains=@python
 
 " Vars metadata flags
 syn match bbVarFlagDef          "^\([a-zA-Z0-9\-_\.]\+\)\(\[[a-zA-Z0-9\-_\.]\+\]\)\@=" contains=bbIdentifier nextgroup=bbVarFlagFlag
-syn region bbVarFlagFlag        matchgroup=bbArrayBrackets start="\[" end="\]\s*\(=\)\@=" keepend excludenl contained contains=bbIdentifier nextgroup=bbVarEq
+syn region bbVarFlagFlag        matchgroup=bbArrayBrackets start="\[" end="\]\s*\(=\|+=\|=+\|?=\)\@=" contained contains=bbIdentifier nextgroup=bbVarEq
 
 " Includes and requires
 syn keyword bbInclude           inherit include require contained 
@@ -83,13 +83,16 @@ if exists("b:current_syntax")
   unlet b:current_syntax
 endif
 syn keyword bbShFakeRootFlag    fakeroot contained
-syn match bbShFuncDef           "^\(fakeroot\s*\)\?\([0-9A-Za-z_-]\+\)\(python\)\@<!\(\s*()\s*\)\({\)\@=" contains=bbShFakeRootFlag,bbFunction,bbDelimiter nextgroup=bbShFuncRegion skipwhite
-syn region bbShFuncRegion       matchgroup=bbDelimiter start="{\s*$" end="^}\s*$" keepend contained contains=@shell
+syn match bbShFuncDef           "^\(fakeroot\s*\)\?\([0-9A-Za-z_${}-]\+\)\(python\)\@<!\(\s*()\s*\)\({\)\@=" contains=bbShFakeRootFlag,bbFunction,bbVarDeref,bbDelimiter nextgroup=bbShFuncRegion skipwhite
+syn region bbShFuncRegion       matchgroup=bbDelimiter start="{\s*$" end="^}\s*$" contained contains=@shell
+
+" Python value inside shell functions
+syn region shDeref         start=+${@+ skip=+\\$+ excludenl end=+}+ contained contains=@python
 
 " BitBake python metadata
 syn keyword bbPyFlag            python contained
-syn match bbPyFuncDef           "^\(python\s\+\)\([0-9A-Za-z_-]\+\)\?\(\s*()\s*\)\({\)\@=" contains=bbPyFlag,bbFunction,bbDelimiter nextgroup=bbPyFuncRegion skipwhite 
-syn region bbPyFuncRegion       matchgroup=bbDelimiter start="{\s*$" end="^}\s*$" keepend contained contains=@python
+syn match bbPyFuncDef           "^\(python\s\+\)\([0-9A-Za-z_${}-]\+\)\?\(\s*()\s*\)\({\)\@=" contains=bbPyFlag,bbFunction,bbVarDeref,bbDelimiter nextgroup=bbPyFuncRegion skipwhite
+syn region bbPyFuncRegion       matchgroup=bbDelimiter start="{\s*$" end="^}\s*$" contained contains=@python
 
 " BitBake 'def'd python functions
 syn keyword bbPyDef             def contained
-- 
1.8.4


