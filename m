Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web12.12356.1618593088980420882
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 16 Apr 2021 10:11:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=QNZMAWhL;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f48.google.com with SMTP id g9so11359715wrx.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 16 Apr 2021 10:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=wCIIKxbFEfcezMLuSbMiWRuUdgW2pifE3majcGGrKHQ=;
        b=QNZMAWhLKRH0Qbf5mVmvwGNvbAo0+M2gicS7nUTvfhzoF/vAg4PJPwoo//5D4dvAYE
         HfGeiiP5tRY4znEtUKS60wUFxIGXWJg6z2+VlTgmWpxc7qYzPaxOCnwszagpv6nPzg+C
         CaxYdwwCLAQrNtlNplkLruO2LFXSh+HOls+6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wCIIKxbFEfcezMLuSbMiWRuUdgW2pifE3majcGGrKHQ=;
        b=txxFcqUwPQdkwlIg4JdapDSGYG8x5xgPDZlcLLaLWYDULV+D0Lxj4+WZe0ToFgQttm
         xCva8sYfgIXKCbzhjwG/tgeCIGi8xevkTfk5bpX1AbfhA9E/0rpR3TiKgLx9308cKpxx
         y34TiPQQIV8lE2FHTHyNlsfQH7J/YcgpduLjaoDdc4OhxmMw8ZShq5lY+1WDj1ILXaum
         wyHCiBt4N14lhfCiPvKpwsYeV5Htu1t6wgJBDLqlzm/uDSIs2sWIdG3BKvC5A4k2ePod
         LxQkmL9i8A3nPe9LOJ90gHkofT2+d5u2SVAKjgAfjMNy8crl2Wa/LXHxHxHgVMfN15Pc
         CcIw==
X-Gm-Message-State: AOAM531IEePrdoeHKQ7UNqVdNAgQQnq1+kP0IAo5TdkvmVGHKke0OZKZ
	4Wug+50NGy6rzi7geBzH8P8+sfjILbGneQ==
X-Google-Smtp-Source: ABdhPJytBSfMnet7CvstcseBmcGy+0LCwXS7VUefDWUx1GDpoPEMXCdtvEYczdXiBPM8lRhZbiNhRg==
X-Received: by 2002:a5d:5711:: with SMTP id a17mr218741wrv.342.1618593087499;
        Fri, 16 Apr 2021 10:11:27 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:6910:66c9:6ed2:e889])
        by smtp.gmail.com with ESMTPSA id v185sm10368774wmb.25.2021.04.16.10.11.27
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 10:11:27 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/2] bin/bitbake-getvar: Add a new command to query a variable value (with history)
Date: Fri, 16 Apr 2021 18:11:26 +0100
Message-Id: <20210416171126.1373752-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210416171126.1373752-1-richard.purdie@linuxfoundation.org>
References: <20210416171126.1373752-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index 0000000000..0eddfe294b
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
2.30.2

