Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A1BC05027
	for <webhook@archiver.kernel.org>; Tue, 14 Feb 2023 16:07:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web11.11051.1676390874848625336
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 14 Feb 2023 08:07:54 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 181671042;
	Tue, 14 Feb 2023 08:08:37 -0800 (PST)
Received: from oss-tx204.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 00AC03F663;
	Tue, 14 Feb 2023 08:07:53 -0800 (PST)
From: Ross Burton <ross.burton@arm.com>
To: bitbake-devel@lists.openembedded.org
Cc: nd@arm.com
Subject: [PATCH] fetch2/wget: clean up netrc usage
Date: Tue, 14 Feb 2023 16:07:51 +0000
Message-Id: <20230214160751.2391568-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 14 Feb 2023 16:07:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14419

Assigning a return value which is potentially None to a tuple and
catching TypeError is pretty ugly.  Rewrite the code to explicitly check
the value for clarity.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 bitbake/lib/bb/fetch2/wget.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.p=
y
index 696e9180303..6d365729e0c 100644
--- a/bitbake/lib/bb/fetch2/wget.py
+++ b/bitbake/lib/bb/fetch2/wget.py
@@ -361,10 +361,11 @@ class Wget(FetchMethod):
=20
                 try:
                     import netrc
-                    n =3D netrc.netrc()
-                    login, unused, password =3D n.authenticators(urllib.=
parse.urlparse(uri).hostname)
-                    add_basic_auth("%s:%s" % (login, password), r)
-                except (TypeError, ImportError, IOError, netrc.NetrcPars=
eError):
+                    auth_data =3D netrc.netrc().authenticators(urllib.pa=
rse.urlparse(uri).hostname)
+                    if auth_data:
+                        login, _, password =3D auth_data
+                        add_basic_auth("%s:%s" % (login, password), r)
+                except (FileNotFoundError, netrc.NetrcParseError):
                     pass
=20
                 with opener.open(r, timeout=3D30) as response:
--=20
2.34.1


