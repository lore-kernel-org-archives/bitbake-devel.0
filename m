Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C732AC5516D
	for <webhook@archiver.kernel.org>; Fri, 20 Feb 2026 09:14:31 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.34737.1771578868402562387
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 20 Feb 2026 01:14:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=fYiKWYVM;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 3816B4E407AF
	for <bitbake-devel@lists.openembedded.org>; Fri, 20 Feb 2026 09:14:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id ECEE35FA8F
	for <bitbake-devel@lists.openembedded.org>; Fri, 20 Feb 2026 09:14:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 528BC10368C6E;
	Fri, 20 Feb 2026 10:14:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1771578865; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=IEFlVi2DOl7J+PB9eDccExALGWVGdIsv1PM7fO56tI8=;
	b=fYiKWYVMzNPXzaD5jr0lhzMl7bNrAbYEsEMMEJV4f8S9vxtgbuvu3FqftXWQgdaXheasCx
	colcz2woPltaiMgPTDC2GdxgYnpljAX8kF+Pqgx5rZBKl/VmYhfk8v+s0zQjcAlEYMl8kw
	vx9X6ujD1d8al/7qyLwixUGaaVBlbL4v2gbEqxK1z5bHpaz9ASZtIjJhYYi4oFi7Czjfjj
	QpSqYZu9K8zl7zNObCIBmLfe7j+rsCD5gx8M//rTZUp35jCUvQzotR7dU0CSnYgE09fwEb
	s39EqIr2YPnR9eS9FFAeXABArrlyI1vBFYOrBC6rseVpmwXXxoXn8oxRWHnxcg==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Fri, 20 Feb 2026 10:14:05 +0100
Subject: [PATCH v3] bitbake-setup: print colored diffs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-improve-bbsetup-readability-v3-1-baed6930af87@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NSw6DIBSF4a0YxqUBFKMddR9NB4DXehsVA0hqj
 Huvj0k7cXiSk++fiQeH4MktmYmDiB5tv470khDTqP4FFKt1E8FEzrhIKXaDsxGo1h7COFAHqlI
 aWwwTretcMYACQEiyCoODGj+7/nge24/6DSZs5PZo0Afrpj0f+fY7SoKflyKnjGbcgEk1y8tS3
 LW1ocX+amxHtlYUv1pxrolVSyWXRQayqkvzry3L8gWdibvEKAEAAA==
X-Change-ID: 20260123-improve-bbsetup-readability-ff6a0ee8ee25
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2911;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=72UqHSE7+LtNDSFv0XLdyxbXIKLBwMduXrvS4GEhdNw=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpmCXwICrMAnDdwI4cdQYJ04AMj5HttNL9PNi5k
 r1BM50sJsyJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaZgl8AAKCRDRgEFAKaOo
 NvYEEACTTbjTePH9jz8tdlHO30/4wUorwwrIiNisxf9N8aH7XYy84KpX1o0P4qJWZdBA8Qbi0rF
 K108B/6dqOv/41FuCr382Lbl0CC7ocYYpH7Z3mg1Z1ngZpZwVJZiCoi0F0E/SB1j4TWUr2JJgy4
 lI2EMmN2+pjya87OkoHB1RR20beNZHXiaJCpytUje2J/OvMksBNyWR+IkvJCMB2a72qco6GDB1L
 cmiomZTFHvbWX6sZbOtQjyiUwtyfAQPZeez3hGwL6jebH3SqTtXgU8jL6JpCmTN9qOM6aa6/64F
 SlKiZk2KcYoF25cjbZIPDtz2DFQaTkJLAED5wHg8uuyQu1RHu13UjgU47Ndv4QDBkL8CnILqsdZ
 ihvfROvrq4BwtkvZdtVcw9IvzbdVqPh1qBUYoMF3Adjq7F+WGR5PxJkzf/Rw1MyROSOzCIYOlpl
 /mlhboZa2T8Nzbei5eaurQjQxwXTzuczfiTV2QlJyLtQ0yVvl2hhQgIDquI+oXCwW6Z/fV8P7Y4
 O7Y62icfo06rzDk8gruXlRVDoq7Nip4oX9LRUqr/o9xF4okdZbac5N4RZ/WoZyERO8xHFhP+/IP
 1Y1s6TCWduDVzTv752YtN7/kGCehVSupLjegEGeuWdrYBg09UdBOulUW1e4NQkh/FPeyGz81hPr
 8cNMiitB8N4Dotw==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 20 Feb 2026 09:14:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19074

Define a get_diff_color_param() function that returns the --color value
for diff commands. It function also uses color_enabled() to force showing
color or not in the spawned subprocess (--color=auto would never show color).

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
Changes in v3:
- Rebase on master
- Drop patch 1/2 (merged)
- Drop patch 4
- Define a get_diff_color_param() helper function for diff commands
- Link to v2: https://patch.msgid.link/20260218-improve-bbsetup-readability-v2-0-351584e5df9c@bootlin.com

Changes in v2:
- Drop the --quiet patch
- Define a run_git_diff() helper function used for printing colored
  diffs. Drop get_diff() in favor of it.
- Link to v1: https://patch.msgid.link/20260213-improve-bbsetup-readability-v1-0-41cec3b06992@bootlin.com
---
 bin/bitbake-setup | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 9b0ecc8d0e4..553164b575d 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -42,6 +42,9 @@ def color_enabled() -> bool:
     """
     return logger.handlers[0].formatter.color_enabled
 
+def get_diff_color_param() -> str:
+    return "--color=always" if color_enabled() else "--color=never"
+
 def print_configs(prompt: str, choices: list[str], descriptions: list[str] = []):
     """
     Helper function to print a list of choices and align the output.
@@ -202,7 +205,7 @@ be preserved in a backup directory.""".format(r_name, r_path))
         status = bb.process.run('git -C {} status --porcelain'.format(r_path))[0]
         if status:
             return True
-        diff = bb.process.run('git -C {} diff {}'.format(r_path, rev))[0]
+        diff = bb.process.run('git -C {} diff {} {}'.format(r_path, get_diff_color_param(), rev))[0]
         if diff:
             return True
         return False
@@ -728,7 +731,7 @@ def init_config(top_dir, settings, args):
 
 def get_diff(file1, file2):
     try:
-        bb.process.run('diff -uNr {} {}'.format(file1, file2))
+        bb.process.run('diff {} -uNr {} {}'.format(get_diff_color_param(), file1, file2))
     except bb.process.ExecutionError as e:
         if e.exitcode == 1:
             return e.stdout
@@ -786,7 +789,7 @@ def build_status(top_dir, settings, args, d, update=False):
     new_upstream_config = obtain_config(top_dir, registry, args, source_overrides, d)
 
     write_upstream_config(confdir, new_upstream_config)
-    config_diff = bb.process.run('git -C {} diff'.format(confdir))[0]
+    config_diff = bb.process.run('git -C {} diff {}'.format(confdir, get_diff_color_param()))[0]
 
     if config_diff:
         logger.plain('\nConfiguration in {} has changed:\n{}'.format(setupdir, config_diff))

---
base-commit: d9700632bd6b627d1124fdc83ddf7bfb4199228d
change-id: 20260123-improve-bbsetup-readability-ff6a0ee8ee25


