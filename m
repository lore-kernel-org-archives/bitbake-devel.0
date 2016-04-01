Return-Path: <olof.johansson@axis.com>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
	by mail.openembedded.org (Postfix) with ESMTP id 39B00763F0
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  1 Apr 2016 15:01:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bes.se.axis.com (Postfix) with ESMTP id 907482E3CC
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  1 Apr 2016 17:01:54 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id AhKx92BESs4F for <bitbake-devel@lists.openembedded.org>;
	Fri,  1 Apr 2016 17:01:50 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bes.se.axis.com (Postfix) with ESMTP id B74DA2E3AB
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  1 Apr 2016 17:01:48 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id A1D3617D1
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  1 Apr 2016 17:01:48 +0200 (CEST)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
	by boulder.se.axis.com (Postfix) with ESMTP id 96E5617CF
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  1 Apr 2016 17:01:48 +0200 (CEST)
Received: from lnxolofjn.se.axis.com (lnxolofjn.se.axis.com [10.92.17.1])
	by seth.se.axis.com (Postfix) with ESMTP id 9589D1151
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  1 Apr 2016 17:01:48 +0200 (CEST)
Received: by lnxolofjn.se.axis.com (Postfix, from userid 20466)
	id 8441A9C04E; Fri,  1 Apr 2016 17:01:48 +0200 (CEST)
From: Olof Johansson <olof.johansson@axis.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  1 Apr 2016 17:01:48 +0200
Message-Id: <1459522908-26650-2-git-send-email-olofjn@axis.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1459522908-26650-1-git-send-email-olofjn@axis.com>
References: <1459522908-26650-1-git-send-email-olofjn@axis.com>
Subject: [PATCH v2 2/2] tests/fetch.py: Improve unit tests for trusted network check
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
X-List-Received-Date: Fri, 01 Apr 2016 15:01:55 -0000

From: Olof Johansson <olof.johansson@axis.com>

The tests were skipped when running without network even though they
didn't require network. This commit also adds a test case for URLs with
ports in them (the ports should not be considered when doing trusted
network checks).

Signed-off-by: Olof Johansson <olof.johansson@axis.com>
---
 bitbake/lib/bb/tests/fetch.py | 77 +++++++++++++++++++++++--------------------
 1 file changed, 42 insertions(+), 35 deletions(-)

diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
index 29d8999..4ba688b 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -611,42 +611,49 @@ class FetcherNetworkTest(FetcherTest):
             os.chdir(os.path.dirname(self.unpackdir))
             fetcher.unpack(self.unpackdir)
 
-        def test_trusted_network(self):
-            # Ensure trusted_network returns False when the host IS in the list.
-            url = "git://Someserver.org/foo;rev=1"
-            self.d.setVar("BB_ALLOWED_NETWORKS", "server1.org someserver.org server2.org server3.org")
-            self.assertTrue(bb.fetch.trusted_network(self.d, url))
-
-        def test_wild_trusted_network(self):
-            # Ensure trusted_network returns true when the *.host IS in the list.
-            url = "git://Someserver.org/foo;rev=1"
-            self.d.setVar("BB_ALLOWED_NETWORKS", "server1.org *.someserver.org server2.org server3.org")
-            self.assertTrue(bb.fetch.trusted_network(self.d, url))
-
-        def test_prefix_wild_trusted_network(self):
-            # Ensure trusted_network returns true when the prefix matches *.host.
-            url = "git://git.Someserver.org/foo;rev=1"
-            self.d.setVar("BB_ALLOWED_NETWORKS", "server1.org *.someserver.org server2.org server3.org")
-            self.assertTrue(bb.fetch.trusted_network(self.d, url))
-
-        def test_two_prefix_wild_trusted_network(self):
-            # Ensure trusted_network returns true when the prefix matches *.host.
-            url = "git://something.git.Someserver.org/foo;rev=1"
-            self.d.setVar("BB_ALLOWED_NETWORKS", "server1.org *.someserver.org server2.org server3.org")
-            self.assertTrue(bb.fetch.trusted_network(self.d, url))
-
-        def test_untrusted_network(self):
-            # Ensure trusted_network returns False when the host is NOT in the list.
-            url = "git://someserver.org/foo;rev=1"
-            self.d.setVar("BB_ALLOWED_NETWORKS", "server1.org server2.org server3.org")
-            self.assertFalse(bb.fetch.trusted_network(self.d, url))
-
-        def test_wild_untrusted_network(self):
-            # Ensure trusted_network returns False when the host is NOT in the list.
-            url = "git://*.someserver.org/foo;rev=1"
-            self.d.setVar("BB_ALLOWED_NETWORKS", "server1.org server2.org server3.org")
-            self.assertFalse(bb.fetch.trusted_network(self.d, url))
 
+class TrustedNetworksTest(FetcherTest):
+    def test_trusted_network(self):
+        # Ensure trusted_network returns False when the host IS in the list.
+        url = "git://Someserver.org/foo;rev=1"
+        self.d.setVar("BB_ALLOWED_NETWORKS", "server1.org someserver.org server2.org server3.org")
+        self.assertTrue(bb.fetch.trusted_network(self.d, url))
+
+    def test_wild_trusted_network(self):
+        # Ensure trusted_network returns true when the *.host IS in the list.
+        url = "git://Someserver.org/foo;rev=1"
+        self.d.setVar("BB_ALLOWED_NETWORKS", "server1.org *.someserver.org server2.org server3.org")
+        self.assertTrue(bb.fetch.trusted_network(self.d, url))
+
+    def test_prefix_wild_trusted_network(self):
+        # Ensure trusted_network returns true when the prefix matches *.host.
+        url = "git://git.Someserver.org/foo;rev=1"
+        self.d.setVar("BB_ALLOWED_NETWORKS", "server1.org *.someserver.org server2.org server3.org")
+        self.assertTrue(bb.fetch.trusted_network(self.d, url))
+
+    def test_two_prefix_wild_trusted_network(self):
+        # Ensure trusted_network returns true when the prefix matches *.host.
+        url = "git://something.git.Someserver.org/foo;rev=1"
+        self.d.setVar("BB_ALLOWED_NETWORKS", "server1.org *.someserver.org server2.org server3.org")
+        self.assertTrue(bb.fetch.trusted_network(self.d, url))
+
+    def test_port_trusted_network(self):
+        # Ensure trusted_network returns True, even if the url specifies a port.
+        url = "git://someserver.org:8080/foo;rev=1"
+        self.d.setVar("BB_ALLOWED_NETWORKS", "someserver.org")
+        self.assertTrue(bb.fetch.trusted_network(self.d, url))
+
+    def test_untrusted_network(self):
+        # Ensure trusted_network returns False when the host is NOT in the list.
+        url = "git://someserver.org/foo;rev=1"
+        self.d.setVar("BB_ALLOWED_NETWORKS", "server1.org server2.org server3.org")
+        self.assertFalse(bb.fetch.trusted_network(self.d, url))
+
+    def test_wild_untrusted_network(self):
+        # Ensure trusted_network returns False when the host is NOT in the list.
+        url = "git://*.someserver.org/foo;rev=1"
+        self.d.setVar("BB_ALLOWED_NETWORKS", "server1.org server2.org server3.org")
+        self.assertFalse(bb.fetch.trusted_network(self.d, url))
 
 class URLHandle(unittest.TestCase):
 
-- 
2.1.4


