Return-Path: <kergoth@gmail.com>
Received: from mail-pf0-f194.google.com (mail-pf0-f194.google.com
	[209.85.192.194])
	by mail.openembedded.org (Postfix) with ESMTP id 697266FF60
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 30 Apr 2016 19:52:55 +0000 (UTC)
Received: by mail-pf0-f194.google.com with SMTP id e190so17839901pfe.0
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 30 Apr 2016 12:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=xncxU3H3sppIEDNxI4NzprXt4wTZAbskVXZ15rurlsA=;
	b=dwUa2V9hxEKMiSsqat85F8q810VquF8+j+POEr3RaWS/XxpKQsF0scpVJbliJWra7B
	8aPvluaqYKAbt5KYNRuAC65Kd02RJEWyFaq7wJRAijJ0FTPTWTxYA+JvPHk1tiVG35ek
	8cJjAsGahjY1pYo4lubrZ0lTnaaf1HucmyITMkshC+vvxA9ROGmQaGFG+L/yVsWamxSn
	f+JGLn0jZ/idz41nt2spc4D7TGExtiZK8zSavROGIHhQcgfuXmYB57OthM3ZC2mNdm9/
	20tOQuorQfjBNSBs/evJYG9v0yIOdhEZqhTM/FkXry5hbBmfH/OUIiSaiBkHwH4BoBCl
	pfsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=xncxU3H3sppIEDNxI4NzprXt4wTZAbskVXZ15rurlsA=;
	b=FY3Hf+Cfd9nmHUCSlNR5gBjEVCv9qC2g+mNgBAibEo/4a6t8mIBO4D3oehTCAdaHZo
	IGsNmLX79ynJwo5vi672l5zSAbM0zWtbOt1vAVQ6GVTHBWY0rXRA2sOGQOKS4KOGw7GA
	IODwmL+vl9z3VdvaKlA1ChPL0HdfLx1HXvBPTbG0UIes5AUFzMfwzZ5JJNn0DGCiwoFj
	s72dyUamUTkv2lQiHeVNOqUBfOtolkTiYMq5HOPqtzxydEo7GYEgU4opf//s1vadyqPh
	VlYHKhnqW9Rv6gfUTBLI6WlPHtO3q4B5dHIOsuAkJ+zG/cLDufS6U4/p8kXNZA+TGdDd
	emTg==
X-Gm-Message-State: AOPr4FUY+lzpN0xBO6xUY3/zIFud5ajexbJOd/boBgrrRiHHvXyceuK1q0KwxXDZb2E02g==
X-Received: by 10.98.102.20 with SMTP id a20mr38906960pfc.137.1462045977025;
	Sat, 30 Apr 2016 12:52:57 -0700 (PDT)
Received: from amyr.alm.mentorg.com (nat-lmt.mentorg.com. [139.181.28.34])
	by smtp.gmail.com with ESMTPSA id
	z2sm33247522pfa.90.2016.04.30.12.52.55
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sat, 30 Apr 2016 12:52:55 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 30 Apr 2016 12:52:47 -0700
Message-Id: <1462045969-14538-3-git-send-email-kergoth@gmail.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1462045969-14538-1-git-send-email-kergoth@gmail.com>
References: <1462045969-14538-1-git-send-email-kergoth@gmail.com>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [master][PATCH] bb.cooker: only emit a var as python if 'func' is set
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
X-List-Received-Date: Sat, 30 Apr 2016 19:52:56 -0000

From: Christopher Larson <chris_larson@mentor.com>

This avoids a common issue where PACKAGECONFIG is emitted as a function in
bitbake -e when the 'python' flag exists. It isn't a python function unless
both 'func' and 'python' are set. This aligns with the behavior of
emit_func_python.

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 lib/bb/cooker.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 9b565fc..b2187d7 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -656,7 +656,7 @@ class BBCooker:
         # emit the metadata which isnt valid shell
         data.expandKeys(envdata)
         for e in envdata.keys():
-            if data.getVarFlag( e, 'python', envdata ):
+            if envdata.getVarFlag(e, 'func', False) and envdata.getVarFlag(e, 'python', False):
                 logger.plain("\npython %s () {\n%s}\n", e, envdata.getVar(e, False))
 
 
-- 
2.8.0


