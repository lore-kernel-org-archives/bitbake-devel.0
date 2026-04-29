Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59877FF8875
	for <webhook@archiver.kernel.org>; Wed, 29 Apr 2026 09:13:05 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7149.1777453979906732852
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 29 Apr 2026 02:13:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=VldLH1UX;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E63131A3478;
	Wed, 29 Apr 2026 09:12:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B74D8601DF;
	Wed, 29 Apr 2026 09:12:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B4E7B1072860C;
	Wed, 29 Apr 2026 11:12:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777453977; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=tk8USsdLxU+BQPZ2O15izMuivQod75afag7ySSFJ5OM=;
	b=VldLH1UXSkOB/i6dKvPxSd0pvgmGy+YwM5w3wxxnicnAjz4I45wiDtzsD44SGVA0MwbmNg
	inPAnBWgSrHtOR9sUwZyMT/Kpulc9hFXYEEMFCj9YjLswj1TUdqzqD3jA5grCbZidpbmtH
	aQIlrIUZUVj4wQiPOKTSklhQvSVg68nZiwsMOHPttuxoLZRaAjPJgG6JU11FuZ2Z/4/tpA
	b4aTsZB4qaKo+2BKMDn7pcAbwYn3ijNCus4zZYCAKgYX/oUq74NPGVRlYxucJR34fDuiQX
	PpY7lBlw7uhegYhkGePxVWLH5z+RP7a/CCsvvwNDLP/JLOsVVw3a3WenTe+++g==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Wed, 29 Apr 2026 11:12:52 +0200
Subject: [PATCH] doc/setversions.py: add --get-latest-branch argument
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-doc-get-latest-branch-v1-1-e5a0ce87cec4@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBG4avIrDsQU1HpVUoXMfnVKSWWTFoK4
 t1Ndfkt3ltJkQRKt2qlhK+oLLGgvlTkZxcnsIRissa2prE9h8XzhMwvl6GZh+SinznUHUyAbXp
 3pdK+E0b5Hd/747R+hid8/s9o23Yy5/TBeQAAAA==
X-Change-ID: 20260428-doc-get-latest-branch-d17e0de248a3
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1948;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=U7RdIWC27g1j4A+jAmU8HwtNYBzbD97dno6Psj2U25g=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBp8cuXLpe+k+5IuAw2qdWKCdt2jtk7Yuf4I9F5P
 2kVlYiGNZGJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCafHLlwAKCRDRgEFAKaOo
 NknJD/9X5Yf7NdLOYCGGAQGdr5vFBPksjVwHeiJ19agQJ9KOMNw+SrwoTevZzj2On5E8Chah7jx
 6COMobAtz57UjFmctHDMK9HG+rFO78X2rv6VYKeNOlgcxluPj7JKl43onzmULVr/YYDz5V8C+xs
 zjNGkEqh7z6iE3ui9VQn1KH8YgfJqXbrqAz0sFD7Pjq0bsHpDDARH5mBHnhpc21EOWo8gaFEuhQ
 p7r1SjibSzeFZish+6kxGrJJX82okD1X5yjXiboVk7HGQA2GVI3sWWyhq16W5CJHcKzngcKcFDR
 wz+dc+BwxB1zWZGZs47v9iHGL+K7rR1LDBe08rr8D3lePQNJW+pN3Pv/N/GNSgwkWMtSMDGw35N
 IEBep6xQRSSvNLsp/sMnKxV7GfivGq0sCkKfRFfml0DiF0bbYgLFndo3IUFtvsoGZ/8uNBAF3rC
 38ZRneRRVeJDSiDEqonEN56ktrZv7XSrLXvm1PNQKeSIIoLfYuoo8e4gKpbS8OSJWcqmen7IQme
 /zwpuP1dDIOUYS8JJkhXoPRf4iOQMii3wQ/Om3qpY0Gem/+RAvHeiEnM++yQU1pIcT1mTUSRPdY
 3KU8WNsiFR+0NVjKmIz+p0ydJm33r0mx/bSui735/u/V2R4iQCnxKikpKO1oOF6X/4xSwmXDF1P
 40jHRJj3h3MLOQw==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 29 Apr 2026 09:13:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19411

Add a --get-latest-branch argument that can be used to show the latest
branch from the parsed releases.json file. This will be used by the
Autobuilder to know what the version of the default bitbake docs page
should be.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
Note: Companion patch on the yocto-autobuilder-helper repo will be sent
after this one.
---
 doc/setversions.py | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/doc/setversions.py b/doc/setversions.py
index f1aea0a4225..c4127bb43fd 100755
--- a/doc/setversions.py
+++ b/doc/setversions.py
@@ -13,6 +13,7 @@
 # SPDX-License-Identifier: MIT
 #
 
+import argparse
 import itertools
 import json
 import os
@@ -23,6 +24,15 @@ import textwrap
 
 from urllib.request import urlopen, URLError
 
+parser = argparse.ArgumentParser(
+    description="Parse https://dashboard.yoctoproject.org/releases.json to get current releases information"
+)
+parser.add_argument("--get-latest-branch",
+                    help="Get current latest branch",
+                    action="store_true",
+                    default=False)
+args = parser.parse_args()
+
 # NOTE: the following variables contain default values in case we are not able to fetch
 # the releases.json file from https://dashboard.yoctoproject.org/releases.json
 DEVBRANCH = "2.18"
@@ -85,6 +95,10 @@ if RELEASES_FROM_JSON:
     # current releases is also an LTS
     ACTIVERELEASES = list(dict.fromkeys([current_branch] + LTSSERIES))
 
+if args.get_latest_branch:
+    print(ACTIVERELEASES[0])
+    sys.exit(0)
+
 print(f"ACTIVERELEASES calculated to be {ACTIVERELEASES}", file=sys.stderr)
 print(f"DEVBRANCH calculated to be {DEVBRANCH}", file=sys.stderr)
 print(f"LTSSERIES calculated to be {LTSSERIES}", file=sys.stderr)

---
base-commit: b79667b6599494a0ed209d48bf8bbb7e8921d926
change-id: 20260428-doc-get-latest-branch-d17e0de248a3


