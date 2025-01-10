Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5044E7719C
	for <webhook@archiver.kernel.org>; Fri, 10 Jan 2025 19:09:20 +0000 (UTC)
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
 by mx.groups.io with SMTP id smtpd.web10.401.1736536150184654806
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Jan 2025 11:09:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=wxP5czbE;
 spf=pass (domain: smile.fr, ip: 209.85.221.68, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-385deda28b3so1466235f8f.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 10 Jan 2025 11:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1736536148; x=1737140948; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zzfLq1OwDcWoNZX/DVu+nqKPp3FCVH+hwIFUFd6c74s=;
        b=wxP5czbESFqVniacu/OI7rZjQsSKD4bEe1UClzNnj1vu6RVpi7vYZtRAiv9K/h6tO0
         luw6WP0fogp9T7SfjUbks6YDfL4j0/8oe+HsMrZIWMmPgIsOG6ZsM5/3if/6QtLR76OH
         ueoURKn3/Lwat065nhW2FCGEfYElzLwbV52GY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736536148; x=1737140948;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zzfLq1OwDcWoNZX/DVu+nqKPp3FCVH+hwIFUFd6c74s=;
        b=S9TbXFFb5Fgo8JaEPU/VXgtpeR3liRXiqVo/j6Apst5Us8WcPB2gM5Yt+/8hBFQq+d
         ph6WViUTlcHN+HM8KNiGYJfCBKpuN1LpZfcqHtqWuKqbNiSITC8VoKPP5+wEP/+DbMch
         LWBBrp7EIo44Rhemsy8nIjroeJfzSwWaLAqFd20THXPXNDOL+SoQeNmhi1RUuLjIzIIr
         cn5PpTJuoKYxx/OSC3YUCu4mUsdMVgvuFeVeLSQrqU9J/MTR2AA30uOh071mJxzL/iFW
         THQJlNWwyfNvlXwje70SmyZmZGRqBdhrPeXfQcUT0sOtFKa3GZvvLBqazmKmk0d2ntjB
         F0tQ==
X-Gm-Message-State: AOJu0YyiUNHBAweRBwePljhvsRKlMH/ntG1LOgRHeBHEGgm+Cy4p5phM
	3n/VB4Vkdtk4pyZd1lpE79GlGPF1RVlnDJir7ZMks2W6EeON3SW99N8fhYZVlWPzqvXwD4iBa8z
	QPdtkAQ==
X-Gm-Gg: ASbGncvtYH6XSeBjdA4hL0Dx7wvT3VlEthsxjM2sKOMwqskYDNDEdGcmr2ggngZZ/dX
	WeFhhAz0QOqrphBu8ml3k1dP2tdX33KH2G/EjWJvBUQvR7ExvMtY6T1n2idY/BkRNaVAqfqwFnf
	KDxEC86ZBiM925jwKYSeoMceavKllk9W/Hsahf+biy2qXvrV3qSE9UeJWJiAO/yTopaHRhWlMOO
	ifuwp/J1B3+dJRcjgdhEOyRjQipAcwCmqoQUIrkKQZXNAz+wHpZBl7q50rQYr0qFdbaaE3gfzck
	nBe7vWiB82KQ2wg+IyNdax8dTXue/C5uHIsZ8j6SpJx91dDHbfyhHlBbAgggydY=
X-Google-Smtp-Source: AGHT+IE1zqAmmvr/BtAzK4oMV0YZXqa/tfrSu5fBpSnQeQ3A21oydoDLqiPqp0KTSyJ8YNgXpzC3ZQ==
X-Received: by 2002:a05:6000:1f81:b0:386:7fe:af8e with SMTP id ffacd0b85a97d-38a872fb17fmr9751272f8f.12.1736536147694;
        Fri, 10 Jan 2025 11:09:07 -0800 (PST)
Received: from P-ASN-ECS-830T8C3.home (2a01cb000deef000bdfc82d7e16362a9.ipv6.abo.wanadoo.fr. [2a01:cb00:dee:f000:bdfc:82d7:e163:62a9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4c1cf2sm5275443f8f.99.2025.01.10.11.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 11:09:07 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [PATCH 1/2] tests/parse: add test for ?= and ??= operators for variable flags
Date: Fri, 10 Jan 2025 20:08:41 +0100
Message-Id: <20250110190842.3861684-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 10 Jan 2025 19:09:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17008

From: Yoann Congal <yoann.congal@smile.fr>

Run the test with:
 $ bitbake-selftest bb.tests.parse.ParseTest.test_parse_defaulttest
.
----------------------------------------------------------------------
Ran 1 test in 0.001s

OK

This is a test case for [YOCTO #15685]

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/bb/tests/parse.py | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/lib/bb/tests/parse.py b/lib/bb/tests/parse.py
index 56eb66be9..8e04458a0 100644
--- a/lib/bb/tests/parse.py
+++ b/lib/bb/tests/parse.py
@@ -75,6 +75,29 @@ unset B[flag]
         self.assertEqual(d.getVarFlag("A","flag"), None)
         self.assertEqual(d.getVar("B"), "2")
 
+    defaulttest = """
+A = "set value"
+A ??= "default value"
+
+A[flag_set_vs_question] = "set flag"
+A[flag_set_vs_question] ?= "question flag"
+
+A[flag_set_vs_default] = "set flag"
+A[flag_set_vs_default] ??= "default flag"
+
+A[flag_question] ?= "question flag"
+
+A[flag_default] ??= "default flag"
+"""
+    def test_parse_defaulttest(self):
+        f = self.parsehelper(self.defaulttest)
+        d = bb.parse.handle(f.name, self.d)['']
+        self.assertEqual(d.getVar("A"), "set value")
+        self.assertEqual(d.getVarFlag("A","flag_set_vs_question"), "set flag")
+        self.assertEqual(d.getVarFlag("A","flag_set_vs_default"), "set flag")
+        self.assertEqual(d.getVarFlag("A","flag_question"), "question flag")
+        self.assertEqual(d.getVarFlag("A","flag_default"), "default flag")
+
     exporttest = """
 A = "a"
 export B = "b"

