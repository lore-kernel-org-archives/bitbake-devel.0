Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A951E7719A
	for <webhook@archiver.kernel.org>; Sat, 11 Jan 2025 14:14:07 +0000 (UTC)
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
 by mx.groups.io with SMTP id smtpd.web11.15945.1736604845128186764
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 11 Jan 2025 06:14:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=oXOzTBV+;
 spf=pass (domain: smile.fr, ip: 209.85.128.66, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-436202dd730so21133575e9.2
        for <bitbake-devel@lists.openembedded.org>; Sat, 11 Jan 2025 06:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1736604843; x=1737209643; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/2BzqZlhbfPWjCX1OzRPzIVCtrZO+aHEgSzFS/QL+yY=;
        b=oXOzTBV+W/ulPMolgs+AOJPgD75PP6/5wzZI7x34w8FmKA7fN7kBjfZFpanVfDZ8Yr
         CETBsuVf6oT0aYWEPYZ5Az7WezwOGvzv/LlSch7tq5uzTiDMeqLiXb6gbe0HMsWhDtsv
         zm2wExvZcxmWwfsp3sCIVmr6ceMSaaqh8RGtE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736604843; x=1737209643;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/2BzqZlhbfPWjCX1OzRPzIVCtrZO+aHEgSzFS/QL+yY=;
        b=SwIM9nyMbH/+eYEtwxJG9P1Wjt3dJVwcXf1Ur4cyesPULgLOoQDC9wiGjER00ktRu2
         8s0qP4G2YLkamYbvCt99ufO7ovgt0BpILqCj8FtMH0Z3WEfjthXMGUs+CQ02Ih5BNoiH
         JrGuQCFsfrdK4IPcQKiCtYC0nqb0dMBsQvX/zOnW6TkQx6kMG6CGAQWdUIRb/CAO4xI5
         0Z+39WeiW6X1pb3f6iNzo2zJIebwkZoqSVMX/I9npad+kiHs6Ir2StpKE5Eud4K1Kjx/
         7PdmjhF7Rew7t0DcCv8ErU0i52oj4KFm4+wIo+/HP4PPVkvaQ3P2i7iG8iV4EgxWZv8o
         Nphw==
X-Gm-Message-State: AOJu0Yx9fmu2zVgRhRJTpim3d3ehMCk5mCHaxmscanzzd/qhpRUwb/3s
	tpqWGwTJEn9wU3SUO9mVnACZaOrP6NGD1OnQXq2s7VhR8CHWNbiq6tE9M3Jmpft03TozFc0GgSa
	ndXphSw==
X-Gm-Gg: ASbGncsxH75qfOIDvh61WPRfgy9r0ldtNNyWsLYGxYf/tJTNYTnwX8l8tvIlNtUyD7F
	vS1APUwDjrvaHty267dqQenvpirCg/vj5sb/vE4Z+4dEmb06XfPYYhL2QC+tm2WLhmQVT1A/8P1
	XhI8cKmlfoOEDYMP/mZE9vpKOf98KBRpnWH4m0JkeO0zEHR8NKxfOeWN6nyGP3WZ+v4Xv+Vp++z
	e39AbS30X+LvWj+IPPsvlq4F172IebtMgd304o/6T2CATTVJ6tv457RXpLGL/y+nW1y3jrur4zO
	q19sJr60lMjnUptwkW0Y9vz5fLOtTXj506xMZuq9BkOV7S+ZAkWbZ9eV+vnJRX4=
X-Google-Smtp-Source: AGHT+IHPiMr3gvc5sF/aSXy7j2srM0HXs29qrkFgFFhMzAiYx8Wwuxm2lpJrA1gAL2akDRF4Pe+fOQ==
X-Received: by 2002:a05:600c:3551:b0:434:effb:9f8a with SMTP id 5b1f17b1804b1-436e26b8be2mr144454175e9.15.1736604842692;
        Sat, 11 Jan 2025 06:14:02 -0800 (PST)
Received: from P-ASN-ECS-830T8C3.home (2a01cb000deef000bdfc82d7e16362a9.ipv6.abo.wanadoo.fr. [2a01:cb00:dee:f000:bdfc:82d7:e163:62a9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436f67192a1sm15110325e9.27.2025.01.11.06.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2025 06:14:02 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Yoann Congal <yoann.congal@smile.fr>,
	=?UTF-8?q?Ghislain=20Mang=C3=A9?= <ghislain.mange@smile.fr>
Subject: [PATCH v3 1/2] tests/parse: add test for ?= and ??= operators for variable flags
Date: Sat, 11 Jan 2025 15:13:50 +0100
Message-Id: <20250111141351.3993834-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 11 Jan 2025 14:14:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17015

From: Yoann Congal <yoann.congal@smile.fr>

Run the test with:
 $ bitbake-selftest bb.tests.parse.ParseTest.test_parse_defaulttest
.
----------------------------------------------------------------------
Ran 1 test in 0.001s

OK

This is a test case for [YOCTO #15685]

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
Reviewed-by: Ghislain Mangé <ghislain.mange@smile.fr>
---
V2->v3:
* Even more comprehensive test (same operator twice) suggested by Peter Kjellerstedt <peter.kjellerstedt@axis.com>
v1->v2:
* More comprehensive test cases with =, ?= and ??= combinations
---
 lib/bb/tests/parse.py | 53 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/lib/bb/tests/parse.py b/lib/bb/tests/parse.py
index 56eb66be9..935c85ac7 100644
--- a/lib/bb/tests/parse.py
+++ b/lib/bb/tests/parse.py
@@ -75,6 +75,59 @@ unset B[flag]
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
+
+A[flag_question_vs_default] ?= "question flag"
+A[flag_question_vs_default] ??= "default flag"
+
+A[flag_default_vs_question] ??= "default flag"
+A[flag_default_vs_question] ?= "question flag"
+
+A[flag_set_question_default] = "set flag"
+A[flag_set_question_default] ?= "question flag"
+A[flag_set_question_default] ??= "default flag"
+
+A[flag_set_default_question] = "set flag"
+A[flag_set_default_question] ??= "default flag"
+A[flag_set_default_question] ?= "question flag"
+
+A[flag_set_twice] = "set flag first"
+A[flag_set_twice] = "set flag second"
+
+A[flag_question_twice] ?= "question flag first"
+A[flag_question_twice] ?= "question flag second"
+
+A[flag_default_twice] ??= "default flag first"
+A[flag_default_twice] ??= "default flag second"
+"""
+    def test_parse_defaulttest(self):
+        f = self.parsehelper(self.defaulttest)
+        d = bb.parse.handle(f.name, self.d)['']
+        self.assertEqual(d.getVar("A"), "set value")
+        self.assertEqual(d.getVarFlag("A","flag_set_vs_question"), "set flag")
+        self.assertEqual(d.getVarFlag("A","flag_set_vs_default"), "set flag")
+        self.assertEqual(d.getVarFlag("A","flag_question"), "question flag")
+        self.assertEqual(d.getVarFlag("A","flag_default"), "default flag")
+        self.assertEqual(d.getVarFlag("A","flag_question_vs_default"), "question flag")
+        self.assertEqual(d.getVarFlag("A","flag_default_vs_question"), "question flag")
+        self.assertEqual(d.getVarFlag("A","flag_set_question_default"), "set flag")
+        self.assertEqual(d.getVarFlag("A","flag_set_default_question"), "set flag")
+        self.assertEqual(d.getVarFlag("A","flag_set_twice"), "set flag second")
+        self.assertEqual(d.getVarFlag("A","flag_question_twice"), "question flag first")
+        self.assertEqual(d.getVarFlag("A","flag_default_twice"), "default flag second")
+
     exporttest = """
 A = "a"
 export B = "b"

