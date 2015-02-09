Return-Path: <alexandru.damian@intel.com>
Received: from mail-pd0-f181.google.com (mail-pd0-f181.google.com
	[209.85.192.181])
	by mail.openembedded.org (Postfix) with ESMTP id 91E42732BE
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Feb 2015 18:02:05 +0000 (UTC)
Received: by pdbfl12 with SMTP id fl12so8029278pdb.4
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 09 Feb 2015 10:02:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=WTFFGF4PY3X9cbjoXADKPV/wc5XeKiQWP/JhksETp7w=;
	b=McN6JYLiJoPTLXNz0Q3ghztVvVUy675359URW64eYvuXmdZc0L0I8MsrXGK5UMwCJb
	SJcSVyPqn9x2fSYKmvtJeJiSC/pb9DB11So0gSKKoxw4MmQlxh8jNHH2eAUohD8/rCUf
	tKy1NVtiT65w0XwHLOP/X619pTJdpH8m7Xyutz7/sEOlZPovYTrbCg/mHYYWKxASNiiE
	JfkmNMP0GkXspyE1u85i/fxDg2IYPX9LSr1gXi3fgfc+40kqsO2/QbcTIxEWX+i10ebf
	mDIzRl0pIQL/jBOY76tVfzrhc59TR5qJ4pHt7aZpnzmq9LD+da+mqS9s8f3Kg7hO0sQH
	KELQ==
X-Gm-Message-State: ALoCoQkJCpevzp667XgloatVRbAUQ3E+REuRngXYne5tnohOvX9RzTt0zCxIGLfwtHyzly/hULoV
X-Received: by 10.66.119.193 with SMTP id kw1mr21517144pab.64.1423504926484;
	Mon, 09 Feb 2015 10:02:06 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	tk7sm17123236pab.23.2015.02.09.10.02.03
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 09 Feb 2015 10:02:04 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 4ED2556619C; Mon,  9 Feb 2015 18:01:58 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Feb 2015 18:01:36 +0000
Message-Id: <f0faba8ef0f08c98ac4bddf5b3954d540820d215.1423504574.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <b7b1e64f650c9ea676714209b9d6e7efeca992be.1423504574.git.alexandru.damian@intel.com>
References: <b7b1e64f650c9ea676714209b9d6e7efeca992be.1423504574.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1423504574.git.alexandru.damian@intel.com>
References: <cover.1423504574.git.alexandru.damian@intel.com>
Subject: [PATCH 06/27] toastergui: improvements in layer selection logic
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
X-List-Received-Date: Mon, 09 Feb 2015 18:02:06 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch clearers and bring fixes for the layer selection
logic in order to enable information collected during build to be used
in configuring projects, specifically targeting the recipes
learned through the building process.

The patch also adds tests to verify the layer selection logic.

