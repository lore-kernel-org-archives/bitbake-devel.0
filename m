Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138C3CE7A8B
	for <webhook@archiver.kernel.org>; Mon, 25 Sep 2023 03:22:58 +0000 (UTC)
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by mx.groups.io with SMTP id smtpd.web11.54270.1695612171846492613
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 24 Sep 2023 20:22:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=DoGLL293;
 spf=pass (domain: axis.com, ip: 195.60.68.17, mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1695612172;
  x=1727148172;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cQolKH5I+DQQBibC7pN8MbZoICziKV+Br9hj1nMvtUo=;
  b=DoGLL293YV8eu2sjUoY4y5PSS5RiEir2f7w1Ixmlc4eQK7uRoghYQuOD
   /aUCERIH2W6VH9zD4ZJVNCquoIP34VuC+9V13PVQvT4zs9o2/kHNiLXCF
   ByHB9oKljXFsgS1lNIl5lpmSTamFxh1JPgidX/ADF6Wlp7ikj6aRZCsSb
   S8qH1MAQyZokzUiRHPouDY3rXh5E7QjLmgpWdpKu07EhXZTCvMeYSb3Rj
   MFnB1wk7XP5rDdoJH8nLD5WAQykfsSveDHekT/+cWKe2vdkdWI0cUbLG8
   e41lzK2TO43u3TIaaE+pkdvdv+m6FdlNuFq3fAUOeGUli3m7KBBb/N7bI
   w==;
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH] bitbake-getvar: Do not output anything with --value and undefined variable
Date: Mon, 25 Sep 2023 05:22:43 +0200
Message-ID: <20230925032246.1316597-1-pkj@axis.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 25 Sep 2023 03:22:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15113

Rather than outputting the string "None" when an unknown variable is
used together with --value, output nothing. This is consistent with the
no --value case where only a comment stating that the variable is not
known is output.

This also means it is now possible to differentiate between an undefined
variable and an empty variable since the empty variable will be output
as a linefeed.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 bitbake/bin/bitbake-getvar | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/bitbake/bin/bitbake-getvar b/bitbake/bin/bitbake-getvar
index 4a9eb4f311..806bbd8e4e 100755
--- a/bitbake/bin/bitbake-getvar
+++ b/bitbake/bin/bitbake-getvar
@@ -43,9 +43,12 @@ if __name__ == "__main__":
         else:
             tinfoil.prepare(quiet=2, config_only=True)
             d = tinfoil.config_data
+        value = None
         if args.flag:
-            print(str(d.getVarFlag(args.variable, args.flag, expand=(not args.unexpand))))
+            value = d.getVarFlag(args.variable, args.flag, expand=(not args.unexpand))
         elif args.value:
-            print(str(d.getVar(args.variable, expand=(not args.unexpand))))
+            value = d.getVar(args.variable, expand=(not args.unexpand))
         else:
             bb.data.emit_var(args.variable, d=d, all=True)
+        if value is not None:
+            print(str(value))

