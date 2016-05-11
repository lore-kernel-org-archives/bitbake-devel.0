Return-Path: <humberto.ibarra.lopez@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 65B296E666
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 11 May 2016 20:00:50 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by orsmga102.jf.intel.com with ESMTP; 11 May 2016 13:00:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,609,1455004800"; d="scan'208";a="101475433"
Received: from jhibarra-desk.zpn.intel.com ([10.219.18.66])
	by fmsmga004.fm.intel.com with ESMTP; 11 May 2016 13:00:52 -0700
From: Humberto Ibarra <humberto.ibarra.lopez@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 11 May 2016 15:01:08 -0500
Message-Id: <1462996868-10200-1-git-send-email-humberto.ibarra.lopez@intel.com>
X-Mailer: git-send-email 2.4.11
Subject: [PATCH v2] bitbake/lib/bb/cookerdata.py: Check if layer conf files exist before parsing them
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
X-List-Received-Date: Wed, 11 May 2016 20:00:53 -0000

If an invalid layer is added to bblayers.conf, the parsing of said file
ends with a trace and an "Unable to parse" exception. This is not the
ideal output, especially considering that we know exactly why this is failing.

This patch checks if a layer conf file exists before trying to parse it.
If it does not, a clear and more concise message is send to the user.
Otherwise, the parsing continues.

[Yocto #9506]

Signed-off-by: Humberto Ibarra <humberto.ibarra.lopez@intel.com>
---
 bitbake/lib/bb/cookerdata.py | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/cookerdata.py b/bitbake/lib/bb/cookerdata.py
index 50259a9..a1b0457 100644
--- a/bitbake/lib/bb/cookerdata.py
+++ b/bitbake/lib/bb/cookerdata.py
@@ -178,9 +178,13 @@ def catch_parse_error(func):
         try:
             return func(fn, *args)
         except IOError as exc:
-            import traceback
-            parselog.critical(traceback.format_exc())
-            parselog.critical("Unable to parse %s: %s" % (fn, exc))
+            import errno
+            if exc.errno == errno.ENOENT:
+                parselog.critical("Unable to find the configuration file: %s" % fn)
+            else:
+                import traceback
+                parselog.critical(traceback.format_exc())
+                parselog.critical("Unable to parse %s: %s" % (fn, exc))
             sys.exit(1)
         except bb.data_smart.ExpansionError as exc:
             import traceback
-- 
2.4.11


