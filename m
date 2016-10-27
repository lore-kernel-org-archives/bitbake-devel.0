Return-Path: <o.mandel@menlosystems.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by mail.openembedded.org (Postfix) with ESMTP id 51F7971A50
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Oct 2016 16:42:59 +0000 (UTC)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3t4XbP63Hzz3hk9P;
	Thu, 27 Oct 2016 18:36:49 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3t4XbP1twBzvl1X;
	Thu, 27 Oct 2016 18:36:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new,
	port 10024)
	with ESMTP id dr8aSmYaJKHl; Thu, 27 Oct 2016 18:36:48 +0200 (CEST)
X-Auth-Info: 7/e+hQUfVzhKlH7yztlEwezGfAuBEbrLpZ/EAwJIPR58jWC0Q4bfZaVND3kRC5CN
Received: from menlobuildsrv.menlosystems.local
	(host-141-40-253-38.customer.izb-online.de [141.40.253.38])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Thu, 27 Oct 2016 18:36:48 +0200 (CEST)
From: Olaf Mandel <o.mandel@menlosystems.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 27 Oct 2016 16:36:37 +0000
Message-Id: <1477586197-29398-1-git-send-email-o.mandel@menlosystems.com>
X-Mailer: git-send-email 2.1.4
Cc: Olaf Mandel <o.mandel@menlosystems.com>
Subject: [PATCH] toasterui.py: warn if buildstats is missing
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
X-List-Received-Date: Thu, 27 Oct 2016 16:43:00 -0000

Like for buildhistory and INHERIT, warn if buildstats is missing
from USER_CLASSES.

Signed-off-by: Olaf Mandel <o.mandel@menlosystems.com>
---
 lib/bb/ui/toasterui.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/bb/ui/toasterui.py b/lib/bb/ui/toasterui.py
index 9808f6b..2687faf 100644
--- a/lib/bb/ui/toasterui.py
+++ b/lib/bb/ui/toasterui.py
@@ -168,6 +168,11 @@ def main(server, eventHandler, params):
         logger.warning("buildhistory is not enabled. Please enable INHERIT += \"buildhistory\" to see image details.")
         build_history_enabled = False
 
+    userclasseslist, _ = server.runCommand(["getVariable", "USER_CLASSES"])
+
+    if not "buildstats" in userclasseslist.split(" "):
+        logger.warning("buildstats is not enabled. Please enable USER_CLASSES += \"buildstats\" to generate build statistics.")
+
     if not params.observe_only:
         params.updateFromServer(server)
         params.updateToServer(server, os.environ.copy())
-- 
2.1.4


