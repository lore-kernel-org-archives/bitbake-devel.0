Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C3CCE7A91
	for <webhook@archiver.kernel.org>; Mon, 25 Sep 2023 01:25:16 +0000 (UTC)
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by mx.groups.io with SMTP id smtpd.web10.52172.1695605111217766162
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 24 Sep 2023 18:25:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=J0qLPh8M;
 spf=pass (domain: axis.com, ip: 195.60.68.17, mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1695605113;
  x=1727141113;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=bKc/wlWxiW0iWZe+MeUyw/BQoY8zOS+9TrAXyfQqBY0=;
  b=J0qLPh8Mk0Bg8wMQbJeSP5nHQT7u/IVUDiVG82LFb9SSk8uyVC5qkgq+
   +aokCCPhxeNGSDV2CRyAbrN/AkRNeV3hZR19yofUs5rZc4ucSSH+1NQ3/
   vx0fm29rXryCeoYaIcqFPJNRSW8M8VHAwOcee0RcUu7IxucBicxRbIIBs
   Kc6AlKGqc6Q3iC2psMiKcrSUyedwqDZDiAxYtPqCv8OZl+dCBqqi16RuO
   /AD4UUsJy8zs4PknnfRVsu9QaduZkzkVKQVT4PMSmPyoRPiS5Lf+6lkGr
   ZirIFg7sRRPpAyLC4yYlv7PdEgl14TEPUIlPzYCIWgh0ABENKaI0rTNuE
   Q==;
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCHv2 3/3] bitbake-getvar: Make --value imply --quiet
Date: Mon, 25 Sep 2023 03:25:02 +0200
Message-ID: <20230925012502.770037-3-pkj@axis.com>
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15109

It does not make any sense to get log output from bitbake-getvar when
the --value option is used as the log output is sent to stdout and thus
interferes with the output of the variable's value.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---

PATCHv2: Adapted to the changes in the preceding commit.

 bitbake/bin/bitbake-getvar | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/bin/bitbake-getvar b/bitbake/bin/bitbake-getvar
index 40bf3dc620..ed2dad63a2 100755
--- a/bitbake/bin/bitbake-getvar
+++ b/bitbake/bin/bitbake-getvar
@@ -36,7 +36,7 @@ if __name__ == "__main__":
         print("--flag only makes sense with --value")
         sys.exit(1)
 
-    quiet = args.quiet
+    quiet = args.quiet or args.value
     with bb.tinfoil.Tinfoil(tracking=True) as tinfoil:
         if args.recipe:
             tinfoil.prepare(quiet=3 if quiet else 2)

