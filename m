Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1SzOld-0002z4-QD
	for bitbake-devel@lists.openembedded.org;
	Thu, 09 Aug 2012 11:10:58 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id q798x9lO002689
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 9 Aug 2012 01:59:09 -0700 (PDT)
Received: from usp-ub10.corp.ad.wrs.com (128.224.163.69) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.2.309.2; Thu, 9 Aug 2012 01:59:08 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 9 Aug 2012 16:56:26 +0800
Message-ID: <2caf68f6aa334948840a647d7c34a59f0405d11b.1344482807.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <cover.1344482807.git.liezhi.yang@windriver.com>
References: <cover.1344482807.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Cc: Zhenfeng.Zhao@windriver.com
Subject: [PATCH 1/1] fetch2/__init__.py: add an "auto" policy for BB_SRCREV_POLICY
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 09 Aug 2012 09:10:58 -0000
Content-Type: text/plain

The newly added "auto" policy is used for the SRCREV="${AUTOREV}" recipe,
the current BB_SRCREV_POLICY are: "clear" (default) and "cache":

* When "clear", the "AUTOREV" recipe will not be cached in bb_cache.dat

* When "cache", the "AUTOREV" would be cached in bb_cache.dat, but it
  doesn't try to get the latest revision.

The "auto" policy is much like the "cache" except that it will try to
get the latest revision.

[YOCTO #2920]

Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/fetch2/__init__.py |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 12ebce2..27b73c0 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -249,8 +249,8 @@ def fetcher_init(d):
     Calls before this must not hit the cache.
     """
     # When to drop SCM head revisions controlled by user policy
-    srcrev_policy = d.getVar('BB_SRCREV_POLICY', True) or "clear"
-    if srcrev_policy == "cache":
+    srcrev_policy = get_srcrev_policy(d)
+    if srcrev_policy == "cache" or srcrev_policy == "auto":
         logger.debug(1, "Keeping SRCREV cache due to cache policy of: %s", srcrev_policy)
     elif srcrev_policy == "clear":
         logger.debug(1, "Clearing SRCREV cache due to cache policy of: %s", srcrev_policy)
@@ -384,9 +384,13 @@ def subprocess_setup():
     # SIGPIPE errors are known issues with gzip/bash
     signal.signal(signal.SIGPIPE, signal.SIG_DFL)
 
+def get_srcrev_policy(d):
+    return d.getVar('BB_SRCREV_POLICY', True) or "auto"
+
 def get_autorev(d):
     #  only not cache src rev in autorev case
-    if d.getVar('BB_SRCREV_POLICY', True) != "cache":
+    srcrev_policy = get_srcrev_policy(d)
+    if srcrev_policy != "cache" and srcrev_policy != "auto":
         d.setVar('__BB_DONT_CACHE', '1')
     return "AUTOINC"
 
@@ -1048,6 +1052,8 @@ class FetchMethod(object):
 
         revs = bb.persist_data.persist('BB_URI_HEADREVS', d)
         key = self.generate_revision_key(url, ud, d, name)
+        if get_srcrev_policy(d) == "auto":
+            revs[key] = self._latest_revision(url, ud, d, name)
         try:
             return revs[key]
         except KeyError:
-- 
1.7.1



