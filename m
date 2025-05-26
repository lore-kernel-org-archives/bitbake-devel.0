Return-Path: <isaac.true@emlix.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379C4C5AD49
	for <webhook@archiver.kernel.org>; Mon, 26 May 2025 13:57:52 +0000 (UTC)
Received: from mx1.emlix.com (mx1.emlix.com [178.63.209.131])
 by mx.groups.io with SMTP id smtpd.web10.29038.1748267867871585050
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 26 May 2025 06:57:48 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: emlix.com, ip: 178.63.209.131, mailfrom: isaac.true@emlix.com)
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.emlix.com (Postfix) with ESMTPS id CEC795F9D3
	for <bitbake-devel@lists.openembedded.org>; Mon, 26 May 2025 15:57:45 +0200 (CEST)
From: Isaac True <isaac.true@emlix.com>
To: bitbake-devel@lists.openembedded.org
Cc: Isaac True <isaac.true@emlix.com>
Subject: [PATCH] fetch2: add support for .debs containing uncompressed data tarballs
Date: Mon, 26 May 2025 15:57:33 +0200
Message-ID: <20250526135733.1082741-2-isaac.true@emlix.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 26 May 2025 13:57:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17641

Some .deb files contain uncompressed data tarballs which do not have an
additional file extension after `.tar`. Add support for such cases while
preserving the existing behaviour.

Signed-off-by: Isaac True <isaac.true@emlix.com>
---
 lib/bb/fetch2/__init__.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 8f0ed2b9e..06378e96d 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1569,11 +1569,11 @@ class FetchMethod(object):
                 datafile =3D None
                 if output:
                     for line in output.decode().splitlines():
-                        if line.startswith('data.tar.'):
+                        if line.startswith('data.tar.') or line =3D=3D '=
data.tar':
                             datafile =3D line
                             break
                     else:
-                        raise UnpackError("Unable to unpack deb/ipk pack=
age - does not contain data.tar.* file", urldata.url)
+                        raise UnpackError("Unable to unpack deb/ipk pack=
age - does not contain data.tar* file", urldata.url)
                 else:
                     raise UnpackError("Unable to unpack deb/ipk package =
- could not list contents", urldata.url)
                 cmd =3D 'ar x %s %s && %s -p -f %s && rm %s' % (file, da=
tafile, tar_cmd, datafile, datafile)
--=20
2.39.5


