Return-Path: <jpewhacker@gmail.com>
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com
	[209.85.166.173])
	by mail.openembedded.org (Postfix) with ESMTP id 8E3147F979
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  6 Dec 2019 18:14:07 +0000 (UTC)
Received: by mail-il1-f173.google.com with SMTP id a7so7013292ild.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 06 Dec 2019 10:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=jCT+OZNisAYyJkjpIUujFax5XtYG9dDN+9IiK9hxd3o=;
	b=cza9LGTpy1ephUz+rFLCO0WyLPGmz2+muhutd9pXLpWMJzjhEflMwWAB9o6duW5WdN
	r9NJH4CwAD+2NQevytqob2bKhuPdkREIcyPONuNrBgNQfUDuAQ7Wyq2iLKRF5qVrY1UD
	jeOe4UumDzZV8mdwStnb8C8VMPErwbZBUNab0b0jihV+eM5NhQknnt49gH2gzlSZu+x2
	oQ/89Fq4O52E88mlL31jdm5/lyEqJmiu5LyYWuPCHoOTe0Phut357K0XnaoakbL9gNdi
	s3a4TOTiRFGiz8R4fhJI6QNynVSmrsuO5nifKHn2foTmL4KgFRSfFETHCGk62I9HztnZ
	XeyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=jCT+OZNisAYyJkjpIUujFax5XtYG9dDN+9IiK9hxd3o=;
	b=CS5DX2g9bnabKcCFSCFqk/ApuyxVS8DmgEPRub/KMyTKd1W8LlepBjba7bbuqIblhB
	C78FziyfRbUvkitRk6oSZV3UY/vQxpxZg2QsLtJqkt1chYoYCTn8Neqp68pivOB0Y5hx
	hBaU+iZ8q7dg8gfOFI5VGDsY7jZS/SsBUEi3ZOxw4yYPbIM40Uknn7hT82vkl/G5FazR
	eSGwtJ/ja38WT4bh/g8lL0DihjynM0xj+rl1LfuIWj6LclAxOMN/7QMmnak48MaJ4No7
	ujXMPXW1WpNL5exUZ3zlLXLQzMtrotInDoMJDr+VrWJ5gsEIfLTKZ5TYaRDj6aNiKyrj
	HDKg==
X-Gm-Message-State: APjAAAUHc3hJ6cP6TxqG/Am0FXnHPaP7iBOtNsvKdlZcR2vbGs7XVvek
	uKQHNvNkJbKSUywgWtW2PBGT5Mi0Y/Y=
X-Google-Smtp-Source: APXvYqwcSaO7PJN/Q4YIzWk/wu4UMLqavI4ZgVRrnR3/tiXfrQU4cgXvIMTPwnsMK8kXywYDWOEJFA==
X-Received: by 2002:a92:aa4d:: with SMTP id j74mr15892344ili.271.1575656048238;
	Fri, 06 Dec 2019 10:14:08 -0800 (PST)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id k9sm3398138ior.0.2019.12.06.10.14.07
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 06 Dec 2019 10:14:07 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  6 Dec 2019 12:12:56 -0600
Message-Id: <20191206181256.1392097-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Subject: [PATCH] Bump minimum python version to 3.5
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
X-List-Received-Date: Fri, 06 Dec 2019 18:14:07 -0000
Content-Transfer-Encoding: 8bit

The local hash equivalence server used by bitbake requires python 3.5,
so bump up the minimum required version.

[YOCTO #13678]

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/__init__.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/__init__.py b/bitbake/lib/bb/__init__.py
index c144311be4c..b9d8bfa7694 100644
--- a/bitbake/lib/bb/__init__.py
+++ b/bitbake/lib/bb/__init__.py
@@ -12,8 +12,8 @@
 __version__ = "1.44.0"
 
 import sys
-if sys.version_info < (3, 4, 0):
-    raise RuntimeError("Sorry, python 3.4.0 or later is required for this version of bitbake")
+if sys.version_info < (3, 5, 0):
+    raise RuntimeError("Sorry, python 3.5.0 or later is required for this version of bitbake")
 
 
 class BBHandledException(Exception):
-- 
2.23.0


