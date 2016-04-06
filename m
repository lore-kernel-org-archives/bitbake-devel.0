Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f53.google.com (mail-wm0-f53.google.com [74.125.82.53])
	by mail.openembedded.org (Postfix) with ESMTP id 4A03E770B4
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Apr 2016 16:47:18 +0000 (UTC)
Received: by mail-wm0-f53.google.com with SMTP id 191so64804069wmq.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 06 Apr 2016 09:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
	:references; bh=p5LEShvX+hLXBn9gk9M/9dQ0uoO6VivaSfxsbZ3GukE=;
	b=Bk/+63ESWUycMK10wPs1MlyLVpuRDSWY1/DOX9H9IC318rlKYkNU+BbOVo26A2AER0
	kRK305HsWV5U3mjP/gfxIFyyvPggIaFQ1gxUTgwYidkWhC5GFGhAG5+J0GiUj81hHDk6
	nxoCN3trwgJkCwmUb1rOnlEeCvaYUCLkFQtRDsOaJN6zJOfWkMSf9bIwfr1lH4r5hd7S
	5jyvRhWvpLuUVPriCyeNZtAGaRUaX+fL5o1hJgg2P9QgFGHd5EXL6Z6iik+Q3UdLxI3d
	x3iNsNzAmUVD5i5szTk0ICpBpN2Tw4nqzX0h9/oS0eKx4JhWjc77urqt1sdnOZGXUPQI
	xmkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=p5LEShvX+hLXBn9gk9M/9dQ0uoO6VivaSfxsbZ3GukE=;
	b=U6FOZqM+KlOuJSojNzQ7BoDEMD0LJErfbwy3Nprt1UgilMUBhS4rahHYH8hU8IAPOa
	m5D97QxxrFxXphM3z3SlAs0x/VhG56xA3y2mjN7TQJ5kCvnGpRoTIK7J49y5+Yoe57f/
	mvaHQijns7v9/yQtynxgZ4QBW6HAryrw5O/dm0hsbuBPIL/X3cVpJkzruHR6oOz2RiM6
	R5J0iD41ufbCVy3IRP7iEw9G/3DRd8KH9Osmtte9ENxovHy7Jqd6aKnMvYUsPbOAw2nB
	9lfI9cKyWxglx9SUWb5+iGY2FZPBDIHiyob1v28KFkSeBr+9dvwV5arLwdIwthT22Flo
	T/Jw==
X-Gm-Message-State: AD7BkJLTOpqgvKeRkCiPBYHvAyBm2znVHbm03Cpd0klU2a6UzMV/3Llg3M2tOIdyfuSEsYFl
X-Received: by 10.28.45.212 with SMTP id t203mr25054206wmt.71.1459961238883;
	Wed, 06 Apr 2016 09:47:18 -0700 (PDT)
Received: from draco.icx.intel.com ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id gt7sm4145345wjc.1.2016.04.06.09.47.17
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 06 Apr 2016 09:47:18 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  6 Apr 2016 17:46:21 +0100
Message-Id: <1683c3b11d580238a41dfb787a297356736f5f72.1459960764.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
References: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1459960764.git.michael.g.wood@intel.com>
References: <cover.1459960764.git.michael.g.wood@intel.com>
Subject: [PATCH 11/38] toaster: modified setLayers API
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
X-List-Received-Date: Wed, 06 Apr 2016 16:47:18 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Removed updating of bblayers.conf. It will be done in runBuild method.
Changed return value: return list of layers.
Removed _updateBBLayers method.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/bldcontrol/bbcontroller.py          | 18 ------------------
 lib/toaster/bldcontrol/localhostbecontroller.py |  9 +--------
 2 files changed, 1 insertion(+), 26 deletions(-)

diff --git a/lib/toaster/bldcontrol/bbcontroller.py b/lib/toaster/bldcontrol/bbcontroller.py
index 2ca2661..058e490 100644
--- a/lib/toaster/bldcontrol/bbcontroller.py
+++ b/lib/toaster/bldcontrol/bbcontroller.py
@@ -109,24 +109,6 @@ class BuildEnvironmentController(object):
         self.be = be
         self.connection = None
 
-    @staticmethod
-    def _updateBBLayers(bblayerconf, layerlist):
-        conflines = open(bblayerconf, "r").readlines()
-
-        bblayerconffile = open(bblayerconf, "w")
-        skip = 0
-        for i in xrange(len(conflines)):
-            if skip > 0:
-                skip =- 1
-                continue
-            if conflines[i].startswith("# line added by toaster"):
-                skip = 1
-            else:
-                bblayerconffile.write(conflines[i])
-
-        bblayerconffile.write("# line added by toaster build control\nBBLAYERS = \"" + " ".join(layerlist) + "\"")
-        bblayerconffile.close()
-
     def setLayers(self, bitbake, ls):
         """ Checks-out bitbake executor and layers from git repositories.
             Sets the layer variables in the config file, after validating local layer paths.
diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index e588924..0a2e41d 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -180,11 +180,6 @@ class LocalhostBEController(BuildEnvironmentController):
 
         logger.debug("localhostbecontroller: current layer list %s " % pformat(layerlist))
 
-        # 4. update the bblayers.conf
-        bblayerconf = os.path.join(self.be.builddir, "conf/bblayers.conf")
-        if not os.path.exists(bblayerconf):
-            raise BuildSetupException("BE is not consistent: bblayers.conf file missing at %s" % bblayerconf)
-
         # 5. create custom layer and add custom recipes to it
         layerpath = os.path.join(self.be.builddir,
                                  CustomImageRecipe.LAYER_NAME)
@@ -247,10 +242,8 @@ class LocalhostBEController(BuildEnvironmentController):
         if os.path.isdir(layerpath):
             layerlist.append(layerpath)
 
-        BuildEnvironmentController._updateBBLayers(bblayerconf, layerlist)
-
         self.islayerset = True
-        return True
+        return layerlist
 
     def readServerLogFile(self):
         return open(os.path.join(self.be.builddir, "toaster_server.log"), "r").read()
-- 
2.1.4


