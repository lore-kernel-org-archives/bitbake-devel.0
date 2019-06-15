Return-Path: <akuster808@gmail.com>
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
	[209.85.214.169])
	by mail.openembedded.org (Postfix) with ESMTP id 53BEE7E8E0
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 15 Jun 2019 17:51:02 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id ay6so127780plb.9
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 15 Jun 2019 10:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=P3Zo4bIlD06wkIrSSbXODhx0q0uR1Ks2WnhULIof0Kk=;
	b=lgwnTswffUybihBoGB3B3kAkOb9+N1fBG7SglHvAcJd4Tnf8ZHDBp+HcFsdLHXXQRw
	XMP0KtkriSZaGQRTnQTZUj6RRUuG98hbszzTtEUytO7/OsP6PqdOprGeapUNkCOKRfXq
	Ajdc9AEU6K8QoqoF+HxV8SHp2G8cdsRy7FLd/gdaV7bVeMBEmoK1c2qNCiTiWreShpuE
	wP50R0sZj9BNeaDqwg2xTjoLEIbvCmlS51Fqu3BSRGoQYnpvmIvc8mkorPqIu35gemNS
	IsLmA9gYzbooSzPJLXd2xSv/47gc9oSWhmJ5NuPemYrxHItEg1Ui7W1vC+U6Y2qIHkiF
	pgRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=P3Zo4bIlD06wkIrSSbXODhx0q0uR1Ks2WnhULIof0Kk=;
	b=U5GlWwYZk1bflnwedxDzZ1xvJW9JlwxWqD8Pod6p/jxrR/u1NhrSInM2M7q/zDPt75
	ztJdI3zyErrHC+ih5m6oOeqg+TV8kVzRLzoUl1giaxqME2c8xpvkkQWtduc//Nma0/W/
	sQGAG9kHwcutrPbUVs0mMtQXL5ExxFNBZgsJp+3kdwGmi6fJGbjZ7CZBf/ICO/yhrul8
	uyEFTV+Ng6R3+X+ByV320oRwhc1Om5bY1gORE+Qz5Ue4XNemosjRo+/AEzyPflNp8eks
	BHKDNM1Z7a5M/1LIrRcXb8CyXpnMbgowIAYu/mmIok4hJbn/J5Bx0iaCPRvZJHERGlgY
	kImQ==
X-Gm-Message-State: APjAAAV+Qj68PPuh3t8RH4O6mDYVS1AHceNQ40IMNPYch9OC5L6u0vXD
	rqxcmDhD7w+d3Vo0CTfAh53btcLT
X-Google-Smtp-Source: APXvYqyFWsOkom/xBs2R4b4poeJjmHfa07bdom5pQi6R0cKcc5iBKL/LJgd0VIT6PJOnVCNsYUoJvA==
X-Received: by 2002:a17:902:20e2:: with SMTP id
	v31mr99152909plg.138.1560621063226; 
	Sat, 15 Jun 2019 10:51:03 -0700 (PDT)
Received: from akuster-ThinkPad-T460s.hsd1.ca.comcast.net
	([2601:202:4180:c33:5942:80bf:dc9c:15ab])
	by smtp.gmail.com with ESMTPSA id x5sm6622470pjp.21.2019.06.15.10.51.02
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sat, 15 Jun 2019 10:51:02 -0700 (PDT)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 15 Jun 2019 10:50:33 -0700
Message-Id: <0fddf21a5d66f4c2103c7e9a6b1f40382ada9d68.1560620937.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1560620937.git.akuster808@gmail.com>
References: <cover.1560620937.git.akuster808@gmail.com>
Subject: [Warror][ 03/23] oprofile: make MACHINE_ARCH
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
X-List-Received-Date: Sat, 15 Jun 2019 17:51:02 -0000

From: Martin Jansa <martin.jansa@gmail.com>

