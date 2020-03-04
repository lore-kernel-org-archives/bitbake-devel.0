Return-Path: <jpewhacker@gmail.com>
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com
	[209.85.166.180])
	by mail.openembedded.org (Postfix) with ESMTP id 8E6D0616F5
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  4 Mar 2020 20:02:31 +0000 (UTC)
Received: by mail-il1-f180.google.com with SMTP id n11so2950659ild.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 04 Mar 2020 12:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=7ZjEf4PE2WiDpEtu+eaqS605d2/GDpoyzBrdW68rCzo=;
	b=e5UlGcobENWnLguyN8xZRjuuHR3wW8qnSo8GaQe2LutlEe2dmFMq7PbFxqx7e52lbs
	Kl98XKAkVPSRSjAJx5lIWKPnDusT6mzZ5JjD93GoiDxAFscwWDswWCDIiIN84IEqpDk6
	Qir2H4Eh06xckTFy7ZTnp6q2a6ieX6VBOr+0HZkCMiRmrQonrP47J8DMNccpOCN3ms+t
	hMetpYV7w4h0p2Eg4Gg7TNukfL80SHrVIxQQDs7hwTyeqJV23ht0/M9o6phFE+m14kju
	gIGfLhXIXhFppP3MjHUTQvfRY6fhC5zKeKSdh17p00qdog6tkvJ9wflcGpoUH00w/sAi
	ETaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=7ZjEf4PE2WiDpEtu+eaqS605d2/GDpoyzBrdW68rCzo=;
	b=bVKNRouxS52JbrsCoYIGftDKveUxNi2WJ2wgGF/3tCzocKUZr2JnrpgkzHcmkeXckm
	kqbI8Ql+dcYgGWYaZNaJ/ZYLqLOnRVl+PqPZdAQoPYKzRH+k9yBsssfACcMAgghBA4aG
	YfVHn/5DJ31nsihPzU8G9EctR5IJ4pKQBH00inQNzRGz5+EDAN09wxknahuolgkic+ao
	x3uqDzAmWB+H8YoFdoZ9l4gxKOq7EGToBlBR9AAyQ++YSS/DQBw4cLhV1pn4z5obuYtN
	OqJA91EPv5AdZrCeUu85ovohmf3JiiVeF4HC7kGTn9K0pNPHuslGKxwvuaP++jwh2owu
	AOGQ==
X-Gm-Message-State: ANhLgQ19FVCa+vcuo1a7z/Ad3mIcEcps6J5BZk1D8MgzbJr7uQL0Re6W
	e2ycn0m7zeN96SwbZ217kaMAR9DmBpo=
X-Google-Smtp-Source: ADFU+vtyTamU76XyUQyzsY+5Fiue3E3nXJt+wmKpntN4qVBDY7yKKwB3kkamRs5R89xqLqS5rnniUQ==
X-Received: by 2002:a05:6e02:cc1:: with SMTP id
	c1mr4463985ilj.165.1583352152373; 
	Wed, 04 Mar 2020 12:02:32 -0800 (PST)
Received: from OLA-8C37N23.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id j4sm7310626ilf.21.2020.03.04.12.02.31
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 04 Mar 2020 12:02:31 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  4 Mar 2020 14:02:25 -0600
Message-Id: <20200304200226.23771-4-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200304200226.23771-1-JPEWhacker@gmail.com>
References: <20200304200226.23771-1-JPEWhacker@gmail.com>
Subject: [PATCH 3/4] bitbake: tinfoil: Add multiconfig support
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
X-List-Received-Date: Wed, 04 Mar 2020 20:02:31 -0000

Adds support for the Tinfoil cache adaptor to be bound to a specific
multiconfig and invoke the appropriate commands for that multiconfig
instead of the default. The cooker adapter now creates a cache adapter
for each multiconfig specified in BBMULTICONFIG so that each multiconfig
is present.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/tinfoil.py | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/bitbake/lib/bb/tinfoil.py b/bitbake/lib/bb/tinfoil.py
index 645f49639d..5c5be456e2 100644
--- a/bitbake/lib/bb/tinfoil.py
+++ b/bitbake/lib/bb/tinfoil.py
@@ -127,12 +127,13 @@ class TinfoilCookerAdapter:
 
     class TinfoilRecipeCacheAdapter:
         """ cooker.recipecache adapter """
-        def __init__(self, tinfoil):
+        def __init__(self, tinfoil, mc=''):
             self.tinfoil = tinfoil
