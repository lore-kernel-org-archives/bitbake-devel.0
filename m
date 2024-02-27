Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903C0C5478C
	for <webhook@archiver.kernel.org>; Tue, 27 Feb 2024 18:03:47 +0000 (UTC)
Received: from letterbox.kde.org (letterbox.kde.org [46.43.1.242])
 by mx.groups.io with SMTP id smtpd.web10.455.1709055349095239893
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 27 Feb 2024 09:35:49 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@kde.org header.s=users header.b=BqPq/8uU;
 spf=pass (domain: kde.org, ip: 46.43.1.242, mailfrom: cordlandwehr@kde.org)
Received: from behemoth.fritz.box (p200300e27f1e240062e132e88e9c8201.dip0.t-ipconnect.de [IPv6:2003:e2:7f1e:2400:62e1:32e8:8e9c:8201])
	(Authenticated sender: cordlandwehr)
	by letterbox.kde.org (Postfix) with ESMTPSA id 1B30C33EAA2;
	Tue, 27 Feb 2024 17:35:46 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kde.org; s=users;
	t=1709055347; bh=6OMPvcO7Fw1ZgIzAG7Pxq2zWsiB0qIKGsJloZ3F2YBk=;
	h=From:To:Cc:Subject:Date:From;
	b=BqPq/8uU6GVKWnBdryjhXALzvVtVHgBsalcW7Up/gQvLEgzndimKJzAaxE+FmloT0
	 dXXeZAWykZ/DwFf2ZXr8xEoDwnPwMaxQdDl8Jnp6mH0c0LTluz3VMLSn5/2orrZaX2
	 FCcY+0gboV8BORblfK9eq89ZvzkYBPMKHcFrhABaMjevo+mrJmIXwuLwVG7vJ+obx2
	 x9c75W36Bvedh2HYeSXYAn1V9tYrESTUNS4wIKUHKl0LMGZbMc1EXvDUQAzQCwPVN9
	 xEM91tUdxU8elFnVWJIPPNa6x6QmJ4nG9GbmYN9DlzvPf8NJcSPrh9ieeZjt86qavN
	 p3UE5ODQg/chg==
From: "Andreas Cord-Landwehr" <cordlandwehr@kde.org>
To: bitbake-devel@lists.openembedded.org
Cc: Andreas Cord-Landwehr <cordlandwehr@kde.org>
Subject: [PATCH] fetch2/gitsm.py: handle spaces in git repository paths
Date: Tue, 27 Feb 2024 18:35:27 +0100
Message-Id: <20240227173527.726401-1-cordlandwehr@kde.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 27 Feb 2024 18:03:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15965

Handle encoding of spaces for the obscure but real-world scenario of
having a git repository with submodules, where the urls to submodules
contain spaces, eg. https://example.com/foo/repo%20with%20space.git

Git submodules are referenced with single escaping, yet the fetcher
requires double-escaping of spaces.

Signed-off-by: Andreas Cord-Landwehr <cordlandwehr@kde.org>
---
 bitbake/lib/bb/fetch2/gitsm.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/bitbake/lib/bb/fetch2/gitsm.py b/bitbake/lib/bb/fetch2/gitsm=
.py
index f7f3af7212..e37be055eb 100644
--- a/bitbake/lib/bb/fetch2/gitsm.py
+++ b/bitbake/lib/bb/fetch2/gitsm.py
@@ -23,6 +23,7 @@ import copy
 import shutil
 import tempfile
 from   bb.fetch2.git import Git
+from   bb.fetch2 import URI
 from   bb.fetch2 import runfetchcmd
 from   bb.fetch2 import logger
 from   bb.fetch2 import Fetch
@@ -93,6 +94,11 @@ class GitSM(Git):
                     newud.path =3D os.path.normpath(os.path.join(newud.p=
ath, uris[m]))
                     uris[m] =3D Git._get_repo_url(self, newud)
=20
+                # Double-encode before handing over to git to handle spa=
ces in URLs
+                double_encoded_uri =3D URI(uris[m])
+                double_encoded_uri.path =3D double_encoded_uri.path_quot=
ed
+                uris[m] =3D str(double_encoded_uri)
+
         for module in submodules:
             # Translate the module url into a SRC_URI
=20
--=20
2.40.1


