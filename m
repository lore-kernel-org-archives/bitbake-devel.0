Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D61C00140
	for <webhook@archiver.kernel.org>; Fri, 12 Aug 2022 10:48:15 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web09.9298.1660301286910141435
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 12 Aug 2022 03:48:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ACSDtSLh;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.48,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f48.google.com with SMTP id n4so761854wrp.10
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 12 Aug 2022 03:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc;
        bh=4DdM4+ddf3WfEn5GN6hJlBVvbJnNojK0ggH5c2d+vWY=;
        b=ACSDtSLhlCCspx9AxZ0p0wlqc+n/bVgAuFZTY80c0gcPJV563WAtqsKl6FUrDxqoqv
         qkc1QfNhyHqAGKqpDHjDG96sRy/TCrHzHy0/MegPTtqGfrm8PUVNEsmHIqZvrVb2DvAT
         goarfT5G3YuhxyEGXVH2iQU24X2qYrt8Sz9+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc;
        bh=4DdM4+ddf3WfEn5GN6hJlBVvbJnNojK0ggH5c2d+vWY=;
        b=Yy3sEc8yHcljbw9Tf966EBLL4LCejNjiI9zwL6Ny97qJdrVYp8+jureBL9JYNsb0Fy
         89g/PjGTM4e1LXAGX07dfGzZNyCb8z24c0pqGyElauxv/fbzN4UvO53hVsNGIu2hCCoo
         AIwZUULvcQzyrXTxOPDmFKvC1gXLE/9n6785yq4udIQ8aPxN6As8PJObtH0qf5fXtCH1
         lmUVAcwJ4h3IQ4dJKfrDz5XZDpK1RNEA0Oc8AE+IVmrmqBozyP/6ivOdfaZRZWDqmzbo
         VaFoqcNdOCAYBpOXRbtmU3un1tG80sWRej2Nn3/17assZi1LtGl1u7OCjgbP8BZXCaln
         UiMw==
X-Gm-Message-State: ACgBeo2AHYvIHdxA3dbzM29zZ7YL4sUlck9jN0RO3vw0F5t73CEzukvE
	N7Rhadh8D4mFgbRJZA+pMcnTfAqp/hMw8g==
X-Google-Smtp-Source: 
 AA6agR7dXwpk+tbZhSgcjoeB3skhPRNbYoBKPjfMVj1eGhr68yjaYlWcJvIRJwBMj/WBHM9gsM01Ng==
X-Received: by 2002:a05:6000:986:b0:220:7d86:46e3 with SMTP id
 by6-20020a056000098600b002207d8646e3mr1668390wrb.142.1660301285039;
        Fri, 12 Aug 2022 03:48:05 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:c425:95a5:4141:7147])
        by smtp.gmail.com with ESMTPSA id
 k7-20020a05600c1c8700b003a2f6367049sm2536041wms.48.2022.08.12.03.48.04
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 03:48:04 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH v2] BBHandler/cooker: Implement recipe and global classes
Date: Fri, 12 Aug 2022 11:48:04 +0100
Message-Id: <20220812104804.827651-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 12 Aug 2022 10:48:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13892

We have some confusion for users since some classes are meant to work
in the configuration space (or "globally") and some are meant to be
selected by recipes individually.

The cleanest way I could find to clarify this is to create "classes-global"
and "classes-recipe" directories which contain the approproate classes and
have bitbake switch scope between them at the appropriate point during
parsing. The existing "classes" directory is always searched as a fallback.

Once a class is moved to a specific directory, it will no longer be found
in the incorrect context. A good example from OE is that

INHERIT += "testimage"

will no longer work but

IMAGE_CLASSES += "testimage"

will, which makes the global scope cleaner by only including it where it
is useful and intended to be used (images).

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bin/bitbake-worker                 |  1 +
 lib/bb/cooker.py                   |  1 +
 lib/bb/cookerdata.py               |  1 +
 lib/bb/data.py                     |  2 +-
 lib/bb/parse/parse_py/BBHandler.py | 29 ++++++++++++++++++-----------
 lib/bb/tests/parse.py              |  1 +
 lib/bblayers/query.py              | 26 ++++++++++++++++----------
 7 files changed, 39 insertions(+), 22 deletions(-)

diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index 2f3e9f72f9..7be39370b3 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -457,6 +457,7 @@ class BitbakeWorker(object):
         for mc in self.databuilder.mcdata:
             self.databuilder.mcdata[mc].setVar("PRSERV_HOST", self.workerdata["prhost"])
             self.databuilder.mcdata[mc].setVar("BB_HASHSERVE", self.workerdata["hashservaddr"])
+            self.databuilder.mcdata[mc].setVar("__bbclasstype", "recipe")
 
     def handle_newtaskhashes(self, data):
         self.workerdata["newhashes"] = pickle.loads(data)
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 2adf4d297d..1b6ee3032c 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -402,6 +402,7 @@ class BBCooker:
         for mc in self.databuilder.mcdata.values():
             mc.renameVar("__depends", "__base_depends")
             self.add_filewatch(mc.getVar("__base_depends", False), self.configwatcher)
+            mc.setVar("__bbclasstype", "recipe")
 
         self.baseconfig_valid = True
         self.parsecache_valid = False
diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index d54ac932e5..9706948ab3 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -254,6 +254,7 @@ class CookerDataBuilder(object):
         filtered_keys = bb.utils.approved_variables()
         bb.data.inheritFromOS(self.basedata, self.savedenv, filtered_keys)
         self.basedata.setVar("BB_ORIGENV", self.savedenv)
+        self.basedata.setVar("__bbclasstype", "global")
 
         if worker:
             self.basedata.setVar("BB_WORKERCONTEXT", "1")
