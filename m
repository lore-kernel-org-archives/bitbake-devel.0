Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3E9EB64D7
	for <webhook@archiver.kernel.org>; Fri, 30 Jun 2023 08:50:36 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web11.7913.1688115034482607020
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 30 Jun 2023 01:50:34 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@linuxfoundation.org header.s=google header.b=Q08doAkr;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3113da5260dso1797536f8f.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 30 Jun 2023 01:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1688115032; x=1690707032;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=PLOyRT+iewZE4PYz7zmrFU5MTsFxYGFjQmkmhsmqDPo=;
        b=Q08doAkrUxKzk+oY1YUPpvc92xAINqg/GHIM02MxvxbzLDhOV21DcO2TNMz+SiclFu
         pyAOXU+9cFpoug67nZjxMyZ9ROUk64tGhhVF9a/qGAK8rQ2AKYZkYGMwuvR/fIxOYLlA
         SMnY6iFM3GVB6j+ruHfoZH5iUCoq1XV1Bbf8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688115032; x=1690707032;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PLOyRT+iewZE4PYz7zmrFU5MTsFxYGFjQmkmhsmqDPo=;
        b=FpFzhgvUIfjYijVlcwdNO4fVJAjauxIM622WfyjEpJ1eW4geHLTVa1njizbRppPaHL
         /d1ksxL4I8BelrsT1j4HzvCMyEJreOM6fBFALM8VROrHPTdojOjzWqTnLnkkfPxHgaun
         KB75TpwCfMAhSbBghXarJfJMIhrKHN8msYteGYNG9WbW8vyoMtjLmeAJtbuaw9bx4U+S
         8aNtmRrUMPXTTwqBVg88gA1YnYDl+uY8v+q/+ZX7hVT1zaF42Zp0cLm8KqIU4iIhkLyn
         W4JBeyKkAyDyU9hGJyxzkYUOqdD2BJecARZ54VCHGnlrIWTkEWn379z1HgW3e2xpiKp5
         oxCQ==
X-Gm-Message-State: ABy/qLaUgKhfBXMqaogIoeGDC08uHVHX/gKm1Ns3EXtkpGKRh4MyH75D
	vFWNoOLhVUlMh/SK1Dsau8Hx+YUC1w2Irtji3iY=
X-Google-Smtp-Source: APBJJlHgAsJNT5/OPgr8VLzeJ9nNm7zd1nv/oy9zwhUpsnmZwH/r3r4bq89N/IgwnbTctVFeUTanwg==
X-Received: by 2002:a5d:49c4:0:b0:314:c9c:94dd with SMTP id t4-20020a5d49c4000000b003140c9c94ddmr1931035wrs.20.1688115032489;
        Fri, 30 Jun 2023 01:50:32 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:dd8:5bad:5828:567])
        by smtp.gmail.com with ESMTPSA id w10-20020adfec4a000000b00314172ba213sm3416741wrn.108.2023.06.30.01.50.31
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 01:50:32 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] fetch2/npmsw: Support old and new shrinkwrap formats
Date: Fri, 30 Jun 2023 09:50:31 +0100
Message-Id: <20230630085031.2738013-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 30 Jun 2023 08:50:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14869

"fetch2/npmsw: Add support for the new format of the shrinkwrap file"
added support for the new format shrinkwrap files but this regressed
our tests which still use the old format.

Similar to how npm handles this, support both for now until we can
migrate our tests.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/npmsw.py | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/lib/bb/fetch2/npmsw.py b/lib/bb/fetch2/npmsw.py
index d89be10caf..971ccc9050 100644
--- a/lib/bb/fetch2/npmsw.py
+++ b/lib/bb/fetch2/npmsw.py
@@ -43,15 +43,32 @@ def foreach_dependencies(shrinkwrap, callback=None, dev=False):
             params = the package parameters (dictionary)
             destdir = the destination of the package (string)
     """
-    packages = shrinkwrap.get("packages", {})
-
-    for package in packages:
-        if package != "":
-            name = package.split('node_modules/')[-1]
-            package_infos = packages.get(package, {})
-            if dev == False and package_infos.get("dev", False):
-                continue
-            callback(name, package_infos, package)
+    # For handling old style dependencies entries in shinkwrap files
+    def _walk_deps(deps, deptree):
+        for name in deps:
+            subtree = [*deptree, name]
+            _walk_deps(deps[name].get("dependencies", {}), subtree)
+            if callback is not None:
+                if deps[name].get("dev", False) and not dev:
+                    continue
+                elif deps[name].get("bundled", False):
+                    continue
+                destsubdirs = [os.path.join("node_modules", dep) for dep in subtree]
+                destsuffix = os.path.join(*destsubdirs)
+                callback(name, deps[name], destsuffix)
+
+    # packages entry means new style shrinkwrap file, else use dependencies
+    packages = shrinkwrap.get("packages", None)
+    if packages is not None:
+        for package in packages:
+            if package != "":
+                name = package.split('node_modules/')[-1]
+                package_infos = packages.get(package, {})
+                if dev == False and package_infos.get("dev", False):
+                    continue
+                callback(name, package_infos, package)
+    else:
+        _walk_deps(shrinkwrap.get("dependencies", {}), [])
 
 class NpmShrinkWrap(FetchMethod):
     """Class to fetch all package from a shrinkwrap file"""
-- 
2.39.2


