Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
	[209.85.128.52])
	by mail.openembedded.org (Postfix) with ESMTP id D03227F9DE
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Nov 2019 20:54:17 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id b11so5234777wmb.5
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Nov 2019 12:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=SFEm1nVdnNWRlXsS0O1kAyUyXhOtFpff1iExCuDYnt4=;
	b=drn5zEFbtuvFyzYacjGunp+Ha3qf3xCdoAKe5/4bvDKWJZSwuyX4NuuB9FTH5A+uuZ
	r/wH+9WFu9A+VDpTR8+d9MA9YC/eZS9QhF7UhsReO/vETafoJyHyt74nryDGBCypCoJx
	i0Ezm1Yk1CdqyNxqxC1kDxWoSGj+p+cfCrxWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=SFEm1nVdnNWRlXsS0O1kAyUyXhOtFpff1iExCuDYnt4=;
	b=qncQetKtckGJ0yrvpHGGq4d2owov5YCiFOElM7h8Wwt9WrQAZvYNUrC/uGMcPN+G/y
	sOo/HC7ed0/iJqtYTPScOLg86A7rrlpII9QVy8pKGryAPaFj7lL+fsOnQ8N0aWozzmUu
	E2Q+MpBrgxdMvtK3d7W3hbohSajtkmsb0xfMHptNxrvjXs78Pl3uYmHkZVlYguC+9tCj
	PtjZGL3miUMYJJGsKSVH5KZzEmSYZAm91q4EtWWRtaNE7V4aiFFwEJt5gic2dOrLGnp9
	cDfySE01t16kjo7/4yrQUzXgRkrXq6vPHraI8iLKOAc4HVHW6u19gmJ46su0NAPIA4AC
	SziA==
X-Gm-Message-State: APjAAAW8fDR8lJLDxR88i7cSAHuh7jykZ8A0/417Pu4z75HkVwtFyRoU
	A4i9Mf/zM4LQ0Hcha0jSt+8rnBpmLc0=
X-Google-Smtp-Source: APXvYqyh8tGLvD57ISiJqKA6t05d0WM54Bvfnt9UY8Xmh2i7SMsP4X0SPmBD2yFr/t8Fy0C2dIbh5w==
X-Received: by 2002:a05:600c:206:: with SMTP id
	6mr13271934wmi.78.1574369658065; 
	Thu, 21 Nov 2019 12:54:18 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	w12sm925982wmi.17.2019.11.21.12.54.16
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Thu, 21 Nov 2019 12:54:17 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 21 Nov 2019 20:54:11 +0000
Message-Id: <20191121205415.25946-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Subject: [PATCH 1/5] opkg: Add upstream fixes for empty packages
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 21 Nov 2019 20:54:18 -0000
Content-Transfer-Encoding: 8bit

An ipk with a zero size data.tar file caused opkg to crash with a
double free abort. Add the upstream fixes for this.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 .../opkg/opkg/open_inner.patch                | 46 ++++++++++++++++
 .../opkg/opkg/opkg_archive.patch              | 54 +++++++++++++++++++
 meta/recipes-devtools/opkg/opkg_0.4.1.bb      |  2 +
 3 files changed, 102 insertions(+)
 create mode 100644 meta/recipes-devtools/opkg/opkg/open_inner.patch
 create mode 100644 meta/recipes-devtools/opkg/opkg/opkg_archive.patch

