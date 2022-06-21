Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3873CCA473
	for <webhook@archiver.kernel.org>; Tue, 21 Jun 2022 18:21:25 +0000 (UTC)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by mx.groups.io with SMTP id smtpd.web08.47032.1655835681073956879
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Jun 2022 11:21:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=c8qYCDgl;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.46,
 mailfrom: steve@sakoman.com)
Received: by mail-pj1-f46.google.com with SMTP id p5so8001909pjt.2
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Jun 2022 11:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=74ZOMBboF3dgbyvMndqG+/Xsl4OI/PyEevqBGequ69g=;
        b=c8qYCDglft20b8L0nyJqDIrekXzI4utzUS1iBrfd0fmz23qtNLONX3KVnHrF/gMl3A
         Ss8LaL90LKFglIqNq6QwOM0CrhHws0XoWUcSe5PkUJrw14sO0Bvl9rH1MOk2XC2JLXCC
         dNx3xsBhRzjdUFGyaXK5OlY/d4EbH6ik2sYXyyTq9Gdqxdb16sb1IGOyRDKvyZRFJlEC
         U2ZpqaHWuU+0ycypl/jd09WGQLs1yt0OGEvLbsWeouKHNwM8aDrHFTHOk0b0sUR/Kv9r
         6z1UVzEAUE36DGu/Qmb28zBsNb6TnXU7/sQz5S1Xe3yeauIJrXa0JIGnhJi/4hp/I4Gr
         npbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=74ZOMBboF3dgbyvMndqG+/Xsl4OI/PyEevqBGequ69g=;
        b=ocmPyJrmsMMrTSytzMokOvGNRIgI+GZDsJvVTmvB5a0yUIJaAWFn9pOMHWUEcOCZcY
         D0Gd6VkEbH9RZvl+jm3YFy8SADmcMSOLi3UXAwH39sh8aGMMzFlDD6KiCGV2cTmdDWz5
         s37yp9AeCzDZh3/40lRWCEhDJ5su19PWgAMWoltjijdutaGNkRcPPG6VaZpSaU3i1s3E
         h2vOhPNPVAM3aqOkoBbEpjJ3uYpZmRIhAjfGhvETDqERdcChh1wTSIzxmpFXRrtAXr+0
         xrmSwCN9uRQIy+nuI5gblmiaLDNTv15W0tAMgeM/H6kwx7qxbAP9e6sEpJ/6ukFe6z2Y
         DaQQ==
X-Gm-Message-State: AJIora82u02DrVLK0KbeCyopkaPa5keHhE7boDyfgA8qdiYsqv4BFj8X
	x4MPYxZk6FegMPWIsn3O2mZ0W96KrW86RdDT
X-Google-Smtp-Source: 
 AGRyM1tOEUobXwojl/k/rc1N6q/IX5lf12ubT1RCX7oBHOQEmJ1Llu/35PynIxZYH3IrgANiEw46CA==
X-Received: by 2002:a17:90b:314a:b0:1e8:5362:5620 with SMTP id
 ip10-20020a17090b314a00b001e853625620mr34735019pjb.9.1655835680049;
        Tue, 21 Jun 2022 11:21:20 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 t13-20020a1709027fcd00b0016392bd5060sm9755503plb.142.2022.06.21.11.21.18
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 11:21:19 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 3/5] bin/bitbake-getvar: Add a new
 command to query a variable value (with history)
Date: Tue, 21 Jun 2022 08:20:59 -1000
Message-Id: 
 <47ed06d441152f8b6d374cacfac2c668c354423e.1655835530.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1655835530.git.steve@sakoman.com>
References: <cover.1655835530.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 21 Jun 2022 18:21:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13781

From: Richard Purdie <richard.purdie@linuxfoundation.org>

We've talked about having this for long enough. Add a command which queries a single
variable value with history. This saves "bitbake -e | grep" and avoids the
various pitfalls that has.

It also provides a neat example of using tinfoil to make such a query.

Parameters to limit the output to just the value, to limit to a variable flag
and to not expand the output are provided.

[YOCTO #10748]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 4c1881b620e885f55d7772f8626b8a76c2828333)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 bin/bitbake-getvar | 48 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100755 bin/bitbake-getvar

diff --git a/bin/bitbake-getvar b/bin/bitbake-getvar
new file mode 100755
index 00000000..94232192
--- /dev/null
+++ b/bin/bitbake-getvar
@@ -0,0 +1,48 @@
+#! /usr/bin/env python3
+#
+# Copyright (C) 2021 Richard Purdie
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
+import argparse
+import io
+import os
+import sys
+
+bindir = os.path.dirname(__file__)
+topdir = os.path.dirname(bindir)
+sys.path[0:0] = [os.path.join(topdir, 'lib')]
+
+import bb.tinfoil
+
+if __name__ == "__main__":
+    parser = argparse.ArgumentParser(description="Bitbake Query Variable")
+    parser.add_argument("variable", help="variable name to query")
+    parser.add_argument("-r", "--recipe", help="Recipe name to query", default=None, required=False)
+    parser.add_argument('-u', '--unexpand', help='Do not expand the value (with --value)', action="store_true")
+    parser.add_argument('-f', '--flag', help='Specify a variable flag to query (with --value)', default=None)
+    parser.add_argument('--value', help='Only report the value, no history and no variable name', action="store_true")
+    args = parser.parse_args()
+
+    if args.unexpand and not args.value:
+        print("--unexpand only makes sense with --value")
+        sys.exit(1)
+
+    if args.flag and not args.value:
+        print("--flag only makes sense with --value")
+        sys.exit(1)
+
+    with bb.tinfoil.Tinfoil(tracking=True) as tinfoil:
+        if args.recipe:
+            tinfoil.prepare(quiet=2)
+            d = tinfoil.parse_recipe(args.recipe)
+        else:
+            tinfoil.prepare(quiet=2, config_only=True)
+            d = tinfoil.config_data
+        if args.flag:
+            print(str(d.getVarFlag(args.variable, args.flag, expand=(not args.unexpand))))
+        elif args.value:
+            print(str(d.getVar(args.variable, expand=(not args.unexpand))))
+        else:
+            bb.data.emit_var(args.variable, d=d, all=True)
-- 
2.25.1


