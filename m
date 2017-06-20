Return-Path: <ross.burton@intel.com>
Received: from mail-wr0-f171.google.com (mail-wr0-f171.google.com
	[209.85.128.171])
	by mail.openembedded.org (Postfix) with ESMTP id 09FE877D2A
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 20 Jun 2017 18:47:36 +0000 (UTC)
Received: by mail-wr0-f171.google.com with SMTP id r103so102946146wrb.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 20 Jun 2017 11:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id;
	bh=/6I6kCQigZJ8HmgEtZSoHW60U3W2UWjDb9LJVWqkpKA=;
	b=P8mQ16iClLLxKuhYiauiXIyLD/aSf8X1iSooN8vg2X+0wnYzwkKOr19ep/4j3IVtvO
	ot20bDOZNNcJ9Al46V1XavSv/q7GL71JJPQjnovlwMpqm/4+f5oPGsB+0V8D1KhEPQAf
	r5AqEgbWn99m1Zs8smAKvGg2zXdidouGIVpHdIGdnQ6FfRrAKWwBhCxMl12TdpcMpXw4
	3HW4ab6ZsMNMycLdinBQCuvUKKKVM6IEbFaAvo+xdzMgHhvXdPZS66z40rgwv5razQHu
	D1htX8Fp9dhRnNAXGpMWaLKqnPqTDJ/taFIBkv2/CI//45qPcohx2+aFYv4/pm4kyarS
	UZ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=/6I6kCQigZJ8HmgEtZSoHW60U3W2UWjDb9LJVWqkpKA=;
	b=IRUCvizwMZizhUXhehC6pPHn/8SRLIRmNiZrzXAAx4abT3dI6gQN1DNVJW1TqP5Yb+
	SCNEL3pEQfVMOHEvBX7Up1T3xHol48n92rpX8E6E7g+RrznyRo31jhHksbB/H57h2ChB
	qh5OEUjwv0AYpUgBZx7CqQhBLhpTxzboGKrmz2Q0HUjPQAcAs2Tf8QxpwcJ9MYQJ5gPb
	hADHeXFjtjTC/6E5VGjG+iQuu1nLC7lga/kso1rChyZrNSlvvdg61FcCVH9AhvDB8fEM
	G3dzlwVnW9DxBpg7Ymyi9c9irOLROMRG4tbHElL/ZJktFogDvSJ45le5CgYJcaUNS7sN
	AZng==
X-Gm-Message-State: AKS2vOxV3/HL/aG9aMSm3JiLJZH/A6h1jCiruAEkJbeHd9ozWDxQmeHx
	4VqwxI0vVSAQe2u++S8=
X-Received: by 10.223.164.220 with SMTP id h28mr23446796wrb.24.1497984457362; 
	Tue, 20 Jun 2017 11:47:37 -0700 (PDT)
Received: from flashheart.burtonini.com (home.burtonini.com. [81.2.106.35])
	by smtp.gmail.com with ESMTPSA id
	u80sm16076503wrb.1.2017.06.20.11.47.36
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 20 Jun 2017 11:47:36 -0700 (PDT)
From: Ross Burton <ross.burton@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 20 Jun 2017 19:47:34 +0100
Message-Id: <20170620184734.15746-1-ross.burton@intel.com>
X-Mailer: git-send-email 2.11.0
Subject: [PATCH] bitbake/cache: don't insert PN into PACKAGES
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
X-List-Received-Date: Tue, 20 Jun 2017 18:47:37 -0000

The cache code currently inserts PN into the package list if it isn't already
present.  Whilst this ensures that the package list contains something which is
important for native recipes that don't set PACKAGES, it causes confusing
behaviour where a normal recipe doesn't have PN in PACKAGES: for example adding
dhcp to IMAGE_INSTALL will parse successfully but fail at rootfs time as the
dhcp recipe doesn't generate a dhcp package.

Solve this by only adding PN to the cache's package list if the package list is
empty.  This results in the package list for recipes such as DHCP being correct,
but native recipes continue to have just PN in the list as before.

[ YOCTO #5533 ]

Signed-off-by: Ross Burton <ross.burton@intel.com>
---
 bitbake/lib/bb/cache.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
index e7eeb4f5054..514399269a9 100644
--- a/bitbake/lib/bb/cache.py
+++ b/bitbake/lib/bb/cache.py
@@ -107,7 +107,7 @@ class CoreRecipeInfo(RecipeInfoCommon):
 
         self.pn = self.getvar('PN', metadata)
         self.packages = self.listvar('PACKAGES', metadata)
-        if not self.pn in self.packages:
+        if not self.packages:
             self.packages.append(self.pn)
 
         self.basetaskhashes = self.taskvar('BB_BASEHASH', self.tasks, metadata)
@@ -217,7 +217,7 @@ class CoreRecipeInfo(RecipeInfoCommon):
             cachedata.packages_dynamic[package].append(fn)
 
         # Build hash of runtime depends and recommends
-        for package in self.packages + [self.pn]:
+        for package in self.packages:
             cachedata.rundeps[fn][package] = list(self.rdepends) + self.rdepends_pkg[package]
             cachedata.runrecs[fn][package] = list(self.rrecommends) + self.rrecommends_pkg[package]
 
-- 
2.11.0


