Return-Path: <akuster808@gmail.com>
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com
	[209.85.214.194])
	by mail.openembedded.org (Postfix) with ESMTP id 0289F7EAAB
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 15 Jun 2019 17:51:07 +0000 (UTC)
Received: by mail-pl1-f194.google.com with SMTP id s24so2351854plr.8
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 15 Jun 2019 10:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=bi3vORrScoWI2LXYof30FL04KSL4NhLYemC4AGwSoug=;
	b=bjbXWUW3HpegryvP9zZoSNrv1wBUqWPg2YIG0lAQsS1DLKZhBXcqvd9XLMUC4RHi1K
	wWJYYCm3mIQzI8vcnaTsDF3gfM5hTTpOs0+tnALvZOvddMAqkFNNfzsbwgeGUOyRScPA
	SxDnCw3AvPYx7VfVL4G8w2PNmMJSI+d8v99jg634aAis0w09HW/iqDDXgzhIwIYAB65q
	Xeb1+brsLJtUHNT7GTiUtBtv4W9frBkBTIw7d7pekkA21dxUSrEaj6YvOCo2ePHnPKts
	J9p7eVkiZBiyh1yswgKQZsMVe1lq0C3nBUUk+gTkWFPbj02YD0YLYmMmiOtNtQQD6MGQ
	qvpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=bi3vORrScoWI2LXYof30FL04KSL4NhLYemC4AGwSoug=;
	b=Y9kAltArChdEKxnnlj2GAcNwXR8z5VuadO47i9RGplksx6fHTJoXWVnagLOF4WYAsD
	fpp6QHc6bhNYksm5k8UNSuykopSyiQasx3hiaAn/kqrhNiT3JJ7Uz+4qcdXNzKYGX1rs
	l6uKiLDAxtb/MXjWrC7knEbryWP/1aME2Cwa5dA7ORUBYlPp/CzWaWVuDMEA/wiQQL5Z
	fNpEwNVUgrm+uiPRtlH/FkhSdcZVfLfA/upAOtIQkCiPF9K9y7QY7x4FGReeyJW7LogY
	6oJsru7IOTOVDIzBOp6KbMXle1RaJWmk0CAotqaGcI4+8ZSaXzm6+lZgi402bUo+y8BV
	u15g==
X-Gm-Message-State: APjAAAXMAfgTkcTveXWrPVWE/cwNj1Y8jrdjUI4eUhEVPUm3bT98nMSW
	2Tf0YoRfx5X+omlIx6RRxyvCEV8X
X-Google-Smtp-Source: APXvYqwj1jP3Wo7URS3O6DiUaTGUDiXRKMNOyc4oJT+H2DIIUXTvCd2d57n3r5YkgU+KR92t0FvWZw==
X-Received: by 2002:a17:902:760f:: with SMTP id
	k15mr75084922pll.125.1560621068866; 
	Sat, 15 Jun 2019 10:51:08 -0700 (PDT)
Received: from akuster-ThinkPad-T460s.hsd1.ca.comcast.net
	([2601:202:4180:c33:5942:80bf:dc9c:15ab])
	by smtp.gmail.com with ESMTPSA id x5sm6622470pjp.21.2019.06.15.10.51.08
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sat, 15 Jun 2019 10:51:08 -0700 (PDT)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 15 Jun 2019 10:50:39 -0700
Message-Id: <b5276e52e10bb87ba38872f0bd0cf9b9214fc8bf.1560620937.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1560620937.git.akuster808@gmail.com>
References: <cover.1560620937.git.akuster808@gmail.com>
Subject: [Warror][ 09/23] igmpproxy: remove 0001-src-igmpproxy.h-Include-sys-types.h-for-u_short-u_in.patch and _GNU_SOURCE
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
X-List-Received-Date: Sat, 15 Jun 2019 17:51:08 -0000

From: Martin Jansa <martin.jansa@gmail.com>

* it was upgraded to 0.2.1 in:
  commit 50979151e69e5707580b2f3d263a9b36b6a190d5
  Author: Oleksandr Kravchuk <open.source@oleksandr-kravchuk.com>
  Date:   Sat Mar 16 18:22:59 2019 +0100

    igmpproxy: update to 0.2.1

* which includes _GNU_SOURCE:
  https://github.com/pali/igmpproxy/commit/7d790aa2f16afad63418e573db13ea39d76ed141
