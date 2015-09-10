Return-Path: <mark.hatle@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 6BC3673232
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Sep 2015 22:02:11 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id t8AM2B7T016964
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Sep 2015 15:02:11 -0700 (PDT)
Received: from msp-dhcp23.wrs.com (172.25.34.23) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.3.235.1;
	Thu, 10 Sep 2015 15:02:11 -0700
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 10 Sep 2015 17:02:10 -0500
Message-ID: <1441922530-133753-1-git-send-email-mark.hatle@windriver.com>
X-Mailer: git-send-email 1.9.3
MIME-Version: 1.0
Subject: [PATCH] fetch2/__init__.py: uri_replace regex handling
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
X-List-Received-Date: Thu, 10 Sep 2015 22:02:14 -0000
Content-Type: text/plain

We should only substitute one time.  If we do it without a max count, we can
end up matching over and over.

Before this change:

https://downloads.yoctoproject.org/releases/bitbake/bitbake-1.0.tar.gz

with a mirror of

https://.*/[^/]*    http://AAAA/A/A/A/

would end up either recursing indefinitely or result in:

http://AAAA/A/A/A/A/A/A/A/A/A/bitbake-1.0.tar.gz

Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
---
 lib/bb/fetch2/__init__.py | 2 +-
 lib/bb/tests/fetch.py     | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 3d53b63..569007f 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -464,7 +464,7 @@ def uri_replace(ud, uri_find, uri_replace, replacements, d):
                 for k in replacements:
                     uri_replace_decoded[loc] = uri_replace_decoded[loc].replace(k, replacements[k])
                 #bb.note("%s %s %s" % (regexp, uri_replace_decoded[loc], uri_decoded[loc]))
-                result_decoded[loc] = re.sub(regexp, uri_replace_decoded[loc], uri_decoded[loc])
+                result_decoded[loc] = re.sub(regexp, uri_replace_decoded[loc], uri_decoded[loc], 1)
             if loc == 2:
                 # Handle path manipulations
                 basename = None
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 1e61f3a..8486224 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -405,6 +405,13 @@ class MirrorUriTest(FetcherTest):
                                 'http://otherdownloads.yoctoproject.org/downloads/bitbake-1.0.tar.gz',
                                 'http://downloads2.yoctoproject.org/downloads/bitbake-1.0.tar.gz'])
 
+    recmirrorvar = "https://.*/[^/]*    http://AAAA/A/A/A/ \n"
+
+    def test_recursive(self):
+        fetcher = bb.fetch.FetchData("https://downloads.yoctoproject.org/releases/bitbake/bitbake-1.0.tar.gz", self.d)
+        mirrors = bb.fetch2.mirror_from_string(self.recmirrorvar)
+        uris, uds = bb.fetch2.build_mirroruris(fetcher, mirrors, self.d)
+        self.assertEqual(uris, ['http://AAAA/A/A/A/bitbake/bitbake-1.0.tar.gz'])
 
 class FetcherLocalTest(FetcherTest):
     def setUp(self):
-- 
1.9.3


