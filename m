Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C11CCFA1E
	for <webhook@archiver.kernel.org>; Tue, 11 Nov 2025 17:17:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.22925.1762881412617365311
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 11 Nov 2025 09:16:52 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82252497
	for <bitbake-devel@lists.openembedded.org>; Tue, 11 Nov 2025 09:16:44 -0800 (PST)
Received: from cesw-amp-gbt-1s-m12830-04.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C96CD3F5A1
	for <bitbake-devel@lists.openembedded.org>; Tue, 11 Nov 2025 09:16:51 -0800 (PST)
From: Ross Burton <ross.burton@arm.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/2] bitbake-setup: fix undefined variable
Date: Tue, 11 Nov 2025 17:16:42 +0000
Message-ID: <20251111171643.3329047-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 11 Nov 2025 17:17:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18328

The symlink variable is never defined, and it appears that it should
have been siteconf_symlink.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 bin/bitbake-setup | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index caec990c29..96c0400152 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -240,8 +240,8 @@ def setup_bitbake_build(bitbake_config, layerdir, set=
updir, thisdir):
     siteconf_symlink =3D os.path.join(bitbake_confdir, "site.conf")
     siteconf =3D os.path.normpath(os.path.join(setupdir, '..', "site.con=
f"))
     if os.path.lexists(siteconf_symlink):
-        os.remove(symlink)
-    os.symlink(os.path.relpath(siteconf, bitbake_confdir) ,siteconf_syml=
ink)
+        os.remove(siteconf_symlink)
+    os.symlink(os.path.relpath(siteconf, bitbake_confdir), siteconf_syml=
ink)
=20
=20
     init_script =3D os.path.join(bitbake_builddir, "init-build-env")
--=20
2.43.0


