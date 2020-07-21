Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web12.17850.1595334828447705099
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Jul 2020 05:33:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=cdH1OChZ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f48.google.com with SMTP id o8so2646137wmh.4
        for <bitbake-devel@lists.openembedded.org>; Tue, 21 Jul 2020 05:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gPOOAxttzUhEBCaHGSPPrqPBDUuIAEF1JA6SASFMrzM=;
        b=cdH1OChZ1rQNTrjboCAc4LfY3dSw5eIVDXW9IjnQnReqNd9TXc+NQu8wLjtRcb8ygR
         70zPNeU07md2qfYl/pMFpV3+R2BB13LPkDR06TU2bQDQ2pEO80xt8boMCmuyt7+KeOUX
         hydetuFJDVW1U+d0nRw6oDpgU82HNjLbpdpGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gPOOAxttzUhEBCaHGSPPrqPBDUuIAEF1JA6SASFMrzM=;
        b=tQtSxEShzc5nxoeyAhu8a0qTKuT/og9E3hrjGU9Sz0p9i08BuUt6FsQkJY7/Qb0w8e
         4Axh2ftP5HiN3OcHnVPrKEidwjhljph5eI+3HmpxhfOGbNBieB7AnH2MffKjEWdgcnTa
         bH98b06/RADxHXswjO1ERAXe3X7abigCzza8JDP+mvrMIFzNhnyOv+3O0qxsWvu9J6SE
         YuZJJUEeECt+fS42opA5RAN+NGJeN4cKx7N22jjK08SfthxOEOMPHmZdImDJBiKoIqf8
         cCk54DjC7ouC5T6iY3o7h9clZWuytl5Y3QJN9gh0y4oc+gqNS1zqbXbatE38PZaBEioz
         AF7A==
X-Gm-Message-State: AOAM533rRv2udcQz/pt0nQsoTVlXUXTjehRpY9EXh+jdcumLsiaDb4KG
	w8vLLvOtqvt2aXjFQin9Sq06vz34w0y5Uw==
X-Google-Smtp-Source: ABdhPJwQao1htaxSIkbpk8h8mUEIHI0uzn0NgHBWa1yxZLaoCjbUaVL/+cnGIWSI1A3mkE8gZCMlVg==
X-Received: by 2002:a1c:56c3:: with SMTP id k186mr2764513wmb.21.1595334826277;
        Tue, 21 Jul 2020 05:33:46 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (6.d.c.a.e.4.9.c.8.4.4.2.b.1.8.1.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:181b:2448:c94e:acd6])
        by smtp.gmail.com with ESMTPSA id x13sm1815113wro.64.2020.07.21.05.33.45
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 05:33:45 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/2] cooker: Fix unmatched files handling leading to misleading warnings
Date: Tue, 21 Jul 2020 13:33:43 +0100
Message-Id: <20200721123344.121156-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if all recipes in a layer are skipped, there are warnings that the
BBFILE_PATTERN_ entry didn't match anything. We probably shouldn't do this
for skipped recipes.

The current code is hard to understand, not least as it passes variables
which functions modify by reference rather than giving a return value.

Update calc_bbfile_priority() to return values rather than modifying them.
Refactor the code to try and make it clearer what its doing and fix the
skipped recipe issue by passing in the list of parsed files.

