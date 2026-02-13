Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E02EDF168
	for <webhook@archiver.kernel.org>; Fri, 13 Feb 2026 13:50:53 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.71819.1770990651890237560
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 13 Feb 2026 05:50:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=NnJ9YIbd;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 0C286C1E4AA
	for <bitbake-devel@lists.openembedded.org>; Fri, 13 Feb 2026 13:51:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 590B1606BE
	for <bitbake-devel@lists.openembedded.org>; Fri, 13 Feb 2026 13:50:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A0E4210368E9A;
	Fri, 13 Feb 2026 14:50:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770990650; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=5PnWtHCncfoS2w2RvO/HkGrsS/GX0vbTRC8W6CORhxI=;
	b=NnJ9YIbdDHyPmCuVjvFlUH/h/K7s41QoYC9pORqgAmFUkTocnoRNx5v7/yrL2LydKlOuYG
	OppCT/AjF0iJN5fhtO2JGmCjpGPvO3NQAMzabgrgk+Sr2ZwlTc5zbZFPWxsGYDsOETY7gB
	e1zcHtVsR8SsN9Le2OMbfe/rYa/tAKIaKR792LP5Wak9WDK+ZRHD6rNAKNmWP9bIvZMnCc
	MFBdb98OmmBpHuPEVdu64kCUmbc3Tgf6wdMQBzngo8e1qT63BnTK8qHir70nJiqCjDbM/3
	orPV6mPQ777vRpR3g1yuCZpnTuMWCtxF8K8pUu0f1dIVww6fke98du/YbUxrRw==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Fri, 13 Feb 2026 14:50:42 +0100
Subject: [PATCH 4/4] bitbake-setup: print colored diffs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260213-improve-bbsetup-readability-v1-4-41cec3b06992@bootlin.com>
References: <20260213-improve-bbsetup-readability-v1-0-41cec3b06992@bootlin.com>
In-Reply-To: <20260213-improve-bbsetup-readability-v1-0-41cec3b06992@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2255;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=sCI3gBDVMWr/XlLVjIpmgJCrxbNtTKpT3gQVKREhLSU=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpjyw2f60ZK0AFal9hxv9rvjLoD/DmLjRwy6SfM
 1EuoHMrd1aJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaY8sNgAKCRDRgEFAKaOo
 NvWvEACKTxMZjr0/IgDDk9o2L4zvxy5Y/SRR+hCfv5GFyUD1aZ92YwUqeVNeCZTeNyDgQgItVf3
 3GKzGefu9tKwiu3qbUk+5e29L49mYTv8VfNI4QTFdSsJHuuWMOFyRrlrXw4/0ckkKGhp6A3A94E
 S0hxbxd2TC4NIPBUO6qVQ0l/tI3rFU+bvOix0Kc+590bhZ724/ERHSONulpeq9d0AxmcHrefB15
 vCh0YU7yFLrPIk5YakhGd9WSwb1c282eVivGHTTaFVz2zs6Nx+Cvsqdlt0DDUM+bDclzMgMX5eS
 pWHv/VPhkn7n+DGrZ4V9JSMtqBIrOQM8O3x8QYtkhvYb/A6uHWNBJ+zvRMY0aRvccH9sbJfA8BV
 UXolC8sAFvACY2ysj5WqiHxVqdtFIGoEB6vQseLk85XL5Qz/ykmyzczaal0bytNTDkPAyojJ8P1
 89kVbS4QjfqYXRA89kTG9eurizY8Wb/Gcd8ggaN+Q3U7y8z4ScBkkT01nsBTrNz8ZAcSEy+DnEH
 OfGQ48fy4t6vIUnCE9LWPig5XKHwKSNPM/BbzwT67MIvv2uurdiE+E7DxTPCBHMD1HDlERJT6YE
 /8dRd/dtSwZfyeov/HbB5Almnp7vGo4MYA74ggNe2Gow654TAUFtXsZpTrlaABSiWjrVomPpf91
 jKZ9gVDIlfXzExw==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 13 Feb 2026 13:50:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19027

Use the global BBSETUP_COLOR variable to enable color or not in diff
outputs. When passing "auto" to the diff or git diff commands in
subprocess tasks, the color is never shown, which is why we need to
force it using "always" when BBSETUP_COLOR is True.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 bin/bitbake-setup | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 19db14edb3e..b8acf972e14 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -196,7 +196,9 @@ be preserved in a backup directory.""".format(r_name, r_path))
         status = bb.process.run('git -C {} status --porcelain'.format(r_path))[0]
         if status:
             return True
-        diff = bb.process.run('git -C {} diff {}'.format(r_path, rev))[0]
+        diff = bb.process.run('git -C {} diff --color={} {}'.format(r_path,
+                                                                    "always" if BBSETUP_COLOR else "never",
+                                                                    rev))[0]
         if diff:
             return True
         return False
@@ -722,7 +724,9 @@ def init_config(top_dir, settings, args):
 
 def get_diff(file1, file2):
     try:
-        bb.process.run('diff -uNr {} {}'.format(file1, file2))
+        bb.process.run('diff --color={} -uNr {} {}'.format("always" if BBSETUP_COLOR else "never",
+                                                           file1,
+                                                           file2))
     except bb.process.ExecutionError as e:
         if e.exitcode == 1:
             return e.stdout
@@ -780,7 +784,7 @@ def build_status(top_dir, settings, args, d, update=False):
     new_upstream_config = obtain_config(top_dir, registry, args, source_overrides, d)
 
     write_upstream_config(confdir, new_upstream_config)
-    config_diff = bb.process.run('git -C {} diff'.format(confdir))[0]
+    config_diff = bb.process.run('git -C {} diff --color={}'.format(confdir, "always" if BBSETUP_COLOR else "never"))[0]
 
     if config_diff:
         logger.plain('\nConfiguration in {} has changed:\n{}'.format(setupdir, config_diff))

-- 
2.52.0


