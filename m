Return-Path: <o.mandel@menlosystems.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by mail.openembedded.org (Postfix) with ESMTP id 3D32A783A7
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 30 Aug 2017 12:33:01 +0000 (UTC)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3xj4SM5Lp9z1qsgf;
	Wed, 30 Aug 2017 14:24:19 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
	by mail.m-online.net (Postfix) with ESMTP id 3xj4SM4fxtz3hjJs;
	Wed, 30 Aug 2017 14:24:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new,
	port 10024)
	with ESMTP id hqN96aOnveiH; Wed, 30 Aug 2017 14:24:17 +0200 (CEST)
X-Auth-Info: 2wQ2yADB/45XsFBq+3OFWBNgrEfmsw3Sck71IBlsFyAuRF2VU4xuRS4b48byDYO/
Received: from menlobldserver.menlosystems.local
	(host-141-40-253-38.customer.izb-online.de [141.40.253.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Wed, 30 Aug 2017 14:24:17 +0200 (CEST)
From: Olaf Mandel <o.mandel@menlosystems.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 30 Aug 2017 12:24:06 +0000
Message-Id: <20170830122406.30085-1-o.mandel@menlosystems.com>
X-Mailer: git-send-email 2.11.0
Cc: Olaf Mandel <o.mandel@menlosystems.com>
Subject: [PATCH] toaster: set pokydirname in local build
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
X-List-Received-Date: Wed, 30 Aug 2017 12:33:02 -0000

If no external layers are defined, pokydirname was not set: rectify
this by taking the be.sourcedir as the pokydirname if possible.

Signed-off-by: Olaf Mandel <o.mandel@menlosystems.com>
---
 lib/toaster/bldcontrol/localhostbecontroller.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index 62e62fe1..358cce4d 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -200,6 +200,10 @@ class LocalhostBEController(BuildEnvironmentController):
 
         logger.debug("localhostbecontroller: current layer list %s " % pformat(layerlist))
 
+        if self.pokydirname is None and os.path.exists(os.path.join(self.be.sourcedir, "oe-init-build-env")):
+            logger.debug("localhostbecontroller: selected poky dir name %s" % self.be.sourcedir)
+            self.pokydirname = self.be.sourcedir
+
         # 5. create custom layer and add custom recipes to it
         for target in targets:
             try:
-- 
2.11.0


