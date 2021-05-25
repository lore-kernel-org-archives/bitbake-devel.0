Received: from lilium.sigma-star.at (lilium.sigma-star.at [109.75.188.150])
 by mx.groups.io with SMTP id smtpd.web12.8108.1621940703526161575
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 May 2021 04:05:04 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=permerror, err=syntax error for token:  (domain: nod.at, ip: 109.75.188.150, mailfrom: richard@nod.at)
Received: from localhost (localhost [127.0.0.1])
	by lilium.sigma-star.at (Postfix) with ESMTP id 26B991817A0D2;
	Tue, 25 May 2021 13:04:57 +0200 (CEST)
Received: from lilium.sigma-star.at ([127.0.0.1])
	by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id jG9f0FLqAvuw; Tue, 25 May 2021 13:04:56 +0200 (CEST)
Received: from lilium.sigma-star.at ([127.0.0.1])
	by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id HXQHXUb7qxbn; Tue, 25 May 2021 13:04:56 +0200 (CEST)
From: "Richard Weinberger" <richard@nod.at>
To: openembedded-core@lists.openembedded.org,
	bitbake-devel@lists.openembedded.org,
	docs@lists.yoctoproject.org
Cc: Richard Weinberger <richard@nod.at>
Subject: [bitbake][PATCH] Add support for erofs image types
Date: Tue, 25 May 2021 13:04:28 +0200
Message-Id: <20210525110429.738-2-richard@nod.at>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210525110429.738-1-richard@nod.at>
References: <20210525110429.738-1-richard@nod.at>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 lib/toaster/orm/models.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 7f7e922adecc..517774baa0b1 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -968,9 +968,10 @@ class Target_Image_File(models.Model):
         'btrfs', 'container', 'cpio', 'cpio.gz', 'cpio.lz4', 'cpio.lzma'=
,
         'cpio.xz', 'cramfs', 'ext2', 'ext2.bz2', 'ext2.gz', 'ext2.lzma',
         'ext3', 'ext3.gz', 'ext4', 'ext4.gz', 'f2fs', 'hddimg', 'iso', '=
jffs2',
-        'jffs2.sum', 'multiubi', 'squashfs', 'squashfs-lz4', 'squashfs-l=
zo',
-        'squashfs-xz', 'tar', 'tar.bz2', 'tar.gz', 'tar.lz4', 'tar.xz', =
'ubi',
-        'ubifs', 'wic', 'wic.bz2', 'wic.gz', 'wic.lzma'
+        'jffs2.sum', 'multiubi', 'erofs', 'erofs-lz4', 'erofs-lz4hc',
+        'squashfs', 'squashfs-lz4', 'squashfs-lzo', 'squashfs-xz', 'tar'=
,
+        'tar.bz2', 'tar.gz', 'tar.lz4', 'tar.xz', 'ubi', 'ubifs', 'wic',
+        'wic.bz2', 'wic.gz', 'wic.lzma'
     }
=20
     target =3D models.ForeignKey(Target, on_delete=3Dmodels.CASCADE)
--=20
2.26.2

