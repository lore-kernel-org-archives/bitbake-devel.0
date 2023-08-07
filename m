Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191FBEB64DD
	for <webhook@archiver.kernel.org>; Mon,  7 Aug 2023 09:37:12 +0000 (UTC)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
 by mx.groups.io with SMTP id smtpd.web10.30436.1691401028247888828
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 07 Aug 2023 02:37:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=PWaT0HsV;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.208.170, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2b9f0b7af65so65275571fa.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 07 Aug 2023 02:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1691401026; x=1692005826;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=QeFm3rOZ1g2ZR5wtPEvbolvpQgFJLSyPgaWXSfv8wTI=;
        b=PWaT0HsVafj4mksW3Cc7LBy92rASWY/l/KVrjP4e5q0keLpxV4y25LlMPYCrgOA1R6
         5MwPLQWYvKexXWGEnTwK54h9OCO5hmnST1YJj9VqvdE2qTTGcoWKGB785Ak/hgnWC18W
         WtTzsWV1WxAaRtpU+GbVvicYsiLy41lmeOJTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691401026; x=1692005826;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QeFm3rOZ1g2ZR5wtPEvbolvpQgFJLSyPgaWXSfv8wTI=;
        b=kvvMXFcpb8vC49FB1NXuJHZl0qgjMgoVB17fWHE0MqiHO8++1mp9cknvSdLXwN8VYZ
         h00LOXl4uXatmVHXGa8HcK7zLO6I2qhJSdbzO+xPvJrKC4LsLgL9wjsYyz84V4odgUya
         rKyiB5Sg2g5uRoAaOT0UlJLVuPG2KG5kkaJDXv8LqKnIwh3v6Nuh4Vd2Qorp0wNKyXI5
         1+HqlYpCfUEnTOTu2FT5BhOwj91PvSYwBBtHiecqHGU0TWz+9rwMwirMWwemDuRXBNf9
         OKqN7iTWx9KM96NkP88ehWQqRpDIn744IJ5o1Btpfpgfbw/Qf37q5h5mSkiA1MqBo/P3
         +4aQ==
X-Gm-Message-State: AOJu0YzXMsHpjCK/fu34YWjfrplCoIimyADdmLKuuykk3ZB0oMA7p0xO
	6EisyrDXJafcBxNCb8vTbezUbGFGGI1IdopaES0=
X-Google-Smtp-Source: AGHT+IFR4M7meuUy4uWIDYKJzzMOiHlBO/s6aOp1FUWvMGXeihfS8CUIERxE0roBkIUo78I59VSTlw==
X-Received: by 2002:a2e:9190:0:b0:2b6:e651:8591 with SMTP id f16-20020a2e9190000000b002b6e6518591mr6417152ljg.37.1691401025805;
        Mon, 07 Aug 2023 02:37:05 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:ea0f:cf41:6751:30d5])
        by smtp.gmail.com with ESMTPSA id v13-20020a1cf70d000000b003fe17901fcdsm14539885wmh.32.2023.08.07.02.37.05
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 02:37:05 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH v2] siggen: Improve runtaskdeps data to fix sstate debugging
Date: Mon,  7 Aug 2023 10:36:58 +0100
Message-Id: <20230807093658.2866546-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 07 Aug 2023 09:37:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14921

The runtaskdep data in siginfo files was written out with full paths to
the bb files, matching bitbake's internal "unique key" ID for recipes/tasks.
When originally implemented this made sense.

Over time, the main use for the data in siginfo files has become to match
against other siginfo files to debug changes of hash calcuations. The
recipename data is not useful for this as the siginfo filenames use PN
instead which can often be derived from the recipe filename but not always.

It is time to throw away the 'tid' data format and switch over the use a
hybrid PN form which includes the multiconfig. That can be easily stripped
off in the find_siginfo code in oe-core.

The other purpose of having a sortable dependency ID is retained and the
multiconfig needs to be included to allow the taskhashes to be processed
and calculated correctly. PN is meant to be unique between recipes, only
one would ever be built so using PN in this location is fine.

