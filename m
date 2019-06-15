Return-Path: <akuster808@gmail.com>
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
	[209.85.215.174])
	by mail.openembedded.org (Postfix) with ESMTP id 10B4E7EAA8
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 15 Jun 2019 17:51:06 +0000 (UTC)
Received: by mail-pg1-f174.google.com with SMTP id 20so3411209pgr.4
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 15 Jun 2019 10:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=KQGeDVttLlvr78wBMIF0QxlYvfsbzP56LXl5erj9BwM=;
	b=d+lk+6tqPJrqeWsa4G2v1Pnko2xZaJ82dW5pImoRVhYWRCYOmfY+A4LmUFUEGkuY1v
	9c/w/eebQ9QUdTT0vLQ8Luehv7aRcsT154XuWHJl9129GsWhlYyDgi/giFhVcYeMcGv/
	4eP01gnRf4DEyGf+GyMxScyhS0DMs8egRyX+VEilVt6yv4SrBWszFqLBydf/nB6RQqax
	rAC2TnBuGqNNbVL3mr9vUwfQKkE30qtGwR1ZyXKS6uohCLQ84snbrOSqNQujZw6WaPrT
	O3mfrEL5lDNaMBjRAsJQXOSdpHXvgPRLM4KUxLaB4adQB8zcAlg2T0iltXtSAfX3iaJZ
	XmQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=KQGeDVttLlvr78wBMIF0QxlYvfsbzP56LXl5erj9BwM=;
	b=t5HQAwNxzLSC9Vs6K58KHl8c/XOVpeLKwsiT+oL4Rn8aZCQi0uG4Ch2o4w2VqayIE5
	O60KVHrOMiDjKZfZq8/nQT2BIarTiT9I5bijSNx2Qm8JcBj4VR29BssehWTz6tG4/ibm
	yLyhTBzeIwpg5VvXXLgvmKzesfFWm4ipdWHqluU3SHfM21EXxHjLSrcOpubkgRFmayxy
	y54n8+JScQch3rXTJkC7DoWU3iWKL6pnKy2++IBVDeTkfximzxB9sfA1wfXZ7ekxZ+dA
	sTpHsGPUndM6egbGz7eoEe867VBesNUK7SLJ3OtY7sCETc/OQp7ufXirDRXafU7VEdra
	Mccw==
X-Gm-Message-State: APjAAAULx91R+6SRtVrRgg01dF0/fCSAN/IW1ARjHyU6+FHF2TvvoT1+
	0c9C4M3Pi/9luTny5HJYto5wI6Yh
X-Google-Smtp-Source: APXvYqyGrYONDoC8BuC9LOrkOmNRl6O8xEgmUW7Bw2lxps74SiuBw49PDLE+kdBwwrUudGnsPxdhRQ==
X-Received: by 2002:a65:5787:: with SMTP id b7mr42002759pgr.148.1560621068016; 
	Sat, 15 Jun 2019 10:51:08 -0700 (PDT)
Received: from akuster-ThinkPad-T460s.hsd1.ca.comcast.net
	([2601:202:4180:c33:5942:80bf:dc9c:15ab])
	by smtp.gmail.com with ESMTPSA id x5sm6622470pjp.21.2019.06.15.10.51.07
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sat, 15 Jun 2019 10:51:07 -0700 (PDT)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 15 Jun 2019 10:50:38 -0700
Message-Id: <ebc2170183b3f9246ed2611064c73d3f84b7b222.1560620937.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1560620937.git.akuster808@gmail.com>
References: <cover.1560620937.git.akuster808@gmail.com>
Subject: [Warror][ 08/23] opencv: use the same package name in PACKAGES and RDEPENDS
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
X-List-Received-Date: Sat, 15 Jun 2019 17:51:07 -0000

From: Martin Jansa <martin.jansa@gmail.com>

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 meta-oe/recipes-support/opencv/opencv_3.4.5.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta-oe/recipes-support/opencv/opencv_3.4.5.bb b/meta-oe/recipes-support/opencv/opencv_3.4.5.bb
index fa6e06a..ce60698 100644
--- a/meta-oe/recipes-support/opencv/opencv_3.4.5.bb
+++ b/meta-oe/recipes-support/opencv/opencv_3.4.5.bb
@@ -176,7 +176,7 @@ SUMMARY_python3-opencv = "Python bindings to opencv"
 FILES_python3-opencv = "${PYTHON_SITEPACKAGES_DIR}/*"
 RDEPENDS_python3-opencv = "python3-core python3-numpy"
 
-RDEPENDS_opencv-apps  = "bash"
+RDEPENDS_${PN}-apps  = "bash"
 
 do_install_append() {
     cp ${S}/include/opencv/*.h ${D}${includedir}/opencv/
-- 
2.7.4


