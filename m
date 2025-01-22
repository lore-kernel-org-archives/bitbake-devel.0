Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95CF4C0218B
	for <webhook@archiver.kernel.org>; Wed, 22 Jan 2025 03:09:07 +0000 (UTC)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
 by mx.groups.io with SMTP id smtpd.web10.34524.1737515338365576072
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Jan 2025 19:08:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=mObJy5iE;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.51, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ee50ffcf14so670402a91.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 21 Jan 2025 19:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1737515337; x=1738120137; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BbK4Ci1PkHDwUhKYAZRwJnR3OP1QLCNu2oeiXD0b8I8=;
        b=mObJy5iE0PZh0B7grtv4LP1vBwl8JZ+T5M7mYlTDafCnxbq/LDezy3UpYYPm8IiUL+
         h3h+nhCpYYw8JvNOMR+i1sKoPzHiHJOCivTOt15GE3IXQKO3CAgBTO6EggHoxqFWocbQ
         LH/DEfvSlMDsjCIbJ1vpgO9Nmfv91PSikflubYhvaKdjjXxwalUIuJprhq9VY1cLlXDU
         M6uMIwyyFuS2W427FXgQ5tOPvCd7ktdaXhL0/AbTKVPF90R0TadiXGZuSo2/UiR68vdx
         iyIhYxSn58TE6Pum35aHnyq56FgCf/yASV7h23g7qVVqCalthRFEGh6iu3aHGwBfFRgq
         zrQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737515337; x=1738120137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BbK4Ci1PkHDwUhKYAZRwJnR3OP1QLCNu2oeiXD0b8I8=;
        b=p5GQlX0tMAHB256HKuXge+wyF9QVncHnKRfO+xIOyhJSy0P8rAwWGTmjl7iaZ5ZM60
         SlBeAeM0AaDnHvHWCQ58INkgcknZsyUtbabfxeBrz5OorY7PErPQhe5hTu7ouXIFBNdT
         8ycgoPlCxm8UoypuTEgCeINzyp82jfhDiBkxXGGVsyYu5mMVhyMx83e+EMnNvkeIFJCg
         WWZAb9ZGKTqQ9rgHJlsYNKyI9oes427Tw/A/bZ8vUucVHkLuq5JLbrVDkvnQsBV9ahq6
         UyH2Ag9l2z28cS8oVPsx9Wl3WQHLEVrtscPm/p+tYkX0/xIfcRMpfPGORsLSyAMfO1tK
         dMTw==
X-Gm-Message-State: AOJu0YwVNCChYYrarfMWVxMM5VBdi/C0eZg+O7DXON9YhIXCWNrB7EQT
	lPFh/OKmJOmZxPCU0apQ9MgEmGCnMWxXlQNxSLDtnHwSnLbVt0RYtyRNXaevEKpUkeSPpng8laz
	foc4=
X-Gm-Gg: ASbGncvFdMwjCCv+l/quSkvNUNOWxYadD8rfkSDsXS0d6CYDfQtN5SsGwmwjIIUNKmK
	4/636kvYNngHzcvXwVZMZREwqbje+QQOzfPpg1sy7xd7DoHsNA1gtijGDcIRAW1SH6A37lnEWhW
	PqTik2FJHe96UgGEsadn/JaOC2BGYmERWyVaxMX26HJL8Qb0V8RLFRxpqhQ93csLVbJXgTiSK9o
	DPxPxZwQFCiyQFqnC8UgoOcmBEL8gIddYq9QD/xdV1LRmJFob9JW8vbTaY=
X-Google-Smtp-Source: AGHT+IGb34Ob1fzmyJBej2Q+Z6gU3w7K5RiysTaj0+1bWB9MCu2dVSjPvloaJaEp9TUGq2evwkEyBA==
X-Received: by 2002:a05:6a00:66cb:b0:727:39a4:30cc with SMTP id d2e1a72fcca58-72d8c46e973mr38058977b3a.1.1737515336884;
        Tue, 21 Jan 2025 19:08:56 -0800 (PST)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab816412sm10050820b3a.66.2025.01.21.19.08.56
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 19:08:56 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 3/3] cooker: Make cooker 'skiplist' per-multiconfig/mc
Date: Tue, 21 Jan 2025 19:08:46 -0800
Message-ID: <7dde14582bfd104c6da26e3f5ecf2ef37a1494ce.1737515198.git.steve@sakoman.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1737515198.git.steve@sakoman.com>
References: <cover.1737515198.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 22 Jan 2025 03:09:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17055

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
index 1cb3e189f..6fce19b46 100644
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
@@ -612,8 +613,8 @@ class BBCooker:
         localdata = {}
 
         for mc in self.multiconfigs:
-            taskdata[mc] = bb.taskdata.TaskData(halt, skiplist=self.skiplist, allowincomplete=allowincomplete)
-            localdata[mc] = data.createCopy(self.databuilder.mcdata[mc])
+            taskdata[mc] = bb.taskdata.TaskData(halt, skiplist=self.skiplist_by_mc[mc], allowincomplete=allowincomplete)
+            localdata[mc] = bb.data.createCopy(self.databuilder.mcdata[mc])
             bb.data.expandKeys(localdata[mc])
 
         current = 0
@@ -933,7 +934,7 @@ class BBCooker:
         for mc in self.multiconfigs:
             # First get list of recipes, including skipped
             recipefns = list(self.recipecaches[mc].pkg_fn.keys())
-            recipefns.extend(self.skiplist.keys())
+            recipefns.extend(self.skiplist_by_mc[mc].keys())
 
             # Work out list of bbappends that have been applied
             applied_appends = []
@@ -2358,7 +2359,7 @@ class CookerParser(object):
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


