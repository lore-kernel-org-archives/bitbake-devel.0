Return-Path: <thomas.perrot@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA50CCD3439
	for <webhook@archiver.kernel.org>; Thu,  7 May 2026 14:38:02 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13509.1778164676575031714
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 07 May 2026 07:37:56 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bootlin.com header.s=dkim header.b=xT6kEtMh;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: thomas.perrot@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 0F8B01A3562
	for <bitbake-devel@lists.openembedded.org>; Thu,  7 May 2026 14:37:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D971260495
	for <bitbake-devel@lists.openembedded.org>; Thu,  7 May 2026 14:37:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 065D7108194E5;
	Thu,  7 May 2026 16:37:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778164674; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=7DfogcCK7vxH5W1GOA4mLyQTronEtnJRkIj4ZHFvBjM=;
	b=xT6kEtMhKwEftp7iuJEcgi8aP+nVwBaN5V3at/7xL5hlJCH3Oy5twJ+WrVYU4BAFoQVF5M
	aTHopcLNPudq6qDWWz6ZsrJmJHiScyEYLzRVWx1+q1v+ac8U2gIhTvZSWFYg+UTNPUSV4I
	QpCwLQfgf5XXsnY6vBYvVcFYE7GTCi+lMUYzgCz4QOR3dia3JhvjisDE6GiZ2g7aMdS9zv
	DAogSCVv0eVvcTf3YCTjNnleaCLxLINs1PVezAxW/dyKsiM9hhXep1yv1HebYf0w8bwb7g
	9NUtgJ6PF45UzwM81/179D2VIFWPKC4lf5M6Ln0wFBtiyRENEeJ6VIZv63EAhg==
From: thomas.perrot@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: thomas.petazzoni@bootlin.com,
	Thomas Perrot <thomas.perrot@bootlin.com>
Subject: [bitbake-devel][PATCH] fetch2/crate: replace instance method monkey-patching with URL dispatch
Date: Thu,  7 May 2026 16:37:44 +0200
Message-ID: <20260507143744.974630-1-thomas.perrot@bootlin.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 07 May 2026 14:38:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19470

From: Thomas Perrot <thomas.perrot@bootlin.com>

Instead of overwriting self.latest_versionstring at init time to swap
in a different implementation, have latest_versionstring() inspect
ud.versionsurl and dispatch to the appropriate private helper.

This avoids surprising instance-level mutation and makes the branching
logic explicit and readable.

Signed-off-by: Thomas Perrot <thomas.perrot@bootlin.com>
---
 lib/bb/fetch2/crate.py | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/lib/bb/fetch2/crate.py b/lib/bb/fetch2/crate.py
index b46d4f1a9801..bb12f4e9b7c2 100644
--- a/lib/bb/fetch2/crate.py
+++ b/lib/bb/fetch2/crate.py
@@ -81,7 +81,6 @@ class Crate(Wget):
         if host =3D=3D 'crates.io':
             ud.url =3D "https://static.crates.io/crates/%s/%s/download" =
% (name, version)
             ud.versionsurl =3D 'https://index.crates.io/' + self._genera=
te_index_path(name)
-            self.latest_versionstring =3D self.latest_versionstring_from=
_index
         else:
             ud.url =3D "https://%s/%s/%s/download" % (host, name, versio=
n)
             ud.versionsurl =3D "https://%s/%s/versions" % (host, name)
@@ -158,7 +157,16 @@ class Crate(Wget):
=20
     def latest_versionstring(self, ud, d):
         """
-        Return the latest version available when versionsurl is the [nam=
e]/versions URL.
+        Return the latest upstream version, dispatching to the appropria=
te
+        parser based on the versionsurl format.
+        """
+        if ud.versionsurl.startswith('https://index.crates.io/'):
+            return self._latest_versionstring_from_index(ud, d)
+        return self._latest_versionstring_from_api(ud, d)
+
+    def _latest_versionstring_from_api(self, ud, d):
+        """
+        Parse the latest version from a [name]/versions JSON API respons=
e.
         """
         json_data =3D json.loads(self._fetch_index(ud.versionsurl, ud, d=
))
         versions =3D [(0, i["num"], "") for i in json_data["versions"]]
@@ -166,10 +174,9 @@ class Crate(Wget):
=20
         return (versions[-1][1], "") if versions else ("", "")
=20
-    def latest_versionstring_from_index(self, ud, d):
+    def _latest_versionstring_from_index(self, ud, d):
         """
-        Return the latest version available when versionsurl is a Cargo =
index
-        file.
+        Parse the latest version from a Cargo sparse index file (NDJSON)=
.
         https://doc.rust-lang.org/cargo/reference/registry-index.html#in=
dex-files
         """
         versions =3D []
--=20
2.54.0


