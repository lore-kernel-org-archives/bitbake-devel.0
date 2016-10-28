Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id 71DBB71DB1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Oct 2016 15:49:38 +0000 (UTC)
Received: from orsmga004.jf.intel.com ([10.7.209.38])
	by fmsmga104.fm.intel.com with ESMTP; 28 Oct 2016 08:49:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.31,410,1473145200"; d="scan'208";a="25205709"
Received: from linux.intel.com ([10.54.29.200])
	by orsmga004.jf.intel.com with ESMTP; 28 Oct 2016 08:49:39 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.68])
	by linux.intel.com (Postfix) with ESMTP id 09D1C6A4006;
	Fri, 28 Oct 2016 08:49:03 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 28 Oct 2016 18:48:44 +0300
Message-Id: <0227e288fe535ceae0d443b61bf1639ac8a8e874.1477669487.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <9f194bc2e4eb2c366782ae6ac9a111c6157d8b01.1477669486.git.ed.bartosh@linux.intel.com>
References: <9f194bc2e4eb2c366782ae6ac9a111c6157d8b01.1477669486.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1477669486.git.ed.bartosh@linux.intel.com>
References: <cover.1477669486.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 3/8] toaster: Delete useless bldcontrol/test
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
X-List-Received-Date: Fri, 28 Oct 2016 15:49:38 -0000

From: Michael Wood <michael.g.wood@intel.com>

It doesn't work nor does it test anything useful

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/bldcontrol/tests.py | 141 ----------------------------------------
 1 file changed, 141 deletions(-)
 delete mode 100644 bitbake/lib/toaster/bldcontrol/tests.py

