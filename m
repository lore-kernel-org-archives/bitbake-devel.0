Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1SW5WY-0005D7-1U
	for bitbake-devel@lists.openembedded.org;
	Sun, 20 May 2012 14:46:14 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q4KCa7tH016616
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 20 May 2012 05:36:07 -0700 (PDT)
Received: from usp-ub10.corp.ad.wrs.com (128.224.163.69) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.1.255.0; Sun, 20 May 2012 05:36:06 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Sun, 20 May 2012 20:36:06 +0800
Message-ID: <401cf2b62edc824883b8c7084f4f742e0b2d098c.1337515887.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <cover.1337515887.git.liezhi.yang@windriver.com>
References: <cover.1337515887.git.liezhi.yang@windriver.com>
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
X-List-Received-Date: Sun, 20 May 2012 12:46:14 -0000
Content-Type: text/plain

Replace os.popen with subprocess.Popen since the older function would
fail (more or less) silently if the executed program cannot be found

There is a bb.process.run() which will invoke the Popen to run command,
use it for simplify the code.

For the:
p4file = os.popen("%s%s files %s" % (p4cmd, p4opt, depot))
...
for file in p4file:
    list = file.split()

in bitbake/lib/bb/fetch2/perforce.py, it should be an error in the past,
since it didn't use readline() to read the pipe, but directly used the
split() for the pipe. Use the bb.process.run would fix the problem since
bb.process.run will return strings.

More info:
http://docs.python.org/library/subprocess.html#subprocess-replacements

[YOCTO #2075]

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/fetch2/perforce.py            |   11 ++++++-----
 bitbake/lib/bb/fetch2/svk.py                 |    4 ++--
 bitbake/lib/bb/ui/crumbs/builddetailspage.py |    5 +++--
 bitbake/lib/bb/ui/crumbs/hig.py              |    7 ++++---
 4 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/perforce.py b/bitbake/lib/bb/fetch2/perforce.py
index 6abf15d..df3a3a3 100644
--- a/bitbake/lib/bb/fetch2/perforce.py
+++ b/bitbake/lib/bb/fetch2/perforce.py
@@ -91,8 +91,8 @@ class Perforce(FetchMethod):
 
         p4cmd = data.getVar('FETCHCOMMAND_p4', d, True)
         logger.debug(1, "Running %s%s changes -m 1 %s", p4cmd, p4opt, depot)
-        p4file = os.popen("%s%s changes -m 1 %s" % (p4cmd, p4opt, depot))
-        cset = p4file.readline().strip()
+        p4file, errors = bb.process.run("%s%s changes -m 1 %s" % (p4cmd, p4opt, depot))
+        cset = p4file.strip()
         logger.debug(1, "READ %s", cset)
         if not cset:
             return -1
@@ -155,8 +155,8 @@ class Perforce(FetchMethod):
         logger.debug(2, "Fetch: creating temporary directory")
         bb.utils.mkdirhier(data.expand('${WORKDIR}', localdata))
         data.setVar('TMPBASE', data.expand('${WORKDIR}/oep4.XXXXXX', localdata), localdata)
-        tmppipe = os.popen(data.getVar('MKTEMPDIRCMD', localdata, True) or "false")
-        tmpfile = tmppipe.readline().strip()
+        tmpfile, errors = bb.process.run(data.getVar('MKTEMPDIRCMD', localdata, True) or "false")
+        tmpfile = tmpfile.strip()
         if not tmpfile:
             raise FetchError("Fetch: unable to create temporary directory.. make sure 'mktemp' is in the PATH.", loc)
 
@@ -169,7 +169,8 @@ class Perforce(FetchMethod):
         os.chdir(tmpfile)
         logger.info("Fetch " + loc)
         logger.info("%s%s files %s", p4cmd, p4opt, depot)
-        p4file = os.popen("%s%s files %s" % (p4cmd, p4opt, depot))
+        p4file, errors = bb.process.run("%s%s files %s" % (p4cmd, p4opt, depot))
+        p4file = p4file.strip()
 
         if not p4file:
             raise FetchError("Fetch: unable to get the P4 files from %s" % depot, loc)
diff --git a/bitbake/lib/bb/fetch2/svk.py b/bitbake/lib/bb/fetch2/svk.py
index 9d34abf..ee3823f 100644
--- a/bitbake/lib/bb/fetch2/svk.py
+++ b/bitbake/lib/bb/fetch2/svk.py
@@ -77,8 +77,8 @@ class Svk(FetchMethod):
         logger.debug(2, "Fetch: creating temporary directory")
         bb.utils.mkdirhier(data.expand('${WORKDIR}', localdata))
         data.setVar('TMPBASE', data.expand('${WORKDIR}/oesvk.XXXXXX', localdata), localdata)
-        tmppipe = os.popen(data.getVar('MKTEMPDIRCMD', localdata, True) or "false")
-        tmpfile = tmppipe.readline().strip()
+        tmpfile, errors = bb.process.run(data.getVar('MKTEMPDIRCMD', localdata, True) or "false")
+        tmpfile = tmpfile.strip()
         if not tmpfile:
             logger.error()
             raise FetchError("Fetch: unable to create temporary directory.. make sure 'mktemp' is in the PATH.", loc)
diff --git a/bitbake/lib/bb/ui/crumbs/builddetailspage.py b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
index c2d5abc..3ec15d4 100755
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
@@ -96,9 +97,9 @@ class BuildConfigurationTreeView(gtk.TreeView):
         for path in src_config_info.layers:
             import os, os.path
             if os.path.exists(path):
-                f = os.popen('cd %s; git branch 2>&1 | grep "^* " | tr -d "* "' % path)
+                f, errors = bb.process.run('cd %s; git branch 2>&1 | grep "^* " | tr -d "* "' % path)
                 if f:
-                    branch = f.readline().lstrip('\n').rstrip('\n')
+                    branch = f.strip('\n')
                     vars.append(self.set_vars("Branch:", branch))
                     f.close()
                 break
diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/hig.py
index 721d145..b3936f8 100644
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
+        tmpout, errors = bb.process.run("%s" % cmd)
+        return tmpout.strip()
 
     def find_all_usb_devices(self):
         usb_devs = [ os.readlink(u)
@@ -755,7 +756,7 @@ class DeployImageDialog (CrumbsDialog):
                 cmdline = bb.ui.crumbs.utils.which_terminal()
                 if cmdline:
                     cmdline += "\"sudo dd if=" + self.image_path + " of=" + combo_item + "\""
-                    subprocess.Popen(args=shlex.split(cmdline))
+                    bb.process.run(shlex.split(cmdline))
 
     def update_progress_bar(self, title, fraction, status=None):
         self.progress_bar.update(fraction)
-- 
1.7.1



