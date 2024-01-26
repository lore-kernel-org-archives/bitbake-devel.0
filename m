Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D53C47422
	for <webhook@archiver.kernel.org>; Fri, 26 Jan 2024 16:19:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web11.2036.1706285973275304046
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 26 Jan 2024 08:19:33 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21D691FB
	for <bitbake-devel@lists.openembedded.org>; Fri, 26 Jan 2024 08:20:17 -0800 (PST)
Received: from oss-tx204.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5108A3F762
	for <bitbake-devel@lists.openembedded.org>; Fri, 26 Jan 2024 08:19:32 -0800 (PST)
From: ross.burton@arm.com
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] bitbake: Version bump for inherit_defer addition
Date: Fri, 26 Jan 2024 16:19:29 +0000
Message-Id: <20240126161929.2841739-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 26 Jan 2024 16:19:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15799

From: Ross Burton <ross.burton@arm.com>

We've added a new statement, inherit_defer, so bump the version so this
can be checked.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 bitbake/bin/bitbake        | 2 +-
 bitbake/lib/bb/__init__.py | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/bin/bitbake b/bitbake/bin/bitbake
index abf7de26d8d..1055635ffdd 100755
--- a/bitbake/bin/bitbake
+++ b/bitbake/bin/bitbake
@@ -27,7 +27,7 @@ from bb.main import bitbake_main, BitBakeConfigParamete=
rs, BBMainException
=20
 bb.utils.check_system_locale()
=20
-__version__ =3D "2.7.1"
+__version__ =3D "2.7.2"
=20
 if __name__ =3D=3D "__main__":
     if __version__ !=3D bb.__version__:
diff --git a/bitbake/lib/bb/__init__.py b/bitbake/lib/bb/__init__.py
index 019ab1977a9..5e22d347472 100644
--- a/bitbake/lib/bb/__init__.py
+++ b/bitbake/lib/bb/__init__.py
@@ -9,7 +9,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
=20
-__version__ =3D "2.7.1"
+__version__ =3D "2.7.2"
=20
 import sys
 if sys.version_info < (3, 8, 0):
--=20
2.34.1


