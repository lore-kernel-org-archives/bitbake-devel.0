Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3AACE7A8B
	for <webhook@archiver.kernel.org>; Mon, 25 Sep 2023 01:25:16 +0000 (UTC)
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by mx.groups.io with SMTP id smtpd.web10.52172.1695605111217766162
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 24 Sep 2023 18:25:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=nDBf1tkK;
 spf=pass (domain: axis.com, ip: 195.60.68.17, mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1695605112;
  x=1727141112;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=stQ9KOrMsYJFNP8x/bsnumdeiqP5ajLGrU0FHk3oons=;
  b=nDBf1tkKbCDHk8tJxVGkXkDfM4p8mggVuVnzwdzTxnVHxLesndWV4bHQ
   pKgC4bI1KxKyFN6gHP5sPGITanbxqkyccbOp4EuByWPQ3f3GPKayBRxi0
   hD7YDXORcfP5hh/sNnBMPl4F2bTiryc7/eoEZIubtRRO2qroLocmbZoHQ
   kL0G4Vnh0BIAEtW/3mpSfkyC1ZWAWxf/EUQA1uRR5giybEOSB9DcmLRKz
   pbbfQnD1ygmKWzarLqOHZQVRQ8UGwZDrR/WBobH2XP+PiRdChX//pQiUs
   ExwFiBLo9NqxYMtqQKddANZ4Ho2dAfF27L1WhygAL6pTLjJqZNuyzwrvu
   A==;
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCHv2 2/3] bitbake-getvar: Make --quiet work with --recipe
Date: Mon, 25 Sep 2023 03:25:01 +0200
Message-ID: <20230925012502.770037-2-pkj@axis.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230925012502.770037-1-pkj@axis.com>
References: <20230925012502.770037-1-pkj@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 25 Sep 2023 01:25:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15108

Initializing Tinfoil with setup_logging = False only has an effect when
recipe parsing is not needed. To make it work regardless of if --recipe
is used, manipulate the quiet parameter to Tinfoil.prepare() instead.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---

PATCHv2: New in this patch set.

 bitbake/bin/bitbake-getvar | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/bitbake/bin/bitbake-getvar b/bitbake/bin/bitbake-getvar
index 4a9eb4f311..40bf3dc620 100755
--- a/bitbake/bin/bitbake-getvar
+++ b/bitbake/bin/bitbake-getvar
@@ -36,12 +36,13 @@ if __name__ == "__main__":
         print("--flag only makes sense with --value")
         sys.exit(1)
 
-    with bb.tinfoil.Tinfoil(tracking=True, setup_logging=not args.quiet) as tinfoil:
+    quiet = args.quiet
+    with bb.tinfoil.Tinfoil(tracking=True) as tinfoil:
         if args.recipe:
-            tinfoil.prepare(quiet=2)
+            tinfoil.prepare(quiet=3 if quiet else 2)
             d = tinfoil.parse_recipe(args.recipe)
         else:
-            tinfoil.prepare(quiet=2, config_only=True)
+            tinfoil.prepare(quiet=3 if quiet else 2, config_only=True)
             d = tinfoil.config_data
         if args.flag:
             print(str(d.getVarFlag(args.variable, args.flag, expand=(not args.unexpand))))

