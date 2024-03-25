Return-Path: <simone.p.weiss@posteo.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3058C54E58
	for <webhook@archiver.kernel.org>; Mon, 25 Mar 2024 20:28:11 +0000 (UTC)
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
 by mx.groups.io with SMTP id smtpd.web10.2442.1711398488464196356
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 25 Mar 2024 13:28:09 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@posteo.com header.s=2017 header.b=UbiQZxkv;
 spf=pass (domain: posteo.com, ip: 185.67.36.66, mailfrom: simone.p.weiss@posteo.com)
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 3ABFA240101
	for <bitbake-devel@lists.openembedded.org>; Mon, 25 Mar 2024 21:28:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.com; s=2017;
	t=1711398486; bh=Bc4+rsOFZ2nnNcLBQ0G8TwZCwNzl1AgvY94NvuUBvGM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:From;
	b=UbiQZxkvsVgi6IYV1L1QKXJsbWZpAHXBRFXJkTDOJZr2V5drRWLJDFVFpdQMZFeV/
	 FA3wfJ/CkDa05nNMgPQnbsdbfrxrZ/TeX/oVzg1RC+tK12LnhkCZcv7+gYuI/qSWdb
	 yZ4YT/Gwknx9Mmk0HENCTwKeTIzzBEFYlUASRxo0jpXw7D34t90M7hza2pN6KNWjXz
	 QBJC//RaLj4vhXhSigJ1vjmBu5GgHo1wyAmAAL1feaF0IVVoyNyZtdgN3K7wShBUN9
	 VjfbW9zycnj/sy92J3Mdvb5H/rnuViMIWrIS9txiq+iv/O1jmE8zOiOjvez8N7O5mv
	 AOabGyWDD04Dw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4V3PdK1WnYz9rxM;
	Mon, 25 Mar 2024 21:28:04 +0100 (CET)
From: simone.p.weiss@posteo.com
To: bitbake-devel@lists.openembedded.org
Cc: =?UTF-8?q?Simone=20Wei=C3=9F?= <simone.p.weiss@posteo.com>
Subject: [PATCH] bitbake-layers: add/remove option to not use tinfoil
Date: Mon, 25 Mar 2024 20:27:57 +0000
Message-Id: <20240325202757.7711-1-simone.p.weiss@posteo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 25 Mar 2024 20:28:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16014

From: Simone Wei=C3=9F <simone.p.weiss@posteo.com>

Fixes [YOCTO #15417]

When a layer adds a new dependency after it was added to a conf, it can n=
ot be
removed w/o this dependency in the setup. Even the dependent layer can no=
t be
added, as the tinfoil setup will fail.
Add an option to not perform the tinfoil at all, the use will be at own r=
isk,
i.e. the added layers might not parse properly afterwards.

Signed-off-by: Simone Wei=C3=9F <simone.p.weiss@posteo.com>
---
 bin/bitbake-layers     | 16 +++++++++++-----
 lib/bblayers/action.py |  6 ++++--
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/bin/bitbake-layers b/bin/bitbake-layers
index d4b1d1aa..78c316ff 100755
--- a/bin/bitbake-layers
+++ b/bin/bitbake-layers
@@ -34,6 +34,7 @@ def main():
     parser.add_argument('-d', '--debug', help=3D'Enable debug output', a=
ction=3D'store_true')
     parser.add_argument('-q', '--quiet', help=3D'Print only errors', act=
ion=3D'store_true')
     parser.add_argument('-F', '--force', help=3D'Force add without recip=
e parse verification', action=3D'store_true')
+    parser.add_argument('-T', '--notinfoil', help=3D'Force run without t=
infoil, this might fail.', action=3D'store_true')
     parser.add_argument('--color', choices=3D['auto', 'always', 'never']=
, default=3D'auto', help=3D'Colorize output (where %(metavar)s is %(choic=
es)s)', metavar=3D'COLOR')
=20
     global_args, unparsed_args =3D parser.parse_known_args()
@@ -59,16 +60,21 @@ def main():
     plugins =3D []
     tinfoil =3D bb.tinfoil.Tinfoil(tracking=3DTrue)
     tinfoil.logger.setLevel(logger.getEffectiveLevel())
-    try:
+    if global_args.notinfoil:
+        bbpath_string =3D []
+    else:
         tinfoil.prepare(True)
-        for path in ([topdir] +
-                    tinfoil.config_data.getVar('BBPATH').split(':')):
+        bbpath_string =3D tinfoil.config_data.getVar('BBPATH').split(':'=
)
+        print(bbpath_string)
+   =20
+    try:=20
+        for path in ([topdir] + bbpath_string):
             pluginpath =3D os.path.join(path, 'lib', 'bblayers')
             bb.utils.load_plugins(logger, plugins, pluginpath)
-
         registered =3D False
+
         for plugin in plugins:
-            if hasattr(plugin, 'tinfoil_init'):
+            if hasattr(plugin, 'tinfoil_init') and not global_args.notin=
foil:
                 plugin.tinfoil_init(tinfoil)
             if hasattr(plugin, 'register_commands'):
                 registered =3D True
diff --git a/lib/bblayers/action.py b/lib/bblayers/action.py
index a8f26993..7180ef64 100644
--- a/lib/bblayers/action.py
+++ b/lib/bblayers/action.py
@@ -50,8 +50,8 @@ class ActionPlugin(LayerPlugin):
=20
         try:
             notadded, _ =3D bb.utils.edit_bblayers_conf(bblayers_conf, l=
ayerdirs, None)
-            self.tinfoil.modified_files()
-            if not (args.force or notadded):
+            if not (args.force or notadded or args.notinfoil):
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
+        if args.notinfoil:
+            return 0
         self.tinfoil.modified_files()
         if notremoved:
             for item in notremoved:
--=20
2.39.2


