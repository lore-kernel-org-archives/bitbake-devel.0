Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC48C4828D
	for <webhook@archiver.kernel.org>; Tue,  6 Feb 2024 12:15:35 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web10.20044.1707221731701860789
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 06 Feb 2024 04:15:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=G+cEdQg2;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40fe2ed8746so4502925e9.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 06 Feb 2024 04:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1707221730; x=1707826530; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=S9LKRPBn5tYetoBp/349iD722OxW6BEiZ2t+OW8PFV0=;
        b=G+cEdQg27w4s7P+Y+l22DCAs7l3cpk76Y1eSa/45tqGnTngMYkU+Qo/KLtiTxNWkaf
         DMvNHa8o6uQOBtCqgvobY3g1gpU07egHJ6lRQhm8QyB3gc3TqLymWry3jHcv2Ee+4X3/
         el98rnO8jO+BJRj+rui8ojTXyXPaxxmmOzrkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707221730; x=1707826530;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S9LKRPBn5tYetoBp/349iD722OxW6BEiZ2t+OW8PFV0=;
        b=XDmdmK7BPQ9uuoMXp04h8VBobTqjY2nK4dcYoNeBCvNYLRS2XBHxKQrhHlHKtiYtJE
         pBEsefCin3Wc3MN2Nc6Bpc+BQ80QvPlAwDTm8TdbnHs4679p5vU33rru1xVVIFcQhUhE
         5mpIf2rHcXbAA7OugMAL1RCW0ENd6q1s7Xfa81Y0tYa9J07SWuXx+OCzXPjc3IEw/TRL
         lC079dwnguTqw8u8ZbSt4rVdCd/jrqma2OW5CymiC0kMkk+nYdVCW6+ytzh/vsj4Anij
         6Tvek5vE0ULqlI1qPBo0p7bdmxd5mRGkoHQT+VNFEKe6XXami+V7YJH4Edgqrx5F7/Es
         ol2A==
X-Gm-Message-State: AOJu0YwRG+Xf4FBVrYCapERtJFk+3XK7wlQnWB78ziJ0i/IJ5mBscYXl
	wOM0KuGtW1+zVZtWL3FNez38kVQXAUWtRz6t+MaZqVmrZOGHqqN3STB9LRIbAD0JK8JYVNqkEm0
	L
X-Google-Smtp-Source: AGHT+IGQ7BguZlz7eFihUobcpEk05f1fPZxQdWjsGjlfnBHN657xcAk5fcCcheV8eSQ7/F8df2pRlQ==
X-Received: by 2002:a05:600c:3d92:b0:40f:de6a:29ee with SMTP id bi18-20020a05600c3d9200b0040fde6a29eemr1644082wmb.0.1707221729495;
        Tue, 06 Feb 2024 04:15:29 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:45c0:34a2:1eea:2530])
        by smtp.gmail.com with ESMTPSA id fc19-20020a05600c525300b0040fcaec04b8sm1833547wmb.22.2024.02.06.04.15.28
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 04:15:29 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] lib/bb: Drop BBFILE_PRIORITY support
Date: Tue,  6 Feb 2024 12:15:28 +0000
Message-Id: <20240206121528.2581233-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 06 Feb 2024 12:15:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15828

These entries, usually in layer.conf are part of an old, pre-layers
part of bitbake for overlay/collection support. This is not really
used any more and was replaced by the idea of layers.

In a recent discussion, we asked the question "When do you need to
use proprities?" and the answer was "almost never" given all the other
tools and techniques now available in layers.

These layer priorities cause users huge amounts of confusion. It is
unclear to people how the "magic values" work if it is unset
and if they are set differently, users don't expect the way it
actually works and the effects it has between layers.

In discussions I've had, there has been surprisingly strong support
for removing them entirely, even if that does means we'd need to fix
some corner caes.

I wholly agree and support that idea, so lets remove the support
and take a simplification where we can. The functionality had a
and place but it has passed and we've moved on.

Developers are about to need to change layer.conf to update the
series comparibility for the next release so it is a good time to
do it.