diff --git a/lib/toaster/bldcontrol/tests.py b/lib/toaster/bldcontrol/tests.py
deleted file mode 100644
index 475ac0a..0000000
--- a/lib/toaster/bldcontrol/tests.py
+++ /dev/null
@@ -1,141 +0,0 @@
-"""
-This file demonstrates writing tests using the unittest module. These will pass
-when you run "manage.py test".
-
-Replace this with more appropriate tests for your application.
-"""
-
-from django.test import TestCase
-
-from bldcontrol.bbcontroller import BitbakeController, BuildSetupException
-from bldcontrol.localhostbecontroller import LocalhostBEController
-from bldcontrol.models import BuildEnvironment, BuildRequest
-from bldcontrol.management.commands.runbuilds import Command
-
-import socket
-import subprocess
-import os
-
-# standard poky data hardcoded for testing
-BITBAKE_LAYER = type('bitbake_info', (object,), { "giturl": "git://git.yoctoproject.org/poky.git", "dirpath": "", "commit": "HEAD"})
-POKY_LAYERS = [
-    type('poky_info', (object,), { "name": "meta", "giturl": "git://git.yoctoproject.org/poky.git", "dirpath": "meta", "commit": "HEAD"}),
-    type('poky_info', (object,), { "name": "meta-yocto", "giturl": "git://git.yoctoproject.org/poky.git", "dirpath": "meta-yocto", "commit": "HEAD"}),
-    type('poky_info', (object,), { "name": "meta-yocto-bsp", "giturl": "git://git.yoctoproject.org/poky.git", "dirpath": "meta-yocto-bsp", "commit": "HEAD"}),
-    ]
-
-
-
-# we have an abstract test class designed to ensure that the controllers use a single interface
-# specific controller tests only need to override the _getBuildEnvironment() method
-
-test_sourcedir = os.getenv("TTS_SOURCE_DIR")
-test_builddir = os.getenv("TTS_BUILD_DIR")
-test_address = os.getenv("TTS_TEST_ADDRESS", "localhost")
-
-if test_sourcedir == None or test_builddir == None or test_address == None:
-    raise Exception("Please set TTTS_SOURCE_DIR, TTS_BUILD_DIR and TTS_TEST_ADDRESS")
-
-# The bb server will expect a toaster-pre.conf file to exist. If it doesn't exit then we make
-# an empty one here.
-open(test_builddir + 'conf/toaster-pre.conf', 'a').close()
-
-class BEControllerTests(object):
-
-    def _serverForceStop(self, bc):
-        err = bc._shellcmd("netstat  -tapn 2>/dev/null | grep 8200 | awk '{print $7}' | sort -fu | cut -d \"/\" -f 1 | grep -v -- - | tee /dev/fd/2 | xargs -r kill")
-        self.assertTrue(err == '', "bitbake server pid %s not stopped" % err)
-
-    def test_serverStartAndStop(self):
-        obe =  self._getBuildEnvironment()
-        bc = self._getBEController(obe)
-        try:
-            # setting layers, skip any layer info
-            bc.setLayers(BITBAKE_LAYER, POKY_LAYERS)
-        except NotImplementedError:
-            print("Test skipped due to command not implemented yet")
-            return True
-        # We are ok with the exception as we're handling the git already exists
-        except BuildSetupException:
-            pass
-
-        bc.pokydirname = test_sourcedir
-        bc.islayerset = True
-
-        hostname = test_address.split("@")[-1]
-
-        # test start server and stop
-        bc.startBBServer()
-
-        self.assertFalse(socket.socket(socket.AF_INET, socket.SOCK_STREAM).connect_ex((hostname, int(bc.be.bbport))), "Server not answering")
-
-        self._serverForceStop(bc)
-
-    def test_getBBController(self):
-        obe = self._getBuildEnvironment()
-        bc = self._getBEController(obe)
-        layerSet = False
-        try:
-            # setting layers, skip any layer info
-            layerSet = bc.setLayers(BITBAKE_LAYER, POKY_LAYERS)
-        except NotImplementedError:
-            print("Test skipped due to command not implemented yet")
-            return True
-        # We are ok with the exception as we're handling the git already exists
-        except BuildSetupException:
-            pass
-
-        bc.pokydirname = test_sourcedir
-        bc.islayerset = True
-
-        bbc = bc.getBBController()
-        self.assertTrue(isinstance(bbc, BitbakeController))
-
-        self._serverForceStop(bc)
-
-class LocalhostBEControllerTests(TestCase, BEControllerTests):
-    def __init__(self, *args):
-        super(LocalhostBEControllerTests, self).__init__(*args)
-
-
-    def _getBuildEnvironment(self):
-        return BuildEnvironment.objects.create(
-                lock = BuildEnvironment.LOCK_FREE,
-                betype = BuildEnvironment.TYPE_LOCAL,
-                address = test_address,
-                sourcedir = test_sourcedir,
-                builddir = test_builddir )
-
-    def _getBEController(self, obe):
-        return LocalhostBEController(obe)
-
-class RunBuildsCommandTests(TestCase):
-    def test_bec_select(self):
-        """
-        Tests that we can find and lock a build environment
-        """
-
-        obe = BuildEnvironment.objects.create(lock = BuildEnvironment.LOCK_FREE, betype = BuildEnvironment.TYPE_LOCAL)
-        command = Command()
-        bec = command._selectBuildEnvironment()
-
-        # make sure we select the object we've just built
-        self.assertTrue(bec.be.id == obe.id, "Environment is not properly selected")
-        # we have a locked environment
-        self.assertTrue(bec.be.lock == BuildEnvironment.LOCK_LOCK, "Environment is not locked")
-        # no more selections possible here
-        self.assertRaises(IndexError, command._selectBuildEnvironment)
-
-    def test_br_select(self):
-        from orm.models import Project, Release, BitbakeVersion, Branch
-        p = Project.objects.create_project("test", Release.objects.get_or_create(name = "HEAD", bitbake_version = BitbakeVersion.objects.get_or_create(name="HEAD", branch=Branch.objects.get_or_create(name="HEAD"))[0])[0])
-        obr = BuildRequest.objects.create(state = BuildRequest.REQ_QUEUED, project = p)
-        command = Command()
-        br = command._selectBuildRequest()
-
-        # make sure we select the object we've just built
-        self.assertTrue(obr.id == br.id, "Request is not properly selected")
-        # we have a locked environment
-        self.assertTrue(br.state == BuildRequest.REQ_INPROGRESS, "Request is not updated")
-        # no more selections possible here
-        self.assertRaises(IndexError, command._selectBuildRequest)
-- 
2.1.4