+            self.mc = mc
             self._cache = {}
 
         def get_pkg_pn_fn(self):
-            pkg_pn = defaultdict(list, self.tinfoil.run_command('getRecipes') or [])
+            pkg_pn = defaultdict(list, self.tinfoil.run_command('getRecipes', self.mc) or [])
             pkg_fn = {}
             for pn, fnlist in pkg_pn.items():
                 for fn in fnlist:
@@ -151,27 +152,27 @@ class TinfoilCookerAdapter:
                 self.get_pkg_pn_fn()
                 return self._cache[name]
             elif name == 'deps':
-                attrvalue = defaultdict(list, self.tinfoil.run_command('getRecipeDepends') or [])
+                attrvalue = defaultdict(list, self.tinfoil.run_command('getRecipeDepends', self.mc) or [])
             elif name == 'rundeps':
-                attrvalue = defaultdict(lambda: defaultdict(list), self.tinfoil.run_command('getRuntimeDepends') or [])
+                attrvalue = defaultdict(lambda: defaultdict(list), self.tinfoil.run_command('getRuntimeDepends', self.mc) or [])
             elif name == 'runrecs':
-                attrvalue = defaultdict(lambda: defaultdict(list), self.tinfoil.run_command('getRuntimeRecommends') or [])
+                attrvalue = defaultdict(lambda: defaultdict(list), self.tinfoil.run_command('getRuntimeRecommends', self.mc) or [])
             elif name == 'pkg_pepvpr':
-                attrvalue = self.tinfoil.run_command('getRecipeVersions') or {}
+                attrvalue = self.tinfoil.run_command('getRecipeVersions', self.mc) or {}
             elif name == 'inherits':
-                attrvalue = self.tinfoil.run_command('getRecipeInherits') or {}
+                attrvalue = self.tinfoil.run_command('getRecipeInherits', self.mc) or {}
             elif name == 'bbfile_priority':
-                attrvalue = self.tinfoil.run_command('getBbFilePriority') or {}
+                attrvalue = self.tinfoil.run_command('getBbFilePriority', self.mc) or {}
             elif name == 'pkg_dp':
-                attrvalue = self.tinfoil.run_command('getDefaultPreference') or {}
+                attrvalue = self.tinfoil.run_command('getDefaultPreference', self.mc) or {}
             elif name == 'fn_provides':
-                attrvalue = self.tinfoil.run_command('getRecipeProvides') or {}
+                attrvalue = self.tinfoil.run_command('getRecipeProvides', self.mc) or {}
             elif name == 'packages':
-                attrvalue = self.tinfoil.run_command('getRecipePackages') or {}
+                attrvalue = self.tinfoil.run_command('getRecipePackages', self.mc) or {}
             elif name == 'packages_dynamic':
-                attrvalue = self.tinfoil.run_command('getRecipePackagesDynamic') or {}
+                attrvalue = self.tinfoil.run_command('getRecipePackagesDynamic', self.mc) or {}
             elif name == 'rproviders':
-                attrvalue = self.tinfoil.run_command('getRProviders') or {}
+                attrvalue = self.tinfoil.run_command('getRProviders', self.mc) or {}
             else:
                 raise AttributeError("%s instance has no attribute '%s'" % (self.__class__.__name__, name))
 
@@ -182,8 +183,9 @@ class TinfoilCookerAdapter:
         self.tinfoil = tinfoil
         self.collection = self.TinfoilCookerCollectionAdapter(tinfoil)
         self.recipecaches = {}
-        # FIXME all machines
         self.recipecaches[''] = self.TinfoilRecipeCacheAdapter(tinfoil)
+        for mc in (tinfoil.config_data.getVar('BBMULTICONFIG') or '').split():
+            self.recipecaches[mc] = self.TinfoilRecipeCacheAdapter(tinfoil, mc)
         self._cache = {}
     def __getattr__(self, name):
         # Grab these only when they are requested since they aren't always used
@@ -501,11 +503,11 @@ class Tinfoil:
         """
         return OrderedDict(self.run_command('getSkippedRecipes'))
 
-    def get_all_providers(self):
-        return defaultdict(list, self.run_command('allProviders'))
+    def get_all_providers(self, mc=''):
+        return defaultdict(list, self.run_command('allProviders', mc))
 
-    def find_providers(self):
-        return self.run_command('findProviders')
+    def find_providers(self, mc=''):
+        return self.run_command('findProviders', mc)
 
     def find_best_provider(self, pn):
         return self.run_command('findBestProvider', pn)
-- 
2.17.1


