Return-Path: <akuster808@gmail.com>
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com
	[209.85.214.193])
	by mail.openembedded.org (Postfix) with ESMTP id D231D7EAD0
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 15 Jun 2019 17:51:15 +0000 (UTC)
Received: by mail-pl1-f193.google.com with SMTP id e5so2341575pls.13
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 15 Jun 2019 10:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=Xau82ud8s61fc7nEWZbA1mhCdS0uKt7agL7ku/0C6Jc=;
	b=QVWlFWcmi1DdWG3VxHVZhCZakshqf0BzGivc/0jTwVqDQ1z1spTWp06EBrDvrT/BHP
	Jah3xCQ+TRyvtUheEAmoPMj6EgPcGrB7CNOXcl0UBvgygEtS4wA0t6yeIvnwtKoTyyDW
	lwBBinG2Xod0EmItWTrKaDDkbBz+4ALflvU8gITLOdfQceqqOg3j3haFx13B5ZQxUJ+Q
	1NLFto5z45TAg6e74h9YJKgv4NAC80jB5UAxjNrhyMRPx39Xak4Od7h1SXjpVh6oyG3B
	1pu1J7alATetYL684xMMb6b4fv1ZqdrAeMxIUxKKUyPtMjINKZvanf+Z8mIPHwOOpggi
	cG4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=Xau82ud8s61fc7nEWZbA1mhCdS0uKt7agL7ku/0C6Jc=;
	b=HOXGsGJL5hB0ziO94b04yG6Qwn63bsMVi4do9FFfH8jzsT6SLfWD20jPoVSiZaswNc
	zVtvq/yOYMu71PMpHMrHBs8+y9X3sNMR+BaduvmudkD3qNvf2LeSx0xvWa2RaNAxNjPS
	4uw9zlS/n2nf6Us0r5lB10md2hGl2E2W11sQk2+S1PA+jXxQs84JzJ8XnxZ4gQF2seG5
	O0NsGn8pf3lvIlC/w/zRyeh/H5mcUcdWhLlMr54R/mi2cyarV9BOmXiPrAPVSwTfnaEF
	aEgzuOPCE2gdOUz0TCcEEEDSOMBf9x/Hm2SnbBzMdx74AQkbk8PkNtfU1z+bXZlcIf/3
	R54w==
X-Gm-Message-State: APjAAAVSuXIILj7dYMJRuF3k5QQwWxks6q0SqwQfGw25Y6B1obDFqy26
	Na2bGZj4UUcP4Bo5vko0QF/4mLYL
X-Google-Smtp-Source: APXvYqwFoTgJe3ntzTcG7B7N4u0Ru80e1vkR02+joTKZVrTKAXTubUHsWMTd6lE0FAd8k/BtyaeTYQ==
X-Received: by 2002:a17:902:b204:: with SMTP id
	t4mr99719934plr.285.1560621076770; 
	Sat, 15 Jun 2019 10:51:16 -0700 (PDT)
Received: from akuster-ThinkPad-T460s.hsd1.ca.comcast.net
	([2601:202:4180:c33:5942:80bf:dc9c:15ab])
	by smtp.gmail.com with ESMTPSA id x5sm6622470pjp.21.2019.06.15.10.51.16
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sat, 15 Jun 2019 10:51:16 -0700 (PDT)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 15 Jun 2019 10:50:50 -0700
Message-Id: <06ec57f7cbbbad226afdd623e7ecb32bb7bc2fd7.1560620937.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1560620937.git.akuster808@gmail.com>
References: <cover.1560620937.git.akuster808@gmail.com>
Subject: [Warror][ 20/23] crash: do not use unstable github archive tarballs
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
X-List-Received-Date: Sat, 15 Jun 2019 17:51:15 -0000

From: Hongxu Jia <hongxu.jia@windriver.com>

Since commit [21f84fc insane: add sanity checks to SRC_URI] applied
in oe-core, do not use unstable github archive tarballs

Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
Signed-off-by: Khem Raj <raj.khem@gmail.com>
Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 meta-oe/recipes-kernel/crash/crash_7.2.5.bb | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/meta-oe/recipes-kernel/crash/crash_7.2.5.bb b/meta-oe/recipes-kernel/crash/crash_7.2.5.bb
index 0b23356..e124db1 100644
--- a/meta-oe/recipes-kernel/crash/crash_7.2.5.bb
+++ b/meta-oe/recipes-kernel/crash/crash_7.2.5.bb
@@ -12,8 +12,9 @@ LIC_FILES_CHKSUM = "file://COPYING3;md5=d32239bcb673463ab874e80d47fae504"
 
 DEPENDS = "zlib readline coreutils-native"
 
-SRC_URI = "https://github.com/crash-utility/${BPN}/archive/${PV}.tar.gz;downloadfilename=${BP}.tar.gz \
-           http://ftp.gnu.org/gnu/gdb/gdb-7.6.tar.gz;name=gdb;subdir=${BP} \
+S = "${WORKDIR}/git"
+SRC_URI = "git://github.com/crash-utility/${BPN}.git \
+           http://ftp.gnu.org/gnu/gdb/gdb-7.6.tar.gz;name=gdb;subdir=git \
            file://7001force_define_architecture.patch \
            file://7003cross_ranlib.patch \
            file://0001-cross_add_configure_option.patch \
@@ -25,8 +26,7 @@ SRC_URI = "https://github.com/crash-utility/${BPN}/archive/${PV}.tar.gz;download
            file://0002-crash-fix-build-error-unknown-type-name-gdb_fpregset.patch \
            file://0003-crash-detect-the-sysroot-s-glibc-header-file.patch \
            "
-SRC_URI[md5sum] = "3f6e18d38821bb326700f1d6d43bcaec"
-SRC_URI[sha256sum] = "114a83ca27c91e4321f6399d637a9d2270f72b9327e56d687c5fb139e903069b"
+SRCREV = "c0a2fc9d322cf0c5f569ce54e9201d2f586edb0c"
 
 SRC_URI[gdb.md5sum] = "a9836707337e5f7bf76a009a8904f470"
 SRC_URI[gdb.sha256sum] = "8070389a5dcc104eb0be483d582729f98ed4d761ad19cedd3f17b5d2502faa36"
-- 
2.7.4


