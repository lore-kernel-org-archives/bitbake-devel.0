Return-Path: <markus.lehtonen@linux.intel.com>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by mail.openembedded.org (Postfix) with ESMTP id CE4A771BF8
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  1 Nov 2016 15:05:13 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by orsmga105.jf.intel.com with ESMTP; 01 Nov 2016 08:05:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.31,580,1473145200"; d="scan'208";a="186337519"
Received: from marquiz.fi.intel.com ([10.237.72.155])
	by fmsmga004.fm.intel.com with ESMTP; 01 Nov 2016 08:05:14 -0700
From: Markus Lehtonen <markus.lehtonen@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  1 Nov 2016 17:05:11 +0200
Message-Id: <1478012712-17287-2-git-send-email-markus.lehtonen@linux.intel.com>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <1478012712-17287-1-git-send-email-markus.lehtonen@linux.intel.com>
References: <1478012712-17287-1-git-send-email-markus.lehtonen@linux.intel.com>
Subject: [PATCH 1/2] data: fix exception handling in exported_vars()
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
X-List-Received-Date: Tue, 01 Nov 2016 15:05:14 -0000

Fix a bug where a totally wrong value of a variable would be exported if
an exception happened during d.getVar(). Also, print a warning if an
exception happends instead of silently ignoring it. It would probably be
best just to raise the exception, instead, but use the warning for now
in order to avoid breaking existing builds.

[YOCTO #10393]

Signed-off-by: Markus Lehtonen <markus.lehtonen@linux.intel.com>
---
 lib/bb/data.py | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/lib/bb/data.py b/lib/bb/data.py
index c1f27cd..c56965c 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -258,11 +258,13 @@ def exported_keys(d):
                                       not d.getVarFlag(key, 'unexport', False))
 
 def exported_vars(d):
-    for key in exported_keys(d):
+    k = list(exported_keys(d))
+    for key in k:
         try:
             value = d.getVar(key, True)
-        except Exception:
-            pass
+        except Exception as err:
+            bb.warn("%s: Unable to export ${%s}: %s" % (d.getVar("FILE", True), key, err))
+            continue
 
         if value is not None:
             yield key, str(value)
-- 
2.6.6


