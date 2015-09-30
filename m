Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 3B75D73D13
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 30 Sep 2015 13:29:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t8UDTGHm005520 for <bitbake-devel@lists.openembedded.org>;
	Wed, 30 Sep 2015 14:29:16 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id uws46b2k0b02 for <bitbake-devel@lists.openembedded.org>;
	Wed, 30 Sep 2015 14:29:16 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t8UDT1Mn005515
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 30 Sep 2015 14:29:12 +0100
Message-ID: <1443619741.5162.75.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 30 Sep 2015 14:29:01 +0100
X-Mailer: Evolution 3.12.11-0ubuntu3 
Mime-Version: 1.0
Subject: [PATCH] runqueue: Add handling of virtual/xxx provider mappings
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
X-List-Received-Date: Wed, 30 Sep 2015 13:29:17 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

This firstly prints debug messages which show how bitbake decided to resolve
the virtual/xxx providers which is useful for debugging.

If the siggen has a tasks_resolved() method, it calls this, passing in
the mappings, allowing that to do things with the resolved names.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 49d853d..8370579 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -824,6 +824,15 @@ class RunQueueData:
                         st = "do_%s" % st
                     invalidate_task(fn, st, True)
 
+        # Create and print to the logs a virtual/xxxx -> PN (fn) table
+        virtmap = taskData.get_providermap()
+        virtpnmap = {}
+        for v in virtmap:
+            virtpnmap[v] = self.dataCache.pkg_fn[virtmap[v]]
+            bb.debug(2, "%s resolved to: %s (%s)" % (v, virtpnmap[v], virtmap[v]))
+        if hasattr(bb.parse.siggen, "tasks_resolved"):
+            bb.parse.siggen.tasks_resolved(virtmap, virtpnmap, self.dataCache)
+
         # Iterate over the task list and call into the siggen code
         dealtwith = set()
         todeal = set(range(len(self.runq_fnid)))



