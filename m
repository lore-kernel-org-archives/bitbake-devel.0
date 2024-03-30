Return-Path: <simone.p.weiss@posteo.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D1CCD1288
	for <webhook@archiver.kernel.org>; Sat, 30 Mar 2024 16:47:19 +0000 (UTC)
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
 by mx.groups.io with SMTP id smtpd.web11.1160.1711817238507875535
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 30 Mar 2024 09:47:19 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@posteo.com header.s=2017 header.b=LKpJpinm;
 spf=pass (domain: posteo.com, ip: 185.67.36.66, mailfrom: simone.p.weiss@posteo.com)
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 58CCC240103
	for <bitbake-devel@lists.openembedded.org>; Sat, 30 Mar 2024 17:47:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.com; s=2017;
	t=1711817236; bh=hndWQS9sAVvOqKlhSwX+b+YYUA6jP3jI/w7oDYIdqLI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:From;
	b=LKpJpinmFNzbOs3KK2zBCxbUXKjyLvqwVye8jqMq+1dd+mEwhy1U2RfuJJ8SsqrE5
	 gmXGcXHpB4mvp7vxeI/kTkhBapwCv/gUKPqM+aFi+KWP8m5KHU8SJnqYqrPfbbQl5l
	 xQdMba9poUBF+OtVXxbqwx0DaLB9ErZYTTO+1hRyr7hdNdXUt9R2QdL2jX2I0+kYnJ
	 87FQOtyhdBsvEySkxj+9qZ8nVLptQFXtBjH+vee/UQqObYCjFraNPCNiXceFUfj89V
	 U1ffAWECczABFoDmYkgh0ETk7sp0FIxfPyRT7IK7JoQ80hzmuASa+ZLdVZaXlIgLLJ
	 GYf4bQbgFTJIw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4V6NVC4CSfz9rxK;
	Sat, 30 Mar 2024 17:47:15 +0100 (CET)
From: simone.p.weiss@posteo.com
To: bitbake-devel@lists.openembedded.org
Cc: =?UTF-8?q?Simone=20Wei=C3=9F?= <simone.p.weiss@posteo.com>
Subject: [PATCH] bitbake-layers: add/remove option to not use tinfoil
Date: Sat, 30 Mar 2024 16:46:40 +0000
Message-Id: <20240330164640.7270-1-simone.p.weiss@posteo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 30 Mar 2024 16:47:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16038

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
This is not merged into the force options as it even changes the loading =
of
plugins from other layers and is hence even more invasive as force.

Signed-off-by: Simone Wei=C3=9F <simone.p.weiss@posteo.com>
---
 bin/bitbake-layers     | 13 +++++++++----
 lib/bblayers/action.py |  6 ++++--
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/bin/bitbake-layers b/bin/bitbake-layers
index d4b1d1aa..f5002861 100755
--- a/bin/bitbake-layers
+++ b/bin/bitbake-layers
@@ -34,6 +34,7 @@ def main():
     parser.add_argument('-d', '--debug', help=3D'Enable debug output', a=
ction=3D'store_true')
     parser.add_argument('-q', '--quiet', help=3D'Print only errors', act=
ion=3D'store_true')
     parser.add_argument('-F', '--force', help=3D'Force add without recip=
e parse verification', action=3D'store_true')
+    parser.add_argument('-S', '--skip_parse_tests', help=3D'Force run wi=
thout parsing the layers, this might cause later failures.', action=3D'st=
ore_true')
     parser.add_argument('--color', choices=3D['auto', 'always', 'never']=
, default=3D'auto', help=3D'Colorize output (where %(metavar)s is %(choic=
es)s)', metavar=3D'COLOR')
=20
     global_args, unparsed_args =3D parser.parse_known_args()
@@ -59,16 +60,20 @@ def main():
     plugins =3D []
     tinfoil =3D bb.tinfoil.Tinfoil(tracking=3DTrue)
     tinfoil.logger.setLevel(logger.getEffectiveLevel())
-    try:
+    if global_args.skip_parse_tests:
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
+            if hasattr(plugin, 'tinfoil_init') and not global_args.skip_=
parse_tests:
                 plugin.tinfoil_init(tinfoil)
             if hasattr(plugin, 'register_commands'):
                 registered =3D True
diff --git a/lib/bblayers/action.py b/lib/bblayers/action.py
index a8f26993..5aecc452 100644
--- a/lib/bblayers/action.py
+++ b/lib/bblayers/action.py
@@ -50,8 +50,8 @@ class ActionPlugin(LayerPlugin):
=20
         try:
             notadded, _ =3D bb.utils.edit_bblayers_conf(bblayers_conf, l=
ayerdirs, None)
-            self.tinfoil.modified_files()
-            if not (args.force or notadded):
+            if not (args.force or notadded or args.skip_parse_tests):
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
+        if args.skip_parse_tests:
+            return 0
         self.tinfoil.modified_files()
         if notremoved:
             for item in notremoved:
--=20
2.39.2


