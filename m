Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5631C4828D
	for <webhook@archiver.kernel.org>; Wed,  7 Feb 2024 17:21:28 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web10.3450.1707326486500370252
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 07 Feb 2024 09:21:26 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9931A1FB
	for <bitbake-devel@lists.openembedded.org>; Wed,  7 Feb 2024 09:22:08 -0800 (PST)
Received: from oss-tx204.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C4EE03F762
	for <bitbake-devel@lists.openembedded.org>; Wed,  7 Feb 2024 09:21:25 -0800 (PST)
From: ross.burton@arm.com
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] bitbake-layers: add show-machines command
Date: Wed,  7 Feb 2024 17:21:21 +0000
Message-Id: <20240207172121.4044574-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 07 Feb 2024 17:21:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15833

From: Ross Burton <ross.burton@arm.com>

Add a show-machines command to list all of the available machines in the
currently configured layers.

By default it includes the layer name, but for machine-readable uses
this can be hidden by passing --bare.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 bitbake/lib/bblayers/query.py | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/bitbake/lib/bblayers/query.py b/bitbake/lib/bblayers/query.p=
y
index bfc18a75939..3080763abfd 100644
--- a/bitbake/lib/bblayers/query.py
+++ b/bitbake/lib/bblayers/query.py
@@ -10,6 +10,7 @@ import logging
 import sys
 import os
 import re
+import pathlib
=20
 import bb.utils
=20
@@ -515,6 +516,19 @@ NOTE: .bbappend files can impact the dependencies.
=20
             logger.plain("%s %s %s" % (f, keyword, best_realfn))
=20
+    def do_show_machines(self, args):
+        """List the machines available in the currently configured layer=
s."""
+
+        for layer_dir in self.bblayers:
+            layer_name =3D self.get_layer_name(layer_dir)
+
+            for p in sorted(pathlib.Path(layer_dir).glob("conf/machine/*=
.conf")):
+                if args.bare:
+                    logger.plain("%s" % (p.stem))
+                else:
+                    logger.plain("%s (%s)" % (p.stem, layer_name))
+
+
     def register_commands(self, sp):
         self.add_command(sp, 'show-layers', self.do_show_layers, parsere=
cipes=3DFalse)
=20
@@ -540,3 +554,6 @@ NOTE: .bbappend files can impact the dependencies.
         parser_show_cross_depends =3D self.add_command(sp, 'show-cross-d=
epends', self.do_show_cross_depends)
         parser_show_cross_depends.add_argument('-f', '--filenames', help=
=3D'show full file path', action=3D'store_true')
         parser_show_cross_depends.add_argument('-i', '--ignore', help=3D=
'ignore dependencies on items in the specified layer(s) (split multiple l=
ayer names with commas, no spaces)', metavar=3D'LAYERNAME')
+
+        parser_show_machines =3D self.add_command(sp, "show-machines", s=
elf.do_show_machines)
+        parser_show_machines.add_argument('-b', '--bare', help=3D'output=
 just the machine names, not the source layer', action=3D'store_true')
--=20
2.34.1


