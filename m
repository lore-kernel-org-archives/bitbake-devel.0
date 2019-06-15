Return-Path: <akuster808@gmail.com>
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
	[209.85.210.181])
	by mail.openembedded.org (Postfix) with ESMTP id 9A7A27E3EB
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 15 Jun 2019 17:51:00 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id q10so3321217pff.9
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 15 Jun 2019 10:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=4h3E0Js2feQNlBo/EtFisBriNHAtvETZoA9DaF2Vao8=;
	b=ZlDI7SjvWZQRKQ/x4lWOw3EXZhwH/sd7A3XbmC9PWuUdN2DpZy6Bjto3ObEcoAaN6v
	RoWB5ENJ2SXJHsx7Ab10jZ+XyqaeP9ER6SjPXcfBc5734CUQuNplHuYJ0Ue+3MCOCbMp
	wQzX9D2L3BkEy4cZaa3068k6GjNCzpaoNlKch7Re6iY0VWs+HpPQeorZx5c5VaLBpQna
	tivUPvPr0YAzO9KNjYSAGbr4i8x69uZxvG+H2mK1i/UFVwkNut6b51f/1bk1WT3WHY4s
	xcthXrJqjEOU0QTbu3hwv85Hg7Y7310eyElHem2iG8jH8t1mC8wTxOifBA+o4/Ztytsf
	K63A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=4h3E0Js2feQNlBo/EtFisBriNHAtvETZoA9DaF2Vao8=;
	b=bpflW4MvywL39/O0r0I71ivfyj6rNLGSQUhFF2D3YsJIpfJe23OWB43xGpVHpz2nOa
	DxmGmYHLUaSiwBbNgY9aqjJsVuzgidZ4bk72pJXTx84V7KtvmfP+mcwMp0oEs/q5tLT6
	Z3wbIj/okp6fin55dAaXTtH9twadrXmVLkdA1ym5KWWO0NIbuS6bYbmfppNFEHIZOV20
	NLXOb8Fevb+gUoJET7jy/Mbkxj6NVj6p3UXVrtGkOaRe7YvzNE2g1wvg08CkuFESLeY/
	nJ89QZSctWXXx13F6BTnId3uR/nRCkHw+77+/SlJtowHThLOGXn1YAQwdCy6nUG7dlUC
	6WuQ==
X-Gm-Message-State: APjAAAVGrRBj0XfLe18HqlMciJuCdQ9VAsdtp81mDMI3c+1sCPkS6ynY
	WP/QHos7stt2KYfCaAWYGWXSkhPh
X-Google-Smtp-Source: APXvYqz2Iwj7AQi1iZTTvtU6gC1QesnjDKTSq8tDgOBl6oKDAw8SZEezoE2sGW+UbvzUcEJmIVsgPw==
X-Received: by 2002:a63:6157:: with SMTP id v84mr40661648pgb.36.1560621061622; 
	Sat, 15 Jun 2019 10:51:01 -0700 (PDT)
Received: from akuster-ThinkPad-T460s.hsd1.ca.comcast.net
	([2601:202:4180:c33:5942:80bf:dc9c:15ab])
	by smtp.gmail.com with ESMTPSA id x5sm6622470pjp.21.2019.06.15.10.51.00
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sat, 15 Jun 2019 10:51:01 -0700 (PDT)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 15 Jun 2019 10:50:31 -0700
Message-Id: <e14c57e7db6a02a7829f412c34a1ab8825f927ab.1560620937.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1560620937.git.akuster808@gmail.com>
References: <cover.1560620937.git.akuster808@gmail.com>
Subject: [Warror][ 01/23] gtkwave: add distro_features_check
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
X-List-Received-Date: Sat, 15 Jun 2019 17:51:00 -0000

From: Martin Jansa <martin.jansa@gmail.com>

* fixes:
ERROR: Nothing PROVIDES 'gtk+' (but /OE/build/luneos-warrior/webos-ports/meta-openembedded/meta-oe/recipes-graphics/gtkwave/gtkwave_3.3.98.bb DEPENDS on or otherwise requires it)
gtk+ was skipped: one of 'x11 directfb' needs to be in DISTRO_FEATURES
ERROR: Required build target 'meta-world-pkgdata' has no buildable providers.
Missing or unbuildable dependency chain was: ['meta-world-pkgdata', 'gtkwave', 'gtk+']

and

ERROR: Nothing PROVIDES 'tk' (but /OE/build/luneos-warrior/webos-ports/meta-openembedded/meta-oe/recipes-graphics/gtkwave/gtkwave_3.3.98.bb DEPENDS on or otherwise requires it)
tk was skipped: missing required distro feature 'x11' (not in DISTRO_FEATURES)
ERROR: Required build target 'meta-world-pkgdata' has no buildable providers.
Missing or unbuildable dependency chain was: ['meta-world-pkgdata', 'gtkwave', 'tk']

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 meta-oe/recipes-graphics/gtkwave/gtkwave_3.3.98.bb | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/meta-oe/recipes-graphics/gtkwave/gtkwave_3.3.98.bb b/meta-oe/recipes-graphics/gtkwave/gtkwave_3.3.98.bb
index 60df6f7..b9aae0f 100644
--- a/meta-oe/recipes-graphics/gtkwave/gtkwave_3.3.98.bb
+++ b/meta-oe/recipes-graphics/gtkwave/gtkwave_3.3.98.bb
@@ -14,6 +14,10 @@ inherit pkgconfig autotools gettext texinfo
 DEPENDS = "tcl tk gperf-native bzip2 xz pango zlib gtk+ gdk-pixbuf glib-2.0"
 RDEPENDS_${PN} = "tk-lib"
 
+# depends on gtk+ which has this restriction
+inherit distro_features_check
+ANY_OF_DISTRO_FEATURES = "${GTK2DISTROFEATURES}"
+
 EXTRA_OECONF = "--with-tcl=${STAGING_BINDIR_CROSS} --with-tk=${STAGING_BINDIR_CROSS}"
 
 FILES_${PN} = "${bindir} ${datadir}"
-- 
2.7.4


