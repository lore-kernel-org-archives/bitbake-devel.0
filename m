Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
	[209.85.212.179])
	by mail.openembedded.org (Postfix) with ESMTP id DCA5F714A1
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  4 Sep 2014 16:45:20 +0000 (UTC)
Received: by mail-wi0-f179.google.com with SMTP id q5so1506708wiv.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 04 Sep 2014 09:45:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=JF0KJLtYNjim1sZEp1E+BBUU8Za5HlhJGOuwujonRK0=;
	b=lJLzvIAySsAi9hB/mRNYbt9UlNPpuv7lot5fHihpLrb+NDjAW+eeWopQ401on8NtMV
	kvsS8qJI1aOZMo7eMxFcvepzoRSTKO09T5l19O4e8slpL/Yp7xU5AD3ULFu08neJ4iDI
	GpVJJGMuhY/x1wpGxnUddcxmVpLlx2zrVRpiBUGoicQA4Jm/UQGvkap7Mt+kKt7PJGbE
	Aak9Xze7DSnNRpitASSgcNNNK7TwR5713H6+Bb/89aZkDYjvIV8oOjPoLivK587I0PS6
	/vz/pZ1jMx8ZOtrDQz1rYDd+20qQgj5C2dtPFGOR1BCmUIE81Rq3MdykLVL+yhBRfCWE
	kOhA==
X-Gm-Message-State: ALoCoQn2oqIEsFpsGhKcj+eLDN9I47igI8GYFwh21cqyxtdjb0k46LH+GaX2mMWKyeu+gNhhUX4g
X-Received: by 10.194.5.234 with SMTP id v10mr7514308wjv.45.1409849120965;
	Thu, 04 Sep 2014 09:45:20 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id gl10sm2433652wib.1.2014.09.04.09.45.18
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 04 Sep 2014 09:45:19 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 50222562457; Thu,  4 Sep 2014 17:45:19 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: toaster@yoctoproject.org,
	bitbake-devel@lists.openembedded.org
Date: Thu,  4 Sep 2014 17:45:14 +0100
Message-Id: <c2ad9c9bb83f61c171434324df8c4d5ee655a556.1409848901.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <a37f2c194d7e59611177cb8755524b7ad702fe91.1409848901.git.alexandru.damian@intel.com>
References: <a37f2c194d7e59611177cb8755524b7ad702fe91.1409848901.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1409848901.git.alexandru.damian@intel.com>
References: <cover.1409848901.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 3/6] toaster: enable SSH-based remote build support
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
X-List-Received-Date: Thu, 04 Sep 2014 16:45:21 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We enable support for starting builds on remote machines
through SSH. The support is limited to poky-based distributions.

We refactor localhost build support and we update
bldcontrol application tests to uniformely test the APIs
of localhost and SSH build controllers.

[YOCTO #6240]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/bldcontrol/bbcontroller.py          | 170 ++-------------------
 lib/toaster/bldcontrol/localhostbecontroller.py | 191 +++++++++++++++++++++++
 lib/toaster/bldcontrol/sshbecontroller.py       | 193 ++++++++++++++++++++++++
 lib/toaster/bldcontrol/tests.py                 | 116 +++++++++++---
 4 files changed, 488 insertions(+), 182 deletions(-)
 create mode 100644 lib/toaster/bldcontrol/localhostbecontroller.py
 create mode 100644 lib/toaster/bldcontrol/sshbecontroller.py

diff --git a/lib/toaster/bldcontrol/bbcontroller.py b/lib/toaster/bldcontrol/bbcontroller.py
index bf9cdf9..6812ae3 100644
--- a/lib/toaster/bldcontrol/bbcontroller.py
+++ b/lib/toaster/bldcontrol/bbcontroller.py
@@ -26,10 +26,6 @@ import re
 from django.db import transaction
 from django.db.models import Q
 from bldcontrol.models import BuildEnvironment, BRLayer, BRVariable, BRTarget, BRBitbake
-import subprocess
-
-from toastermain import settings
-
 
 # load Bitbake components
 path = os.path.join(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))
@@ -72,6 +68,10 @@ def getBuildEnvironmentController(**kwargs):
 
         The return object MUST always be a BuildEnvironmentController.
     """
+
+    from localhostbecontroller import LocalhostBEController
+    from sshbecontroller    import SSHBEController
+
     be = BuildEnvironment.objects.filter(Q(**kwargs))[0]
     if be.betype == BuildEnvironment.TYPE_LOCAL:
         return LocalhostBEController(be)
@@ -81,6 +81,13 @@ def getBuildEnvironmentController(**kwargs):
         raise Exception("FIXME: Implement BEC for type %s" % str(be.betype))
 
 
+def _getgitcheckoutdirectoryname(url):
+    """ Utility that returns the last component of a git path as directory
+    """
+    import re
+    components = re.split(r'[:\.\/]', url)
+    return components[-2] if components[-1] == "git" else components[-1]
+
 
 class BuildEnvironmentController(object):
     """ BuildEnvironmentController (BEC) is the abstract class that defines the operations that MUST
