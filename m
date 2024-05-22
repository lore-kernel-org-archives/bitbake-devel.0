Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3AFC25B78
	for <webhook@archiver.kernel.org>; Wed, 22 May 2024 15:46:35 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web10.785.1716392794558437679
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 22 May 2024 08:46:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=UzTbpdRv;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4200ee78e56so9179455e9.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 22 May 2024 08:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1716392793; x=1716997593; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0fDASkxzmByHBq+TmRTQm+sCzjsoKYxKi84Gs2r0GFo=;
        b=UzTbpdRvm1snSQHzdYnN+9ooigwkr+3fBvSqrfyvBvVHzd8bdxeYs7skLztP5jlcCv
         NPYiQsuU49IoPDzcMsC04X5fnc+gR4YkRJvbhLTITkQuqzn1K/IqgQ+sJ+BAkJFBrzwO
         hi01+eo0sOy5N3y5qveUKLE0r0Gbg+wY4isNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716392793; x=1716997593;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0fDASkxzmByHBq+TmRTQm+sCzjsoKYxKi84Gs2r0GFo=;
        b=nmQw43jY1pD3e7OYYrYpv6nlKqUyLsSIanCr/ENKWv8aPpRMDlWHzV7K2p2NZ2CTrW
         MPYvkuDkqr/ZHDbnC7e9ytM7XPYhfl+DWNVKdnqMZRvpcyazc66/0YJreoH3JhHfYiP1
         S5yoRH5ySZmRLYcpiDaoWCFxiihRO+PomoFwqNTU2DhBC8bqN0rNEhfxJJzDGRHJaPvj
         rFWarA6x95YFb3sVgAcFAknFN9v89WBpMSljUFSfsegkY4azUHD5DCWg/H2TPxKRecQk
         txi3pTvdiJEA6GEdXPqEKf9g9Ia5cxSg/gFh8UF2k5CsvPiQQFnJEfb8XtwvFCPdMBbv
         oeMg==
X-Gm-Message-State: AOJu0YwVw+E5XN4g1aUkTTouC1+mMwwqYaHanOP8zYN/gqpWuJasV9ZV
	Z07NXq60jBFXGmkNoA7mSD7DE4bmsQDXQvyGwUJKz9wESIyvO23bPZEL8idHMXb3Gh2PHdTAN3t
	xjxA=
X-Google-Smtp-Source: AGHT+IHvuEfJn6p+ktP2pA0n3ROZkiZg5pQN3avkeh/P86oDdRdgHWqzDBkjxef4yPHbTXnc3pGSig==
X-Received: by 2002:a05:600c:3b16:b0:41f:e959:9053 with SMTP id 5b1f17b1804b1-4210032278cmr2918645e9.38.1716392792665;
        Wed, 22 May 2024 08:46:32 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:ef1c:155d:9d8e:11ce])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccbe8fa6sm503913825e9.2.2024.05.22.08.46.32
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 08:46:32 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] fetch/npmsw: The fetcher shouldn't have any knowledge of S
Date: Wed, 22 May 2024 16:46:31 +0100
Message-Id: <20240522154631.2212924-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 22 May 2024 15:46:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16240

I don't know why there is hardcoded knowledge of S in the fetcher but there
shouldn't be and the OE unpack changes highlight this doing things it
shouldn't.

Drop the S reference and use rootdir which is the only place it should
be touching.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/npmsw.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/npmsw.py b/lib/bb/fetch2/npmsw.py
index ff5f8dc755..b55e885d7b 100644
--- a/lib/bb/fetch2/npmsw.py
+++ b/lib/bb/fetch2/npmsw.py
@@ -268,7 +268,7 @@ class NpmShrinkWrap(FetchMethod):
 
     def unpack(self, ud, rootdir, d):
         """Unpack the downloaded dependencies"""
-        destdir = d.getVar("S")
+        destdir = rootdir
         destsuffix = ud.parm.get("destsuffix")
         if destsuffix:
             destdir = os.path.join(rootdir, destsuffix)
-- 
2.40.1


