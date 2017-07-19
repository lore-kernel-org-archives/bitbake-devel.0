Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id E744878249
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Jul 2017 09:56:52 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	19 Jul 2017 02:56:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.40,380,1496127600"; d="scan'208";a="880410434"
Received: from gsena-mobl.amr.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.48.213])
	by FMSMGA003.fm.intel.com with ESMTP; 19 Jul 2017 02:56:54 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 19 Jul 2017 11:56:11 +0200
Message-Id: <795aef829eb4d1ca43a855b0ecb241063a16fb16.1500458081.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <cover.1500458081.git.paul.eggleton@linux.intel.com>
References: <cover.1500458081.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 12/12] fetch2: fire an event when there are missing checksums
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
X-List-Received-Date: Wed, 19 Jul 2017 09:56:53 -0000

If BB_STRICT_CHECKSUMS is set to anything other than "1" i.e. we're not
going to raise an error, then fire an event so that scripts can listen
for it and get the checksums.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/fetch2/__init__.py | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 2e615b2..74ba37f 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -39,6 +39,7 @@ import errno
 import bb.persist_data, bb.utils
 import bb.checksum
 import bb.process
+import bb.event
 
 __version__ = "2"
 _checksum_cache = bb.checksum.FileChecksumCache()
@@ -142,6 +143,13 @@ class NonLocalMethod(Exception):
     def __init__(self):
         Exception.__init__(self)
 
+class MissingChecksumEvent(bb.event.Event):
+    def __init__(self, url, md5sum, sha256sum):
+        self.url = url
+        self.checksums = {'md5sum': md5sum,
+                          'sha256sum': sha256sum}
+        bb.event.Event.__init__(self)
+
 
 class URI(object):
     """
@@ -584,6 +592,8 @@ def verify_checksum(ud, d, precomputed={}):
                               ud.sha256_name, sha256data))
             raise NoChecksumError('Missing SRC_URI checksum', ud.url)
 
+        bb.event.fire(MissingChecksumEvent(ud.url, md5data, sha256data), d)
+
         if strict == "ignore":
             return {
                 _MD5_KEY: md5data,
-- 
2.9.4