* fixes:
ERROR: oprofile different signature for task do_configure.sigdata between hammerhead and mako
Hash for dependent task oprofile/oprofile_1.3.0.bb.do_prepare_recipe_sysroot changed from deecd34bc94f47935ce3dc7f83f9a8407269959e446518bd9700a2ebae4324bb to d4d6301a72fcd061c167a6715372a6e35f57bf08152a6223b1571957834428f0
Unable to find matching sigdata for /OE/build/luneos-master/webos-ports/meta-openembedded/meta-oe/recipes-kernel/oprofile/oprofile_1.3.0.bb.do_prepare_recipe_sysroot with hashes deecd34bc94f47935ce3dc7f83f9a8407269959e446518bd9700a2ebae4324bb or d4d6301a72fcd061c167a6715372a6e35f57bf08152a6223b1571957834428f0

$ bitbake-diffsigs /OE/build/luneos-master/webos-ports/tmp-glibc/sstate-diff/1557963509/[hm]*/*/oprofile/*do_prepare*.sigdata*
runtaskdeps changed:
['autoconf/autoconf_2.69.bb.do_populate_sysroot:virtual:native automake/automake_1.16.1.bb.do_populate_sysroot:virtual:native binutils/binutils_2.32.bb.do_populate_sysroot gcc/gcc-cross_7.3.bb.do_populate_sysroot gcc/gcc-runtime_7.3.bb.do_populate_sysroot glibc/glibc_2.29.bb.do_populate_sysroot gnu-config/gnu-config_git.bb.do_populate_sysroot:virtual:native libtool/libtool-cross_2.4.6.bb.do_populate_sysroot libtool/libtool-native_2.4.6.bb.do_populate_sysroot', -linux/linux-lg-hammerhead_git.bb.do_populate_sysroot, +linux/linux-lg-mako_git.bb.do_populate_sysroot, 'oprofile/oprofile_1.3.0.bb.do_fetch pkgconfig/pkgconfig_git.bb.do_populate_sysroot:virtual:native popt/popt_1.16.bb.do_populate_sysroot']
linux/linux-lg-hammerhead_git.bb.do_populate_sysroot with hash e58e94601af73831ea51ca6cc18578c26b9b491bcadb82a2c590b22498447438
 changed to
linux/linux-lg-mako_git.bb.do_populate_sysroot with hash 4c7372d0063be9d5c96bfad20a2052ded3a7121a06027c21a75e79a4f6a678e3
Dependency on task linux/linux-lg-mako_git.bb.do_populate_sysroot was added with hash 4c7372d0063be9d5c96bfad20a2052ded3a7121a06027c21a75e79a4f6a678e3
Dependency on task linux/linux-lg-hammerhead_git.bb.do_populate_sysroot was removed with hash e58e94601af73831ea51ca6cc18578c26b9b491bcadb82a2c590b22498447438

* as detected with:
openembedded-core/scripts/sstate-diff-machines.sh --targets=world --tmpdir=tmp-glibc/ --analyze --machines="hammerhead mako qemux86"

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 meta-oe/recipes-kernel/oprofile/oprofile_1.3.0.bb | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/meta-oe/recipes-kernel/oprofile/oprofile_1.3.0.bb b/meta-oe/recipes-kernel/oprofile/oprofile_1.3.0.bb
index 1dc535e..8d706e4 100644
--- a/meta-oe/recipes-kernel/oprofile/oprofile_1.3.0.bb
+++ b/meta-oe/recipes-kernel/oprofile/oprofile_1.3.0.bb
@@ -3,6 +3,9 @@ require oprofile.inc
 DEPENDS += "virtual/kernel"
 DEPENDS_append_powerpc64 = " libpfm4"
 
+# Depends on MACHINE_ARCH kernel
+PACKAGE_ARCH = "${MACHINE_ARCH}"
+
 SRC_URI[md5sum] = "bd998df5521ebedae31e71cd3fb6200b"
 SRC_URI[sha256sum] = "95ded8bde1ec39922f0af015981a67aec63e025a501e4dc04cd65d38f73647e6"
 
-- 
2.7.4