This patch removes the core support and replaces it with a warning.
It does not chase down every last reference or function parmeter,
that can follow as time allows.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cache.py     |  1 -
 lib/bb/cooker.py    | 51 +++++++--------------------------------
 lib/bb/providers.py | 58 +++++++++++++++++++--------------------------
 lib/bb/utils.py     |  2 +-
 4 files changed, 34 insertions(+), 78 deletions(-)

diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index 18d5574a31..64dbffc0f6 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -818,7 +818,6 @@ class CacheData(object):
         # Indirect Cache variables (set elsewhere)
         self.ignored_dependencies = []
         self.world_target = set()
-        self.bbfile_priority = {}
 
     def add_from_recipeinfo(self, fn, info_array):
         for info in info_array:
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index c5bfef55d6..381379086a 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1124,26 +1124,15 @@ class BBCooker:
         errors = False
         self.bbfile_config_priorities = []
         if collections:
-            collection_priorities = {}
             collection_depends = {}
             collection_list = collections.split()
             min_prio = 0
             for c in collection_list:
                 bb.debug(1,'Processing %s in collection list' % (c))
 
-                # Get collection priority if defined explicitly
                 priority = self.data.getVar("BBFILE_PRIORITY_%s" % c)
                 if priority:
-                    try:
-                        prio = int(priority)
-                    except ValueError:
-                        parselog.error("invalid value for BBFILE_PRIORITY_%s: \"%s\"", c, priority)
-                        errors = True
-                    if min_prio == 0 or prio < min_prio:
-                        min_prio = prio
-                    collection_priorities[c] = prio
-                else:
-                    collection_priorities[c] = None
+                    bb.warn("Ignoring obsolete BBFILE_PRIORITY_%s" % c)
 
                 # Check dependencies and store information for priority calculation
                 deps = self.data.getVar("LAYERDEPENDS_%s" % c)
@@ -1204,22 +1193,9 @@ class BBCooker:
                         else:
                             parselog.debug3("Layer '%s' recommends layer '%s', but this layer is not enabled in your configuration", c, rec)
 
-            # Recursively work out collection priorities based on dependencies
-            def calc_layer_priority(collection):
-                if not collection_priorities[collection]:
-                    max_depprio = min_prio
-                    for dep in collection_depends[collection]:
-                        calc_layer_priority(dep)
-                        depprio = collection_priorities[dep]
-                        if depprio > max_depprio:
-                            max_depprio = depprio
-                    max_depprio += 1
-                    parselog.debug("Calculated priority of layer %s as %d", collection, max_depprio)
-                    collection_priorities[collection] = max_depprio
-
-            # Calculate all layer priorities using calc_layer_priority and store in bbfile_config_priorities
+
+            # Store all layer priorities in bbfile_config_priorities
             for c in collection_list:
-                calc_layer_priority(c)
                 regex = self.data.getVar("BBFILE_PATTERN_%s" % c)
                 if regex is None:
                     parselog.error("BBFILE_PATTERN_%s not defined" % c)
@@ -1236,7 +1212,7 @@ class BBCooker:
                         parselog.error("BBFILE_PATTERN_%s \"%s\" is not a valid regular expression", c, regex)
                         errors = True
                         continue
-                self.bbfile_config_priorities.append((c, regex, cre, collection_priorities[c]))
+                self.bbfile_config_priorities.append((c, regex, cre, 0))
         if errors:
             # We've already printed the actual error(s)
             raise CollectionError("Errors during parsing layer configuration")
@@ -1358,7 +1334,6 @@ class BBCooker:
         # Tweak some variables
         item = info_array[0].pn
         self.recipecaches[mc].ignored_dependencies = set()
-        self.recipecaches[mc].bbfile_priority[fn] = 1
         self.configuration.limited_deps = True
 
         # Remove external dependencies
@@ -1639,7 +1614,7 @@ class BBCooker:
             self.show_appends_with_no_recipes()
             self.handlePrefProviders()
             for mc in self.multiconfigs:
-                self.recipecaches[mc].bbfile_priority = self.collections[mc].collection_priorities(self.recipecaches[mc].pkg_fn, self.parser.mcfilelist[mc], self.data)
+                self.collections[mc].collection_priorities(self.recipecaches[mc].pkg_fn, self.parser.mcfilelist[mc], self.data)
             self.state = state.running
 
             # Send an event listing all stamps reachable after parsing
@@ -1767,9 +1742,9 @@ class CookerCollectFiles(object):
         self.bbfile_config_priorities = sorted(priorities, key=lambda tup: tup[1], reverse=True)
 
     def calc_bbfile_priority(self, filename):
-        for layername, _, regex, pri in self.bbfile_config_priorities:
+        for layername, _, regex, _ in self.bbfile_config_priorities:
             if regex.match(filename):
-                return pri, regex, layername
+                return 0, regex, layername
         return 0, None, None
 
     def get_bbfiles(self):
@@ -1801,10 +1776,6 @@ class CookerCollectFiles(object):
 
         files = (config.getVar( "BBFILES") or "").split()
 
-        # Sort files by priority
-        files.sort( key=lambda fileitem: self.calc_bbfile_priority(fileitem)[0] )
-        config.setVar("BBFILES_PRIORITIZED", " ".join(files))
-
         if not files:
             files = self.get_bbfiles()
 
@@ -1926,12 +1897,10 @@ class CookerCollectFiles(object):
         return tuple(filelist)
 
     def collection_priorities(self, pkgfns, fns, d):
-        # Return the priorities of the entries in pkgfns
-        # Also check that all the regexes in self.bbfile_config_priorities are used
+        # Check that all the regexes in self.bbfile_config_priorities are used
         # (but to do that we need to ensure skipped recipes aren't counted, nor
         # collections in BBFILE_PATTERN_IGNORE_EMPTY)
 
-        priorities = {}
         seen = set()
         matched = set()
 
@@ -1943,7 +1912,7 @@ class CookerCollectFiles(object):
         # Calculate priorities for each file
         for p in pkgfns:
             realfn, cls, mc = bb.cache.virtualfn2realfn(p)
-            priorities[p], regex, _ = self.calc_bbfile_priority(realfn)
+            _, regex, _ = self.calc_bbfile_priority(realfn)
             if regex in unmatched_regex:
                 matched_regex.add(regex)
                 unmatched_regex.remove(regex)
@@ -1985,8 +1954,6 @@ class CookerCollectFiles(object):
                     collectlog.warning("No bb files in %s matched BBFILE_PATTERN_%s '%s'" % (self.mc if self.mc else 'default',
                                                                                              collection, pattern))
 
-        return priorities
-
 class ParsingFailure(Exception):
     def __init__(self, realexception, recipe):
         self.realexception = realexception
diff --git a/lib/bb/providers.py b/lib/bb/providers.py
index e11a4637d1..f527dc469f 100644
--- a/lib/bb/providers.py
+++ b/lib/bb/providers.py
@@ -71,21 +71,15 @@ def sortPriorities(pn, dataCache, pkg_pn = None):
     files = pkg_pn[pn]
     priorities = {}
     for f in files:
-        priority = dataCache.bbfile_priority[f]
         preference = dataCache.pkg_dp[f]
