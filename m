Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1SUXPP-0004Mk-I0
	for bitbake-devel@lists.openembedded.org;
	Wed, 16 May 2012 08:08:27 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q4G5wQkp004981
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 15 May 2012 22:58:26 -0700 (PDT)
Received: from usp-ub10.corp.ad.wrs.com (128.224.163.69) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.1.255.0; Tue, 15 May 2012 22:58:25 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 16 May 2012 13:55:29 +0800
Message-ID: <e22ec7981521df200e2db535630b666ce6d2731f.1337147194.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <cover.1337147194.git.liezhi.yang@windriver.com>
References: <cover.1337147194.git.liezhi.yang@windriver.com>
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
X-List-Received-Date: Wed, 16 May 2012 06:08:28 -0000
Content-Type: text/plain

Replace os.popen with subprocess.Popen since the older function would
fail (more or less) silently if the executed program cannot be found

There is a bb.process.run() which will invoke the Popen to run command,
use it for simplify the code.

More info:
http://docs.python.org/library/subprocess.html#subprocess-replacements

[YOCTO #2075]

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/fetch2/perforce.py            |    6 +++---
 bitbake/lib/bb/fetch2/svk.py                 |    2 +-
 bitbake/lib/bb/ui/crumbs/builddetailspage.py |    3 ++-
 bitbake/lib/bb/ui/crumbs/hig.py              |    7 ++++---
 4 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/perforce.py b/bitbake/lib/bb/fetch2/perforce.py
index 6abf15d..e07afdd 100644
--- a/bitbake/lib/bb/fetch2/perforce.py
+++ b/bitbake/lib/bb/fetch2/perforce.py
@@ -91,7 +91,7 @@ class Perforce(FetchMethod):
 
         p4cmd = data.getVar('FETCHCOMMAND_p4', d, True)
         logger.debug(1, "Running %s%s changes -m 1 %s", p4cmd, p4opt, depot)
-        p4file = os.popen("%s%s changes -m 1 %s" % (p4cmd, p4opt, depot))
+        (p4file, errors) = bb.process.run("%s%s changes -m 1 %s" % (p4cmd, p4opt, depot))
         cset = p4file.readline().strip()
         logger.debug(1, "READ %s", cset)
         if not cset:
@@ -155,7 +155,7 @@ class Perforce(FetchMethod):
         logger.debug(2, "Fetch: creating temporary directory")
         bb.utils.mkdirhier(data.expand('${WORKDIR}', localdata))
         data.setVar('TMPBASE', data.expand('${WORKDIR}/oep4.XXXXXX', localdata), localdata)
-        tmppipe = os.popen(data.getVar('MKTEMPDIRCMD', localdata, True) or "false")
+        (tmppipe, errors) = bb.process.run(data.getVar('MKTEMPDIRCMD', localdata, True) or "false")
         tmpfile = tmppipe.readline().strip()
         if not tmpfile:
             raise FetchError("Fetch: unable to create temporary directory.. make sure 'mktemp' is in the PATH.", loc)
@@ -169,7 +169,7 @@ class Perforce(FetchMethod):
         os.chdir(tmpfile)
         logger.info("Fetch " + loc)
         logger.info("%s%s files %s", p4cmd, p4opt, depot)
-        p4file = os.popen("%s%s files %s" % (p4cmd, p4opt, depot))
+        (p4file, errors) = bb.process.run("%s%s files %s" % (p4cmd, p4opt, depot))
 
         if not p4file:
             raise FetchError("Fetch: unable to get the P4 files from %s" % depot, loc)
diff --git a/bitbake/lib/bb/fetch2/svk.py b/bitbake/lib/bb/fetch2/svk.py
index 9d34abf..157e487 100644
--- a/bitbake/lib/bb/fetch2/svk.py
+++ b/bitbake/lib/bb/fetch2/svk.py
@@ -77,7 +77,7 @@ class Svk(FetchMethod):
         logger.debug(2, "Fetch: creating temporary directory")
         bb.utils.mkdirhier(data.expand('${WORKDIR}', localdata))
         data.setVar('TMPBASE', data.expand('${WORKDIR}/oesvk.XXXXXX', localdata), localdata)
-        tmppipe = os.popen(data.getVar('MKTEMPDIRCMD', localdata, True) or "false")
+        (tmppipe, errors) = bb.process.run(data.getVar('MKTEMPDIRCMD', localdata, True) or "false")
         tmpfile = tmppipe.readline().strip()
         if not tmpfile:
             logger.error()
diff --git a/bitbake/lib/bb/ui/crumbs/builddetailspage.py b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
index 51e6a4a..3f54437 100755
--- a/bitbake/lib/bb/ui/crumbs/builddetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
@@ -23,6 +23,7 @@
 import gtk
 import pango
 import gobject
+import bb.process
 from bb.ui.crumbs.progressbar import HobProgressBar
 from bb.ui.crumbs.hobwidget import hic, HobNotebook, HobAltButton, HobWarpCellRendererText
 from bb.ui.crumbs.runningbuild import RunningBuildTreeView
@@ -96,7 +97,7 @@ class BuildConfigurationTreeView(gtk.TreeView):
         for path in src_config_info.layers:
             import os, os.path
             if os.path.exists(path):
-                f = os.popen('cd %s; git branch 2>&1 | grep "^* " | tr -d "* "' % path)
+                (f, errors) = bb.process.run('cd %s; git branch 2>&1 | grep "^* " | tr -d "* "' % path)
                 if f:
                     branch = f.readline().lstrip('\n').rstrip('\n')
                     vars.append(self.set_vars("Branch:", branch))
diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/hig.py
index 4baf960..7d109e5 100644
--- a/bitbake/lib/bb/ui/crumbs/hig.py
+++ b/bitbake/lib/bb/ui/crumbs/hig.py
@@ -25,12 +25,12 @@ import gobject
 import hashlib
 import os
 import re
-import subprocess
 import shlex
 from bb.ui.crumbs.hobcolor import HobColors
 from bb.ui.crumbs.hobwidget import hcc, hic, HobViewTable, HobInfoButton, HobButton, HobAltButton, HobIconChecker
 from bb.ui.crumbs.progressbar import HobProgressBar
 import bb.ui.crumbs.utils
+import bb.process
 
 """
 The following are convenience classes for implementing GNOME HIG compliant
@@ -726,7 +726,8 @@ class DeployImageDialog (CrumbsDialog):
         self.progress_bar.hide()
 
     def popen_read(self, cmd):
-        return os.popen("%s 2>/dev/null" % cmd).read().strip()
+        (tmpout, errors) = bb.process.run("%s" % cmd)
+        return tmpout.read().strip()
 
     def find_all_usb_devices(self):
         usb_devs = [ os.readlink(u)
@@ -755,7 +756,7 @@ class DeployImageDialog (CrumbsDialog):
                 cmdline = bb.ui.crumbs.utils.which_terminal()
                 if cmdline:
                     cmdline += "\"sudo dd if=" + self.image_path + " of=" + combo_item + "\""
-                    subprocess.Popen(args=shlex.split(cmdline))
+                    bb.process.run(args=shlex.split(cmdline))
 
     def update_progress_bar(self, title, fraction, status=None):
         self.progress_bar.update(fraction)
-- 
1.7.1



