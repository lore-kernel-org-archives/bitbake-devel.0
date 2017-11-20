Return-Path: <david.reyna@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 73BCA78698
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Nov 2017 22:31:24 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id vAKMVPBx014767
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Nov 2017 14:31:25 -0800 (PST)
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.78) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server
	(TLS) id 14.3.361.1; Mon, 20 Nov 2017 14:31:24 -0800
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 20 Nov 2017 14:23:33 -0800
Message-ID: <228e1cc3ec2b5ce0d30e70da50f0327a4d6a872c.1511216528.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1511216528.git.David.Reyna@windriver.com>
References: <cover.1511216528.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.157.78]
Subject: [PATCH 1/6] toaster: unset BBPATH before starting bbserver for backwards compatibility
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
X-List-Received-Date: Mon, 20 Nov 2017 22:31:25 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

The latest build enviroment script is now setting BBPATH. This breaks
building previous releases from a master-based Toaster, because with this
newly inherited BBPATH value the 'bitbake.lock' file ends up in the
Toaster build directory instead of the project's build directory.

Toaster should always clear BBPATH so that the bbserver's environment
is clean (enough).

[YOCTO #12363]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/bldcontrol/localhostbecontroller.py | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index 83cb703..23b2792 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -332,15 +332,18 @@ class LocalhostBEController(BuildEnvironmentController):
                 conf.write('%s="%s"\n' % (var.name, var.value))
             conf.write('INHERIT+="toaster buildhistory"')
 
+        # clean the Toaster to build environment
+        env_clean = 'unset BBPATH;' # clean BBPATH for <= YP-2.4.0
+
         # run bitbake server from the clone
         bitbake = os.path.join(self.pokydirname, 'bitbake', 'bin', 'bitbake')
         toasterlayers = os.path.join(builddir,"conf/toaster-bblayers.conf")
-        self._shellcmd('bash -c \"source %s %s; BITBAKE_UI="knotty" %s --read %s --read %s '
-                       '--server-only -B 0.0.0.0:0\"' % (oe_init,
+        self._shellcmd('%s bash -c \"source %s %s; BITBAKE_UI="knotty" %s --read %s --read %s '
+                       '--server-only -B 0.0.0.0:0\"' % (env_clean, oe_init,
                        builddir, bitbake, confpath, toasterlayers), self.be.sourcedir)
 
         # read port number from bitbake.lock
-        self.be.bbport = ""
+        self.be.bbport = -1
         bblock = os.path.join(builddir, 'bitbake.lock')
         # allow 10 seconds for bb lock file to appear but also be populated
         for lock_check in range(10):
@@ -352,6 +355,9 @@ class LocalhostBEController(BuildEnvironmentController):
                 break
             logger.debug("localhostbecontroller: waiting for bblock content to appear")
             time.sleep(1)
+        else:
+            raise BuildSetupException("Cannot find bitbake server lock file '%s'. Aborting." % bblock)
+
         with open(bblock) as fplock:
             for line in fplock:
                 if ":" in line:
@@ -359,7 +365,7 @@ class LocalhostBEController(BuildEnvironmentController):
                     logger.debug("localhostbecontroller: bitbake port %s", self.be.bbport)
                     break
 
-        if not self.be.bbport:
+        if -1 == self.be.bbport:
             raise BuildSetupException("localhostbecontroller: can't read bitbake port from %s" % bblock)
 
         self.be.bbaddress = "localhost"
@@ -380,10 +386,10 @@ class LocalhostBEController(BuildEnvironmentController):
         log = os.path.join(builddir, 'toaster_ui.log')
         local_bitbake = os.path.join(os.path.dirname(os.getenv('BBBASEDIR')),
                                      'bitbake')
-        self._shellcmd(['bash -c \"(TOASTER_BRBE="%s" BBSERVER="0.0.0.0:%s" '
+        self._shellcmd(['%s bash -c \"(TOASTER_BRBE="%s" BBSERVER="0.0.0.0:%s" '
                         '%s %s -u toasterui  --read %s --read %s --token="" >>%s 2>&1;'
                         'BITBAKE_UI="knotty" BBSERVER=0.0.0.0:%s %s -m)&\"' \
-                        % (brbe, self.be.bbport, local_bitbake, bbtargets, confpath, toasterlayers, log,
+                        % (env_clean, brbe, self.be.bbport, local_bitbake, bbtargets, confpath, toasterlayers, log,
                         self.be.bbport, bitbake,)],
                         builddir, nowait=True)
 
-- 
1.9.1