The one risk of this change is there isn't any compatibility to the old
format. I'm not convinced we should spend time complicating the code
with it. This change will change the taskhashes everywhere so the only
mixing of old and new siginfo files will be either through hash equivalence
or through users using the tool against old and new info files manually
which will give some weird output but it should be clear they're in
different formats as there would be large paths from the old files not
present in the new ones.

We have options to add backwards compatibility if some issue is found
to need that.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/siggen.py       | 72 +++++++++++++--------------------------
 lib/bb/tests/siggen.py | 77 ++++--------------------------------------
 2 files changed, 31 insertions(+), 118 deletions(-)

v2 - fix bitbake-selftest and remove obsolete test cases

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index c4ff9d8de1..d0a555654b 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -182,6 +182,11 @@ class SignatureGenerator(object):
     def exit(self):
         return
 
+def build_pnid(mc, pn, taskname):
+    if mc:
+        return "mc:" + mc + ":" + pn + ":" + taskname
+    return pn + ":" + taskname
+
 class SignatureGeneratorBasic(SignatureGenerator):
     """
     """
@@ -309,15 +314,19 @@ class SignatureGeneratorBasic(SignatureGenerator):
         recipename = dataCaches[mc].pkg_fn[mcfn]
 
         self.tidtopn[tid] = recipename
+        # save hashfn for deps into siginfo?
+        for dep in deps:
+            (depmc, _, deptask, depmcfn) = bb.runqueue.split_tid_mcfn(dep)
+            dep_pn = dataCaches[depmc].pkg_fn[depmcfn]
 
-        for dep in sorted(deps, key=clean_basepath):
-            (depmc, _, _, depmcfn) = bb.runqueue.split_tid_mcfn(dep)
-            depname = dataCaches[depmc].pkg_fn[depmcfn]
-            if not self.rundep_check(mcfn, recipename, task, dep, depname, dataCaches):
+            if not self.rundep_check(mcfn, recipename, task, dep, dep_pn, dataCaches):
                 continue
+
             if dep not in self.taskhash:
                 bb.fatal("%s is not in taskhash, caller isn't calling in dependency order?" % dep)
-            self.runtaskdeps[tid].append(dep)
+
+            dep_pnid = build_pnid(depmc, dep_pn, deptask)
+            self.runtaskdeps[tid].append((dep_pnid, dep))
 
         if task in dataCaches[mc].file_checksums[mcfn]:
             if self.checksum_cache:
@@ -348,8 +357,8 @@ class SignatureGeneratorBasic(SignatureGenerator):
     def get_taskhash(self, tid, deps, dataCaches):
 
         data = self.basehash[tid]
-        for dep in self.runtaskdeps[tid]:
-            data += self.get_unihash(dep)
+        for dep in sorted(self.runtaskdeps[tid]):
+            data += self.get_unihash(dep[1])
 
         for (f, cs) in self.file_checksum_values[tid]:
             if cs:
@@ -414,7 +423,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
             data['varvals'][dep] = self.datacaches[mc].siggen_varvals[mcfn][dep]
 
         if runtime and tid in self.taskhash:
-            data['runtaskdeps'] = self.runtaskdeps[tid]
+            data['runtaskdeps'] = [dep[0] for dep in sorted(self.runtaskdeps[tid])]
             data['file_checksum_values'] = []
             for f,cs in self.file_checksum_values[tid]:
                 if "/./" in f:
@@ -422,8 +431,8 @@ class SignatureGeneratorBasic(SignatureGenerator):
                 else:
                     data['file_checksum_values'].append((os.path.basename(f), cs))
             data['runtaskhashes'] = {}
-            for dep in data['runtaskdeps']:
-                data['runtaskhashes'][dep] = self.get_unihash(dep)
+            for dep in self.runtaskdeps[tid]:
+                data['runtaskhashes'][dep[0]] = self.get_unihash(dep[1])
             data['taskhash'] = self.taskhash[tid]
             data['unihash'] = self.get_unihash(tid)
 
@@ -793,39 +802,6 @@ def list_inline_diff(oldlist, newlist, colors=None):
             ret.append(item)
     return '[%s]' % (', '.join(ret))
 
