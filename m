Return-Path: <joe.slater@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 675CC78E4C
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 30 Oct 2018 23:33:39 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id w9UNX44C000974
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 30 Oct 2018 16:33:30 -0700
Received: from ala-lpggp5.wrs.com (147.11.105.121) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.3.408.0;
	Tue, 30 Oct 2018 16:33:04 -0700
From: Joe Slater <joe.slater@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 30 Oct 2018 16:33:04 -0700
Message-ID: <20181030233304.214025-1-joe.slater@windriver.com>
X-Mailer: git-send-email 2.13.0
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 31 Oct 2018 07:51:23 +0000
Cc: joe.slater@windriver.com
Subject: [oe-core][PATCH 1/1] cooker.py: no bb.fatal() for pr server
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
X-List-Received-Date: Tue, 30 Oct 2018 23:33:39 -0000
Content-Type: text/plain

Calls to bb.fatal() will block at this point of initialization.

Signed-off-by: Joe Slater <joe.slater@windriver.com>
---
 lib/bb/cooker.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 71a0eba..2a3721b 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -383,7 +383,8 @@ class BBCooker:
         try:
             self.prhost = prserv.serv.auto_start(self.data)
         except prserv.serv.PRServiceConfigError as e:
-            bb.fatal("Unable to start PR Server, exitting")
+            logger.error("Unable to start PR Server.  Continuing anyway...")
+            self.prhost = None
 
     def enableDataTracking(self):
         self.configuration.tracking = True
-- 
2.7.4


