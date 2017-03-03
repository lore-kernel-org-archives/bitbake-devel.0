Return-Path: <armccurdy@gmail.com>
Received: from mail-pf0-f195.google.com (mail-pf0-f195.google.com
	[209.85.192.195])
	by mail.openembedded.org (Postfix) with ESMTP id 2F90272F3C
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  3 Mar 2017 00:22:05 +0000 (UTC)
Received: by mail-pf0-f195.google.com with SMTP id j5so8151309pfb.3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 02 Mar 2017 16:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=4c/w8EncKLccjqw8apNUtfuT40/SSO4gCXa9HV4uOpo=;
	b=IwJCr9ajYK5GVk3Q/dW2FSLKOZK1Hs7hexMeb0qwFngkWAk6Z8qpOd/xRayW+0gxCp
	iSLB5RiM8YoPeIdamTwXeR9hkNPBNulBN9Ajqu7XX0Cc/GWL+L2a9FagoNXMTHdfRZD4
	Mmz4gsPc/cVHedU4MCe5Bix2QDTWolQcdHakyTgPkw5QvJYqOTD/9u7KiaD1PMiFCl4T
	QxWpjRi+thDE9+ApuTFTOaEu5EENf9k8AgOkRxNU0ITGc7YltP/SkwXWrdCKc4nXAITN
	3Twlo99Z1UDBpPHPkNb9IjaXHchqCStRdc3pPX/YdoQblA5w3s/ApJM7wrXSjx1nHnDk
	2QGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=4c/w8EncKLccjqw8apNUtfuT40/SSO4gCXa9HV4uOpo=;
	b=gIcVWHW32T+nmTlgt+PmGCs/R9pIfxIeKNHpMeC5sbg8ynoes7OBU07q78C9yUmIis
	vC/XZqMNKLSVN+Rn/ggcVj3BcQmYjAZgjAj+KakpSmWUC7guy34ZY+G5VB517ZOvbl3E
	LOdpap4wOxNzbwVdmRFvRAbEN1KHlAAUqCr1jEKiNb7tXGa+JFNG7gf0hZzvidmzEl2r
	bsgOesGMRJsWFdUJZVpIaTCdXGiMPQWF2vxXPyhc0dFMlvVJ4avM7jRHpXYlo1WOJ37j
	Tec62qm2xR2DS/ejNfeulawAPdv2+Bn9bMDN+CfSDn41DNqsUkYy317a2k6LZh+/yY28
	StzA==
X-Gm-Message-State: AMke39k7GfvgLd39S+xVIOJ0SVKE4Yf3gn69ltzsXecmvCj56rf8DpeIHf4+dTArYBUK+g==
X-Received: by 10.99.43.71 with SMTP id r68mr18883426pgr.21.1488500527109;
	Thu, 02 Mar 2017 16:22:07 -0800 (PST)
Received: from e6520.cablelabs.com ([4.16.80.121])
	by smtp.gmail.com with ESMTPSA id
	o125sm19186001pfb.109.2017.03.02.16.22.05
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 02 Mar 2017 16:22:05 -0800 (PST)
From: Andre McCurdy <armccurdy@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  2 Mar 2017 16:22:00 -0800
Message-Id: <1488500520-2086-1-git-send-email-armccurdy@gmail.com>
X-Mailer: git-send-email 1.9.1
Subject: [PATCH] fetch2: remove last remaining usage of deprecated bb.data APIs
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
X-List-Received-Date: Fri, 03 Mar 2017 00:22:07 -0000

Signed-off-by: Andre McCurdy <armccurdy@gmail.com>
---
 lib/bb/fetch2/__init__.py | 3 +--
 lib/bb/fetch2/npm.py      | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 0205c3d..2f9813e 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -38,7 +38,6 @@ import pickle
 import errno
 import bb.persist_data, bb.utils
 import bb.checksum
-from bb import data
 import bb.process
 
 __version__ = "2"
@@ -1179,7 +1178,7 @@ class FetchData(object):
         self.mirrortarball = None
         self.basename = None
         self.basepath = None
-        (self.type, self.host, self.path, self.user, self.pswd, self.parm) = decodeurl(data.expand(url, d))
+        (self.type, self.host, self.path, self.user, self.pswd, self.parm) = decodeurl(d.expand(url))
         self.date = self.getSRCDate(d)
         self.url = url
         if not self.user and "user" in self.parm:
diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index 780f26d..73a75fe 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -25,7 +25,6 @@ import json
 import subprocess
 import signal
 import bb
-from   bb import data
 from   bb.fetch2 import FetchMethod
 from   bb.fetch2 import FetchError
 from   bb.fetch2 import ChecksumError
-- 
1.9.1


