Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by mx.groups.io with SMTP id smtpd.web09.1187.1604537965132707978
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 04 Nov 2020 16:59:25 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: intel.com, ip: 192.55.52.43, mailfrom: chee.yang.lee@intel.com)
IronPort-SDR: QciW1U/QvRWII9t2RSOmCSX6qwi0CKGiCNKbEyZQRzA/6wGfUiwF6OhpA8IHr+3mtn+5kAj47S
 cixgX8pn8bHg==
X-IronPort-AV: E=McAfee;i="6000,8403,9795"; a="254017112"
X-IronPort-AV: E=Sophos;i="5.77,451,1596524400"; 
   d="scan'208";a="254017112"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2020 16:59:23 -0800
IronPort-SDR: 9zz1EPxpxjYqdUi7M/Z2zuTKsx5+ENNgHjFkW3kkQbq3lNn4VbrLE7zRXnkdv7WNvIbuOmF2uE
 qqWZgR9jhq2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,451,1596524400"; 
   d="scan'208";a="364167820"
Received: from unknown (HELO guest1-ubuntu1804.png.intel.com) ([10.221.183.51])
  by orsmga007.jf.intel.com with ESMTP; 04 Nov 2020 16:59:21 -0800
From: "Lee Chee Yang" <chee.yang.lee@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] BBHandler: prompt error when task name contain expression
Date: Thu,  5 Nov 2020 08:59:21 +0800
Message-Id: <20201105005921.56640-1-chee.yang.lee@intel.com>
X-Mailer: git-send-email 2.17.1

From: Lee Chee Yang <chee.yang.lee@intel.com>

Task name contain expresion (eg, do_foo_remove_bar) can cause fatal error.

Check for naming before addtask. Prompt with understandable error message
when expression found in task name.

[YOCTO #8805]

Signed-off-by: Lee Chee Yang <chee.yang.lee@intel.com>
---
 lib/bb/parse/parse_py/BBHandler.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/bb/parse/parse_py/BBHandler.py b/lib/bb/parse/parse_py/BBHandler.py
index 215f940b..dd9a92b4 100644
--- a/lib/bb/parse/parse_py/BBHandler.py
+++ b/lib/bb/parse/parse_py/BBHandler.py
@@ -13,7 +13,7 @@
 #
 
 import re, bb, os
-import bb.build, bb.utils
+import bb.build, bb.utils, bb.data_smart
 
 from . import ConfHandler
 from .. import resolve_file, ast, logger, ParseError
@@ -233,6 +233,10 @@ def feeder(lineno, s, fn, root, statements, eof=False):
             if taskexpression.count(word) > 1:
                 logger.warning("addtask contained multiple '%s' keywords, only one is supported" % word)
 
+        # Check and warn for having task with exprssion as part of task name
+        for te in taskexpression:
+            if any( ( "%s_" % keyword ) in te for keyword in bb.data_smart.__setvar_keyword__ ):
+                raise ParseError("Task name '%s' contain expression keyword, this is confusing the parser.\nAvoid using these expression keyword in task name.\n%s" % (te, ("\n".join(map(str, bb.data_smart.__setvar_keyword__)))), fn)
         ast.handleAddTask(statements, fn, lineno, m)
         return
 
-- 
2.17.1

