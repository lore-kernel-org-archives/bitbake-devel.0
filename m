Return-Path: <randy.e.witt@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 7BF0B609B2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 May 2015 22:06:22 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga101.jf.intel.com with ESMTP; 18 May 2015 15:06:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.13,455,1427785200"; d="scan'208";a="573315041"
Received: from bitbang.jf.intel.com ([10.7.201.37])
	by orsmga003.jf.intel.com with ESMTP; 18 May 2015 15:06:24 -0700
From: Randy Witt <randy.e.witt@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 18 May 2015 15:06:12 -0700
Message-Id: <1431986772-17395-3-git-send-email-randy.e.witt@linux.intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <1431986772-17395-1-git-send-email-randy.e.witt@linux.intel.com>
References: <1431986772-17395-1-git-send-email-randy.e.witt@linux.intel.com>
Subject: [PATCH 2/2] toaster: Remove dependency on daemon application
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
X-List-Received-Date: Mon, 18 May 2015 22:06:22 -0000

The bitbake observer is now started using python subprocess. This should
allow for toaster to run without installing the "daemon" application.

[Yocto #7271]

Signed-off-by: Randy Witt <randy.e.witt@linux.intel.com>
---
 bitbake/bin/toaster                                     |  5 -----
 bitbake/lib/toaster/bldcontrol/localhostbecontroller.py | 12 +++++++++---
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/bitbake/bin/toaster b/bitbake/bin/toaster
index f5ee68c..18eba8e 100755
--- a/bitbake/bin/toaster
+++ b/bitbake/bin/toaster
@@ -183,11 +183,6 @@ if [ `basename \"$0\"` = `basename \"${SRCFILE}\"` ]; then
         exit 1
     fi
 
-    if ! which daemon >/dev/null 2>&1; then
-        echo -e "Failed dependency; toaster needs the 'daemon' program in order to be able to start builds'. Please install the 'daemon' program from your distribution repositories or http://www.libslack.org/daemon/" 1>&2
-        exit 1
-    fi
-
     # Define a fake builddir where only the pid files are actually created. No real builds will take place here.
     BUILDDIR=/tmp/toaster_$$
     if [ -d "$BUILDDIR" ]; then
diff --git a/bitbake/lib/toaster/bldcontrol/localhostbecontroller.py b/bitbake/lib/toaster/bldcontrol/localhostbecontroller.py
index 95ba481..dfe06f9 100644
--- a/bitbake/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/bitbake/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -117,10 +117,11 @@ class LocalhostBEController(BuildEnvironmentController):
                 f.seek(0, 2)    # jump to the end
                 toaster_ui_log_filelength = f.tell()
 
-        cmd = "bash -c \"source %s/oe-init-build-env %s 2>&1 >toaster_server.log && bitbake --read conf/toaster-pre.conf --postread conf/toaster.conf --server-only -t xmlrpc -B 0.0.0.0:0 2>&1 >toaster_server.log && DATABASE_URL=%s BBSERVER=0.0.0.0:-1 daemon -d -i -D %s -o toaster_ui.log -- %s --observe-only -u toasterui &\"" % (self.pokydirname, self.be.builddir,
-                self.dburl, self.be.builddir, own_bitbake)
+        cmd = "bash -c \"source %s/oe-init-build-env %s 2>&1 >toaster_server.log && bitbake --read conf/toaster-pre.conf --postread conf/toaster.conf --server-only -t xmlrpc -B 0.0.0.0:0 2>&1 >>toaster_server.log \"" % (self.pokydirname, self.be.builddir)
+
         port = "-1"
         logger.debug("localhostbecontroller: starting builder \n%s\n" % cmd)
+
         cmdoutput = self._shellcmd(cmd)
         with open(self.be.builddir + "/toaster_server.log", "r") as f:
             for i in f.readlines():
@@ -128,6 +129,10 @@ class LocalhostBEController(BuildEnvironmentController):
                     port = i.split(" ")[-1]
                     logger.debug("localhostbecontroller: Found bitbake server port %s" % port)
 
+        cmd = "bash -c \"source %s/oe-init-build-env-memres -1 %s && DATABASE_URL=%s %s --observe-only -u toasterui --remote-server=0.0.0.0:-1 -t xmlrpc\"" % (self.pokydirname, self.be.builddir, self.dburl, own_bitbake)
+        with open(toaster_ui_log_filepath, "a+") as f:
+            p = subprocess.Popen(cmd, cwd = self.be.builddir, shell=True, stdout=f, stderr=f)
+
         def _toaster_ui_started(filepath, filepos = 0):
             if not os.path.exists(filepath):
                 return False
@@ -148,8 +153,9 @@ class LocalhostBEController(BuildEnvironmentController):
             retries += 1
 
         if not started:
+            toaster_ui_log = open(os.path.join(self.be.builddir, "toaster_ui.log"), "r").read()
             toaster_server_log = open(os.path.join(self.be.builddir, "toaster_server.log"), "r").read()
-            raise BuildSetupException("localhostbecontroller: Bitbake server did not start in 5 seconds, aborting (Error: '%s' '%s')" % (cmdoutput, toaster_server_log))
+            raise BuildSetupException("localhostbecontroller: Bitbake server did not start in 5 seconds, aborting (Error: '%s' '%s')" % (toaster_ui_log, toaster_server_log))
 
         logger.debug("localhostbecontroller: Started bitbake server")
 
-- 
1.9.3


