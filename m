Received: from mail-iy0-f175.google.com ([209.85.210.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <raj.khem@gmail.com>) id 1RZRjD-0005VG-MS
	for bitbake-devel@lists.openembedded.org;
	Sat, 10 Dec 2011 19:32:55 +0100
Received: by iadj38 with SMTP id j38so6111692iad.6
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 10 Dec 2011 10:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=from:to:cc:subject:date:message-id:x-mailer;
	bh=97uLp23yudz5+9pLab53YeyUAFXLRJPbkoCuPdva/JE=;
	b=NrTQgD+rOM5Mo7wzJd7xaNB3uLABfiX46kk6oYvAghbm1G9MH1R1PizgF4GIfRME+J
	q+DnzbiORjZXRrDUZxcI8lzUfxK1YDCPEGtrXVB1vo9QAn+Ojd1cfv6uEYyqGwqmTW4o
	kKtlUPOExK+IOyI897VLtFHyGxM4RTaLLrV+E=
Received: by 10.42.136.196 with SMTP id v4mr6821376ict.3.1323541562310;
	Sat, 10 Dec 2011 10:26:02 -0800 (PST)
Received: from localhost.localdomain
	(99-57-141-118.lightspeed.sntcca.sbcglobal.net. [99.57.141.118])
	by mx.google.com with ESMTPS id ew6sm26601349igc.4.2011.12.10.10.25.59
	(version=TLSv1/SSLv3 cipher=OTHER);
	Sat, 10 Dec 2011 10:26:00 -0800 (PST)
From: Khem Raj <raj.khem@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 10 Dec 2011 10:25:57 -0800
Message-Id: <1323541557-6681-1-git-send-email-raj.khem@gmail.com>
X-Mailer: git-send-email 1.7.5.4
Subject: [PATCH] vim/syntax: Recognize ?? operator
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
X-List-Received-Date: Sat, 10 Dec 2011 18:32:55 -0000

Signed-off-by: Khem Raj <raj.khem@gmail.com>
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
 
-- 
1.7.5.4



