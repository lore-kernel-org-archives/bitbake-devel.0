Return-Path: <andy.voltz@timesys.com>
Received: from mail-qt0-f177.google.com (mail-qt0-f177.google.com
	[209.85.216.177])
	by mail.openembedded.org (Postfix) with ESMTP id BF9817807E
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 18 May 2017 16:09:14 +0000 (UTC)
Received: by mail-qt0-f177.google.com with SMTP id v27so38040828qtg.2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 18 May 2017 09:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=timesys-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=kJm6+S7eTc7j3KXc23VpsoV+u8u6kVf+Ei7gmNV7Agw=;
	b=BXM8P4S9e3SuTkDjhasLWhkmZD99/9dg6R4V4dE+wbm3K9lQffC6tbnepdva9nNNl3
	iOXF0AnGC127lOBmhxOjfnLKcZScS7x5bpxhQ4WRtAhzdmKWGaMMKDZbzuKXfvPSq3Q0
	6+Jd/3R7rGwuDmfvQNdU32jeeyjCTAYgy11z6NJ0L9NR4HeiL/EeMISP6OKJO/yc072W
	jhwkU4DjvZPLUbUZLRiqpj2IWwEj5+BGaqslbP7yM3The6/FWqzDDKziovBNEHLoAiSE
	p9PvR6MjIT+kcTkNpQ/pgOeP/2noEjSELvVK02R8qeTFaLuPJ/e5eG7crNPmcU/7TyHw
	GGcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=kJm6+S7eTc7j3KXc23VpsoV+u8u6kVf+Ei7gmNV7Agw=;
	b=jijCSRGadCIvxNp9QnTZF1uBqCoGqQzD7H0Q6tRfZek7ud1ATNmrqjyUzQnzcg+Bcp
	e5EdQJJsje7mXDiXpC12teaW6612byswLAtarWRvwjln/GTSIIyFo0NFDWSEW2x/bv8w
	0G+v9rLPGQTOpC54QQ9HEPfxG5z/REqDxSnFtS663WLdNE9ADh9AnptynT0muG/qkxUX
	tBbeJbh4CFNz6kAvlEJzElLjwoGcu2WCyu/64eNqzCgYau7NPTNYD1pypkChzqeSxnKo
	ztmZnxpW5FI93BnEgHkuP76ftIwp8JzdObR3kuuXJ9mtIYT8aMBrzVhSgZYAiym7F6TA
	l99Q==
X-Gm-Message-State: AODbwcDIc8zHxGnR909uI/CMAYCRv9+ayEreiFzhV+nHShSERsC3L0c4
	mFzXGybZDfSYXvZI
X-Received: by 10.237.60.23 with SMTP id t23mr4819617qte.206.1495123755592;
	Thu, 18 May 2017 09:09:15 -0700 (PDT)
Received: from smarf.timesys.com
	(96-94-100-129-static.hfc.comcastbusiness.net. [96.94.100.129])
	by smtp.gmail.com with ESMTPSA id
	d200sm3917151qkg.50.2017.05.18.09.09.14
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 18 May 2017 09:09:14 -0700 (PDT)
From: Andy Voltz <andy.voltz@timesys.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 18 May 2017 12:09:10 -0400
Message-Id: <1495123751-14886-2-git-send-email-andy.voltz@timesys.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1495123751-14886-1-git-send-email-andy.voltz@timesys.com>
References: <1495123751-14886-1-git-send-email-andy.voltz@timesys.com>
Subject: [PATCH 1/2] tinfoil: allow extra features to be passed to prepare
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
X-List-Received-Date: Thu, 18 May 2017 16:09:14 -0000

Signed-off-by: Andy Voltz <andy.voltz@timesys.com>
---
 lib/bb/tinfoil.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index 928333a..563c0c4 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -228,12 +228,15 @@ class Tinfoil:
     def __exit__(self, type, value, traceback):
         self.shutdown()
 
-    def prepare(self, config_only=False, config_params=None, quiet=0):
+    def prepare(self, config_only=False, config_params=None, quiet=0, extra_features=None):
         if self.tracking:
             extrafeatures = [bb.cooker.CookerFeatures.BASEDATASTORE_TRACKING]
         else:
             extrafeatures = []
 
+        if extra_features:
+            extrafeatures += extra_features
+
         if not config_params:
             config_params = TinfoilConfigParameters(config_only=config_only, quiet=quiet)
 
-- 
2.1.4


