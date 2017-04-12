Return-Path: <ola.x.nilsson@axis.com>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
	by mail.openembedded.org (Postfix) with ESMTP id F009C77D26
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 12 Apr 2017 16:03:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bes.se.axis.com (Postfix) with ESMTP id 838802E1BB
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 12 Apr 2017 18:03:01 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id ocuT8g5KXBrW for <bitbake-devel@lists.openembedded.org>;
	Wed, 12 Apr 2017 18:03:01 +0200 (CEST)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
	by bes.se.axis.com (Postfix) with ESMTPS id 68DD42E1BA
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 12 Apr 2017 18:03:01 +0200 (CEST)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 53FF81E068
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 12 Apr 2017 18:03:01 +0200 (CEST)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4910C1E060
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 12 Apr 2017 18:03:01 +0200 (CEST)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
	by boulder03.se.axis.com (Postfix) with ESMTP
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 12 Apr 2017 18:03:01 +0200 (CEST)
Received: from lnxolani.se.axis.com (lnxolani.se.axis.com [10.88.67.1])
	by thoth.se.axis.com (Postfix) with ESMTP id 3DA6B2C9
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 12 Apr 2017 18:03:01 +0200 (CEST)
Received: by lnxolani.se.axis.com (Postfix, from userid 20853)
	id 302CF7C066; Wed, 12 Apr 2017 18:03:01 +0200 (CEST)
From: Ola x Nilsson <ola.x.nilsson@axis.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 12 Apr 2017 18:03:01 +0200
Message-Id: <1492012981-20215-1-git-send-email-olani@axis.com>
X-Mailer: git-send-email 2.1.4
X-TM-AS-GCONF: 00
Subject: [PATCH] bitbake: knotty: Show elapsed time for tasks with progressbar
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
X-List-Received-Date: Wed, 12 Apr 2017 16:03:03 -0000

Signed-off-by: Ola x Nilsson <olani@axis.com>
---
 bitbake/lib/bb/ui/knotty.py | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index 948f527..4caeafa 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -32,6 +32,7 @@ import fcntl
 import struct
 import copy
 import atexit
+import re
 
 from bb.ui import uihelper
 
@@ -248,10 +249,10 @@ class TerminalFilter(object):
                 start_time = activetasks[t].get("starttime", None)
                 if not pbar or pbar.bouncing != (progress < 0):
                     if progress < 0:
-                        pbar = BBProgress("0: %s (pid %s) " % (activetasks[t]["title"], t), 100, widgets=[progressbar.BouncingSlider(), ''], extrapos=2, resize_handler=self.sigwinch_handle)
+                        pbar = BBProgress("0: %s - 0s (pid %s) " % (activetasks[t]["title"], t), 100, widgets=[progressbar.BouncingSlider(), ''], extrapos=2, resize_handler=self.sigwinch_handle)
                         pbar.bouncing = True
                     else:
-                        pbar = BBProgress("0: %s (pid %s) " % (activetasks[t]["title"], t), 100, widgets=[progressbar.Percentage(), ' ', progressbar.Bar(), ''], extrapos=4, resize_handler=self.sigwinch_handle)
+                        pbar = BBProgress("0: %s - 0s (pid %s) " % (activetasks[t]["title"], t), 100, widgets=[progressbar.Percentage(), ' ', progressbar.Bar(), ''], extrapos=4, resize_handler=self.sigwinch_handle)
                         pbar.bouncing = False
                     activetasks[t]["progressbar"] = pbar
                 tasks.append((pbar, progress, rate, start_time))
@@ -292,7 +293,10 @@ class TerminalFilter(object):
                         pbar.start(False)
                         if start_time:
                             pbar.start_time = start_time
-                    pbar.setmessage('%s:%s' % (tasknum, pbar.msg.split(':', 1)[1]))
+                    m = re.match(r'\d+: (.*) - \d+s (\(pid \d+\))', pbar.msg)
+                    pbar.setmessage('%s: %s - %ds %s' %
+                                    (tasknum, m.group(1),
+                                     currenttime - pbar.start_time, m.group(2)))
                     if progress > -1:
                         pbar.setextra(rate)
                         content = pbar.update(progress)
-- 
2.1.4