-        if priority not in priorities:
-            priorities[priority] = {}
-        if preference not in priorities[priority]:
-            priorities[priority][preference] = []
-        priorities[priority][preference].append(f)
-    tmp_pn = []
-    for pri in sorted(priorities):
-        tmp_pref = []
-        for pref in sorted(priorities[pri]):
-            tmp_pref.extend(priorities[pri][pref])
-        tmp_pn = [tmp_pref] + tmp_pn
-
-    return tmp_pn
+        if preference not in priorities:
+            priorities[preference] = []
+        priorities[preference].append(f)
+    tmp_pref = []
+    for pref in sorted(priorities):
+        tmp_pref.extend(priorities[pref])
+
+    return tmp_pref
 
 def versionVariableMatch(cfgData, keyword, pn):
     """
@@ -115,7 +109,7 @@ def preferredVersionMatch(pe, pv, pr, preferred_e, preferred_v, preferred_r):
                 return True
     return False
 
-def findPreferredProvider(pn, cfgData, dataCache, pkg_pn = None, item = None):
+def findPreferredProvider(pn, cfgData, dataCache, pkg_pn, item):
     """
     Find the first provider in pkg_pn with REQUIRED_VERSION or PREFERRED_VERSION set.
     """
@@ -156,15 +150,12 @@ def findPreferredProvider(pn, cfgData, dataCache, pkg_pn = None, item = None):
             preferred_e = None
             preferred_r = None
 
-        for file_set in pkg_pn:
-            for f in file_set:
-                pe, pv, pr = dataCache.pkg_pepvpr[f]
-                if preferredVersionMatch(pe, pv, pr, preferred_e, preferred_v, preferred_r):
-                    preferred_file = f
-                    preferred_ver = (pe, pv, pr)
-                    break
-            if preferred_file:
-                break;
+        for f in pkg_pn:
+            pe, pv, pr = dataCache.pkg_pepvpr[f]
+            if preferredVersionMatch(pe, pv, pr, preferred_e, preferred_v, preferred_r):
+                preferred_file = f
+                preferred_ver = (pe, pv, pr)
+                break
         if preferred_r:
             pv_str = '%s-%s' % (preferred_v, preferred_r)
         else:
@@ -175,14 +166,13 @@ def findPreferredProvider(pn, cfgData, dataCache, pkg_pn = None, item = None):
             if not required:
                 logger.warning("preferred version %s of %s not available%s", pv_str, pn, itemstr)
             available_vers = []
-            for file_set in pkg_pn:
-                for f in file_set:
-                    pe, pv, pr = dataCache.pkg_pepvpr[f]
-                    ver_str = pv
-                    if pe:
-                        ver_str = "%s:%s" % (pe, ver_str)
-                    if not ver_str in available_vers:
-                        available_vers.append(ver_str)
+            for f in pkg_pn:
+                pe, pv, pr = dataCache.pkg_pepvpr[f]
+                ver_str = pv
+                if pe:
+                    ver_str = "%s:%s" % (pe, ver_str)
+                if not ver_str in available_vers:
+                    available_vers.append(ver_str)
             if available_vers:
                 available_vers.sort()
                 logger.warning("versions of %s available: %s", pn, ' '.join(available_vers))
@@ -226,7 +216,7 @@ def findBestProvider(pn, cfgData, dataCache, pkg_pn = None, item = None):
     # Find the highest priority provider with a REQUIRED_VERSION or PREFERRED_VERSION set
     (preferred_ver, preferred_file, required) = findPreferredProvider(pn, cfgData, dataCache, sortpkg_pn, item)
     # Find the latest version of the highest priority provider
-    (latest, latest_f) = findLatestProvider(pn, cfgData, dataCache, sortpkg_pn[0])
+    (latest, latest_f) = findLatestProvider(pn, cfgData, dataCache, sortpkg_pn)
 
     if not required and preferred_file is None:
         preferred_file = latest_f
@@ -272,7 +262,7 @@ def _filterProviders(providers, item, cfgData, dataCache):
     for pn in sorted(sortpkg_pn):
         if pn in preferred_versions and preferred_versions[pn][1]:
             continue
-        preferred_versions[pn] = findLatestProvider(pn, cfgData, dataCache, sortpkg_pn[pn][0])
+        preferred_versions[pn] = findLatestProvider(pn, cfgData, dataCache, sortpkg_pn[pn])
         eligible.append(preferred_versions[pn][1])
 
     if not eligible:
diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 068b631c94..3ee3aa8875 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -1563,7 +1563,7 @@ def get_file_layer(filename, d, collection_res={}):
         return match
 
     result = None
-    bbfiles = (d.getVar('BBFILES_PRIORITIZED') or '').split()
+    bbfiles = (d.getVar('BBFILES') or '').split()
     bbfilesmatch = False
     for bbfilesentry in bbfiles:
         if fnmatch.fnmatchcase(filename, bbfilesentry):
-- 
2.40.1


