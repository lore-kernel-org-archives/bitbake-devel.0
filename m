Received: from mail-pa0-f54.google.com ([209.85.220.54])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>) id 1TypLp-0007lQ-Ky
	for bitbake-devel@lists.openembedded.org;
	Fri, 25 Jan 2013 20:54:45 +0100
Received: by mail-pa0-f54.google.com with SMTP id bi5so441200pad.13
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Jan 2013 11:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:from:to:cc:subject:date:message-id:x-mailer;
	bh=Pq7zgUCNFs8RRMhkhZWnG8S1cEqta8jCHJJA715rFq4=;
	b=oOqqxKVQKe0jcnp4g6ULuo1gGS7rnfPWzhYn6tHTiey93a3LzP1k67WgbpmH5VqXQt
	MBfBhJA+TvfHBlfL3oEOK1a1ubsVll9Jw75NCUQIsKm0NY1BtGwvf04ycunfVt7rkMsc
	3b8WFb1kD71dFAy8xuvMGZC8oKKsfZzYZWcqUGk3y3SXINPQ2DzuhP2fzpDU6JjK6kk7
	iCcnQy+QuUHKZ/j2qC9uDUm4PHD855dnJeLaWOaYhOwUN2xfAYXum3ADEQKSFcyizHvU
	D8UcHzQaGkhwundNpzy4/DZ5F7k4uEo3ArQ51ljek2WsriSOcpIlE37uiddS2rblHxRO
	ntSw==
X-Received: by 10.69.1.73 with SMTP id be9mr17043107pbd.116.1359142718354;
	Fri, 25 Jan 2013 11:38:38 -0800 (PST)
