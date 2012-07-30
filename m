Received: from mail-wg0-f41.google.com ([74.125.82.41])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>) id 1Svo4R-0007nW-CW
	for bitbake-devel@lists.openembedded.org;
	Mon, 30 Jul 2012 13:23:31 +0200
Received: by wgbds1 with SMTP id ds1so2283757wgb.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 30 Jul 2012 04:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:x-mailer;
	bh=DnPOQNY44k6RfjW4A8x8sQDG29k7IqpwxYvZEScoaEc=;
	b=ptEDKwhWqg0VltzpVxFY86DkhGAoelZOPseicm0QEg9glQ+KhHv+U9kxl/AEeMaZlK
	h8Ua+r/Vve/l+MLmas2kfc80kY9pI4tqSZ4GZkskWypub8HvYVrEE9SIU/Sq42Sqs+Iu
	5W9v/XxYBNxAks+bfPrkGUWV3XkvlDCdoT12dIhG5bVPk1e+puk3rTx/RcTEGY0RjWen
	t05p+8qzjuyyfEKcvTXuMBSEdlTxgMOh6AfHpJPUhc+qFIor442ULrgEfFpIAlyUvemN
	SyTZTh7PG4PgiDQvC2eXMH7254oSXruSZQuXlzD2CnK4sxpdDeKHM4bJr6pHKhfKaNE2
	9zmA==
Received: by 10.216.233.216 with SMTP id p66mr5018760weq.152.1343646715751;
	Mon, 30 Jul 2012 04:11:55 -0700 (PDT)
Received: from localhost ([94.230.152.246])
	by mx.google.com with ESMTPS id fr4sm23492550wib.8.2012.07.30.04.11.54
	(version=TLSv1/SSLv3 cipher=OTHER);
	Mon, 30 Jul 2012 04:11:54 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 30 Jul 2012 13:11:46 +0200
Message-Id: <1343646706-15732-1-git-send-email-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 1.7.8.6
Subject: [PATCH] knotty: ensure that directory for BB_CONSOLELOG exists before using it
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
X-List-Received-Date: Mon, 30 Jul 2012 11:23:31 -0000

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
---
 lib/bb/ui/knotty.py |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 0167416..9f51823 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -119,6 +119,7 @@ def main(server, eventHandler, tf = TerminalFilter):
     console.setFormatter(format)
     logger.addHandler(console)
     if consolelogfile:
+        bb.utils.mkdirhier(os.path.dirname(consolelogfile))
         consolelog = logging.FileHandler(consolelogfile)
         bb.msg.addDefaultlogFilter(consolelog)
         consolelog.setFormatter(format)
-- 
1.7.8.6



