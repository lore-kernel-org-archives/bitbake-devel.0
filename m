Return-Path: <rpjday@crashcourse.ca>
Received: from smtp684.redcondor.net (smtp684.redcondor.net [208.80.206.84])
	by mail.openembedded.org (Postfix) with ESMTP id 4960C601A8
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Aug 2014 12:23:36 +0000 (UTC)
Received: from astoria.ccjclearline.com ([64.235.106.9])
	by smtp684.redcondor.net ({700db0a8-6fb7-4c8b-9b2a-6812225182d8})
	via TCP (outbound) with ESMTPS id 20140820122335937
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Aug 2014 12:23:35 +0000
X-RC-FROM: <rpjday@crashcourse.ca>
X-RC-RCPT: <bitbake-devel@lists.openembedded.org>
Received: from [99.240.204.5] (port=33142 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.80) (envelope-from <rpjday@crashcourse.ca>)
	id 1XK4vM-0000so-4a for bitbake-devel@lists.openembedded.org;
	Wed, 20 Aug 2014 08:23:32 -0400
Date: Wed, 20 Aug 2014 08:23:27 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Message-ID: <alpine.LFD.2.11.1408200819540.14073@localhost>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
X-AntiAbuse: This header was added to track abuse,
	please include it with any abuse report
X-AntiAbuse: Primary Hostname - astoria.ccjclearline.com
X-AntiAbuse: Original Domain - lists.openembedded.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-MAG-OUTBOUND: ccj.redcondor.net@64.235.106.9/32
Subject: [PATCH] lib/bb/*.py: Typo fixes/grammar/comment fixes, nothing functional.
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
X-List-Received-Date: Wed, 20 Aug 2014 12:23:40 -0000
Content-Type: TEXT/PLAIN; charset=US-ASCII


Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

  normally, i won't mess with *really* minor stuff unless a file has
something that merits changing, then since i'm there, i might as well
tidy up even the small stuff.

diff --git a/lib/bb/__init__.py b/lib/bb/__init__.py
index 84f6ec3..001941a 100644
--- a/lib/bb/__init__.py
+++ b/lib/bb/__init__.py
@@ -103,7 +103,7 @@ def fatal(*args):

 def deprecated(func, name=None, advice=""):
     """This is a decorator which can be used to mark functions
-    as deprecated. It will result in a warning being emmitted
+    as deprecated. It will result in a warning being emitted
     when the function is used."""
     import warnings

diff --git a/lib/bb/build.py b/lib/bb/build.py
index dcd42ef..f2922f3 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -23,7 +23,7 @@
 # with this program; if not, write to the Free Software Foundation, Inc.,
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 #
-#Based on functions from the base bb module, Copyright 2003 Holger Schurig
+# Based on functions from the base bb module, Copyright 2003 Holger Schurig

 import os
 import sys
@@ -42,9 +42,8 @@ logger = logging.getLogger('BitBake.Build')

 NULL = open(os.devnull, 'r+')

-
-# When we execute a python function we'd like certain things
-# in all namespaces, hence we add them to __builtins__
+# When we execute a Python function, we'd like certain things
+# in all namespaces, hence we add them to __builtins__.
 # If we do not do this and use the exec globals, they will
 # not be available to subfunctions.
 __builtins__['bb'] = bb
@@ -143,7 +142,7 @@ class LogTee(object):
         self.outfile.flush()

 def exec_func(func, d, dirs = None):
-    """Execute an BB 'function'"""
+    """Execute a BB 'function'"""

     body = d.getVar(func)
     if not body:
@@ -417,7 +416,7 @@ def _exec_task(fn, task, d, quieterr):
     os.dup2(logfile.fileno(), oso[1])
     os.dup2(logfile.fileno(), ose[1])

-    # Ensure python logging goes to the logfile
+    # Ensure Python logging goes to the logfile
     handler = logging.StreamHandler(logfile)
     handler.setFormatter(logformatter)
     # Always enable full debug output into task logfiles
diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index f892d7d..ac0c27f 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -225,7 +225,7 @@ class CoreRecipeInfo(RecipeInfoCommon):
         for package in self.packages_dynamic:
             cachedata.packages_dynamic[package].append(fn)

-        # Build hash of runtime depends and rececommends
+        # Build hash of runtime depends and recommends
         for package in self.packages + [self.pn]:
             cachedata.rundeps[fn][package] = list(self.rdepends) + self.rdepends_pkg[package]
             cachedata.runrecs[fn][package] = list(self.rrecommends) + self.rrecommends_pkg[package]
@@ -261,7 +261,7 @@ class Cache(object):

     def __init__(self, data, data_hash, caches_array):
         # Pass caches_array information into Cache Constructor
-        # It will be used in later for deciding whether we
+        # It will be used later for deciding whether we
         # need extra cache file dump/load support
         self.caches_array = caches_array
         self.cachedir = data.getVar("CACHE", True)
diff --git a/lib/bb/daemonize.py b/lib/bb/daemonize.py
index 898820b..346a618 100644
--- a/lib/bb/daemonize.py
+++ b/lib/bb/daemonize.py
@@ -12,8 +12,11 @@ A failed call to fork() now raises an exception.

 References:
     1) Advanced Programming in the Unix Environment: W. Richard Stevens
-    2) Unix Programming Frequently Asked Questions:
-            http://www.erlenstar.demon.co.uk/unix/faq_toc.html
+	http://www.apuebook.com/apue3e.html
+    2) The Linux Programming Interface: Michael Kerrisk
+	http://man7.org/tlpi/index.html
+    3) Unix Programming Frequently Asked Questions:
+	http://www.faqs.org/faqs/unix-faq/programmer/faq/

 Modified to allow a function to be daemonized and return for
 bitbake use by Richard Purdie
@@ -146,7 +149,7 @@ def createDaemon(function, logfile):
     # OR
     #
     # Use the getrlimit method to retrieve the maximum file descriptor number
-    # that can be opened by this process.  If there is not limit on the
+    # that can be opened by this process.  If there is no limit on the
     # resource, use the default value.
     #
     import resource             # Resource usage information.
diff --git a/lib/bb/data.py b/lib/bb/data.py
index db938be..3d776b3 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -6,7 +6,7 @@ BitBake 'Data' implementations
 Functions for interacting with the data structure used by the
 BitBake build tools.

-The expandData and update_data are the most expensive
+The expandKeys and update_data are the most expensive
 operations. At night the cookie monster came by and
 suggested 'give me cookies on setting the variables and
 things will work out'. Taking this suggestion into account
@@ -15,7 +15,7 @@ Analyse von Algorithmen' lecture and the cookie
 monster seems to be right. We will track setVar more carefully
 to have faster update_data and expandKeys operations.

-This is a treade-off between speed and memory again but
+This is a trade-off between speed and memory again but
 the speed is more critical here.
 """

@@ -35,7 +35,7 @@ the speed is more critical here.
 # with this program; if not, write to the Free Software Foundation, Inc.,
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 #
-#Based on functions from the base bb module, Copyright 2003 Holger Schurig
+# Based on functions from the base bb module, Copyright 2003 Holger Schurig

 import sys, os, re
 if sys.argv[0][-5:] == "pydoc":
diff --git a/lib/bb/event.py b/lib/bb/event.py
index e2f6b9c..32df779 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -598,7 +598,7 @@ class MetadataEvent(Event):

 class SanityCheck(Event):
     """
-    Event to runs sanity checks, either raise errors or generate events as return status.
+    Event to run sanity checks, either raise errors or generate events as return status.
     """
     def __init__(self, generateevents = True):
         Event.__init__(self)
@@ -606,7 +606,7 @@ class SanityCheck(Event):

 class SanityCheckPassed(Event):
     """
-    Event to indicate sanity check is passed
+    Event to indicate sanity check has passed
     """

 class SanityCheckFailed(Event):
diff --git a/lib/bb/monitordisk.py b/lib/bb/monitordisk.py
index fca43ee..6b03682 100644
--- a/lib/bb/monitordisk.py
+++ b/lib/bb/monitordisk.py
@@ -52,10 +52,10 @@ def getMountedDev(path):
     parentDev = os.stat(path).st_dev
     currentDev = parentDev
     # When the current directory's device is different from the
-    # parrent's, then the current directory is a mount point
+    # parent's, then the current directory is a mount point
     while parentDev == currentDev:
         mountPoint = path
-        # Use dirname to get the parrent's directory
+        # Use dirname to get the parent's directory
         path = os.path.dirname(path)
         # Reach the "/"
         if path == mountPoint:
@@ -77,7 +77,7 @@ def getDiskData(BBDirs, configuration):
     """Prepare disk data for disk space monitor"""

     # Save the device IDs, need the ID to be unique (the dictionary's key is
-    # unique), so that when more than one directories are located in the same
+    # unique), so that when more than one directory is located on the same
     # device, we just monitor it once
     devDict = {}
     for pathSpaceInode in BBDirs.split():
@@ -187,11 +187,11 @@ class diskMonitor:
                 if self.spaceInterval and self.inodeInterval:
                     self.enableMonitor = True
                     # These are for saving the previous disk free space and inode, we
-                    # use them to avoid print too many warning messages
+                    # use them to avoid printing too many warning messages
                     self.preFreeS = {}
                     self.preFreeI = {}
-                    # This is for STOPTASKS and ABORT, to avoid print the message repeatly
-                    # during waiting the tasks to finish
+                    # This is for STOPTASKS and ABORT, to avoid printing the message
+                    # repeatedly while waiting for the tasks to finish
                     self.checked = {}
                     for k in self.devDict:
                         self.preFreeS[k] = 0
diff --git a/lib/bb/namedtuple_with_abc.py b/lib/bb/namedtuple_with_abc.py
index f5e0a3f..32f2fc6 100644
--- a/lib/bb/namedtuple_with_abc.py
+++ b/lib/bb/namedtuple_with_abc.py
@@ -202,8 +202,8 @@ if __name__ == '__main__':
     print(rec5._replace(k=222)._my_custom_method())  # MyMixIn's
     print(rec5._replace(k=222).count(2))  # MyMixIn's

-    # None that behavior: the standard namedtuple methods cannot be
-    # overriden by a foreign mix-in -- even if the mix-in is declared
+    # Note that behavior: the standard namedtuple methods cannot be
+    # overridden by a foreign mix-in -- even if the mix-in is declared
     # as the leftmost base class (but, obviously, you can override them
     # in the defined class or its subclasses):

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index f62709b..8f059d9 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -264,7 +264,7 @@ def _print_trace(body, line):
 def better_compile(text, file, realfile, mode = "exec"):
     """
     A better compile method. This method
-    will print  the offending lines.
+    will print the offending lines.
     """
     try:
         return compile(text, file, mode)
@@ -530,7 +530,7 @@ def filter_environment(good_vars):
 def approved_variables():
     """
     Determine and return the list of whitelisted variables which are approved
-    to remain in the envrionment.
+    to remain in the environment.
     """
     if 'BB_PRESERVE_ENV' in os.environ:
         return os.environ.keys()

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================


