Return-Path: <o.mandel@menlosystems.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by mail.openembedded.org (Postfix) with ESMTP id CAF6971B79
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Oct 2016 14:04:28 +0000 (UTC)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3t5599021kz3hjR8;
	Fri, 28 Oct 2016 16:04:28 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3t55984XFdzwXYh;
	Fri, 28 Oct 2016 16:04:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new,
	port 10024)
	with ESMTP id lsOywAsFFYLA; Fri, 28 Oct 2016 16:04:27 +0200 (CEST)
X-Auth-Info: 8wbwuqNHQ0GFMySfM1s2zpvPA/ESz7RBi253DVhEEu3mQTWolTpvEIFp/7l9t9X3
Received: from menlobuildsrv.menlosystems.local
	(host-141-40-253-38.customer.izb-online.de [141.40.253.38])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Fri, 28 Oct 2016 16:04:27 +0200 (CEST)
From: Olaf Mandel <o.mandel@menlosystems.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 28 Oct 2016 14:04:10 +0000
Message-Id: <1477663450-1275-1-git-send-email-o.mandel@menlosystems.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1477646878.3717.83.camel@linux.intel.com>
References: <1477646878.3717.83.camel@linux.intel.com>
Cc: Olaf Mandel <o.mandel@menlosystems.com>
Subject: [PATCH v2] toasterui.py: warn if buildstats is missing
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
X-List-Received-Date: Fri, 28 Oct 2016 14:04:29 -0000

Like for buildhistory, warn if buildstats is missing from INHERIT.

CC: Joshua Lock <joshua.g.lock@linux.intel.com>
Signed-off-by: Olaf Mandel <o.mandel@menlosystems.com>
---
 lib/bb/ui/toasterui.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/bb/ui/toasterui.py b/lib/bb/ui/toasterui.py
index 9808f6b..b1b3684 100644
--- a/lib/bb/ui/toasterui.py
+++ b/lib/bb/ui/toasterui.py
@@ -168,6 +168,9 @@ def main(server, eventHandler, params):
         logger.warning("buildhistory is not enabled. Please enable INHERIT += \"buildhistory\" to see image details.")
         build_history_enabled = False
 
+    if not "buildstats" in inheritlist.split(" "):
+        logger.warning("buildstats is not enabled. Please enable INHERIT += \"buildstats\" to generate build statistics.")
+
     if not params.observe_only:
         params.updateFromServer(server)
         params.updateToServer(server, os.environ.copy())
-- 
2.1.4


