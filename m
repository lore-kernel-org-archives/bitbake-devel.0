Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id CEBF977BDE
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Jul 2017 21:37:05 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v6ILb4iw012341
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Tue, 18 Jul 2017 22:37:05 +0100
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1dXaAy-0006TC-TM; Tue, 18 Jul 2017 22:37:04 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 18 Jul 2017 22:36:57 +0100
Message-Id: <1500413820-24816-3-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1500413820-24816-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1500413820-24816-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.11
	(dan.rpsys.net [192.168.3.1]);
	Tue, 18 Jul 2017 22:37:06 +0100 (BST)
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: [PATCH 3/6] cookerdata: Add a function to find TOPDIR
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
X-List-Received-Date: Tue, 18 Jul 2017 21:37:06 -0000

Finding the top level build directory is currently hard and relies on
having a complete cooker being setup. Add a helper function which
does the same thing without all the extra overhead. This is needed
to be able to locate the bitbake lockfile and hence the socket
for connecting clients in the new server model.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cookerdata.py | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index 644bb38..aa0a641 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -230,6 +230,27 @@ def findConfigFile(configfile, data):
 
     return None
 
+#
+# We search for a conf/bblayers.conf under an entry in BBPATH or in cwd working 
+# up to /. If that fails, we search for a conf/bitbake.conf in BBPATH.
+#
+
+def findTopdir():
+    d = bb.data.init()
+    bbpath = None
+    if 'BBPATH' in os.environ:
+        bbpath = os.environ['BBPATH']
+        d.setVar('BBPATH', bbpath)
+
+    layerconf = findConfigFile("bblayers.conf", d)
+    if layerconf:
+        return os.path.dirname(os.path.dirname(layerconf))
+    if bbpath:
+        bitbakeconf = bb.utils.which(bbpath, "conf/bitbake.conf")
+        if bitbakeconf:
+            return os.path.dirname(os.path.dirname(bitbakeconf))
+    return None
+
 class CookerDataBuilder(object):
 
     def __init__(self, cookercfg, worker = False):
-- 
2.7.4


