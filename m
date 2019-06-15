Return-Path: <akuster808@gmail.com>
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
	[209.85.210.196])
	by mail.openembedded.org (Postfix) with ESMTP id C2E777EB3D
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 15 Jun 2019 17:51:17 +0000 (UTC)
Received: by mail-pf1-f196.google.com with SMTP id r7so3336267pfl.3
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 15 Jun 2019 10:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=bO2vaccFElOPcx/dGBerDxWNqYx2Cv2YtDKLp/GJ4Qc=;
	b=fT3ZRqXLIl5y8gjtpkvr9fo5eBBezTscUdG4/BUcp2JrJ/vH3dNKLGVdmJqWZOUqGI
	0q3yu6vg3TNsfytgNdj5tbtp1vzZKz33hGhGnq+tovXYL+a5MtEhB/Vohf0DPhZjSRAt
	NlOUGRr65XGvc9l1H9lEroA2RIto8QqVNRKar5ttdcO0GLT9cyyvpuWKtfnDZVvqXf00
	0zHN1eq1Wl826N1yEdl0jSUVlJJak2P8AC7CGLci83Qn8q5+rf3APcTDFQmUGSn4+IH7
	hHDEEFlvPtpEZ2jyLW1KL8+UO7EqZ+Qbt+K4Y4aYCEdP6SSVBKdGpxUqizoSpgBdwh7D
	ZSwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=bO2vaccFElOPcx/dGBerDxWNqYx2Cv2YtDKLp/GJ4Qc=;
	b=rGPj70QKz1uXpsolA5rsAKvmjQnNtsXPpE68B3A4ojji7hKrG7K2tfxMdWxYEGhefZ
	h6bXJhek3RsNNTiPN6iDDORQsQJP4fNcVNuBQNOwe7oNMzpmo9gEKUvOXnoHTQUnzWUq
	E6uuut+SSxV3E/LgDtllzxcFTVEAECZ5lHsc7CKiTHINpASpD/GrtHnx2KMnP8dLe0gm
	wMYbqyxSNbltTyeJ35BmziZTkvfOu976UjljsfA9r8OeLzqABY9E+FObTYbT5shjemVu
	QIwSp3AC5d8VPV5Tb7wSu/6AJWXCqXZ7wOQCjvU9aXyx1UtIc/lohsMUiTMwH7Wii7I6
	McpQ==
X-Gm-Message-State: APjAAAVAEpj9OIlIN4n/TH5LwAhUS8316KkECBNPaEEgO/qsqDsw6kR9
	XJZRyWeDzxmimyUDgyDBQRi+qcuD
X-Google-Smtp-Source: APXvYqzQedsjNTBazmEQtyeGkl/RguIBu0/p7Id5YZZz0tgcIRgWW9k8XtnP3LKoIDxsAUwRN/UTnA==
X-Received: by 2002:a63:e358:: with SMTP id o24mr40648192pgj.78.1560621078789; 
	Sat, 15 Jun 2019 10:51:18 -0700 (PDT)
Received: from akuster-ThinkPad-T460s.hsd1.ca.comcast.net
	([2601:202:4180:c33:5942:80bf:dc9c:15ab])
	by smtp.gmail.com with ESMTPSA id x5sm6622470pjp.21.2019.06.15.10.51.18
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sat, 15 Jun 2019 10:51:18 -0700 (PDT)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 15 Jun 2019 10:50:53 -0700
Message-Id: <7c6e1c674a2ce9cca8129c2dbf1d031be4e22f5e.1560620937.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1560620937.git.akuster808@gmail.com>
References: <cover.1560620937.git.akuster808@gmail.com>
Subject: [Warror][ 23/23] turbostat: copy bits.h from kernel to turbostat
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
X-List-Received-Date: Sat, 15 Jun 2019 17:51:17 -0000

From: Liwei Song <liwei.song@windriver.com>

because bits.h was included in msr-index.h, so we also need
copy bits.h from kernel to tubostat to aviod compile error.

Signed-off-by: Liwei Song <liwei.song@windriver.com>
Signed-off-by: Khem Raj <raj.khem@gmail.com>
Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 meta-oe/recipes-kernel/turbostat/turbostat_3.4.bb | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/meta-oe/recipes-kernel/turbostat/turbostat_3.4.bb b/meta-oe/recipes-kernel/turbostat/turbostat_3.4.bb
index dc3e78f..3f25e6f 100644
--- a/meta-oe/recipes-kernel/turbostat/turbostat_3.4.bb
+++ b/meta-oe/recipes-kernel/turbostat/turbostat_3.4.bb
@@ -41,11 +41,13 @@ do_configure_prepend() {
 	mkdir -p ${S}
 	cp -r ${STAGING_KERNEL_DIR}/arch/x86/include/asm/msr-index.h ${S}
 	cp -r ${STAGING_KERNEL_DIR}/arch/x86/include/asm/intel-family.h ${S}
+	cp -r ${STAGING_KERNEL_DIR}/include/linux/bits.h ${S}
 	cp -r ${STAGING_KERNEL_DIR}/tools/power/x86/turbostat/* ${S}
 	cp -r ${WORKDIR}/COPYING ${S}
 }
 
 do_compile() {
+	sed -i 's#<linux/bits.h>#"bits.h"#' msr-index.h
 	sed -i 's#MSRHEADER#"msr-index.h"#' turbostat.c
 	sed -i 's#INTEL_FAMILY_HEADER#"intel-family.h"#' turbostat.c
 	sed -i 's#\$(CC) \$(CFLAGS) \$< -o \$(BUILD_OUTPUT)/\$@#\$(CC) \$(CFLAGS) \$(LDFLAGS) \$< -o \$(BUILD_OUTPUT)/\$@#' Makefile
-- 
2.7.4


