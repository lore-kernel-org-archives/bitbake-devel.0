Return-Path: <shen_jiamin@comp.nus.edu.sg>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F20D8C5B549
	for <webhook@archiver.kernel.org>; Sun,  1 Jun 2025 09:36:01 +0000 (UTC)
Received: from smtpgw-1-2.nogo.comp.nus.edu.sg (smtpgw-1-2.nogo.comp.nus.edu.sg [137.132.84.20])
 by mx.groups.io with SMTP id smtpd.web10.23999.1748770561531714111
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 01 Jun 2025 02:36:01 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: comp.nus.edu.sg, ip: 137.132.84.20, mailfrom: shen_jiamin@comp.nus.edu.sg)
Received: from localhost (localhost [127.0.0.1])
	by smtpgw-1-2.nogo.comp.nus.edu.sg (Postfix) with ESMTP id D03D5160746;
	Sun,  1 Jun 2025 17:35:59 +0800 (+08)
X-Virus-Scanned: Debian amavisd-new at smtpgw-1-2.comp.nus.edu.sg
Received: from smtpgw-1-2.nogo.comp.nus.edu.sg ([127.0.0.1])
	by localhost (smtpgw-1-2.comp.nus.edu.sg [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uGvN_VDpqo1d; Sun,  1 Jun 2025 17:35:59 +0800 (+08)
Received: from smtpauth-2-1.comp.nus.edu.sg (smtpauth-2-1.comp.nus.edu.sg [192.168.21.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtpgw-1-2.nogo.comp.nus.edu.sg (Postfix) with ESMTPS;
	Sun,  1 Jun 2025 17:35:59 +0800 (+08)
Received: from localhost.localdomain (unknown [202.73.41.222])
	(using TLSv1.3 with cipher TLS_CHACHA20_POLY1305_SHA256 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	(Authenticated sender: e0446373)
	by smtpauth-2-1.comp.nus.edu.sg (Postfix) with ESMTPSA id 5743812026A;
	Sun,  1 Jun 2025 17:35:59 +0800 (+08)
From: Shen Jiamin <shen_jiamin@comp.nus.edu.sg>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Cc: Shen Jiamin <shen_jiamin@comp.nus.edu.sg>,
	Shen Jiamin <shen_jiamin@u.nus.edu>
Subject: [PATCH] bitbake-layers: allow adding layers as relative paths
Date: Sun,  1 Jun 2025 17:35:55 +0800
Message-Id: <20250601093555.40432-1-shen_jiamin@comp.nus.edu.sg>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 01 Jun 2025 09:36:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17663

Modify the add-layer command to accept a new --relative (-r) option
that adds specified layer directories as paths relative to TOPDIR
instead of absolute paths.

This change updates the handling of bblayers.conf to store layer
paths in the form ${TOPDIR}/relative/path, improving portability
and flexibility when managing layers.

Signed-off-by: Shen Jiamin <shen_jiamin@comp.nus.edu.sg>
---
 lib/bblayers/action.py | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/lib/bblayers/action.py b/lib/bblayers/action.py
index a14f19948..bd3b6bb04 100644
--- a/lib/bblayers/action.py
+++ b/lib/bblayers/action.py
@@ -38,7 +38,8 @@ class ActionPlugin(LayerPlugin):
                 sys.stderr.write("Specified layer directory %s doesn't c=
ontain a conf/layer.conf file\n" % layerdir)
                 return 1

-        bblayers_conf =3D os.path.join(findTopdir(),'conf', 'bblayers.co=
nf')
+        topdir =3D findTopdir()
+        bblayers_conf =3D os.path.join(topdir, 'conf', 'bblayers.conf')
         if not os.path.exists(bblayers_conf):
             sys.stderr.write("Unable to find bblayers.conf\n")
             return 1
@@ -48,6 +49,12 @@ class ActionPlugin(LayerPlugin):
         backup =3D tempdir + "/bblayers.conf.bak"
         shutil.copy2(bblayers_conf, backup)

+        if args.relative:
+            layerdirs =3D [
+                os.path.join("${TOPDIR}", os.path.relpath(ldir, topdir))
+                for ldir in layerdirs
+            ]
+
         try:
             notadded, _ =3D bb.utils.edit_bblayers_conf(bblayers_conf, l=
ayerdirs, None)
             if not (args.force or notadded):
@@ -268,6 +275,7 @@ build results (as the layer priority order has effect=
ively changed).

     def register_commands(self, sp):
         parser_add_layer =3D self.add_command(sp, 'add-layer', self.do_a=
dd_layer, parserecipes=3DFalse)
+        parser_add_layer.add_argument('-r', '--relative', action=3D'stor=
e_true', help=3D'Add layer directories relative to TOPDIR (default is abs=
olute paths)')
         parser_add_layer.add_argument('layerdir', nargs=3D'+', help=3D'L=
ayer directory/directories to add')

         parser_remove_layer =3D self.add_command(sp, 'remove-layer', sel=
f.do_remove_layer, parserecipes=3DFalse)

