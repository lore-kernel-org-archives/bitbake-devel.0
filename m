Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
	[209.85.221.66])
	by mail.openembedded.org (Postfix) with ESMTP id 6D2CB79BF0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 18 Oct 2018 09:22:54 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id e4-v6so32828241wrs.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 18 Oct 2018 02:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=LyooG4yvhpkR+qRrKh4Dr4R0aQCkMKG5QdxP0rmlGJI=;
	b=gZLrHSvxfEEvI+VZZ0NmCMdWsAuYTNpjIuaMEsWie52KuO5XNewhIoUJ44Ow+yZtZ5
	nHsihgbWkspuWTPxjqP1NWxrjyWToMtsV91z5A0pEEs3iP91/rYS3BbXhAOsGAk2MUlo
	vNatMIuofKPwrDutI/PP2aiI6Fv2NjvnOJ1mk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=LyooG4yvhpkR+qRrKh4Dr4R0aQCkMKG5QdxP0rmlGJI=;
	b=Y2LpjSKEbiI5zoo93ttLTjSXilHdTFg6w9oe3UkX2XhJLiSFX6EgOIxbnQtVKxN32e
	gflFXl16vXe+7J53dxVbcEz3vbZ0IGlaLouzFlagFjeE0Gz51hF7ciqsB7CXidtSNHWH
	w0MzB3TkPFRa77w+NWYMG/Dd85P9tWy5j1jH0iZ6c/p3qr1Fe6YfUhFVktTE/vNZmBv1
	4OsYo0AY4KAwgv1sRzz3JpI1rK+H0dbaXR6qBGYNq1wA7Y9JiVT0CDS2KdoCcGbXscVE
	XUhF8lBQosouGKZzBmCAsZ2kcPNvzkGX9GT7aHWBqrycTctHY44s5k88KPsgSpmXgpur
	y5+w==
X-Gm-Message-State: AGRZ1gKryc98KNT0iNgBuRv/8FIHVL7N297wRBFueiitaQrr1+E6fBFu
	98QtSMe9dQE2OmaxBk3lXP+zcyIh2w0=
X-Google-Smtp-Source: AJdET5d3gd51ypabSXT+SgsA2D8aU+gCFX/k0Kd3xFFEOS7TutP6KNhqN7qQ0uaGN4fs2ceLpXPy+g==
X-Received: by 2002:a5d:62c2:: with SMTP id o2-v6mr1023792wrv.27.1539854574577;
	Thu, 18 Oct 2018 02:22:54 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	x17-v6sm17666494wrs.84.2018.10.18.02.22.53
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 18 Oct 2018 02:22:53 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 18 Oct 2018 10:22:45 +0100
Message-Id: <20181018092246.1445-6-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181018092246.1445-1-richard.purdie@linuxfoundation.org>
References: <20181018092246.1445-1-richard.purdie@linuxfoundation.org>
Subject: [PATCH 6/7] data/siggen: Extract task hash generation code into a function
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
X-List-Received-Date: Thu, 18 Oct 2018 09:22:54 -0000

By creating a standalone function, we can add better functional testing
of this code.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/data.py   | 38 ++++++++++++++++++++++++++++++++++++++
 lib/bb/siggen.py | 37 ++++---------------------------------
 2 files changed, 42 insertions(+), 33 deletions(-)

diff --git a/lib/bb/data.py b/lib/bb/data.py
index fde4cba6bb..d66d98cc8b 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -38,6 +38,7 @@ the speed is more critical here.
 # Based on functions from the base bb module, Copyright 2003 Holger Schurig
 
 import sys, os, re
+import hashlib
 if sys.argv[0][-5:] == "pydoc":
     path = os.path.dirname(os.path.dirname(sys.argv[1]))
 else:
@@ -405,6 +406,43 @@ def generate_dependencies(d):
         #print "For %s: %s" % (task, str(deps[task]))
     return tasklist, deps, values
 
+def generate_dependency_hash(tasklist, gendeps, lookupcache, whitelist, fn):
+    taskdeps = {}
+    basehash = {}
+
+    for task in tasklist:
+        data = lookupcache[task]
+
+        if data is None:
+            bb.error("Task %s from %s seems to be empty?!" % (task, fn))
+            data = ''
+
+        gendeps[task] -= whitelist
+        newdeps = gendeps[task]
+        seen = set()
+        while newdeps:
+            nextdeps = newdeps
+            seen |= nextdeps
+            newdeps = set()
+            for dep in nextdeps:
+                if dep in whitelist:
+                    continue
+                gendeps[dep] -= whitelist
+                newdeps |= gendeps[dep]
+            newdeps -= seen
+
+        alldeps = sorted(seen)
+        for dep in alldeps:
+            data = data + dep
+            var = lookupcache[dep]
+            if var is not None:
+                data = data + str(var)
+        k = fn + "." + task
+        basehash[k] = hashlib.md5(data.encode("utf-8")).hexdigest()
+        taskdeps[task] = alldeps
+
+    return taskdeps, basehash
+
 def inherits_class(klass, d):
     val = d.getVar('__inherit_cache', False) or []
     needle = os.path.join('classes', '%s.bbclass' % klass)
diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index e9bb51d736..03c824ec38 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -110,42 +110,13 @@ class SignatureGeneratorBasic(SignatureGenerator):
         ignore_mismatch = ((d.getVar("BB_HASH_IGNORE_MISMATCH") or '') == '1')
         tasklist, gendeps, lookupcache = bb.data.generate_dependencies(d)
 
-        taskdeps = {}
-        basehash = {}
+        taskdeps, basehash = bb.data.generate_dependency_hash(tasklist, gendeps, lookupcache, self.basewhitelist, fn)
 
         for task in tasklist:
-            data = lookupcache[task]
-
-            if data is None:
-                bb.error("Task %s from %s seems to be empty?!" % (task, fn))
-                data = ''
-
-            gendeps[task] -= self.basewhitelist
-            newdeps = gendeps[task]
-            seen = set()
-            while newdeps:
-                nextdeps = newdeps
-                seen |= nextdeps
-                newdeps = set()
-                for dep in nextdeps:
-                    if dep in self.basewhitelist:
-                        continue
-                    gendeps[dep] -= self.basewhitelist
-                    newdeps |= gendeps[dep]
-                newdeps -= seen
-
-            alldeps = sorted(seen)
-            for dep in alldeps:
-                data = data + dep
-                var = lookupcache[dep]
-                if var is not None:
-                    data = data + str(var)
-            datahash = hashlib.md5(data.encode("utf-8")).hexdigest()
             k = fn + "." + task
-            if not ignore_mismatch and k in self.basehash and self.basehash[k] != datahash:
-                bb.error("When reparsing %s, the basehash value changed from %s to %s. The metadata is not deterministic and this needs to be fixed." % (k, self.basehash[k], datahash))
-            self.basehash[k] = datahash
-            taskdeps[task] = alldeps
+            if not ignore_mismatch and k in self.basehash and self.basehash[k] != basehash[k]:
+                bb.error("When reparsing %s, the basehash value changed from %s to %s. The metadata is not deterministic and this needs to be fixed." % (k, self.basehash[k], basehash[k]))
+            self.basehash[k] = basehash[k]
 
         self.taskdeps[fn] = taskdeps
         self.gendeps[fn] = gendeps
-- 
2.17.1


