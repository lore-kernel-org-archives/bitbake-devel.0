Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 879E5E7717D
	for <webhook@archiver.kernel.org>; Wed, 11 Dec 2024 12:09:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web10.9260.1733918934667065771
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 11 Dec 2024 04:08:54 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A5261063
	for <bitbake-devel@lists.openembedded.org>; Wed, 11 Dec 2024 04:09:22 -0800 (PST)
Received: from cesw-amp-gbt-1s-m12830-04.oss.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BC7443F5A1
	for <bitbake-devel@lists.openembedded.org>; Wed, 11 Dec 2024 04:08:53 -0800 (PST)
From: Ross Burton <ross.burton@arm.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH v2 3/3] scripts/devtool: use bb.util.listtasks instead of __BBTASKS
Date: Wed, 11 Dec 2024 12:08:47 +0000
Message-ID: <20241211120847.384816-3-ross.burton@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211120847.384816-1-ross.burton@arm.com>
References: <20241211120847.384816-1-ross.burton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 11 Dec 2024 12:09:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16906

Don't access private variables, instead use the new bb.build.listtasks()
function (from bitbake 185c4b)

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 scripts/lib/devtool/build.py    | 2 +-
 scripts/lib/devtool/utilcmds.py | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/lib/devtool/build.py b/scripts/lib/devtool/build.py
index 935ffab46c5..0b2c3d33dc1 100644
--- a/scripts/lib/devtool/build.py
+++ b/scripts/lib/devtool/build.py
@@ -49,7 +49,7 @@ def build(args, config, basepath, workspace):
         rd =3D parse_recipe(config, tinfoil, args.recipename, appends=3D=
True, filter_workspace=3DFalse)
         if not rd:
             return 1
-        deploytask =3D 'do_deploy' in rd.getVar('__BBTASKS')
+        deploytask =3D 'do_deploy' in bb.build.listtasks(rd)
     finally:
         tinfoil.shutdown()
=20
diff --git a/scripts/lib/devtool/utilcmds.py b/scripts/lib/devtool/utilcm=
ds.py
index 964817766b7..bf39f71b118 100644
--- a/scripts/lib/devtool/utilcmds.py
+++ b/scripts/lib/devtool/utilcmds.py
@@ -64,7 +64,7 @@ def configure_help(args, config, basepath, workspace):
         b =3D rd.getVar('B')
         s =3D rd.getVar('S')
         configurescript =3D os.path.join(s, 'configure')
-        confdisabled =3D 'noexec' in rd.getVarFlags('do_configure') or '=
do_configure' not in (rd.getVar('__BBTASKS', False) or [])
+        confdisabled =3D 'noexec' in rd.getVarFlags('do_configure') or '=
do_configure' not in (bb.build.listtasks(rd))
         configureopts =3D oe.utils.squashspaces(rd.getVar('CONFIGUREOPTS=
') or '')
         extra_oeconf =3D oe.utils.squashspaces(rd.getVar('EXTRA_OECONF')=
 or '')
         extra_oecmake =3D oe.utils.squashspaces(rd.getVar('EXTRA_OECMAKE=
') or '')
--=20
2.43.0