Received: from localhost (ip-62-24-80-7.net.upcbroadband.cz. [62.24.80.7])
	by mx.google.com with ESMTPS id o6sm1377074paw.37.2013.01.25.11.38.35
	(version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Fri, 25 Jan 2013 11:38:37 -0800 (PST)
From: Martin Jansa <martin.jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 25 Jan 2013 20:38:28 +0100
Message-Id: <1359142708-24667-1-git-send-email-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 1.8.1.1
Subject: [PATCH] world-image: add extra target
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 25 Jan 2013 19:54:48 -0000

* similar to world target, but collects all PACKAGES
* recipes marked with EXCLUDE_FROM_WORLD are excluded from world as well
  as world-image
* recipes marked with EXCLUDE_FROM_WORLD_IMAGE are excluded completely
  from world-image, sometimes you can build 2 recipes in same sysroot,
  but cannot install them in the same image
* PACKAGES listed in EXCLUDE_PACKAGES_FROM_WORLD_IMAGE are also
  excluded. You can remove e.g. ${PN}-dbg, but keep all other PACKAGES.

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
---
 lib/bb/cache.py  | 17 ++++++++++++++++-
 lib/bb/cooker.py | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index fd5fbb3..47d3f2d 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -43,7 +43,7 @@ except ImportError:
     logger.info("Importing cPickle failed. "
                 "Falling back to a very slow implementation.")
 
-__cache_version__ = "145"
+__cache_version__ = "146"
 
 def getCacheFile(path, filename, data_hash):
     return os.path.join(path, filename + "." + data_hash)
@@ -128,6 +128,8 @@ class CoreRecipeInfo(RecipeInfoCommon):
         self.defaultpref = self.intvar('DEFAULT_PREFERENCE', metadata)
         self.broken = self.getvar('BROKEN', metadata)
         self.not_world = self.getvar('EXCLUDE_FROM_WORLD', metadata)
+        self.not_world_image = self.getvar('EXCLUDE_FROM_WORLD_IMAGE', metadata)
+        self.not_world_image_packages = self.getvar('EXCLUDE_PACKAGES_FROM_WORLD_IMAGE', metadata).split(' ')
         self.stamp = self.getvar('STAMP', metadata)
         self.stampclean = self.getvar('STAMPCLEAN', metadata)        
         self.stamp_base = self.flaglist('stamp-base', self.tasks, metadata)
@@ -176,6 +178,8 @@ class CoreRecipeInfo(RecipeInfoCommon):
         cachedata.rundeps = defaultdict(lambda: defaultdict(list))
         cachedata.runrecs = defaultdict(lambda: defaultdict(list))
         cachedata.possible_world = []
+        cachedata.possible_world_image = []
+        cachedata.possible_world_image_packages = []
         cachedata.universe_target = []
         cachedata.hashfn = {}
 
@@ -235,6 +239,16 @@ class CoreRecipeInfo(RecipeInfoCommon):
         # calculations
         if not self.broken and not self.not_world:
             cachedata.possible_world.append(fn)
+            # Collect files we may need for possible world-image
+            # calculations anc packages which are not explicitly excluded
+            if not self.not_world_image:
+                cachedata.possible_world_image.append(fn)
+                if self.not_world_image_packages:
+                    for package in self.packages:
+                        if not package in self.not_world_image_packages:
+                            cachedata.possible_world_image_packages.append(package)
+                else:
+                    cachedata.possible_world_image_packages.extend(self.packages)
 
         # create a collection of all targets for sanity checking
         # tasks, such as upstream versions, license, and tools for
@@ -710,6 +724,7 @@ class CacheData(object):
         # Indirect Cache variables (set elsewhere)
         self.ignored_dependencies = []
         self.world_target = set()
+        self.world_image_target = set()
         self.bbfile_priority = {}
 
     def add_from_recipeinfo(self, fn, info_array):
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index caf1123..b733066 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -227,6 +227,8 @@ class BBCooker:
         if self.configuration.show_environment:
             if 'world' in self.configuration.pkgs_to_build:
                 self.commandlineAction['msg'] = "'world' is not a valid target for --environment."
+            if 'world-image' in self.configuration.pkgs_to_build:
+                self.commandlineAction['msg'] = "'world-image' is not a valid target for --environment."
             elif 'universe' in self.configuration.pkgs_to_build:
                 self.commandlineAction['msg'] = "'universe' is not a valid target for --environment."
             elif len(self.configuration.pkgs_to_build) > 1:
@@ -817,6 +819,32 @@ class BBCooker:
             if terminal:
                 self.status.world_target.add(pn)
 
+    def buildWorldImageTargetList(self):
+        """
+         Build package list for "bitbake world-image"
+        """
+        all_depends = self.status.all_depends
+        pn_provides = self.status.pn_provides
+        parselog.debug(1, "collating packages for \"world-image\"")
+        for f in self.status.possible_world_image:
+            terminal = True
+            pn = self.status.pkg_fn[f]
+
+            for p in pn_provides[pn]:
+                if p.startswith('virtual/'):
+                    parselog.debug(2, "World image build skipping %s due to %s provider starting with virtual/", f, p)
+                    terminal = False
+                    break
+                for pf in self.status.providers[p]:
+                    if self.status.pkg_fn[pf] != pn:
+                        parselog.debug(2, "World image build skipping %s due to both us and %s providing %s", f, pf, p)
+                        terminal = False
+                        break
+            if terminal:
+                self.status.world_image_target.add(pn)
+        parselog.debug(2, "collated packages for \"world-image\": '%s'" % self.status.possible_world_image_packages)
+        return self.status.possible_world_image_packages
+
     def interactiveMode( self ):
         """Drop off into a shell"""
         try:
@@ -1253,6 +1281,12 @@ class BBCooker:
             for t in self.status.world_target:
                 pkgs_to_build.append(t)
 
+        if 'world-image' in pkgs_to_build:
+            packages = ' '.join(self.buildWorldImageTargetList())
+            self.configuration.data.setVar('IMAGE_INSTALL_pn-world-image', packages)
+            for t in self.status.world_image_target:
+                pkgs_to_build.append(t)
+
         if 'universe' in pkgs_to_build:
             parselog.warn("The \"universe\" target is only intended for testing and may produce errors.")
             parselog.debug(1, "collating packages for \"universe\"")
-- 
1.8.1.1



