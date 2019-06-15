Return-Path: <akuster808@gmail.com>
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
	[209.85.214.176])
	by mail.openembedded.org (Postfix) with ESMTP id 19A217E3EB
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 15 Jun 2019 17:51:11 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id a93so2358423pla.7
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 15 Jun 2019 10:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=UDmw4HRzVkFQaGbRMiSOLyQCZW7RVrHRFyfg5uIS10Q=;
	b=vWNOl+d1uXOKKZynapEUHdfv/SKYA1UmohtZFxY9qwjygRqLp5rIH1wfssHkb6Jgto
	qQne/ARndLNG/48saHIsggZoEEf5rPkyX948HtCKLwi1KLeZDGbvu0V92V8/WzeOTaJA
	48t8iFwIpkZeX+6wDrwmSD9jJgwQFWG/s2do/5Wl9xjh/VttSrmSCPOrJg66P6APnIgx
	0/fihwjrUZQ/zXdmda4+dcacxIIqzOtroSlpCbyqg62Fipc0BycUed5fROvrKf6Tm6vx
	sobhfbAsyQPJ+/EidDcGmTZg++0pweNy96mPzb3BSk89SyyQArSbWVrSh0BSPdI0363X
	iBIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=UDmw4HRzVkFQaGbRMiSOLyQCZW7RVrHRFyfg5uIS10Q=;
	b=bFfgEiBbZGMRq5U72/csLBxDKFpKRzWRWc9rsTKCAKwbv2JZ4gRu4eObXTYs/9VIz3
	2XhgCmr7UnQ1TxjDMSG1zJwLp/TiTkuW7oGLk9LPUqdWjP2d6j2bdyV6BuySkS6BGTx/
	F5wEcsPTWUvfTXUeYilK6dBXG5Tl44XKTrLu11NOpYfz/Xon2ocoKmRU2NLG9xeFTR8a
	Yfp2147AdZRXcUl4qkiAlk0wlKeFHCIzfmFJHP5rPcFvtlgOEz8TfHG4FQqByYUu1O3j
	hloIN8PITvF8+Yj/Mzhid09gPEYYM+7f8PdNHZd7XCqWWTqQmotavhl4jM2z/Gvah65v
	wJQA==
X-Gm-Message-State: APjAAAU3qhzHPYyl84p/qk042tI6RM0sDqzXjTkpLTSxiZT2qpB7lh21
	BlaiMZ/4t+fy8ttswY9v3lcxoYvv
X-Google-Smtp-Source: APXvYqxuDMfCKtwLCvW4cVJT9GcpBE1gKym9pu7YnVRbthaj0yTuRV5mcYZ3ZhFJIpCMv3/m1ySoAw==
X-Received: by 2002:a17:902:54f:: with SMTP id
	73mr97698888plf.246.1560621073095; 
	Sat, 15 Jun 2019 10:51:13 -0700 (PDT)
Received: from akuster-ThinkPad-T460s.hsd1.ca.comcast.net
	([2601:202:4180:c33:5942:80bf:dc9c:15ab])
	by smtp.gmail.com with ESMTPSA id x5sm6622470pjp.21.2019.06.15.10.51.12
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sat, 15 Jun 2019 10:51:12 -0700 (PDT)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 15 Jun 2019 10:50:45 -0700
Message-Id: <d37d0857592a709e1e0a290da0d44bae9fdd6971.1560620937.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1560620937.git.akuster808@gmail.com>
References: <cover.1560620937.git.akuster808@gmail.com>
Subject: [Warror][ 15/23] ttf-mplus, ttf-vlgothic: add ttf-mplus license
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
X-List-Received-Date: Sat, 15 Jun 2019 17:51:12 -0000

From: Martin Jansa <martin.jansa@gmail.com>

* add meta-oe/licenses/ttf-mplus from ttf-mplus/027-r4/mplus-TESTFLIGHT-027/LICENSE_E
* use BPN to use the same LICENSE even with multilib
* use the same license name from ttf-vlgothic
* fixes following warnings:
  WARNING: ttf-mplus-027-r4 do_populate_lic: ttf-mplus: No generic license file exists for: ttf-mplus in any provider
  WARNING: ttf-vlgothic-20141206-r0 do_populate_lic: ttf-vlgothic: No generic license file exists for: mplus in any provider

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
Signed-off-by: Khem Raj <raj.khem@gmail.com>
Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 meta-oe/licenses/ttf-mplus                               | 16 ++++++++++++++++
 meta-oe/recipes-graphics/ttf-fonts/ttf-mplus_027.bb      |  2 +-
 .../recipes-graphics/ttf-fonts/ttf-vlgothic_20141206.bb  |  2 +-
 3 files changed, 18 insertions(+), 2 deletions(-)
 create mode 100644 meta-oe/licenses/ttf-mplus

diff --git a/meta-oe/licenses/ttf-mplus b/meta-oe/licenses/ttf-mplus
new file mode 100644
index 0000000..c9cdca3
--- /dev/null
+++ b/meta-oe/licenses/ttf-mplus
@@ -0,0 +1,16 @@
+M+ FONTS                                Copyright (C) 2002-2009 M+ FONTS PROJECT
+
+-
+
+LICENSE_E
+
+
+
+
+These fonts are free softwares.
+Unlimited permission is granted to use, copy, and distribute it, with
+or without modification, either commercially and noncommercially.
+THESE FONTS ARE PROVIDED "AS IS" WITHOUT WARRANTY.
+
+
+http://mplus-fonts.sourceforge.jp/mplus-outline-fonts/
diff --git a/meta-oe/recipes-graphics/ttf-fonts/ttf-mplus_027.bb b/meta-oe/recipes-graphics/ttf-fonts/ttf-mplus_027.bb
index 9ad348d..efcf1b6 100644
--- a/meta-oe/recipes-graphics/ttf-fonts/ttf-mplus_027.bb
+++ b/meta-oe/recipes-graphics/ttf-fonts/ttf-mplus_027.bb
@@ -2,7 +2,7 @@ require ttf.inc
 
 SUMMARY = "MPlus font - TTF Edition"
 HOMEPAGE = "http://dejavu.sourceforge.net/wiki/"
-LICENSE = "${PN}"
+LICENSE = "${BPN}"
 LIC_FILES_CHKSUM = "file://LICENSE_E;md5=ac161e96eda00db9a3aec7870b5d9658 \
                     file://LICENSE_J;md5=a120ca8d7c8e4a475d5277c9aeb95221 \
 "
diff --git a/meta-oe/recipes-graphics/ttf-fonts/ttf-vlgothic_20141206.bb b/meta-oe/recipes-graphics/ttf-fonts/ttf-vlgothic_20141206.bb
index 62f2bb2..e522810 100644
--- a/meta-oe/recipes-graphics/ttf-fonts/ttf-vlgothic_20141206.bb
+++ b/meta-oe/recipes-graphics/ttf-fonts/ttf-vlgothic_20141206.bb
@@ -4,7 +4,7 @@ SUMMARY = "Japanese TrueType fonts from Vine Linux"
 AUTHOR = "Contributor: noonov <noonov@gmail.com>"
 HOMEPAGE = "http://vlgothic.dicey.org/"
 
-LICENSE = "mplus & BSD"
+LICENSE = "ttf-mplus & BSD"
 LIC_FILES_CHKSUM = "file://LICENSE.en;md5=66ecd0fd7e4da6246fa30317c7b66755 \
                     file://LICENSE_E.mplus;md5=1c4767416f20215f1e61b970f2117db9 \
 "
-- 
2.7.4


