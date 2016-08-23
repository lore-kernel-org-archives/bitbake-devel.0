Return-Path: <mike.looijmans@topic.nl>
X-Greylist: delayed 395 seconds by postgrey-1.34 at layers.openembedded.org;
	Tue, 23 Aug 2016 06:53:48 UTC
Received: from atl4mhfb04.myregisteredsite.com
	(atl4mhfb04.myregisteredsite.com [209.17.115.120])
	by mail.openembedded.org (Postfix) with ESMTP id C8DB7731C9
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 23 Aug 2016 06:53:48 +0000 (UTC)
Received: from atl4mhob07.myregisteredsite.com
	(atl4mhob07.myregisteredsite.com [209.17.115.45])
	by atl4mhfb04.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id
	u7N6ppVO021518 for <bitbake-devel@lists.openembedded.org>;
	Tue, 23 Aug 2016 02:51:51 -0400
Received: from mailpod.hostingplatform.com ([10.30.71.206])
	by atl4mhob07.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id
	u7N6pmY8002444 for <bitbake-devel@lists.openembedded.org>;
	Tue, 23 Aug 2016 02:51:48 -0400
Received: (qmail 26069 invoked by uid 0); 23 Aug 2016 06:51:48 -0000
X-TCPREMOTEIP: 37.74.225.130
X-Authenticated-UID: mike@milosoftware.com
Received: from unknown (HELO mikebuntu.TOPIC.LOCAL)
	(mike@milosoftware.com@37.74.225.130)
	by 0 with ESMTPA; 23 Aug 2016 06:51:48 -0000
From: Mike Looijmans <mike.looijmans@topic.nl>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 23 Aug 2016 08:51:45 +0200
Message-Id: <1471935105-1684-1-git-send-email-mike.looijmans@topic.nl>
X-Mailer: git-send-email 1.9.1
References: <1471934427-16959-1-git-send-email-mike.looijmans@topic.nl>
In-Reply-To: <1471934427-16959-1-git-send-email-mike.looijmans@topic.nl>
X-Mailman-Approved-At: Wed, 31 Aug 2016 14:36:36 +0000
Cc: Mike Looijmans <mike.looijmans@topic.nl>
Subject: [PATCH v2] lib/bb/siggen.py: Prevent ResourceWarning exceptions
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
X-List-Received-Date: Tue, 23 Aug 2016 06:53:49 -0000

Add a "with" statement to explicitly close files. This prevents hundreds of
"ResourceWarning: unclosed file" outputs.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---
v2: Smaller object scope. Wrapped both open() calls.

 lib/bb/siggen.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index db3daef..1b3f205 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -363,10 +363,10 @@ def clean_basepaths_list(a):
 def compare_sigfiles(a, b, recursecb = None):
     output = []
 
-    p1 = pickle.Unpickler(open(a, "rb"))
-    a_data = p1.load()
-    p2 = pickle.Unpickler(open(b, "rb"))
-    b_data = p2.load()
+    with open(a, "rb") as file_a:
+        a_data = pickle.Unpickler(file_a).load()
+    with open(b, "rb") as file_b:
+        b_data = pickle.Unpickler(file_b).load()
 
     def dict_diff(a, b, whitelist=set()):
         sa = set(a.keys())
@@ -563,8 +563,8 @@ def calc_taskhash(sigdata):
 def dump_sigfile(a):
     output = []
 
-    p1 = pickle.Unpickler(open(a, "rb"))
-    a_data = p1.load()
+    with open(a, "rb") as fa:
+        a_data = pickle.Unpickler(fa).load()
 
     output.append("basewhitelist: %s" % (a_data['basewhitelist']))
 
-- 
1.9.1


