Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 31A2F7871D
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  1 Feb 2018 15:14:59 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id w11FF1AJ024866
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 1 Feb 2018 07:15:01 -0800 (PST)
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.361.1; Thu, 1 Feb 2018 07:15:00 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 1 Feb 2018 23:15:23 +0800
Message-ID: <a81f9d5903350f2852919ba2d47d9be82b159732.1517497731.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1517497731.git.liezhi.yang@windriver.com>
References: <cover.1517497731.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 2/8] bitbake: cooker: fix for BBFILE_PATTERN matches bbappend
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
X-List-Received-Date: Thu, 01 Feb 2018 15:15:00 -0000
Content-Type: text/plain

The old code couldn't handle nestled layers correctly, e.g.:
parent_layer/sub_layer/foo.bb

Note there are two layers, parent_layer and sub_layer.
And in parent_layer/conf/layer.conf:
BBFILE_PATTERN_parent_layer = ""^${LAYERDIR}/"

This setting is incorrect since it also matches parent_layer/sub_layer/foo.bb,
so it warns that no files matched sub_layer, this is the expected behavior, but
it doesn't warn when there is a parent_layer/sub_layer/bar.bbappend, this was
incorrect since the bbappend is also matched by BBFILE_PATTERN_parent_layer, it
should warn and let the user fix the problem. Check the bbappend in already
"matched set" before return it as matched by "unmatched set" can fix the problem.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/cooker.py | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index f0dab97..f991c8f 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1808,21 +1808,25 @@ class CookerCollectFiles(object):
             realfn, cls, mc = bb.cache.virtualfn2realfn(p)
             priorities[p] = self.calc_bbfile_priority(realfn, matched)
 
-        # Don't show the warning if the BBFILE_PATTERN did match .bbappend files
         unmatched = set()
         for _, _, regex, pri in self.bbfile_config_priorities:
             if not regex in matched:
                 unmatched.add(regex)
 
-        def findmatch(regex):
+        # Don't show the warning if the BBFILE_PATTERN did match .bbappend files
+        def find_bbappend_match(regex):
             for b in self.bbappends:
                 (bbfile, append) = b
                 if regex.match(append):
+                    # If the bbappend is matched by already "matched set", return False
+                    for matched_regex in matched:
+                        if matched_regex.match(append):
+                            return False
                     return True
             return False
 
         for unmatch in unmatched.copy():
-            if findmatch(unmatch):
+            if find_bbappend_match(unmatch):
                 unmatched.remove(unmatch)
 
         for collection, pattern, regex, _ in self.bbfile_config_priorities:
-- 
2.7.4


