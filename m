Return-Path: <thomas.perrot@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4519CD3439
	for <webhook@archiver.kernel.org>; Thu,  7 May 2026 14:37:02 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13490.1778164614361398130
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 07 May 2026 07:36:55 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bootlin.com header.s=dkim header.b=VpnQRVHo;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: thomas.perrot@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C699F1A3562
	for <bitbake-devel@lists.openembedded.org>; Thu,  7 May 2026 14:36:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9599260495
	for <bitbake-devel@lists.openembedded.org>; Thu,  7 May 2026 14:36:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CFEBE1081949C;
	Thu,  7 May 2026 16:36:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778164612; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=YnalVfgzwKT+KioNVq0QI8oRQgmYnCRGSlDD/0kX7IM=;
	b=VpnQRVHoaQSKxZpfZp6SW/4BggrsV0KJSXjkjn/sIWtYp/ZJ+a2z3Ert35hmWsuAd1ZxVd
	3vSrzXBFkjYlnZwzLf3/IpEpKJblay31YxW1uTZ7Rbo+eLK7gYxYK78maywhGlGWMCICji
	vbbzaXQsdrNZJKPgmXxXMy8ufJxjotvzdHUtcEoBOv8UCTSnt5k/SAJ6s2Ea0xUq7i4EHS
	GdDQY83ggDP5olZ84QvEi3Tb+DBIBIl9lDrV+LSg3xwk3ekCy0nf2Ldedq4HDDqX5AWQN6
	VKYXHZTr362aj3QpGWd16ePXZqfzGg0CzKEbdiiB5+2ZmQR7UCGafHDXsNGjKg==
From: thomas.perrot@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: thomas.petazzoni@bootlin.com,
	Thomas Perrot <thomas.perrot@bootlin.com>
Subject: [bitbake-devel][PATCH] fetch2/crate: guard against empty version list
Date: Thu,  7 May 2026 16:36:41 +0200
Message-ID: <20260507143641.973592-1-thomas.perrot@bootlin.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 07 May 2026 14:37:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19468

From: Thomas Perrot <thomas.perrot@bootlin.com>

Both latest_versionstring() and latest_versionstring_from_index() would
raise IndexError on versions[-1] if the fetched index returns no usable
versions.
Return ("", "") in that case, consistent with what callers expect when
no upstream version can be determined.

Signed-off-by: Thomas Perrot <thomas.perrot@bootlin.com>
---
 lib/bb/fetch2/crate.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/crate.py b/lib/bb/fetch2/crate.py
index d84bae0bcd1e..eb1fd5719e8c 100644
--- a/lib/bb/fetch2/crate.py
+++ b/lib/bb/fetch2/crate.py
@@ -164,7 +164,7 @@ class Crate(Wget):
         versions =3D [(0, i["num"], "") for i in json_data["versions"]]
         versions =3D sorted(versions, key=3Dcmp_to_key(bb.utils.vercmp))
=20
-        return (versions[-1][1], "")
+        return (versions[-1][1], "") if versions else ("", "")
=20
     def latest_versionstring_from_index(self, ud, d):
         """
@@ -182,4 +182,4 @@ class Crate(Wget):
                 versions.append((0, data["vers"], ""))
=20
         versions =3D sorted(versions, key=3Dcmp_to_key(bb.utils.vercmp))
-        return (versions[-1][1], "")
+        return (versions[-1][1], "") if versions else ("", "")
--=20
2.54.0


