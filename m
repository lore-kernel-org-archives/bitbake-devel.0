Return-Path: <mohamedaymanworkspace2@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FEFCA0EE4
	for <webhook@archiver.kernel.org>; Mon, 18 Aug 2025 16:09:18 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web10.79615.1755533348580399895
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 18 Aug 2025 09:09:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=c0MYk41R;
 spf=pass (domain: gmail.com, ip: 209.85.128.53, mailfrom: mohamedaymanworkspace2@gmail.com)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45a1b05d252so29822455e9.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 18 Aug 2025 09:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755533346; x=1756138146; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h7ognQEhZIU8WDaS1JsI8k88HwHKFIxWxtu/HxsCgAw=;
        b=c0MYk41RVpUJVK1Gl46KtAovtnyKPb3myhSkGNsH8G4cEm7nVcx3/UKyXNq0+z4HqA
         u0pS12GCkdc76qBcikH4t3KERmS59ILlqOonIXQbd7u1esxeE2TInsMvR6j5L32wnuF/
         tmTF2T2nStZPLSSnY5YmaN66qNtQKUBX9/VBWQGTd2Nu8FAgBTzZgXkIa2VLJt3fRXWl
         VpU/cIAWOim0SxMZF0m5niFLoOGEl81EBCR8luMvWpEjdpbQFCsC+uSvyCJhLb2kvuep
         Ud7PLjo4IHGMWLpxH7ur7JoChdDLmA9p3TpROA+YQa0LC6pgL/TYjDmAVXdigsCi+ib5
         W7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755533346; x=1756138146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h7ognQEhZIU8WDaS1JsI8k88HwHKFIxWxtu/HxsCgAw=;
        b=jeRMK9NEIyvhf2OFcVOFADCs/+Gp9c5zCg4tx5AQZ1u1KhmeV0ifJz19fQinq8h76e
         RDjYoj9q3c+jrMd9ubC3Zmx5/W0aOih5F1skhLzCiacs6lRNVVwpQO+SA7+8xpRWl807
         JavnoFahB+0YHUwB1Ytr8+CZ5VZ3uU6zzrYZVDkpQlh1gfq7NTrlxfSYwGs4xARZ42Ry
         a9X5UjB9R3QaGob2TNBmYXbBZP4p6Meci6rHzs4Lw1mNq1Dz8/w05ev+KFFCq1VMQMDP
         jy/y8lg/9o0YbGiuwJwMjfyzdTKSeEKskUuEOy04bdooFbWytmb1SNSjcRQCE0TvtaAT
         ++rA==
X-Gm-Message-State: AOJu0YyIVsjg4U0Fo5NLKs4PLKm+f5vMLqjDgpuIwF/Dpne46RkCh7vY
	jN1IjRQ6cnFM7vClEJYhYoRHK6L5ErhaIs9hYWtYiBk8Mdlh6JEI/UmDeRrc2Osz
X-Gm-Gg: ASbGncuwCJKFf3oP+W3Ia7T3skQkRwlFliCT83heN/HqmLPZy2qWigyUF6H1GZhWCT3
	xIX31ZM0mY0aR4dgRaekwTDnlrw9ahNGt5nJU5S7SCMU84bWjhI3rY/tnVIxSeyqM5SxV7+NAxR
	EFHvvkpxMCc5K1u0ShkbzKxyj75uHCV83e9OY/BtHxkD7YL530Cn2JsZbjQn1Cfa8crUxc6KTTK
	viS+yHhR3fr0nLxeNIUSfBgyC+RyTi3JZaEirJLajZySk1XZV2tz/Ws7WjRVh6x97W41xRA10Fi
	ijnh6QluJBSAG1e4ivijIQzdbdtKDJyx1ODRIbh2H+JRcfJnoIW13XLCqCt2Ee+4zA19oOwTwgn
	VRtKwQwFPDVnaZ7m3ih82Cbu0yI0CPSfUyXBSLXW+NECXq6W+7n0=
X-Google-Smtp-Source: AGHT+IGcyq76k/siIOXmEvuJ8eAGTzzeGObS7QqyQD4mZUTkuhTHHKzSSnIq87KnNOVtKLOEvdyegA==
X-Received: by 2002:a05:600c:1c81:b0:459:d3ce:2cbd with SMTP id 5b1f17b1804b1-45a21803fb3mr95190395e9.13.1755533346402;
        Mon, 18 Aug 2025 09:09:06 -0700 (PDT)
Received: from ST.. ([196.221.32.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c76e9basm185571505e9.21.2025.08.18.09.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 09:09:06 -0700 (PDT)
From: Mohamed Ayman <mohamedaymanworkspace2@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Mohamed Ayman <mohamedaymanworkspace2@gmail.com>
Subject: [PATCH] doc: improve BitBake README testing instructions
Date: Mon, 18 Aug 2025 19:08:36 +0300
Message-Id: <20250818160836.3102-2-mohamedaymanworkspace2@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250818160836.3102-1-mohamedaymanworkspace2@gmail.com>
References: <20250818160836.3102-1-mohamedaymanworkspace2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 18 Aug 2025 16:09:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17880

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