The function is complicated by the need to not rerun regex matching more
than we ever have to which complicates the flow, it would be easier if we
just reran operations multiple times.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/command.py      |  2 +-
 lib/bb/cooker.py       | 80 ++++++++++++++++++++++++++----------------
 lib/bb/tests/cooker.py |  2 +-
 3 files changed, 52 insertions(+), 32 deletions(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index 3902ccca71..805ed9216c 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -396,7 +396,7 @@ class CommandsSync:
         def sortkey(x):
             vfn, _ = x
             realfn, _, mc = bb.cache.virtualfn2realfn(vfn)
-            return (-command.cooker.collections[mc].calc_bbfile_priority(realfn), vfn)
+            return (-command.cooker.collections[mc].calc_bbfile_priority(realfn)[0], vfn)
 
         skipdict = OrderedDict(sorted(command.cooker.skiplist.items(), key=sortkey))
         return list(skipdict.items())
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index effd02442c..3a58a3a332 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1588,7 +1588,7 @@ class BBCooker:
             self.show_appends_with_no_recipes()
             self.handlePrefProviders()
             for mc in self.multiconfigs:
-                self.recipecaches[mc].bbfile_priority = self.collections[mc].collection_priorities(self.recipecaches[mc].pkg_fn, self.data)
+                self.recipecaches[mc].bbfile_priority = self.collections[mc].collection_priorities(self.recipecaches[mc].pkg_fn, self.parser.mcfilelist[mc], self.data)
             self.state = state.running
 
             # Send an event listing all stamps reachable after parsing
@@ -1704,14 +1704,11 @@ class CookerCollectFiles(object):
         # the shortest.  This allows nested layers to be properly evaluated.
         self.bbfile_config_priorities = sorted(priorities, key=lambda tup: tup[1], reverse=True)
 
-    def calc_bbfile_priority( self, filename, matched = None ):
+    def calc_bbfile_priority(self, filename):
         for _, _, regex, pri in self.bbfile_config_priorities:
             if regex.match(filename):
-                if matched is not None:
-                    if not regex in matched:
-                        matched.add(regex)
-                return pri
-        return 0
+                return pri, regex
+        return 0, None
 
     def get_bbfiles(self):
         """Get list of default .bb files by reading out the current directory"""
@@ -1744,7 +1741,7 @@ class CookerCollectFiles(object):
         config.setVar("BBFILES", " ".join(files))
 
         # Sort files by priority
-        files.sort( key=lambda fileitem: self.calc_bbfile_priority(fileitem) )
+        files.sort( key=lambda fileitem: self.calc_bbfile_priority(fileitem)[0] )
 
         if not len(files):
             files = self.get_bbfiles()
@@ -1866,39 +1863,62 @@ class CookerCollectFiles(object):
                 filelist.append(filename)
         return tuple(filelist)
 
-    def collection_priorities(self, pkgfns, d):
+    def collection_priorities(self, pkgfns, fns, d):
+        # Return the priorities of the entries in pkgfns
+        # Also check that all the regexes in self.bbfile_config_priorities are used
+        # (but to do that we need to ensure skipped recipes aren't counted, nor
+        # collections in BBFILE_PATTERN_IGNORE_EMPTY)
 
         priorities = {}
+        seen = set()
+        matched = set()
+
+        matched_regex = set()
+        unmatched_regex = set()
+        for _, _, regex, _ in self.bbfile_config_priorities:
+            unmatched_regex.add(regex)
 
         # Calculate priorities for each file
-        matched = set()
         for p in pkgfns:
             realfn, cls, mc = bb.cache.virtualfn2realfn(p)
-            priorities[p] = self.calc_bbfile_priority(realfn, matched)
-
-        unmatched = set()
-        for _, _, regex, pri in self.bbfile_config_priorities:
-            if not regex in matched:
-                unmatched.add(regex)
-
-        # Don't show the warning if the BBFILE_PATTERN did match .bbappend files
-        def find_bbappend_match(regex):
+            priorities[p], regex = self.calc_bbfile_priority(realfn)
+            if regex in unmatched_regex:
+                matched_regex.add(regex)
+                unmatched_regex.remove(regex)
+            seen.add(realfn)
+            if regex:
+                matched.add(realfn)
+
+        if unmatched_regex:
+            # Account for bbappend files
             for b in self.bbappends:
                 (bbfile, append) = b
-                if regex.match(append):
-                    # If the bbappend is matched by already "matched set", return False
-                    for matched_regex in matched:
-                        if matched_regex.match(append):
-                            return False
-                    return True
-            return False
+                seen.add(append)
+
+            # Account for skipped recipes
+            seen.update(fns)
+
+            seen.difference_update(matched)
 
-        for unmatch in unmatched.copy():
-            if find_bbappend_match(unmatch):
-                unmatched.remove(unmatch)
+            def already_matched(fn):
+                for regex in matched_regex:
+                    if regex.match(fn):
+                        return True
+                return False
+
+            for unmatch in unmatched_regex.copy():
+                for fn in seen:
+                    if unmatch.match(fn):
+                        # If the bbappend or file was already matched by another regex, skip it
+                        # e.g. for a layer within a layer, the outer regex could match, the inner
+                        # regex may match nothing and we should warn about that
+                        if already_matched(fn):
+                            continue
+                        unmatched_regex.remove(unmatch)
+                        break
 
         for collection, pattern, regex, _ in self.bbfile_config_priorities:
-            if regex in unmatched:
+            if regex in unmatched_regex:
                 if d.getVar('BBFILE_PATTERN_IGNORE_EMPTY_%s' % collection) != '1':
                     collectlog.warning("No bb files in %s matched BBFILE_PATTERN_%s '%s'" % (self.mc if self.mc else 'default',
                                                                                              collection, pattern))
diff --git a/lib/bb/tests/cooker.py b/lib/bb/tests/cooker.py
index 74c903f010..c82d4b7b81 100644
--- a/lib/bb/tests/cooker.py
+++ b/lib/bb/tests/cooker.py
@@ -60,7 +60,7 @@ class CookerTest(unittest.TestCase):
         log_handler = LogHandler()
         logger.addHandler(log_handler)
         collection = bb.cooker.CookerCollectFiles(bbfile_config_priorities)
-        collection.collection_priorities(pkgfns, self.d)
+        collection.collection_priorities(pkgfns, pkgfns, self.d)
         logger.removeHandler(log_handler)
 
         # Should be empty (no generated messages)
-- 
2.25.1

