Return-Path: <akuster808@gmail.com>
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
	[209.85.215.180])
	by mail.openembedded.org (Postfix) with ESMTP id 288867EAA2
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 15 Jun 2019 17:51:04 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id v9so3386238pgr.13
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 15 Jun 2019 10:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=LyFIkF2R5KDrfMoANPmldCu4T6E4Yl74jVmrQ/WPaXA=;
	b=KmtgKGth+Bw+Jtt6Di5jeNRAD6t+GRjEgPOQBWhLww/1f8NeBlEpztm1/leHpec1jK
	+h9siP7wmV/I04il1qpgAKbSmZCFzbkICPaYi8dil1Mx5NDUUZWs6gFT1Yxe4L1t7nMr
	XDDXsUXIaJwmxU2AwxyAKOtcjht4LIdl8boFP3cROAYfNqOr7hn+Z6sZYWMr9V3VAegy
	I0d4np5b3OzfPZWho1ujD8ywOb+0pU2JBIf5LVtM1M38OuGeRkbQm0MoR0n6JZOWA/rR
	BXq24960n05dg9hCsjkYoc46gAMOY1HG29c488+78m/GZk7ImFcayXrDN1O03YF46GFF
	C0pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=LyFIkF2R5KDrfMoANPmldCu4T6E4Yl74jVmrQ/WPaXA=;
	b=QIZXzGGODNEYCyxA5vLLSlYCjnFQOCH4aj93xb59xFz9fWImAl5GGPcoUZyYqSP4FR
	lksBm180KeJwoxd4YSgCNcvBOt4g8GnwtXDZ4K9R5aqTcrZrT/zs+SdznyvxES5PwJDd
	PIjz5B/wY4Q/EZXCZ7QSa+Lgti7EPgdH7X3E/s6DhVrEBXHJXi1tBerKRsDxhCmMAkse
	Pi1P1VP3supqFxHj5qwHVL/S9dw4C6VLhBJ4qwe145AyEvB1Ogem7FssOzAx3F6lfV69
	abPZ7ja2ephPO54nMw14Xe0zgpYew39hDh6eH9aF9bm6ht3lac+8Mxy+U39DxOHQs40t
	jxFg==
X-Gm-Message-State: APjAAAUXA6HXDBX1WcJqsppCEEtbs+AlmUtE34J73L7mTfvwId4GZSjN
	940DImibhCYTidIG3B168j1v6Qv0
X-Google-Smtp-Source: APXvYqzsdB6WPMSRn0l/jImeYF+W3E777nYDapCRaVazxKlQkaL7eUayiHIgcnLkwX+i6JCoHY5zjQ==
X-Received: by 2002:a17:90a:21d0:: with SMTP id
	q74mr17590284pjc.12.1560621065354; 
	Sat, 15 Jun 2019 10:51:05 -0700 (PDT)
Received: from akuster-ThinkPad-T460s.hsd1.ca.comcast.net
	([2601:202:4180:c33:5942:80bf:dc9c:15ab])
	by smtp.gmail.com with ESMTPSA id x5sm6622470pjp.21.2019.06.15.10.51.04
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sat, 15 Jun 2019 10:51:04 -0700 (PDT)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 15 Jun 2019 10:50:35 -0700
Message-Id: <ac3b63a7405aee4ca86f4d99908731ccdd2eb4fc.1560620937.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1560620937.git.akuster808@gmail.com>
References: <cover.1560620937.git.akuster808@gmail.com>
Subject: [Warror][ 05/23] mscgen: fix SRC_URI for multilib
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
X-List-Received-Date: Sat, 15 Jun 2019 17:51:05 -0000

From: Martin Jansa <martin.jansa@gmail.com>

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 meta-oe/recipes-support/mscgen/mscgen_0.20.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta-oe/recipes-support/mscgen/mscgen_0.20.bb b/meta-oe/recipes-support/mscgen/mscgen_0.20.bb
index 6ead015..276ad20 100644
--- a/meta-oe/recipes-support/mscgen/mscgen_0.20.bb
+++ b/meta-oe/recipes-support/mscgen/mscgen_0.20.bb
@@ -4,7 +4,7 @@ HOMEPAGE = "http://www.mcternan.me.uk/mscgen/"
 LICENSE = "GPLv2"
 LIC_FILES_CHKSUM = "file://COPYING;md5=b1e6a340187c1cf716513439d07c1d79"
 
-SRC_URI = "http://www.mcternan.me.uk/mscgen/software/${PN}-src-${PV}.tar.gz"
+SRC_URI = "http://www.mcternan.me.uk/mscgen/software/${BPN}-src-${PV}.tar.gz"
 
 SRC_URI[md5sum] = "65c90fb5150d7176b65b793f0faa7377"
 SRC_URI[sha256sum] = "3c3481ae0599e1c2d30b7ed54ab45249127533ab2f20e768a0ae58d8551ddc23"
-- 
2.7.4


