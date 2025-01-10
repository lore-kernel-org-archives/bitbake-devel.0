Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CCAE7719D
	for <webhook@archiver.kernel.org>; Fri, 10 Jan 2025 22:57:12 +0000 (UTC)
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
 by mx.groups.io with SMTP id smtpd.web11.4542.1736549823491231268
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Jan 2025 14:57:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=drSvB+iH;
 spf=pass (domain: smile.fr, ip: 209.85.128.67, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-436345cc17bso19156305e9.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 10 Jan 2025 14:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1736549821; x=1737154621; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GPoFJwRTCPd0zFAjmtwhgmcJbD9PcocBdIXv9GmAyd0=;
        b=drSvB+iHof/VlIRy9B7vke0MsLKEtBQEgSa/aVIbiVWxEBuwvZajx4iDAuag80av1K
         LqkVBeWbel2YKZhA7R5MuQzIWV7csnugB0JsNDdKHQPFul1HnH6NkGhh5XGNKXr4tZUt
         ZroWwmTW0pKMvejA9MkN9SFHeJklsFGrcMl1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736549821; x=1737154621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GPoFJwRTCPd0zFAjmtwhgmcJbD9PcocBdIXv9GmAyd0=;
        b=miRN9KV/BS0TdGzjeVKIYsy1TGuFG60TzQ7sc5J8v/r9ueqf46wlFyHP9fQVJlGB5d
         9rdE9YeWZaokI9Ydl3h+/zJGy12f45+J8PJGPE32oZGBr42n1L4RUIp0gcrj+nkcNWf5
         jj0HlcsTUtRoWrKdPITpjliRd/7fXZOxKr5axzEpIOJ8THqkKBvpovICvsTAXZqHAnSY
         UwvXfK7kdRMa1p2FXMaZQUyMJmOkPmZSsSHW+ykIaKfXSMLJ5HErzPsH4enxRKNdSR4P
         oW33+kM5ldUHob0rKbd2tLmIuGYxDv+GnO8+T5zr0vUkI5tYukg7/LxxZxQq4B3RjNUu
         Vigg==
X-Gm-Message-State: AOJu0Yx2NNgMH3OSAC03OqD1tTd3UfvPGMpzJOgea1T+CrYd48L5TPVO
	sQjV6o6yLM6e4/EPeTXzbtMEQjsVnXEBQ0mw9bNcLiHXyJH26F4L52uVFQd40R/nMJL/XzgEmGk
	GvVn+gQ==
X-Gm-Gg: ASbGnctFEaOaHx5+iopIvoYROwXPElWBLSvjEXP5aXCgs1TBmdwgNf4w4Ll2CawpWIh
	GYRP5bsSkb9lCXDUe16xkU8aIDV1vUhr5lAVHjTFrIWXpatfCXGTh9v7rcmTzaTsDfLTS7aYfOK
	YY88dBttVQ9d0Obpv81366SBTHcVZ883gkAd4h9zf65MbS0+qwqxUbAMNi7zkAvKuVch88DKpN/
	A01mJKaXKQrXoZhNTl5/Wtw7yo4UedWmxDU4oinW/83fL1MKhEnIwqBsqN0JLFTeVIFy4YeuEqr
	3hP+SOQEANr//aXxPCi1uUEEoWJeVMHdMI74oBClLuIEDAAN681aSdgxsnqcNiY=
X-Google-Smtp-Source: AGHT+IElXGVdHeVgCRw9FsvWb4KqlYVyVhSOlDhZexyK+DzONG1OzEspX7O9/pO+e8XPyMfjGqypBw==
X-Received: by 2002:a05:600c:1987:b0:436:1aa6:b8ee with SMTP id 5b1f17b1804b1-436e2677378mr109333545e9.2.1736549821142;
        Fri, 10 Jan 2025 14:57:01 -0800 (PST)
Received: from P-ASN-ECS-830T8C3.home (2a01cb000deef000bdfc82d7e16362a9.ipv6.abo.wanadoo.fr. [2a01:cb00:dee:f000:bdfc:82d7:e163:62a9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2dc0f69sm98727805e9.13.2025.01.10.14.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 14:57:00 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Yoann Congal <yoann.congal@smile.fr>,
	=?UTF-8?q?Ghislain=20Mang=C3=A9?= <ghislain.mange@smile.fr>
Subject: [PATCH v2 1/2] tests/parse: add test for ?= and ??= operators for variable flags
Date: Fri, 10 Jan 2025 23:56:51 +0100
Message-Id: <20250110225652.3892828-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 10 Jan 2025 22:57:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17011

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
v1->v2:
* More comprehensive test cases with =, ?= and ??= combinations
---
 lib/bb/tests/parse.py | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/lib/bb/tests/parse.py b/lib/bb/tests/parse.py
index 56eb66be9..38c3e3253 100644
--- a/lib/bb/tests/parse.py
+++ b/lib/bb/tests/parse.py
@@ -75,6 +75,47 @@ unset B[flag]
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
+
     exporttest = """
 A = "a"
 export B = "b"

