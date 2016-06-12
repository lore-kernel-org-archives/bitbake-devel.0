Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 3018C7318D
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 12 Jun 2016 08:45:00 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id u5C8j1JK010114
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 12 Jun 2016 01:45:01 -0700 (PDT)
Received: from ala-blade47.wrs.com (147.11.105.67) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.248.2;
	Sun, 12 Jun 2016 01:45:00 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Sun, 12 Jun 2016 01:45:00 -0700
Message-ID: <23816ef5cf6ded66923a1de98141fae9573923ee.1465721061.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <cover.1465721061.git.liezhi.yang@windriver.com>
References: <cover.1465721061.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/1] cooker.py: fix warn() -> warning()
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
X-List-Received-Date: Sun, 12 Jun 2016 08:45:01 -0000
Content-Type: text/plain

Fixed:
DeprecationWarning: The 'warn' method is deprecated, use 'warning' instead

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/cooker.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 2154ef4..ce818f3 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1576,7 +1576,7 @@ class BBCooker:
         ignore = (self.expanded_data.getVar("ASSUME_PROVIDED", True) or "").split()
         for pkg in pkgs_to_build:
             if pkg in ignore:
-                parselog.warn("Explicit target \"%s\" is in ASSUME_PROVIDED, ignoring" % pkg)
+                parselog.warning("Explicit target \"%s\" is in ASSUME_PROVIDED, ignoring" % pkg)
 
         if 'world' in pkgs_to_build:
             bb.providers.buildWorldTargetList(self.recipecache)
@@ -1585,7 +1585,7 @@ class BBCooker:
                 pkgs_to_build.append(t)
 
         if 'universe' in pkgs_to_build:
-            parselog.warn("The \"universe\" target is only intended for testing and may produce errors.")
+            parselog.warning("The \"universe\" target is only intended for testing and may produce errors.")
             parselog.debug(1, "collating packages for \"universe\"")
             pkgs_to_build.remove('universe')
             for t in self.recipecache.universe_target:
@@ -1867,7 +1867,7 @@ class CookerCollectFiles(object):
         for collection, pattern, regex, _ in self.bbfile_config_priorities:
             if regex in unmatched:
                 if d.getVar('BBFILE_PATTERN_IGNORE_EMPTY_%s' % collection, True) != '1':
-                    collectlog.warn("No bb files matched BBFILE_PATTERN_%s '%s'" % (collection, pattern))
+                    collectlog.warning("No bb files matched BBFILE_PATTERN_%s '%s'" % (collection, pattern))
 
         return priorities
 
-- 
2.8.0


