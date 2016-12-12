Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 6B2FA71A74
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 12 Dec 2016 21:54:02 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 12 Dec 2016 13:54:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,338,1477983600"; d="scan'208";a="1071257011"
Received: from mauric9x-mobl.amr.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com.fritz.box) ([10.255.158.7])
	by orsmga001.jf.intel.com with ESMTP; 12 Dec 2016 13:53:59 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 13 Dec 2016 10:53:51 +1300
Message-Id: <527403c2ec01f6cec8d5cde2530a6953ba54522a.1481579534.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <cover.1481579534.git.paul.eggleton@linux.intel.com>
References: <cover.1481579534.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/1] lib/bb/build: enable access to logger within tasks
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
X-List-Received-Date: Mon, 12 Dec 2016 21:54:02 -0000

In certain circumstances it can be useful to get access to BitBake's
logger within a task; the main example is in OpenEmbedded's image
construction code where we want to be able to check the log file for
errors and warnings, but we don't want to see any errors or warnings
that were emitted through the logger; so we need a way to exclude those.
In order to do this, pass the logger object into the task via a
BB_TASK_LOGGER variable, and add a logging handler class to bb.utils
that can be added to it in order to keep a list of warnings/errors that
have been emitted.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/build.py |  1 +
 lib/bb/utils.py | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 7a7aabb..0c2c1ba 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -562,6 +562,7 @@ def _exec_task(fn, task, d, quieterr):
 
     localdata.setVar('BB_LOGFILE', logfn)
     localdata.setVar('BB_RUNTASK', task)
+    localdata.setVar('BB_TASK_LOGGER', bblogger)
 
     flags = localdata.getVarFlags(task)
 
diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 9073f15..a22a05e 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -1503,3 +1503,14 @@ def load_plugins(logger, plugins, pluginpath):
                 plugins.append(obj or plugin)
             else:
                 plugins.append(plugin)
+
+
+class LogCatcher(logging.Handler):
+    """Logging handler for collecting logged messages so you can check them later"""
+    def __init__(self):
+        self.messages = []
+        logging.Handler.__init__(self, logging.WARNING)
+    def emit(self, record):
+        self.messages.append(bb.build.logformatter.format(record))
+    def contains(self, message):
+        return (message in self.messages)
-- 
2.5.5


