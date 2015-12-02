Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
	[209.85.220.54])
	by mail.openembedded.org (Postfix) with ESMTP id 89E2E60616
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  2 Dec 2015 17:59:48 +0000 (UTC)
Received: by pacdm15 with SMTP id dm15so47009078pac.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 02 Dec 2015 09:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=VD7ReJe675hDB+Y2Z8Nb38mkUQ7ily7wRnUj3oeHtXs=;
	b=DB8vGYBp1XlCRFJ6OfMZ+RlHU0JUuAtMhXhu8+b35YIboLeVolPO9t8yv/Ttm0fsI2
	IBbuGHugXGd+XN53AEC7j+sKTMjtd091pRWu3DNIsblXn1Zof6L1DPdZ6fL7+Bbuxywj
	akRRk++QX+Ra25LhfyYtlOzXyMZSXIdLHO1rhKdcG5+IZCGTA211ubmEtrWMyWKW9WJS
	oPiIi35EkS7SHjYWq40t33wHoYcFJ33Sntu6D5TMRHdtBpq9wPllfQjhYpGsRnKNXKk8
	WcFvkIEvTHdExgkGolqh9wkBjRgNxFMj4pOMb+sWOoagIO+qvKfd1uMio4UBkE4EzdJ8
	quTQ==
X-Received: by 10.98.80.20 with SMTP id e20mr6443594pfb.23.1449079189610;
	Wed, 02 Dec 2015 09:59:49 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	e25sm5657267pfb.64.2015.12.02.09.59.48
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 02 Dec 2015 09:59:48 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  2 Dec 2015 10:02:48 -0800
Message-Id: <8b7c5b09886dbf3622c3a0ed8349e08f89735f18.1449078919.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <757ad75509219d7ce5afe9db3bb7524fde4a3809.1449078919.git.avery.brian@gmail.com>
References: <757ad75509219d7ce5afe9db3bb7524fde4a3809.1449078919.git.avery.brian@gmail.com>
In-Reply-To: <cover.1449078919.git.avery.brian@gmail.com>
References: <cover.1449078919.git.avery.brian@gmail.com>
Subject: [PATCH 16/30] toaster: remove stopBBServer API
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
X-List-Received-Date: Wed, 02 Dec 2015 17:59:48 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Removed stopBBServer API from build controller as toaster
doesn't stop bitbake server anymore. It's reused for both
types of builds: triggered by UI and started manually.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/bldcontrol/bbcontroller.py          |  6 ------
 lib/toaster/bldcontrol/localhostbecontroller.py |  9 ---------
 lib/toaster/bldcontrol/sshbecontroller.py       | 10 ----------
 lib/toaster/bldcontrol/tests.py                 |  4 ----
 4 files changed, 29 deletions(-)

diff --git a/lib/toaster/bldcontrol/bbcontroller.py b/lib/toaster/bldcontrol/bbcontroller.py
index ad70ac8..3d98ad7 100644
--- a/lib/toaster/bldcontrol/bbcontroller.py
+++ b/lib/toaster/bldcontrol/bbcontroller.py
@@ -140,12 +140,6 @@ class BuildEnvironmentController(object):
         """
         raise Exception("FIXME: Must override in order to actually start the BB server")
 
-    def stopBBServer(self):
-        """ Stops the currently running BB server.
-            The bbstate MUST be updated to "stopped".
-            self.connection must be none.
-        """
-        raise Exception("FIXME: Must override stoBBServer")
 
     def setLayers(self, bbs, ls):
         """ Checks-out bitbake executor and layers from git repositories.
diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index 44a9136..19afb1a 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -113,15 +113,6 @@ class LocalhostBEController(BuildEnvironmentController):
         self.be.bbstate = BuildEnvironment.SERVER_STARTED
         self.be.save()
 
-    def stopBBServer(self):
-        assert self.pokydirname and os.path.exists(self.pokydirname)
-        assert self.islayerset
-        self._shellcmd("bash -c \"source %s/oe-init-build-env %s && %s source toaster stop\"" %
-            (self.pokydirname, self.be.builddir, (lambda: "" if self.be.bbtoken is None else "BBTOKEN=%s" % self.be.bbtoken)()))
-        self.be.bbstate = BuildEnvironment.SERVER_STOPPED
-        self.be.save()
-        logger.debug("localhostbecontroller: Stopped bitbake server")
-
     def getGitCloneDirectory(self, url, branch):
         """Construct unique clone directory name out of url and branch."""
         if branch != "HEAD":
diff --git a/lib/toaster/bldcontrol/sshbecontroller.py b/lib/toaster/bldcontrol/sshbecontroller.py
index 8ef434b..17dd66c 100644
--- a/lib/toaster/bldcontrol/sshbecontroller.py
+++ b/lib/toaster/bldcontrol/sshbecontroller.py
@@ -98,16 +98,6 @@ class SSHBEController(BuildEnvironmentController):
         self.be.bbstate = BuildEnvironment.SERVER_STARTED
         self.be.save()
 
-    def stopBBServer(self):
-        assert self.pokydirname and self._pathexists(self.pokydirname)
-        assert self.islayerset
-        print self._shellcmd("bash -c \"source %s/oe-init-build-env %s && %s source toaster stop\"" %
-            (self.pokydirname, self.be.builddir, (lambda: "" if self.be.bbtoken is None else "BBTOKEN=%s" % self.be.bbtoken)()))
-        self.be.bbstate = BuildEnvironment.SERVER_STOPPED
-        self.be.save()
-        print "Stopped server"
-
-
     def _copyFile(self, filepath1, filepath2):
         p = subprocess.Popen("scp '%s' '%s'" % (filepath1, filepath2), stdout=subprocess.PIPE, stderr = subprocess.PIPE, shell=True)
         (out, err) = p.communicate()
diff --git a/lib/toaster/bldcontrol/tests.py b/lib/toaster/bldcontrol/tests.py
index 5dbc77f..f54cf7f 100644
--- a/lib/toaster/bldcontrol/tests.py
+++ b/lib/toaster/bldcontrol/tests.py
@@ -71,9 +71,6 @@ class BEControllerTests(object):
 
         self.assertFalse(socket.socket(socket.AF_INET, socket.SOCK_STREAM).connect_ex((hostname, int(bc.be.bbport))), "Server not answering")
 
-        bc.stopBBServer()
-        self.assertTrue(socket.socket(socket.AF_INET, socket.SOCK_STREAM).connect_ex((hostname, int(bc.be.bbport))), "Server not stopped")
-
         self._serverForceStop(bc)
 
     def test_getBBController(self):
@@ -96,7 +93,6 @@ class BEControllerTests(object):
 
         bbc = bc.getBBController()
         self.assertTrue(isinstance(bbc, BitbakeController))
-        bc.stopBBServer()
 
         self._serverForceStop(bc)
 
-- 
1.9.1