[YOCTO #7189]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/bldcontrol/bbcontroller.py          |  13 ---
 lib/toaster/bldcontrol/localhostbecontroller.py |  54 +++++++---
 lib/toaster/bldcontrol/sshbecontroller.py       |   2 +-
 lib/toaster/orm/models.py                       |  23 ++++-
 lib/toaster/orm/tests.py                        | 131 +++++++++++++++++++++++-
 lib/toaster/toastergui/templates/targets.html   |  14 +--
 lib/toaster/toastergui/views.py                 |  35 +++++--
 lib/toaster/toastermain/urls.py                 |   5 +
 8 files changed, 224 insertions(+), 53 deletions(-)

diff --git a/lib/toaster/bldcontrol/bbcontroller.py b/lib/toaster/bldcontrol/bbcontroller.py
index cf3f1fd..42675d3 100644
--- a/lib/toaster/bldcontrol/bbcontroller.py
+++ b/lib/toaster/bldcontrol/bbcontroller.py
@@ -81,19 +81,6 @@ def getBuildEnvironmentController(**kwargs):
         raise Exception("FIXME: Implement BEC for type %s" % str(be.betype))
 
 
-def _get_git_clonedirectory(url, branch):
-    """ Utility that returns the last component of a git path as directory
-    """
-    import re
-    components = re.split(r'[:\.\/]', url)
-    base = components[-2] if components[-1] == "git" else components[-1]
-
-    if branch != "HEAD":
-        return "_%s_%s.toaster_cloned" % (base, branch)
-
-    return base
-
-
 class BuildEnvironmentController(object):
     """ BuildEnvironmentController (BEC) is the abstract class that defines the operations that MUST
         or SHOULD be supported by a Build Environment. It is used to establish the framework, and must
diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index 47708d1..005c464 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -30,7 +30,7 @@ import subprocess
 
 from toastermain import settings
 
-from bbcontroller import BuildEnvironmentController, ShellCmdException, BuildSetupException, _get_git_clonedirectory
+from bbcontroller import BuildEnvironmentController, ShellCmdException, BuildSetupException
 
 import logging
 logger = logging.getLogger("toaster")
@@ -54,6 +54,7 @@ class LocalhostBEController(BuildEnvironmentController):
         if cwd is None:
             cwd = self.be.sourcedir
 
+        #logger.debug("lbc_shellcmmd: (%s) %s" % (cwd, command))
         p = subprocess.Popen(command, cwd = cwd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
         (out,err) = p.communicate()
         p.wait()
@@ -62,7 +63,7 @@ class LocalhostBEController(BuildEnvironmentController):
                 err = "command: %s \n%s" % (command, out)
             else:
                 err = "command: %s \n%s" % (command, err)
-            #logger.debug("localhostbecontroller: shellcmd error %s" % err)
+            #logger.warn("localhostbecontroller: shellcmd error %s" % err)
             raise ShellCmdException(err)
         else:
             #logger.debug("localhostbecontroller: shellcmd success")
@@ -106,19 +107,12 @@ class LocalhostBEController(BuildEnvironmentController):
 
         logger.debug("localhostbecontroller: running the listener at %s" % own_bitbake)
 
-        try:
-            os.remove(os.path.join(self.be.builddir, "toaster_ui.log"))
-        except OSError as e:
-            import errno
-            if e.errno != errno.ENOENT:
-                raise
-
 
         cmd = "bash -c \"source %s/oe-init-build-env %s && bitbake --read conf/toaster-pre.conf --postread conf/toaster.conf --server-only -t xmlrpc -B 0.0.0.0:0 && DATABASE_URL=%s BBSERVER=0.0.0.0:-1 daemon -d -i -D %s -o toaster_ui.log -- %s --observe-only -u toasterui &\"" % (self.pokydirname, self.be.builddir,
                 self.dburl, self.be.builddir, own_bitbake)
-        logger.debug("fullcommand |%s| " % cmd)
         port = "-1"
-        for i in self._shellcmd(cmd).split("\n"):
+        cmdoutput = self._shellcmd(cmd)
+        for i in cmdoutput.split("\n"):
             if i.startswith("Bitbake server address"):
                 port = i.split(" ")[-1]
                 logger.debug("localhostbecontroller: Found bitbake server port %s" % port)
@@ -132,10 +126,17 @@ class LocalhostBEController(BuildEnvironmentController):
                         return True
             return False
 
-        while not _toaster_ui_started(os.path.join(self.be.builddir, "toaster_ui.log")):
+        retries = 0
+        started = False
+        while not started and retries < 10:
+            started = _toaster_ui_started(os.path.join(self.be.builddir, "toaster_ui.log"))
             import time
             logger.debug("localhostbecontroller: Waiting bitbake server to start")
             time.sleep(0.5)
+            retries += 1
+
+        if not started:
+            raise BuildSetupException("localhostbecontroller: Bitbake server did not start in 5 seconds, aborting (Error: '%s')" % (cmdoutput))
 
         logger.debug("localhostbecontroller: Started bitbake server")
 
@@ -163,6 +164,25 @@ class LocalhostBEController(BuildEnvironmentController):
         self.be.save()
         logger.debug("localhostbecontroller: Stopped bitbake server")
 
+    def getGitCloneDirectory(self, url, branch):
+        """ Utility that returns the last component of a git path as directory
+        """
+        import re
+        components = re.split(r'[:\.\/]', url)
+        base = components[-2] if components[-1] == "git" else components[-1]
+
+        if branch != "HEAD":
+            return "_%s_%s.toaster_cloned" % (base, branch)
+
+
+        # word of attention; this is a localhost-specific issue; only on the localhost we expect to have "HEAD" releases
+        # which _ALWAYS_ means the current poky checkout
+        from os.path import dirname as DN
+        local_checkout_path = DN(DN(DN(DN(DN(os.path.abspath(__file__))))))
+        #logger.debug("localhostbecontroller: using HEAD checkout in %s" % local_checkout_path)
+        return local_checkout_path
+
+
     def setLayers(self, bitbakes, layers):
         """ a word of attention: by convention, the first layer for any build will be poky! """
 
@@ -208,15 +228,17 @@ class LocalhostBEController(BuildEnvironmentController):
 
         layerlist = []
 
+
         # 3. checkout the repositories
         for giturl, commit in gitrepos.keys():
-            localdirname = os.path.join(self.be.sourcedir, _get_git_clonedirectory(giturl, commit))
+            localdirname = os.path.join(self.be.sourcedir, self.getGitCloneDirectory(giturl, commit))
             logger.debug("localhostbecontroller: giturl %s:%s checking out in current directory %s" % (giturl, commit, localdirname))
 
             # make sure our directory is a git repository
             if os.path.exists(localdirname):
-                if not giturl in self._shellcmd("git remote -v", localdirname):
-                    raise BuildSetupException("Existing git repository at %s, but with different remotes (not '%s'). Aborting." % (localdirname, giturl))
+                localremotes = self._shellcmd("git remote -v", localdirname)
+                if not giturl in localremotes:
+                    raise BuildSetupException("Existing git repository at %s, but with different remotes ('%s', expected '%s'). Toaster will not continue out of fear of damaging something." % (localdirname, ", ".join(localremotes.split("\n")), giturl))
             else:
                 if giturl in cached_layers:
                     logger.debug("localhostbecontroller git-copying %s to %s" % (cached_layers[giturl], localdirname))
@@ -230,7 +252,7 @@ class LocalhostBEController(BuildEnvironmentController):
             # branch magic name "HEAD" will inhibit checkout
             if commit != "HEAD":
                 logger.debug("localhostbecontroller: checking out commit %s to %s " % (commit, localdirname))
-                self._shellcmd("git fetch --all && git checkout \"%s\"" % commit , localdirname)
+                self._shellcmd("git fetch --all && git checkout \"%s\" && git pull --rebase" % (commit) , localdirname)
 
             # take the localdirname as poky dir if we can find the oe-init-build-env
             if self.pokydirname is None and os.path.exists(os.path.join(localdirname, "oe-init-build-env")):
diff --git a/lib/toaster/bldcontrol/sshbecontroller.py b/lib/toaster/bldcontrol/sshbecontroller.py
index be797c9..11ad08d 100644
--- a/lib/toaster/bldcontrol/sshbecontroller.py
+++ b/lib/toaster/bldcontrol/sshbecontroller.py
@@ -29,7 +29,7 @@ import subprocess
 
 from toastermain import settings
 
-from bbcontroller import BuildEnvironmentController, ShellCmdException, BuildSetupException, _get_git_clonedirectory
+from bbcontroller import BuildEnvironmentController, ShellCmdException, BuildSetupException
 
 def DN(path):
     return "/".join(path.split("/")[0:-1])
diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 5eff955..454f369 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -103,7 +103,7 @@ class Project(models.Model):
         if release == None:
             release = self.release
         # layers on the same branch or layers specifically set for this project
-        queryset = Layer_Version.objects.filter((Q(up_branch__name = release.branch_name) & Q(project = None)) | Q(project = self))
+        queryset = Layer_Version.objects.filter((Q(up_branch__name = release.branch_name) & Q(project = None)) | Q(project = self) | Q(build__project = self))
         if layer_name is not None:
             # we select only a layer name
             queryset = queryset.filter(layer__name = layer_name)
@@ -952,11 +952,24 @@ class Layer_Version(models.Model):
         """ Returns an ordered layerversion list that satisfies a LayerVersionDependency using the layer name and the current Project Releases' LayerSource priority """
         def _get_ls_priority(ls):
             try:
+                # if there is no layer source, we have minus infinite priority, as we don't want this layer selected
+                if ls == None:
+                    return -10000
                 return ls.releaselayersourcepriority_set.get(release=project.release).priority
             except ReleaseLayerSourcePriority.DoesNotExist:
                 raise
+
+        # layers created for this project, or coming from a build inthe project
+        query = Q(project = project) | Q(build__project = project)
+        if self.up_branch is not None:
+            # the same up_branch name
+            query |= Q(up_branch__name=self.up_branch.name)
+        else:
+            # or we have a layer in the project that's similar to mine (See the layer.name constraint below)
+            query |= Q(projectlayer__project=project)
+
         return sorted(
-                Layer_Version.objects.filter( layer__name = self.layer.name, up_branch__name = self.up_branch.name ),
+                Layer_Version.objects.filter(layer__name = self.layer.name).filter(query).select_related('layer_source', 'layer'),
                 key = lambda x: _get_ls_priority(x.layer_source),
                 reverse = True)
 
@@ -965,10 +978,12 @@ class Layer_Version(models.Model):
             return self.commit
         if self.branch is not None and len(self.branch) > 0:
             return self.branch
-        return self.up_branch.name
+        if self.up_branch is not None:
+            return self.up_branch.name
+        raise Exception("Cannot determine the vcs_reference for layer version %s" % vars(self))
 
     def __unicode__(self):
-        return  str(self.layer) + " (" + self.commit +")"
+        return  str(self.layer) + "(%s,%s)" % (self.get_vcs_reference(), self.build.project if self.build is not None else "None")
 
     class Meta:
         unique_together = ("layer_source", "up_id")
diff --git a/lib/toaster/orm/tests.py b/lib/toaster/orm/tests.py
index b965d8e..7b1b963 100644
--- a/lib/toaster/orm/tests.py
+++ b/lib/toaster/orm/tests.py
@@ -2,6 +2,12 @@ from django.test import TestCase
 from orm.models import LocalLayerSource, LayerIndexLayerSource, ImportedLayerSource, LayerSource
 from orm.models import Branch
 
+from orm.models import Project, Build, Layer, Layer_Version, Branch, ProjectLayer
+from orm.models import Release, ReleaseLayerSourcePriority, BitbakeVersion
+
+from django.utils import timezone
+
+# tests to verify inheritance for the LayerSource proxy-inheritance classes
 class LayerSourceVerifyInheritanceSaveLoad(TestCase):
     def test_object_creation(self):
         lls = LayerSource.objects.create(name = "a1", sourcetype = LayerSource.TYPE_LOCAL, apiurl = "")
@@ -23,7 +29,7 @@ class LayerSourceVerifyInheritanceSaveLoad(TestCase):
         self.assertRaises(Exception, duplicate)
 
 
-
+# test to verify the layer source update functionality for layerindex. edit to pass the URL to a layerindex application
 class LILSUpdateTestCase(TestCase):
     def test_update(self):
         lils = LayerSource.objects.create(name = "b1", sourcetype = LayerSource.TYPE_LAYERINDEX, apiurl = "http://adamian-desk.local:8080/layerindex/api/")
@@ -34,3 +40,126 @@ class LILSUpdateTestCase(TestCase):
 
         # print vars(lils)
         #print map(lambda x: vars(x), Branch.objects.all())
+
+        # run asserts
+        self.assertTrue(lils.branch_set.all().count() > 0, "update() needs to fetch some branches")
+
+
+
+# tests to verify layer_version priority selection
+class LayerVersionEquivalenceTestCase(TestCase):
+    def setUp(self):
+        # create layer sources
+        ls = LayerSource.objects.create(name = "dummy-layersource", sourcetype = LayerSource.TYPE_LOCAL)
+
+        # create bitbake version
+        bbv = BitbakeVersion.objects.create(name="master", giturl="git://git.openembedded.org/bitbake")
+        # create release
+        release = Release.objects.create(name="default-release", bitbake_version = bbv, branch_name = "master")
+        # attach layer source to release
+        ReleaseLayerSourcePriority.objects.create(release = release, layer_source = ls, priority = 1)
+
+        # create layer attach
+        self.layer = Layer.objects.create(name="meta-testlayer", layer_source = ls)
+        # create branch
+        self.branch = Branch.objects.create(name="master", layer_source = ls)
+
+        # set a layer version for the layer on the specified branch
+        self.layerversion = Layer_Version.objects.create(layer = self.layer, layer_source = ls, up_branch = self.branch)
+
+        # create spoof layer that should not appear in the search results
+        Layer_Version.objects.create(layer = Layer.objects.create(name="meta-notvalid", layer_source = ls), layer_source = ls, up_branch = self.branch)
+
+
+        # create a project ...
+        self.project = Project.objects.create_project(name="test-project", release = release)
+        # ... and set it up with a single layer version
+        ProjectLayer.objects.create(project=  self.project, layercommit = self.layerversion)
+
+    def test_single_layersource(self):
+        # when we have a single layer version, get_equivalents_wpriority() should return a list with just this layer_version
+        equivalent_list = self.layerversion.get_equivalents_wpriority(self.project)
+        self.assertTrue(len(equivalent_list) == 1)
+        self.assertTrue(equivalent_list[0] == self.layerversion)
+
+    def test_dual_layersource(self):
+        # if we have two layers with the same name, from different layer sources, we expect both layers in, in increasing priority of the layer source
+        ls2 = LayerSource.objects.create(name = "dummy-layersource2", sourcetype = LayerSource.TYPE_LOCAL)
+
+        # assign a lower priority for the second layer source
+        Release.objects.get(name="default-release").releaselayersourcepriority_set.create(layer_source = ls2, priority = 2)
+
+        # create a new layer_version for a layer with the same name coming from the second layer source
+        self.layer2 = Layer.objects.create(name="meta-testlayer", layer_source = ls2)
+        self.layerversion2 = Layer_Version.objects.create(layer = self.layer2, layer_source = ls2, up_branch = self.branch)
+
+        # expect two layer versions, in the priority order
+        equivalent_list = self.layerversion.get_equivalents_wpriority(self.project)
+        self.assertTrue(len(equivalent_list) == 2)
+        self.assertTrue(equivalent_list[0] == self.layerversion2)
+        self.assertTrue(equivalent_list[1] == self.layerversion)
+
+    def test_build_layerversion(self):
+        # any layer version coming from the build should show up before any layer version coming from upstream
+        build = Build.objects.create(project = self.project, started_on = timezone.now(), completed_on = timezone.now())
+        self.layerversion_build = Layer_Version.objects.create(layer = self.layer, build = build, commit = "deadbeef")
+
+        # a build layerversion must be in the equivalence list for the original layerversion
+        equivalent_list = self.layerversion.get_equivalents_wpriority(self.project)
+        self.assertTrue(len(equivalent_list) == 2)
+        self.assertTrue(equivalent_list[0] == self.layerversion)
+        self.assertTrue(equivalent_list[1] == self.layerversion_build)
+
+        # getting the build layerversion equivalent list must return the same list as the original layer
+        build_equivalent_list = self.layerversion_build.get_equivalents_wpriority(self.project)
+
+        self.assertTrue(equivalent_list == build_equivalent_list, "%s is not %s" % (equivalent_list, build_equivalent_list))
+
+class ProjectLVSelectionTestCase(TestCase):
+    def setUp(self):
+        # create layer sources
+        ls = LayerSource.objects.create(name = "dummy-layersource", sourcetype = LayerSource.TYPE_LOCAL)
+
+        # create bitbake version
+        bbv = BitbakeVersion.objects.create(name="master", giturl="git://git.openembedded.org/bitbake")
+        # create release
+        release = Release.objects.create(name="default-release", bitbake_version = bbv, branch_name="master")
+        # attach layer source to release
+        ReleaseLayerSourcePriority.objects.create(release = release, layer_source = ls, priority = 1)
+
+        # create layer attach
+        self.layer = Layer.objects.create(name="meta-testlayer", layer_source = ls)
+        # create branch
+        self.branch = Branch.objects.create(name="master", layer_source = ls)
+
+        # set a layer version for the layer on the specified branch
+        self.layerversion = Layer_Version.objects.create(layer = self.layer, layer_source = ls, up_branch = self.branch)
+
+
+        # create a project ...
+        self.project = Project.objects.create_project(name="test-project", release = release)
+        # ... and set it up with a single layer version
+        ProjectLayer.objects.create(project=  self.project, layercommit = self.layerversion)
+
+    def test_single_layersource(self):
+        compatible_layerversions = self.project.compatible_layerversions()
+        self.assertTrue(len(compatible_layerversions) == 1)
+        self.assertTrue(compatible_layerversions[0] == self.layerversion)
+
+
+    def test_dual_layersource(self):
+         # if we have two layers with the same name, from different layer sources, we expect both layers in, in increasing priority of the layer source
+        ls2 = LayerSource.objects.create(name = "dummy-layersource2", sourcetype = LayerSource.TYPE_LOCAL)
+
+        # assign a lower priority for the second layer source
+        Release.objects.get(name="default-release").releaselayersourcepriority_set.create(layer_source = ls2, priority = 2)
+
+        # create a new layer_version for a layer with the same name coming from the second layer source
+        self.layer2 = Layer.objects.create(name="meta-testlayer", layer_source = ls2)
+        self.layerversion2 = Layer_Version.objects.create(layer = self.layer2, layer_source = ls2, up_branch = self.branch)
+
+         # expect two layer versions, in the priority order
+        equivalent_list = self.project.compatible_layerversions()
+        self.assertTrue(len(equivalent_list) == 2)
+        self.assertTrue(equivalent_list[0] == self.layerversion2)
+        self.assertTrue(equivalent_list[1] == self.layerversion)
diff --git a/lib/toaster/toastergui/templates/targets.html b/lib/toaster/toastergui/templates/targets.html
index 590ecb9..3038649 100644
--- a/lib/toaster/toastergui/templates/targets.html
+++ b/lib/toaster/toastergui/templates/targets.html
@@ -52,11 +52,11 @@
         </td>
         <td class="target-section">{{o.section}}</td>
         <td class="license">{{o.license}}</td>
-        <td class="layer"><a href="{% url 'layerdetails' o.layer_version.id%}">{{o.layer_version.layer.name}}</a></td>
-        <td class="source">{{o.layer_source.name}}</td>
+        <td class="layer"><a href="{% url 'layerdetails' o.preffered_layerversion.id%}">{{o.preffered_layerversion.layer.name}}</a></td>
+        <td class="source">{{o.preffered_layerversion.layer_source.name}}</td>
         <td class="branch">
-        {% if o.layer_version.up_branch %}
-            {{o.layer_version.up_branch.name}}
+        {% if o.preffered_layerversion.up_branch %}
+            {{o.preffered_layerversion.up_branch.name}}
         {% else %}
         <a class="btn"
                 data-content="<ul class='unstyled'>
@@ -66,15 +66,15 @@
             </a>
             {% endif %}
         </td>
-        <td class="add-layer" value="{{o.pk}}" layerversion_id="{{o.layer_version.pk}}">
+        <td class="add-layer" value="{{o.pk}}" layerversion_id="{{o.preffered_layerversion.pk}}">
             <div id="layer-tooltip-{{o.pk}}" style="display: none; font-size: 11px; line-height: 1.3;" class="tooltip-inner">layer was modified</div>
             <a href="{% url 'project' project.id %}#/targetbuild={{o.name}}" id="target-build-{{o.pk}}" class="btn btn-block remove-layer" style="display:none;" >
                 Build target
             </a>
-            <a id="layer-add-{{o.pk}}" class="btn btn-block" style="display:none;" href="javascript:layerAdd({{o.layer_version.pk}}, '{{o.layer_version.layer.name}}', '{%url 'layerdetails' o.layer_version.pk%}', {{o.pk}})" >
+            <a id="layer-add-{{o.pk}}" class="btn btn-block" style="display:none;" href="javascript:layerAdd({{o.preffered_layerversion.pk}}, '{{o.preffered_layerversion.layer.name}}', '{%url 'layerdetails' o.preffered_layerversion.pk%}', {{o.pk}})" >
                 <i class="icon-plus"></i>
                 Add layer
-                <i title="" class="icon-question-sign get-help" data-original-title="To build this target, you must first add the {{o.layer_version.layer.name}} layer to your project"></i>
+                <i title="" class="icon-question-sign get-help" data-original-title="To build this target, you must first add the {{o.preffered_layerversion.layer.name}} layer to your project"></i>
             </a>
         </td>
     </tr>
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 6ccbf54..7353844 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -22,7 +22,7 @@
 import operator,re
 import HTMLParser
 
-from django.db.models import Q, Sum, Count
+from django.db.models import Q, Sum, Count, Max
 from django.db import IntegrityError
 from django.shortcuts import render, redirect
 from orm.models import Build, Target, Task, Layer, Layer_Version, Recipe, LogMessage, Variable
@@ -236,7 +236,7 @@ def _get_queryset(model, queryset, filter_string, search_term, ordering_string,
     if search_term:
         queryset = _get_search_results(search_term, queryset, model)
 
-    if ordering_string and queryset:
+    if ordering_string:
         column, order = ordering_string.split(':')
         if column == re.sub('-','',ordering_secondary):
             ordering_secondary=''
@@ -2046,7 +2046,7 @@ if toastermain.settings.MANAGED:
                         "url": x.layercommit.layer.layer_index_url,
                         "layerdetailurl": reverse("layerdetails", args=(x.layercommit.pk,)),
                 # This branch name is actually the release
-                        "branch" : { "name" : x.layercommit.commit, "layersource" : x.layercommit.up_branch.layer_source.name}},
+                        "branch" : { "name" : x.layercommit.commit, "layersource" : x.layercommit.up_branch.layer_source.name if x.layercommit.up_branch != None else None}},
                     prj.projectlayer_set.all().order_by("id")),
             "targets" : map(lambda x: {"target" : x.target, "task" : x.task, "pk": x.pk}, prj.projecttarget_set.all()),
             "freqtargets": freqtargets,
