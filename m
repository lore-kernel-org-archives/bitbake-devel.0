Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71643CEBF93
	for <webhook@archiver.kernel.org>; Mon, 17 Nov 2025 08:16:11 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5030.1763367367788735536
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 17 Nov 2025 00:16:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=iqR2ksyH;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 03A58C12651
	for <bitbake-devel@lists.openembedded.org>; Mon, 17 Nov 2025 08:15:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 15A89606B9
	for <bitbake-devel@lists.openembedded.org>; Mon, 17 Nov 2025 08:16:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 71A1A10371CF4;
	Mon, 17 Nov 2025 09:16:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763367365; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=0bTTjHJyAbZw61A67EDvCtePF4Lc0qskl+WzGjgbnsI=;
	b=iqR2ksyHupVT5MwdUzsgKcG0Ui60Eh7WAQ7OWr+z/Gk9ujf0399B/MWH2zg2GS4H4C8FdY
	7JYpoyPXgtqSX58qpWazfs9u7oXLBUTdAPI+0yDhJazRMxpy9ShpA7h/qjPipXIHVaKIrA
	5NxzjrmDe72PDFi0Z4wkgM1JrzEArk/m5RXxIxiQgl2+ukanqK4niwpNOqMWvYzXGjH0QO
	1KqqPNItJZJVm2PTZ5N+Ob6Z2TRfEP9au94AvzLqtW8L0rLl9ZnYLmG6n0mT2Hbw2s4N5z
	bxcOOH6oWpAkza66gL4D4vEHHs5cPGOBQ0KJXoGB0ZjB/ZhgrSGd8zH4a+0vWw==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Mon, 17 Nov 2025 09:15:38 +0100
Subject: [PATCH v2 2/3] bitbake-setup: create top-dir later in init
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-bitbake-setup-abort-v2-2-a73f44e83bc0@bootlin.com>
References: <20251117-bitbake-setup-abort-v2-0-a73f44e83bc0@bootlin.com>
In-Reply-To: <20251117-bitbake-setup-abort-v2-0-a73f44e83bc0@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2571;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=pDvHWcmjKOobHVPCY4tp6SM9gOlyOOBSaDfq1iveWSc=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpGtnCOps86HopqizE4j0DhbHwoPnfem/H3ibwR
 w/qmnwcSy6JAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaRrZwgAKCRDRgEFAKaOo
 NiUzD/4oz9lrzxL11rpXKkfPbuocG19zOOhdUyyS7oQ3rW/f87U+L1uRwwhpUwGrCFbMQwNnjMf
 V4ccPRqmW9qZz2f3d+U/rvX6epfGMZTKLZMS7bypguixhN/0mNSOTdPM/nH0azSRClUIL+hCG5s
 LKCNsQZe0giwpdwBSejgUl80vEKcfKtEXIkG1sUSi2Zqke/mxDeAv8+Fh0oMxK3dc/varPi8/jx
 7pRF2NJxdapCI5JSCvd0GU4bnP9Hs8nXXMncphgrpBfhHIaO4Ak5W5pkNCCzYzAGgKJgRAWEyuN
 w9/DePCmZ3Mh5TT31b2vxZrbg35pg9jxVAGac66ZSKnefLJl2VGq1Cv6G9Cgv552QSgDNyjOovj
 1DTO0WiAXdB8nbFrMGINdwWIc4yjfRMWELP2SWJ+4rcQ2/YLgG14GXK2zuBFyNYLpemB2mu3hk8
 epb93IH5erbAA1aTksu8XCFcAl59WhUZYc5zOcNOb6I24XTp/soFYuwvvXJmpt5gOs9QEas070D
 zdsUunlmdO/CKdBRr4B8lRva4o1wBf3lahU4SoncxGX1hPcuC4/kF1d9zuM2uQZ5ffZSrKmQWgK
 SRzANZcaYmTakaZa9ydSK3wWlsBD39TFoj+Fm7+5SJ1noef0rNNisn0VzSluqYrqzeMgM5k55O4
 jgEVCtsYDXiIpXQ==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 17 Nov 2025 08:16:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18418

Calling init_bb_cache() before init_config() creates the top-directory
already, before the user has accepted to proceed after the first few
messages:

  Bitbake-setup is using <topdir> as top directory ("bitbake-setup settings --help" shows how to change it).

  A common site.conf file will be created, please edit or replace before running builds
      <topdir>/site.conf

  Proceed? (y/N):

Saying N here would leave an empty top directory which is unexpected.

Move the init_bb_cache() call later in init_config().

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 bin/bitbake-setup | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index adf19ab09f..db6428f8d2 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -452,14 +452,16 @@ def obtain_config(top_dir, settings, args, source_overrides, d):
     upstream_config['skip-selection'] = args.skip_selection
     return upstream_config
 
-def init_config(top_dir, settings, args, d):
+def init_config(top_dir, settings, args):
+    create_siteconf(top_dir, args.non_interactive, settings)
+
+    d = init_bb_cache(top_dir, settings, args)
     stdout = sys.stdout
     def handle_task_progress(event, d):
         rate = event.rate if event.rate else ''
         progress = event.progress if event.progress > 0 else 0
         print("{}% {}                ".format(progress, rate), file=stdout, end='\r')
 
-    create_siteconf(top_dir, args.non_interactive, settings)
     source_overrides = json.load(open(args.source_overrides)) if args.source_overrides else {'sources':{}}
     upstream_config = obtain_config(top_dir, settings, args, source_overrides, d)
     print("\nRun 'bitbake-setup init --non-interactive {}' to select this configuration non-interactively.\n".format(" ".join(upstream_config['non-interactive-cmdline-options'])))
@@ -898,8 +900,12 @@ def main():
 
         print('Bitbake-setup is using {} as top directory ("bitbake-setup settings --help" shows how to change it).\n'.format(top_dir, global_settings_path(args)))
 
-        d = init_bb_cache(top_dir, all_settings, args)
-        args.func(top_dir, all_settings, args, d)
+        if args.func == init_config:
+            init_config(top_dir, all_settings, args)
+        else:
+            d = init_bb_cache(top_dir, all_settings, args)
+            args.func(top_dir, all_settings, args, d)
+
         save_bb_cache()
     else:
         from argparse import Namespace

-- 
2.51.0


