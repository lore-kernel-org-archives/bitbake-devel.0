Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
	[209.85.221.66])
	by mail.openembedded.org (Postfix) with ESMTP id 1EC867E510
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  7 Jun 2019 15:48:13 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id p11so2648338wre.7
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 07 Jun 2019 08:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=60G88z340GJ+y6vt5Tke7rZFpjvc10/LZry5EDimhuQ=;
	b=PhlBpoh/MXpRRDrHz+8F+nUa6Tx1g/Sc3Hfh7+IBPe68X1tQWAWKC1zvYYLHsaV9ns
	UDA5v8ggYlWDU7FPssGW/eP3zALQUgrwXDcbObDTLG6MyfBZv9YTabRQTZJFElTzGJLA
	3ZI2mTMXf3+ZBdBbF9r/Tui6lYAW2lmXMNMPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=60G88z340GJ+y6vt5Tke7rZFpjvc10/LZry5EDimhuQ=;
	b=G/WlRk/pB8R4ApIHmbsunCHD9dTfjxixDGLyLom5sslJPmHZdyeWAdSNkE96sleA43
	hTBZ6o8AcizJxPdewQPnpknWHitlgyu33YjqeyL1Zkf3puz9nwFsFUyXEfwFHMQWVu5N
	2L3h448hV7qNY8pPCu1FAevXVV8Pjd7xQb+Ef9GV9hSr81ddRyYlJRe0pdv+nKdoKoHw
	NXFNhzdX3H5orv92B8kFuGdA2tOIv17I2dwUUzPwMrneZmeR1JhmlwwaSQlAn2O4ej8c
	hZEBfV065V7GN/ViHl+Gk2589qrvG9F4r0HW9yHF/gB/kD20+MZVfSR0bbnMIqWd7cRg
	fhhg==
X-Gm-Message-State: APjAAAXMnYN9p0DIqPFZ/aGX39jBaxT48pMUSATtoAK0vJrjN/vawLC1
	d4LOgttmQlk2UewuUjxkDX8N3I3wHZk=
X-Google-Smtp-Source: APXvYqwN9MOjV0UNTNhdXUyBj3IDupUPFNW3GwdSWxSqNLmb0VM5xmoAi+hUAZ6uE09z6PDekUDvQg==
X-Received: by 2002:a5d:6207:: with SMTP id y7mr15469297wru.265.1559922494395; 
	Fri, 07 Jun 2019 08:48:14 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	x129sm3027811wmg.44.2019.06.07.08.48.13
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 07 Jun 2019 08:48:13 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  7 Jun 2019 16:48:12 +0100
Message-Id: <20190607154812.15852-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Subject: [PATCH] multiconfig: Switch from 'multiconfig' -> 'mc'
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
X-List-Received-Date: Fri, 07 Jun 2019 15:48:14 -0000
Content-Transfer-Encoding: 8bit

After real world use its clear the "multiconfig:" prefix to multiconfig tasks,
whilst clear, is also clumbersome. Switch to use the short version instead.

mcdepends will continue to work with "multiconfig:" for now as well. The commandline
will only accept mc: going forward.

