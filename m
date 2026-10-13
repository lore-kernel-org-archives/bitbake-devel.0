Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42DFCC6B18
	for <webhook@archiver.kernel.org>; Tue, 13 Oct 2026 12:14:12 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5690.1791893646723469972
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Oct 2026 05:14:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=IQNUEa6i;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 8D71DC653EB
	for <bitbake-devel@lists.openembedded.org>; Tue, 13 Oct 2026 12:15:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0A1AA60362;
	Tue, 13 Oct 2026 12:14:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 08FAD11D71058;
	Tue, 13 Oct 2026 14:14:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791893644; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=SKAMb2L/OfNiCtu1zfi6Fqc1sDv1OFcPTLgLzk5zCkg=;
	b=IQNUEa6i/nxR5kxvbD9KzwtY51Dqi8lYuhBlP8hq5Gzu6thUoVDGkf8675OBDumvu5ICIK
	RxXM/Hs+3ydsVrvkkujo6/9+hkdZu0QMeSKY9dvrXeXwKIB/fjYT8LUe4ER+pUPrhmPwbQ
	qwCBbZXXswWQfoWD5ED394TkOeCYIk0hDTDkd4CKvDsQov4oK6ORF17mL67cq2bBRXtxbA
	A6uUnRRv7W5V3FnCOzaMGZuut/LTKBiXGom8ClGa4rZwiKZ1weM21xoLMJ2ET9lM39MK91
	Nb2uWBt7xrBiz0B5XY7jcNwVWKipFZPa1nv4FJoO9aiQPhDhYd0LYHLf74JKMw==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Tue, 13 Oct 2026 14:13:36 +0200
Subject: [PATCH 3/4] knotty: convert warnings to errors when -W is passed
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-warn-as-errors-v1-3-ab3658758ceb@bootlin.com>
References: <20261013-warn-as-errors-v1-0-ab3658758ceb@bootlin.com>
In-Reply-To: <20261013-warn-as-errors-v1-0-ab3658758ceb@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2179;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=6Masqy+hbBKtotiStPySW3Pr0daMVYYOOh3Hh8f/H3M=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBqziB0s++R6AVnKiRVnRL3Co01BfqUhjWhMZK/h
 EiVXUAyJh2JAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCas4gdAAKCRDRgEFAKaOo
 NnKBD/43oAqZVfJU2fh2J+69+8kg/t7vkXKv3BRRkry4ljnCakUzi70p8d70mblxN36KyV02nYK
 uoa7GKsNJY2Pui6O1+MCqi1GMA1ioJQ0XeQw2i5kvGiimVJuEAboWralA1gx5VO1bNZ2T36P05n
 G7T6GN2rmroaioyoxhKxewhYRwOSAEUGku/GKyntdgpy3rQE51WGe0V9OpHa/Z8ETIUG7oGwdQs
 8YE+5jjQ7fcbVn0IxPnEiHEMM8+HMns0zhllJWCXbSNb7i55RIM8NVYINs4iHCsdkzLZyXthlH+
 rBd9DswZJ1kTmny4jfmaHdlUTe87zEUtPUMuINNpMUbDCaAuiRtG1UBgUrjNZTxouOQRoXgpyNu
 DJ2IwebhOqmVzd/T68lyu+UtS+ER2dcPUe1I4ro+yGVoIlsp+61lxphe3ht0X8Ye9JBbvFpFq24
 napztn/rB3sob7fsCOj170OaIx55q/hLMVJdycABO7XGKxhfc87NjIYpw9XrCF/LNQEcTPe818i
 0TDz7cSdPVGXUq7Np0crCmLWkBxVILwu7wSyOO8q25d1NGQsGUV6wa9hcyB3w8WYGkV6ELUnLXm
 ulWSnD8YFBF/UPCqiTKtYeeMPCJ6En3O98gkafyaqlqOMWdzgJZL05EXTsVi5ea7C7N8SsNJuSd
 VyY3g2O1kipkWcg==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 13 Oct 2026 12:14:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20328

When -W is passed, modify the handlers to show warnings in red and set
the return value to 1. Add a summary line informing the user that the -W
option was used as it might not be obvious when looking at the bottom
the end of the console log.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 lib/bb/ui/knotty.py | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 1a3198b5c02..a3a5c374a35 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -662,6 +662,14 @@ def main(server, eventHandler, params, tf = TerminalFilter):
     # terminal handler
     console_handlers = [h for h in conf.config['handlers'].values() if getattr(h, 'is_console', False)]
 
+    if params.werror:
+        # Change the color of warning/warnonce messages to red when -W is passed
+        for h in console_handlers:
+            try:
+                h.formatter.set_warn_color_red()
+            except AttributeError:
+                pass
+
     bb.utils.set_process_name("KnottyUI")
 
     if params.options.remote_server and params.options.kill_server:
@@ -782,6 +790,8 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                     return_value = 1
                 elif event.levelno == bb.msg.BBLogFormatter.WARNING:
                     warnings = warnings + 1
+                    if params.werror:
+                        return_value = 1
 
                 if event.taskpid != 0:
                     # For "normal" logging conditions, don't show note logs from tasks
@@ -1054,6 +1064,10 @@ def main(server, eventHandler, params, tf = TerminalFilter):
         if return_value and errors:
             summary += pluralise("\nSummary: There was %s ERROR message, returning a non-zero exit code.",
                                  "\nSummary: There were %s ERROR messages, returning a non-zero exit code.", errors)
+
+        if params.werror and warnings:
+            summary += "\nSummary: Warnings were treated as errors (-W)."
+
         if summary and params.options.quiet == 0:
             print(summary)
 

-- 
2.55.0