diff --git a/meta/recipes-devtools/opkg/opkg/open_inner.patch b/meta/recipes-devtools/opkg/opkg/open_inner.patch
new file mode 100644
index 00000000000..278e099e3ac
--- /dev/null
+++ b/meta/recipes-devtools/opkg/opkg/open_inner.patch
@@ -0,0 +1,46 @@
+From alejandro.delcastillo@ni.com Wed Nov 20 22:35:02 2019
+From: Alejandro del Castillo <alejandro.delcastillo@ni.com>
+To: <opkg-devel@googlegroups.com>, <richard.purdie@linuxfoundation.org>
+CC: Alejandro del Castillo <alejandro.delcastillo@ni.com>
+Subject: [opkg][PATCH 2/2] open_inner: add support for empty payloads
+Date: Wed, 20 Nov 2019 16:34:48 -0600
+Message-ID: <20191120223448.26522-3-alejandro.delcastillo@ni.com>
+X-Mailer: git-send-email 2.22.0
+In-Reply-To: <20191120223448.26522-1-alejandro.delcastillo@ni.com>
+References: <20191120223448.26522-1-alejandro.delcastillo@ni.com>
+MIME-Version: 1.0
+Content-Type: text/plain
+Content-Transfer-Encoding: 8bit
+
+Support for empty compressed payloads need to be explicitly enabled on
+libarchive.
+
+Signed-off-by: Alejandro del Castillo <alejandro.delcastillo@ni.com>
+
+Upstream-Status: Backport
+---
+ libopkg/opkg_archive.c | 7 +++++++
+ 1 file changed, 7 insertions(+)
+
+diff --git a/libopkg/opkg_archive.c b/libopkg/opkg_archive.c
+index 0e9ccea..f19cece 100644
+--- a/libopkg/opkg_archive.c
++++ b/libopkg/opkg_archive.c
+@@ -618,6 +618,13 @@ static struct archive *open_inner(struct archive *outer)
+         goto err_cleanup;
+     }
+ 
++    r = archive_read_support_format_empty(inner);
++    if (r != ARCHIVE_OK) {
++        opkg_msg(ERROR, "Empty format not supported: %s\n",
++                 archive_error_string(inner));
++        goto err_cleanup;
++    }
++
+     r = archive_read_open(inner, data, NULL, inner_read, inner_close);
+     if (r != ARCHIVE_OK) {
+         opkg_msg(ERROR, "Failed to open inner archive: %s\n",
+-- 
+2.22.0
+
+
diff --git a/meta/recipes-devtools/opkg/opkg/opkg_archive.patch b/meta/recipes-devtools/opkg/opkg/opkg_archive.patch
new file mode 100644
index 00000000000..3e1ebae9530
--- /dev/null
+++ b/meta/recipes-devtools/opkg/opkg/opkg_archive.patch
@@ -0,0 +1,54 @@
+From alejandro.delcastillo@ni.com Wed Nov 20 22:35:01 2019
+Return-Path: <richard.purdie+caf_=rpurdie=rpsys.net@linuxfoundation.org>
+From: Alejandro del Castillo <alejandro.delcastillo@ni.com>
+To: <opkg-devel@googlegroups.com>, <richard.purdie@linuxfoundation.org>
+CC: Alejandro del Castillo <alejandro.delcastillo@ni.com>
+Subject: [opkg][PATCH 1/2] opkg_archive.c: avoid double free on uncompress
+ error
+Date: Wed, 20 Nov 2019 16:34:47 -0600
+Message-ID: <20191120223448.26522-2-alejandro.delcastillo@ni.com>
+X-Mailer: git-send-email 2.22.0
+In-Reply-To: <20191120223448.26522-1-alejandro.delcastillo@ni.com>
+References: <20191120223448.26522-1-alejandro.delcastillo@ni.com>
+MIME-Version: 1.0
+Content-Type: text/plain
+Content-Transfer-Encoding: 8bit
+
+The open-inner function calls archive_read_open. On error,
+archive_read_open calls inner_close, which also closes the outter
+archive. On error, return NULL directly to avoid double free.
+
+
+Upstream-Status: Backport
+
+Signed-off-by: Alejandro del Castillo <alejandro.delcastillo@ni.com>
+---
+ libopkg/opkg_archive.c | 4 ++--
+ 1 file changed, 2 insertions(+), 2 deletions(-)
+
+diff --git a/libopkg/opkg_archive.c b/libopkg/opkg_archive.c
+index 3d87db1..0e9ccea 100644
+--- a/libopkg/opkg_archive.c
++++ b/libopkg/opkg_archive.c
+@@ -622,7 +622,7 @@ static struct archive *open_inner(struct archive *outer)
+     if (r != ARCHIVE_OK) {
+         opkg_msg(ERROR, "Failed to open inner archive: %s\n",
+                  archive_error_string(inner));
+-        goto err_cleanup;
++        return NULL;
+     }
+ 
+     return inner;
+@@ -683,7 +683,7 @@ static struct archive *extract_outer(const char *filename, const char *arname)
+ 
+     inner = open_inner(outer);
+     if (!inner)
+-        goto err_cleanup;
++        return NULL;
+ 
+     return inner;
+ 
+-- 
+2.22.0
+
+
diff --git a/meta/recipes-devtools/opkg/opkg_0.4.1.bb b/meta/recipes-devtools/opkg/opkg_0.4.1.bb
index 149ee3ca190..f0ae8b36bd1 100644
--- a/meta/recipes-devtools/opkg/opkg_0.4.1.bb
+++ b/meta/recipes-devtools/opkg/opkg_0.4.1.bb
@@ -14,6 +14,8 @@ PE = "1"
 SRC_URI = "http://downloads.yoctoproject.org/releases/${BPN}/${BPN}-${PV}.tar.gz \
            file://opkg.conf \
            file://0001-opkg_conf-create-opkg.lock-in-run-instead-of-var-run.patch \
+           file://opkg_archive.patch \
+           file://open_inner.patch \
            file://run-ptest \
 "
 
-- 
2.20.1


