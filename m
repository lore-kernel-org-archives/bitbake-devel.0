Return-Path: <otavio.salvador@gmail.com>
Received: from mail-yh0-f45.google.com (mail-yh0-f45.google.com
	[209.85.213.45])
	by mail.openembedded.org (Postfix) with ESMTP id BFF8465D1B
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Apr 2014 21:21:28 +0000 (UTC)
Received: by mail-yh0-f45.google.com with SMTP id a41so4068431yho.4
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Apr 2014 14:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=sender:from:to:cc:subject:date:message-id:organization;
	bh=S2Yrp+HtP2VT1AH28c4f+/TJQlKcGZVtITCFqAsr5Sw=;
	b=1BJ4mh1uw58Vg/GubpOD04KSv2Mi3LL1OCP0US9eU4XlAuuUfsfxecVXWl9t3BGSlT
	HYjPvYHOhPpTlhW3Gwug2cyzlRGh+k8cL1LV9ck1io5shyG0iz8YpA++Q5QSxSPYIwTT
	Roi93jWA/53yzM5PSTtIWLjN4xMG3EtQRhYDZNElBeU9zcfzBbe/1Jgrjlp/nT5ueBTJ
	YesFVUpy0W/eb8bEBpj8N68ZXEghTF91FwYNPWTNnshgcPbMAVhcovi6AvzgkSR8q7HC
	dZhXY9id3uyvklc590y3RwZGogbGNE83y+ggI2TkeGhuIllL5w9/sQ/3QF7VcsNOkdtr
	1Fkg==
X-Received: by 10.236.231.130 with SMTP id l2mr6519506yhq.116.1398460889816;
	Fri, 25 Apr 2014 14:21:29 -0700 (PDT)
Received: from nano.lab.ossystems.com.br ([177.194.208.225])
	by mx.google.com with ESMTPSA id
	t63sm15639975yhm.32.2014.04.25.14.21.27 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 25 Apr 2014 14:21:28 -0700 (PDT)
Sender: Otavio Salvador <otavio.salvador@gmail.com>
Received: by nano.lab.ossystems.com.br (Postfix, from userid 1000)
	id 1A1801A5BA21B; Fri, 25 Apr 2014 18:21:24 -0300 (BRT)
From: Otavio Salvador <otavio@ossystems.com.br>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 25 Apr 2014 18:21:23 -0300
Message-Id: <1398460884-26033-1-git-send-email-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.0.0.rc0
Organization: O.S. Systems Software LTDA.
Cc: Otavio Salvador <otavio@ossystems.com.br>
Subject: [PATCH 1/2] bb.codeparser.py: Remove reference for oe.utils.contains
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
X-List-Received-Date: Fri, 25 Apr 2014 21:21:32 -0000

The oe.utils.contains function has been removed from OE-Core metadata
as the references for it has been replaced to use the
bb.utils.contains.

Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---
 lib/bb/codeparser.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/codeparser.py b/lib/bb/codeparser.py
index a50b9f2..b4b1013 100644
--- a/lib/bb/codeparser.py
+++ b/lib/bb/codeparser.py
@@ -103,7 +103,7 @@ class BufferedLogger(Logger):
 
 class PythonParser():
     getvars = ("d.getVar", "bb.data.getVar", "data.getVar", "d.appendVar", "d.prependVar")
-    containsfuncs = ("bb.utils.contains", "base_contains", "oe.utils.contains")
+    containsfuncs = ("bb.utils.contains", "base_contains")
     execfuncs = ("bb.build.exec_func", "bb.build.exec_task")
 
     def warn(self, func, arg):
-- 
2.0.0.rc0


