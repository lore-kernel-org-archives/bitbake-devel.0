Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA35C04A94
	for <webhook@archiver.kernel.org>; Tue,  1 Aug 2023 14:38:20 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web10.14469.1690900697034593919
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 01 Aug 2023 07:38:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Tqhjpmvr;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-3fbef8ad9bbso62457825e9.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 01 Aug 2023 07:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1690900695; x=1691505495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+d0d6BT2DMb3OUYRdQrWTKOA4OBY2Q2pM2WyA5N52ao=;
        b=Tqhjpmvrz9mXH8R9M7lkrs9I/6ME4updYJGptxHE+RUnTjnkNgzhu+LOpIv67GVoEc
         /AYxoOeshYlmwX+2edCEYDdvhZ2mURTn/uc3dVwPlIordWPVcjpIpO3ZD5H0CQ+A1X8A
         /XgX5KDzJupVaTk3cRuQ5hdRq6eJETi19axKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690900695; x=1691505495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+d0d6BT2DMb3OUYRdQrWTKOA4OBY2Q2pM2WyA5N52ao=;
        b=TmN6MaJdQaN6jiRwMjRhU3tKfhMEna9uSTBPxNyQcaJEMbyymq57OxGMSThEchaM7/
         5GfJ1NMGKNzYTdNfCrqtxtRD6L/MjR+17DSs4M9an9Rc8zerCvu/TJDCfB+yNOs9Gs2y
         bhbE2XOP2OBQKQypSRJa3f2ofVrPGODKuQ1muovNycvoelysV/XlDz0ru9ofaLEKG4ET
         j1DlnekNnCJXQmVirlGuEH6rda33kbMq2izYsDS/hit095IulNDZvXDi7bX3W1zjq0px
         kc4cE+DPcNsIMKbWXe+RffHEigNfAHa+LbJP/hKndCZDKVbG5lfsuk2Qr7bHMT83KZXv
         tz2A==
X-Gm-Message-State: ABy/qLYvpDj0GHKxlm65p9xL2kXxxdpamamDBNQZ+RnFGkO8z3VZstdS
	VJbUGnZCfM0Gylse8d4ogkadcOgbO/6EOOkD+wU=
X-Google-Smtp-Source: APBJJlFKk84xV4wXR4q9OZJ5pAlI4854CKtf7VuKgHIYzW5A3qS833jUqWMMRz0pVEzHGVSLTlZLNg==
X-Received: by 2002:a5d:6611:0:b0:314:1fdc:796d with SMTP id n17-20020a5d6611000000b003141fdc796dmr2136318wru.70.1690900695370;
        Tue, 01 Aug 2023 07:38:15 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:e3b7:1714:595d:8417])
        by smtp.gmail.com with ESMTPSA id d14-20020adff2ce000000b003176053506fsm12572887wrp.99.2023.08.01.07.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 07:38:14 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Cc: Christopher Larson <kergoth@gmail.com>
Subject: [PATCH 2/6] tests.codeparser: add test for exec of builtin from inline python
Date: Tue,  1 Aug 2023 15:38:09 +0100
Message-Id: <20230801143813.2206785-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230801143813.2206785-1-richard.purdie@linuxfoundation.org>
References: <20230801143813.2206785-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 01 Aug 2023 14:38:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14901

From: Christopher Larson <kergoth@gmail.com>

This ensures that any change to the presence of builtins in inline
python execs will be noticed.

Signed-off-by: Christopher Larson <kergoth@gmail.com>
---
 lib/bb/tests/codeparser.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/bb/tests/codeparser.py b/lib/bb/tests/codeparser.py
index 7f5d59ca74..a64c614b0b 100644
--- a/lib/bb/tests/codeparser.py
+++ b/lib/bb/tests/codeparser.py
@@ -44,6 +44,7 @@ class VariableReferenceTest(ReferenceTest):
     def parseExpression(self, exp):
         parsedvar = self.d.expandWithRefs(exp, None)
         self.references = parsedvar.references
+        self.execs = parsedvar.execs
 
     def test_simple_reference(self):
         self.setEmptyVars(["FOO"])
@@ -61,6 +62,11 @@ class VariableReferenceTest(ReferenceTest):
         self.parseExpression("${@d.getVar('BAR') + 'foo'}")
         self.assertReferences(set(["BAR"]))
 
+    def test_python_exec_reference(self):
+        self.parseExpression("${@eval('3 * 5')}")
+        self.assertReferences(set())
+        self.assertExecs(set(["eval"]))
+
 class ShellReferenceTest(ReferenceTest):
 
     def parseExpression(self, exp):
-- 
2.39.2