@@ -110,6 +117,7 @@ class BuildEnvironmentController(object):
         self.be = be
         self.connection = None
 
+
     def startBBServer(self):
         """ Starts a  BB server with Toaster toasterui set up to record the builds, an no controlling UI.
             After this method executes, self.be bbaddress/bbport MUST point to a running and free server,
@@ -173,157 +181,3 @@ class ShellCmdException(Exception):
 class BuildSetupException(Exception):
     pass
 
-class LocalhostBEController(BuildEnvironmentController):
-    """ Implementation of the BuildEnvironmentController for the localhost;
-        this controller manages the default build directory,
-        the server setup and system start and stop for the localhost-type build environment
-
-    """
-
-    def __init__(self, be):
-        super(LocalhostBEController, self).__init__(be)
-        self.dburl = settings.getDATABASE_URL()
-        self.pokydirname = None
-
-    def _shellcmd(self, command, cwd = None):
-        if cwd is None:
-            cwd = self.be.sourcedir
-
-        p = subprocess.Popen(command, cwd = cwd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
-        (out,err) = p.communicate()
-        if p.returncode:
-            if len(err) == 0:
-                err = "command: %s \n%s" % (command, out)
-            else:
-                err = "command: %s \n%s" % (command, err)
-            raise ShellCmdException(err)
-        else:
-            return out
-
-    def _createdirpath(self, path):
-        from os.path import dirname as DN
-        if not os.path.exists(DN(path)):
-            self._createdirpath(DN(path))
-        if not os.path.exists(path):
-            os.mkdir(path, 0755)
-
-    def _startBE(self):
-        assert self.pokydirname and os.path.exists(self.pokydirname)
-        self._createdirpath(self.be.builddir)
-        self._shellcmd("bash -c \"source %s/oe-init-build-env %s\"" % (self.pokydirname, self.be.builddir))
-
-    def startBBServer(self):
-        assert self.pokydirname and os.path.exists(self.pokydirname)
-        print self._shellcmd("bash -c \"source %s/oe-init-build-env %s && DATABASE_URL=%s source toaster start noweb && sleep 1\"" % (self.pokydirname, self.be.builddir, self.dburl))
-        # FIXME unfortunate sleep 1 - we need to make sure that bbserver is started and the toaster ui is connected
-        # but since they start async without any return, we just wait a bit
-        print "Started server"
-        assert self.be.sourcedir and os.path.exists(self.be.builddir)
-        self.be.bbaddress = "localhost"
-        self.be.bbport = "8200"
-        self.be.bbstate = BuildEnvironment.SERVER_STARTED
-        self.be.save()
-
-    def stopBBServer(self):
-        assert self.be.sourcedir
-        print self._shellcmd("bash -c \"source %s/oe-init-build-env %s && %s source toaster stop\"" %
-            (self.be.sourcedir, self.be.builddir, (lambda: "" if self.be.bbtoken is None else "BBTOKEN=%s" % self.be.bbtoken)()))
-        self.be.bbstate = BuildEnvironment.SERVER_STOPPED
-        self.be.save()
-        print "Stopped server"
-
-    def setLayers(self, bitbakes, layers):
-        """ a word of attention: by convention, the first layer for any build will be poky! """
-
-        assert self.be.sourcedir is not None
-        assert len(bitbakes) == 1
-        # set layers in the layersource
-
-        # 1. get a list of repos, and map dirpaths for each layer
-        gitrepos = {}
-        gitrepos[bitbakes[0].giturl] = []
-        gitrepos[bitbakes[0].giturl].append( ("bitbake", bitbakes[0].dirpath, bitbakes[0].commit) )
-        
-        for layer in layers:
-            # we don't process local URLs
-            if layer.giturl.startswith("file://"):
-                continue
-            if not layer.giturl in gitrepos:
-                gitrepos[layer.giturl] = []
-            gitrepos[layer.giturl].append( (layer.name, layer.dirpath, layer.commit))
-        for giturl in gitrepos.keys():
-            commitid = gitrepos[giturl][0][2]
-            for e in gitrepos[giturl]:
-                if commitid != e[2]:
-                    raise BuildSetupException("More than one commit per git url, unsupported configuration")
-
-        def _getgitdirectoryname(url):
-            import re
-            components = re.split(r'[:\.\/]', url)
-            return components[-2] if components[-1] == "git" else components[-1]
-
-        layerlist = []
-
-        # 2. checkout the repositories
-        for giturl in gitrepos.keys():
-            localdirname = os.path.join(self.be.sourcedir, _getgitdirectoryname(giturl))
-            print "DEBUG: giturl ", giturl ,"checking out in current directory", localdirname
-
-            # make sure our directory is a git repository
-            if os.path.exists(localdirname):
-                if not giturl in self._shellcmd("git remote -v", localdirname):
-                    raise BuildSetupException("Existing git repository at %s, but with different remotes (not '%s'). Aborting." % (localdirname, giturl))
-            else:
-                self._shellcmd("git clone \"%s\" \"%s\"" % (giturl, localdirname))
-            # checkout the needed commit
-            commit = gitrepos[giturl][0][2]
-
-            # branch magic name "HEAD" will inhibit checkout
-            if commit != "HEAD":
-                print "DEBUG: checking out commit ", commit, "to", localdirname
-                self._shellcmd("git fetch --all && git checkout \"%s\"" % commit , localdirname)
-
-            # take the localdirname as poky dir if we can find the oe-init-build-env
-            if self.pokydirname is None and os.path.exists(os.path.join(localdirname, "oe-init-build-env")):
-                print "DEBUG: selected poky dir name", localdirname
-                self.pokydirname = localdirname
-
-            # verify our repositories
-            for name, dirpath, commit in gitrepos[giturl]:
-                localdirpath = os.path.join(localdirname, dirpath)
-                if not os.path.exists(localdirpath):
-                    raise BuildSetupException("Cannot find layer git path '%s' in checked out repository '%s:%s'. Aborting." % (localdirpath, giturl, commit))
-
-                if name != "bitbake":
-                    layerlist.append(localdirpath)
-
-        print "DEBUG: current layer list ", layerlist
-
-        # 3. configure the build environment, so we have a conf/bblayers.conf
-        assert self.pokydirname is not None
-        self._startBE()
-
-        # 4. update the bblayers.conf
-        bblayerconf = os.path.join(self.be.builddir, "conf/bblayers.conf")
-        if not os.path.exists(bblayerconf):
-            raise BuildSetupException("BE is not consistent: bblayers.conf file missing at %s" % bblayerconf)
-
-        conflines = open(bblayerconf, "r").readlines()
-
-        bblayerconffile = open(bblayerconf, "w")
-        for i in xrange(len(conflines)):
-            if conflines[i].startswith("# line added by toaster"):
-                i += 2
-            else:
-                bblayerconffile.write(conflines[i])
-
-        bblayerconffile.write("\n# line added by toaster build control\nBBLAYERS = \"" + " ".join(layerlist) + "\"")
-        bblayerconffile.close()
-
-        return True
-
-    def release(self):
-        assert self.be.sourcedir and os.path.exists(self.be.builddir)
-        import shutil
-        shutil.rmtree(os.path.join(self.be.sourcedir, "build"))
-        assert not os.path.exists(self.be.builddir)
diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
new file mode 100644
index 0000000..fe7fd81
--- /dev/null
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -0,0 +1,191 @@
+#
+# ex:ts=4:sw=4:sts=4:et
+# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
+#
+# BitBake Toaster Implementation
+#
+# Copyright (C) 2014        Intel Corporation
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+
+
+import os
+import sys
+import re
+from django.db import transaction
+from django.db.models import Q
+from bldcontrol.models import BuildEnvironment, BRLayer, BRVariable, BRTarget, BRBitbake
+import subprocess
+
+from toastermain import settings
+
+from bbcontroller import BuildEnvironmentController, ShellCmdException, BuildSetupException, _getgitcheckoutdirectoryname
+
+class LocalhostBEController(BuildEnvironmentController):
+    """ Implementation of the BuildEnvironmentController for the localhost;
+        this controller manages the default build directory,
+        the server setup and system start and stop for the localhost-type build environment
+
+    """
+
+    def __init__(self, be):
+        super(LocalhostBEController, self).__init__(be)
+        self.dburl = settings.getDATABASE_URL()
+        self.pokydirname = None
+        self.islayerset = False
+
+    def _shellcmd(self, command, cwd = None):
+        if cwd is None:
+            cwd = self.be.sourcedir
+
+        p = subprocess.Popen(command, cwd = cwd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
+        (out,err) = p.communicate()
+        if p.returncode:
+            if len(err) == 0:
+                err = "command: %s \n%s" % (command, out)
+            else:
+                err = "command: %s \n%s" % (command, err)
+            raise ShellCmdException(err)
+        else:
+            return out
+
+    def _createdirpath(self, path):
+        from os.path import dirname as DN
+        if path == "":
+            raise Exception("Invalid path creation specified.")
+        if not os.path.exists(DN(path)):
+            self._createdirpath(DN(path))
+        if not os.path.exists(path):
+            os.mkdir(path, 0755)
+
+    def _setupBE(self):
+        assert self.pokydirname and os.path.exists(self.pokydirname)
+        self._createdirpath(self.be.builddir)
+        self._shellcmd("bash -c \"source %s/oe-init-build-env %s\"" % (self.pokydirname, self.be.builddir))
+
+    def startBBServer(self):
+        assert self.pokydirname and os.path.exists(self.pokydirname)
+        assert self.islayerset
+        print("DEBUG: executing ", "bash -c \"source %s/oe-init-build-env %s && DATABASE_URL=%s source toaster start noweb && sleep 1\"" % (self.pokydirname, self.be.builddir, self.dburl))
+        print self._shellcmd("bash -c \"source %s/oe-init-build-env %s && DATABASE_URL=%s source toaster start noweb && sleep 1\"" % (self.pokydirname, self.be.builddir, self.dburl))
+        # FIXME unfortunate sleep 1 - we need to make sure that bbserver is started and the toaster ui is connected
+        # but since they start async without any return, we just wait a bit
+        print "Started server"
+        assert self.be.sourcedir and os.path.exists(self.be.builddir)
+        self.be.bbaddress = "localhost"
+        self.be.bbport = "8200"
+        self.be.bbstate = BuildEnvironment.SERVER_STARTED
+        self.be.save()
+
+    def stopBBServer(self):
+        assert self.pokydirname and os.path.exists(self.pokydirname)
+        assert self.islayerset
+        print self._shellcmd("bash -c \"source %s/oe-init-build-env %s && %s source toaster stop\"" %
+            (self.pokydirname, self.be.builddir, (lambda: "" if self.be.bbtoken is None else "BBTOKEN=%s" % self.be.bbtoken)()))
+        self.be.bbstate = BuildEnvironment.SERVER_STOPPED
+        self.be.save()
+        print "Stopped server"
+
+    def setLayers(self, bitbakes, layers):
+        """ a word of attention: by convention, the first layer for any build will be poky! """
+
+        assert self.be.sourcedir is not None
+        assert len(bitbakes) == 1
+        # set layers in the layersource
+
+        # 1. get a list of repos, and map dirpaths for each layer
+        gitrepos = {}
+        gitrepos[bitbakes[0].giturl] = []
+        gitrepos[bitbakes[0].giturl].append( ("bitbake", bitbakes[0].dirpath, bitbakes[0].commit) )
+        
+        for layer in layers:
+            # we don't process local URLs
+            if layer.giturl.startswith("file://"):
+                continue
+            if not layer.giturl in gitrepos:
+                gitrepos[layer.giturl] = []
+            gitrepos[layer.giturl].append( (layer.name, layer.dirpath, layer.commit))
+        for giturl in gitrepos.keys():
+            commitid = gitrepos[giturl][0][2]
+            for e in gitrepos[giturl]:
+                if commitid != e[2]:
+                    raise BuildSetupException("More than one commit per git url, unsupported configuration")
+
+
+        layerlist = []
+
+        # 2. checkout the repositories
+        for giturl in gitrepos.keys():
+            localdirname = os.path.join(self.be.sourcedir, _getgitcheckoutdirectoryname(giturl))
+            print "DEBUG: giturl ", giturl ,"checking out in current directory", localdirname
+
+            # make sure our directory is a git repository
+            if os.path.exists(localdirname):
+                if not giturl in self._shellcmd("git remote -v", localdirname):
+                    raise BuildSetupException("Existing git repository at %s, but with different remotes (not '%s'). Aborting." % (localdirname, giturl))
+            else:
+                self._shellcmd("git clone \"%s\" \"%s\"" % (giturl, localdirname))
+            # checkout the needed commit
+            commit = gitrepos[giturl][0][2]
+
+            # branch magic name "HEAD" will inhibit checkout
+            if commit != "HEAD":
+                print "DEBUG: checking out commit ", commit, "to", localdirname
+                self._shellcmd("git fetch --all && git checkout \"%s\"" % commit , localdirname)
+
+            # take the localdirname as poky dir if we can find the oe-init-build-env
+            if self.pokydirname is None and os.path.exists(os.path.join(localdirname, "oe-init-build-env")):
+                print "DEBUG: selected poky dir name", localdirname
+                self.pokydirname = localdirname
+
+            # verify our repositories
+            for name, dirpath, commit in gitrepos[giturl]:
+                localdirpath = os.path.join(localdirname, dirpath)
+                if not os.path.exists(localdirpath):
+                    raise BuildSetupException("Cannot find layer git path '%s' in checked out repository '%s:%s'. Aborting." % (localdirpath, giturl, commit))
+
+                if name != "bitbake":
+                    layerlist.append(localdirpath)
+
+        print "DEBUG: current layer list ", layerlist
+
+        # 3. configure the build environment, so we have a conf/bblayers.conf
+        assert self.pokydirname is not None
+        self._setupBE()
+
+        # 4. update the bblayers.conf
+        bblayerconf = os.path.join(self.be.builddir, "conf/bblayers.conf")
+        if not os.path.exists(bblayerconf):
+            raise BuildSetupException("BE is not consistent: bblayers.conf file missing at %s" % bblayerconf)
+
+        conflines = open(bblayerconf, "r").readlines()
+
+        bblayerconffile = open(bblayerconf, "w")
+        for i in xrange(len(conflines)):
+            if conflines[i].startswith("# line added by toaster"):
+                i += 2
+            else:
+                bblayerconffile.write(conflines[i])
+
+        bblayerconffile.write("\n# line added by toaster build control\nBBLAYERS = \"" + " ".join(layerlist) + "\"")
+        bblayerconffile.close()
+
+        self.islayerset = True
+        return True
+
+    def release(self):
+        assert self.be.sourcedir and os.path.exists(self.be.builddir)
+        import shutil
+        shutil.rmtree(os.path.join(self.be.sourcedir, "build"))
+        assert not os.path.exists(self.be.builddir)
diff --git a/lib/toaster/bldcontrol/sshbecontroller.py b/lib/toaster/bldcontrol/sshbecontroller.py
new file mode 100644
index 0000000..6467495
--- /dev/null
+++ b/lib/toaster/bldcontrol/sshbecontroller.py
@@ -0,0 +1,193 @@
+#
+# ex:ts=4:sw=4:sts=4:et
+# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
+#
+# BitBake Toaster Implementation
+#
+# Copyright (C) 2014        Intel Corporation
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+
+
+import sys
+import re
+from django.db import transaction
+from django.db.models import Q
+from bldcontrol.models import BuildEnvironment, BRLayer, BRVariable, BRTarget, BRBitbake
+import subprocess
+
+from toastermain import settings
+
+from bbcontroller import BuildEnvironmentController, ShellCmdException, BuildSetupException, _getgitcheckoutdirectoryname
+
+def DN(path):
+    return "/".join(path.split("/")[0:-1])
+
+class SSHBEController(BuildEnvironmentController):
+    """ Implementation of the BuildEnvironmentController for the localhost;
+        this controller manages the default build directory,
+        the server setup and system start and stop for the localhost-type build environment
+
+    """
+
+    def __init__(self, be):
+        super(SSHBEController, self).__init__(be)
+        self.dburl = settings.getDATABASE_URL()
+        self.pokydirname = None
+        self.islayerset = False
+
+    def _shellcmd(self, command, cwd = None):
+        if cwd is None:
+            cwd = self.be.sourcedir
+
+        p = subprocess.Popen("ssh %s 'cd %s && %s'" % (self.be.address, cwd, command), stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True)
+        (out,err) = p.communicate()
+        if p.returncode:
+            if len(err) == 0:
+                err = "command: %s \n%s" % (command, out)
+            else:
+                err = "command: %s \n%s" % (command, err)
+            raise ShellCmdException(err)
+        else:
+            return out.strip()
+
+    def _pathexists(self, path):
+        try:
+            self._shellcmd("test -e \"%s\"" % path)
+            return True
+        except ShellCmdException as e:
+            return False
+
+    def _pathcreate(self, path):
+        self._shellcmd("mkdir -p \"%s\"" % path)
+
+    def _setupBE(self):
+        assert self.pokydirname and self._pathexists(self.pokydirname)
+        self._pathcreate(self.be.builddir)
+        self._shellcmd("bash -c \"source %s/oe-init-build-env %s\"" % (self.pokydirname, self.be.builddir))
+
+    def startBBServer(self):
+        assert self.pokydirname and self._pathexists(self.pokydirname)
+        assert self.islayerset
+        print self._shellcmd("bash -c \"source %s/oe-init-build-env %s && DATABASE_URL=%s source toaster start noweb && sleep 1\"" % (self.pokydirname, self.be.builddir, self.dburl))
+        # FIXME unfortunate sleep 1 - we need to make sure that bbserver is started and the toaster ui is connected
+        # but since they start async without any return, we just wait a bit
+        print "Started server"
+        assert self.be.sourcedir and self._pathexists(self.be.builddir)
+        self.be.bbaddress = self.be.address.split("@")[-1]
+        self.be.bbport = "8200"
+        self.be.bbstate = BuildEnvironment.SERVER_STARTED
+        self.be.save()
+
+    def stopBBServer(self):
+        assert self.pokydirname and self._pathexists(self.pokydirname)
+        assert self.islayerset
+        print self._shellcmd("bash -c \"source %s/oe-init-build-env %s && %s source toaster stop\"" %
+            (self.pokydirname, self.be.builddir, (lambda: "" if self.be.bbtoken is None else "BBTOKEN=%s" % self.be.bbtoken)()))
+        self.be.bbstate = BuildEnvironment.SERVER_STOPPED
+        self.be.save()
+        print "Stopped server"
+
+    def setLayers(self, bitbakes, layers):
+        """ a word of attention: by convention, the first layer for any build will be poky! """
+
+        assert self.be.sourcedir is not None
+        assert len(bitbakes) == 1
+        # set layers in the layersource
+
+        # 1. get a list of repos, and map dirpaths for each layer
+        gitrepos = {}
+        gitrepos[bitbakes[0].giturl] = []
+        gitrepos[bitbakes[0].giturl].append( ("bitbake", bitbakes[0].dirpath, bitbakes[0].commit) )
+        
+        for layer in layers:
+            # we don't process local URLs
+            if layer.giturl.startswith("file://"):
+                continue
+            if not layer.giturl in gitrepos:
+                gitrepos[layer.giturl] = []
+            gitrepos[layer.giturl].append( (layer.name, layer.dirpath, layer.commit))
+        for giturl in gitrepos.keys():
+            commitid = gitrepos[giturl][0][2]
+            for e in gitrepos[giturl]:
+                if commitid != e[2]:
+                    raise BuildSetupException("More than one commit per git url, unsupported configuration")
+
+        layerlist = []
+
+        # 2. checkout the repositories
+        for giturl in gitrepos.keys():
+            import os
+            localdirname = os.path.join(self.be.sourcedir, _getgitcheckoutdirectoryname(giturl))
+            print "DEBUG: giturl ", giturl ,"checking out in current directory", localdirname
+
+            # make sure our directory is a git repository
+            if self._pathexists(localdirname):
+                if not giturl in self._shellcmd("git remote -v", localdirname):
+                    raise BuildSetupException("Existing git repository at %s, but with different remotes (not '%s'). Aborting." % (localdirname, giturl))
+            else:
+                self._shellcmd("git clone \"%s\" \"%s\"" % (giturl, localdirname))
+            # checkout the needed commit
+            commit = gitrepos[giturl][0][2]
+
+            # branch magic name "HEAD" will inhibit checkout
+            if commit != "HEAD":
+                print "DEBUG: checking out commit ", commit, "to", localdirname
+                self._shellcmd("git fetch --all && git checkout \"%s\"" % commit , localdirname)
+
+            # take the localdirname as poky dir if we can find the oe-init-build-env
+            if self.pokydirname is None and self._pathexists(os.path.join(localdirname, "oe-init-build-env")):
+                print "DEBUG: selected poky dir name", localdirname
+                self.pokydirname = localdirname
+
+            # verify our repositories
+            for name, dirpath, commit in gitrepos[giturl]:
+                localdirpath = os.path.join(localdirname, dirpath)
+                if not self._pathexists(localdirpath):
+                    raise BuildSetupException("Cannot find layer git path '%s' in checked out repository '%s:%s'. Aborting." % (localdirpath, giturl, commit))
+
+                if name != "bitbake":
+                    layerlist.append(localdirpath)
+
+        print "DEBUG: current layer list ", layerlist
+
+        # 3. configure the build environment, so we have a conf/bblayers.conf
+        assert self.pokydirname is not None
+        self._setupBE()
+
+        # 4. update the bblayers.conf
+        bblayerconf = os.path.join(self.be.builddir, "conf/bblayers.conf")
+        if not self._pathexists(bblayerconf):
+            raise BuildSetupException("BE is not consistent: bblayers.conf file missing at %s" % bblayerconf)
+
+        conflines = open(bblayerconf, "r").readlines()
+
+        bblayerconffile = open(bblayerconf, "w")
+        for i in xrange(len(conflines)):
+            if conflines[i].startswith("# line added by toaster"):
+                i += 2
+            else:
+                bblayerconffile.write(conflines[i])
+
+        bblayerconffile.write("\n# line added by toaster build control\nBBLAYERS = \"" + " ".join(layerlist) + "\"")
+        bblayerconffile.close()
+
+        self.islayerset = True
+        return True
+
+    def release(self):
+        assert self.be.sourcedir and self._pathexists(self.be.builddir)
+        import shutil
+        shutil.rmtree(os.path.join(self.be.sourcedir, "build"))
+        assert not self._pathexists(self.be.builddir)
diff --git a/lib/toaster/bldcontrol/tests.py b/lib/toaster/bldcontrol/tests.py
index ebe477d..4577c3f 100644
--- a/lib/toaster/bldcontrol/tests.py
+++ b/lib/toaster/bldcontrol/tests.py
@@ -7,46 +7,114 @@ Replace this with more appropriate tests for your application.
 
 from django.test import TestCase
 
-from bldcontrol.bbcontroller import LocalhostBEController, BitbakeController
+from bldcontrol.bbcontroller import BitbakeController
+from bldcontrol.localhostbecontroller import LocalhostBEController
+from bldcontrol.sshbecontroller import SSHBEController
 from bldcontrol.models import BuildEnvironment, BuildRequest
 from bldcontrol.management.commands.runbuilds import Command
 
 import socket
 import subprocess
 
-class LocalhostBEControllerTests(TestCase):
-    def test_StartAndStopServer(self):
-        obe = BuildEnvironment.objects.create(lock = BuildEnvironment.LOCK_FREE, betype = BuildEnvironment.TYPE_LOCAL)
-        lbc = LocalhostBEController(obe)
+# standard poky data hardcoded for testing
+BITBAKE_LAYERS = [type('bitbake_info', (object,), { "giturl": "git://git.yoctoproject.org/poky.git", "dirpath": "", "commit": "HEAD"})]
+POKY_LAYERS = [
+    type('poky_info', (object,), { "name": "meta", "giturl": "git://git.yoctoproject.org/poky.git", "dirpath": "meta", "commit": "HEAD"}),
+    type('poky_info', (object,), { "name": "meta-yocto", "giturl": "git://git.yoctoproject.org/poky.git", "dirpath": "meta-yocto", "commit": "HEAD"}),
+    type('poky_info', (object,), { "name": "meta-yocto-bsp", "giturl": "git://git.yoctoproject.org/poky.git", "dirpath": "meta-yocto-bsp", "commit": "HEAD"}),
+    ]
+
 
-        # test start server and stop
-        self.assertTrue(socket.socket(socket.AF_INET, socket.SOCK_STREAM).connect_ex(('localhost', 8200)), "Port already occupied")
-        lbc.startBBServer()
-        self.assertFalse(socket.socket(socket.AF_INET, socket.SOCK_STREAM).connect_ex(('localhost', 8200)), "Server not answering")
 
-        lbc.stopBBServer()
-        self.assertTrue(socket.socket(socket.AF_INET, socket.SOCK_STREAM).connect_ex(('localhost', 8200)), "Server not stopped")
+# we have an abstract test class designed to ensure that the controllers use a single interface
+# specific controller tests only need to override the _getBuildEnvironment() method
 
-        # clean up
-        import subprocess
-        out, err = subprocess.Popen("netstat  -tapn 2>/dev/null | grep 8200 | awk '{print $7}' | sort -fu | cut -d \"/\" -f 1 | grep -v -- - | tee /dev/fd/2 | xargs -r kill", shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE).communicate()
+class BEControllerTests(object):
 
+    def _serverForceStop(self, bc):
+        err = bc._shellcmd("netstat  -tapn 2>/dev/null | grep 8200 | awk '{print $7}' | sort -fu | cut -d \"/\" -f 1 | grep -v -- - | tee /dev/fd/2 | xargs -r kill")
         self.assertTrue(err == '', "bitbake server pid %s not stopped" % err)
 
-        obe = BuildEnvironment.objects.create(lock = BuildEnvironment.LOCK_FREE, betype = BuildEnvironment.TYPE_LOCAL)
-        lbc = LocalhostBEController(obe)
+    def test_serverStartAndStop(self):
+        obe =  self._getBuildEnvironment()
+        bc = self._getBEController(obe)
+        bc.setLayers(BITBAKE_LAYERS, POKY_LAYERS) # setting layers, skip any layer info
+
+        hostname = self.test_address.split("@")[-1]
 
-        bbc = lbc.getBBController()
+        # test start server and stop
+        self.assertTrue(socket.socket(socket.AF_INET, socket.SOCK_STREAM).connect_ex((hostname, 8200)), "Port already occupied")
+        bc.startBBServer()
+        self.assertFalse(socket.socket(socket.AF_INET, socket.SOCK_STREAM).connect_ex((hostname, 8200)), "Server not answering")
+
+        bc.stopBBServer()
+        self.assertTrue(socket.socket(socket.AF_INET, socket.SOCK_STREAM).connect_ex((hostname, 8200)), "Server not stopped")
+
+        self._serverForceStop(bc)
+
+    def test_getBBController(self):
+        obe = self._getBuildEnvironment()
+        bc = self._getBEController(obe)
+        bc.setLayers(BITBAKE_LAYERS, POKY_LAYERS) # setting layers, skip any layer info
+
+        bbc = bc.getBBController()
         self.assertTrue(isinstance(bbc, BitbakeController))
-        # test set variable
+        # test set variable, use no build marker -1 for BR value
         try:
-            bbc.setVariable
+            bbc.setVariable("TOASTER_BRBE", "%d:%d" % (-1, obe.pk))
         except Exception as e :
             self.fail("setVariable raised %s", e)
 
-        lbc.stopBBServer()
-        out, err = subprocess.Popen("netstat  -tapn 2>/dev/null | grep 8200 | awk '{print $7}' | sort -fu | cut -d \"/\" -f 1 | grep -v -- - | tee /dev/fd/2 | xargs -r kill", shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE).communicate()
-        self.assertTrue(err == '', "bitbake server pid %s not stopped" % err)
+        bc.stopBBServer()
+
+        self._serverForceStop(bc)
+
+class LocalhostBEControllerTests(TestCase, BEControllerTests):
+    def __init__(self, *args):
+        super(LocalhostBEControllerTests, self).__init__(*args)
+        # hardcoded for Alex's machine; since the localhost BE is machine-dependent,
+        # I found no good way to abstractize this
+        self.test_sourcedir = "/home/ddalex/ssd/yocto"
+        self.test_builddir = "/home/ddalex/ssd/yocto/build"
+        self.test_address = "localhost"
+
+    def _getBuildEnvironment(self):
+        return BuildEnvironment.objects.create(
+                lock = BuildEnvironment.LOCK_FREE,
+                betype = BuildEnvironment.TYPE_LOCAL,
+                address = self.test_address,
+                sourcedir = self.test_sourcedir,
+                builddir = self.test_builddir )
+
+    def _getBEController(self, obe):
+        return LocalhostBEController(obe)
+
+class SSHBEControllerTests(TestCase, BEControllerTests):
+    def __init__(self, *args):
+        super(SSHBEControllerTests, self).__init__(*args)
+        self.test_address = "ddalex-desktop.local"
+        # hardcoded for ddalex-desktop.local machine; since the localhost BE is machine-dependent,
+        # I found no good way to abstractize this
+        self.test_sourcedir = "/home/ddalex/ssd/yocto"
+        self.test_builddir = "/home/ddalex/ssd/yocto/build"
+
+    def _getBuildEnvironment(self):
+        return BuildEnvironment.objects.create(
+                lock = BuildEnvironment.LOCK_FREE,
+                betype = BuildEnvironment.TYPE_SSH,
+                address = self.test_address,
+                sourcedir = self.test_sourcedir,
+                builddir = self.test_builddir )
+
+    def _getBEController(self, obe):
+        return SSHBEController(obe)
+
+    def test_pathExists(self):
+        obe = BuildEnvironment.objects.create(betype = BuildEnvironment.TYPE_SSH, address= self.test_address)
+        sbc = SSHBEController(obe)
+        self.assertTrue(sbc._pathexists("/"))
+        self.assertFalse(sbc._pathexists("/.deadbeef"))
+        self.assertTrue(sbc._pathexists(sbc._shellcmd("pwd")))
 
 
 class RunBuildsCommandTests(TestCase):
@@ -67,8 +135,8 @@ class RunBuildsCommandTests(TestCase):
         self.assertRaises(IndexError, command._selectBuildEnvironment)
 
     def test_br_select(self):
-        from orm.models import Project
-        p, created = Project.objects.get_or_create(pk=1)
+        from orm.models import Project, Release, BitbakeVersion
+        p = Project.objects.create_project("test", Release.objects.get_or_create(name = "HEAD", bitbake_version = BitbakeVersion.objects.get_or_create(name="HEAD", branch="HEAD")[0])[0])
         obr = BuildRequest.objects.create(state = BuildRequest.REQ_QUEUED, project = p)
         command = Command()
         br = command._selectBuildRequest()
-- 
1.9.1


