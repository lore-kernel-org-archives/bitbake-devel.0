Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42850C636E5
	for <webhook@archiver.kernel.org>; Wed, 28 Aug 2024 17:15:34 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web11.1844.1724865327848746404
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 28 Aug 2024 10:15:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=fUh2fCUr;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-428101fa30aso60306465e9.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 28 Aug 2024 10:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1724865326; x=1725470126; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=LyAJERny0oHrVyC9BgajpdKr6pNsGDt6zUbD1APB/uI=;
        b=fUh2fCUrTqMg2EGF9Esi3l3OVaFTy8P8Wjh0/fgM6DJy9riOoxJHedM5NCw/58XJHu
         WmQlI7vvd2OuunOQgCVYU1VsOaTcfEd9hSeU4hOMyMY3SrHfeE8agowM8IGnv//btw1E
         +Wum8rJaGDj5jinAQyjeP1IenLP4AWX/hTUVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724865326; x=1725470126;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LyAJERny0oHrVyC9BgajpdKr6pNsGDt6zUbD1APB/uI=;
        b=p9M0iUDS/O+FzfA0o6a8b7GReDyFNw4uMrogdQEO6MBvhTUXIdoArYcTB3yXO54HLL
         KjMil2FWB3GiwQhAWOcRq1mGAYHX6LK0rVXy7nHbgJlvj3mgagxL2vjelMMd2b4KU7Wb
         pbHObEzIzCgOKKYgBcAQu/KeBSu1EigV0r5HZAtjrP4X12UWK0We0d6EqWenfg/LCRse
         q3VGgcbQnpgBO1mjsBMmvJzQaMa6dSv5cqyuTmtNvhilATNaPaOVj8Pgs7/aQyVDNDM/
         EMOcBrZEsGy/vWgM4mka9Sj9d4zX7j+g4xuQcf5mez/YaXRr3p1IzvuXa2V+eMsNxw8U
         SO1w==
X-Gm-Message-State: AOJu0Yw8dRhPIjXr60AefH0u5NCoewWAWOeTkXleYV/GTobfhCZMAgZI
	pt+sLsRAlQvYtGqe4AB5i6n0MUjBVg7NW1GJ46a0OnZcXMEo51SjnrBGtvy91B2xrqg/0EDTIVC
	z
X-Google-Smtp-Source: AGHT+IG8dT4679Dx58JlkkMyYQyS41Cvn/txx9SgYjdyc1LQv6begvxscAUigGv22GgdT6KzFziV/w==
X-Received: by 2002:adf:edd0:0:b0:368:48b2:95ec with SMTP id ffacd0b85a97d-3749b5310dcmr205947f8f.1.1724865325640;
        Wed, 28 Aug 2024 10:15:25 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:354e:532a:804e:264e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba63d8187sm27396045e9.40.2024.08.28.10.15.24
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 10:15:25 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH v2] codeparser: Allow code visitor expressions to be declared in metadata
Date: Wed, 28 Aug 2024 18:15:24 +0100
Message-ID: <20240828171524.1545176-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 28 Aug 2024 17:15:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16527

Allow the metadata to define code visitor expressions which mean that
custom dependencies can be handled in function libraries.

An example is the qa.handle_error function in OE which can set something
like:

handle_error.visitorcode = """
if isinstance(args[0], ast.Constant) and isinstance(args[0].value, str):
    for i in ["ERROR_QA", "WARN_QA"]:
        if i not in self.contains:
            self.contains[i] = set()
    self.contains[i].add(args[0].value)
else:
    self.warn(node.func, args[0])
    self.execs.add(name)
"""

Meaning that it can have contains optimisations on ERROR and WARN_QA
instead of hard dependencies.

One drawback to this solution is the parsing order. Functions with
visitorcode need to be defined before anything else references them
or the visitor code will not function for the earlier references.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cache.py      |  2 +-
 lib/bb/codeparser.py | 19 +++++++++++++++----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index c48feb7138..958652e0e3 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -28,7 +28,7 @@ import shutil
 
 logger = logging.getLogger("BitBake.Cache")
 
-__cache_version__ = "155"
+__cache_version__ = "156"
 
 def getCacheFile(path, filename, mc, data_hash):
     mcspec = ''
diff --git a/lib/bb/codeparser.py b/lib/bb/codeparser.py
index b25a2133d2..d249af326e 100644
--- a/lib/bb/codeparser.py
+++ b/lib/bb/codeparser.py
@@ -87,14 +87,17 @@ def add_module_functions(fn, functions, namespace):
             if e in functions:
                 execs.remove(e)
                 execs.add(namespace + "." + e)
-        modulecode_deps[name] = [parser.references.copy(), execs, parser.var_execs.copy(), parser.contains.copy(), parser.extra]
+        visitorcode = None
+        if hasattr(functions[f], 'visitorcode'):
+            visitorcode = getattr(functions[f], "visitorcode")
+        modulecode_deps[name] = [parser.references.copy(), execs, parser.var_execs.copy(), parser.contains.copy(), parser.extra, visitorcode]
         #bb.warn("%s: %s\nRefs:%s Execs: %s %s %s" % (name, fn, parser.references, parser.execs, parser.var_execs, parser.contains))
 
 def update_module_dependencies(d):
     for mod in modulecode_deps:
         excludes = set((d.getVarFlag(mod, "vardepsexclude") or "").split())
         if excludes:
-            modulecode_deps[mod] = [modulecode_deps[mod][0] - excludes, modulecode_deps[mod][1] - excludes, modulecode_deps[mod][2] - excludes, modulecode_deps[mod][3], modulecode_deps[mod][4]]
+            modulecode_deps[mod] = [modulecode_deps[mod][0] - excludes, modulecode_deps[mod][1] - excludes, modulecode_deps[mod][2] - excludes, modulecode_deps[mod][3], modulecode_deps[mod][4], modulecode_deps[mod][5]]
 
 # A custom getstate/setstate using tuples is actually worth 15% cachesize by
 # avoiding duplication of the attribute names!
@@ -161,7 +164,7 @@ class CodeParserCache(MultiProcessCache):
     # so that an existing cache gets invalidated. Additionally you'll need
     # to increment __cache_version__ in cache.py in order to ensure that old
     # recipe caches don't trigger "Taskhash mismatch" errors.
-    CACHE_VERSION = 12
+    CACHE_VERSION = 14
 
     def __init__(self):
         MultiProcessCache.__init__(self)
@@ -261,7 +264,15 @@ class PythonParser():
 
     def visit_Call(self, node):
         name = self.called_node_name(node.func)
-        if name and (name.endswith(self.getvars) or name.endswith(self.getvarflags) or name in self.containsfuncs or name in self.containsanyfuncs):
+        if name and name in modulecode_deps and modulecode_deps[name][5]:
+            visitorcode = modulecode_deps[name][5]
+            contains, execs, warn = visitorcode(name, node.args)
+            for i in contains:
+                self.contains[i] = contains[i]
+            self.execs |= execs
+            if warn:
+                self.warn(node.func, warn)
+        elif name and (name.endswith(self.getvars) or name.endswith(self.getvarflags) or name in self.containsfuncs or name in self.containsanyfuncs):
             if isinstance(node.args[0], ast.Constant) and isinstance(node.args[0].value, str):
                 varname = node.args[0].value
                 if name in self.containsfuncs and isinstance(node.args[1], ast.Constant):

