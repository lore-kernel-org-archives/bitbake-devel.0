Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
	[209.85.221.66])
	by mail.openembedded.org (Postfix) with ESMTP id DD8D26C4B5
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  7 Dec 2018 12:10:06 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id c14so3622129wrr.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 07 Dec 2018 04:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=2mG8HT7ufrXvco1+75CprS+UNpBq1v4uYPXc/h1HfCY=;
	b=DN+k6Kt/EjidP1MSDgfNIxPrN2Ki1TDoRXsrPiqs/RMYbvAujvTDBBphK5H3/Ns1yz
	Zm0dGKPrCMOx/TdzpUBwu1+QeSnSt2GyqnWcdjHnTklGckluZoWgUQcrt0uU7Qty+sFM
	av2iCASDSu7Xyjn6l8vaKRayKwhZ5+jSEiM28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=2mG8HT7ufrXvco1+75CprS+UNpBq1v4uYPXc/h1HfCY=;
	b=oR3JdVpy//z2nbx5D/AhCIqQJ6C2RFDlXhFBxiygvOoSIBk9JQ+xKrVe0RXAo5uoZx
	suKS5LaYDnQAxUsoFhmNYowBf1sd4ZbxQTJeJibO8aet37yfkmZWC15Vled7LTy9RYsf
	VuGPMohpU1MagTaHqLQQO+p36s0JM/pNNQ2af715xvGsceIwAtHYpa4mmc/AkMa1KQKR
	C1gWaQY/QwGhXd+nWC/iTZmlOUuMyxarUkt3HuFfKshn2zllW0JG4Z+m7YXGrwpPq7Sv
	OnqkZDru67JMudkbdh029OPhKtFKsd0tDW2tdPa0pRyW3C0QL0SgX0up75oZ4X8Vz4Y/
	Aa7Q==
X-Gm-Message-State: AA+aEWaCEKBB2SuaBkfWfG3CnEMmdTq80i+YNRbzBj7KXoEayb01RJHw
	jWh02KtrNSF5lTa5UKyyFseFIE+TSLw=
X-Google-Smtp-Source: AFSGD/XC4aTpN3WWY29cxz1psgCRW1vTVOC9XyKMEMvs2wqBDO4Xe8E0Bcb6u06o8Pfz+8LViMBzvw==
X-Received: by 2002:adf:a50c:: with SMTP id i12mr1520493wrb.220.1544184607314; 
	Fri, 07 Dec 2018 04:10:07 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	s66sm4590348wmf.34.2018.12.07.04.10.06
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 07 Dec 2018 04:10:06 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  7 Dec 2018 12:10:05 +0000
Message-Id: <20181207121005.11658-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Subject: [PATCH] cache: Cleanup deprecated function usage
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
X-List-Received-Date: Fri, 07 Dec 2018 12:10:07 -0000
Content-Transfer-Encoding: 8bit

Remove a deprecated warning and stop using our own deprecated API!

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cache.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index 258d679dc1..65c514b908 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -97,7 +97,7 @@ class CoreRecipeInfo(RecipeInfoCommon):
 
         self.skipreason = self.getvar('__SKIPPED', metadata)
         if self.skipreason:
-            self.pn = self.getvar('PN', metadata) or bb.parse.BBHandler.vars_from_file(filename,metadata)[0]
+            self.pn = self.getvar('PN', metadata) or bb.parse.vars_from_file(filename,metadata)[0]
             self.skipped = True
             self.provides  = self.depvar('PROVIDES', metadata)
             self.rprovides = self.depvar('RPROVIDES', metadata)
-- 
2.19.1


