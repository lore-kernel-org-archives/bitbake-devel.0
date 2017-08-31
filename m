Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 57B937841C
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 31 Aug 2017 16:38:42 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v7VGcfnf028718
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Thu, 31 Aug 2017 17:38:42 +0100
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1dnSUL-0003FI-6I; Thu, 31 Aug 2017 17:38:41 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 31 Aug 2017 17:38:31 +0100
Message-Id: <1504197520-12428-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.11
	(dan.rpsys.net [192.168.3.1]);
	Thu, 31 Aug 2017 17:38:42 +0100 (BST)
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: [PATCH 01/10] prserv/cooker: Drop unused param
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
X-List-Received-Date: Thu, 31 Aug 2017 16:38:46 -0000

Drop pointless unused function parameter.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py   | 2 +-
 lib/prserv/serv.py | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index db034b9..2ee349e 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1576,7 +1576,7 @@ class BBCooker:
         return
 
     def post_serve(self):
-        prserv.serv.auto_shutdown(self.data)
+        prserv.serv.auto_shutdown()
         bb.event.fire(CookerExit(), self.data)
 
 
diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index 3145689..306f0a3 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -478,7 +478,7 @@ def auto_start(d):
         logger.critical("PRservice %s:%d not available" % (host, port))
         raise PRServiceConfigError
 
-def auto_shutdown(d=None):
+def auto_shutdown():
     global singleton
     if singleton:
         host, port = singleton.getinfo()
-- 
2.7.4


