Return-Path: <adrian.freihofer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDEFFC72A0
	for <webhook@archiver.kernel.org>; Sun, 29 Mar 2026 18:34:30 +0000 (UTC)
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.34712.1774809263055963453
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 29 Mar 2026 11:34:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=adrian.freihofer@siemens.com header.s=fm1 header.b=EaMUvPIS;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.228, mailfrom: fm-1329275-2026032918342118c5e0ffeb000207f9-kmjacq@rts-flowmailer.siemens.com)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 2026032918342118c5e0ffeb000207f9
        for <bitbake-devel@lists.openembedded.org>;
        Sun, 29 Mar 2026 20:34:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=adrian.freihofer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=L/kndJXkAdGDHDSqcJ9pO5OZMr8c2Rqq2Atnz6V3m/c=;
 b=EaMUvPISkf0W3ITEwwI1Y6uzlKjVCZkb/dZQKpty7FdGj/JS6TztfAHx0q7JuPBFP9Gt7N
 lFUr3O716x1h2kZD21u01AR6C/4w/Oi8uxBel9MsAbS3neM+m5qhE30EHULFK/Ihmtw3cQ/q
 ONENCBWS0TPK1SVGwfSy6SQr3W6LqUCS2eHbnCvPxwBQXPXN3ruxzPrRFMU3OWrvvemhCN6u
 01IC1KDezEGPpVF9cGNCzBH41D0qdxkBWOGe0Z4j/W8WiOIKCkCAIra7XM5V9rkP3c9ve+AR
 5UoPANwYumoUjsEJjw+2YE8ROy6rPSo3sF8WdOFWYyXOFb+SOwIPWDKA==;
From: AdrianF <adrian.freihofer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [PATCH v3 13/14] bitbake-setup: catch unexpected exceptions and show a clean error message
Date: Sun, 29 Mar 2026 20:33:00 +0200
Message-ID: <20260329183332.1996183-14-adrian.freihofer@siemens.com>
In-Reply-To: <20260329183332.1996183-1-adrian.freihofer@siemens.com>
References: <20260329183332.1996183-1-adrian.freihofer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1329275:519-21489:flowmailer
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 29 Mar 2026 18:34:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19264

From: Adrian Freihofer <adrian.freihofer@siemens.com>

Without a top-level exception handler, any unexpected Python exception
reaches the user as a raw traceback, which is confusing and exposes
implementation details.

Add a try/except block around the main dispatch in main() that:
- catches all unexpected exceptions and logs them as a single ERROR
  line, consistent with how other errors are already presented
- re-raises when --debug is active, so the full traceback is still
  available for diagnosis
- explicitly re-raises SystemExit and KeyboardInterrupt so sys.exit()
  calls and Ctrl-C continue to work normally

Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
---
 bin/bitbake-setup | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 596722e48..ddb6d2af1 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -1361,13 +1361,21 @@ def main():
 
         logger.info('Bitbake-setup is using {} as top directory.'.format(top_dir))
 
-        if args.func == init_config:
-            init_config(top_dir, all_settings, args)
-        else:
-            d = init_bb_cache(top_dir, all_settings, args)
-            args.func(top_dir, all_settings, args, d)
+        try:
+            if args.func == init_config:
+                init_config(top_dir, all_settings, args)
+            else:
+                d = init_bb_cache(top_dir, all_settings, args)
+                args.func(top_dir, all_settings, args, d)
 
-        save_bb_cache()
+            save_bb_cache()
+        except (SystemExit, KeyboardInterrupt):
+            raise
+        except Exception as e:
+            if args.debug:
+                raise
+            logger.error(str(e))
+            sys.exit(1)
     else:
         parser.print_help()
 
-- 
2.53.0


