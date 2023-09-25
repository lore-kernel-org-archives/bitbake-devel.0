Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D5ACE7A95
	for <webhook@archiver.kernel.org>; Mon, 25 Sep 2023 02:18:47 +0000 (UTC)
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by mx.groups.io with SMTP id smtpd.web10.52909.1695608318351341141
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 24 Sep 2023 19:18:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=iv1yeMNE;
 spf=pass (domain: axis.com, ip: 195.60.68.17, mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1695608319;
  x=1727144319;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=ZOJ+iDkLnvIqY5iU1gqlmKJOuoBs+J/xse7dU1sDctY=;
  b=iv1yeMNESWDrth4DZJz1z/PH88tqAZsaCDQVR9WQyZTgNwNQDvCG8PQc
   ThwYt0M1FtEslVuCrvqQnTgZBtJPzoKUuFFRyZ1NhQk4sDOO/DJjU0IfW
   1PQKVWw0ph3xXwFQOhypDLW45zU4zywrjeEpqFCvbshnbEklLBHDalqBW
   42TMs0rxRZQBm/gmkcAbDXFP/7eV+TG3/SyhyApcQfw9j51vzcX4DFrdc
   p7EI61TR7KFgLYh1Pr3shXFruHoQfPpJ+gpczajQcshTOBHfDsctmrMop
   ++ijm5KaGlIs3Vbp/oZt1GsI+qFRsJjs6Z4tBnfeAkijkgp5Z/ezPLo4O
   g==;
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCHv3 2/3] bitbake-getvar: Make --quiet work with --recipe
Date: Mon, 25 Sep 2023 04:18:32 +0200
Message-ID: <20230925021833.1303449-2-pkj@axis.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230925021833.1303449-1-pkj@axis.com>
References: <20230925021833.1303449-1-pkj@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 25 Sep 2023 02:18:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15111

Initializing Tinfoil with setup_logging = False only has an effect when
recipe parsing is not needed. To make it work regardless of if --recipe
is used, manipulate the quiet parameter to Tinfoil.prepare() instead.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---

PATCHv2: New in this patch set.
PATCHv3: Apparently setup_logging still needs to be configured when
         config_only=True...

 bitbake/bin/bitbake-getvar | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/bitbake/bin/bitbake-getvar b/bitbake/bin/bitbake-getvar
index 4a9eb4f311..13a317e1d6 100755
--- a/bitbake/bin/bitbake-getvar
+++ b/bitbake/bin/bitbake-getvar
@@ -36,9 +36,10 @@ if __name__ == "__main__":
         print("--flag only makes sense with --value")
         sys.exit(1)
 
-    with bb.tinfoil.Tinfoil(tracking=True, setup_logging=not args.quiet) as tinfoil:
+    quiet = args.quiet
+    with bb.tinfoil.Tinfoil(tracking=True, setup_logging=not quiet) as tinfoil:
         if args.recipe:
-            tinfoil.prepare(quiet=2)
+            tinfoil.prepare(quiet=3 if quiet else 2)
             d = tinfoil.parse_recipe(args.recipe)
         else:
             tinfoil.prepare(quiet=2, config_only=True)

