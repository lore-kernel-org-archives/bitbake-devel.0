Return-Path: <simone.p.weiss@posteo.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B8DC4345F
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 20:10:32 +0000 (UTC)
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
 by mx.groups.io with SMTP id smtpd.web10.3563.1713557431737801876
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 19 Apr 2024 13:10:32 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@posteo.com header.s=2017 header.b=EkloSSbx;
 spf=pass (domain: posteo.com, ip: 185.67.36.66, mailfrom: simone.p.weiss@posteo.com)
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id B9101240101
	for <bitbake-devel@lists.openembedded.org>; Fri, 19 Apr 2024 22:10:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.com; s=2017;
	t=1713557429; bh=DXlcmGgZ4EbZ06ZBG+2EVfgEg8PimZI03MvpLWp0JFE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:From;
	b=EkloSSbxdatMMmOWa2Pt05tU1//ACvqNHr8G1M2f446B1kQOi/pBbr/3TnlmoRZrR
	 6UAiko9yFlARwCXBhJTm4rrIYiLEZN4ZgazQIJhFObiaZkFmbOePMPD/DwfCL9TEMT
	 QCLwgzH2XHzxWAyLbPSBm18vH++7oDWmioAuLJLNVYQNhR6uyc5A60tdnMQO/ke9Pv
	 BNRFA8rspQn6u2t4O2KMocCkWGlR9aIQjSCw2XJbL8LA+K0+Md2yKzweSkMUEK0ydt
	 ni7bk/rkN/VqcklldGMXZhgQpcnyG2wcle29L7OvZ9d9Mwajehah4vsFoJL8rE3dxK
	 X3j3wbwPHIaZA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4VLm3S6pD1z6tmv;
	Fri, 19 Apr 2024 22:10:28 +0200 (CEST)
From: simone.p.weiss@posteo.com
To: bitbake-devel@lists.openembedded.org
Cc: =?UTF-8?q?Simone=20Wei=C3=9F?= <simone.p.weiss@posteo.com>
Subject: [PATCH v4] bitbake-layers: adapt force option to not use tinfoil
Date: Fri, 19 Apr 2024 20:08:55 +0000
Message-Id: <20240419200854.10611-1-simone.p.weiss@posteo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 19 Apr 2024 20:10:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16115

From: Simone Wei=C3=9F <simone.p.weiss@posteo.com>

Fixes [YOCTO #15417]

When a layer adds a new dependency after it was added to a conf, it can n=
ot be
removed w/o this dependency in the setup. Even the dependent layer can no=
t be
added, as the tinfoil setup will fail.
Adapt --force to not perform the tinfoil at all, the use will be at own r=
isk,
i.e. the added layers might not parse properly afterwards.
This is not merged into the force option with -F as it even changes the l=
oading of
plugins from other layers and is hence even more invasive as force. Inste=
ad
force can now be speciefied multiple times and is counted.

Signed-off-by: Simone Wei=C3=9F <simone.p.weiss@posteo.com>
---
v4: Do not add a new option to skip the tinfoil setup and allow mutiple f=
orce
levels instead.

 bin/bitbake-layers     | 14 +++++++++-----
 lib/bblayers/action.py |  4 +++-
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/bin/bitbake-layers b/bin/bitbake-layers
index d4b1d1aa..aebb5100 100755
--- a/bin/bitbake-layers
+++ b/bin/bitbake-layers
@@ -33,7 +33,7 @@ def main():
         add_help=3DFalse)
     parser.add_argument('-d', '--debug', help=3D'Enable debug output', a=
ction=3D'store_true')
     parser.add_argument('-q', '--quiet', help=3D'Print only errors', act=
ion=3D'store_true')
-    parser.add_argument('-F', '--force', help=3D'Force add without recip=
e parse verification', action=3D'store_true')
+    parser.add_argument('-F', '--force', help=3D'Forced execution: can b=
e specified multiple times. -F will force add without recipe parse verifi=
cation and -FF will additionally force the run withput layer parsing.', a=
ction=3D'count', default=3D0)
     parser.add_argument('--color', choices=3D['auto', 'always', 'never']=
, default=3D'auto', help=3D'Colorize output (where %(metavar)s is %(choic=
es)s)', metavar=3D'COLOR')
=20
     global_args, unparsed_args =3D parser.parse_known_args()
@@ -59,16 +59,20 @@ def main():
     plugins =3D []
     tinfoil =3D bb.tinfoil.Tinfoil(tracking=3DTrue)
     tinfoil.logger.setLevel(logger.getEffectiveLevel())
-    try:
+    if global_args.force > 1:
+        bbpaths =3D []
+    else:
         tinfoil.prepare(True)
-        for path in ([topdir] +
-                    tinfoil.config_data.getVar('BBPATH').split(':')):
+        bbpaths =3D tinfoil.config_data.getVar('BBPATH').split(':')
+   =20
+    try:=20
+        for path in ([topdir] + bbpaths):
             pluginpath =3D os.path.join(path, 'lib', 'bblayers')
             bb.utils.load_plugins(logger, plugins, pluginpath)
=20
         registered =3D False
         for plugin in plugins:
-            if hasattr(plugin, 'tinfoil_init'):
+            if hasattr(plugin, 'tinfoil_init') and global_args.force <=3D=
 1:
                 plugin.tinfoil_init(tinfoil)
             if hasattr(plugin, 'register_commands'):
                 registered =3D True
diff --git a/lib/bblayers/action.py b/lib/bblayers/action.py
index a8f26993..a14f1994 100644
--- a/lib/bblayers/action.py
+++ b/lib/bblayers/action.py
@@ -50,8 +50,8 @@ class ActionPlugin(LayerPlugin):
=20
         try:
             notadded, _ =3D bb.utils.edit_bblayers_conf(bblayers_conf, l=
ayerdirs, None)
-            self.tinfoil.modified_files()
             if not (args.force or notadded):
+                self.tinfoil.modified_files()
                 try:
                     self.tinfoil.run_command('parseConfiguration')
                 except (bb.tinfoil.TinfoilUIException, bb.BBHandledExcep=
tion):
@@ -83,6 +83,8 @@ class ActionPlugin(LayerPlugin):
                 layerdir =3D os.path.abspath(item)
             layerdirs.append(layerdir)
         (_, notremoved) =3D bb.utils.edit_bblayers_conf(bblayers_conf, N=
one, layerdirs)
+        if args.force > 1:
+            return 0
         self.tinfoil.modified_files()
         if notremoved:
             for item in notremoved:
--=20
2.39.2


