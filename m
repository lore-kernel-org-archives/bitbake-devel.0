Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 928B06CBB4
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2014 15:21:11 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s0KFL66h009523 for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2014 15:21:07 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id B9_0XLy6yVkc for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2014 15:21:06 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s0KFKKnY009494
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2014 15:20:22 GMT
Message-ID: <1390231214.874.34.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 20 Jan 2014 15:20:14 +0000
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] fetch2: Sanity check SRCREV matches rev/tag parameter
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
X-List-Received-Date: Mon, 20 Jan 2014 15:21:12 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Add a sanity check so that if some SRCREV is set and a rev parameter is given
to the url, the revision given should match.

Any tag parameter behaves the same as rev. If both are specified, error to
tell the user we're confused rather than do something which may or may not
be what they intended.

Also add some unittests for this.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 4af089d..b4717c4 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -867,12 +867,6 @@ def srcrev_internal_helper(ud, d, name):
         c) None if not specified
     """
 
-    if 'rev' in ud.parm:
-        return ud.parm['rev']
-
-    if 'tag' in ud.parm:
-        return ud.parm['tag']
-
     srcrev = None
     pn = d.getVar("PN", True)
     attempts = []
@@ -889,6 +883,20 @@ def srcrev_internal_helper(ud, d, name):
         if srcrev and srcrev != "INVALID":
             break
 
+    if 'rev' in ud.parm and 'tag' in ud.parm:
+        raise FetchError("Please specify a ;rev= parameter or a ;tag= parameter in the url %s but not both." % (ud.url))
+
+    if 'rev' in ud.parm or 'tag' in ud.parm:
+        if 'rev' in ud.parm:
+            parmrev = ud.parm['rev']
+        else:
+            parmrev = ud.parm['tag']
+        if srcrev == "INVALID" or not srcrev:
+            return parmrev
+        if srcrev != parmrev:
+            raise FetchError("Conflicting revisions (%s from SRCREV and %s from the url) found, please spcify one valid value" % (srcrev, parmrev))
+        return parmrev
+
     rev = srcrev
     if rev == "INVALID" or not rev:
         var = "SRCREV_pn-%s" % pn
diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
index 4bcff54..eaab0de 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -382,6 +382,21 @@ class FetcherNetworkTest(FetcherTest):
             url1 = url2 = "git://git.openembedded.org/bitbake"
             self.gitfetcher(url1, url2)
 
+        def test_gitfetch_goodsrcrev(self):
+            # SRCREV is set but matches rev= parameter
+            url1 = url2 = "git://git.openembedded.org/bitbake;rev=270a05b0b4ba0959fe0624d2a4885d7b70426da5"
+            self.gitfetcher(url1, url2)
+
+        def test_gitfetch_badsrcrev(self):
+            # SRCREV is set but does not match rev= parameter
+            url1 = url2 = "git://git.openembedded.org/bitbake;rev=dead05b0b4ba0959fe0624d2a4885d7b70426da5"
+            self.assertRaises(bb.fetch.FetchError, self.gitfetcher, url1, url2)
+
+        def test_gitfetch_tagandrev(self):
+            # SRCREV is set but does not match rev= parameter
+            url1 = url2 = "git://git.openembedded.org/bitbake;rev=270a05b0b4ba0959fe0624d2a4885d7b70426da5;tag=270a05b0b4ba0959fe0624d2a4885d7b70426da5"
+            self.assertRaises(bb.fetch.FetchError, self.gitfetcher, url1, url2)
+
         def test_gitfetch_premirror(self):
             url1 = "git://git.openembedded.org/bitbake"
             url2 = "git://someserver.org/bitbake"



