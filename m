Return-Path: <markus.lehtonen@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 65671731F9
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 30 Aug 2016 09:53:42 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga103.fm.intel.com with ESMTP; 30 Aug 2016 02:53:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.30,255,1470726000"; d="scan'208";a="1022186488"
Received: from dthoumin-mobl2.ger.corp.intel.com (HELO
	mqz-osx-suse64.fi.intel.com) ([10.252.6.138])
	by orsmga001.jf.intel.com with ESMTP; 30 Aug 2016 02:53:33 -0700
From: Markus Lehtonen <markus.lehtonen@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 30 Aug 2016 12:53:30 +0300
Message-Id: <1472550810-10006-1-git-send-email-markus.lehtonen@linux.intel.com>
X-Mailer: git-send-email 2.6.6
Subject: [PATCH] Fail gracefully if event handler function is not found
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
X-List-Received-Date: Tue, 30 Aug 2016 09:53:43 -0000

[YOCTO #10186]

Signed-off-by: Markus Lehtonen <markus.lehtonen@linux.intel.com>
---
 lib/bb/cookerdata.py | 3 +++
 lib/bb/parse/ast.py  | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index fa1de7a..bf9bfbf 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -357,6 +357,9 @@ class CookerDataBuilder(object):
         # We register any handlers we've found so far here...
         for var in data.getVar('__BBHANDLERS', False) or []:
             handlerfn = data.getVarFlag(var, "filename", False)
+            if not handlerfn:
+                parselog.critical("Undefined event handler function '%s'" % var)
+                sys.exit(1)
             handlerln = int(data.getVarFlag(var, "lineno", False))
             bb.event.register(var, data.getVar(var, False),  (data.getVarFlag(var, "eventmask", True) or "").split(), handlerfn, handlerln)
 
diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index d7185b1..fa83b18 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -344,6 +344,8 @@ def finalize(fn, d, variant = None):
     for var in d.getVar('__BBHANDLERS', False) or []:
         # try to add the handler
         handlerfn = d.getVarFlag(var, "filename", False)
+        if not handlerfn:
+            bb.fatal("Undefined event handler function '%s'" % var)
         handlerln = int(d.getVarFlag(var, "lineno", False))
         bb.event.register(var, d.getVar(var, False), (d.getVarFlag(var, "eventmask", True) or "").split(), handlerfn, handlerln)
 
-- 
2.6.6


