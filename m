Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 30053601F6
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Jul 2016 04:26:16 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga103.fm.intel.com with ESMTP; 05 Jul 2016 21:26:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,317,1464678000"; d="scan'208";a="1016348110"
Received: from mabubaka-mobl1.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.170.98])
	by fmsmga002.fm.intel.com with ESMTP; 05 Jul 2016 21:26:15 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  6 Jul 2016 16:26:10 +1200
Message-Id: <1467779170-28649-1-git-send-email-paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <3b15ae1a30cb247128e003512c036b1f95909674.1466679280.git.paul.eggleton@linux.intel.com>
References: <3b15ae1a30cb247128e003512c036b1f95909674.1466679280.git.paul.eggleton@linux.intel.com>
Subject: [PATCH v3] fetch2: implement progress support
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
X-List-Received-Date: Wed, 06 Jul 2016 04:26:17 -0000

Implement progress reporting support specifically for the fetchers. For
fetch tasks we don't necessarily know which fetcher will be used (we
might initially be fetching a git:// URI, but if we instead download a
mirror tarball we may fetch that over http using wget). These programs
also have different abilities as far as reporting progress goes (e.g.
wget gives us percentage complete and rate, git gives this some of the
time depending on what stage it's at). Additionally we filter out the
progress output before it makes it to the logs, in order to prevent the
logs filling up with junk.

At the moment this is only implemented for the wget and git fetchers
since they are the most commonly used (and svn doesn't seem to support
any kind of progress output, at least not without doing a relatively
expensive remote file listing first).

Line changes such as the ones you get in git's output as it progresses
don't make it to the log files, you only get the final state of the line
so the logs aren't filled with progress information that's useless after
the fact.

Part of the implementation for [YOCTO #5383].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---

Changes since v2:
 * Use -v instead of --show-progress in the wget command line since the
   latter is only available with wget 1.16 and newer, and we still need
   to support distros that have older versions than that. This does
   override the default of -nv if present (which it will be via the
   FETCHCMD_wget set in bitbake.conf within OE), but the added verbosity
   is minimal since the progress information is filtered out of the logs
   by the progress handler.

 lib/bb/fetch2/__init__.py |  4 ++--
 lib/bb/fetch2/git.py      | 52 +++++++++++++++++++++++++++++++++++++++++++----
 lib/bb/fetch2/wget.py     | 28 +++++++++++++++++++++++--
 lib/bb/progress.py        | 31 ++++++++++++++++++++++++++++
 4 files changed, 107 insertions(+), 8 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index b6fcaaa..a27512c 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -779,7 +779,7 @@ def localpath(url, d):
     fetcher = bb.fetch2.Fetch([url], d)
     return fetcher.localpath(url)
 
-def runfetchcmd(cmd, d, quiet=False, cleanup=None):
+def runfetchcmd(cmd, d, quiet=False, cleanup=None, log=None):
     """
     Run cmd returning the command output
     Raise an error if interrupted or cmd fails
@@ -821,7 +821,7 @@ def runfetchcmd(cmd, d, quiet=False, cleanup=None):
     error_message = ""
 
     try:
-        (output, errors) = bb.process.run(cmd, shell=True, stderr=subprocess.PIPE)
+        (output, errors) = bb.process.run(cmd, log=log, shell=True, stderr=subprocess.PIPE)
         success = True
     except bb.process.NotFoundError as e:
         error_message = "Fetch command %s" % (e.command)
diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 59827e3..4e2dcec 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -71,11 +71,53 @@ import os
 import re
 import bb
 import errno
+import bb.progress
 from   bb    import data
 from   bb.fetch2 import FetchMethod
 from   bb.fetch2 import runfetchcmd
 from   bb.fetch2 import logger
 
+
+class GitProgressHandler(bb.progress.LineFilterProgressHandler):
+    """Extract progress information from git output"""
+    def __init__(self, d):
+        self._buffer = ''
+        self._count = 0
+        super(GitProgressHandler, self).__init__(d)
+        # Send an initial progress event so the bar gets shown
+        self._fire_progress(-1)
+
+    def write(self, string):
+        self._buffer += string
+        stages = ['Counting objects', 'Compressing objects', 'Receiving objects', 'Resolving deltas']
+        stage_weights = [0.2, 0.05, 0.5, 0.25]
+        stagenum = 0
+        for i, stage in reversed(list(enumerate(stages))):
+            if stage in self._buffer:
+                stagenum = i
+                self._buffer = ''
+                break
+        self._status = stages[stagenum]
+        percs = re.findall(r'(\d+)%', string)
+        if percs:
+            progress = int(round((int(percs[-1]) * stage_weights[stagenum]) + (sum(stage_weights[:stagenum]) * 100)))
+            rates = re.findall(r'([\d.]+ [a-zA-Z]*/s+)', string)
+            if rates:
+                rate = rates[-1]
+            else:
+                rate = None
+            self.update(progress, rate)
+        else:
+            if stagenum == 0:
+                percs = re.findall(r': (\d+)', string)
+                if percs:
+                    count = int(percs[-1])
+                    if count > self._count:
+                        self._count = count
+                        self._fire_progress(-count)
+        super(GitProgressHandler, self).write(string)
+
+
 class Git(FetchMethod):
     """Class to fetch a module or modules from git repositories"""
     def init(self, d):
@@ -196,10 +238,11 @@ class Git(FetchMethod):
             # We do this since git will use a "-l" option automatically for local urls where possible
             if repourl.startswith("file://"):
                 repourl = repourl[7:]
-            clone_cmd = "%s clone --bare --mirror %s %s" % (ud.basecmd, repourl, ud.clonedir)
+            clone_cmd = "LANG=C %s clone --bare --mirror %s %s --progress" % (ud.basecmd, repourl, ud.clonedir)
             if ud.proto.lower() != 'file':
                 bb.fetch2.check_network_access(d, clone_cmd)
-            runfetchcmd(clone_cmd, d)
+            progresshandler = GitProgressHandler(d)
+            runfetchcmd(clone_cmd, d, log=progresshandler)
 
         os.chdir(ud.clonedir)
         # Update the checkout if needed
@@ -214,10 +257,11 @@ class Git(FetchMethod):
                 logger.debug(1, "No Origin")
 
             runfetchcmd("%s remote add --mirror=fetch origin %s" % (ud.basecmd, repourl), d)
-            fetch_cmd = "%s fetch -f --prune %s refs/*:refs/*" % (ud.basecmd, repourl)
+            fetch_cmd = "LANG=C %s fetch -f --prune --progress %s refs/*:refs/*" % (ud.basecmd, repourl)
             if ud.proto.lower() != 'file':
                 bb.fetch2.check_network_access(d, fetch_cmd, ud.url)
-            runfetchcmd(fetch_cmd, d)
+            progresshandler = GitProgressHandler(d)
+            runfetchcmd(fetch_cmd, d, log=progresshandler)
             runfetchcmd("%s prune-packed" % ud.basecmd, d)
             runfetchcmd("%s pack-redundant --all | xargs -r rm" % ud.basecmd, d)
             try:
diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index d688fd9..275cd7d 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -31,6 +31,7 @@ import subprocess
 import os
 import logging
 import bb
+import bb.progress
 import urllib.request, urllib.parse, urllib.error
 from   bb import data
 from   bb.fetch2 import FetchMethod
@@ -41,6 +42,27 @@ from   bb.utils import export_proxies
 from   bs4 import BeautifulSoup
 from   bs4 import SoupStrainer
 
+class WgetProgressHandler(bb.progress.LineFilterProgressHandler):
+    """
+    Extract progress information from wget output.
+    Note: relies on --progress=dot (with -v or without -q/-nv) being
+    specified on the wget command line.
+    """
+    def __init__(self, d):
+        super(WgetProgressHandler, self).__init__(d)
+        # Send an initial progress event so the bar gets shown
+        self._fire_progress(0)
+
+    def writeline(self, line):
+        percs = re.findall(r'(\d+)%\s+([\d.]+[A-Z])', line)
+        if percs:
+            progress = int(percs[-1][0])
+            rate = percs[-1][1] + '/s'
+            self.update(progress, rate)
+            return False
+        return True
+
+
 class Wget(FetchMethod):
     """Class to fetch urls via 'wget'"""
     def supports(self, ud, d):
@@ -66,13 +88,15 @@ class Wget(FetchMethod):
         if not ud.localfile:
             ud.localfile = data.expand(urllib.parse.unquote(ud.host + ud.path).replace("/", "."), d)
 
-        self.basecmd = d.getVar("FETCHCMD_wget", True) or "/usr/bin/env wget -t 2 -T 30 -nv --passive-ftp --no-check-certificate"
+        self.basecmd = d.getVar("FETCHCMD_wget", True) or "/usr/bin/env wget -t 2 -T 30 --passive-ftp --no-check-certificate"
 
     def _runwget(self, ud, d, command, quiet):
 
+        progresshandler = WgetProgressHandler(d)
+
         logger.debug(2, "Fetching %s using command '%s'" % (ud.url, command))
         bb.fetch2.check_network_access(d, command)
-        runfetchcmd(command, d, quiet)
+        runfetchcmd(command + ' --progress=dot -v', d, quiet, log=progresshandler)
 
     def download(self, ud, d):
         """Fetch urls"""
diff --git a/lib/bb/progress.py b/lib/bb/progress.py
index 93e42df..1365068 100644
--- a/lib/bb/progress.py
+++ b/lib/bb/progress.py
@@ -58,6 +58,37 @@ class ProgressHandler(object):
             self._lastevent = ts
             self._progress = progress
 
+class LineFilterProgressHandler(ProgressHandler):
+    """
+    A ProgressHandler variant that provides the ability to filter out
+    the lines if they contain progress information. Additionally, it
+    filters out anything before the last line feed on a line. This can
+    be used to keep the logs clean of output that we've only enabled for
+    getting progress, assuming that that can be done on a per-line
+    basis.
+    """
+    def __init__(self, d, outfile=None):
+        self._linebuffer = ''
+        super(LineFilterProgressHandler, self).__init__(d, outfile)
+
+    def write(self, string):
+        self._linebuffer += string
+        while True:
+            breakpos = self._linebuffer.find('\n') + 1
+            if breakpos == 0:
+                break
+            line = self._linebuffer[:breakpos]
+            self._linebuffer = self._linebuffer[breakpos:]
+            # Drop any line feeds and anything that precedes them
+            lbreakpos = line.rfind('\r') + 1
+            if lbreakpos:
+                line = line[lbreakpos:]
+            if self.writeline(line):
+                super(LineFilterProgressHandler, self).write(line)
+
+    def writeline(self, line):
+        return True
+
 class BasicProgressHandler(ProgressHandler):
     def __init__(self, d, regex=r'(\d+)%', outfile=None):
         super(BasicProgressHandler, self).__init__(d, outfile)
-- 
2.5.5


