Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0BF1C41513
	for <webhook@archiver.kernel.org>; Tue,  1 Aug 2023 14:38:20 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web10.14468.1690900696555260344
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 01 Aug 2023 07:38:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=OT6/CLF8;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3178fa77b27so4096260f8f.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 01 Aug 2023 07:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1690900695; x=1691505495;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6L4Ma5eNbezaBLNUb0LVCNsX9V3RtJTGEQhqHrzzU8Q=;
        b=OT6/CLF8c4EigcbbY6nMLGLIlcBmtEpHsdgK9IAlE43JYapno3PfitWAoIg237cqkV
         zbLgB9OlJ/jXo+lSBtDTpu1cL769+T747vv0F+dmyue5lj+7DkUj0hgNTbE2OdcLxECS
         cF0AzGSW8H4IyDFo6s9nzRFZA2xuWllLHO9gM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690900695; x=1691505495;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6L4Ma5eNbezaBLNUb0LVCNsX9V3RtJTGEQhqHrzzU8Q=;
        b=JXMet5vIhhdzUHCeHrgwPi0sXto9csvxP8OY3+NwNeuxDbMJM54EHr8xXXXuIG/B+F
         zHaX0Zo1zGvnuoWfJGAMAXY0RK2pzRC9nmRi81jbtYMgg+R6izA/j8n8SMEW++W2lQxH
         wJeRw0fx2ESFVIbpKM2NpfmgwIybyzFEMxiNKjmKaAL0EXFEYGZHhy+9gu9ni3vfJpkD
         uGfepMYWQhJrWGpBF0+Amr66F1dg5dmUuqx9LTpmhaqWfjjPL+bKHvym9hdQlXItnRHd
         5Bkz36W4CIiq6cFNIrHjQ5TqZ/lSq1rN9JAMZTYhj+dd8NhjwGBkUAYttS7E/rIUZtKE
         n+Zw==
X-Gm-Message-State: ABy/qLbP9rvhZ8g79MLhfqfNHOmYIgvg9K8mt1pl9r98/3T1Ziz9IISG
	Eek24XKC++lsfk+CDZjD0xRQYQsN0SMJ5uiKFaM=
X-Google-Smtp-Source: APBJJlHWljiX8fwotRPx9GWY7lFneFT0XaE8zrG1+JCzF8jr4WiUiaGUjCGDTWb9qNBSP7JEXUjpLA==
X-Received: by 2002:adf:e386:0:b0:313:f45f:74a1 with SMTP id e6-20020adfe386000000b00313f45f74a1mr2591303wrm.51.1690900694590;
        Tue, 01 Aug 2023 07:38:14 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:e3b7:1714:595d:8417])
        by smtp.gmail.com with ESMTPSA id d14-20020adff2ce000000b003176053506fsm12572887wrp.99.2023.08.01.07.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 07:38:14 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Cc: Christopher Larson <kergoth@gmail.com>
Subject: [PATCH 1/6] tests.data: add test for inline python calling a def'd function
Date: Tue,  1 Aug 2023 15:38:08 +0100
Message-Id: <20230801143813.2206785-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 01 Aug 2023 14:38:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14900

From: Christopher Larson <kergoth@gmail.com>

This is a test for an issue seen long ago, to avoid regressions, where a
reference to a def'd function in the metadata would return the string
value from the metadata rather than the function in inline python.

Signed-off-by: Christopher Larson <kergoth@gmail.com>
---
 lib/bb/tests/data.py | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/bb/tests/data.py b/lib/bb/tests/data.py
index 8c043b709d..251130b857 100644
--- a/lib/bb/tests/data.py
+++ b/lib/bb/tests/data.py
@@ -77,6 +77,15 @@ class DataExpansions(unittest.TestCase):
         val = self.d.expand("${@d.getVar('foo') + ' ${bar}'}")
         self.assertEqual(str(val), "value_of_foo value_of_bar")
 
+    def test_python_snippet_function_reference(self):
+        self.d.setVar("TESTVAL", "testvalue")
+        self.d.setVar("testfunc", 'd.getVar("TESTVAL")')
+        self.d.setVarFlag("testfunc", "func", "1")
+        context = bb.utils.get_context()
+        context["testfunc"] = lambda d: d.getVar("TESTVAL")
+        val = self.d.expand("${@testfunc(d)}")
+        self.assertEqual(str(val), "testvalue")
+
     def test_python_unexpanded(self):
         self.d.setVar("bar", "${unsetvar}")
         val = self.d.expand("${@d.getVar('foo') + ' ${bar}'}")
-- 
2.39.2


