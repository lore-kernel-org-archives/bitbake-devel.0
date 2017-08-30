Return-Path: <o.mandel@menlosystems.com>
X-Greylist: delayed 523 seconds by postgrey-1.34 at layers.openembedded.org;
	Wed, 30 Aug 2017 12:33:01 UTC
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by mail.openembedded.org (Postfix) with ESMTP id 3C38D7839B
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 30 Aug 2017 12:33:01 +0000 (UTC)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3xj4Sx5RXCz1qsGZ;
	Wed, 30 Aug 2017 14:24:49 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
	by mail.m-online.net (Postfix) with ESMTP id 3xj4Sx577yz3hjJm;
	Wed, 30 Aug 2017 14:24:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new,
	port 10024)
	with ESMTP id Ob9-lBfGK0VX; Wed, 30 Aug 2017 14:24:49 +0200 (CEST)
X-Auth-Info: 6oqTtvI9kEv5EslJOX2DsP3yPUxwcvgqtQYjf2FD+FSAZn+6AfiSNGp1CLimiuMz
Received: from menlobldserver.menlosystems.local
	(host-141-40-253-38.customer.izb-online.de [141.40.253.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Wed, 30 Aug 2017 14:24:49 +0200 (CEST)
From: Olaf Mandel <o.mandel@menlosystems.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 30 Aug 2017 12:24:38 +0000
Message-Id: <20170830122438.30191-1-o.mandel@menlosystems.com>
X-Mailer: git-send-email 2.11.0
Cc: Olaf Mandel <o.mandel@menlosystems.com>
Subject: [PATCH] toaster: make debug output more readable
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

One of the debug-messages during build contains a list of all layers,
but without spaces or other separators between them. Use pformat
instead.

Signed-off-by: Olaf Mandel <o.mandel@menlosystems.com>
---
 lib/toaster/bldcontrol/localhostbecontroller.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index 358cce4d..12071029 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -221,7 +221,7 @@ class LocalhostBEController(BuildEnvironmentController):
                 continue  # not a custom recipe, skip
 
         layerlist.extend(nongitlayerlist)
-        logger.debug("\n\nset layers gives this list \n %s" % ''.join(layerlist))
+        logger.debug("\n\nset layers gives this list %s" % pformat(layerlist))
         self.islayerset = True
         return layerlist
 
-- 
2.11.0


