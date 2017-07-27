Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 061317825C
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Jul 2017 12:52:10 +0000 (UTC)
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
	by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	27 Jul 2017 05:52:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.40,419,1496127600"; d="scan'208";a="131949812"
Received: from nippert-mobl.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.43.119])
	by fmsmga005.fm.intel.com with ESMTP; 27 Jul 2017 05:52:11 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 27 Jul 2017 14:51:49 +0200
Message-Id: <567abdb2af03b7f933bf7fa83ac4a85162ef7a2e.1501159861.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <cover.1501159861.git.paul.eggleton@linux.intel.com>
References: <cover.1501159861.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/1] bitbake-diffsigs: fix regression after recent server changes
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
X-List-Received-Date: Thu, 27 Jul 2017 12:52:11 -0000

We were bridging the gap between the server and UI here by calling a
bb.siggen.find_siginfo, a function defined and set on that module from
the metadata. This worked from the UI side before but since the recent
server changes is no longer accessible. Create a new command so this can
execute on the server side and return the result by way of a new event.

(We're still running compare_sigfiles() on the signature generator but
that isn't quite the same thing and does still work.)

Fixes [YOCTO #11844].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bin/bitbake-diffsigs | 35 ++++++++++++++++++++++++++++-------
 lib/bb/command.py    | 11 +++++++++++
 lib/bb/event.py      |  8 ++++++++
 3 files changed, 47 insertions(+), 7 deletions(-)

diff --git a/bin/bitbake-diffsigs b/bin/bitbake-diffsigs
index eb2f859..4e6bbdd 100755
--- a/bin/bitbake-diffsigs
+++ b/bin/bitbake-diffsigs
@@ -34,18 +34,39 @@ import bb.msg
 
 logger = bb.msg.logger_create('bitbake-diffsigs')
 
+def find_siginfo(tinfoil, pn, taskname, sigs=None):
+    result = None
+    tinfoil.set_event_mask(['bb.event.FindSigInfoResult',
+                            'logging.LogRecord',
+                            'bb.command.CommandCompleted',
+                            'bb.command.CommandFailed'])
+    ret = tinfoil.run_command('findSigInfo', pn, taskname, sigs)
+    if ret:
+        while True:
+            event = tinfoil.wait_event(1)
+            if event:
+                if isinstance(event, bb.command.CommandCompleted):
+                    break
+                elif isinstance(event, bb.command.CommandFailed):
+                    logger.error(str(event))
+                    sys.exit(2)
+                elif isinstance(event, bb.event.FindSigInfoResult):
+                    result = event.result
+                elif isinstance(event, logging.LogRecord):
+                    logger.handle(event)
+    else:
+        logger.error('No result returned from findSigInfo command')
+        sys.exit(2)
+    return result
+
 def find_compare_task(bbhandler, pn, taskname, sig1=None, sig2=None, color=False):
     """ Find the most recent signature files for the specified PN/task and compare them """
 
-    if not hasattr(bb.siggen, 'find_siginfo'):
-        logger.error('Metadata does not support finding signature data files')
-        sys.exit(1)
-
     if not taskname.startswith('do_'):
         taskname = 'do_%s' % taskname
 
     if sig1 and sig2:
-        sigfiles = bb.siggen.find_siginfo(pn, taskname, [sig1, sig2], bbhandler.config_data)
+        sigfiles = find_siginfo(bbhandler, pn, taskname, [sig1, sig2])
         if len(sigfiles) == 0:
             logger.error('No sigdata files found matching %s %s matching either %s or %s' % (pn, taskname, sig1, sig2))
             sys.exit(1)
@@ -57,7 +78,7 @@ def find_compare_task(bbhandler, pn, taskname, sig1=None, sig2=None, color=False
             sys.exit(1)
         latestfiles = [sigfiles[sig1], sigfiles[sig2]]
     else:
-        filedates = bb.siggen.find_siginfo(pn, taskname, None, bbhandler.config_data)
+        filedates = find_siginfo(bbhandler, pn, taskname)
         latestfiles = sorted(filedates.keys(), key=lambda f: filedates[f])[-3:]
         if not latestfiles:
             logger.error('No sigdata files found matching %s %s' % (pn, taskname))
@@ -69,7 +90,7 @@ def find_compare_task(bbhandler, pn, taskname, sig1=None, sig2=None, color=False
     # Define recursion callback
     def recursecb(key, hash1, hash2):
         hashes = [hash1, hash2]
-        hashfiles = bb.siggen.find_siginfo(key, None, hashes, bbhandler.config_data)
+        hashfiles = find_siginfo(bbhandler, key, None, hashes)
 
         recout = []
         if len(hashfiles) == 0:
diff --git a/lib/bb/command.py b/lib/bb/command.py
index 0e0a35a..c44c7a6 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -746,3 +746,14 @@ class CommandsAsync:
         command.finishAsyncCommand()
     clientComplete.needcache = False
 
+    def findSigInfo(self, command, params):
+        """
+        Find signature info files via the signature generator
+        """
+        pn = params[0]
+        taskname = params[1]
+        sigs = params[2]
+        res = bb.siggen.find_siginfo(pn, taskname, sigs, command.cooker.data)
+        bb.event.fire(bb.event.FindSigInfoResult(res), command.cooker.data)
+        command.finishAsyncCommand()
+    findSigInfo.needcache = False
diff --git a/lib/bb/event.py b/lib/bb/event.py
index 59cca61..3827dcf 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -819,3 +819,11 @@ class NetworkTestFailed(Event):
     """
     Event to indicate network test has failed
     """
+
+class FindSigInfoResult(Event):
+    """
+    Event to return results from findSigInfo command
+    """
+    def __init__(self, result):
+        Event.__init__(self)
+        self.result = result
-- 
2.9.4


