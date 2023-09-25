Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B85ACE79A1
	for <webhook@archiver.kernel.org>; Mon, 25 Sep 2023 20:31:42 +0000 (UTC)
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 by mx.groups.io with SMTP id smtpd.web10.2805.1695673895874468628
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 25 Sep 2023 13:31:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=NQam4EHv;
 spf=pass (domain: axis.com, ip: 195.60.68.18, mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1695673896;
  x=1727209896;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WbzdHErN2BlVWaqVG6afJ198nZo5q2iZpIurWv36HIk=;
  b=NQam4EHv8wFISgSPPRfRgGs0HFz0RWugyxazjsxA3yIOgUKcWiA3L4KA
   7gOTHu2ydVLajcnM5NyQ/hxbaFJdmows7K/+xMgZBsLdY7V2Fy9wJAY+L
   Q1Y3FCsWg+kkA3SrJQLpQwEwxsnxWkGkWWWU8W8dytU/YiOV6JZt0Oje9
   pgAx1B35AQ7EacAHc1T4jXvIBHmUxGlKsDWIjZ2Oixdxj2S7kn1IJNnJL
   xkddou5Txx9NFGF9sw/bWGGBIZuijYZaIoqGwuBKQ2ib0nprUCXxs0ok4
   Zhc/mnsrapixG9wDtu3SPyTgT13lvWSduUHERTZ5SdO3H2DEVjaz+YRlQ
   g==;
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCHv2] bitbake-getvar: Add an option to specify a default value
Date: Mon, 25 Sep 2023 22:31:28 +0200
Message-ID: <20230925203128.73512-1-pkj@axis.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 25 Sep 2023 20:31:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15125

The default value is returned in case the specified variable or variable
flag is not defined.

In case no default option has been specified, bitbake-getvar fails with
an error instead.

Suggested-by: Mario Domenech Goulart <mario@parenteses.org>
Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---

PATCHv2: New solution based on the discussion after the previous patch.

 bitbake/bin/bitbake-getvar | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/bitbake/bin/bitbake-getvar b/bitbake/bin/bitbake-getvar
index 4a9eb4f311..1c670e7b96 100755
--- a/bitbake/bin/bitbake-getvar
+++ b/bitbake/bin/bitbake-getvar
@@ -26,15 +26,16 @@ if __name__ == "__main__":
     parser.add_argument('-f', '--flag', help='Specify a variable flag to query (with --value)', default=None)
     parser.add_argument('--value', help='Only report the value, no history and no variable name', action="store_true")
     parser.add_argument('-q', '--quiet', help='Silence bitbake server logging', action="store_true")
+    parser.add_argument('-d', '--default', help='Default value returned in case variable is not defined',
+                        default=None, const=True, required=False, nargs='?')
     args = parser.parse_args()
 
-    if args.unexpand and not args.value:
-        print("--unexpand only makes sense with --value")
-        sys.exit(1)
+    if not args.value:
+        if args.unexpand:
+            sys.exit("--unexpand only makes sense with --value")
 
-    if args.flag and not args.value:
-        print("--flag only makes sense with --value")
-        sys.exit(1)
+        if args.flag:
+            sys.exit("--flag only makes sense with --value")
 
     with bb.tinfoil.Tinfoil(tracking=True, setup_logging=not args.quiet) as tinfoil:
         if args.recipe:
@@ -43,9 +44,26 @@ if __name__ == "__main__":
         else:
             tinfoil.prepare(quiet=2, config_only=True)
             d = tinfoil.config_data
+
+        value = None
         if args.flag:
-            print(str(d.getVarFlag(args.variable, args.flag, expand=(not args.unexpand))))
-        elif args.value:
-            print(str(d.getVar(args.variable, expand=(not args.unexpand))))
+            value = d.getVarFlag(args.variable, args.flag, expand=(not args.unexpand))
+            if value is None:
+                if args.default is None:
+                    sys.exit(f"The flag '{args.flag}' is not defined for variable '{args.variable}'")
+                elif isinstance(args.default, str):
+                    value = args.default
+        else:
+            value = d.getVar(args.variable, expand=(not args.unexpand))
+            if value is None:
+                if args.default is None:
+                    sys.exit(f"The variable '{args.variable}' is not defined")
+                elif isinstance(args.default, str):
+                    value = args.default
+                    # Inject the default value, in case it is needed by bb.data.emit_var() below.
+                    d.setVar(args.variable, value);
+        if args.value:
+            if value is not None:
+                print(str(value))
         else:
             bb.data.emit_var(args.variable, d=d, all=True)