[YOCTO #11168]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cache.py    | 12 ++++++------
 lib/bb/cooker.py   | 18 +++++++++---------
 lib/bb/runqueue.py |  8 ++++----
 lib/bb/siggen.py   |  8 ++++----
 lib/bb/taskdata.py |  2 +-
 5 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index 060758e0c4..5fb2f17cda 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -237,7 +237,7 @@ def virtualfn2realfn(virtualfn):
     Convert a virtual file name to a real one + the associated subclass keyword
     """
     mc = ""
-    if virtualfn.startswith('multiconfig:'):
+    if virtualfn.startswith('mc:'):
         elems = virtualfn.split(':')
         mc = elems[1]
         virtualfn = ":".join(elems[2:])
@@ -258,7 +258,7 @@ def realfn2virtual(realfn, cls, mc):
     if cls:
         realfn = "virtual:" + cls + ":" + realfn
     if mc:
-        realfn = "multiconfig:" + mc + ":" + realfn
+        realfn = "mc:" + mc + ":" + realfn
     return realfn
 
 def variant2virtual(realfn, variant):
@@ -267,11 +267,11 @@ def variant2virtual(realfn, variant):
     """
     if variant == "":
         return realfn
-    if variant.startswith("multiconfig:"):
+    if variant.startswith("mc:"):
         elems = variant.split(":")
         if elems[2]:
-            return "multiconfig:" + elems[1] + ":virtual:" + ":".join(elems[2:]) + ":" + realfn
-        return "multiconfig:" + elems[1] + ":" + realfn
+            return "mc:" + elems[1] + ":virtual:" + ":".join(elems[2:]) + ":" + realfn
+        return "mc:" + elems[1] + ":" + realfn
     return "virtual:" + variant + ":" + realfn
 
 def parse_recipe(bb_data, bbfile, appends, mc=''):
@@ -349,7 +349,7 @@ class NoCache(object):
             bb_data = self.databuilder.mcdata[mc].createCopy()
             newstores = parse_recipe(bb_data, bbfile, appends, mc)
             for ns in newstores:
-                datastores["multiconfig:%s:%s" % (mc, ns)] = newstores[ns]
+                datastores["mc:%s:%s" % (mc, ns)] = newstores[ns]
 
         return datastores
 
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index d183abab6d..855a180523 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -505,7 +505,7 @@ class BBCooker:
             self.reset()
 
         def mc_base(p):
-            if p.startswith('multiconfig:'):
+            if p.startswith('mc:'):
                 s = p.split(':')
                 if len(s) == 2:
                     return s[1]
@@ -583,10 +583,10 @@ class BBCooker:
         wildcard = False
 
         # Wild card expansion:
-        # Replace string such as "multiconfig:*:bash"
-        # into "multiconfig:A:bash multiconfig:B:bash bash"
+        # Replace string such as "mc:*:bash"
+        # into "mc:A:bash mc:B:bash bash"
         for k in targetlist:
-            if k.startswith("multiconfig:"):
+            if k.startswith("mc:"):
                 if wildcard:
                     bb.fatal('multiconfig conflict')
                 if k.split(":")[1] == "*":
@@ -619,7 +619,7 @@ class BBCooker:
         runlist = []
         for k in fulltargetlist:
             mc = ""
-            if k.startswith("multiconfig:"):
+            if k.startswith("mc:"):
                 mc = k.split(":")[1]
                 k = ":".join(k.split(":")[2:])
             ktask = task
@@ -700,7 +700,7 @@ class BBCooker:
     @staticmethod
     def add_mc_prefix(mc, pn):
         if mc:
-            return "multiconfig:%s:%s" % (mc, pn)
+            return "mc:%s:%s" % (mc, pn)
         return pn
 
     def buildDependTree(self, rq, taskdata):
@@ -1477,7 +1477,7 @@ class BBCooker:
         ntargets = []
         for target in runlist:
             if target[0]:
-                ntargets.append("multiconfig:%s:%s:%s" % (target[0], target[1], target[2]))
+                ntargets.append("mc:%s:%s:%s" % (target[0], target[1], target[2]))
             ntargets.append("%s:%s" % (target[1], target[2]))
 
         for mc in self.multiconfigs:
@@ -1607,7 +1607,7 @@ class BBCooker:
                 bb.providers.buildWorldTargetList(self.recipecaches[mc], task)
                 for t in self.recipecaches[mc].world_target:
                     if mc:
-                        t = "multiconfig:" + mc + ":" + t
+                        t = "mc:" + mc + ":" + t
                     pkgs_to_build.append(t)
 
         if 'universe' in pkgs_to_build:
@@ -1626,7 +1626,7 @@ class BBCooker:
                             bb.debug(1, "Skipping %s for universe tasks as task %s doesn't exist" % (t, task))
                             continue
                     if mc:
-                        t = "multiconfig:" + mc + ":" + t
+                        t = "mc:" + mc + ":" + t
                     pkgs_to_build.append(t)
 
         return pkgs_to_build
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index d573ed460e..010b085010 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -39,7 +39,7 @@ def taskname_from_tid(tid):
     return tid.rsplit(":", 1)[1]
 
 def mc_from_tid(tid):
-    if tid.startswith('multiconfig:'):
+    if tid.startswith('mc:'):
         return tid.split(':')[1]
     return ""
 
@@ -48,12 +48,12 @@ def split_tid(tid):
     return (mc, fn, taskname)
 
 def split_tid_mcfn(tid):
-    if tid.startswith('multiconfig:'):
+    if tid.startswith('mc:'):
         elems = tid.split(':')
         mc = elems[1]
         fn = ":".join(elems[2:-1])
         taskname = elems[-1]
-        mcfn = "multiconfig:" + mc + ":" + fn
+        mcfn = "mc:" + mc + ":" + fn
     else:
         tid = tid.rsplit(":", 1)
         mc = ""
@@ -65,7 +65,7 @@ def split_tid_mcfn(tid):
 
 def build_tid(mc, fn, taskname):
     if mc:
-        return "multiconfig:" + mc + ":" + fn + ":" + taskname
+        return "mc:" + mc + ":" + fn + ":" + taskname
     return fn + ":" + taskname
 
 class RunQueueStats:
diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index e0a66e68d5..fe580e487f 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -179,7 +179,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
     def get_taskhash(self, fn, task, deps, dataCache):
 
         mc = ''
-        if fn.startswith('multiconfig:'):
+        if fn.startswith('mc:'):
             mc = fn.split(':')[1]
         k = fn + "." + task
 
@@ -194,7 +194,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
                 depmc = pkgname.split(':')[1]
                 if mc != depmc:
                     continue
-            if dep.startswith("multiconfig:") and not mc:
+            if dep.startswith("mc:") and not mc:
                 continue
             depname = dataCache.pkg_fn[pkgname]
             if not self.rundep_check(fn, recipename, task, dep, depname, dataCache):
@@ -412,13 +412,13 @@ def list_inline_diff(oldlist, newlist, colors=None):
 
 def clean_basepath(a):
     mc = None
-    if a.startswith("multiconfig:"):
+    if a.startswith("mc:"):
         _, mc, a = a.split(":", 2)
     b = a.rsplit("/", 2)[1] + '/' + a.rsplit("/", 2)[2]
     if a.startswith("virtual:"):
         b = b + ":" + a.rsplit(":", 1)[0]
     if mc:
-        b = b + ":multiconfig:" + mc
+        b = b + ":mc:" + mc
     return b
 
 def clean_basepaths(a):
diff --git a/lib/bb/taskdata.py b/lib/bb/taskdata.py
index c7de3db38d..d13bd7c3bf 100644
--- a/lib/bb/taskdata.py
+++ b/lib/bb/taskdata.py
@@ -81,7 +81,7 @@ class TaskData:
         def add_mcdepends(task):
             for dep in task_deps['mcdepends'][task].split():
                 if len(dep.split(':')) != 5:
-                    bb.msg.fatal("TaskData", "Error for %s:%s[%s], multiconfig dependency %s does not contain exactly four  ':' characters.\n Task '%s' should be specified in the form 'multiconfig:fromMC:toMC:packagename:task'" % (fn, task, 'mcdepends', dep, 'mcdepends'))
+                    bb.msg.fatal("TaskData", "Error for %s:%s[%s], multiconfig dependency %s does not contain exactly four  ':' characters.\n Task '%s' should be specified in the form 'mc:fromMC:toMC:packagename:task'" % (fn, task, 'mcdepends', dep, 'mcdepends'))
                 if dep not in self.mcdepends:
                     self.mcdepends.append(dep)
 
-- 
2.20.1


