Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1Rczed-0002YA-Vo
	for bitbake-devel@lists.openembedded.org;
	Tue, 20 Dec 2011 14:22:52 +0100
Received: by opal (Postfix, from userid 111)
	id 2D35B10331; Tue, 20 Dec 2011 13:21:28 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20111220132128.2D35B10331@opal>
Date: Tue, 20 Dec 2011 13:21:28 +0000 (UTC)
From: git@git.openembedded.org
Subject: Khem Raj : vim/syntax: Recognize ?? operator
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 20 Dec 2011 13:22:52 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: 5337ed86820ab0a2cbb3fd82eb11edb807c47f54
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=5337ed86820ab0a2cbb3fd82eb11edb807c47f54

Author: Khem Raj <raj.khem@gmail.com>
Date:   Sat Dec 10 10:25:57 2011 -0800

vim/syntax: Recognize ?? operator

Signed-off-by: Khem Raj <raj.khem@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 contrib/vim/syntax/bitbake.vim |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/vim/syntax/bitbake.vim b/contrib/vim/syntax/bitbake.vim
index a06dd9e..336e6bb 100644
--- a/contrib/vim/syntax/bitbake.vim
+++ b/contrib/vim/syntax/bitbake.vim
@@ -52,8 +52,8 @@ syn match bbExport            "^export" nextgroup=bbIdentifier skipwhite
 syn keyword bbExportFlag        export contained nextgroup=bbIdentifier skipwhite
 syn match bbIdentifier          "[a-zA-Z0-9\-_\.\/\+]\+" display contained
 syn match bbVarDeref            "${[a-zA-Z0-9\-_\.\/\+]\+}" contained
-syn match bbVarEq               "\(:=\|+=\|=+\|\.=\|=\.\|?=\|=\)" contained nextgroup=bbVarValue
-syn match bbVarDef              "^\(export\s*\)\?\([a-zA-Z0-9\-_\.\/\+]\+\(_[${}a-zA-Z0-9\-_\.\/\+]\+\)\?\)\s*\(:=\|+=\|=+\|\.=\|=\.\|?=\|=\)\@=" contains=bbExportFlag,bbIdentifier,bbVarDeref nextgroup=bbVarEq
+syn match bbVarEq               "\(:=\|+=\|=+\|\.=\|=\.\|?=\|??=\|=\)" contained nextgroup=bbVarValue
+syn match bbVarDef              "^\(export\s*\)\?\([a-zA-Z0-9\-_\.\/\+]\+\(_[${}a-zA-Z0-9\-_\.\/\+]\+\)\?\)\s*\(:=\|+=\|=+\|\.=\|=\.\|?=\|??=\|=\)\@=" contains=bbExportFlag,bbIdentifier,bbVarDeref nextgroup=bbVarEq
 syn match bbVarValue            ".*$" contained contains=bbString,bbVarDeref,bbVarPyValue
 syn region bbVarPyValue         start=+${@+ skip=+\\$+ excludenl end=+}+ contained contains=@python
 



