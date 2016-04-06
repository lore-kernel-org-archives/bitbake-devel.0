Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f43.google.com (mail-wm0-f43.google.com [74.125.82.43])
	by mail.openembedded.org (Postfix) with ESMTP id 257F9770B4
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Apr 2016 16:47:15 +0000 (UTC)
Received: by mail-wm0-f43.google.com with SMTP id f198so81797686wme.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 06 Apr 2016 09:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
	:references; bh=tCuIt96RZeY7mAfkqp45IWYjzG1SG0OAdjuwvAXsgIs=;
	b=dTy6KjdMJHyiCT9e+R/s3F6WRvw9TpJlrOvjhWhNSouLRvViTKZXSJlHFuN4jkcZJh
	SHIkY1kOcSfSMjMSXORD18HH4yMetFKm0a4rTPs3Ty9lTBnIMWAMb42uNLnkunKCNuoR
	2ez6CFxY0O18oUwnr+GN/H3Gph7VwRso47lKOyJMf69dN57hwHqx++YTncKIikd6KlJ0
	DGEXXHr+AhUkGoIyr2woR2mK38zJtpFuKg+qZ1KstvGsknVOPvMlZ/Nh5TtNPyI9eRS8
	yYW2wtYebzg5G8pgM/k2eanCTlf0HB9+vrzEantDzDm1LYTYSwE23wk5o4QXhlMieky8
	emJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=tCuIt96RZeY7mAfkqp45IWYjzG1SG0OAdjuwvAXsgIs=;
	b=OQAw0KUj2Yedy664XwJIAAf0ru6extCEGcCuYh9YEme/As+Vdxy3woLOfK4/SlWf69
	mNo04Mhi5uvxaSGFdUVtp4QPtubmlJBWmf+hVMZIbD2UToxuzoGw9vppGCXNrLquG++V
	ropUm/h4ZY1iDoL7pRB6xhi79s+yhjeTrRMbL8IfnumlnHMqzprpYV1ySEyVa0HxITNm
	srcROTg9m05AdaK72RYqWq6c13yMaxVIc9axh9ZX9Lx3Qsv98G9MLCnz0n3WNNngCU3Q
	f/NHw6tjS3LfF0+N6hB4i6RLVwJhI/658y7Ir15IlemZgqsKvOl+oX/qdLGRmIAAiRm2
	LZ9Q==
X-Gm-Message-State: AD7BkJI6VI4Zt1UCaZ3RfEX9NBjWzTyWp5CT4HgZhPocXb9vmGrqU5noVoo47BnxDDtZYvTM
X-Received: by 10.194.5.101 with SMTP id r5mr30105423wjr.47.1459961235720;
	Wed, 06 Apr 2016 09:47:15 -0700 (PDT)
Received: from draco.icx.intel.com ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id gt7sm4145345wjc.1.2016.04.06.09.47.14
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 06 Apr 2016 09:47:15 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  6 Apr 2016 17:46:18 +0100
Message-Id: <d328ea07be86dda721e8e5a52b00289c98bd92f7.1459960764.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
References: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1459960764.git.michael.g.wood@intel.com>
References: <cover.1459960764.git.michael.g.wood@intel.com>
Subject: [PATCH 08/38] toaster: remove startBBServer API
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
X-List-Received-Date: Wed, 06 Apr 2016 16:47:15 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

We still will have to run bitbake server, but it will be done
different way and the code will be in triggerBuild function.

Removed startBBServer API from BuildEnvironmentController and
LocalhostBEController classes.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/bldcontrol/bbcontroller.py          |  9 -------
 lib/toaster/bldcontrol/localhostbecontroller.py | 32 -------------------------
 2 files changed, 41 deletions(-)

diff --git a/lib/toaster/bldcontrol/bbcontroller.py b/lib/toaster/bldcontrol/bbcontroller.py
index f40103c..535a398 100644
--- a/lib/toaster/bldcontrol/bbcontroller.py
+++ b/lib/toaster/bldcontrol/bbcontroller.py
@@ -127,14 +127,6 @@ class BuildEnvironmentController(object):
         bblayerconffile.write("# line added by toaster build control\nBBLAYERS = \"" + " ".join(layerlist) + "\"")
         bblayerconffile.close()
 
-    def startBBServer(self):
-        """ Starts a  BB server with Toaster toasterui set up to record the builds, an no controlling UI.
-            After this method executes, self.be bbaddress/bbport MUST point to a running and free server,
-            and the bbstate MUST be  updated to "started".
-        """
-        raise NotImplementedError("FIXME: Must override in order to actually start the BB server")
-
-
     def setLayers(self, bitbake, ls):
         """ Checks-out bitbake executor and layers from git repositories.
             Sets the layer variables in the config file, after validating local layer paths.
@@ -151,7 +143,6 @@ class BuildEnvironmentController(object):
             starts if needed; or reconnects to the server if we can
         """
         if not self.connection:
-            self.startBBServer()
             self.be.lock = BuildEnvironment.LOCK_RUNNING
             self.be.save()
 
diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index 08419f2..7d6abe6 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -70,38 +70,6 @@ class LocalhostBEController(BuildEnvironmentController):
             logger.debug("localhostbecontroller: shellcmd success")
             return out
 
-    def startBBServer(self):
-        assert self.pokydirname and os.path.exists(self.pokydirname)
-        assert self.islayerset
-
-        # find our own toasterui listener/bitbake
-        from toaster.bldcontrol.management.commands.loadconf import _reduce_canon_path
-
-        toaster = _reduce_canon_path(os.path.join(os.path.dirname(os.path.abspath(__file__)), "../../../bin/toaster"))
-        assert os.path.exists(toaster) and os.path.isfile(toaster)
-
-        # restart bitbake server and toastergui observer
-        self._shellcmd("bash -c 'source %s restart-bitbake'" % toaster, self.be.builddir)
-        logger.debug("localhostbecontroller: restarted bitbake server")
-
-        # read port number from bitbake.lock
-        self.be.bbport = ""
-        bblock = os.path.join(self.be.builddir, 'bitbake.lock')
-        if os.path.exists(bblock):
-            with open(bblock) as fplock:
-                for line in fplock:
-                    if ":" in line:
-                        self.be.bbport = line.split(":")[-1].strip()
-                        logger.debug("localhostbecontroller: bitbake port %s", self.be.bbport)
-                        break
-
-        if not self.be.bbport:
-            raise BuildSetupException("localhostbecontroller: can't read bitbake port from %s" % bblock)
-
-        self.be.bbaddress = "localhost"
-        self.be.bbstate = BuildEnvironment.SERVER_STARTED
-        self.be.save()
-
     def getGitCloneDirectory(self, url, branch):
         """Construct unique clone directory name out of url and branch."""
         if branch != "HEAD":
-- 
2.1.4


