Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F5BCAC597
	for <webhook@archiver.kernel.org>; Mon, 15 Sep 2025 12:21:41 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.web11.31662.1757938899107534977
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Sep 2025 05:21:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=zwbN84Ae;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id C7B504E40C9B
	for <bitbake-devel@lists.openembedded.org>; Mon, 15 Sep 2025 12:21:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9D8946063F;
	Mon, 15 Sep 2025 12:21:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0EDAC102F2ABB;
	Mon, 15 Sep 2025 14:21:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757938897; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=nmJ8dv3rMTtj5JdGLCfqmijWuTTBkLayJ8ARa7Sfzxk=;
	b=zwbN84AeH9+EbnG6oD3oAzA4j6qtYCzsdx3jW/mway5SBiF0jSpN3rmxIGBVdUq5AbI5vu
	1dNHlxMQPL1YwSCkS5RPsJyrR4n9dMYiD7sIjsPa9aNLSqXVezOOKge5gg37e+F68OOT0h
	BeqOeLlUuzz50z7B9mOaIvzAlVINcvJVICies2h5ZPKLm+eByUF0MAtEWoKGENzOGaB81B
	8tI9q9UHYzDzWzXLpUXEtNzaSHuvDUAT4MeWNP9qNiAUJ85OgYJhDFyyNaqf9lcKnEyeip
	iJuqNiUAwFU4aSX3DaFnlmwsla9jperHRPQUs6y928KKYxkw9p4CQRGNLihqSQ==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Mon, 15 Sep 2025 14:19:55 +0200
Subject: [PATCH 2/2] doc/conf.py: get current version from env
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-fix-switchers-js-v1-2-523ef53fe802@bootlin.com>
References: <20250915-fix-switchers-js-v1-0-523ef53fe802@bootlin.com>
In-Reply-To: <20250915-fix-switchers-js-v1-0-523ef53fe802@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=842;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=ApVajcZhEFzTNgGWXGlJj8yQqN3OMmZmTtaqrLHINfI=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBoyATOZQFKtYU3QpoYUraGOuccS4FUh8A/t5PbO
 SoU54AtGsCJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaMgEzgAKCRDRgEFAKaOo
 Nn8cD/sEBGTH+V3jPt/sYrNd+VEDHMx+KWpYiHcF7Ydruy5VXGkTKtCBN0uTFsaF19P+mLSq6nZ
 ia3+i8zlDcVkvV5wd6gioO4z+TByeDOncicnew0L+eeJtG0Q2vrTebISvuu9mLaheAmecDA7Y0B
 PXiK+8EJbGhFY++MNAyMqwN60sb8UlhmHdoXzM8XgUWSi639T+3e6OQzT/BVFR49U5iIQbwaReU
 TdzCIYZlMKF/96pJUCURVWT8vSDea+t1mqJq61gmPebft6uPuUhWswIRRTTOu51ajJCPgM8pbVb
 TthUJs3YMbQTcjefoh3haBt8USqvOEPiJXe006xGp3B0yBIG0cWdFYhoKb/dxWRwJJmCb/0YXXb
 rS8dV4MVFwnYrvdIczaW6Klgkck9n57HxWoEziggZtWekB2I9QpFR4TJtj6e5iLnc1jE/9EKKdv
 BVOvtYczzlEU35hMJNtFq5IBOWwYRMQYUNTFt2llegpakhRfCA+1iHTNSudLMp7lJfY3hu6qIbN
 A4rYqb5z9PlWNPYNn/kGjuWg+gr6x59zS1wOkwkIbiNfLNdkGUT0Tij3KQ10nBxObq63OAXxVnx
 lhAq7DGi6kz7k48omUMEQLVyYaF0RvBEkG3SZJzbvzo21NYx1qA2poPc6Xxwgovkh4phHqXrQ/M
 DT3jUKpsybXaCfg==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 15 Sep 2025 12:21:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18025

The Autobuilder can also give this information from the run-docs-build
script. Fallback on "dev" if we can't find the information, so we can
still build.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 doc/conf.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/doc/conf.py b/doc/conf.py
index f61241e28b..5845220f6f 100644
--- a/doc/conf.py
+++ b/doc/conf.py
@@ -14,12 +14,15 @@
 # import sys
 # sys.path.insert(0, os.path.abspath('.'))
 
+import os
 import sys
 import datetime
 
 from pathlib import Path
 
-current_version = "dev"
+# The current version of Bitbake we are building for is passed from the
+# Autobuilder.
+current_version = os.getenv("BITBAKE_CURRENT_VERSION", "dev")
 
 # String used in sidebar
 version = 'Version: ' + current_version

-- 
2.51.0


