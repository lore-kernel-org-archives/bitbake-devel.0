Return-Path: <david.reyna@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 736AD7836A
	for <bitbake-devel@lists.openembedded.org>;
	Sun,  3 Sep 2017 05:32:29 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id v835WUFj019897
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 2 Sep 2017 22:32:31 -0700 (PDT)
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.78) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server
	(TLS) id 14.3.361.1; Sat, 2 Sep 2017 22:32:29 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Sat, 2 Sep 2017 22:24:07 -0700
Message-ID: <33e333d5073b16873aedd1f2eb65586471d441b1.1504416112.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1504416112.git.David.Reyna@windriver.com>
References: <cover.1504416112.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.157.78]
Subject: [PATCH 4/4] toaster: set default pokydirname if no external layers
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
X-List-Received-Date: Sun, 03 Sep 2017 05:32:29 -0000
Content-Type: text/plain

From: Olaf Mandel <o.mandel@menlosystems.com>

If no external layers are defined, pokydirname is not set. Rectify
this by taking the 'be.sourcedir' as the pokydirname.

[YOCTO #12015]

Signed-off-by: Olaf Mandel <o.mandel@menlosystems.com>
Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/bldcontrol/localhostbecontroller.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index a93cf40..a2ca95b 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -213,6 +213,10 @@ class LocalhostBEController(BuildEnvironmentController):
         self.setCloneStatus(bitbake,'complete',clone_total,clone_count)
         logger.debug("localhostbecontroller: current layer list %s " % pformat(layerlist))
 
+        if self.pokydirname is None and os.path.exists(os.path.join(self.be.sourcedir, "oe-init-build-env")):
+            logger.debug("localhostbecontroller: selected poky dir name %s" % self.be.sourcedir)
+            self.pokydirname = self.be.sourcedir
+
         # 5. create custom layer and add custom recipes to it
         for target in targets:
             try:
-- 
1.9.1


