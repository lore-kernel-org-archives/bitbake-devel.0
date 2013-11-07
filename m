Return-Path: <raj.khem@gmail.com>
Received: from mail-pb0-f48.google.com (mail-pb0-f48.google.com
	[209.85.160.48])
	by mail.openembedded.org (Postfix) with ESMTP id 762B86D320
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 Nov 2013 15:11:27 +0000 (UTC)
Received: by mail-pb0-f48.google.com with SMTP id mc8so714261pbc.35
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 07 Nov 2013 07:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=SQCsUDITtig2+2sFZdV6G0b3MvKkJ8Wgcxe4+cZcZXc=;
	b=WVEJqtu1EcZp7zYtvPx2fsZZBmJi9l6kkodj+VQrGsn2R260TIF/B7KhMz9j0zV5Pt
	Rgjng5Ao6NKzg2a4CY9MDvsjxFtoRnU7r2caO3IM0LbEhCl0XKzR78AVtPw7TPb8me6J
	TpbfAtrLM4ub6RNFmZaHIeeF9doDoXPYrRSGfyOoCpHry77cy3HRZwoXp9umvfpDJfTD
	ICSptZFobxbJdr95iMr59xbTh/3lK2qMQk03DNXRHKXt46VG7BRNL2lcV0F+qq/ZiBlp
	RoZjw9TXOq2GjTC1fK7AuwKpzA5RpDw6vEjiCoLXmYtctzLIPWiOmmLyGeN7caFKLC4H
	6P9g==
X-Received: by 10.68.101.225 with SMTP id fj1mr9602073pbb.8.1383837089462;
	Thu, 07 Nov 2013 07:11:29 -0800 (PST)
Received: from haswell.gateway.2wire.net
	(99-57-140-209.lightspeed.sntcca.sbcglobal.net. [99.57.140.209])
	by mx.google.com with ESMTPSA id zq10sm7067992pab.6.2013.11.07.07.11.28
	for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Thu, 07 Nov 2013 07:11:28 -0800 (PST)
From: Khem Raj <raj.khem@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  7 Nov 2013 07:10:35 -0800
Message-Id: <1383837035-29410-1-git-send-email-raj.khem@gmail.com>
X-Mailer: git-send-email 1.8.3.2
Subject: [PATCH] bitbake.vim: fix highlighing for ??= operator
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
X-List-Received-Date: Thu, 07 Nov 2013 15:11:28 -0000

equation is OK but operator itself is highlighted
which is odd

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 contrib/vim/syntax/bitbake.vim | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/vim/syntax/bitbake.vim b/contrib/vim/syntax/bitbake.vim
index fb55f91..0cad484 100644
--- a/contrib/vim/syntax/bitbake.vim
+++ b/contrib/vim/syntax/bitbake.vim
@@ -59,7 +59,7 @@ syn region bbVarPyValue         start=+${@+ skip=+\\$+ end=+}+ contained contain
 
 " Vars metadata flags
 syn match bbVarFlagDef          "^\([a-zA-Z0-9\-_\.]\+\)\(\[[a-zA-Z0-9\-_\.]\+\]\)\@=" contains=bbIdentifier nextgroup=bbVarFlagFlag
-syn region bbVarFlagFlag        matchgroup=bbArrayBrackets start="\[" end="\]\s*\(=\|+=\|=+\|?=\)\@=" contained contains=bbIdentifier nextgroup=bbVarEq
+syn region bbVarFlagFlag        matchgroup=bbArrayBrackets start="\[" end="\]\s*\(=\|+=\|=+\|?=\|??=\)\@=" contained contains=bbIdentifier nextgroup=bbVarEq
 
 " Includes and requires
 syn keyword bbInclude           inherit include require contained 
-- 
1.8.3.2


