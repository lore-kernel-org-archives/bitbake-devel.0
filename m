Return-Path: <belouargamohamed@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2742C77B73
	for <webhook@archiver.kernel.org>; Sat, 27 May 2023 05:44:58 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web10.5515.1685166294669498491
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 26 May 2023 22:44:55 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@gmail.com header.s=20221208 header.b=lSn2siPf;
 spf=pass (domain: gmail.com, ip: 209.85.221.54, mailfrom: belouargamohamed@gmail.com)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-30a892c45c4so842137f8f.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 26 May 2023 22:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685166293; x=1687758293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F5UssFWQsf+EuLrfh4ZQAzdLPUeM63/WRNHGFKSWLAE=;
        b=lSn2siPfPDmEyJPPgJrNIXmFkeQhp6MEeqDxdcFK36Ib1nGmqZxRt4TpM59oTR+N7Z
         jwGEp4YHhMkbJ172gcoaSzh9NEqNnVlpBA2XM7c7GkKW6QsfU0fIPSEYytLKO6t/ub+4
         TANiZoVGYOXZ9O7u19JMb6JLkgcDlN3zRGYfId+POLnNkKDIGIaRYhzbVo4l50fvJOWQ
         T5yNYCEDAovbjCUTlVTra0UlWJwdJCJQQVuvh5S84RZ9Y/wEI06zvdYBx+4EdS88QL9N
         NCPypn+EZ28xNl+IeoVDsgi9Z3sI0t747Hff5lCgZoJ+0ZyjlOOawvk9042xyIpaDwIF
         465A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685166293; x=1687758293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F5UssFWQsf+EuLrfh4ZQAzdLPUeM63/WRNHGFKSWLAE=;
        b=BuNzYaycXRdf8ik6B1r4Nyn5TCazvOTiORNF0/84BwJx2fqy/gsHI/AMqKLp5HlXZw
         KtrijZfM/1tqtLA3OpIsgV1/gQK3wnvanrhhpkFFXL7qmfboFMKhv2OaTWrkZOF4lYWO
         0G/3EW4aYJI8LZH4goJUgcKxI4L2m+qFAGsoBjFxMfw/3NPSFei29BMYAHAdXLdjgHfK
         3OssnNcktuuZyJW6E62iQiCL/MZanx2I1Yh9Vj14hGOqly8Smxx46bohKNl8kSGLsBB3
         Xg945dGqw61feyPfVZhZrQmsL/+O9yeInsjt0wbkaEDlzdo8Ki4Tn6qyPPqmBnYfSkcv
         jorA==
X-Gm-Message-State: AC+VfDytJ8e50aS82gUpIUTjHaCBm/zOBV4f8iHQll9o429mu+zkO+2d
	kzRihFJOsBYpbh8akNDcb7wbHRW38kWT0ZLI
X-Google-Smtp-Source: ACHHUZ5EYEAfbkpVFkZbrKe/10dTRG7wpitqgV3Ul4W66o3Cfu3MLUzg91M25NoMsjodSCK963fwxQ==
X-Received: by 2002:a05:6000:10c3:b0:309:4c7f:170a with SMTP id b3-20020a05600010c300b003094c7f170amr2850884wrx.44.1685166292608;
        Fri, 26 May 2023 22:44:52 -0700 (PDT)
Received: from localhost.localdomain (2a02-842a-002e-7001-f2b0-7c97-e26b-fbea.rev.sfr.net. [2a02:842a:2e:7001:f2b0:7c97:e26b:fbea])
        by smtp.gmail.com with ESMTPSA id j12-20020adff54c000000b0030630de6fbdsm6972859wrp.13.2023.05.26.22.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 22:44:52 -0700 (PDT)
From: belouargamohamed@gmail.com
X-Google-Original-From: m.belouarga@technologyandstrategy.com
To: bitbake-devel@lists.openembedded.org
Cc: f.lahoudere@technologyandstrategy.com,
	e.aubineau@technologyandstrategy.com,
	BELOUARGA Mohamed <m.belouarga@technologyandstrategy.com>
Subject: [kirkstone][PATCH] fetch2: npmsw: Add support for the new format of the shrinkwrap file
Date: Sat, 27 May 2023 07:44:49 +0200
Message-Id: <20230527054449.931273-1-m.belouarga@technologyandstrategy.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 27 May 2023 05:44:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14815

From: BELOUARGA Mohamed <m.belouarga@technologyandstrategy.com>

Npm is a package manager that has its own manner to handle installation of packages.
But it is not yocto friendly, for instance NPM fetch dependencies in the middle of compilation.

The shrinkwrap file changed its format over npm versions, but npm does not version
this file, so we can use it properly.
The actual changes make NPM depencies work with the actual shrinkwrap format.

Signed-off-by: BELOUARGA Mohamed <m.belouarga@technologyandstrategy.com>
---
 lib/bb/fetch2/npmsw.py | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/lib/bb/fetch2/npmsw.py b/lib/bb/fetch2/npmsw.py
index cc81100b..359192a2 100644
--- a/lib/bb/fetch2/npmsw.py
+++ b/lib/bb/fetch2/npmsw.py
@@ -41,20 +41,15 @@ def foreach_dependencies(shrinkwrap, callback=None, dev=False):
         with:
             name = the package name (string)
             params = the package parameters (dictionary)
-            deptree = the package dependency tree (array of strings)
+            destdir = the destination of the package (string)
     """
-    def _walk_deps(deps, deptree):
-        for name in deps:
-            subtree = [*deptree, name]
-            _walk_deps(deps[name].get("dependencies", {}), subtree)
-            if callback is not None:
-                if deps[name].get("dev", False) and not dev:
-                    continue
-                elif deps[name].get("bundled", False):
-                    continue
-                callback(name, deps[name], subtree)
-
-    _walk_deps(shrinkwrap.get("dependencies", {}), [])
+    packages = shrinkwrap.get("packages", {})
+
+    for package in packages:
+        if package != "":
+            name = package.split('node_modules/')[-1]
+            package_infos = packages.get(package, {})
+            callback(name, package_infos, package)
 
 class NpmShrinkWrap(FetchMethod):
     """Class to fetch all package from a shrinkwrap file"""
@@ -75,12 +70,10 @@ class NpmShrinkWrap(FetchMethod):
         # Resolve the dependencies
         ud.deps = []
 
-        def _resolve_dependency(name, params, deptree):
+        def _resolve_dependency(name, params, destsuffix):
             url = None
             localpath = None
             extrapaths = []
-            destsubdirs = [os.path.join("node_modules", dep) for dep in deptree]
-            destsuffix = os.path.join(*destsubdirs)
             unpack = True
 
             integrity = params.get("integrity", None)
-- 
2.25.1


