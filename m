Return-Path: <alexandru.damian@intel.com>
Received: from mail-pa0-f46.google.com (mail-pa0-f46.google.com
	[209.85.220.46])
	by mail.openembedded.org (Postfix) with ESMTP id 5833066122
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 30 Jan 2015 14:28:33 +0000 (UTC)
Received: by mail-pa0-f46.google.com with SMTP id lj1so52894738pab.5
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 30 Jan 2015 06:28:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=UgEnkDWlM87JCM4ZN9EbSZvEDxTAxrKoUu6gJNvhRKY=;
	b=BTdyPKqFg6FtPyDn2oh3qxYq/FaCE8F36ifEUXBvJXPS3SRbtS4+soj5nfRf6at+XH
	5uy9sWXkP/gbHI8VwoX06rBRVD7vBfC68cVGfBvncgQYKgK8N9v74nkBE7Rse31Ep/7k
	yZ8hAALSJNEo/AL62Jrtv/ulp5aXKXW8B0vR3z7XslX2SAjqxinvkgLDYXGJ2tpomB3M
	8zGFXzbrEaUGA+UWNNJfvI7g/8rmlLBo97ZSKzgLnfVsyQkz1Wygo30PJaopdbl00Oox
	KzC07LQOTDNDTsmCVAmgTZh83gr9ohDEQQGrj1pW68qm4jWo7+xhLovvxLT5YfR2XI1z
	Tm6A==
X-Gm-Message-State: ALoCoQnwaSVN5sTXplxKv2Mh4CTPppaVDIypwli30Ao+Cy67f742BfuNfzQFfpO/0IXsujsxs5Qv
X-Received: by 10.66.63.2 with SMTP id c2mr9112757pas.23.1422628115166;
	Fri, 30 Jan 2015 06:28:35 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id tn2sm3221342pbc.15.2015.01.30.06.28.33
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 30 Jan 2015 06:28:34 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 9636D561F59; Fri, 30 Jan 2015 14:28:31 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 30 Jan 2015 14:28:30 +0000
Message-Id: <c6eb0f7f16c59530c2525b2e5629fe86de4e8f0f.1422627985.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <90ef8975f35e2da824bc1c80e41ca26d9af0b208.1422627985.git.alexandru.damian@intel.com>
References: <90ef8975f35e2da824bc1c80e41ca26d9af0b208.1422627985.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1422627985.git.alexandru.damian@intel.com>
References: <cover.1422627985.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 2/2] toaster: new layer checkout logic
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
X-List-Received-Date: Fri, 30 Jan 2015 14:28:35 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch implements a new layer checkout logic that brings more
flexibility in getting layers under different commits work with
Toaster.

The new hibrid logic will checkout separately each layer and commit id;
the task execution will be delegated to the checkedout bitbake, but the
data logger will be executed from the current toaster version as to
bring in enough data to sustain the updates in UI models.

