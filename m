Return-Path: <akuster808@gmail.com>
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
	[209.85.214.179])
	by mail.openembedded.org (Postfix) with ESMTP id 848737E3EB
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 15 Jun 2019 17:51:10 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id p1so2361247plo.2
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 15 Jun 2019 10:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=CKH0cpG0IOEp/fLYKbbcZj5KCoIBUDL0dOrjcIlnTXM=;
	b=QT5c27lpCopVP5thaNTZ5von8Bxs06gZesvcGul3vtI6dArW7mdZUlsZRwmXjzM3U/
	sHmli0jqRdYbYGk2d/MFHO6DlflfzgXsIlCfDXkJTZ9rjtkscUL5Inso13CHeBCe46Ax
	0FQdLhIQYgTPBmrGw1mWnnpc+u/VjxMfsS2kSobWhs/ufUmo6cJAkQ7c5xSXPC1fm7Om
	Sf704RFjejNg7xyEJDcbxmRJX51vNjo/mDQ/3/sME3/Sj4Ggt+mtPFJcx0tBzKF4NE28
	gGJmWOHP1YWr/FIqaw3Ls1RN057QPdYK7SwEwPzPtZveWXMWMnTZMeIeXxX11huxxlPU
	3sQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=CKH0cpG0IOEp/fLYKbbcZj5KCoIBUDL0dOrjcIlnTXM=;
	b=XrwfWkYhgaYpi04jRlo2crRl/teiqr16CWX7Bz2rIIEht1o/DTi1e8v7gwg6JQrTL9
	2OcT7Vr1EAwM8blTJUd8ADHNOUTav/qEstvW6YTFKK3FpTFdSd1F5u/W25y6zDYpLlT1
	9uXiHPoIk+vilx/NOSZktBMaQY+PbQZzsLk4foYLK3j5zS7QnPPro0Sdea0UVY+Pmonz
	kGXayauz4/tgCkYYOBZ/S7UmEcmivtPrMqY9/KK3TNhGKXIhJYvWX7wwkJ7tMnmyNcgj
	+KTdm8qOXkil//LVJ7J1/hWRUwnHe9wCKp1v+834GZN+682FIIPhMC+P0hHfGtVuVHFp
	7A5g==
X-Gm-Message-State: APjAAAXOFhsyigiiBTFiXX1xpYDi4ifJ+he+XNSN70oOiRaKvj8BvEd5
	Dl7h5KbZ7dIwCgvJ0w/nDPFrD8L5
X-Google-Smtp-Source: APXvYqxDAkGKf3doLtulr5KBV6QNeke16uXP5frzllGCw15lyxT2QCFrH2n9kzpz0cwc4O/eO5cNgg==
X-Received: by 2002:a17:902:e011:: with SMTP id
	ca17mr32532432plb.328.1560621071718; 
	Sat, 15 Jun 2019 10:51:11 -0700 (PDT)
Received: from akuster-ThinkPad-T460s.hsd1.ca.comcast.net
	([2601:202:4180:c33:5942:80bf:dc9c:15ab])
	by smtp.gmail.com with ESMTPSA id x5sm6622470pjp.21.2019.06.15.10.51.11
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sat, 15 Jun 2019 10:51:11 -0700 (PDT)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 15 Jun 2019 10:50:43 -0700
Message-Id: <e68fd1c8e982fc5470f7606cff57fe59272c9017.1560620937.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1560620937.git.akuster808@gmail.com>
References: <cover.1560620937.git.akuster808@gmail.com>
Subject: [Warror][ 13/23] ne10, libopus: add armv7ve override as well
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
X-List-Received-Date: Sat, 15 Jun 2019 17:51:10 -0000

From: Martin Jansa <martin.jansa@gmail.com>

* fix the override in packagegroup-meta-oe.bb
* alllow building ne10 for armv7ve (e.g. Cortex-A15)

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
Signed-off-by: Khem Raj <raj.khem@gmail.com>
Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 meta-oe/recipes-core/packagegroups/packagegroup-meta-oe.bb | 3 ++-
 meta-oe/recipes-multimedia/libopus/libopus_1.1.3.bb        | 3 ++-
 meta-oe/recipes-support/ne10/ne10_1.2.1.bb                 | 4 +++-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/meta-oe/recipes-core/packagegroups/packagegroup-meta-oe.bb b/meta-oe/recipes-core/packagegroups/packagegroup-meta-oe.bb
index 5fcf989..af3e848 100644
--- a/meta-oe/recipes-core/packagegroups/packagegroup-meta-oe.bb
+++ b/meta-oe/recipes-core/packagegroups/packagegroup-meta-oe.bb
@@ -220,7 +220,8 @@ RDEPENDS_packagegroup-meta-oe-shells ="\
 
 NE10 = ""
 NE10_aarch64 = "ne10"
-NE10_arm7 = "ne10"
+NE10_armv7a = "ne10"
+NE10_armv7ve = "ne10"
 
 RDEPENDS_packagegroup-meta-oe-support ="\
     anthy asio atop augeas avro-c bdwgc frame grail \
diff --git a/meta-oe/recipes-multimedia/libopus/libopus_1.1.3.bb b/meta-oe/recipes-multimedia/libopus/libopus_1.1.3.bb
index 50d4937..fb9bdc7 100644
--- a/meta-oe/recipes-multimedia/libopus/libopus_1.1.3.bb
+++ b/meta-oe/recipes-multimedia/libopus/libopus_1.1.3.bb
@@ -28,9 +28,10 @@ EXTRA_OECONF = " \
     --enable-custom-modes \
 "
 
-# ne10 is available only for armv7a and aarch64
+# ne10 is available only for armv7a, armv7ve and aarch64
 DEPENDS_append_aarch64 = " ne10"
 DEPENDS_append_armv7a = " ne10"
+DEPENDS_append_armv7ve = " ne10"
 
 python () {
     if d.getVar('TARGET_FPU') in [ 'soft' ]:
diff --git a/meta-oe/recipes-support/ne10/ne10_1.2.1.bb b/meta-oe/recipes-support/ne10/ne10_1.2.1.bb
index 4e8986d..f37ccde 100644
--- a/meta-oe/recipes-support/ne10/ne10_1.2.1.bb
+++ b/meta-oe/recipes-support/ne10/ne10_1.2.1.bb
@@ -15,13 +15,15 @@ PV .= "gitr+${SRCPV}"
 
 inherit cmake
 
-# Incompatible with archs other than armv7 and aarch64
+# Incompatible with archs other than armv7, armv7ve and aarch64
 COMPATIBLE_MACHINE = "(^$)"
 COMPATIBLE_MACHINE_aarch64 = "(.*)"
 COMPATIBLE_MACHINE_armv7a = "(.*)"
+COMPATIBLE_MACHINE_armv7ve = "(.*)"
 NE10_TARGET_ARCH = ""
 NE10_TARGET_ARCH_aarch64 = "aarch64"
 NE10_TARGET_ARCH_armv7a = "armv7"
+NE10_TARGET_ARCH_armv7ve = "armv7"
 
 EXTRA_OECMAKE = '-DGNULINUX_PLATFORM=ON -DNE10_BUILD_SHARED=ON -DNE10_LINUX_TARGET_ARCH="${NE10_TARGET_ARCH}"'
 
-- 
2.7.4


