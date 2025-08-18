Return-Path: <mohamedaymanworkspace2@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4B4CA0EE4
	for <webhook@archiver.kernel.org>; Mon, 18 Aug 2025 16:33:53 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web11.80199.1755534829591310168
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 18 Aug 2025 09:33:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Zesk/H1V;
 spf=pass (domain: gmail.com, ip: 209.85.128.42, mailfrom: mohamedaymanworkspace2@gmail.com)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45a1b04f8b5so21431835e9.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 18 Aug 2025 09:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755534828; x=1756139628; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h7ognQEhZIU8WDaS1JsI8k88HwHKFIxWxtu/HxsCgAw=;
        b=Zesk/H1V7fY6e4FOXhCbqsjaf+ZzLom7oLRL2Z+i2B9wp1Fj9ClSZD4tLGtnbVCAVi
         J8SVHkHn4kml88HSPN41UL0RYJvAIdrXE0vHREMLvpLINi7yE9aHei9SPwQO7AJVILDl
         HsbOMilUBqS7UEgqVuYU3iPviY7UFeEm5pOPkRUSJjC8W1GmTyAkHDYeN9azxW9h5zAi
         f0Vma7V5Ru25TOIBR4PeD4mCodl8wLb1WL42IoCVlzeUIunZ+YAiK4lmdvdJrmHuHnQK
         nTqSVo7eRjtLwqa1VpcwHwrVRq1074ZHGUD4z0dVkDhH9onZbSTdq88m28DnCXWwhmJH
         wCKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755534828; x=1756139628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h7ognQEhZIU8WDaS1JsI8k88HwHKFIxWxtu/HxsCgAw=;
        b=XUH5cqAtGeZxiJ5ZL03kAqxaH0si4Jau802bOJSJp91GqTtFqm1gOk0I25PsuQdQyg
         T5FSF0Sc8KnEIhgSv9fKBeyZWFJAcTMTMfB+YAzyEV5dDrmqNMEl4LTbJwe/pl+GZRlY
         hKwJc2SXj8Mh84b63+LlZ0TuO2Ol8ZII316Ld/E3xbJSxgznakK2rujCZ4FF34t3JXyC
         HZ6CFWO+TqFgcIFQqeS7Z729v+0XK0W3Lm6DCT7JOOQOEAOXbM1IafBpfGLWl/mEIBUy
         beAZbaCvm/o+tOYkxrTlR5tN7V+aoERB+c+wVW5TOtUgybokeSuKJv/zacUelPUPJYQy
         X8qg==
X-Gm-Message-State: AOJu0YyGdRnKX2Slm76skKO2X0bFxO5ABq5bUrRbXp0hf5+fC9HGQqXv
	zX/WU0iN8YBXMqs3ZXxM/tLt3Hx9HgjIGauAnWnDGgJK0hhtCHqLFTVFNSHcfIt7
X-Gm-Gg: ASbGnct/wIQnMB8Ya499ONpOeCt2uaiIkpnGL0mkxPbqkP4BW5BubJ+abQdfbREA8G5
	9VNB6fxOERdtuZdW9kay8YtuzxGwCo4xsCZGYQbsk34ToatVI6rAn2FvMX0wXANnKRcQDO3xMUj
	f2Hg4bMpvm6Tnp4LxdG/iyvqnj/p8vmX2SBCSXBXOhAC1wtQTqQmJ8AxqRLh/uFWbK+17mTjS4Z
	N8HyQ7w21OQbaLKuSGT4NdIMdrzxfeI1KmNHqCt6/keZ4Ux5avRG5o/ZfWgu0zTvPm9DrDRxHGC
	MAE37YCx+SgtuSyXR8DaJBDgNbby3CLEHvPeHK23zskIj0tJ6CV3PVH+geJPu1jrZ/5F5QmS/Gb
	RtH1clloXU504Bf4hl5AsdvCJpZ+qURFA83+EwQmSA3zk8Hw+E5E=
X-Google-Smtp-Source: AGHT+IGMMTRM1OqsRIkH7PejEgqe5RKN0nV77tillTu04pUHK8T75eZVfoc5TMPmrACrbRzTqPkmUg==
X-Received: by 2002:a05:600c:4f52:b0:459:df07:6db7 with SMTP id 5b1f17b1804b1-45a27b6f0c6mr60831175e9.6.1755534827571;
        Mon, 18 Aug 2025 09:33:47 -0700 (PDT)
Received: from ST.. ([196.221.32.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c773e57sm190286305e9.23.2025.08.18.09.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 09:33:47 -0700 (PDT)
From: Mohamed Ayman <mohamedaymanworkspace2@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Mohamed Ayman <mohamedaymanworkspace2@gmail.com>
Subject: [PATCH] doc: improve BitBake README testing instructions
Date: Mon, 18 Aug 2025 19:33:37 +0300
Message-Id: <20250818163337.3440-2-mohamedaymanworkspace2@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250818163337.3440-1-mohamedaymanworkspace2@gmail.com>
References: <20250818163337.3440-1-mohamedaymanworkspace2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 18 Aug 2025 16:33:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17882

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


