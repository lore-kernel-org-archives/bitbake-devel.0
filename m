Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1SUEdz-0005iJ-3A
	for bitbake-devel@lists.openembedded.org;
	Tue, 15 May 2012 12:06:15 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q4F9uEEq021657
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 15 May 2012 02:56:15 -0700 (PDT)
Received: from usp-ub10.corp.ad.wrs.com (128.224.163.69) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.1.255.0; Tue, 15 May 2012 02:56:14 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 15 May 2012 17:53:25 +0800
Message-ID: <6ca7f7e56bdab86c3920182256220077a94fe78d.1337073916.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <cover.1337073916.git.liezhi.yang@windriver.com>
References: <cover.1337073916.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Cc: Zhenfeng.Zhao@windriver.com
Subject: [PATCH 2/2] replace os.popen with subprocess.Popen
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 15 May 2012 10:06:15 -0000
Content-Type: text/plain

Replace os.popen with subprocess.Popen since the older function would
fail (more or less) silently if the executed program cannot be found

There is a wrappers around Popen for convenience in the bb.process python
module, so use the Popen from bb.process to simplify the code.

More info:
http://docs.python.org/library/subprocess.html#subprocess-replacements

[YOCTO #2075]

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/fetch2/perforce.py            |    7 ++++---
 bitbake/lib/bb/fetch2/svk.py                 |    3 ++-
 bitbake/lib/bb/ui/crumbs/builddetailspage.py |    3 ++-
 bitbake/lib/bb/ui/crumbs/hig.py              |    6 +++---
 4 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/perforce.py b/bitbake/lib/bb/fetch2/perforce.py
index 6abf15d..1c4ef25 100644
--- a/bitbake/lib/bb/fetch2/perforce.py
+++ b/bitbake/lib/bb/fetch2/perforce.py
@@ -35,6 +35,7 @@ from   bb.fetch2 import FetchMethod
 from   bb.fetch2 import FetchError
 from   bb.fetch2 import logger
 from   bb.fetch2 import runfetchcmd
+from   bb.process import Popen
 
 class Perforce(FetchMethod):
     def supports(self, url, ud, d):
@@ -91,7 +92,7 @@ class Perforce(FetchMethod):
 
         p4cmd = data.getVar('FETCHCOMMAND_p4', d, True)
         logger.debug(1, "Running %s%s changes -m 1 %s", p4cmd, p4opt, depot)
-        p4file = os.popen("%s%s changes -m 1 %s" % (p4cmd, p4opt, depot))
+        p4file = Popen("%s%s changes -m 1 %s" % (p4cmd, p4opt, depot)).stdout
         cset = p4file.readline().strip()
         logger.debug(1, "READ %s", cset)
         if not cset:
@@ -155,7 +156,7 @@ class Perforce(FetchMethod):
         logger.debug(2, "Fetch: creating temporary directory")
         bb.utils.mkdirhier(data.expand('${WORKDIR}', localdata))
         data.setVar('TMPBASE', data.expand('${WORKDIR}/oep4.XXXXXX', localdata), localdata)
-        tmppipe = os.popen(data.getVar('MKTEMPDIRCMD', localdata, True) or "false")
+        tmppipe = Popen(data.getVar('MKTEMPDIRCMD', localdata, True) or "false").stdout
         tmpfile = tmppipe.readline().strip()
         if not tmpfile:
             raise FetchError("Fetch: unable to create temporary directory.. make sure 'mktemp' is in the PATH.", loc)
@@ -169,7 +170,7 @@ class Perforce(FetchMethod):
         os.chdir(tmpfile)
         logger.info("Fetch " + loc)
         logger.info("%s%s files %s", p4cmd, p4opt, depot)
-        p4file = os.popen("%s%s files %s" % (p4cmd, p4opt, depot))
+        p4file = Popen("%s%s files %s" % (p4cmd, p4opt, depot)).stdout
 
         if not p4file:
             raise FetchError("Fetch: unable to get the P4 files from %s" % depot, loc)
diff --git a/bitbake/lib/bb/fetch2/svk.py b/bitbake/lib/bb/fetch2/svk.py
index 9d34abf..43d30a3 100644
--- a/bitbake/lib/bb/fetch2/svk.py
+++ b/bitbake/lib/bb/fetch2/svk.py
@@ -34,6 +34,7 @@ from   bb.fetch2 import FetchError
 from   bb.fetch2 import MissingParameterError
 from   bb.fetch2 import logger
 from   bb.fetch2 import runfetchcmd
+from   bb.process import Popen
 
 class Svk(FetchMethod):
     """Class to fetch a module or modules from svk repositories"""
@@ -77,7 +78,7 @@ class Svk(FetchMethod):
         logger.debug(2, "Fetch: creating temporary directory")
         bb.utils.mkdirhier(data.expand('${WORKDIR}', localdata))
         data.setVar('TMPBASE', data.expand('${WORKDIR}/oesvk.XXXXXX', localdata), localdata)
-        tmppipe = os.popen(data.getVar('MKTEMPDIRCMD', localdata, True) or "false")
+        tmppipe = Popen(data.getVar('MKTEMPDIRCMD', localdata, True) or "false").stdout
         tmpfile = tmppipe.readline().strip()
         if not tmpfile:
             logger.error()
diff --git a/bitbake/lib/bb/ui/crumbs/builddetailspage.py b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
index 51e6a4a..8387161 100755
--- a/bitbake/lib/bb/ui/crumbs/builddetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
@@ -28,6 +28,7 @@ from bb.ui.crumbs.hobwidget import hic, HobNotebook, HobAltButton, HobWarpCellRe
 from bb.ui.crumbs.runningbuild import RunningBuildTreeView
 from bb.ui.crumbs.runningbuild import BuildFailureTreeView
 from bb.ui.crumbs.hobpages import HobPage
+from bb.process import Popen
 
 class BuildConfigurationTreeView(gtk.TreeView):
     def __init__ (self):
@@ -96,7 +97,7 @@ class BuildConfigurationTreeView(gtk.TreeView):
         for path in src_config_info.layers:
             import os, os.path
             if os.path.exists(path):
-                f = os.popen('cd %s; git branch 2>&1 | grep "^* " | tr -d "* "' % path)
+                f = Popen('cd %s; git branch 2>&1 | grep "^* " | tr -d "* "' % path).stdout
                 if f:
                     branch = f.readline().lstrip('\n').rstrip('\n')
                     vars.append(self.set_vars("Branch:", branch))
diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/hig.py
index 4baf960..d4fcb55 100644
--- a/bitbake/lib/bb/ui/crumbs/hig.py
+++ b/bitbake/lib/bb/ui/crumbs/hig.py
@@ -25,11 +25,11 @@ import gobject
 import hashlib
 import os
 import re
-import subprocess
 import shlex
 from bb.ui.crumbs.hobcolor import HobColors
 from bb.ui.crumbs.hobwidget import hcc, hic, HobViewTable, HobInfoButton, HobButton, HobAltButton, HobIconChecker
 from bb.ui.crumbs.progressbar import HobProgressBar
+from bb.process import Popen
 import bb.ui.crumbs.utils
 
 """
@@ -726,7 +726,7 @@ class DeployImageDialog (CrumbsDialog):
         self.progress_bar.hide()
 
     def popen_read(self, cmd):
-        return os.popen("%s 2>/dev/null" % cmd).read().strip()
+        return Popen("%s" % cmd).stdout.read().strip()
 
     def find_all_usb_devices(self):
         usb_devs = [ os.readlink(u)
@@ -755,7 +755,7 @@ class DeployImageDialog (CrumbsDialog):
                 cmdline = bb.ui.crumbs.utils.which_terminal()
                 if cmdline:
                     cmdline += "\"sudo dd if=" + self.image_path + " of=" + combo_item + "\""
-                    subprocess.Popen(args=shlex.split(cmdline))
+                    Popen(args=shlex.split(cmdline))
 
     def update_progress_bar(self, title, fraction, status=None):
         self.progress_bar.update(fraction)
-- 
1.7.1



