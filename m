Return-Path: <liu.ming50@gmail.com>
Received: from mail-wm0-f65.google.com (mail-wm0-f65.google.com [74.125.82.65])
	by mail.openembedded.org (Postfix) with ESMTP id 66CA7780FA
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  6 Jun 2017 03:28:02 +0000 (UTC)
Received: by mail-wm0-f65.google.com with SMTP id x3so5518172wme.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 05 Jun 2017 20:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=9Y/ZYH3fxPbsas3Hn1FA4+MnGkEMp9BXUB23EkdmjYo=;
	b=cN3f+1B+IoISMWbil/D5YJIjESTVzNtBgjyS3h6whnPNOayY5dzWZDDUd2VWUqc+iU
	P3Tqyr1gDsi/itQ0LTuBLiKWZfgqcxqpHQkfdminFu65aC87pZFneuQ0NGL1TfmaoGzs
	aFCRbaT9j0z3Z1ZGKIlIxxuQa0J71kLLQYBDjLY3k1PvRtd0QkDmOTM7IDbpXbLQ3K5B
	g326YRViBPJRuLpN1lR7Bs4EZMFgfpFiTAHyAR1a7HBul4TqI/3sTXtqUT/d1GN7K4/1
	7uG1U2G/iZfyuI1vLMkxT+MkR4JWcJk8NpLX5W3N8AdR0UPNl2u0uvPMDmpfR3dOBsSg
	FIRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=9Y/ZYH3fxPbsas3Hn1FA4+MnGkEMp9BXUB23EkdmjYo=;
	b=IPzEVTs4JOyi8aa/YcQ8CoGAn09j+mtuM2dlueZKBcA7wNEGHzuyWKF6mx0wSdfdm3
	Uq71JadilDXgNavxVWsc4iXT+6BDqmmhMxQT9WMRk13c/z/ic+cChOoTYABWsZh/7t4w
	0vOxP4tL4bu+hyLd1OM7rolJHwfApuJroBwLEztmEAm4rCquYB/uvRBFtL1zjmZpf4Iw
	VJB1ozKw3pDC1my/MK3JnywnLkAfM8cCyw6TRYxkQtE8smHRzGGlH16I00fkq0jHLvSB
	j7WwzGH83NrnpifHpfCsRkk+Wv9zSsgtyzhJf9Ea8r8YljIZLId/Byp6vICTJYW/BmOq
	Iilw==
X-Gm-Message-State: AODbwcCws7EhEoFQxaY3Rry2NUxbOGfgbmEQTBoHsc+ertLU7knlIY9+
	2MANL5sm55abNfZ+
X-Received: by 10.80.139.145 with SMTP id m17mr13943045edm.121.1496719683826; 
	Mon, 05 Jun 2017 20:28:03 -0700 (PDT)
Received: from peterliu-Precision-M4800.emea.group.atlascopco.com
	([106.119.199.183]) by smtp.gmail.com with ESMTPSA id
	n55sm12323590edd.65.2017.06.05.20.28.01
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 05 Jun 2017 20:28:03 -0700 (PDT)
From: liu.ming50@gmail.com
To: bitbake-devel@lists.openembedded.org
Date: Tue,  6 Jun 2017 05:27:52 +0200
Message-Id: <1496719672-5773-1-git-send-email-liu.ming50@gmail.com>
X-Mailer: git-send-email 2.7.4
Cc: Ming Liu <peter.x.liu@external.atlascopco.com>
Subject: [PATCH] bitbake-user-manual-metadata.xml: fix a typo
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
X-List-Received-Date: Tue, 06 Jun 2017 03:28:05 -0000

From: Ming Liu <peter.x.liu@external.atlascopco.com>

'buildCompleted' should be 'BuildCompleted'.

Signed-off-by: Ming Liu <peter.x.liu@external.atlascopco.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-metadata.xml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml b/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
index b32fa33..999d295 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
@@ -2030,7 +2030,7 @@
             before any tasks are executed so would be in the global
             configuration datastore namespace.
             No recipe-specific metadata exists in that namespace.
-            The "BuildStarted" and "buildCompleted" events also run in
+            The "BuildStarted" and "BuildCompleted" events also run in
             the main cooker/server process rather than any worker context.
             Thus, any changes made to the datastore would be seen by other
             cooker/server events within the current build but not seen
-- 
2.7.4


