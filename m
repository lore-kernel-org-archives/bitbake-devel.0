Return-Path: <akuster808@gmail.com>
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
	[209.85.214.181])
	by mail.openembedded.org (Postfix) with ESMTP id 79C437EB39
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 15 Jun 2019 17:51:16 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id e5so2341581pls.13
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 15 Jun 2019 10:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=OfgY++drjHG4Nay1KFg9l0oGNXHPFLPliWnKWNjsVF4=;
	b=JHIFpyKHYxmEE/9spwI6ecTRCsGWQWTciPg8DDeux7atNyLkH2fGrtS5egVVW2f6xt
	kYLW2cmWl2eD2P4J+BYhuro5E5HWo4UOfVUwzKxu3LKQRd2A+GXfn0aeV0W/L5fB7jJ6
	s4xibxQ6Ud8d+KCXbKYu+g4LGBMvHAUhmQW5QUpsCo2D3kM8yUc2uXok7T/d83K1JnNZ
	OasMs0J/YSoqT63O4qiP7faaKX1gkEldm43itGWW7idRZoTRr5pvzdfV0K8FhZh0ughL
	ZcZzuTVbLxWPvtq3dwKOAZ4Xq5g/k3CRDEIQpmqlDDjLFMXxycYCFRXlZcPM0q2+CWV4
	io6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=OfgY++drjHG4Nay1KFg9l0oGNXHPFLPliWnKWNjsVF4=;
	b=GIUVcRyABTfMbNWvQVbexaWWAmXUlvxuJvQZ+k7tR2qDBTqhJHZnMkv30Pt2bSsyPT
	gsgriCuo/9eJDA5f4OojYmffFhGYkLtSLgMpqeANb82bFn4MD/PZv/2324DDm8uLBGqQ
	RNXkh4LmEe87uN3hdE8IjR0F6dEfJFOYRqbIG21KNOmyzzOAqU/zj2/MxJRSMGw/8cmO
	UI88TM3B5BPmAct2HihiwotrbSyYu5SVDBhQMGsgp5G2tgbvUnDUkd2wnxW0hpsk+EUQ
	iuEWeBPGon/acf0aKhaQS7kLGa9ZCB35CT1EWfXhAKqSovOHJZfud2A74DCxeJXQXCEf
	wTzA==
X-Gm-Message-State: APjAAAUtP4GUetNzYptS39yegGBfXDVVFQYYib/jFjna0SQAkzG+jpm5
	AIF0lOgVYPfhYGLkF8i8R+VX46TJ
X-Google-Smtp-Source: APXvYqwsoK7rtFQn4zkNJ/MZzg/PVyUKqj55x1e0qCx8ZSHfiEeiWUG5/AwhZ3MIG0VgThcZHBVxCQ==
X-Received: by 2002:a17:902:3a5:: with SMTP id
	d34mr14822364pld.239.1560621077531; 
	Sat, 15 Jun 2019 10:51:17 -0700 (PDT)
Received: from akuster-ThinkPad-T460s.hsd1.ca.comcast.net
	([2601:202:4180:c33:5942:80bf:dc9c:15ab])
	by smtp.gmail.com with ESMTPSA id x5sm6622470pjp.21.2019.06.15.10.51.16
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sat, 15 Jun 2019 10:51:17 -0700 (PDT)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 15 Jun 2019 10:50:51 -0700
Message-Id: <624b41537a60683169185f479d85c32b0b4b2157.1560620937.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1560620937.git.akuster808@gmail.com>
References: <cover.1560620937.git.akuster808@gmail.com>
Subject: [Warror][ 21/23] uthash: do not use unstable github archive tarballs
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
X-List-Received-Date: Sat, 15 Jun 2019 17:51:16 -0000

From: nick83ola <nick83ola@gmail.com>

Since commit [21f84fc insane: add sanity checks to SRC_URI] applied
in oe-core, do not use unstable github archive tarballs.

Signed-off-by: Nicola Lunghi <nick83ola@gmail.com>
Signed-off-by: Khem Raj <raj.khem@gmail.com>
Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 meta-oe/recipes-support/uthash/uthash_2.1.0.bb | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/meta-oe/recipes-support/uthash/uthash_2.1.0.bb b/meta-oe/recipes-support/uthash/uthash_2.1.0.bb
index 7eb1383..d01a06c 100644
--- a/meta-oe/recipes-support/uthash/uthash_2.1.0.bb
+++ b/meta-oe/recipes-support/uthash/uthash_2.1.0.bb
@@ -9,15 +9,14 @@ HOMEPAGE = "https://troydhanson.github.io/uthash/"
 SECTION = "base"
 LICENSE = "BSD-1-Clause"
 LIC_FILES_CHKSUM = "file://LICENSE;md5=a2513f7d2291df840527b76b2a8f9718"
+SRCREV = "8b214aefcb81df86a7e5e0d4fa20e59a6c18bc02"
 
 SRC_URI = "\
-    https://github.com/troydhanson/${BPN}/archive/v${PV}.tar.gz;downloadfilename=${BP}.tar.gz \
+    git://github.com/troydhanson/${BPN}.git \
     file://run-ptest \
 "
-UPSTREAM_CHECK_URI = "https://github.com/troydhanson/${BPN}/releases"
 
-SRC_URI[md5sum] = "4d0a33f6393260926032f1fad4bad39a"
-SRC_URI[sha256sum] = "152ccd8e64d0f495377232e3964d06c7ec8bb8c3fbd3217f8a5702614f9a669e"
+S = "${WORKDIR}/git"
 
 inherit ptest
 
-- 
2.7.4


