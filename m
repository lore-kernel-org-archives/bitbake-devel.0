Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 8E6757701C
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 30 Sep 2015 13:28:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t8UDSYLk005499 for <bitbake-devel@lists.openembedded.org>;
	Wed, 30 Sep 2015 14:28:34 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Qcjrd6-wx6uD for <bitbake-devel@lists.openembedded.org>;
	Wed, 30 Sep 2015 14:28:34 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t8UDSMCL005496
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 30 Sep 2015 14:28:33 +0100
Message-ID: <1443619701.5162.74.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 30 Sep 2015 14:28:21 +0100
X-Mailer: Evolution 3.12.11-0ubuntu3 
Mime-Version: 1.0
Subject: [PATCH] taskdata: Add a function to return the virtual/ mapping data
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
X-List-Received-Date: Wed, 30 Sep 2015 13:28:36 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

When building an execution task graph, bitbake does resolve virtual/xxx
namespaces into specific providers. This data isn't exported anywhere
however.

This adds a function so that runqueue can at least retrieve this data
which can then be used by the system.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/taskdata.py b/bitbake/lib/bb/taskdata.py
index 5fab704..4d12b33 100644
--- a/bitbake/lib/bb/taskdata.py
+++ b/bitbake/lib/bb/taskdata.py
@@ -612,6 +612,18 @@ class TaskData:
                 break
         # self.dump_data()
 
+    def get_providermap(self):
+        virts = []
+        virtmap = {}
+
+        for name in self.build_names_index:
+            if name.startswith("virtual/"):
+                virts.append(name)
+        for v in virts:
+            if self.have_build_target(v):
+                virtmap[v] = self.fn_index[self.get_provider(v)[0]]
+        return virtmap
+
     def dump_data(self):
         """
         Dump some debug information on the internal data structures



