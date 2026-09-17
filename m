Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16558C982D9
	for <webhook@archiver.kernel.org>; Thu, 17 Sep 2026 22:17:20 +0000 (UTC)
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1875.1789683435316299135
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 17 Sep 2026 15:17:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=c3V7A+E/;
 spf=pass (domain: smile.fr, ip: 74.125.225.140, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd38e0e5dso1407225e9.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 17 Sep 2026 15:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1789683433; x=1790288233; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7HlQBJ0LFrt1ruDGzJk0CX1WzmAhWgHpSOWGAa8qBTU=;
        b=c3V7A+E/Ln27NjHketE8VlOdefL/52NJAiMClmYLD3gkS14CZDQ2GS59ZhLmeVh7aK
         rFsZrb88pyfU3qlqtsM3oW2VBPu7UXjgfK7hy+LSFFv4Ml/ZL2bHB1y991QzpG7qQuTY
         F97k+bwox6saqqXXSnuVCvOBBOLTcOyRH+cj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789683433; x=1790288233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=7HlQBJ0LFrt1ruDGzJk0CX1WzmAhWgHpSOWGAa8qBTU=;
        b=el98n2VCDt6+ih/iS8PN5kh8OqhUyyOQEg23Zo19GzSL/muekcNB7+4zTZE/525ePI
         ljitcztCrfjBF6yz0OYwXd2f0K1pUE2HY2zjp71buT9Bmm21omC7At1/PfW+cFFHilTY
         2WxyLq2LeXVXogOzY8xWV/Me72Ggd3NNU1w1mPfn1YmDDXA7QTJ4ZKucm6oK3uSLXSWh
         /rDfPuT6g+v+0ByhSQkccXgU/Z6khTSvIHYCOnyJhv4e6T4tU/4LUW1t3eGpWhGlQo2t
         aZxF27JrtVcB5+ZaO+2o2pDNGVJiDb/81B+MUZoSPW29951hobNyZwCmTf7WMW1whBeA
         iMWw==
X-Gm-Message-State: AFuF++l4v5z6UtGuAbVWi2rkxabrTqugPgeAYb9nyo4hXY4CC2JRDfq8
	6gSmWhrqWqSvX8SqiR6zhYVb4vz5OnCaPzUdCXxudL+Ra3d6NzwzNg2isVCQxDHk3OEJaBux0uD
	BKFceygA=
X-Gm-Gg: AYBFou2jABvyPMe52JzsLHALpaNcRw+8rYNYDkhkzyrvFjeuAvvH9O8N5XrnkO1x432
	aA+vZ9HalPM1Ey0Qh32po4H9bLDGrPvgnn67HVQ2w1yaIL4j8VLynV3ZrhF4/TemvnDpoqYoTx0
	J7ttPkwp3uuXac9HrMd5xc/xiJ9pPkcvvWk+4I2ghPy+dYVfKUUZWpOt14GMBB4HU0/cDE4Ctlw
	9tcEhZjaIrvfBzfgx8xQNl5Y1qYomEM7/BgWhOGwELDVLL8ZzFivWQ9nbolfW8Q4Dn6u41cPABS
	4vW6PmTWlZAqstzQPb7N6lHnQGzxHWgGblfF4Jnbs0sdxdlw6qC7CJ/aJrS6VUbTUDeUGmAVVGZ
	TPe0EnxCeT1ZphSxsshRoApUYwHYlkz0J4mJUnUl4bBoq4H75kv4gcJHsyV7BbBxxV1BsjjmOZf
	H1CaKMQgFqzwZeCnVi9wbhr/RQfWv3UT1FNaOVo7w7MYfZo0xtzulp+IJaHsmNrTI76nNS9JlYC
	OKO1X54sk9Ad1Jk/voTdWeVUXG3TvmbHMlxnDmwzcm+9HZF3bDCiT4Jin7L2cL/ANM1DkMQs2E=
X-Received: by 2002:a05:600c:3b9d:b0:49f:bd3c:bc1f with SMTP id 5b1f17b1804b1-49fc573b54amr4031625e9.26.1789683433707;
        Thu, 17 Sep 2026 15:17:13 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd247809sm185737725e9.11.2026.09.17.15.17.13
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 15:17:13 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][wrynose][2.18][PATCH 4/7] fetch2/__init__.py: add filter_regex to default latest_versionstring
Date: Fri, 18 Sep 2026 00:17:02 +0200
Message-ID: <baea2a2c6e1fe8599b3218b97eb913c6a4bf5610.1789683244.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1789683244.git.yoann.congal@smile.fr>
References: <cover.1789683244.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 17 Sep 2026 22:17:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20227

From: Chen Qi <Qi.Chen@windriver.com>

Add filter_regex parameter to the default latest_versionstring
function so that fetchers that do not implement this function can also
take the filter_regex parameter.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 52f4d0ffd4a51b8c279eb5df157c90fe7d471a55)
Signed-off-by: Daniel Turull <daniel.turull@ericsson.com>
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/bb/fetch2/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index b9373d2a9..d5f9c7d8e 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1735,7 +1735,7 @@ class FetchMethod(object):
     def generate_revision_key(self, ud, d, name):
         return self._revision_key(ud, d, name)
 
-    def latest_versionstring(self, ud, d):
+    def latest_versionstring(self, ud, d, filter_regex=None):
         """
         Compute the latest release name like "x.y.x" in "x.y.x+gitHASH"
         by searching through the tags output of ls-remote, comparing

