Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1STqVq-0005gh-OS
	for bitbake-devel@lists.openembedded.org;
	Mon, 14 May 2012 10:20:15 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q4E8AFEJ029777
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 14 May 2012 01:10:16 -0700 (PDT)
Received: from usp-ub10.corp.ad.wrs.com (128.224.163.69) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.1.255.0; Mon, 14 May 2012 01:10:15 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 14 May 2012 16:07:35 +0800
Message-ID: <a072dd7795f44603322db6583ac748f0418684fd.1336974361.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <cover.1336974361.git.liezhi.yang@windriver.com>
References: <cover.1336974361.git.liezhi.yang@windriver.com>
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
X-List-Received-Date: Mon, 14 May 2012 08:20:15 -0000
Content-Type: text/plain

Replace os.popen with subprocess.Popen since the older function would
fail (more or less) silently if the executed program cannot be found

More info:
http://docs.python.org/library/subprocess.html#subprocess-replacements

[YOCTO #2075]

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/fetch2/perforce.py            |    6 +++---
 bitbake/lib/bb/fetch2/svk.py                 |    3 ++-
 bitbake/lib/bb/ui/crumbs/builddetailspage.py |    3 ++-
 bitbake/lib/bb/ui/crumbs/hig.py              |    2 +-
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/perforce.py b/bitbake/lib/bb/fetch2/perforce.py
index 6abf15d..ad7df5f 100644
--- a/bitbake/lib/bb/fetch2/perforce.py
+++ b/bitbake/lib/bb/fetch2/perforce.py
@@ -91,7 +91,7 @@ class Perforce(FetchMethod):
 
         p4cmd = data.getVar('FETCHCOMMAND_p4', d, True)
         logger.debug(1, "Running %s%s changes -m 1 %s", p4cmd, p4opt, depot)
-        p4file = os.popen("%s%s changes -m 1 %s" % (p4cmd, p4opt, depot))
+        p4file = subprocess.Popen("%s%s changes -m 1 %s" % (p4cmd, p4opt, depot), shell=True, stdout=subprocess.PIPE).stdout
         cset = p4file.readline().strip()
         logger.debug(1, "READ %s", cset)
         if not cset:
@@ -155,7 +155,7 @@ class Perforce(FetchMethod):
         logger.debug(2, "Fetch: creating temporary directory")
         bb.utils.mkdirhier(data.expand('${WORKDIR}', localdata))
         data.setVar('TMPBASE', data.expand('${WORKDIR}/oep4.XXXXXX', localdata), localdata)
-        tmppipe = os.popen(data.getVar('MKTEMPDIRCMD', localdata, True) or "false")
+        tmppipe = subprocess.Popen(data.getVar('MKTEMPDIRCMD', localdata, True) or "false", shell=True, stdout=subprocess.PIPE).stdout
         tmpfile = tmppipe.readline().strip()
         if not tmpfile:
             raise FetchError("Fetch: unable to create temporary directory.. make sure 'mktemp' is in the PATH.", loc)
@@ -169,7 +169,7 @@ class Perforce(FetchMethod):
         os.chdir(tmpfile)
         logger.info("Fetch " + loc)
         logger.info("%s%s files %s", p4cmd, p4opt, depot)
-        p4file = os.popen("%s%s files %s" % (p4cmd, p4opt, depot))
+        p4file = subprocess.Popen("%s%s files %s" % (p4cmd, p4opt, depot), shell=True, stdout=subprocess.PIPE).stdout
 
         if not p4file:
             raise FetchError("Fetch: unable to get the P4 files from %s" % depot, loc)
diff --git a/bitbake/lib/bb/fetch2/svk.py b/bitbake/lib/bb/fetch2/svk.py
index 9d34abf..cfca713 100644
--- a/bitbake/lib/bb/fetch2/svk.py
+++ b/bitbake/lib/bb/fetch2/svk.py
@@ -26,6 +26,7 @@ This implementation is for svk. It is based on the svn implementation
 # Based on functions from the base bb module, Copyright 2003 Holger Schurig
 
 import os
+import subprocess
 import logging
 import bb
 from   bb import data
@@ -77,7 +78,7 @@ class Svk(FetchMethod):
         logger.debug(2, "Fetch: creating temporary directory")
         bb.utils.mkdirhier(data.expand('${WORKDIR}', localdata))
         data.setVar('TMPBASE', data.expand('${WORKDIR}/oesvk.XXXXXX', localdata), localdata)
-        tmppipe = os.popen(data.getVar('MKTEMPDIRCMD', localdata, True) or "false")
+        tmppipe = subprocess.Popen(data.getVar('MKTEMPDIRCMD', localdata, True) or "false", shell=True, stdout=subprocess.PIPE).stdout
         tmpfile = tmppipe.readline().strip()
         if not tmpfile:
             logger.error()
diff --git a/bitbake/lib/bb/ui/crumbs/builddetailspage.py b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
index 51e6a4a..30f8249 100755
--- a/bitbake/lib/bb/ui/crumbs/builddetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
@@ -28,6 +28,7 @@ from bb.ui.crumbs.hobwidget import hic, HobNotebook, HobAltButton, HobWarpCellRe
 from bb.ui.crumbs.runningbuild import RunningBuildTreeView
 from bb.ui.crumbs.runningbuild import BuildFailureTreeView
 from bb.ui.crumbs.hobpages import HobPage
+import subprocess
 
 class BuildConfigurationTreeView(gtk.TreeView):
     def __init__ (self):
@@ -96,7 +97,7 @@ class BuildConfigurationTreeView(gtk.TreeView):
         for path in src_config_info.layers:
             import os, os.path
             if os.path.exists(path):
-                f = os.popen('cd %s; git branch 2>&1 | grep "^* " | tr -d "* "' % path)
+                f = subprocess.Popen('cd %s; git branch 2>&1 | grep "^* " | tr -d "* "' % path, shell=True, stdout=subprocess.PIPE).stdout
                 if f:
                     branch = f.readline().lstrip('\n').rstrip('\n')
                     vars.append(self.set_vars("Branch:", branch))
diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/hig.py
index 4baf960..e7650f2 100644
--- a/bitbake/lib/bb/ui/crumbs/hig.py
+++ b/bitbake/lib/bb/ui/crumbs/hig.py
@@ -726,7 +726,7 @@ class DeployImageDialog (CrumbsDialog):
         self.progress_bar.hide()
 
     def popen_read(self, cmd):
-        return os.popen("%s 2>/dev/null" % cmd).read().strip()
+        return subprocess.Popen("%s 2>/dev/null" % cmd, shell=True, stdout=subprocess.PIPE).stdout.read().strip()
 
     def find_all_usb_devices(self):
         usb_devs = [ os.readlink(u)
-- 
1.7.1



