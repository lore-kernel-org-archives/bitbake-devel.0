Return-Path: <akuster808@gmail.com>
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
	[209.85.215.174])
	by mail.openembedded.org (Postfix) with ESMTP id 78F157EAD4
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 15 Jun 2019 17:51:08 +0000 (UTC)
Received: by mail-pg1-f174.google.com with SMTP id s27so3418794pgl.2
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 15 Jun 2019 10:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=GUtQkksRAdgBXTzjXZvJM05e/JuiwRsETmjyukxwN1o=;
	b=eGUgqZ+mwqq2ojlRuvpLuIDm03s/CIHQAq9HwjnyfXhAQKSk6DqZMREEGWEYe7lylE
	+kGrgJe2fSp0JcepiiMMTyBoqC7kr1E04L6rC67sbCuRn/oNPnIe8gLndmX0gcIXcQB9
	qLZF5Lzdak0Y3jzo5FDkFmsmXmrvCDOjWSZ7/ItDcrCT856PNcGmZX6deKpVeoJRlmGZ
	6O/jwidNt+3dxouPe5Bbw3m2HE0VGWyq0EPnvrKTiClKDnU4MEq94o9imr0dmN1BNQFh
	EEn2B0BGJGBiOd01Bg7isWXHouWZeRMlv9s36jyaSKNDxIONTnj+cuCkImoE9lZxJ+r5
	AWIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=GUtQkksRAdgBXTzjXZvJM05e/JuiwRsETmjyukxwN1o=;
	b=nrSrIxAogqJt5qfVpaGZFfsJiIVg53Oche54pIMJt6yYJ8rKX4nxsSMWCUNVhmm3Jv
	wEr+oGH1tZaIkl2imCUUkYHG9xE8LMIGlle3K4c24gIMaWXc5Iury4eo3br/QWruAZFq
	8x+2OpaFp8EA8zlX1A2OqVUq84WuERWqlxYI4ZOmqpJWig2sC2egwDp5jxL8jNJKaVqv
	DZ7SaCz3u0JabIQY8uIy9CeaqSLRH4ifm9IjTo20Y9V5h0ZhSEJOWC1yXCH0dagqrV2n
	2elqSHnLVhdEZhz7YlzIvy13xLJfGwJn0TJjVTnhNFooqGSQkfXleoLxUgrME8ybf4LV
	T9ww==
X-Gm-Message-State: APjAAAWRe02rSzArBiUZVuGHdOEttOMk3Mqlre9iMqsq9nRmA1d1mufF
	qEqKOIWB7aCGX0C1U+tpKri6cn+f
X-Google-Smtp-Source: APXvYqzDOEr9Z7TuRnz0q9oAj7TeN7TExxRQB/zULQ5YXIEv0N83FN2+EX7hX3KKvZC4p7hwUCBNJA==
X-Received: by 2002:a63:3148:: with SMTP id x69mr26553310pgx.226.1560621069561;
	Sat, 15 Jun 2019 10:51:09 -0700 (PDT)
Received: from akuster-ThinkPad-T460s.hsd1.ca.comcast.net
	([2601:202:4180:c33:5942:80bf:dc9c:15ab])
	by smtp.gmail.com with ESMTPSA id x5sm6622470pjp.21.2019.06.15.10.51.08
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sat, 15 Jun 2019 10:51:09 -0700 (PDT)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 15 Jun 2019 10:50:40 -0700
Message-Id: <e7a0f311e3ce9abd6fe1d06ed255e15d48916b3c.1560620937.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1560620937.git.akuster808@gmail.com>
References: <cover.1560620937.git.akuster808@gmail.com>
Subject: [Warror][ 10/23] libvncserver: set PV in the recipe
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

* last SRCREV bump commit says:
  libvncserver: Update to latest commit post 0.9.12
  but there is no PV in the recipe, so the version was just:
  git-r0

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 meta-oe/recipes-graphics/libvncserver/libvncserver_git.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta-oe/recipes-graphics/libvncserver/libvncserver_git.bb b/meta-oe/recipes-graphics/libvncserver/libvncserver_git.bb
index 6a806ff..bc47a3f 100644
--- a/meta-oe/recipes-graphics/libvncserver/libvncserver_git.bb
+++ b/meta-oe/recipes-graphics/libvncserver/libvncserver_git.bb
@@ -32,6 +32,6 @@ inherit cmake
 
 SRC_URI = "git://github.com/LibVNC/libvncserver"
 SRCREV = "c0a23857a5c42b45b6d22ccf7218becd1fa69402"
-
+PV = "0.9.12+git${SRCPV}"
 
 S = "${WORKDIR}/git"
-- 
2.7.4