diff --git a/lib/bb/data.py b/lib/bb/data.py
index c09d9b04bb..53fe34825d 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -441,7 +441,7 @@ def generate_dependency_hash(tasklist, gendeps, lookupcache, ignored_vars, fn):
 
 def inherits_class(klass, d):
     val = d.getVar('__inherit_cache', False) or []
-    needle = os.path.join('classes', '%s.bbclass' % klass)
+    needle = '/%s.bbclass' % klass
     for v in val:
         if v.endswith(needle):
             return True
diff --git a/lib/bb/parse/parse_py/BBHandler.py b/lib/bb/parse/parse_py/BBHandler.py
index 1189114341..18e6868387 100644
--- a/lib/bb/parse/parse_py/BBHandler.py
+++ b/lib/bb/parse/parse_py/BBHandler.py
@@ -44,17 +44,24 @@ def inherit(files, fn, lineno, d):
     __inherit_cache = d.getVar('__inherit_cache', False) or []
     files = d.expand(files).split()
     for file in files:
-        if not os.path.isabs(file) and not file.endswith(".bbclass"):
-            file = os.path.join('classes', '%s.bbclass' % file)
-
-        if not os.path.isabs(file):
-            bbpath = d.getVar("BBPATH")
-            abs_fn, attempts = bb.utils.which(bbpath, file, history=True)
-            for af in attempts:
-                if af != abs_fn:
-                    bb.parse.mark_dependency(d, af)
-            if abs_fn:
-                file = abs_fn
+        classtype = d.getVar("__bbclasstype", False)
+        origfile = file
+        for t in ["classes-" + classtype, "classes"]:
+            file = origfile
+            if not os.path.isabs(file) and not file.endswith(".bbclass"):
+                file = os.path.join(t, '%s.bbclass' % file)
+
+            if not os.path.isabs(file):
+                bbpath = d.getVar("BBPATH")
+                abs_fn, attempts = bb.utils.which(bbpath, file, history=True)
+                for af in attempts:
+                    if af != abs_fn:
+                        bb.parse.mark_dependency(d, af)
+                if abs_fn:
+                    file = abs_fn
+
+            if os.path.exists(file):
+                break
 
         if not os.path.exists(file):
             raise ParseError("Could not inherit file %s" % (file), fn, lineno)
diff --git a/lib/bb/tests/parse.py b/lib/bb/tests/parse.py
index 1a3b74934d..ee7f2534f1 100644
--- a/lib/bb/tests/parse.py
+++ b/lib/bb/tests/parse.py
@@ -164,6 +164,7 @@ python () {
     # become unset/disappear.
     #
     def test_parse_classextend_contamination(self):
+        self.d.setVar("__bbclasstype", "recipe")
         cls = self.parsehelper(self.classextend_bbclass, suffix=".bbclass")
         #clsname = os.path.basename(cls.name).replace(".bbclass", "")
         self.classextend = self.classextend.replace("###CLASS###", cls.name)
diff --git a/lib/bblayers/query.py b/lib/bblayers/query.py
index 9142ec4474..afd39518e5 100644
--- a/lib/bblayers/query.py
+++ b/lib/bblayers/query.py
@@ -57,11 +57,12 @@ are overlayed will also be listed, with a " (skipped)" suffix.
         # Check for overlayed .bbclass files
         classes = collections.defaultdict(list)
         for layerdir in self.bblayers:
-            classdir = os.path.join(layerdir, 'classes')
-            if os.path.exists(classdir):
-                for classfile in os.listdir(classdir):
-                    if os.path.splitext(classfile)[1] == '.bbclass':
-                        classes[classfile].append(classdir)
+            for c in ["classes-global", "classes-recipe", "classes"]:
+                classdir = os.path.join(layerdir, c)
+                if os.path.exists(classdir):
+                    for classfile in os.listdir(classdir):
+                        if os.path.splitext(classfile)[1] == '.bbclass':
+                            classes[classfile].append(classdir)
 
         # Locating classes and other files is a bit more complicated than recipes -
         # layer priority is not a factor; instead BitBake uses the first matching
@@ -124,9 +125,14 @@ skipped recipes will also be listed, with a " (skipped)" suffix.
         if inherits:
             bbpath = str(self.tinfoil.config_data.getVar('BBPATH'))
             for classname in inherits:
-                classfile = 'classes/%s.bbclass' % classname
-                if not bb.utils.which(bbpath, classfile, history=False):
-                    logger.error('No class named %s found in BBPATH', classfile)
+                found = False
+                for c in ["classes-global", "classes-recipe", "classes"]:
+                    cfile = c + '/%s.bbclass' % classname
+                    if bb.utils.which(bbpath, cfile, history=False):
+                        found = True
+                        break
+                if not found:
+                    logger.error('No class named %s found in BBPATH', classname)
                     sys.exit(1)
 
         pkg_pn = self.tinfoil.cooker.recipecaches[mc].pkg_pn
@@ -174,7 +180,7 @@ skipped recipes will also be listed, with a " (skipped)" suffix.
                     logger.plain("  %s %s%s", layer.ljust(20), ver, skipped)
 
         global_inherit = (self.tinfoil.config_data.getVar('INHERIT') or "").split()
-        cls_re = re.compile('classes/')
+        cls_re = re.compile('classes.*/')
 
         preffiles = []
         show_unique_pn = []
@@ -407,7 +413,7 @@ NOTE: .bbappend files can impact the dependencies.
                     self.check_cross_depends("RRECOMMENDS", layername, f, best, args.filenames, ignore_layers)
 
             # The inherit class
-            cls_re = re.compile('classes/')
+            cls_re = re.compile('classes.*/')
             if f in self.tinfoil.cooker_data.inherits:
                 inherits = self.tinfoil.cooker_data.inherits[f]
                 for cls in inherits:
-- 
2.34.1


