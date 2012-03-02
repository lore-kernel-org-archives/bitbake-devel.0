Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Kai.Kang@windriver.com>) id 1S3Nez-0001gG-AO
	for bitbake-devel@lists.openembedded.org;
	Fri, 02 Mar 2012 09:16:17 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q227tD3q017591
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Thu, 1 Mar 2012 23:55:13 -0800 (PST)
Received: from localhost.localdomain (128.224.162.225) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server
	(TLS) id 14.1.255.0; Thu, 1 Mar 2012 23:55:12 -0800
From: Kang Kai <kai.kang@windriver.com>
To: <sgw@linux.intel.com>, <bitbake-devel@lists.openembedded.org>
Date: Fri, 2 Mar 2012 15:54:58 +0800
Message-ID: <bbac4fa41e627a8673202459461c10e0c1426b61.1330674604.git.kai.kang@windriver.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1330674604.git.kai.kang@windriver.com>
References: <cover.1330674604.git.kai.kang@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [128.224.162.225]
Subject: [PATCH 1/1] bitbake: enable cleanup of WORKDIR
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
X-List-Received-Date: Fri, 02 Mar 2012 08:16:17 -0000
Content-Type: text/plain

[Yocto 1561]
Add a command line option for bitbake to enable cleanup of WORKDIR.
It checks every package build directories under WORKDIR then parse
the directory name to get package name and version. If the version
is not the package prefer version then delete the directory.

Signed-off-by: Kang Kai <kai.kang@windriver.com>
---
 bitbake/bin/bitbake       |    4 +++
 bitbake/lib/bb/command.py |    5 +++
 bitbake/lib/bb/cooker.py  |   63 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+), 0 deletions(-)

diff --git a/bitbake/bin/bitbake b/bitbake/bin/bitbake
index c06d4e8..89582f7 100755
--- a/bitbake/bin/bitbake
+++ b/bitbake/bin/bitbake
@@ -170,6 +170,10 @@ Default BBFILES are the .bb files in the current directory.""")
 
     parser.add_option("-B", "--bind", help = "The name/address for the bitbake server to bind to",
                action = "store", dest = "bind", default = False)
+
+    parser.add_option("-C", "--clean-workdir", help = "Clean up the old version build directories in workdir",
+               action = "store_true", dest = "clean_workdir", default = False)
+
     options, args = parser.parse_args(sys.argv)
 
     configuration = BBConfiguration(options)
diff --git a/bitbake/lib/bb/command.py b/bitbake/lib/bb/command.py
index 1799f1c..a924e85 100644
--- a/bitbake/lib/bb/command.py
+++ b/bitbake/lib/bb/command.py
@@ -294,6 +294,11 @@ class CommandsAsync:
         command.finishAsyncCommand()
     findConfigFilePath.needcache = False
 
+    def cleanupWorkdir(self, command, params):
+        command.cooker.cleanupWorkdir()
+        command.finishAsyncCommand()
+    cleanupWorkdir.needcache = True
+
     def showVersions(self, command, params):
         """
         Show the currently selected versions
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 558eadd..0870488 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -30,6 +30,7 @@ import logging
 import multiprocessing
 import sre_constants
 import threading
+import shutil
 from cStringIO import StringIO
 from contextlib import closing
 from functools import wraps
@@ -247,6 +248,8 @@ class BBCooker:
                 self.commandlineAction['action'] = ["generateDotGraph", self.configuration.pkgs_to_build, self.configuration.cmd]
             else:
                 self.commandlineAction['msg'] = "Please specify a package name for dependency graph generation."
+        elif self.configuration.clean_workdir:
+            self.commandlineAction['action'] = ["cleanupWorkdir"]
         else:
             if self.configuration.pkgs_to_build:
                 self.commandlineAction['action'] = ["buildTargets", self.configuration.pkgs_to_build, self.configuration.cmd]
@@ -254,6 +257,66 @@ class BBCooker:
                 #self.commandlineAction['msg'] = "Nothing to do.  Use 'bitbake world' to build everything, or run 'bitbake --help' for usage information."
                 self.commandlineAction = None
 
+    def cleanupWorkdir(self):
+        """
+        Clean up the package old version build directory in workdir
+        """
+
+        def parseDirName(match):
+            pkg_name = match.group(1)
+            pkg_version = match.group(2)
+            if pkg_name in pkg_pn:
+                pref = preferred_versions[pkg_name]
+                epoch = pref[0][0]
+                if len(epoch) > 0:
+                    epoch += '_'
+                prefstr = epoch + pref[0][1] + '-' +pref[0][2]
+                if pkg_version != prefstr:
+                    obsolete_dirs.append(pkgabsdir)
+                return True
+            return False
+
+        # Need files parsed
+        self.updateCache()
+
+        pkg_pn = self.status.pkg_pn
+        (latest_versions, preferred_versions) = bb.providers.findProviders(self.configuration.data, self.status, pkg_pn)
+
+        tmpdir = self.configuration.data.getVar('TMPDIR', True)
+        workdir = os.path.join(tmpdir, 'work')
+
+        obsolete_dirs = []
+
+        for archdir in os.listdir(workdir):
+            archdir = os.path.join(workdir, archdir)
+            if not os.path.isdir(archdir):
+                pass
+
+            for pkgdir in os.listdir(archdir):
+                pkgabsdir = os.path.join(archdir, pkgdir)
+                if not os.path.isdir(pkgabsdir):
+                    pass
+
+                # parse the package directory names
+                # parse native/nativesdk packages first
+                match = re.match('(.*?-native.*?)-(.*)', pkgdir)
+                if match and parseDirName(match):
+                    continue
+
+                # parse package names which ends with numbers such as 'glib-2.0'
+                match = re.match('(.*?-[\.\d]+)-(\d.*)', pkgdir)
+                if match and parseDirName(match):
+                    continue
+
+                # other packages
+                match = re.match('(.*?)-(\d.*)', pkgdir)
+                if match and parseDirName(match):
+                    continue
+
+        for d in obsolete_dirs:
+            logger.warn("Deleleting %s", d)
+            shutil.rmtree(d, True)
+
     def runCommands(self, server, data, abort):
         """
         Run any queued asynchronous command
-- 
1.7.5.4



