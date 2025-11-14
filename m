Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B900CE7AB3
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 11:07:59 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15473.1763118471311890460
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 14 Nov 2025 03:07:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=wC6FT9fM;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 317F8C10F62
	for <bitbake-devel@lists.openembedded.org>; Fri, 14 Nov 2025 11:07:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 015156060E
	for <bitbake-devel@lists.openembedded.org>; Fri, 14 Nov 2025 11:07:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 58C2B1037183F;
	Fri, 14 Nov 2025 12:07:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763118469; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=4h4frQ+UQWtRYQ7az1aHhxitLheYapobAmrYmkx/xLA=;
	b=wC6FT9fMnYa3IZs7soxNZYRofWy0c1ogbpy1TaYuSoDtcuhwhkonnO/526DpN5lm+Q9EUw
	gF962IqM7adWc1csgJcOxMbMlQ+dnANHlEDqwxx0O3eQeehvMphzDwqTYPIu1FPdvyP+YO
	DqbyTsyM+CbnQ/An6mERiBO64cCpNk3rfxzFLa//UYzZEZRKQaPjPKyP86eK7xaGdki1Z/
	0rat7zkdeUv/O5pIoOFW/F9pDGhByqDltQnoShs+m5w9FHaZ/VyFSxc4DTKtU6NCPqdbBh
	dEReDEOu9Bl+IH1MJCJvbwlKsTxVaIDn9lNth3xsB2nJ/YqU8BbsroAn4QV7IA==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Fri, 14 Nov 2025 12:07:33 +0100
Subject: [PATCH 2/3] bitbake-setup: create top-dir later in init
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-bitbake-setup-abort-v1-2-d2f9967df3b1@bootlin.com>
References: <20251114-bitbake-setup-abort-v1-0-d2f9967df3b1@bootlin.com>
In-Reply-To: <20251114-bitbake-setup-abort-v1-0-d2f9967df3b1@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2401;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=ZggVQgD1lamBTTKVAgpyRXEIqSLDwrTDxw9xjXrBiyU=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpFw2DjCbRFzEEtF375gx/rVPPg4dxej3pzPMbX
 5DQtxLA7eSJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaRcNgwAKCRDRgEFAKaOo
 Nut2EACqnbaP9ZmqjBtG6V584EBv/8F3UO87kKJXGL+6McxRYZwc04GSTifYZmXfUQ88BU3Fkqn
 gkhFGa7PgTGEWWy2JSrsxM+KYcAnAC+FoC+CBTHeOPUe9allUYL1+EE7zIeGSrb2nY/rC3nTpsj
 nT/ePoyIo4dUs5faRBk3LUMXM68o5c8qP5nzOonpMgKC+auoNAI/boYn7zMikS/H+5vCDOrh2sy
 HxXB5ckIsF0Pyjky65USwW6fPU8VkJ8LojAIKhrvzU1bcELRbkfUG6U2D66/zc3rnYxj5RHgkk4
 5w9EXN9zsENv7Ob8BczotcqUzeA44k+bD3rQSsQGc32cM2YDQf6A/AKn/iEeXXIz58vCtXtp5gN
 Spz7Tgn14GDZAIFtq+TAcJw1HW/NZ1Quh4xgx9AjMUf6jigxsqnOe5rKvoC5T1Uo21EcbARfiaA
 ZIwFPdZZFxioBtI8xUlFgv4IwD1hMtzxDi5EnJe7rjMQyBoPHWFuNP+V8PcYKjVDUr+DH4eA8W1
 uwLwCr+zTT7MTG1NRjTBT31KcfhdO73H6/hqGOtk+bSacTf4N2JfZkMVKmAgJHgAFg/oS4Sqnvk
 bhJiRsUVXX/wsUcfDYpF3cZUIiKShc2SF9yQSmQS/AT0ISK5EkeBjsi3h7JmU08TV5yIEgNadc3
 4QORHeRZP0RhmJw==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 14 Nov 2025 11:07:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18391

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
 bin/bitbake-setup | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 6410504d4f..3dc46cbbfa 100755
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
@@ -898,6 +900,10 @@ def main():
 
         print('Bitbake-setup is using {} as top directory ("bitbake-setup settings --help" shows how to change it).\n'.format(top_dir, global_settings_path(args)))
 
+        if args.func == init_config:
+            init_config(top_dir, all_settings, args)
+            return
+
         d = init_bb_cache(top_dir, all_settings, args)
         args.func(top_dir, all_settings, args, d)
         save_bb_cache()

-- 
2.51.0


