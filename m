Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id D0A7478733
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  1 Feb 2018 15:15:00 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id w11FF288021107
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 1 Feb 2018 07:15:02 -0800 (PST)
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.361.1; Thu, 1 Feb 2018 07:15:01 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 1 Feb 2018 23:15:24 +0800
Message-ID: <7eb5625a77c9545119a6f43b82c7680c9019cf4f.1517497731.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1517497731.git.liezhi.yang@windriver.com>
References: <cover.1517497731.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 3/8] bitbake: cooker: don't stop file notifier when cooker is shutdown
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
X-List-Received-Date: Thu, 01 Feb 2018 15:15:00 -0000
Content-Type: text/plain

It should be live/exited with server rather than cooker, fixed:
$ bitbake --server-only -T -1
Set MACHINE = "qemux86" in conf/local.conf
$ bitbake quilt
Set MACHINE = "qemuppc" in conf/local.conf
$ bitbake quilt
[snip]
ERROR: When reparsing /workspace1/lyang1/poky/meta/recipes-connectivity/openssl/openssl_1.0.2m.bb.do_package, the basehash value changed from c216f7f4fdd3cf4a0b10b975a636426c to d5a8e9431ab261381752d7a64c7b2fa9. The metadata is not deterministic and this needs to be fixed.
[snip]

This is because the server doesn't know local.conf is changed since the
notifiers are stopped, so it doesn't reparse, and then we would get the errors,
let the notifiers live/exited with server can fix the problem.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/cooker.py         | 2 --
 bitbake/lib/bb/server/process.py | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index f991c8f..af482f9 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1604,8 +1604,6 @@ class BBCooker:
 
         if self.parser:
             self.parser.shutdown(clean=not force, force=force)
-        self.notifier.stop()
-        self.confignotifier.stop()
 
     def finishcommand(self):
         self.state = state.initial
diff --git a/bitbake/lib/bb/server/process.py b/bitbake/lib/bb/server/process.py
index 3d31355..828159e 100644
--- a/bitbake/lib/bb/server/process.py
+++ b/bitbake/lib/bb/server/process.py
@@ -223,6 +223,8 @@ class ProcessServer(multiprocessing.Process):
 
         try: 
             self.cooker.shutdown(True)
+            self.cooker.notifier.stop()
+            self.cooker.confignotifier.stop()
         except:
             pass
 
-- 
2.7.4


