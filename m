Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392C4EBFD12
	for <webhook@archiver.kernel.org>; Mon, 13 Apr 2026 07:59:00 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.267216.1776067138813205923
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 13 Apr 2026 00:58:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=PTD55QSt;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 47C2AC5B19E;
	Mon, 13 Apr 2026 07:59:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C4B9D5FFB9;
	Mon, 13 Apr 2026 07:58:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E0B7010450096;
	Mon, 13 Apr 2026 09:58:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1776067136; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=QPjPNU2mdeZuU/aiK55MimBXdmkmrZT7ybMzP0q7B2Q=;
	b=PTD55QStO+0FWW7OlLsEZF2FPf8ybGpfUZ8p+mzmw978UplT/KJdkg8Z/4hF2gfiAkabrC
	H/UMUiMvAMjMEcL7CBQqg2qMaZxErdc6mcdnjK1EJOJ2oq9tEckwBflBSVpUl2h8gU6neB
	Nqdg5pQpj8arAAiLE6nDt139XqbqdmQJGf3AXeQdDL9rCx+2Hok1F4Upt7QmLKuYSArrj6
	+a/0ZRr/LEM0n+N2RNFrY5Dwwkn8iRxIbB0SqgJpxzYSqOxnsMJDPE9WU2Gdookm5LzzPn
	Xc1bv7DCK/IqBrd02tlGToHgb/3hMvcKnS6lbU3KrCiPU4uc4WzkTGMPUPWvQg==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Mon, 13 Apr 2026 09:58:47 +0200
Subject: [PATCH] doc: set_versions.py: change strategy for the default page
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-set-versions-fixes-v1-1-ed5c4f9e624c@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQqDMBBFryKz7oDGVLRXKS6M/tRxYUtGRQje3
 ViXj/ffj6QIAqVXFilgE5XvnKB4ZNSP3fwBy5CYTG6q3BYlKxbeEK6dspcdys+udhXKxlnjKYW
 /gL9I3bu9WVc3oV+uJzqOE2kVHOB2AAAA
X-Change-ID: 20260413-set-versions-fixes-5a8b6e39b42f
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2142;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=VJKKXppDyroXXu1yaPUqgZfdWFHWSQYvUIQ7aOEreaY=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBp3KI+xqxq1esWclaKTkGgc91Fj1tubOZsXqIgU
 oA61CUYU9SJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCadyiPgAKCRDRgEFAKaOo
 NnQ3D/4hhb82w+H4uvmiNFkN1FZmSwA6AfRt/aVzC+fBtq5Vvqq3O1JSFrm1KqIz437SIABvwvT
 2fSw2kuXqMZ1zuHvWkfYG8hcOwygqSNAg+EyiBBal9qJqmrsnVRKyKxsIzVZKWeC7Q447r041PG
 KMC0mTxubS+b9HEdN9Pe/nRVjMk8+Eatw5uZGAvN5MIzZhRs+tIYfdqZWDLhbT2nW+K4OldHh5j
 falC6I7f3c47PM2hJs3aGvMVopF7GrJBhR2+xwvl5dFeZTDBS06uy4hCZ0QJwY9krCa0stZmpDD
 p87RiZhzFHigoQ8XsEAehWPKUh8W2MB6m/9Pkg7DPBTbCZZakShatW72rDaiVvLbZfj/lfgLQ8t
 Ym3h9weFbN7qCVbrxefVyu0sP2ZLrVLVr2fu2AaGXOIju0Y1vl1SmAGwn53I2eHU3hyUphWMwld
 3hIC2sIPEFPbAeEByZ0iMNoqxqxdcobEoR3YjNPanbxrWYSZqm/secYzh6SVJFIR/OwqeUqCzlV
 w2GjJQ6pW8w1qgtod2Ea4fX8TWRtOg2irl3bhDD7H+6TLt7n5BseLWCUUPls6z6yMHsG41KExm9
 TvyYryQ0NAXAfIF3fpiOekPQlDzmFXU16R5k84N1eLIQgTKytgzNlN4OvrClpbHmAOCnAiW4WU1
 hRClvpC4hC0DgPw==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 13 Apr 2026 07:59:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19359

A problem can happen with the current code: if the current stable release
is made EOL before the development branch is made the current stable,
then we only have LTS releases displayed.

Change the logic to _always_ display the latest non-dev branch as the
default page, even if EOL.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
Note: this fix are the same as the ones sent for yocto-docs, see
https://lore.kernel.org/r/20260413-set-versions-no-current-release-v1-0-9c40207c8604@bootlin.com
---
 doc/setversions.py | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/doc/setversions.py b/doc/setversions.py
index 82a0e8b191b..f1aea0a4225 100755
--- a/doc/setversions.py
+++ b/doc/setversions.py
@@ -65,14 +65,25 @@ if RELEASES_FROM_JSON:
         bb_ver = release["bitbake_version"]
         if release["status"] == "Active Development":
             DEVBRANCH = bb_ver
-        if release["series"] == "current":
-            ACTIVERELEASES.append(bb_ver)
         if "LTS until" in release["status"]:
             LTSSERIES.append(bb_ver)
         if release["bitbake_version"]:
             YOCTO_MAPPING[bb_ver] = release["release_codename"]
 
-    ACTIVERELEASES.remove(DEVBRANCH)
+    # Find the first non-dev release, which should be displayed as the default
+    # page on the docs website.
+    current_branch = ""
+    for release in RELEASES_FROM_JSON:
+        if release["status"] != "Active Development":
+            current_branch = release["bitbake_version"]
+            break
+
+    if not current_branch:
+        sys.exit("Unable to find a current release! Exiting...")
+
+    # make the list of releases unique, there can be duplication when the
+    # current releases is also an LTS
+    ACTIVERELEASES = list(dict.fromkeys([current_branch] + LTSSERIES))
 
 print(f"ACTIVERELEASES calculated to be {ACTIVERELEASES}", file=sys.stderr)
 print(f"DEVBRANCH calculated to be {DEVBRANCH}", file=sys.stderr)

---
base-commit: 5d722b5d65e4eef7befe6376983385421e993f86
change-id: 20260413-set-versions-fixes-5a8b6e39b42f


