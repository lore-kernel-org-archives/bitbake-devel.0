Return-Path: <seebs@msp-lpggp2.wrs.com>
Received: from msp-lpggp2.wrs.com (unknown [206.144.70.9])
	by mail.openembedded.org (Postfix) with ESMTP id 11E5A6DB9A
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Nov 2013 23:25:01 +0000 (UTC)
Received: by msp-lpggp2.wrs.com (Postfix, from userid 508)
	id DC634A02EB8; Wed, 20 Nov 2013 17:26:23 -0600 (CST)
From: Peter Seebach <peter.seebach@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 20 Nov 2013 17:26:23 -0600
Message-Id: <29b719bd775e944fea3c05bb7cb77e4885671120.1384989450.git.peter.seebach@windriver.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <cover.1384989450.git.peter.seebach@windriver.com>
References: <cover.1384989450.git.peter.seebach@windriver.com>
In-Reply-To: <cover.1384989450.git.peter.seebach@windriver.com>
References: <cover.1384989450.git.peter.seebach@windriver.com>
Subject: [PATCH 1/1] cooker.py and friends: Convert to using Sanity Check events.
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
X-List-Received-Date: Wed, 20 Nov 2013 23:25:02 -0000

We add two flags to SanityCheck events, one to indicate whether
a failure is tolerable (otherwise, the sanity check attempts to
abort execution), and another to tell it whether to try to use
SanityCheckPassed/SanityCheckFailed events.

So we set sanity_failure_ok if show_environment is set, to let
us distinguish between "tracking is enabled" and "we want to
continue past a sanity failure". This value propagates a little
to, for instance, a CookerDataBuilder created using the same
config flags. Also, we add SanityCheck to the list of known
events in knotty.py.

The intent of all this is to make it so that a system which
wants to do sanity checks can do them at a point other than
the handling of a ConfigParsed event, and can distinguish
between "sanity check failures should be fatal" and "sanity
check failures are fine by me". However, failed sanity checks
which don't exit should set SANITY_CHECKS_FAILED = "1".

Signed-off-by: Peter Seebach <peter.seebach@windriver.com>
---
 lib/bb/cooker.py     |    2 ++
 lib/bb/cookerdata.py |   10 ++++++++++
 lib/bb/event.py      |    4 ++++
 lib/bb/ui/knotty.py  |    1 +
 4 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 3295f6c..ea50c02 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -409,6 +409,8 @@ class BBCooker:
                 parselog.exception("Unable to read %s", fn)
                 raise
 
+        if self.data.getVar("SANITY_CHECK_FAILED", True) == "1":
+            logger.plain("# WARNING: SANITY CHECKS FAILED.")
         # Display history
         with closing(StringIO()) as env:
             self.data.inchistory.emit(env)
diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index e640ed0..b64bf1c 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -41,6 +41,7 @@ class ConfigParameters(object):
 
         self.options.tracking = False
         if hasattr(self.options, "show_environment") and self.options.show_environment:
+            self.options.sanity_failure_ok = True
             self.options.tracking = True
 
         for key, val in self.options.__dict__.items():
@@ -127,6 +128,8 @@ class CookerConfiguration(object):
         self.dump_signatures = False
         self.dry_run = False
         self.tracking = False
+        self.show_environment = False
+        self.sanity_failure_ok = False
 
         self.env = {}
 
@@ -207,6 +210,8 @@ class CookerDataBuilder(object):
         if self.tracking:
             self.data.enableTracking()
 
+        self.sanity_failure_ok = cookercfg.sanity_failure_ok
+
         # Keep a datastore of the initial environment variables and their
         # values from when BitBake was launched to enable child processes
         # to use environment variables which have been cleaned from the
@@ -289,6 +294,11 @@ class CookerDataBuilder(object):
             bb.fetch.fetcher_init(data)
         bb.codeparser.parser_cache_init(data)
         bb.event.fire(bb.event.ConfigParsed(), data)
+        # The sanity checks used to be implied on ConfigParsed, if
+        # BB_WORKERCONTEXT and DISABLE_SANITY_CHECKS were both not-1.
+        # Now we invoke them directly.
+        if (data.getVar("BB_WORKERCONTEXT", True) != 1 and data.getVar("DISABLE_SANITY_CHECKS", True) != 1):
+            bb.event.fire(bb.event.SanityCheck(failure_is_an_option = self.sanity_failure_ok, use_events = False), data)
 
         if data.getVar("BB_INVALIDCONF") is True:
             data.setVar("BB_INVALIDCONF", False)
diff --git a/lib/bb/event.py b/lib/bb/event.py
index 10eae5f..d0e6b54 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -603,6 +603,10 @@ class SanityCheck(Event):
     """
     Event to issue sanity check
     """
+    def __init__(self, failure_is_an_option=False, use_events=True):
+        Event.__init__(self)
+        self._failure_is_an_option = failure_is_an_option
+        self._use_events = use_events
 
 class SanityCheckPassed(Event):
     """
diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index c1ee9f5..e2694f6 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -480,6 +480,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                                   bb.event.MetadataEvent,
                                   bb.event.StampUpdate,
                                   bb.event.ConfigParsed,
+                                  bb.event.SanityCheck,
                                   bb.event.RecipeParsed,
                                   bb.event.RecipePreFinalise,
                                   bb.runqueue.runQueueEvent,
-- 
1.7.1


