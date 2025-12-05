Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C442D2E031
	for <webhook@archiver.kernel.org>; Fri,  5 Dec 2025 07:53:39 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.969.1764921218601241368
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Dec 2025 23:53:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=yj+ZUZlg;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 185664E41A58
	for <bitbake-devel@lists.openembedded.org>; Fri,  5 Dec 2025 07:53:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E3A1760731
	for <bitbake-devel@lists.openembedded.org>; Fri,  5 Dec 2025 07:53:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4F71C10B6055D;
	Fri,  5 Dec 2025 08:53:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764921216; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=RIVmi5KdTl8BSZ7i47n/uV/iPjlLcdqZGWgHFCVYODc=;
	b=yj+ZUZlgGFoHKOnrgDrjR9h8g2qpWmkktR0rGqJAsucUpiyYnS3c40VMGv1q+jZAYRW6/n
	N69/6UFOW46OxVwBTc1Jxavxajz1SWjaPQnFfyVT6UXiuMqsLOpQo6OJq77waUa4tiiiXG
	J491AIfRFC6TFl9bXN7qQBz1tKMV0sm75gV6Mc6t6crdLQ4onb4ksrQSHF7fZticxpgIVe
	N2u4smya07htpKk6zXSrE2xRxMcxfzamLXH4l+KUZ9df0iaBXaQG2g3+wDw4HlZaX2g2m9
	wK3Kj1S9K8aOH4PlYKReHhj5zOyTHdrXT0oOtAhDX33/T29QN1f/yt5EDHHY/A==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Fri, 05 Dec 2025 08:53:18 +0100
Subject: [PATCH] bitbake-setup: fix incorrect setting in note
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251205-bbsetup-fix-top-dir-note-v1-1-c3fdd0c21cc9@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAG2PMmkC/yXMywrCMBCF4Vcps3YgSesFX0W6aNKjjoskZFIRS
 t+9UZcfnPOvpCgCpWu3UsFbVFJssIeOwnOKD7DMzeSMO1rbG/ZeUZfMd/lwTZlnKRxTBYcwGHe
 aLn7Amdo9F7TNL30b/9bFvxDqt0fbtgNXrwQyfAAAAA==
X-Change-ID: 20251130-bbsetup-fix-top-dir-note-cc4026a8b4e7
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1405;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=uoS0Hv95LIRNb4Q1CLmpZoBaB2eGI9r9WFcTzlBV/R8=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpMo+AMAh4ACMxZyZt+W2LpYKVpdj4QQ4ET+WoJ
 njcrWicsL6JAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaTKPgAAKCRDRgEFAKaOo
 NhorD/4u+aLk5YynwV2+MF6m9yjG560lUBD97i9kxX3A3RdgjkQXgdigKBzo6c/+mwy+IK4T1gf
 Wxe5Aw2/tsOzPAhHX1r58CBcmXA/ARj+kUaewj/kKQMNRArNDvT9N0rH1pwf+TnPofYhKdLWLVR
 umNRRMQyg+510ffv6V8zTl4rn5Aq9OuloKLrfGKRE8xGusF4ZxfjLyObFmobFfzpqlkLaHmTAFd
 pg+9tln+LJqGRXACnUY7C/YsYm/RiZqYOmFxjYQcVt0xxpCwkNUns45Zd13vCZg6E6CNpIfDWFS
 OK0BmwfJ1JGccZWE6aqPQ0trKP77QiXOXMK11mFB9ok5dcvHDYiFCanEpBm/19EkLy7W/DG47jD
 plU9CGu9tcs8tsAGX/2I78wEE7obL1M9OyWUva4JEaBJqsCtVksqq0BqeP+Y40pCKFbcZq3/zgx
 BWGfV4wKCgOBLxen/sOdRlZV6Ujv5gyVV6uWcSlMloh2rbnbni9z5mMmISqSBBbJQ34AmrIvdsp
 NRzAZyKu0iBD6+V3oHE0wvbP9M2T+Z6N6jvDRSLgiHCNYD8ONh16A6xkaC43S7ad46ZhmrJ0vJS
 qupq9Zvbb0Au0Jl4mw+ykV0JyI7ryjeWoljfv2YYKnyrraHyrh9Jqt7XAzhVWi6R8siPa6Nvs5b
 Gi2UZD+n3r5LyQA==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Dec 2025 07:53:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18547

Fix the incorrect top-level-prefix/top-level-name settings to
top-dir-prefix/top-dir-name.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 bin/bitbake-setup | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 75be909405..9d45deb421 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -725,8 +725,8 @@ def create_siteconf(top_dir, non_interactive, settings):
     else:
         print(f'{top_dir} looks like a new top directory. If you would like to use a different directory, answer "n" below and either:')
         print('\t1) Change the default bitbake-setup settings:')
-        print('\t\tbitbake-setup settings set default top-level-prefix <PATH>')
-        print('\t\tbitbake-setup settings set default top-level-name <NAME>')
+        print('\t\tbitbake-setup settings set default top-dir-prefix <PATH>')
+        print('\t\tbitbake-setup settings set default top-dir-name <NAME>')
         print('\t2) Pass one or more options on the command line to change the top level directory in that invocation only:')
         print('\t\tbitbake-setup --setting default top-dir-prefix <PATH> ...')
         print('\t\tbitbake-setup --setting default top-dir-name <NAME> ...')

---
base-commit: 720df1a53452983c1c832f624490e255cf389204
change-id: 20251130-bbsetup-fix-top-dir-note-cc4026a8b4e7


