Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mx.groups.io with SMTP id smtpd.web10.18800.1610893513516519014
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 17 Jan 2021 06:25:13 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@linux.microsoft.com header.s=default header.b=YNNq66fw;
 spf=pass (domain: linux.microsoft.com, ip: 13.77.154.182, mailfrom: anbelski@linux.microsoft.com)
Received: from dom0.fritz.box (unknown [87.123.119.238])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2C5E520B7192;
	Sun, 17 Jan 2021 06:25:09 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2C5E520B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1610893512;
	bh=vj87AgXkd2OE9xqGVrRiu4VEcZR0Id/KPHXR2GbSuTA=;
	h=From:To:Cc:Subject:Date:From;
	b=YNNq66fws0Ku5Uot6EcZhzhajDCAy7mXo+OC52KiRI2HkXxLTCe2h/XLgUYEcISst
	 VGFpVoFKTJon4JNWm6iifhDNk1ChHA7KwOWkXWXneMSEwt2dlgGG53hFm/rdSp8blk
	 pM+c1jnkNQYBmCmXHSfkf6x1ffY1Ea4HNRf/l5fQ=
From: "Anatol Belski" <anbelski@linux.microsoft.com>
To: bitbake-devel@lists.openembedded.org
Cc: Sinan Kaya <okaya@kernel.org>,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Paul Barker <pbarker@konsulko.com>
Subject: [bitbake-devel][PATCH v2] toaster: Support vhd/vhdx image suffix
Date: Sun, 17 Jan 2021 15:24:52 +0100
Message-Id: <20210117142452.21238-1-anbelski@linux.microsoft.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Sinan Kaya <okaya@kernel.org>

Signed-off-by: Sinan Kaya <okaya@kernel.org>
Signed-off-by: Anatol Belski <anbelski@linux.microsoft.com>
---
 lib/toaster/orm/models.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 7f7e922a..49dc7dae 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -583,7 +583,7 @@ class Build(models.Model):
         note that this is the actual list of extensions stored on Target=
 objects
         for this build, and not the value of IMAGE_FSTYPES.
=20
-        Returns comma-separated string, e.g. "vmdk, ext4"
+        Returns comma-separated string, e.g. "vmdk, vhd, vhdx, ext4"
         """
         extensions =3D []
=20
@@ -970,7 +970,7 @@ class Target_Image_File(models.Model):
         'ext3', 'ext3.gz', 'ext4', 'ext4.gz', 'f2fs', 'hddimg', 'iso', '=
jffs2',
         'jffs2.sum', 'multiubi', 'squashfs', 'squashfs-lz4', 'squashfs-l=
zo',
         'squashfs-xz', 'tar', 'tar.bz2', 'tar.gz', 'tar.lz4', 'tar.xz', =
'ubi',
-        'ubifs', 'wic', 'wic.bz2', 'wic.gz', 'wic.lzma'
+        'ubifs', "vhd", 'vhdx', 'wic', 'wic.bz2', 'wic.gz', 'wic.lzma'
     }
=20
     target =3D models.ForeignKey(Target, on_delete=3Dmodels.CASCADE)
--=20
2.29.2

