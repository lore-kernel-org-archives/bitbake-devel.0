Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80AA2CE7A94
	for <webhook@archiver.kernel.org>; Mon, 25 Sep 2023 02:18:47 +0000 (UTC)
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 by mx.groups.io with SMTP id smtpd.web10.52911.1695608320280432287
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 24 Sep 2023 19:18:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=IymbNvfS;
 spf=pass (domain: axis.com, ip: 195.60.68.18, mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1695608321;
  x=1727144321;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=ojKOiXKEZevmOjOo/OHI8f/VxY/8EymTXrNtSpRF6aI=;
  b=IymbNvfS1eCFoLp/tXpH0b5xRuV4k9e14GWAjOMQwijI0VCg6/jxrItX
   J6DxBMK4c1ZP3MYl5XKIVeKHZMPHnHH6qbe914j17G7Vs30xPFPJJS/Ah
   FfLErS08uekciZ2jpq6sp7o8oEeIAutMrK2jxZqx8YYLwouRICbrbDEYq
   ZJcyro6JhOdeC3bvnSwTQNmbaYyVrAN4OuEBSHhdSf89jXCcQJyThI0XD
   X5MqmtPK6A+yvvkN99NAoGm1Ag8rEZlJm99xIkp3Hg4Ds5ZcGb44SIHC8
   ByWXRpm6qhHu7aI0f/IqSGZQb/nKzmTrb8VOEgoUTjlMb4glPPiOUGPjn
   g==;
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCHv3 3/3] bitbake-getvar: Make --value imply --quiet
Date: Mon, 25 Sep 2023 04:18:33 +0200
Message-ID: <20230925021833.1303449-3-pkj@axis.com>
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15112

It does not make any sense to get log output from bitbake-getvar when
the --value option is used as the log output is sent to stdout and thus
interferes with the output of the variable's value.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---

PATCHv2: Adapted to the changes in the preceding commit.
PATCHv3: No change.

 bitbake/bin/bitbake-getvar | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/bin/bitbake-getvar b/bitbake/bin/bitbake-getvar
index 13a317e1d6..afd2849846 100755
--- a/bitbake/bin/bitbake-getvar
+++ b/bitbake/bin/bitbake-getvar
@@ -36,7 +36,7 @@ if __name__ == "__main__":
         print("--flag only makes sense with --value")
         sys.exit(1)
 
-    quiet = args.quiet
+    quiet = args.quiet or args.value
     with bb.tinfoil.Tinfoil(tracking=True, setup_logging=not quiet) as tinfoil:
         if args.recipe:
             tinfoil.prepare(quiet=3 if quiet else 2)

