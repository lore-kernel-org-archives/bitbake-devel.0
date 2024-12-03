Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90EE4E74AC8
	for <webhook@archiver.kernel.org>; Tue,  3 Dec 2024 20:02:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web10.29407.1733256166083961591
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 03 Dec 2024 12:02:46 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5951143D
	for <bitbake-devel@lists.openembedded.org>; Tue,  3 Dec 2024 12:03:13 -0800 (PST)
Received: from cesw-amp-gbt-1s-m12830-04.oss.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5CBCB3F5A1
	for <bitbake-devel@lists.openembedded.org>; Tue,  3 Dec 2024 12:02:45 -0800 (PST)
From: Ross Burton <ross.burton@arm.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/2] fetch2/wget: URL-escape the path when constructing a URL for checkstatus
Date: Tue,  3 Dec 2024 20:02:42 +0000
Message-Id: <20241203200242.2955858-2-ross.burton@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203200242.2955858-1-ross.burton@arm.com>
References: <20241203200242.2955858-1-ross.burton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 03 Dec 2024 20:02:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16859

ud.path has been unescaped (eg %20 is space) but as we're reconstructing
a URL we should re-escape it. For example, unzip has a SRC_URI
containing "UnZip%206.x%20%28latest%29/UnZip%206.0/unzip60.tar.gz" which
then throws exceptions if the unescaped string " (latest)" is used.

Also, this code uses the extracted ud.host and ud.path variables. These
are unescaped but potentially stale as eg the cargo fetcher subclasses
Wget() and reassigns ud.url on construction.

Simplify the code by reconstructing a URL from ud.url directly instead
of bouncing through intermediate variables that may be wrong or
unescaped.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 bitbake/lib/bb/fetch2/wget.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.p=
y
index fcb71246d9a..198426065b4 100644
--- a/bitbake/lib/bb/fetch2/wget.py
+++ b/bitbake/lib/bb/fetch2/wget.py
@@ -376,8 +376,8 @@ class Wget(FetchMethod):
             opener =3D urllib.request.build_opener(*handlers)
=20
             try:
-                uri_base =3D ud.url.split(";")[0]
-                uri =3D "{}://{}{}".format(urllib.parse.urlparse(uri_bas=
e).scheme, ud.host, ud.path)
+                parts =3D urllib.parse.urlparse(ud.url.split(";")[0])
+                uri =3D "{}://{}{}".format(parts.scheme, parts.netloc, p=
arts.path)
                 r =3D urllib.request.Request(uri)
                 r.get_method =3D lambda: "HEAD"
                 # Some servers (FusionForge, as used on Alioth) require =
that the
--=20
2.34.1


