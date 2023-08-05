Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4CBEB64DD
	for <webhook@archiver.kernel.org>; Sat,  5 Aug 2023 10:32:10 +0000 (UTC)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
 by mx.groups.io with SMTP id smtpd.web10.3657.1691231526537539690
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 05 Aug 2023 03:32:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=JQn3Z4/O;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.208.176, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2b9d3dacb33so46979421fa.1
        for <bitbake-devel@lists.openembedded.org>; Sat, 05 Aug 2023 03:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1691231524; x=1691836324;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=yRN+9kEFaaU33lhmY11MYoYfMJBN+FBLGNzq8/aspUw=;
        b=JQn3Z4/O10o9nPkTUS6RNk5230fG4JxAzM90NuZGzczlo62nCS+lecpLbbE/rbL7/n
         d9KWZKdPUPINygCJxf7jLofus2gsM2JM9fAiQPTqYWLbDfVVvshypM9cNtEF+tqMJpqV
         7PD5Wl20TRn57+xGJ7hy+4dFWhfsiQ6RGLUXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691231524; x=1691836324;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yRN+9kEFaaU33lhmY11MYoYfMJBN+FBLGNzq8/aspUw=;
        b=hF8hezHemrkYJ8m6ffcSpbSdzO9jLs1BouI95NG4SPUV5DNdUGTZhYgbzjJF7v0HUP
         ir5ZVBOyxlFQFw3vGCsJjjgt1M4VBroIQgn5/2SCMj0kNgKcQjljrK/FvOKkJ89rYwpo
         QV0T51/uOiJ+6Nm8rIfYdpHGsp3LoFxH0dCSHbzLkmTJtwmRV+1NEq4G01XLlOtM24Vn
         z9YXrxXYcnO7mbzgvy+yij+DimPIfW3omGNC0NtVfxGb7bF7mwh+nXtJhwH0WyJujv8O
         In8tBTPflzU7aaQ33ORKzCeyhQZJznHhJHs41As71KOuPibWI4W2uLCsLGFJLRduf3d+
         LgnA==
X-Gm-Message-State: AOJu0Yxzno/e0sEyjI3Q7hMggFLj+dqaHXJkNEr0S1OHZUCv2kU/9Qpc
	7tMzsNJ98yx/LV0AtT0lyKzdte/M8JKFHpP0Jzc=
X-Google-Smtp-Source: AGHT+IHgsbmtiOw2jVuft7q6Kc6kL6mD/nwKtm5nBvqMTl/ukgciXOVPUS8kJfCEQw5XmMJQX3sOig==
X-Received: by 2002:a2e:781a:0:b0:2b9:ac48:d7fb with SMTP id t26-20020a2e781a000000b002b9ac48d7fbmr3436673ljc.41.1691231523411;
        Sat, 05 Aug 2023 03:32:03 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:1adf:6477:9da8:f35a])
        by smtp.gmail.com with ESMTPSA id l26-20020a1c791a000000b003fbb06af219sm4611729wme.32.2023.08.05.03.32.02
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Aug 2023 03:32:02 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] siggen: Improve runtaskdeps data to fix sstate debugging
Date: Sat,  5 Aug 2023 11:32:01 +0100
Message-Id: <20230805103201.2648673-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 05 Aug 2023 10:32:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14917

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
 lib/bb/siggen.py | 72 ++++++++++++++++--------------------------------
 1 file changed, 24 insertions(+), 48 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index c4ff9d8de1..952419b18c 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -299,6 +299,11 @@ class SignatureGeneratorBasic(SignatureGenerator):
             pass
         return taint
 
+    def build_pnid(self, mc, pn, taskname):
+        if mc:
+            return "mc:" + mc + ":" + pn + ":" + taskname
+        return pn + ":" + taskname
+
     def prep_taskhash(self, tid, deps, dataCaches):
 
         (mc, _, task, mcfn) = bb.runqueue.split_tid_mcfn(tid)
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
+            dep_pnid = self.build_pnid(depmc, dep_pn, deptask)
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
-- 
2.39.2


