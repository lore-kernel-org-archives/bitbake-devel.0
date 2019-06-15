Return-Path: <akuster808@gmail.com>
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
	[209.85.214.170])
	by mail.openembedded.org (Postfix) with ESMTP id 2D7B27E3EB
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 15 Jun 2019 17:51:14 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id ay6so127910plb.9
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 15 Jun 2019 10:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=daJzNy9NfGcJt4HxNFwV1OKPm/vJas8FumMSs4fNlpY=;
	b=vIcTTK+sRL3IRkR45Iw/7mWNCMnCjOro9pm6+B23vVBwojWGRGPz7X/l8BOKgD6I6L
	LIOmxC/w8mtnf8ooYai0oqfIXM3yWCdetEGqeTpZr2ci++NYSZbpldPmN4m6tx9mVpuh
	JT5pdTncSR9KXeSJWp76VZ5lRMXl6p686FsIdn7dxE3qpM6UwLP0tNtpQ3JN/ndtMVCX
	7OdAkVZUG20bA2YjYt85gFMYdgx6e1BBzVyFcod+CztkicXeyOzmj459B9jV98+vHU+d
	+8Suw5kHk8pkfFbZGH38kuPpAw6jLCus3rXhKzCrZRFJlB2Jur22XE+1f83jW8CwXnna
	aTGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=daJzNy9NfGcJt4HxNFwV1OKPm/vJas8FumMSs4fNlpY=;
	b=tOKn1Dj5SK48VxpZnwtcMcIAzUrFvcmD7Lf4EOgNsARBOcE2RQhrEJrznGNrGGQUVR
	dIhhAfPcy8KlFBsU5STfL6IWbgLmgDCDORMtqah0eUcFEIXg8xyJkI9xy/CCxrBNT07L
	Cdvw5vTA7uWVmpOwIEz+6/V5s85BgXGz1gg/Lpb0IehhjHK/HFln79Cz3LJAQXuh9Y2F
	UdxyP+NSCNBUMkRVadJ8pagxuqy9ZsI+J5TXp5GiTntFuzVpkLjQzfDXYCw5eVabHQRJ
	EdJqxiz2X8/S3l8STnEnNahmNDbvAEM51VqXnILOhqQrBm1ojcesfp0fTfcilrNO4J5y
	r5Kg==
X-Gm-Message-State: APjAAAWZvsObv7IHCkHv5N+xckfe6SaWtEL64z53Bx5YC1EtwNyCQRNi
	eUVs9OXOksXxMlwPqN2SQJoNjiDh
X-Google-Smtp-Source: APXvYqzv3vR/4dPtMh7j9TDgyxuH25S2fTdfKHhSnTCjkeEMGGMnNinOHVlYaiXqjUcj4TLdfjfjtA==
X-Received: by 2002:a17:902:9a49:: with SMTP id
	x9mr79393734plv.282.1560621075362; 
	Sat, 15 Jun 2019 10:51:15 -0700 (PDT)
Received: from akuster-ThinkPad-T460s.hsd1.ca.comcast.net
	([2601:202:4180:c33:5942:80bf:dc9c:15ab])
	by smtp.gmail.com with ESMTPSA id x5sm6622470pjp.21.2019.06.15.10.51.14
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sat, 15 Jun 2019 10:51:14 -0700 (PDT)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 15 Jun 2019 10:50:48 -0700
Message-Id: <e0238bc3c6361b827b77934b0f4195a77e10dc15.1560620937.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1560620937.git.akuster808@gmail.com>
References: <cover.1560620937.git.akuster808@gmail.com>
Subject: [Warror][ 18/23] libmikmod: fix SRC_URI
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
X-List-Received-Date: Sat, 15 Jun 2019 17:51:14 -0000

From: Martin Jansa <martin.jansa@gmail.com>

* it was moved to outdated_versions directory

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
Signed-off-by: Khem Raj <raj.khem@gmail.com>
Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 meta-oe/recipes-multimedia/mikmod/libmikmod_3.3.6.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta-oe/recipes-multimedia/mikmod/libmikmod_3.3.6.bb b/meta-oe/recipes-multimedia/mikmod/libmikmod_3.3.6.bb
index d53dff6..bbf58f9 100644
--- a/meta-oe/recipes-multimedia/mikmod/libmikmod_3.3.6.bb
+++ b/meta-oe/recipes-multimedia/mikmod/libmikmod_3.3.6.bb
@@ -6,7 +6,7 @@ LIC_FILES_CHKSUM = "file://COPYING.LESSER;md5=4fbd65380cdd255951079008b364516c"
 DEPENDS = "alsa-lib texinfo"
 
 SRC_URI = "\
-    ${SOURCEFORGE_MIRROR}/project/mikmod/${BPN}/${PV}/${BPN}-${PV}.tar.gz \
+    ${SOURCEFORGE_MIRROR}/project/mikmod/outdated_versions/${BPN}/${PV}/${BPN}-${PV}.tar.gz \
 "
 SRC_URI[md5sum] = "9dd9bed30c6f7607a55480234606071b"
 SRC_URI[sha256sum] = "3f363e03f7b1db75b9b6602841bbd440ed275a548e53545f980df8155de4d330"
-- 
2.7.4


