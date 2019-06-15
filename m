Return-Path: <akuster808@gmail.com>
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com
	[209.85.214.194])
	by mail.openembedded.org (Postfix) with ESMTP id 2D9977E3EB
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 15 Jun 2019 17:51:09 +0000 (UTC)
Received: by mail-pl1-f194.google.com with SMTP id k8so1385637plt.3
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 15 Jun 2019 10:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=MFRnU56O+J6ofrbaWzHlkDYsrjzIhsM2sdHIRVNQHi0=;
	b=Zt5uZlCt4q5qpm+BheRfLCbkgkHkPrKESUEAVkp/UrQw8N/wpY8EBvigTdFAISIzu0
	nf2zV6WIkqD+/AjTny0yrnWuVhQyP6Huq1mo01BUwrTSPK1jmYdBsjwysP8QKxuC7LZO
	skgdFPXbDHVpg/5SiGg3MAbTB5xnst3eQTvJQXQPazOvdvK7CWFlm6OJue0/gZvjwJok
	x26CFmy3uH2+V+yYCMG6JMWSLkG4o0P/gJ9vgO50FQQ6yWpF4IJosQVnkeW3pKveJeVz
	USZhEouSsiyI7q2y3McUpvnb5yIXw2C4pvwPQ/eEFiyyytyfZb4ks9/6gIDdO6Pg3WEJ
	Ikog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=MFRnU56O+J6ofrbaWzHlkDYsrjzIhsM2sdHIRVNQHi0=;
	b=dgXysQuN4oM/OpECBviKpR1o4t9fmVS05pU/DOCsUKjij9Fo/OyxUOCll1URG8/iPg
	MEWKhEOiOsyRVavXLIINPX9GQamk+d6M1VqNENLAOEPZS8FPACiNWGR2ziBEEaSmGtrE
	aRM9nx+BhRE/Y0GHBc1O4sB/Qb22G/bxgvbOq1nsMSACS/VVbwahANNTaGFKqD7D3qXw
	g9z+TE7JCUvurm1QPBcmoMHM8rLBvb6KnSvKmkUeiW+2tmob9vVbwv3gX/HpuPljD9pL
	+YsAd5+4t18Qk38BTO04YOHqXKV8VCXiMmtzUK1/hEFGQJR65V20J2zg8sOGWXDeelts
	rKCg==
X-Gm-Message-State: APjAAAWDpMR1aMAOWcXyJ7Hcb3O8r8zEzoWjLogtqdMz8No2os9865sd
	48oQUTIOvEinUnOE9+q4Du2mlMIl
X-Google-Smtp-Source: APXvYqynk3PodKqX+LP8KSZQn5Cj3uEzhfo+N+94x1VsNCYoWSBCyVGqlPZIr9f7FytUY4rT8b33tA==
X-Received: by 2002:a17:902:8203:: with SMTP id
	x3mr15811783pln.304.1560621070366; 
	Sat, 15 Jun 2019 10:51:10 -0700 (PDT)
Received: from akuster-ThinkPad-T460s.hsd1.ca.comcast.net
	([2601:202:4180:c33:5942:80bf:dc9c:15ab])
	by smtp.gmail.com with ESMTPSA id x5sm6622470pjp.21.2019.06.15.10.51.09
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sat, 15 Jun 2019 10:51:09 -0700 (PDT)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 15 Jun 2019 10:50:41 -0700
Message-Id: <d34b9e4c3c49240407c2546fb4c663a73ddd2324.1560620937.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1560620937.git.akuster808@gmail.com>
References: <cover.1560620937.git.akuster808@gmail.com>
Subject: [Warror][ 11/23] ccid: fix SRC_URI
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
X-List-Received-Date: Sat, 15 Jun 2019 17:51:09 -0000

From: Martin Jansa <martin.jansa@gmail.com>

* alioth.debian.org isn't available anymore
* master already has this (was part of the upgrade to newer version)

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 meta-oe/recipes-support/ccid/ccid_1.4.24.bb | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/meta-oe/recipes-support/ccid/ccid_1.4.24.bb b/meta-oe/recipes-support/ccid/ccid_1.4.24.bb
index 31145d0..92f43d8 100644
--- a/meta-oe/recipes-support/ccid/ccid_1.4.24.bb
+++ b/meta-oe/recipes-support/ccid/ccid_1.4.24.bb
@@ -1,12 +1,12 @@
 SUMMARY = "Generic USB CCID smart card reader driver"
-HOMEPAGE = "http://pcsclite.alioth.debian.org/ccid.html"
+HOMEPAGE = "https://ccid.apdu.fr/"
 LICENSE = "LGPLv2.1+"
 LIC_FILES_CHKSUM = "file://COPYING;md5=2d5025d4aa3495befef8f17206a5b0a1"
 
 DEPENDS = "virtual/libusb0 pcsc-lite"
 RDEPENDS_${PN} = "pcsc-lite"
 
-SRC_URI = "https://alioth.debian.org/frs/download.php/file/4171/ccid-${PV}.tar.bz2 \
+SRC_URI = "https://ccid.apdu.fr/files/ccid-${PV}.tar.bz2 \
     file://no-dep-on-libfl.patch \
 "
 
-- 
2.7.4


