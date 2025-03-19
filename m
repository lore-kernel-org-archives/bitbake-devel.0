Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19EAC35FFF
	for <webhook@archiver.kernel.org>; Wed, 19 Mar 2025 11:41:40 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web10.5572.1742384494305591676
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 Mar 2025 04:41:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Mm3fHFYe;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43d0782d787so30811365e9.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 19 Mar 2025 04:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1742384492; x=1742989292; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=TzWDbenpM7FCwoj8JwN3WUKgeZUFvQvIeWXd9nEm4ag=;
        b=Mm3fHFYeXpNEGDOqZZSaqdolqEV1QgcJaoIxUN8sTUnbOFblGZ4NexRN10hx1qMOWy
         5k7H2Fl9NWv6sXbTVhPwNntMRdxtl4mt+mLuXzM8X15xblwkIkCPDVCLNu/ZZLzy6cqX
         E4Ne+J0M7Oxq9rPIm6fT84n2k9HkHVuNFcmNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742384492; x=1742989292;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TzWDbenpM7FCwoj8JwN3WUKgeZUFvQvIeWXd9nEm4ag=;
        b=VoIOkDzZwqcqLQUTcTIMVf+GJKdeZoizYu0r8vLIEcn66/PiTfKv5r42UNxm3qSKma
         kpVAbc7JGzpZ1og0+cIDz8CLb1nZv8GX7zwFSZss56KhRDij0t+j5zssWK5Mg6HEqiye
         BoWfGMCFuySbokyTENzRM2oVuHbCqRgf6gqpepZtSzuV9XvVr5oqjO6kVNh5RZH9MYRg
         sLmW1l13EuKVi81n98Nqx8Z7CaqJVw+Rrgt37upbSDtvh56ySlGFmq0rm2S37YhH5E59
         vn9Yz4BzYkijtiULXyzCpFnOegxBs80LtPX4gRkQiHH4GjtgiubuRgIBdAKUXShyZQC4
         gtZg==
X-Gm-Message-State: AOJu0YxOQb0rF4cXOyXIuoHjqz7pLs6zxYz8lfRvWnmQQi5czPmTtKHS
	0mfDmS+4L/1eZLHEv+VXPE6rXeJeDAgKauUJHSh6X3mtGu1K58KZJ0ibW3QiEWzFoSzL4A67MVp
	J
X-Gm-Gg: ASbGncs280DCNPXJat7yyYZ+abDKZgB8bWEkVYvEqHhxlmm8jASLbWZ5swBWCe1UTb3
	M9ORReGnwx/+QQd9WK0DTdzndav/E7cbkH2ADm9Jr+WpXNzPB34FbO2a+VN94MdSADRA+DAkZQM
	DLi4LsRQ8CjUkchWYGpq+2WCX2ab/+5fLulnsMxhiRoP8BuCdhWWav5enaMmPezgmxWrMl09xr0
	K/0xiRIC5rAv2kM50USeviQPpoVbcjYOu8atxS9oTHNraVgPdvgprKy/1q4NMHl0Ia2iB60wZjl
	0m5zXYDukdmKb+H4TpkfmbI8fNhgUSFMmTFiGd5rdM1vSaPYPQU0qOJpOE+Ah3B367MVsapd
X-Google-Smtp-Source: AGHT+IFVmrQAoi0Flpq4gfioBKgq9llZJnUfJhWT3c+J1JS8Arx+JhxdXBJALFSiobou/e6DKr06wQ==
X-Received: by 2002:a05:600c:19d2:b0:43c:ef55:f1e8 with SMTP id 5b1f17b1804b1-43d43798a14mr18256625e9.13.1742384492102;
        Wed, 19 Mar 2025 04:41:32 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:dad:b471:9c34:4577])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f58a66sm16414165e9.20.2025.03.19.04.41.30
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 04:41:30 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH v2] tests/fetch: Fix typo in npm test
Date: Wed, 19 Mar 2025 11:41:29 +0000
Message-ID: <20250319114129.631226-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 19 Mar 2025 11:41:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17465

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/tests/fetch.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 441b3f8236..8fa870c8a1 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -2815,7 +2815,7 @@ class NPMTest(FetcherTest):
     @skipIfNoNetwork()
     def test_npm_version_latest(self):
         url = ['npm://registry.npmjs.org;package=@savoirfairelinux/node-server-example;version=latest']
-        fetcher = bb.fetch.Fetch(urls, self.d)
+        fetcher = bb.fetch.Fetch(url, self.d)
         fetcher.download()
         fetcher.unpack(self.unpackdir)
         unpackdir = os.path.join(self.unpackdir, 'npm')

