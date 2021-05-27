Received: from mail5.wrs.com (mail5.wrs.com [192.103.53.11])
 by mx.groups.io with SMTP id smtpd.web10.3657.1622099164092591252
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 May 2021 00:06:04 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: windriver.com, ip: 192.103.53.11, mailfrom: mingli.yu@windriver.com)
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.corp.ad.wrs.com [147.11.82.252])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id 14R760CK031369
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 27 May 2021 00:06:00 -0700
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Thu, 27 May 2021 00:06:00 -0700
Received: from pek-lpg-core2.corp.ad.wrs.com (128.224.153.41) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2242.10 via Frontend Transport; Thu, 27 May 2021 00:05:59 -0700
From: "Yu, Mingli" <mingli.yu@windriver.com>
To: <bitbake-devel@lists.openembedded.org>,
        <richard.purdie@linuxfoundation.org>
Subject: [PATCH v2] fetch2: make sure the uri added as expected
Date: Thu, 27 May 2021 15:04:25 +0800
Message-ID: <20210527070425.35230-1-mingli.yu@windriver.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <16806B6C2D8F7DAB.5504@lists.openembedded.org>
References: <16806B6C2D8F7DAB.5504@lists.openembedded.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Mingli Yu <mingli.yu@windriver.com>

When call uri_replace to get the new uris, we should guarantee the
new uri is added when the replace uri begins with file if the find
uri begin with wildcard which mapped as below.
PREMIRRORS_append = " \
     .*://.*/.*  git://somewhere.org/somedir/MIRRORNAME;protocol=http \n \
"      |         |
       |         |
       |         |
       find      replace

Before the patch:
the original uri
gitsm://github.com/tianocore/edk2.git;branch=master;protocol=https

PREMIRRORS_append = " \
     .*://.*/.*  git://somewhere.org/somedir/MIRRORNAME;protocol=http \n \
"
The new uri is git://somewhere.org/somedir/github.com.tianocore.edk2.git/git2_github.com.tianocore.edk2.git.tar.gz;protocol=http

After the patch:
the original uri
gitsm://github.com/tianocore/edk2.git;branch=master;protocol=https

PREMIRRORS_append = " \
     .*://.*/.*  git://somewhere.org/somedir/MIRRORNAME;protocol=http \n \
"
The new uri is None as the find begins with wildcard but the replace
doesn't begin with file.

Signed-off-by: Mingli Yu <mingli.yu@windriver.com>
---
 lib/bb/fetch2/__init__.py | 2 ++
 lib/bb/tests/fetch.py     | 8 +++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index cf0201c4..6701654b 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -430,6 +430,8 @@ def uri_replace(ud, uri_find, uri_replace, replacements, d, mirrortarball=None):
     uri_replace_decoded = list(decodeurl(uri_replace))
     logger.debug2("For url %s comparing %s to %s" % (uri_decoded, uri_find_decoded, uri_replace_decoded))
     result_decoded = ['', '', '', '', '', {}]
+    if uri_find_decoded[0] == '.*' and uri_replace_decoded[0] != 'file':
+        uri_find_decoded[0] = uri_replace_decoded[0]
     for loc, i in enumerate(uri_find_decoded):
         result_decoded[loc] = uri_decoded[loc]
         regexp = i
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 9291ce4a..85a14301 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -406,6 +406,8 @@ class MirrorUriTest(FetcherTest):
             : "git://somewhere.org/mtd-utils.git;tag=1234567890123456789012345678901234567890;protocol=http", 
         ("git://someserver.org/bitbake;tag=1234567890123456789012345678901234567890", "git://someserver.org/bitbake", "git://git.openembedded.org/bitbake")
             : "git://git.openembedded.org/bitbake;tag=1234567890123456789012345678901234567890",
+        ("gitsm://github.com/tianocore/edk2.git;branch=master;protocol=https", ".*://.*/.*", "git://somewhere.org/somedir/MIRRORNAME;protocol=http")
+            : None,
         ("file://sstate-xyz.tgz", "file://.*", "file:///somewhere/1234/sstate-cache") 
             : "file:///somewhere/1234/sstate-cache/sstate-xyz.tgz",
         ("file://sstate-xyz.tgz", "file://.*", "file:///somewhere/1234/sstate-cache/") 
@@ -447,7 +449,11 @@ class MirrorUriTest(FetcherTest):
             ud.setup_localpath(self.d)
             mirrors = bb.fetch2.mirror_from_string("%s %s" % (k[1], k[2]))
             newuris, uds = bb.fetch2.build_mirroruris(ud, mirrors, self.d)
-            self.assertEqual([v], newuris)
+            if not v:
+                 self.assertEqual([v], newuris)
+            else:
+                 self.assertEqual([], newuris)
+
 
     def test_urilist1(self):
         fetcher = bb.fetch.FetchData("http://downloads.yoctoproject.org/releases/bitbake/bitbake-1.0.tar.gz", self.d)
-- 
2.29.2

