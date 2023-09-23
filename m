Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39543CE7A8C
	for <webhook@archiver.kernel.org>; Sat, 23 Sep 2023 03:50:42 +0000 (UTC)
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by mx.groups.io with SMTP id smtpd.web11.14836.1695441034785215943
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 22 Sep 2023 20:50:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=j8cj7qvk;
 spf=pass (domain: axis.com, ip: 195.60.68.17, mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1695441035;
  x=1726977035;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eRq8Oya4RNGxELRzQv1Ag1Xsk+SE1kqTnVdPNqG4xVY=;
  b=j8cj7qvkB2tHaPojhi1qwCrQ3nUIpAyRWkkAxnoaTuxLLKGh1kxM/S8m
   rcJ24stj4ultJUO+GjDiX/ohkNNrB1Qq1563D5FN9pjoWPqlgWgxUwFFq
   daeHKQGCCdhrF2A7fcpS1vDBGp9O0N+EwbrDinqq4+MwWQ9SjruW5Oal5
   i2NFOY/XGRzN54o78A3CNORr91GiOfaZEbEdsBsbaQaHZ4zNIvaBFGD2J
   dKeEsgzzlFhZiJElnBKxn6dr7HPQ0dydUYBXGfTrKJpjbebQYS64P8Ec7
   6aAm5sZtI47HRJtzMc8QtjckxQtjmQS5ETpScnMOsrj3GmqqwutZI2smW
   A==;
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH] bitbake-getvar: Make --value imply --quiet
Date: Sat, 23 Sep 2023 05:50:25 +0200
Message-ID: <20230923035025.682057-1-pkj@axis.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 23 Sep 2023 03:50:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15105

It does not make any sense to get log output from bitbake-getvar when
the --value option is used as the log output is sent to stdout and thus
interferes with the output of the variable's value.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 bitbake/bin/bitbake-getvar | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/bitbake/bin/bitbake-getvar b/bitbake/bin/bitbake-getvar
index 4a9eb4f311..1ec90065a9 100755
--- a/bitbake/bin/bitbake-getvar
+++ b/bitbake/bin/bitbake-getvar
@@ -36,7 +36,8 @@ if __name__ == "__main__":
         print("--flag only makes sense with --value")
         sys.exit(1)
 
-    with bb.tinfoil.Tinfoil(tracking=True, setup_logging=not args.quiet) as tinfoil:
+    quiet = args.quiet or args.value
+    with bb.tinfoil.Tinfoil(tracking=True, setup_logging=not quiet) as tinfoil:
         if args.recipe:
             tinfoil.prepare(quiet=2)
             d = tinfoil.parse_recipe(args.recipe)

