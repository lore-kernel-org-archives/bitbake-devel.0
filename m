Return-Path: <andre.draszik@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884F4C54766
	for <webhook@archiver.kernel.org>; Mon, 19 Feb 2024 09:55:10 +0000 (UTC)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
 by mx.groups.io with SMTP id smtpd.web11.38342.1708336509320740896
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 19 Feb 2024 01:55:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=q4CeUPgx;
 spf=pass (domain: linaro.org, ip: 209.85.208.54, mailfrom: andre.draszik@linaro.org)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-563c403719cso3972480a12.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 19 Feb 2024 01:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708336508; x=1708941308; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cLuMwH/ZxvXi9DjEmiKpIdK2asOJ1vwq7qd2hGWUoT8=;
        b=q4CeUPgxY4MTBj8WGKSzuYHtLt75bzbWxQPtujMhY12z+nnSaUQzK7yCbrrnJMGswK
         qXJD52wETmDW5SQtmWxX5ECpycuZs2AiP3aLLxoj1k6nxKBQZFRp/erzlBkul4kO8gnm
         c6o4W+lZ/B87ady9NLR1PDFf2/CRAFoFX17X0WwJo1nuvWVC3Gp4kTZ8+RK8dScAVHPP
         H9reKUIyXJ5Doi2eTlOtExsKIY/DfHXXBJJheD2dUuxQB0Uyf5cHem3lBEUt2WmKwfAV
         gwuCIWmbHMGDXF0rx+abyXltnPMjLv5x9lKpgdYAToUklwopzFov5pC+Q7P1lJTl2zYS
         jY3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708336508; x=1708941308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cLuMwH/ZxvXi9DjEmiKpIdK2asOJ1vwq7qd2hGWUoT8=;
        b=FRcGMhpQKvrHE61lQQ11cwO8mCUgUhgGAF72Vv5jB5IZZ+xqwxIYRfGnWBI0AxBow+
         NnyJaLqwHeevRh5mPiNTU3OZWlXTpQXAPW7jBJOgZSmxyyiuKY1SOZ5YDLRiahlusocR
         Kti63w/8CXMCPb7cgT1DqGuYooEg7pQV+Rn5/CCibdVjCuyKFlhmQi8NVivQLmDna37g
         qTajZ467oN/Q3csEX626Ug5giau7/SBABt0DGdSuAlX6TQ87g8vtj0Jxih1Fx+J7sXF3
         oN+U0sWXA6/7f+ns/XaJYq/e2mIImURF/b+Jn25fPm5ELcQ4WLGfbw4Yw6hcPGmCuWMz
         2evQ==
X-Gm-Message-State: AOJu0Yzfgzoryw/p4Q5yDMVXyqoHyNABw/F3Dv7PRlsAzWi2WrdKTRhg
	kftih09d4p46Qp/VD+CkW+aZQkcAy0psJXpvRwztpgR0OL5F2gmL8T3ldwXIv0havQq0vxNdA92
	pB+A=
X-Google-Smtp-Source: AGHT+IHl+ZgOLSkszBm8rGa4mszXXXlVTqjkBlCQfRpA613F0khsUcjdXT3ytJeP3zRKUBZn6nYbbg==
X-Received: by 2002:aa7:ca52:0:b0:563:ea79:fccd with SMTP id j18-20020aa7ca52000000b00563ea79fccdmr5947132edt.11.1708336507841;
        Mon, 19 Feb 2024 01:55:07 -0800 (PST)
Received: from puffmais.c.googlers.com.com (94.189.141.34.bc.googleusercontent.com. [34.141.189.94])
        by smtp.gmail.com with ESMTPSA id y11-20020a50e60b000000b00563d03030e8sm2527526edm.55.2024.02.19.01.55.07
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 01:55:07 -0800 (PST)
From: =?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][PATCH 2/3] tests/fetch: support git's safe.bareRepository
Date: Mon, 19 Feb 2024 09:52:13 +0000
Message-ID: <20240219095454.3211974-3-andre.draszik@linaro.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
In-Reply-To: <20240219095454.3211974-1-andre.draszik@linaro.org>
References: <20240219095454.3211974-1-andre.draszik@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 19 Feb 2024 09:55:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15937

When git is configured with safe.bareRepository=explicit [1], the
bitbake selftests fail miserably. LWN has an article about the
problem that this configuration option addresses and why it is useful
in [2].

It also seems that it is being rolled out in some environments as a
default for users.

In order to allow having this configuration turned on for a user's
environment in general, the fetcher has to be tought to use --git-dir=
for all relevent git operations.

The alternative, implemented here, is to forcibly turn off that option
for all git operations. In the future, we could look into converting
these to using the --git-dir= command line argument instead.

Link: https://git.kernel.org/pub/scm/git/git.git/tree/Documentation/config/safe.txt#n1 [1]
Link: https://lwn.net/Articles/892755/ [2]
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 bitbake/lib/bb/tests/fetch.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
index 41e1d8cf107c..bb30ed651313 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -416,9 +416,9 @@ class FetcherTest(unittest.TestCase):
 
     def git(self, cmd, cwd=None):
         if isinstance(cmd, str):
-            cmd = 'git ' + cmd
+            cmd = 'git -c safe.bareRepository=all ' + cmd
         else:
-            cmd = ['git'] + cmd
+            cmd = ['git', '-c', 'safe.bareRepository=all'] + cmd
         if cwd is None:
             cwd = self.gitdir
         return bb.process.run(cmd, cwd=cwd)[0]
-- 
2.44.0.rc0.258.g7320e95886-goog