-def clean_basepath(basepath):
-    basepath, dir, recipe_task = basepath.rsplit("/", 2)
-    cleaned = dir + '/' + recipe_task
-
-    if basepath[0] == '/':
-        return cleaned
-
-    if basepath.startswith("mc:") and basepath.count(':') >= 2:
-        mc, mc_name, basepath = basepath.split(":", 2)
-        mc_suffix = ':mc:' + mc_name
-    else:
-        mc_suffix = ''
-
-    # mc stuff now removed from basepath. Whatever was next, if present will be the first
-    # suffix. ':/', recipe path start, marks the end of this. Something like
-    # 'virtual:a[:b[:c]]:/path...' (b and c being optional)
-    if basepath[0] != '/':
-        cleaned += ':' + basepath.split(':/', 1)[0]
-
-    return cleaned + mc_suffix
-
-def clean_basepaths(a):
-    b = {}
-    for x in a:
-        b[clean_basepath(x)] = a[x]
-    return b
-
-def clean_basepaths_list(a):
-    b = []
-    for x in a:
-        b.append(clean_basepath(x))
-    return b
-
 # Handled renamed fields
 def handle_renames(data):
     if 'basewhitelist' in data:
@@ -994,11 +970,11 @@ def compare_sigfiles(a, b, recursecb=None, color=False, collapsed=False):
                 a = a_data['runtaskdeps'][idx]
                 b = b_data['runtaskdeps'][idx]
                 if a_data['runtaskhashes'][a] != b_data['runtaskhashes'][b] and not collapsed:
-                    changed.append("%s with hash %s\n changed to\n%s with hash %s" % (clean_basepath(a), a_data['runtaskhashes'][a], clean_basepath(b), b_data['runtaskhashes'][b]))
+                    changed.append("%s with hash %s\n changed to\n%s with hash %s" % (a, a_data['runtaskhashes'][a], b, b_data['runtaskhashes'][b]))
 
         if changed:
-            clean_a = clean_basepaths_list(a_data['runtaskdeps'])
-            clean_b = clean_basepaths_list(b_data['runtaskdeps'])
+            clean_a = a_data['runtaskdeps']
+            clean_b = b_data['runtaskdeps']
             if clean_a != clean_b:
                 output.append(color_format("{color_title}runtaskdeps changed:{color_default}\n%s") % list_inline_diff(clean_a, clean_b, colors))
             else:
@@ -1007,8 +983,8 @@ def compare_sigfiles(a, b, recursecb=None, color=False, collapsed=False):
 
 
     if 'runtaskhashes' in a_data and 'runtaskhashes' in b_data:
-        a = clean_basepaths(a_data['runtaskhashes'])
-        b = clean_basepaths(b_data['runtaskhashes'])
+        a = a_data['runtaskhashes']
+        b = b_data['runtaskhashes']
         changed, added, removed = dict_diff(a, b)
         if added:
             for dep in sorted(added):
diff --git a/lib/bb/tests/siggen.py b/lib/bb/tests/siggen.py
index c21ab4e4fb..0dc67e6cc2 100644
--- a/lib/bb/tests/siggen.py
+++ b/lib/bb/tests/siggen.py
@@ -17,75 +17,12 @@ import bb.siggen
 
 class SiggenTest(unittest.TestCase):
 
-    def test_clean_basepath_simple_target_basepath(self):
-        basepath = '/full/path/to/poky/meta/recipes-whatever/helloworld/helloworld_1.2.3.bb:do_sometask'
-        expected_cleaned = 'helloworld/helloworld_1.2.3.bb:do_sometask'
+    def test_build_pnid(self):
+        tests = {
+            ('', 'helloworld', 'do_sometask') : 'helloworld:do_sometask',
+            ('XX', 'helloworld', 'do_sometask') : 'mc:XX:helloworld:do_sometask',
+        }
 
-        actual_cleaned = bb.siggen.clean_basepath(basepath)
+        for t in tests:
+            self.assertEqual(bb.siggen.build_pnid(*t), tests[t])
 
