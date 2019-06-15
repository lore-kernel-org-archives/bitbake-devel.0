Return-Path: <akuster808@gmail.com>
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
	[209.85.214.174])
	by mail.openembedded.org (Postfix) with ESMTP id 0EA9D7EAEC
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 15 Jun 2019 17:51:09 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id cl9so2347942plb.10
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 15 Jun 2019 10:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=fX4ahYGM9L/5d0fPLnfBYd77o+2hZkj2scB8Z6NnPHA=;
	b=qRNcxw9ErPBbrwa7acqb4/OBdJ3lZtag4I0fIdOEJ608tJyVpySAvIUvhx85cked4+
	AhnszEN9VTp6yfy67R9RnKR2APkeSab0Ztdr6Eyhdeu3jMUR6WQ2IjhWHxrQj+LUQeMt
	hVfPjgh+lhp1oQ7AlONcjoGyoqjg6DPYAp/QJyE4TJlbfqHsVjcU+T7NhKhE3emHGEh8
	Vxg25Hwi0jVhd/s0RcNlvAWBZENtSkZ4c7+ThjQ6GAl7XvAZxYByU4Or6nuS3bRNgnE7
	aJqKn6qswPMUWdwo8W3rnSpgs5m+2TMsmY0gygPeR8OZexkvOOutV7A5s424LTUsFc5T
	0BJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=fX4ahYGM9L/5d0fPLnfBYd77o+2hZkj2scB8Z6NnPHA=;
	b=b3WVPXegDDGGwJgLdpOkM0PLnf5CeYPfx3zSHoViRqS2ODTW/E4LxN42rVACDVggsI
	ad8xKpJzW/TyOYEhBY6lHzeu8x1SsUYi9HFqKyQ20iZXw5lkd3lo5sNvggNxwvWM/u0q
	nYa50+F4hTMgE5E/702RucPnKN6bfmJqeZ79JLQYGfpk5I2YGP7aOj4xJnrzzfTdvu/8
	+CZsKVveQ54lBz2skPOBeKjQl7tsvTXPdCBE8ueU58vQQoK3qYh9A95dEoUIaCNSrZwT
	Igs0+Q094L/uSSGnUMIC9yRPD0MGNwS4WarZ/ZIt6mdbvABr+3l/8SgpNkU3ejFS7wGo
	Xotg==
X-Gm-Message-State: APjAAAUjVCrS1V5qk7NFBUTiSdD9Yyjcmh3TZQAv6R84j9bxBpr9Cv+F
	dwTrMrMeivHpEZ5oIHoUFKDkRxoj
X-Google-Smtp-Source: APXvYqyXRB6vAbZXXoAPTtfm0ufGmyV9M24hQ+cczf2O8nOli9TvmOHVJXAfMNHhGvMXWM2JuDfpnw==
X-Received: by 2002:a17:902:d70a:: with SMTP id
	w10mr88527848ply.251.1560621071003; 
	Sat, 15 Jun 2019 10:51:11 -0700 (PDT)
Received: from akuster-ThinkPad-T460s.hsd1.ca.comcast.net
	([2601:202:4180:c33:5942:80bf:dc9c:15ab])
	by smtp.gmail.com with ESMTPSA id x5sm6622470pjp.21.2019.06.15.10.51.10
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sat, 15 Jun 2019 10:51:10 -0700 (PDT)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 15 Jun 2019 10:50:42 -0700
Message-Id: <465a9b349cc3f1a68e23e5e522a3e6798c651b9e.1560620937.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1560620937.git.akuster808@gmail.com>
References: <cover.1560620937.git.akuster808@gmail.com>
Subject: [Warror][ 12/23] wireguard: Upgrade 20190123 -> 20190406
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
X-List-Received-Date: Sat, 15 Jun 2019 17:51:10 -0000

From: Scott Ellis <scottellis.developer@gmail.com>

Fixes issues with kernels 5.1 and greater.

Backport from master fc1b5310b28f70900a8a432048e08ee06ae309d7

Signed-off-by: Scott Ellis <scott@jumpnowtek.com>
Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 ...eguard-module_0.0.20190123.bb => wireguard-module_0.0.20190406.bb} | 0
 ...ireguard-tools_0.0.20190123.bb => wireguard-tools_0.0.20190406.bb} | 0
 meta-networking/recipes-kernel/wireguard/wireguard.inc                | 4 ++--
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename meta-networking/recipes-kernel/wireguard/{wireguard-module_0.0.20190123.bb => wireguard-module_0.0.20190406.bb} (100%)
 rename meta-networking/recipes-kernel/wireguard/{wireguard-tools_0.0.20190123.bb => wireguard-tools_0.0.20190406.bb} (100%)

diff --git a/meta-networking/recipes-kernel/wireguard/wireguard-module_0.0.20190123.bb b/meta-networking/recipes-kernel/wireguard/wireguard-module_0.0.20190406.bb
similarity index 100%
rename from meta-networking/recipes-kernel/wireguard/wireguard-module_0.0.20190123.bb
rename to meta-networking/recipes-kernel/wireguard/wireguard-module_0.0.20190406.bb
diff --git a/meta-networking/recipes-kernel/wireguard/wireguard-tools_0.0.20190123.bb b/meta-networking/recipes-kernel/wireguard/wireguard-tools_0.0.20190406.bb
similarity index 100%
rename from meta-networking/recipes-kernel/wireguard/wireguard-tools_0.0.20190123.bb
rename to meta-networking/recipes-kernel/wireguard/wireguard-tools_0.0.20190406.bb
diff --git a/meta-networking/recipes-kernel/wireguard/wireguard.inc b/meta-networking/recipes-kernel/wireguard/wireguard.inc
index 8314e79..5cf745e 100644
--- a/meta-networking/recipes-kernel/wireguard/wireguard.inc
+++ b/meta-networking/recipes-kernel/wireguard/wireguard.inc
@@ -11,7 +11,7 @@ LICENSE = "GPLv2"
 LIC_FILES_CHKSUM = "file://../COPYING;md5=b234ee4d69f5fce4486a80fdaf4a4263"
 
 SRC_URI = "https://git.zx2c4.com/WireGuard/snapshot/WireGuard-${PV}.tar.xz"
-SRC_URI[md5sum] = "8a0a232f65d5d86dd408efd9ac30bcf9"
-SRC_URI[sha256sum] = "edd13c7631af169e3838621b1a1bff3ef73cf7bc778eec2bd55f7c1089ffdf9b"
+SRC_URI[md5sum] = "c11254fe48695e61c145a7e82756ecba"
+SRC_URI[sha256sum] = "2f06f3adf70b95e74a7736a22dcf6e9ef623b311a15b7d55b5474e57c3d0415b"
 
 S = "${WORKDIR}/WireGuard-${PV}/src/"
-- 
2.7.4


