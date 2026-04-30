Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9499DFF8873
	for <webhook@archiver.kernel.org>; Thu, 30 Apr 2026 13:18:53 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.20363.1777555125599468195
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 30 Apr 2026 06:18:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=itZUaKlf;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id EAECE1A3485
	for <bitbake-devel@lists.openembedded.org>; Thu, 30 Apr 2026 13:18:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C1E4D60495;
	Thu, 30 Apr 2026 13:18:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1BBAE102F291C;
	Thu, 30 Apr 2026 15:18:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777555122; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=PcicQzUt2xnfssHiwY4WShJrlk90OWKTdKFOHx4ePao=;
	b=itZUaKlf2W5aRFaBsOV3sovErl/SxUXB0uOXNvrhEJOuwdSYUtd+q/tOPpvLugViO/zQea
	IB3Uv13EiHgVMFedsQUMCJAvfyUQd4flIlE/vrMzY2+Q7dBPmXzO5bsl4S2zfzyk/s+MIH
	jndyyOudinhBgGRxMwgZIS6KAab0yzhpfVCqcILVwcXBmz08a1RFGpJ1Vg8DlsnWHPfjfR
	o0WwBugW1CjJm3GUAHYnC/KYX+k4AydAIWNEOlT8ZzQpiWIvxfpHZ3II9hwvfGD941PSsp
	WQ8w6jBLsgbHoOjflBZtRbKgvpWzfZx9tpc0UTRYm865v6uKEOUId+blYLz5aQ==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Thu, 30 Apr 2026 15:18:16 +0200
Subject: [PATCH v2] doc/setversions.py: add --get-latest-branch argument
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260430-doc-get-latest-branch-v2-1-fda956696a61@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNQQ6CMBBFr0Jm7Zi2oqAr72FYtNMRarA1bSUaw
 t0FjEuXL/n/vRESR8cJTsUIkQeXXPAzqE0B1GnfMjo7MyihDqJUNdpA2HLGXmdOGU3Unjq0smJ
 hWZW13sH8fUS+utfqvTRfTk9zY8qLbFl0LuUQ32t4kMvu1zj+aQwSJfJeC+K6IqbybELIvfNbC
 ndopmn6AEi5PjPOAAAA
X-Change-ID: 20260428-doc-get-latest-branch-d17e0de248a3
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>, docs@lists.yoctoproject.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2318;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=2PnmUrnNqyOoLxpf3AEeqYMf7tbMVvToiJ/X/AoM0Ko=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBp81aw4RvlgohaFQypIFFixRc+iQg/Z1oX69/Oo
 dZEaOEWpf+JAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCafNWsAAKCRDRgEFAKaOo
 NhLvEADHVR9cb2vtwhDKV1JNUIy2eeXdXqyMxLynd26N2h4or5DFeAtMmbvh2zVIzoZW5lL+Odv
 giDxmQoYSsmCMNjPOxRpurqLapuhVqHDQ4d92T34avisXULcx4w9pwiHbjL4euapxUz+Ip/z3Y6
 OHQBasAOzDQaWNdWVOMw935OIJHzIUl2i+AqlcOLkc3CtlCC+9TUDGyhGbwg6i1s+VTxZH0e61U
 u2cB9Y/NQdokHYdynRnc10R/VmfqoE7nMbYgHn/IGBvp0VJOJZFDAr9TIqyKnmA0emsse575Yth
 XwFuODG0Rh+vbAh8Hz1FqSxfpqmaEz/5mJ9jP3By9w51NprtGPZYmSdOpqjVskVUFhLArJcU72r
 mbqABdwjYhv3x6y9JISQBd/IygrAAOfPV8UMu21tdbBV4oxGFQNp3R6DYoIuTsXhPXaDOjLZ9O5
 7R8xAUrY0ex+6V1U2hd6jtvg2S56ribfwbEYlEBLbtU41Gxt70pSt509oLWUI2yLQVi7n16MZHQ
 JbcKu3treud+5Ii38EmNzwRt2vG4Tek0j22mqSIqQKJ9LoV/vocCl3ThWQ+G2avIObTHx3Oilnv
 Q1m5IUizpQk2Zs553ly1ueYQpfNn95nwcY+QTUnkFJ8XSOoUuSCd8YsK8u+fXxOME+8QMRmu/fX
 hqS9NWTJj1Nom9g==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 30 Apr 2026 13:18:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19422

Add a --get-latest-branch argument that can be used to show the latest
branch from the parsed releases.json file. This will be used by the
Autobuilder to know what the version of the default bitbake docs page
should be.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
https://lore.kernel.org/r/20260429-fix-docs-bitbake-latest-branch-v1-1-25cce6bf4f26@bootlin.com

Note: Companion patch on yocto-autobuilder-helper:
---
Changes in v2:
- Fixup help message as suggested by Quentin
- Link to v1: https://patch.msgid.link/20260429-doc-get-latest-branch-v1-1-e5a0ce87cec4@bootlin.com

To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: docs@lists.yoctoproject.org
---
 doc/setversions.py | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/doc/setversions.py b/doc/setversions.py
index f1aea0a4225..dc0bb11e75e 100755
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
+                    help="Print current latest branch and exit",
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


