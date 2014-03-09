Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 35E826F60F
	for <bitbake-devel@lists.openembedded.org>;
	Sun,  9 Mar 2014 17:07:09 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s29H75nY020429
	for <bitbake-devel@lists.openembedded.org>; Sun, 9 Mar 2014 17:07:05 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id kUUBqbKFLoaM for <bitbake-devel@lists.openembedded.org>;
	Sun,  9 Mar 2014 17:07:05 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s29H5xp0020414
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Sun, 9 Mar 2014 17:06:04 GMT
Message-ID: <1394384754.7883.13.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sun, 09 Mar 2014 10:05:54 -0700
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] cooker: Handle SIGTERM more gracefully
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
X-List-Received-Date: Sun, 09 Mar 2014 17:07:10 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

If the cooker receives a SIGTERM it currently hangs using 100% CPU,

This patch adds in an intercept for the event and puts the cooker into
shutdown mode allowing it to exit cleanly/safely and avoiding the hang.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 8d63195..9cb74d1 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -37,6 +37,7 @@ from collections import defaultdict
 import bb, bb.exceptions, bb.command
 from bb import utils, data, parse, event, cache, providers, taskdata, runqueue
 import Queue
+import signal
 import prserv.serv
 
 logger      = logging.getLogger("BitBake")
@@ -149,6 +150,12 @@ class BBCooker:
 
         self.parser = None
 
+        signal.signal(signal.SIGTERM, self.sigterm_exception)
+
+    def sigterm_exception(self, signum, stackframe):
+        bb.warn("Cooker recieved SIGTERM, shutting down...")
+        self.state = state.forceshutdown
+
     def setFeatures(self, features):
         original_featureset = list(self.featureset)
         for feature in features:



