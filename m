Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E726C0218D
	for <webhook@archiver.kernel.org>; Wed, 29 Jan 2025 18:07:48 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web11.19338.1738174066828264588
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 29 Jan 2025 10:07:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=TM8E3HCE;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.174, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2161eb95317so129165385ad.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 29 Jan 2025 10:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1738174066; x=1738778866; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LVLs0rPjCVvdIqutpaWeJo4isqKM1vy2JtonP+wGbnw=;
        b=TM8E3HCE9uk1+rQtNv+ID0vmAFDJymZoDFNAzt+rRmYXR8gRokJ6wIey0J5MLK+Tay
         iOo73XOkEWQxmlnaFv5Z9/VDjhfiz+Bp01QjE851s824gyLQSAL4ciBqOYgJGpmDnQU7
         mQyKJaLkEB1S6Tqt77Tu7Bnd4rZmqyQjyz0a4V6O+ksj+flS7hlhGnOfRkXMh7+0E5vq
         54s8nMMdv66Vb71Ak680zbD71HsGOW0LSAGuOzzuhfmyrtbaCzDjO/nwwlOdeEe+Nmvx
         4BGPYbVa7e7epXL//DqYsAgvGG3VJl4F1HHBTxTek69axQUix2b3XsqAcc9/xV2zyJEd
         HpFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738174066; x=1738778866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LVLs0rPjCVvdIqutpaWeJo4isqKM1vy2JtonP+wGbnw=;
        b=AnPb0wp6u2hGyT5Dsj4vN/fm90OaGR6qM62TPs0kTG6So1zn8UOxKq5ef0EHADIOqw
         7a294iD7OPPBmJPPqx+njfJtsnWzxFeBy7Xg9DTyw+2kHkL+6unOPE79fws02Yl/XOQA
         G6b/a0LPuiA7zCjZvwVMQFKlI/r0BjyyRo7iRSCZUfwy0SZfqnjrca+fD1PU7QkZqtPu
         CIVwYRzYVcZyEyxaeuEjnAioybfptvM65zTutbRB3hikNxNCuoGmHbrLVsJXkxLiKyl9
         KhdTg8on+4ayraBRDmwXQewdBZnxl2mvGFUx6xaRQlrFPJyvRws3gJoTrPpr6UeZkNYU
         1Wqg==
X-Gm-Message-State: AOJu0Yw+oTT7phSo5iPnVOjHCDRLFeBPdyTncZ9Y5nN0YnfN5sRMChIp
	fm3Nn9IppOhi+JKvtkpUKkobuD4ywwPpPYl1YuKuJ/PnPcjCP/nGORRwr2I/JuvlqoMjLS3+rTK
	qmPs=
X-Gm-Gg: ASbGncvJugTQPFjeZPH0xMikYDtveDn1YjjITX0vLSKGv1YmzmDZOVSbAX46/iZ3nxK
	RPyiyvPGqWdyRd4abItNMTn8Tu05B4caeiTKO0UARdziIiQa40Y35Y01sDcq2SD+KxStVD7mrDp
	rGU4qjaUQiR0HR0oYBDlZY1KsgoBEvQUHC1hu8Swd6KT2y2sqzcgTZsgnOJdanBdoFmtInhagpZ
	/xCMyuUCIuO3oR187hnOgNm4x/72yipQLRYc2Oscs4V59Dmmf1FmUBgTzsNjivaUoYU5B1tP2dc
	DQuj
X-Google-Smtp-Source: AGHT+IGsLXgaUZEmkF5KuVZmen0QzR2ZWVsVO0VK2LrSdRk6OynjLV3tnYSMXFlU+uUNr8En6y7CSQ==
X-Received: by 2002:a17:902:e541:b0:216:282d:c697 with SMTP id d9443c01a7336-21dd7da3eb0mr63575895ad.27.1738174065906;
        Wed, 29 Jan 2025 10:07:45 -0800 (PST)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da3d9c626sm102497005ad.15.2025.01.29.10.07.45
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 10:07:45 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][styhead][2.10][PATCH 1/1] cooker: Make cooker 'skiplist' per-multiconfig/mc
Date: Wed, 29 Jan 2025 10:07:33 -0800
Message-ID: <a8578d12dfe5a3c92119bfee224595a392d6b0dd.1738173956.git.steve@sakoman.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1738173956.git.steve@sakoman.com>
References: <cover.1738173956.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 29 Jan 2025 18:07:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17118

From: Chris Laplante <chris.laplante@agilent.com>

Previously, the cooker skiplist was shared across multiconfigs
(including default ''). If you had a recipe that was incompatible with
several multiconfigs for different reasons, then the displayed reason
(i.e. the "ERROR: Nothing PROVIDES" and "* was skipped" messages) might
vary across invocations of bitbake. This was caused by the random order
in which recipes are parsed under different multiconfig contexts, with
each skip reason overwriting the previously assigned reason.

I hit this specificially when using COMPATIBLE_MACHINE, but
COMPATIBLE_HOST (or anything using bb.parse.SkipRecipe) would have done it too.

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit c51f01a35ed9a928402eab0899598b5c59602eef)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/command.py     | 21 ++++++++++++++++++---
 lib/bb/cooker.py      | 11 ++++++-----
 lib/bb/tinfoil.py     | 16 ++++++++++++----
 lib/bblayers/query.py | 14 +++++++-------
 4 files changed, 43 insertions(+), 19 deletions(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index 1fcb9bf14..5e166fe45 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -420,15 +420,30 @@ class CommandsSync:
         return command.cooker.recipecaches[mc].pkg_dp
     getDefaultPreference.readonly = True
 
+
     def getSkippedRecipes(self, command, params):
+        """
+        Get the map of skipped recipes for the specified multiconfig/mc name (`params[0]`).
+
+        Invoked by `bb.tinfoil.Tinfoil.get_skipped_recipes`
+
+        :param command: Internally used parameter.
+        :param params: Parameter array. params[0] is multiconfig/mc name. If not given, then default mc '' is assumed.
+        :return: Dict whose keys are virtualfns and values are `bb.cooker.SkippedPackage`
+        """
+        try:
+            mc = params[0]
+        except IndexError:
+            mc = ''
+
         # Return list sorted by reverse priority order
         import bb.cache
         def sortkey(x):
             vfn, _ = x
-            realfn, _, mc = bb.cache.virtualfn2realfn(vfn)
-            return (-command.cooker.collections[mc].calc_bbfile_priority(realfn)[0], vfn)
+            realfn, _, item_mc = bb.cache.virtualfn2realfn(vfn)
+            return -command.cooker.collections[item_mc].calc_bbfile_priority(realfn)[0], vfn
 
-        skipdict = OrderedDict(sorted(command.cooker.skiplist.items(), key=sortkey))
+        skipdict = OrderedDict(sorted(command.cooker.skiplist_by_mc[mc].items(), key=sortkey))
         return list(skipdict.items())
     getSkippedRecipes.readonly = True
 
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 582fc35f2..4aad408d4 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -134,7 +134,8 @@ class BBCooker:
         self.baseconfig_valid = False
         self.parsecache_valid = False
         self.eventlog = None
-        self.skiplist = {}
+        # The skiplists, one per multiconfig
+        self.skiplist_by_mc = defaultdict(dict)
         self.featureset = CookerFeatures()
         if featureSet:
             for f in featureSet:
@@ -616,8 +617,8 @@ class BBCooker:
         localdata = {}
 
         for mc in self.multiconfigs:
-            taskdata[mc] = bb.taskdata.TaskData(halt, skiplist=self.skiplist, allowincomplete=allowincomplete)
-            localdata[mc] = data.createCopy(self.databuilder.mcdata[mc])
+            taskdata[mc] = bb.taskdata.TaskData(halt, skiplist=self.skiplist_by_mc[mc], allowincomplete=allowincomplete)
+            localdata[mc] = bb.data.createCopy(self.databuilder.mcdata[mc])
             bb.data.expandKeys(localdata[mc])
 
         current = 0
@@ -937,7 +938,7 @@ class BBCooker:
         for mc in self.multiconfigs:
             # First get list of recipes, including skipped
             recipefns = list(self.recipecaches[mc].pkg_fn.keys())
-            recipefns.extend(self.skiplist.keys())
+            recipefns.extend(self.skiplist_by_mc[mc].keys())
 
             # Work out list of bbappends that have been applied
             applied_appends = []
@@ -2362,7 +2363,7 @@ class CookerParser(object):
         for virtualfn, info_array in result:
             if info_array[0].skipped:
                 self.skipped += 1
-                self.cooker.skiplist[virtualfn] = SkippedPackage(info_array[0])
+                self.cooker.skiplist_by_mc[mc][virtualfn] = SkippedPackage(info_array[0])
             self.bb_caches[mc].add_info(virtualfn, info_array, self.cooker.recipecaches[mc],
                                         parsed=parsed, watcher = self.cooker.add_filewatch)
         return True
diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index dcd3910cc..4dc4590c3 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -188,11 +188,19 @@ class TinfoilCookerAdapter:
             self._cache[name] = attrvalue
             return attrvalue
 
+    class TinfoilSkiplistByMcAdapter:
+        def __init__(self, tinfoil):
+            self.tinfoil = tinfoil
+
+        def __getitem__(self, mc):
+            return self.tinfoil.get_skipped_recipes(mc)
+
     def __init__(self, tinfoil):
         self.tinfoil = tinfoil
         self.multiconfigs = [''] + (tinfoil.config_data.getVar('BBMULTICONFIG') or '').split()
         self.collections = {}
         self.recipecaches = {}
+        self.skiplist_by_mc = self.TinfoilSkiplistByMcAdapter(tinfoil)
         for mc in self.multiconfigs:
             self.collections[mc] = self.TinfoilCookerCollectionAdapter(tinfoil, mc)
             self.recipecaches[mc] = self.TinfoilRecipeCacheAdapter(tinfoil, mc)
@@ -201,8 +209,6 @@ class TinfoilCookerAdapter:
         # Grab these only when they are requested since they aren't always used
         if name in self._cache:
             return self._cache[name]
-        elif name == 'skiplist':
-            attrvalue = self.tinfoil.get_skipped_recipes()
         elif name == 'bbfile_config_priorities':
             ret = self.tinfoil.run_command('getLayerPriorities')
             bbfile_config_priorities = []
@@ -514,12 +520,12 @@ class Tinfoil:
         """
         return defaultdict(list, self.run_command('getOverlayedRecipes', mc))
 
-    def get_skipped_recipes(self):
+    def get_skipped_recipes(self, mc=''):
         """
         Find recipes which were skipped (i.e. SkipRecipe was raised
         during parsing).
         """
-        return OrderedDict(self.run_command('getSkippedRecipes'))
+        return OrderedDict(self.run_command('getSkippedRecipes', mc))
 
     def get_all_providers(self, mc=''):
         return defaultdict(list, self.run_command('allProviders', mc))
@@ -533,6 +539,7 @@ class Tinfoil:
     def get_runtime_providers(self, rdep):
         return self.run_command('getRuntimeProviders', rdep)
 
+    # TODO: teach this method about mc
     def get_recipe_file(self, pn):
         """
         Get the file name for the specified recipe/target. Raises
@@ -541,6 +548,7 @@ class Tinfoil:
         """
         best = self.find_best_provider(pn)
         if not best or (len(best) > 3 and not best[3]):
+            # TODO: pass down mc
             skiplist = self.get_skipped_recipes()
             taskdata = bb.taskdata.TaskData(None, skiplist=skiplist)
             skipreasons = taskdata.get_reasons(pn)
diff --git a/lib/bblayers/query.py b/lib/bblayers/query.py
index bfc18a759..eb7cb465b 100644
--- a/lib/bblayers/query.py
+++ b/lib/bblayers/query.py
@@ -142,10 +142,10 @@ skipped recipes will also be listed, with a " (skipped)" suffix.
         # Ensure we list skipped recipes
         # We are largely guessing about PN, PV and the preferred version here,
         # but we have no choice since skipped recipes are not fully parsed
-        skiplist = list(self.tinfoil.cooker.skiplist.keys())
-        mcspec = 'mc:%s:' % mc
+        skiplist = list(self.tinfoil.cooker.skiplist_by_mc[mc].keys())
+
         if mc:
-            skiplist = [s[len(mcspec):] for s in skiplist if s.startswith(mcspec)]
+            skiplist = [s.removeprefix(f'mc:{mc}:') for s in skiplist]
 
         for fn in skiplist:
             recipe_parts = os.path.splitext(os.path.basename(fn))[0].split('_')
@@ -162,7 +162,7 @@ skipped recipes will also be listed, with a " (skipped)" suffix.
         def print_item(f, pn, ver, layer, ispref):
             if not selected_layer or layer == selected_layer:
                 if not bare and f in skiplist:
-                    skipped = ' (skipped: %s)' % self.tinfoil.cooker.skiplist[f].skipreason
+                    skipped = ' (skipped: %s)' % self.tinfoil.cooker.skiplist_by_mc[mc][f].skipreason
                 else:
                     skipped = ''
                 if show_filenames:
@@ -301,7 +301,7 @@ Lists recipes with the bbappends that apply to them as subitems.
             if self.show_appends_for_pn(pn, cooker_data, args.mc):
                 appends = True
 
-        if not args.pnspec and self.show_appends_for_skipped():
+        if not args.pnspec and self.show_appends_for_skipped(args.mc):
             appends = True
 
         if not appends:
@@ -317,9 +317,9 @@ Lists recipes with the bbappends that apply to them as subitems.
 
         return self.show_appends_output(filenames, best_filename)
 
-    def show_appends_for_skipped(self):
+    def show_appends_for_skipped(self, mc):
         filenames = [os.path.basename(f)
-                    for f in self.tinfoil.cooker.skiplist.keys()]
+                    for f in self.tinfoil.cooker.skiplist_by_mc[mc].keys()]
         return self.show_appends_output(filenames, None, " (skipped)")
 
     def show_appends_output(self, filenames, best_filename, name_suffix = ''):
-- 
2.43.0


