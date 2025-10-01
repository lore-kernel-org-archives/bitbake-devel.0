Return-Path: <paulg@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B34CAC5BB
	for <webhook@archiver.kernel.org>; Wed,  1 Oct 2025 16:44:16 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.web11.1914.1759337051555303866
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 01 Oct 2025 09:44:11 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@kernel.org header.s=k20201202 header.b=DbpId4lz;
 spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: paulg@kernel.org)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 9D49343713;
	Wed,  1 Oct 2025 16:44:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34958C4CEF1;
	Wed,  1 Oct 2025 16:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759337050;
	bh=YRRnFyLQqPy9pP/I0Ipl8EGHsG1uTq69z1KxkfTknDA=;
	h=From:To:Cc:Subject:Date:From;
	b=DbpId4lzq+qiRqTtTfCYKr1Hh6yJW5B/a0cw8sjlnxTEeeblcuK2FboGXfWYbSAh/
	 Y//JmByDycf3PrpcJ75LHgju38TB9sspzWlLDOqbJRDM+X2iSq1e0xADLgbxLG6KCz
	 Wejzv2VXeyhErp543IP7B8BKALB3CmRLik23qwmc8Bbsoiy+Vf33sngKUuHixAVZDs
	 D8A6Db1q9nxDvgB8OUR35AEU2OlCGSIKAHXwdC/jOsD3eROGWqCBvPXFIRtsWx9tQ4
	 WCxLstTVcLTeRVpg1npKgDzQ56V9niZmGsKQu6bHRIjmEiVd99HOy0wnlMaQwuG5IC
	 UJfqdObhAyBtg==
From: paulg@kernel.org
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH] bitbake-setup: clarify that default answer to prompts is no
Date: Wed,  1 Oct 2025 12:44:08 -0400
Message-Id: <20251001164409.805431-1-paulg@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 01 Oct 2025 16:44:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18112

From: Paul Gortmaker <paulg@kernel.org>

It is common practice to put the default choice in upper case for
yes/no interactive prompts, so that when people just hit enter, they
know what they are getting.  An example that linux users are probably
familiar with is "sensors-detect" from the "lm-sensors" package.

Unify all the prompts to be the same and indicate that the default
answer from hitting enter is a no with an upper case N.  No functional
changes.

Signed-off-by: Paul Gortmaker <paulg@kernel.org>
---
 bin/bitbake-setup | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 1fbb6549..0655ed6f 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -403,7 +403,7 @@ def init_config(settings, args, d):
=20
     print("Initializing a build in\n    {}".format(builddir))
     if not args.non_interactive:
-        y_or_n =3D input('Continue? y/n: ')
+        y_or_n =3D input('Continue? (y/N): ')
         if y_or_n !=3D 'y':
             exit()
         print()
@@ -608,7 +608,7 @@ def write_settings(top_dir, force_replace, non_intera=
ctive=3DTrue):
         print('A new settings file will be created in\n    {}\n'.format(=
settings_path))
         print('A common site.conf file will be created, please edit or r=
eplace before running builds\n    {}\n'.format(siteconfpath))
         if not non_interactive:
-            y_or_n =3D input('Bitbake-setup will be configured with the =
above settings in {}, y/n: '.format(top_dir))
+            y_or_n =3D input('Bitbake-setup will be configured with the =
above settings in {}, (y/N): '.format(top_dir))
             if y_or_n !=3D 'y':
                 print("\nYou can run 'bitbake-setup install-settings' to=
 edit them before setting up builds")
                 exit()
@@ -654,7 +654,7 @@ def write_global_settings(settings_path, force_replac=
e, non_interactive=3DTrue):
         print('Top directory prefix (where all top level directories are=
 created) set to\n    {}\n'.format(settings['default']['top-dir-prefix'])=
)
         print('Top directory name (this is added to the top directory pr=
efix to form a top directory where builds are set up) set to\n    {}\n'.f=
ormat(settings['default']['top-dir-name']))
         if not non_interactive:
-            y_or_n =3D input('Write out the global settings as specified=
 above (y/n)? ')
+            y_or_n =3D input('Write out the global settings as specified=
 above (y/N)? ')
             if y_or_n !=3D 'y':
                 print("\nYou can run 'bitbake-setup install-global-setti=
ngs' to edit them before setting up builds")
                 exit()
--=20
2.17.1


