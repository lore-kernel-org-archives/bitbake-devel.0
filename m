Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 845F3EDE9A8
	for <webhook@archiver.kernel.org>; Tue, 10 Sep 2024 16:58:17 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web10.1387.1725987487903310115
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 Sep 2024 09:58:07 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B956D113E
	for <bitbake-devel@lists.openembedded.org>; Tue, 10 Sep 2024 09:58:36 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-04.oss.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3CA1F3F73B
	for <bitbake-devel@lists.openembedded.org>; Tue, 10 Sep 2024 09:58:07 -0700 (PDT)
From: Ross Burton <ross.burton@arm.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] fetch2/gitsm: use configparser to parse .gitmodules
Date: Tue, 10 Sep 2024 17:58:04 +0100
Message-Id: <20240910165804.2924480-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 10 Sep 2024 16:58:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16552

.gitmodules is basically ini-style, so use configparser instead of manual=
ly
parsing by hand.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 bitbake/lib/bb/fetch2/gitsm.py | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/gitsm.py b/bitbake/lib/bb/fetch2/gitsm=
.py
index f7f3af72125..f193ae3c9ba 100644
--- a/bitbake/lib/bb/fetch2/gitsm.py
+++ b/bitbake/lib/bb/fetch2/gitsm.py
@@ -47,18 +47,20 @@ class GitSM(Git):
         subrevision =3D {}
=20
         def parse_gitmodules(gitmodules):
+            """
+            Parse .gitmodules and return a dictionary of submodule paths=
 to dictionaries with path and url members.
+            """
+            import configparser
+            cp =3D configparser.ConfigParser()
+            cp.read_string(gitmodules)
+
             modules =3D {}
-            module =3D ""
-            for line in gitmodules.splitlines():
-                if line.startswith('[submodule'):
-                    module =3D line.split('"')[1]
-                    modules[module] =3D {}
-                elif module and line.strip().startswith('path'):
-                    path =3D line.split('=3D')[1].strip()
-                    modules[module]['path'] =3D path
-                elif module and line.strip().startswith('url'):
-                    url =3D line.split('=3D')[1].strip()
-                    modules[module]['url'] =3D url
+            for section in [s for s in cp.sections() if s.startswith("su=
bmodule ")]:
+                module =3D section.split('"')[1]
+                modules[module] =3D {
+                    'path': cp.get(section, 'path'),
+                    'url': cp.get(section, 'url')
+                }
             return modules
=20
         # Collect the defined submodules, and their attributes
--=20
2.34.1


