Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 5AD9272591
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 23 Dec 2014 12:33:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	sBNCWlDx015816 for <bitbake-devel@lists.openembedded.org>;
	Tue, 23 Dec 2014 12:32:47 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id MAPBcuRvxHMS for <bitbake-devel@lists.openembedded.org>;
	Tue, 23 Dec 2014 12:32:47 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	sBNCWXrE015793
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 23 Dec 2014 12:32:44 GMT
Message-ID: <1419337990.6428.3.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 23 Dec 2014 12:33:10 +0000
X-Mailer: Evolution 3.12.7-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] tests/fetch: Add versionstring tests to network tests list, fix print()
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
X-List-Received-Date: Tue, 23 Dec 2014 12:33:24 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

The versionstring tests hit the network so should only run when
network tests are enabled.

Also remove the print statement which confuses the test output and
add it to the test failure message instead.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
index 3f80c4a..6eb0f2d 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -624,23 +624,23 @@ class FetchMethodTest(FetcherTest):
         ("db", "http://download.oracle.com/berkeley-db/db-5.3.21.tar.gz", "http://www.oracle.com/technetwork/products/berkeleydb/downloads/index-082944.html", "http://download.oracle.com/otn/berkeley-db/(?P<name>db-)(?P<pver>((\d+[\.\-_]*)+))\.tar\.gz")
             : "6.1.19",
     }
-
-    def test_git_latest_versionstring(self):
-        for k, v in self.test_git_uris.items():
-            self.d.setVar("SRCREV", k[2])
-            self.d.setVar("GITTAGREGEX", k[3])
-            ud = bb.fetch2.FetchData(k[1], self.d)
-            verstring = ud.method.latest_versionstring(ud, self.d)
-            print("Package %s, version: %s <= %s" % (k[0], v, verstring))
-            r = bb.utils.vercmp_string(v, verstring)
-            self.assertTrue(r == -1 or r == 0)
-
-    def test_wget_latest_versionstring(self):
-        for k, v in self.test_wget_uris.items():
-            self.d.setVar("REGEX_URI", k[2])
-            self.d.setVar("REGEX", k[3])
-            ud = bb.fetch2.FetchData(k[1], self.d)
-            verstring = ud.method.latest_versionstring(ud, self.d)
-            print("Package %s, version: %s <= %s" % (k[0], v, verstring))
-            r = bb.utils.vercmp_string(v, verstring)
-            self.assertTrue(r == -1 or r == 0)
+    if os.environ.get("BB_SKIP_NETTESTS") == "yes":
+        print("Unset BB_SKIP_NETTESTS to run network tests")
+    else:
+        def test_git_latest_versionstring(self):
+            for k, v in self.test_git_uris.items():
+                self.d.setVar("SRCREV", k[2])
+                self.d.setVar("GITTAGREGEX", k[3])
+                ud = bb.fetch2.FetchData(k[1], self.d)
+                verstring = ud.method.latest_versionstring(ud, self.d)
+                r = bb.utils.vercmp_string(v, verstring)
+                self.assertTrue(r == -1 or r == 0, msg="Package %s, version: %s <= %s" % (k[0], v, verstring))
+
+        def test_wget_latest_versionstring(self):
+            for k, v in self.test_wget_uris.items():
+                self.d.setVar("REGEX_URI", k[2])
+                self.d.setVar("REGEX", k[3])
+                ud = bb.fetch2.FetchData(k[1], self.d)
+                verstring = ud.method.latest_versionstring(ud, self.d)
+                r = bb.utils.vercmp_string(v, verstring)
+                self.assertTrue(r == -1 or r == 0, msg="Package %s, version: %s <= %s" % (k[0], v, verstring))



