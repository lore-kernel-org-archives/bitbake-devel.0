Return-Path: <david.reyna@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 72A9978694
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Nov 2017 22:31:25 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id vAKMVQVB014773
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Nov 2017 14:31:27 -0800 (PST)
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.78) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server
	(TLS) id 14.3.361.1; Mon, 20 Nov 2017 14:31:26 -0800
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 20 Nov 2017 14:23:36 -0800
Message-ID: <f32125d9fccfb367b1292f880a40cf4d29671c34.1511216528.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1511216528.git.David.Reyna@windriver.com>
References: <cover.1511216528.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.157.78]
Subject: [PATCH 4/6] toaster: enable custom env support for shell calls
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

Allow for custom environment additions for git cloning, for example
for anspass support.

[YOCTO #12193]
---
 lib/toaster/bldcontrol/localhostbecontroller.py | 26 ++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index 23b2792..4c17562 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -52,12 +52,14 @@ class LocalhostBEController(BuildEnvironmentController):
         self.pokydirname = None
         self.islayerset = False
 
-    def _shellcmd(self, command, cwd=None, nowait=False):
+    def _shellcmd(self, command, cwd=None, nowait=False,env=None):
         if cwd is None:
             cwd = self.be.sourcedir
+        if env is None:
+            env=os.environ.copy()
 
-        logger.debug("lbc_shellcmmd: (%s) %s" % (cwd, command))
-        p = subprocess.Popen(command, cwd = cwd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
+        logger.debug("lbc_shellcmd: (%s) %s" % (cwd, command))
+        p = subprocess.Popen(command, cwd = cwd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, env=env)
         if nowait:
             return
         (out,err) = p.communicate()
@@ -98,6 +100,8 @@ class LocalhostBEController(BuildEnvironmentController):
 
         layerlist = []
         nongitlayerlist = []
+        git_env = os.environ.copy()
+        # (note: add custom environment settings here)
 
         # set layers in the layersource
 
@@ -138,7 +142,7 @@ class LocalhostBEController(BuildEnvironmentController):
         cached_layers = {}
 
         try:
-            for remotes in self._shellcmd("git remote -v", self.be.sourcedir).split("\n"):
+            for remotes in self._shellcmd("git remote -v", self.be.sourcedir,env=git_env).split("\n"):
                 try:
                     remote = remotes.split("\t")[1].split(" ")[0]
                     if remote not in cached_layers:
@@ -167,7 +171,7 @@ class LocalhostBEController(BuildEnvironmentController):
             if os.path.exists(localdirname):
                 try:
                     localremotes = self._shellcmd("git remote -v",
-                                                  localdirname)
+                                                  localdirname,env=git_env)
                     if not giturl in localremotes and commit != 'HEAD':
                         raise BuildSetupException("Existing git repository at %s, but with different remotes ('%s', expected '%s'). Toaster will not continue out of fear of damaging something." % (localdirname, ", ".join(localremotes.split("\n")), giturl))
                 except ShellCmdException:
@@ -177,18 +181,18 @@ class LocalhostBEController(BuildEnvironmentController):
             else:
                 if giturl in cached_layers:
                     logger.debug("localhostbecontroller git-copying %s to %s" % (cached_layers[giturl], localdirname))
-                    self._shellcmd("git clone \"%s\" \"%s\"" % (cached_layers[giturl], localdirname))
-                    self._shellcmd("git remote remove origin", localdirname)
-                    self._shellcmd("git remote add origin \"%s\"" % giturl, localdirname)
+                    self._shellcmd("git clone \"%s\" \"%s\"" % (cached_layers[giturl], localdirname),env=git_env)
+                    self._shellcmd("git remote remove origin", localdirname,env=git_env)
+                    self._shellcmd("git remote add origin \"%s\"" % giturl, localdirname,env=git_env)
                 else:
                     logger.debug("localhostbecontroller: cloning %s in %s" % (giturl, localdirname))
-                    self._shellcmd('git clone "%s" "%s"' % (giturl, localdirname))
+                    self._shellcmd('git clone "%s" "%s"' % (giturl, localdirname),env=git_env)
 
             # branch magic name "HEAD" will inhibit checkout
             if commit != "HEAD":
                 logger.debug("localhostbecontroller: checking out commit %s to %s " % (commit, localdirname))
                 ref = commit if re.match('^[a-fA-F0-9]+$', commit) else 'origin/%s' % commit
-                self._shellcmd('git fetch --all && git reset --hard "%s"' % ref, localdirname)
+                self._shellcmd('git fetch --all && git reset --hard "%s"' % ref, localdirname,env=git_env)
 
             # take the localdirname as poky dir if we can find the oe-init-build-env
             if self.pokydirname is None and os.path.exists(os.path.join(localdirname, "oe-init-build-env")):
@@ -198,7 +202,7 @@ class LocalhostBEController(BuildEnvironmentController):
                 # make sure we have a working bitbake
                 if not os.path.exists(os.path.join(self.pokydirname, 'bitbake')):
                     logger.debug("localhostbecontroller: checking bitbake into the poky dirname %s " % self.pokydirname)
-                    self._shellcmd("git clone -b \"%s\" \"%s\" \"%s\" " % (bitbake.commit, bitbake.giturl, os.path.join(self.pokydirname, 'bitbake')))
+                    self._shellcmd("git clone -b \"%s\" \"%s\" \"%s\" " % (bitbake.commit, bitbake.giturl, os.path.join(self.pokydirname, 'bitbake')),env=git_env)
 
             # verify our repositories
             for name, dirpath in gitrepos[(giturl, commit)]:
-- 
1.9.1


