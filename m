Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 7BAC775D39
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 14 Jul 2015 14:26:50 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga102.fm.intel.com with ESMTP; 14 Jul 2015 07:26:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,472,1432623600"; d="scan'208";a="728648418"
Received: from cbernard-mobl.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.31.54])
	by orsmga001.jf.intel.com with ESMTP; 14 Jul 2015 07:26:50 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 14 Jul 2015 15:26:41 +0100
Message-Id: <94207ba80494f6487d33da81e63a0b4e75250edb.1436883632.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <cover.1436883632.git.paul.eggleton@linux.intel.com>
References: <cover.1436883632.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1436883632.git.paul.eggleton@linux.intel.com>
References: <cover.1436883632.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/2] lib/bb: provide mechanism to bypass UI log suppression
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
X-List-Received-Date: Tue, 14 Jul 2015 14:26:50 -0000

The recent change to connect through the shell logging functions had an
unexpected side-effect - bb.error() and bb.fatal() cause a flag to be
set internally such that BitBake's UI will not print the full task log
on failure; unfortunately we have in places within the OpenEmbedded
metadata called these shell logging functions under error situations
where we still want to see the full log (i.e., the message we're sending
doesn't include the full error). Thus, provide a mechanism to fatally
exit with an error but unset the flag, utilising the built-in python
logging functionality that allows extra values to be passed in the log
record.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/__init__.py | 8 ++++----
 lib/bb/build.py    | 7 ++++++-
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/lib/bb/__init__.py b/lib/bb/__init__.py
index 1a30fa1..1f7946e 100644
--- a/lib/bb/__init__.py
+++ b/lib/bb/__init__.py
@@ -94,11 +94,11 @@ def note(*args):
 def warn(*args):
     logger.warn(''.join(args))
 
-def error(*args):
-    logger.error(''.join(args))
+def error(*args, **kwargs):
+    logger.error(''.join(args), extra=kwargs)
 
-def fatal(*args):
-    logger.critical(''.join(args))
+def fatal(*args, **kwargs):
+    logger.critical(''.join(args), extra=kwargs)
     raise BBHandledException()
 
 def deprecated(func, name=None, advice=""):
diff --git a/lib/bb/build.py b/lib/bb/build.py
index cce01fe..3439964 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -350,6 +350,8 @@ exit $?
                 # The caller will call exit themselves, so bb.error() is
                 # what we want here rather than bb.fatal()
                 bb.error(value)
+            elif cmd == 'bbfatal_log':
+                bb.error(value, forcelog=True)
             elif cmd == 'bbdebug':
                 splitval = value.split(' ', 1)
                 level = int(splitval[0])
@@ -446,7 +448,10 @@ def _exec_task(fn, task, d, quieterr):
             self.triggered = False
             logging.Handler.__init__(self, logging.ERROR)
         def emit(self, record):
-            self.triggered = True
+            if getattr(record, 'forcelog', False):
+                self.triggered = False
+            else:
+                self.triggered = True
 
     # Handle logfiles
     si = open('/dev/null', 'r')
-- 
2.1.0