@@ -2243,11 +2243,11 @@ if toastermain.settings.MANAGED:
 
             # returns layer versions that provide the named targets
             if request.GET['type'] == "layers4target":
-                # we returnd ata only if the recipe can't be provided by the current project layer set
-                if reduce(lambda x, y: x + y, [x.recipe_layer_version.filter(name="anki").count() for x in prj.projectlayer_equivalent_set()], 0):
+                # we return data only if the recipe can't be provided by the current project layer set
+                if reduce(lambda x, y: x + y, [x.recipe_layer_version.filter(name=request.GET['value']).count() for x in prj.projectlayer_equivalent_set()], 0):
                     final_list = []
                 else:
-                    queryset_all = prj.compatible_layerversions().filter(recipe_layer_version__name = request.GET.get('value', '__none__'))
+                    queryset_all = prj.compatible_layerversions().filter(recipe_layer_version__name = request.GET['value'])
 
                     # exclude layers in the project
                     queryset_all = queryset_all.exclude(pk__in = [x.id for x in prj.projectlayer_equivalent_set()])
@@ -2259,14 +2259,20 @@ if toastermain.settings.MANAGED:
 
             # returns targets provided by current project layers
             if request.GET['type'] == "targets":
-                queryset_all = Recipe.objects.all()
+                queryset_all = Recipe.objects.filter(name__icontains=request.GET.get('value',''))
                 layer_equivalent_set = []
                 for i in prj.projectlayer_set.all():
                     layer_equivalent_set += i.layercommit.get_equivalents_wpriority(prj)
                 queryset_all = queryset_all.filter(layer_version__in =  layer_equivalent_set)
