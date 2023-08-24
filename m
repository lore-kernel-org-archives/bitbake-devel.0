Return-Path: <samantha.jalabert@syslinbit.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53012C6FA8F
	for <webhook@archiver.kernel.org>; Thu, 24 Aug 2023 08:11:44 +0000 (UTC)
Received: from mail.yetanothername.org (mail.yetanothername.org [141.94.99.231])
 by mx.groups.io with SMTP id smtpd.web10.6283.1692864695062117868
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 24 Aug 2023 01:11:35 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: mail.yetanothername.org, ip: 141.94.99.231, mailfrom: ubuntu@mail.yetanothername.org)
Received: by mail.yetanothername.org (Postfix, from userid 1000)
	id AB1D4A01424; Thu, 24 Aug 2023 08:11:20 +0000 (UTC)
From: Samantha Jalabert <samantha.jalabert@syslinbit.com>
To: bitbake-devel@lists.openembedded.org
Cc: Samantha Jalabert <samantha.jalabert@syslinbit.com>
Subject: [PATCH] Fix disk space monitoring on cephfs
Date: Thu, 24 Aug 2023 08:11:10 +0000
Message-Id: <20230824081110.2851830-1-samantha.jalabert@syslinbit.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 24 Aug 2023 08:11:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14970

Error occured while running bitbake on cephfs:

WARNING: The free inode of path is running low (-0.001K left)
ERROR: Immediately halt since the disk space monitor action is "HALT"!

Signed-off-by: Samantha Jalabert <samantha.jalabert@syslinbit.com>
---
 lib/bb/monitordisk.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/bb/monitordisk.py b/lib/bb/monitordisk.py
index a1b91000..f9282103 100644
--- a/lib/bb/monitordisk.py
+++ b/lib/bb/monitordisk.py
@@ -234,9 +234,10 @@ class diskMonitor:
                 freeInode =3D st.f_favail
=20
                 if minInode and freeInode < minInode:
-                    # Some filesystems use dynamic inodes so can't run o=
ut
-                    # (e.g. btrfs). This is reported by the inode count =
being 0.
-                    if st.f_files =3D=3D 0:
+                    # Some filesystems use dynamic inodes so can't run o=
ut.
+                    # This is reported by the inode count being 0 (btrfs=
) or the free
+                    # inode count being -1 (cephfs).
+                    if st.f_files =3D=3D 0 or st.f_favail =3D=3D -1:
                         self.devDict[k][2] =3D None
                         continue
                     # Always show warning, the self.checked would always=
 be False if the action is WARN
--=20
2.34.1


