Return-Path: <thomas.perrot@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F4ACD343B
	for <webhook@archiver.kernel.org>; Thu,  7 May 2026 14:37:32 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13500.1778164648631030970
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 07 May 2026 07:37:28 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bootlin.com header.s=dkim header.b=F8SHjeDm;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: thomas.perrot@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id AE5464E42C2D
	for <bitbake-devel@lists.openembedded.org>; Thu,  7 May 2026 14:37:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7E1C860495
	for <bitbake-devel@lists.openembedded.org>; Thu,  7 May 2026 14:37:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D00E31081949C;
	Thu,  7 May 2026 16:37:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778164646; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=ZrIpf4FUrx6s437/GugkmMRfcqe0ZBkKIEyXVk6YeKs=;
	b=F8SHjeDm1lMwI+wu6yZofKMr5b7++GW5VHLn9qsa9NBJx8r/0bWU8wQmRUqlMtg7Msvdd3
	B2ighc8z0KN3HQoEL7+EWf0OXFR9dvbHYXQWCcnm0Ft9r5cmCUmh7HkFpPT/HoR6Sa2EQL
	yf8T07yFcmkeA3xzD+r37aTYFF2nwGYxJFR5mvfaZAyhUI9WdRl1qQ4zAnqu6KbOJU4KbO
	KaHlJczkkaOdMB9hb0QBVWIv+JO4qrTPPRL2epxch1wupA+c0rAtmKV5UwQL9I/La0f8P3
	8CZ75R/rxb/8k+PP6UL+BwMpVSq9bbHN8x1fWhEcaWjEianAT6A1tSwnZrilug==
From: thomas.perrot@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: thomas.petazzoni@bootlin.com,
	Thomas Perrot <thomas.perrot@bootlin.com>
Subject: [bitbake-devel][PATCH] fetch2/crate: move cmp_to_key import to module level
Date: Thu,  7 May 2026 16:37:11 +0200
Message-ID: <20260507143711.974105-1-thomas.perrot@bootlin.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 07 May 2026 14:37:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19469

From: Thomas Perrot <thomas.perrot@bootlin.com>

The import was duplicated inside both latest_versionstring() and
latest_versionstring_from_index(). Move it to the top of the module.

Signed-off-by: Thomas Perrot <thomas.perrot@bootlin.com>
---
 lib/bb/fetch2/crate.py | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/lib/bb/fetch2/crate.py b/lib/bb/fetch2/crate.py
index eb1fd5719e8c..b46d4f1a9801 100644
--- a/lib/bb/fetch2/crate.py
+++ b/lib/bb/fetch2/crate.py
@@ -14,6 +14,7 @@ import hashlib
 import json
 import os
 import subprocess
+from functools import cmp_to_key
 import bb
 from   bb.fetch2 import logger, subprocess_setup, UnpackError
 from   bb.fetch2.wget import Wget
@@ -159,7 +160,6 @@ class Crate(Wget):
         """
         Return the latest version available when versionsurl is the [nam=
e]/versions URL.
         """
-        from functools import cmp_to_key
         json_data =3D json.loads(self._fetch_index(ud.versionsurl, ud, d=
))
         versions =3D [(0, i["num"], "") for i in json_data["versions"]]
         versions =3D sorted(versions, key=3Dcmp_to_key(bb.utils.vercmp))
@@ -172,8 +172,6 @@ class Crate(Wget):
         file.
         https://doc.rust-lang.org/cargo/reference/registry-index.html#in=
dex-files
         """
-        from functools import cmp_to_key
-
         versions =3D []
         response =3D self._fetch_index(ud.versionsurl, ud, d)
         for line in response.splitlines():
--=20
2.54.0


