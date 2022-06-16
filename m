Return-Path: <Martin.Jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34AFCCA47E
	for <webhook@archiver.kernel.org>; Thu, 16 Jun 2022 13:49:13 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web08.17891.1655387347562174527
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 16 Jun 2022 06:49:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=HiMMJvXe;
 spf=pass (domain: gmail.com, ip: 209.85.128.41,
 mailfrom: martin.jansa@gmail.com)
Received: by mail-wm1-f41.google.com with SMTP id
 m16-20020a7bca50000000b0039c8a224c95so910159wml.2
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 16 Jun 2022 06:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=duyNTGMvZE0oxJFURy56BK1PgpgJuqZ6WzON69fN5Fs=;
        b=HiMMJvXe9/33kldujCIvrmRUvpWMluINKfZ/0q6U44XZuZ0XDY775QvX7uq9aWwqwL
         gTcvLcNzyoNskRgCv4tt+WJpsZyh5E3xXBqe2sOYkbIADalW8zKnkEFcJl3nBzN081M+
         yeEFRWfTkccoj1828OAW6vfI6qVttWcy/e605P82iEMPfumEbWgjsTE/Yeb2bNgTtOBF
         hr4VYUcw/EdFjRwBWOIUwB3fQABmov0T/VGhHxFvh9kFFUGkpz2Il+iSMgkPjtUM4vSi
         8kMrQcjonBVwYOVQb8bS/lEGv3G4QBcyw5Zk3+c/NRfIuvkXv9SWhzlSc1UxHBy2gIZA
         1cQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=duyNTGMvZE0oxJFURy56BK1PgpgJuqZ6WzON69fN5Fs=;
        b=3fLMjMw2FDotSXzuhRgKXCWVNMherozvJU8QLWdeMc7sTkQFN3DOTnFnCSaOjMg7YL
         NSElgcQ4/pWyRyxt3iueXQywRNFmCby5VJPQf+6Zf3w1nz8gFTILe2TpmK9Bj0GVw1dk
         Us/kDEq7cGfz+JMbyb4IxVAZ/9XAIXYceyvrI/Q8I1HWTGjb9ACiype5YstIWRRwBSQp
         eYPurfEKw0VvKwYxXK1oxSENl1kUgD5h8y6tjkOjnPMl7nCv5nVVnKePUabAXWAN6mW0
         5gHuD5YNsUyWIcfcgovxDcZ0EdX2/yU8zd1wYR/pEm4qumZiXIa1Zz946J7ubBevGW74
         3zVA==
X-Gm-Message-State: AJIora/l27kgDFBMJax+cXFrOIG9rrtOauZQjHJR2I/hbcaqWuOtuZa2
	7gq1ONcZ2lwNghv5X2/ghh1k8ppjS38=
X-Google-Smtp-Source: 
 AGRyM1vGY3pIktA2ZLWXfJea1H9kWoZMPC1F8pcTTmnOHkt0QUkm74PZsGC9/H++8ApCvEje6rA3mQ==
X-Received: by 2002:a05:600c:2054:b0:39c:3f73:3552 with SMTP id
 p20-20020a05600c205400b0039c3f733552mr5204991wmg.15.1655387345935;
        Thu, 16 Jun 2022 06:49:05 -0700 (PDT)
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with ESMTPSA id
 v12-20020a5d678c000000b0020c5253d90asm1957391wru.86.2022.06.16.06.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 06:49:05 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [1.46][PATCH 2/4] bin/bitbake-getvar: Add a new command to query a
 variable value (with history)
Date: Thu, 16 Jun 2022 15:48:48 +0200
Message-Id: <20220616134850.3471187-2-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220616134850.3471187-1-Martin.Jansa@gmail.com>
References: <20220616134850.3471187-1-Martin.Jansa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 16 Jun 2022 13:49:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13769

From: Richard Purdie <richard.purdie@linuxfoundation.org>

We've talked about having this for long enough. Add a command which queries a single
variable value with history. This saves "bitbake -e | grep" and avoids the
various pitfalls that has.

It also provides a neat example of using tinfoil to make such a query.

Parameters to limit the output to just the value, to limit to a variable flag
and to not expand the output are provided.

[YOCTO #10748]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bin/bitbake-getvar | 48 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100755 bin/bitbake-getvar

diff --git a/bin/bitbake-getvar b/bin/bitbake-getvar
new file mode 100755
index 00000000..0eddfe29
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
+        if not args.recipe:
+            tinfoil.prepare(quiet=2, config_only=True)
+            d = tinfoil.config_data
+        else:
+            tinfoil.prepare(quiet=2)
+            d = tinfoil.parse_recipe(args.recipe)
+        if args.flag:
+            print(str(d.getVarFlag(args.variable, args.flag, expand=(not args.unexpand))))        
+        elif args.value:
+            print(str(d.getVar(args.variable, expand=(not args.unexpand))))
+        else:
+            bb.data.emit_var(args.variable, d=d, all=True)
-- 
2.35.1