+
+                # if we have more than one hit here (for distinct name and version), max the id it out
+                queryset_all_maxids = queryset_all.values('name').distinct().annotate(max_id=Max('id')).values_list('max_id')
+                queryset_all = queryset_all.filter(id__in = queryset_all_maxids)
+
+
                 return HttpResponse(jsonfilter({ "error":"ok",
-                    "list" : map ( lambda x: {"id": x.pk, "name": x.name, "detail":"[" + x.layer_version.layer.name+ (" | " + x.layer_version.up_branch.name + "]" if x.layer_version.up_branch is not None else "]")},
-                        queryset_all.filter(name__icontains=request.GET.get('value',''))[:8]),
+                    "list" : map ( lambda x: {"id": x.pk, "name": x.name, "detail":"[" + x.layer_version.layer.name + (" | " + x.layer_version.up_branch.name + "]" if x.layer_version.up_branch is not None else "]")},
+                        queryset_all[:8]),
 
                     }), content_type = "application/json")
 
@@ -2663,10 +2669,17 @@ if toastermain.settings.MANAGED:
 
         queryset_with_search = _get_queryset(Recipe, queryset_all, None, search_term, ordering_string, '-name')
 
-        queryset_with_search.prefetch_related("layer_source")
+        # get unique values for 'name' and 'version', and select the maximum ID for each entry (the max id is the newest one)
+        queryset_with_search_maxids = queryset_with_search.values('name').distinct().annotate(max_id=Max('id')).values_list('max_id')
+
+        queryset_with_search = queryset_with_search.filter(id__in=queryset_with_search_maxids).select_related('layer_version', 'layer_version__layer')
+
+        objects = list(queryset_with_search)
+        for e in objects:
+            e.preffered_layerversion = e.layer_version.get_equivalents_wpriority(prj)[0]
 
         # retrieve the objects that will be displayed in the table; targets a paginator and gets a page range to display
-        target_info = _build_page_range(Paginator(queryset_with_search, request.GET.get('count', 10)),request.GET.get('page', 1))
+        target_info = _build_page_range(Paginator(objects, request.GET.get('count', 10)),request.GET.get('page', 1))
 
 
         context = {
diff --git a/lib/toaster/toastermain/urls.py b/lib/toaster/toastermain/urls.py
index a2916e2..6112067 100644
--- a/lib/toaster/toastermain/urls.py
+++ b/lib/toaster/toastermain/urls.py
@@ -48,6 +48,11 @@ import toastermain.settings
 if toastermain.settings.FRESH_ENABLED:
     urlpatterns.insert(1, url(r'', include('fresh.urls')))
 
+if toastermain.settings.DEBUG_PANEL_ENABLED:
+    import debug_toolbar
+    urlpatterns.insert(1, url(r'', include(debug_toolbar.urls)))
+
+
 if toastermain.settings.MANAGED:
     urlpatterns = [
         # Uncomment the next line to enable the admin:
-- 
1.9.1


