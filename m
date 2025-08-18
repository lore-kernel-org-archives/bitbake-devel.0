Return-Path: <mohamedaymanworkspace2@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED598CA0ED1
	for <webhook@archiver.kernel.org>; Mon, 18 Aug 2025 16:08:58 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web11.79494.1755533334024817182
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 18 Aug 2025 09:08:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=JRwWkgQm;
 spf=pass (domain: gmail.com, ip: 209.85.128.42, mailfrom: mohamedaymanworkspace2@gmail.com)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45a1b00797dso27811285e9.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 18 Aug 2025 09:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755533332; x=1756138132; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h7ognQEhZIU8WDaS1JsI8k88HwHKFIxWxtu/HxsCgAw=;
        b=JRwWkgQm0CB5S7X/QVRH9MJm18lPqm9xyKkJX2RJM9XzxzsngIQ+gWuhVBH7oYcSuL
         dT66wSRMUPHCYTw3jKgjzVRTiYsNKs3OStYL6Un5KsZxMHbIOoduhng5AYwrS0M+2p1H
         iJV8lat+XI5FkRxOdmKqkHz53TPLeS6cdoYc2CZfNvBAVhtMzKRFzEGlD4RGUKFwp0JP
         CkdDsLqhTyrlSKX2GAx94+WX2vpZdqMHYJt+tv4iV4GmiL8EBippDwktvNhxCbRCASkd
         IO8/NI5AunCM57fYq8scmBIpSjXohztw1kXnEb+Gi/e6npdDyzhlmno4FjoqTUjUGeOa
         pMzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755533332; x=1756138132;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h7ognQEhZIU8WDaS1JsI8k88HwHKFIxWxtu/HxsCgAw=;
        b=euqlxfJvCcsJqELsfFbCTCU0dLrKcDFX2L0CzdY/zBR+vu110sbpBuVc8xgCLffjv9
         VgNhtyWZqCJ0304r2dVW7kFVWzT77EFG0S9eTq0nBwSMQG9gqkCgX9JD/v/3etR8yifu
         P29V5hN3l8uQp9yXVKeFjC7B/AOQXuyvwCYtav6UehZhRM+Kym85X8GdsRekbIS7+ZTK
         Y0ZavV8Jr2UeK4DocGfneJPYG2ADGRl/x+2wq3HzWiWHsafXJKcB1QchPV4hB1ZaH57A
         o/gMBKs9YiJ2LKF+nSJD9UebBtayHYWrynpf4bww9pgPY123hEb5kdspeGioKxDzX4if
         WW8Q==
X-Gm-Message-State: AOJu0YxZratkAXWrl7yeNCkuHk084Z6t0Y48Eb/iME62qejYLsFugtTI
	GLGJxDnmLRsGCtClf/zoKDAZmOmMpOQ+sMzKfWOf8rH1jN6bZmpFNxAHlMzoTFJA
X-Gm-Gg: ASbGncvu6sbktTCNfxyeLY8qmggai0+vPwPzOPaASySxRZNuW8ofnmfFyKy3zxfQ57N
	Z8Ph0AX3shNJmz+U2jN60nIIshSeErG5EWhYeBNrdWXFkK3T4CaftxwssgeKVgxOIK93aV3VK8O
	nWd/ozGSrz9/XR6N7rGu1iPTTFwJbA/oLJtAqEMtT4nPrYhUX/zA3JmjewOxnpEJqcalIhJMzNt
	xdD+9vg9NnbKM5My5OH6n0v3avSqlXrP+BMw9qF5XIQ6/bbdkg4p9jh3hXgU0yT0Qr08qe3M0KV
	YbLds5tNL8YdmQdj6oHiMnf+G9yImpYDL1bT1iYxWDO3mUQ+QFtp5tZirABj1+AqdbC3ap1N76Q
	r4CP5Vxx6lOTtCQvjP5aNaTdSOEb09LFRDP4AxBn5avNpAdQTE+I=
X-Google-Smtp-Source: AGHT+IFSwMcZfi1wz0S7S43PGnQRassOr9dR0C0z36SnXNBL0jIr6c0m4dZED7ea2+OeZnO0wBU8BQ==
X-Received: by 2002:a05:600c:4f4f:b0:456:1c4a:82b2 with SMTP id 5b1f17b1804b1-45a3eb1e774mr67261285e9.10.1755533332022;
        Mon, 18 Aug 2025 09:08:52 -0700 (PDT)
Received: from ST.. ([196.221.32.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c76e9basm185571505e9.21.2025.08.18.09.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 09:08:51 -0700 (PDT)
From: Mohamed Ayman <mohamedaymanworkspace2@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Mohamed Ayman <mohamedaymanworkspace2@gmail.com>
Subject: [PATCH] doc: improve BitBake README testing instructions
Date: Mon, 18 Aug 2025 19:08:35 +0300
Message-Id: <20250818160836.3102-1-mohamedaymanworkspace2@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 18 Aug 2025 16:08:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17879

Clarified the testing section by:
- Adding context on setting PATH before running selftests
- Documenting how to install pytest using pip
- Providing an example command for running pytest on lib/bb/tests

These additions make it easier for new contributors to run the
testsuite and ensure consistent testing practices.

Signed-off-by: Mohamed Ayman <mohamedaymanworkspace2@gmail.com>
---
 bitbake/README | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/bitbake/README b/bitbake/README
index e9f4c858ee..938eec47ce 100644
--- a/bitbake/README
+++ b/bitbake/README
@@ -54,10 +54,17 @@ The assumption is made that this testsuite is run from an initialized OpenEmbedd
 environment (i.e. `source oe-init-build-env` is used). If this is not the case, run the
 testsuite as follows:
 
+# ensure local tools are on PATH and run the selftest script
     export PATH=$(pwd)/bin:$PATH
     bin/bitbake-selftest
 
 The testsuite can alternatively be executed using pytest, e.g. obtained from PyPI (in this
 case, the PATH is configured automatically):
 
+# install pytest into a virtualenv or pipx (recommended)
+python -m pip install --user pytest
+
+# run tests (example)
+python -m pytest lib/bb/tests -q
+
     pytest
-- 
2.34.1


