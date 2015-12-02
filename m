Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f53.google.com (mail-pa0-f53.google.com
	[209.85.220.53])
	by mail.openembedded.org (Postfix) with ESMTP id 894206FF72
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  2 Dec 2015 17:59:46 +0000 (UTC)
Received: by padhx2 with SMTP id hx2so47140732pad.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 02 Dec 2015 09:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=0fS9UtWyjQKDzZGhtPP6qg+epjoND++Qxzk+RVPa07k=;
	b=oOEj4tYeka2+LsXAJisEre55EBLyYA1JSFTb1PljfPFwTTgmSEAT0xBWN5RjNvzWtj
	3Y+feDxaUvvH+b/3Ijj0MSl2rbF5BkYuds+HA1TlGB5ItiFxk/hLnJ4vluNYItCHbHMD
	ds8tK5KlN/N87+7X+7f9zaxt/C9tzWxilGXbvtPvv/PSgZwpY4SFnNw2Q3st1vvwuaXU
	xYjTByt/CxIoXKSg71Hf4Lou5pKiBlENF/IP5KvAmEpkbmHm8jbyp5jh0CZ717e6owQF
	RwjYEX0n3t5cDByDhzmdQrF3gK72CwZre2bUtSQhHxAY1I2e6GBTpZa52unOjdCXC4lI
	YjRQ==
X-Received: by 10.66.234.226 with SMTP id uh2mr6459925pac.6.1449079187016;
	Wed, 02 Dec 2015 09:59:47 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	e25sm5657267pfb.64.2015.12.02.09.59.45
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 02 Dec 2015 09:59:46 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  2 Dec 2015 10:02:46 -0800
Message-Id: <effb51349315f5e248294c2356d5d820ee92f16c.1449078919.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <757ad75509219d7ce5afe9db3bb7524fde4a3809.1449078919.git.avery.brian@gmail.com>
References: <757ad75509219d7ce5afe9db3bb7524fde4a3809.1449078919.git.avery.brian@gmail.com>
In-Reply-To: <cover.1449078919.git.avery.brian@gmail.com>
References: <cover.1449078919.git.avery.brian@gmail.com>
Subject: [PATCH 14/30] toaster: remove _setupBE function
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
X-List-Received-Date: Wed, 02 Dec 2015 17:59:46 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

This function is not needed as build environment is always created
because of the new way to run Toaster. It can be only sourced after
oe-init-build-env is sourced.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/bldcontrol/localhostbecontroller.py | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index 854a6bb..15c0ff9 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -70,17 +70,6 @@ class LocalhostBEController(BuildEnvironmentController):
             logger.debug("localhostbecontroller: shellcmd success")
             return out
 
-    def _setupBE(self):
-        assert self.pokydirname and os.path.exists(self.pokydirname)
-        path = self.be.builddir
-        if not path:
-            raise Exception("Invalid path creation specified.")
-        if not os.path.exists(path):
-            os.makedirs(path, 0755)
-        self._shellcmd("bash -c \"source %s/oe-init-build-env %s\"" % (self.pokydirname, path))
-        # delete the templateconf.cfg; it may come from an unsupported layer configuration
-        os.remove(os.path.join(path, "conf/templateconf.cfg"))
-
 
     def writeConfFile(self, file_name, variable_list = None, raw = None):
         filepath = os.path.join(self.be.builddir, file_name)
@@ -297,16 +286,12 @@ class LocalhostBEController(BuildEnvironmentController):
 
         logger.debug("localhostbecontroller: current layer list %s " % pformat(layerlist))
 
-        # 4. configure the build environment, so we have a conf/bblayers.conf
-        assert self.pokydirname is not None
-        self._setupBE()
-
-        # 5. update the bblayers.conf
+        # 4. update the bblayers.conf
         bblayerconf = os.path.join(self.be.builddir, "conf/bblayers.conf")
         if not os.path.exists(bblayerconf):
             raise BuildSetupException("BE is not consistent: bblayers.conf file missing at %s" % bblayerconf)
 
-        # 6. create custom layer and add custom recipes to it
+        # 5. create custom layer and add custom recipes to it
         layerpath = os.path.join(self.be.sourcedir, "_meta-toaster-custom")
         if os.path.isdir(layerpath):
             shutil.rmtree(layerpath) # remove leftovers from previous builds
-- 
1.9.1


