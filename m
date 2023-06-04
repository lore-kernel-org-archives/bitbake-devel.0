Return-Path: <belouargamohamed@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECFFC7EE2E
	for <webhook@archiver.kernel.org>; Sun,  4 Jun 2023 01:39:39 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
 by mx.groups.io with SMTP id smtpd.web11.10338.1685842771902408491
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 03 Jun 2023 18:39:32 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@gmail.com header.s=20221208 header.b=clWwhLi/;
 spf=pass (domain: gmail.com, ip: 209.85.218.46, mailfrom: belouargamohamed@gmail.com)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-974f4897d87so277668066b.0
        for <bitbake-devel@lists.openembedded.org>; Sat, 03 Jun 2023 18:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685842770; x=1688434770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hdigl3VfZJzfh8aru7Ft70O9S13l+5mgEuv3jx4031A=;
        b=clWwhLi/egiChJyC516DYzbztsvdQMd2qs4U92qoghCQT+ICOaUJidnG3OOnVRK83E
         KmAxklwZWg5cJdGC6hJuROzV77dKfhc4A0I/P9MzvdykS2AU0dlrwcVN68JGYmiQcolz
         jMPTK034EYwO0a6nBZrhvE4N8JGf17OplMYhmrbtQflxj0LlyUaPeOGWQOrPTMAmVPlv
         8Xn97FSxNTQX8kM02zujeYx8jW4v4ig4ZH0Mg/wCiy4bVqQgx+oqDXhtQPeBsvxrQmgX
         5rRvgVH6fkORfdIrD9B6M2HTb62I+LcFPMArEiLZNLcq/ZtcEuu2nmh7+81ZUkvDmoYM
         DdgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685842770; x=1688434770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hdigl3VfZJzfh8aru7Ft70O9S13l+5mgEuv3jx4031A=;
        b=kKIpEsWD7QZ/WHLKiDavI5z6uxkGHbgZOwflVqeKoEFOLDmothRRBUJHesAsjSPp88
         ObWThXEIN4bpVxKcL8cxmmgZSZ85tekMBKS+uzNDS7eMMAcn5hcMZTMR37WQqI7xGUFI
         91N0jmaHWZUcNgW5/8Zx1ma61CnXGJa4QJ3SkqxYWfNzAey//vfDa2/bEbgdGjf5owTl
         QLxwURjoRKbk2oD4JKS73GI1GY0M8CtiydAZeFz4VSbQX6IP0FD0znu4IWHoEZPPFaL0
         TIDKo3jY4XsVoIAkxanzOdXYyXcLU6XajmYCrDE5QZnvwCD0kQLxL041KNIm64x9F2Yu
         pGOw==
X-Gm-Message-State: AC+VfDwy7PEDEyF4mkmmQ1uwPxbeFPTp7mptVsu6uHCx2PSScaomYTAO
	Mb3gKvbwLYX5nCdc5PpEhC77zgpbLwWsYQ==
X-Google-Smtp-Source: ACHHUZ7L8R7wqvXhgoUx5pjKjcJW9XO/OOo0CL8jv5pi5psQwgqtfuC64hkXm0VIXg+gl6gmO68QhQ==
X-Received: by 2002:a17:907:97cf:b0:94b:4a4:2836 with SMTP id js15-20020a17090797cf00b0094b04a42836mr2553684ejc.69.1685842769695;
        Sat, 03 Jun 2023 18:39:29 -0700 (PDT)
Received: from localhost.localdomain (2a02-842a-002e-7001-0180-174c-8c1b-346b.rev.sfr.net. [2a02:842a:2e:7001:180:174c:8c1b:346b])
        by smtp.gmail.com with ESMTPSA id i8-20020adfdec8000000b0030796e103a1sm5825474wrn.5.2023.06.03.18.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jun 2023 18:39:29 -0700 (PDT)
From: belouargamohamed@gmail.com
X-Google-Original-From: m.belouarga@technologyandstrategy.com
To: bitbake-devel@lists.openembedded.org
Cc: BELOUARGA Mohamed <m.belouarga@technologyandstrategy.com>
Subject: [master][PATCH v2 1/3] bitbake: fetch2: npmsw: Add support for the new format of the shrinkwrap file
Date: Sun,  4 Jun 2023 03:39:17 +0200
Message-Id: <20230604013919.13904-1-m.belouarga@technologyandstrategy.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 04 Jun 2023 01:39:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14827

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
index cc81100b3a..359192a29e 100644
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


