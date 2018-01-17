Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id B9FB8786BD
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 17 Jan 2018 08:52:37 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id w0H8qcTa023584
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 17 Jan 2018 00:52:39 -0800 (PST)
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.361.1; Wed, 17 Jan 2018 00:52:38 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 17 Jan 2018 16:52:51 +0800
Message-ID: <1036e79f934acc33ac1e05424dee33e1857eae00.1516179099.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1516179099.git.liezhi.yang@windriver.com>
References: <cover.1516179099.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 2/2] cooker.py: fix for BBFILE_PATTERN matches bbappend
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
X-List-Received-Date: Wed, 17 Jan 2018 08:52:37 -0000
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
 lib/bb/cooker.py | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index ebfed0d..148c745 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1807,21 +1807,25 @@ class CookerCollectFiles(object):
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