-        self.assertEqual(actual_cleaned, expected_cleaned)
-
-    def test_clean_basepath_basic_virtual_basepath(self):
-        basepath = 'virtual:something:/full/path/to/poky/meta/recipes-whatever/helloworld/helloworld_1.2.3.bb:do_sometask'
-        expected_cleaned = 'helloworld/helloworld_1.2.3.bb:do_sometask:virtual:something'
-
-        actual_cleaned = bb.siggen.clean_basepath(basepath)
-
-        self.assertEqual(actual_cleaned, expected_cleaned)
-
-    def test_clean_basepath_mc_basepath(self):
-        basepath = 'mc:somemachine:/full/path/to/poky/meta/recipes-whatever/helloworld/helloworld_1.2.3.bb:do_sometask'
-        expected_cleaned = 'helloworld/helloworld_1.2.3.bb:do_sometask:mc:somemachine'
-
-        actual_cleaned = bb.siggen.clean_basepath(basepath)
-
-        self.assertEqual(actual_cleaned, expected_cleaned)
-
-    def test_clean_basepath_virtual_long_prefix_basepath(self):
-        basepath = 'virtual:something:A:B:C:/full/path/to/poky/meta/recipes-whatever/helloworld/helloworld_1.2.3.bb:do_sometask'
-        expected_cleaned = 'helloworld/helloworld_1.2.3.bb:do_sometask:virtual:something:A:B:C'
-
-        actual_cleaned = bb.siggen.clean_basepath(basepath)
-
-        self.assertEqual(actual_cleaned, expected_cleaned)
-
-    def test_clean_basepath_mc_virtual_basepath(self):
-        basepath = 'mc:somemachine:virtual:something:/full/path/to/poky/meta/recipes-whatever/helloworld/helloworld_1.2.3.bb:do_sometask'
-        expected_cleaned = 'helloworld/helloworld_1.2.3.bb:do_sometask:virtual:something:mc:somemachine'
-
-        actual_cleaned = bb.siggen.clean_basepath(basepath)
-
-        self.assertEqual(actual_cleaned, expected_cleaned)
-
-    def test_clean_basepath_mc_virtual_long_prefix_basepath(self):
-        basepath = 'mc:X:virtual:something:C:B:A:/full/path/to/poky/meta/recipes-whatever/helloworld/helloworld_1.2.3.bb:do_sometask'
-        expected_cleaned = 'helloworld/helloworld_1.2.3.bb:do_sometask:virtual:something:C:B:A:mc:X'
-
-        actual_cleaned = bb.siggen.clean_basepath(basepath)
-
-        self.assertEqual(actual_cleaned, expected_cleaned)
-
-
-    # def test_clean_basepath_performance(self):
-    #     input_basepaths = [
-    #         'mc:X:/full/path/to/poky/meta/recipes-whatever/helloworld/helloworld_1.2.3.bb:do_sometask',
-    #         'mc:X:virtual:something:C:B:A:/full/path/to/poky/meta/recipes-whatever/helloworld/helloworld_1.2.3.bb:do_sometask',
-    #         'virtual:something:C:B:A:/different/path/to/poky/meta/recipes-whatever/helloworld/helloworld_1.2.3.bb:do_sometask',
-    #         'virtual:something:A:/full/path/to/poky/meta/recipes-whatever/helloworld/helloworld_1.2.3.bb:do_sometask',
-    #         '/this/is/most/common/input/recipes-whatever/helloworld/helloworld_1.2.3.bb:do_sometask',
-    #         '/and/should/be/tested/with/recipes-whatever/helloworld/helloworld_1.2.3.bb:do_sometask',
-    #         '/more/weight/recipes-whatever/helloworld/helloworld_1.2.3.bb:do_sometask',
-    #     ]
-
-    #     time_start = time.time()
-
-    #     i = 2000000
-    #     while i >= 0:
-    #         for basepath in input_basepaths:
-    #             bb.siggen.clean_basepath(basepath)
-    #         i -= 1
-
-    #     elapsed = time.time() - time_start
-    #     print('{} ({}s)'.format(self.id(), round(elapsed, 3)))
-
-    #     self.assertTrue(False)
-- 
2.39.2