* and includes sys/types.h in os-linux.h:
  https://github.com/pali/igmpproxy/commit/6f92242b23178e979f4a806abe4ac9652b51c593
* and the patch doesn't apply cleanly:
  ERROR: Fuzz detected:

  checking file src/igmpproxy.h
  Hunk #1 succeeded at 51 with fuzz 2 (offset 5 lines).

  patching file src/igmpproxy.h
  Hunk #1 succeeded at 51 with fuzz 2 (offset 5 lines).

  The context lines in the patches can be updated with devtool:

      devtool modify lib32-igmpproxy
      devtool finish --force-patch-refresh lib32-igmpproxy <layer_path>

  Don't forget to review changes done by devtool!

  ERROR: QA Issue: Patch log indicates that patches do not apply cleanly. [patch-fuzz]

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 ...xy.h-Include-sys-types.h-for-u_short-u_in.patch | 25 ----------------------
 .../recipes-daemons/igmpproxy/igmpproxy_0.2.1.bb   |  6 +-----
 2 files changed, 1 insertion(+), 30 deletions(-)
 delete mode 100644 meta-networking/recipes-daemons/igmpproxy/igmpproxy/0001-src-igmpproxy.h-Include-sys-types.h-for-u_short-u_in.patch

diff --git a/meta-networking/recipes-daemons/igmpproxy/igmpproxy/0001-src-igmpproxy.h-Include-sys-types.h-for-u_short-u_in.patch b/meta-networking/recipes-daemons/igmpproxy/igmpproxy/0001-src-igmpproxy.h-Include-sys-types.h-for-u_short-u_in.patch
deleted file mode 100644
index 82cdc36..0000000
--- a/meta-networking/recipes-daemons/igmpproxy/igmpproxy/0001-src-igmpproxy.h-Include-sys-types.h-for-u_short-u_in.patch
+++ /dev/null
@@ -1,25 +0,0 @@
-From a557651a08e21e3c7c7f5eca9f5405f86624903f Mon Sep 17 00:00:00 2001
-From: Khem Raj <raj.khem@gmail.com>
-Date: Fri, 14 Jul 2017 22:42:51 -0700
-Subject: [PATCH] src/igmpproxy.h: Include sys/types.h for u_short/u_init
-
-Signed-off-by: Khem Raj <raj.khem@gmail.com>
----
- src/igmpproxy.h | 1 +
- 1 file changed, 1 insertion(+)
-
-diff --git a/src/igmpproxy.h b/src/igmpproxy.h
-index 4dabd1c..4454729 100644
---- a/src/igmpproxy.h
-+++ b/src/igmpproxy.h
-@@ -46,6 +46,7 @@
- #include <stdbool.h>
- 
- #include <sys/socket.h>
-+#include <sys/types.h>
- #include <sys/un.h>
- #include <sys/time.h>
- #include <sys/ioctl.h>
--- 
-2.13.3
-
diff --git a/meta-networking/recipes-daemons/igmpproxy/igmpproxy_0.2.1.bb b/meta-networking/recipes-daemons/igmpproxy/igmpproxy_0.2.1.bb
index c99ebe0..db96d48 100644
--- a/meta-networking/recipes-daemons/igmpproxy/igmpproxy_0.2.1.bb
+++ b/meta-networking/recipes-daemons/igmpproxy/igmpproxy_0.2.1.bb
@@ -4,12 +4,8 @@ HOMEPAGE = "http://sourceforge.net/projects/igmpproxy/"
 LICENSE = "GPLv2+"
 LIC_FILES_CHKSUM = "file://COPYING;md5=432040ff3a55670c1dec0c32b209ad69"
 
-SRC_URI = "https://github.com/pali/igmpproxy/releases/download/${PV}/igmpproxy-${PV}.tar.gz \
-           file://0001-src-igmpproxy.h-Include-sys-types.h-for-u_short-u_in.patch \
-"
+SRC_URI = "https://github.com/pali/igmpproxy/releases/download/${PV}/${BP}.tar.gz"
 SRC_URI[md5sum] = "3a9c2cb42c1f5ee0cb769a4884545641"
 SRC_URI[sha256sum] = "d351e623037390f575c1203d9cbb7ba33a8bdef85a3c5e1d2901c5a2a38449a1"
 
 inherit autotools pkgconfig
-
-CFLAGS += "-D_GNU_SOURCE"
-- 
2.7.4