[YOCTO #7171]
[YOCTO #6892]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/bldcontrol/bbcontroller.py             |  13 ++-
 lib/toaster/bldcontrol/localhostbecontroller.py    | 107 +++++++++++++++------
 .../bldcontrol/management/commands/runbuilds.py    |   7 +-
 lib/toaster/bldcontrol/sshbecontroller.py          |  58 +----------
 4 files changed, 92 insertions(+), 93 deletions(-)

diff --git a/lib/toaster/bldcontrol/bbcontroller.py b/lib/toaster/bldcontrol/bbcontroller.py
index 102606e..dbfb2f3 100644
--- a/lib/toaster/bldcontrol/bbcontroller.py
+++ b/lib/toaster/bldcontrol/bbcontroller.py
@@ -81,12 +81,17 @@ def getBuildEnvironmentController(**kwargs):
         raise Exception("FIXME: Implement BEC for type %s" % str(be.betype))
 
 
-def _getgitcheckoutdirectoryname(url):
+def _get_git_clonedirectory(url, branch):
     """ Utility that returns the last component of a git path as directory
     """
     import re
     components = re.split(r'[:\.\/]', url)
-    return components[-2] if components[-1] == "git" else components[-1]
+    base = components[-2] if components[-1] == "git" else components[-1]
+
+    if branch != "HEAD":
+        return "_%s_%s.toaster_cloned" % (base, branch)
+
+    return base
 
 
 class BuildEnvironmentController(object):
@@ -166,12 +171,12 @@ class BuildEnvironmentController(object):
         raise Exception("Must override setLayers")
 
 
-    def getBBController(self, brbe):
+    def getBBController(self):
         """ returns a BitbakeController to an already started server; this is the point where the server
             starts if needed; or reconnects to the server if we can
         """
         if not self.connection:
-            self.startBBServer(brbe)
+            self.startBBServer()
             self.be.lock = BuildEnvironment.LOCK_RUNNING
             self.be.save()
 
diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index 22d31e3..980751f 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -30,11 +30,12 @@ import subprocess
 
 from toastermain import settings
 
-from bbcontroller import BuildEnvironmentController, ShellCmdException, BuildSetupException, _getgitcheckoutdirectoryname
+from bbcontroller import BuildEnvironmentController, ShellCmdException, BuildSetupException, _get_git_clonedirectory
 
 import logging
 logger = logging.getLogger("toaster")
 
+from pprint import pprint, pformat
 
 class LocalhostBEController(BuildEnvironmentController):
     """ Implementation of the BuildEnvironmentController for the localhost;
@@ -55,15 +56,16 @@ class LocalhostBEController(BuildEnvironmentController):
 
         p = subprocess.Popen(command, cwd = cwd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
         (out,err) = p.communicate()
+        p.wait()
         if p.returncode:
             if len(err) == 0:
                 err = "command: %s \n%s" % (command, out)
             else:
                 err = "command: %s \n%s" % (command, err)
-            logger.debug("localhostbecontroller: shellcmd error %s" % err)
+            #logger.debug("localhostbecontroller: shellcmd error %s" % err)
             raise ShellCmdException(err)
         else:
-            logger.debug("localhostbecontroller: shellcmd success")
+            #logger.debug("localhostbecontroller: shellcmd success")
             return out
 
     def _createdirpath(self, path):
@@ -80,10 +82,19 @@ class LocalhostBEController(BuildEnvironmentController):
         self._createdirpath(self.be.builddir)
         self._shellcmd("bash -c \"source %s/oe-init-build-env %s\"" % (self.pokydirname, self.be.builddir))
 
-    def startBBServer(self, brbe):
+    def startBBServer(self):
         assert self.pokydirname and os.path.exists(self.pokydirname)
         assert self.islayerset
 
+        # find our own toasterui listener/bitbake
+        from toaster.bldcontrol.management.commands.loadconf import _reduce_canon_path
+
+        own_bitbake = _reduce_canon_path(os.path.join(os.path.dirname(os.path.abspath(__file__)), "../../../bin/bitbake"))
+
+        assert os.path.exists(own_bitbake) and os.path.isfile(own_bitbake)
+
+        logger.debug("localhostbecontroller: running the listener at %s" % own_bitbake)
+
         try:
             os.remove(os.path.join(self.be.builddir, "toaster_ui.log"))
         except OSError as e:
@@ -91,7 +102,10 @@ class LocalhostBEController(BuildEnvironmentController):
             if e.errno != errno.ENOENT:
                 raise
 
-        cmd = "bash -c \"source %s/oe-init-build-env %s && DATABASE_URL=%s source toaster start noweb brbe=%s\"" % (self.pokydirname, self.be.builddir, self.dburl, brbe)
+
+        cmd = "bash -c \"source %s/oe-init-build-env %s && bitbake --read conf/toaster-pre.conf --postread conf/toaster.conf --server-only -t xmlrpc -B 0.0.0.0:0 && DATABASE_URL=%s BBSERVER=0.0.0.0:-1 daemon -d -i -D %s -o toaster_ui.log -- %s --observe-only -u toasterui &\"" % (self.pokydirname, self.be.builddir,
+                self.dburl, self.be.builddir, own_bitbake)
+        logger.debug("fullcommand |%s| " % cmd)
         port = "-1"
         for i in self._shellcmd(cmd).split("\n"):
             if i.startswith("Bitbake server address"):
@@ -113,6 +127,16 @@ class LocalhostBEController(BuildEnvironmentController):
             time.sleep(0.5)
 
         logger.debug("localhostbecontroller: Started bitbake server")
+
+        while port == "-1":
+            # the port specification is "autodetect"; read the bitbake.lock file
+            with open("%s/bitbake.lock" % self.be.builddir, "r") as f:
+                for line in f.readlines():
+                    if ":" in line:
+                        port = line.split(":")[1].strip()
+                        logger.debug("localhostbecontroller: Autodetected bitbake port %s", port)
+                        break
+
         assert self.be.sourcedir and os.path.exists(self.be.builddir)
         self.be.bbaddress = "localhost"
         self.be.bbport = port
@@ -135,42 +159,62 @@ class LocalhostBEController(BuildEnvironmentController):
         assert len(bitbakes) == 1
         # set layers in the layersource
 
-        # 1. get a list of repos, and map dirpaths for each layer
+        # 1. get a list of repos with branches, and map dirpaths for each layer
         gitrepos = {}
-        gitrepos[bitbakes[0].giturl] = []
-        gitrepos[bitbakes[0].giturl].append( ("bitbake", bitbakes[0].dirpath, bitbakes[0].commit) )
+
+        gitrepos[(bitbakes[0].giturl, bitbakes[0].commit)] = []
+        gitrepos[(bitbakes[0].giturl, bitbakes[0].commit)].append( ("bitbake", bitbakes[0].dirpath) )
 
         for layer in layers:
             # we don't process local URLs
             if layer.giturl.startswith("file://"):
                 continue
-            if not layer.giturl in gitrepos:
-                gitrepos[layer.giturl] = []
-            gitrepos[layer.giturl].append( (layer.name, layer.dirpath, layer.commit))
-        for giturl in gitrepos.keys():
-            commitid = gitrepos[giturl][0][2]
-            for e in gitrepos[giturl]:
-                if commitid != e[2]:
-                    import pprint
-                    raise BuildSetupException("More than one commit per git url, unsupported configuration: \n%s" % pprint.pformat(gitrepos))
-
-
-        logger.debug("localhostbecontroller, our git repos are %s" % gitrepos)
+            if not (layer.giturl, layer.commit) in gitrepos:
+                gitrepos[(layer.giturl, layer.commit)] = []
+            gitrepos[(layer.giturl, layer.commit)].append( (layer.name, layer.dirpath) )
+
+
+        logger.debug("localhostbecontroller, our git repos are %s" % pformat(gitrepos))
+
+
+        # 2. find checked-out git repos in the sourcedir directory that may help faster cloning
+
+        cached_layers = {}
+        for ldir in os.listdir(self.be.sourcedir):
+            fldir = os.path.join(self.be.sourcedir, ldir)
+            if os.path.isdir(fldir):
+                try:
+                    for line in self._shellcmd("git remote -v", fldir).split("\n"):
+                        try:
+                            remote = line.split("\t")[1].split(" ")[0]
+                            if remote not in cached_layers:
+                                cached_layers[remote] = fldir
+                        except IndexError:
+                            pass
+                except ShellCmdException:
+                    # ignore any errors in collecting git remotes
+                    pass
+
         layerlist = []
 
-        # 2. checkout the repositories
-        for giturl in gitrepos.keys():
-            localdirname = os.path.join(self.be.sourcedir, _getgitcheckoutdirectoryname(giturl))
-            logger.debug("localhostbecontroller: giturl %s checking out in current directory %s" % (giturl, localdirname))
+        # 3. checkout the repositories
+        for giturl, commit in gitrepos.keys():
+            localdirname = os.path.join(self.be.sourcedir, _get_git_clonedirectory(giturl, commit))
+            logger.debug("localhostbecontroller: giturl %s:%s checking out in current directory %s" % (giturl, commit, localdirname))
 
             # make sure our directory is a git repository
             if os.path.exists(localdirname):
                 if not giturl in self._shellcmd("git remote -v", localdirname):
                     raise BuildSetupException("Existing git repository at %s, but with different remotes (not '%s'). Aborting." % (localdirname, giturl))
             else:
-                self._shellcmd("git clone \"%s\" \"%s\"" % (giturl, localdirname))
-            # checkout the needed commit
-            commit = gitrepos[giturl][0][2]
+                if giturl in cached_layers:
+                    logger.debug("localhostbecontroller git-copying %s to %s" % (cached_layers[giturl], localdirname))
+                    self._shellcmd("git clone \"%s\" \"%s\"" % (cached_layers[giturl], localdirname))
+                    self._shellcmd("git remote remove origin", localdirname)
+                    self._shellcmd("git remote add origin \"%s\"" % giturl, localdirname)
+                else:
+                    logger.debug("localhostbecontroller: cloning %s:%s in %s" % (giturl, commit, localdirname))
+                    self._shellcmd("git clone \"%s\" --single-branch --branch \"%s\" \"%s\"" % (giturl, commit, localdirname))
 
             # branch magic name "HEAD" will inhibit checkout
             if commit != "HEAD":
@@ -188,21 +232,22 @@ class LocalhostBEController(BuildEnvironmentController):
                     self._shellcmd("git clone -b \"%s\" \"%s\" \"%s\" " % (bitbakes[0].commit, bitbakes[0].giturl, os.path.join(self.pokydirname, 'bitbake')))
 
             # verify our repositories
-            for name, dirpath, commit in gitrepos[giturl]:
+            for name, dirpath in gitrepos[(giturl, commit)]:
                 localdirpath = os.path.join(localdirname, dirpath)
+                logger.debug("localhostbecontroller: localdirpath expected '%s'" % localdirpath)
                 if not os.path.exists(localdirpath):
                     raise BuildSetupException("Cannot find layer git path '%s' in checked out repository '%s:%s'. Aborting." % (localdirpath, giturl, commit))
 
                 if name != "bitbake":
                     layerlist.append(localdirpath.rstrip("/"))
 
-        logger.debug("localhostbecontroller: current layer list %s " % layerlist)
+        logger.debug("localhostbecontroller: current layer list %s " % pformat(layerlist))
 
-        # 3. configure the build environment, so we have a conf/bblayers.conf
+        # 4. configure the build environment, so we have a conf/bblayers.conf
         assert self.pokydirname is not None
         self._setupBE()
 
-        # 4. update the bblayers.conf
+        # 5. update the bblayers.conf
         bblayerconf = os.path.join(self.be.builddir, "conf/bblayers.conf")
         if not os.path.exists(bblayerconf):
             raise BuildSetupException("BE is not consistent: bblayers.conf file missing at %s" % bblayerconf)
diff --git a/lib/toaster/bldcontrol/management/commands/runbuilds.py b/lib/toaster/bldcontrol/management/commands/runbuilds.py
index bdce6ee..23ee855 100644
--- a/lib/toaster/bldcontrol/management/commands/runbuilds.py
+++ b/lib/toaster/bldcontrol/management/commands/runbuilds.py
@@ -2,7 +2,7 @@ from django.core.management.base import NoArgsCommand, CommandError
 from django.db import transaction
 from orm.models import Build
 from bldcontrol.bbcontroller import getBuildEnvironmentController, ShellCmdException, BuildSetupException
-from bldcontrol.models import BuildRequest, BuildEnvironment, BRError
+from bldcontrol.models import BuildRequest, BuildEnvironment, BRError, BRVariable
 import os
 import logging
 
@@ -47,6 +47,9 @@ class Command(NoArgsCommand):
                 return
 
             logger.debug("runbuilds: starting build %s, environment %s" % (br, bec.be))
+
+            # write the build identification variable
+            BRVariable.objects.create(req = br, name="TOASTER_BRBE", value="%d:%d" % (br.pk, bec.be.pk))
             # let the build request know where it is being executed
             br.environment = bec.be
             br.save()
@@ -56,7 +59,7 @@ class Command(NoArgsCommand):
             bec.writePreConfFile(br.brvariable_set.all())
 
             # get the bb server running with the build req id and build env id
-            bbctrl = bec.getBBController("%d:%d" % (br.pk, bec.be.pk))
+            bbctrl = bec.getBBController()
 
             # trigger the build command
             task = reduce(lambda x, y: x if len(y)== 0 else y, map(lambda y: y.task, br.brtarget_set.all()))
diff --git a/lib/toaster/bldcontrol/sshbecontroller.py b/lib/toaster/bldcontrol/sshbecontroller.py
index 45e1539..be797c9 100644
--- a/lib/toaster/bldcontrol/sshbecontroller.py
+++ b/lib/toaster/bldcontrol/sshbecontroller.py
@@ -29,7 +29,7 @@ import subprocess
 
 from toastermain import settings
 
-from bbcontroller import BuildEnvironmentController, ShellCmdException, BuildSetupException, _getgitcheckoutdirectoryname
+from bbcontroller import BuildEnvironmentController, ShellCmdException, BuildSetupException, _get_git_clonedirectory
 
 def DN(path):
     return "/".join(path.split("/")[0:-1])
@@ -124,62 +124,8 @@ class SSHBEController(BuildEnvironmentController):
         assert len(bitbakes) == 1
         # set layers in the layersource
 
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
-        layerlist = []
-
-        # 2. checkout the repositories
-        for giturl in gitrepos.keys():
-            import os
-            localdirname = os.path.join(self.be.sourcedir, _getgitcheckoutdirectoryname(giturl))
-            print "DEBUG: giturl ", giturl ,"checking out in current directory", localdirname
-
-            # make sure our directory is a git repository
-            if self._pathexists(localdirname):
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
-            if self.pokydirname is None and self._pathexists(os.path.join(localdirname, "oe-init-build-env")):
-                print "DEBUG: selected poky dir name", localdirname
-                self.pokydirname = localdirname
-
-            # verify our repositories
-            for name, dirpath, commit in gitrepos[giturl]:
-                localdirpath = os.path.join(localdirname, dirpath)
-                if not self._pathexists(localdirpath):
-                    raise BuildSetupException("Cannot find layer git path '%s' in checked out repository '%s:%s'. Aborting." % (localdirpath, giturl, commit))
-
-                if name != "bitbake":
-                    layerlist.append(localdirpath)
-
-        print "DEBUG: current layer list ", layerlist
 
+        raise Exception("Not implemented: SSH setLayers")
         # 3. configure the build environment, so we have a conf/bblayers.conf
         assert self.pokydirname is not None
         self._setupBE()
-- 
1.9.1


