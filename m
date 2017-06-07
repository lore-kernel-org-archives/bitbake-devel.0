Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id BFE1D781AD
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  7 Jun 2017 19:05:00 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	07 Jun 2017 12:05:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.39,311,1493708400"; d="scan'208";a="865610507"
Received: from nippert-mobl.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.38.12])
	by FMSMGA003.fm.intel.com with ESMTP; 07 Jun 2017 12:05:01 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  7 Jun 2017 21:04:17 +0200
Message-Id: <291da7b60b6dd829567e8c0081a4237b6df1cf9c.1496862217.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <cover.1496862217.git.paul.eggleton@linux.intel.com>
References: <cover.1496862217.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 2/2] knotty: prevent extra logger from being enabled for tinfoil
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
X-List-Received-Date: Wed, 07 Jun 2017 19:05:01 -0000

tinfoil sets up its own logger by default, but if and when we initialise
the UI (by default knotty) will also set one up, leading to duplicated
messages specifically from tasks. To avoid this, rather than adding some
kind of parameter, just check if there is already a logger outputting to
stdout/stderr and if so, skip adding our own.

Part of the fix for [YOCTO #11275].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/msg.py       | 7 +++++++
 lib/bb/ui/knotty.py | 5 +++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/lib/bb/msg.py b/lib/bb/msg.py
index 90b1582..f1723be 100644
--- a/lib/bb/msg.py
+++ b/lib/bb/msg.py
@@ -216,3 +216,10 @@ def logger_create(name, output=sys.stderr, level=logging.INFO, preserve_handlers
         logger.handlers = [console]
     logger.setLevel(level)
     return logger
+
+def has_console_handler(logger):
+    for handler in logger.handlers:
+        if isinstance(handler, logging.StreamHandler):
+            if handler.stream in [sys.stderr, sys.stdout]:
+                return True
+    return False
diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 82aa7c4..a19c3b3 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -365,8 +365,9 @@ def main(server, eventHandler, params, tf = TerminalFilter):
     bb.msg.addDefaultlogFilter(errconsole, bb.msg.BBLogFilterStdErr)
     console.setFormatter(format)
     errconsole.setFormatter(format)
-    logger.addHandler(console)
-    logger.addHandler(errconsole)
+    if not bb.msg.has_console_handler(logger):
+        logger.addHandler(console)
+        logger.addHandler(errconsole)
 
     bb.utils.set_process_name("KnottyUI")
 
-- 
2.9.4


