Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EAA3C35276
	for <webhook@archiver.kernel.org>; Mon,  4 Apr 2022 18:46:41 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web12.21492.1648981308558317896
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 03 Apr 2022 03:21:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=TRFVEjBH;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.49,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f49.google.com with SMTP id r7so4201434wmq.2
        for <bitbake-devel@lists.openembedded.org>;
 Sun, 03 Apr 2022 03:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=362KOpTFDMmRiPsNMCGrH25RehV/7miKSBWP3lo1b4s=;
        b=TRFVEjBHcGIjb5+oxMMzYew+nPWE4G1c7kBm3NFtuxE7hsVkcbxi51eAbSs4b1+wnG
         pBnBXU8+JX+mpIL2J1+c3SaJa+xR9hvuHeLL5c7Xc2+lgVXuAu4zWMdoWaeILLXksrD9
         WibKmXLSiVV4OF1IY+6RVSGXJ9IcXn6CpJmTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=362KOpTFDMmRiPsNMCGrH25RehV/7miKSBWP3lo1b4s=;
        b=12ElWlYsDQdpHSSnQRxnVTNZw1HC9WC06TkROFHJR5w+VNQKmyyW2hm+sKmw9ZJboq
         EH47Sypes1Wip8HQp6fMHiPdI4PnMjhRlBUs+1beqz6e3il3o7i9xrI+EOoHiE4TxyyU
         mW3ccLUOFxabI9z/DbDZ+wXfR8WHU6sLhpVFFtofYInuO9hapBpQjLazA8BuBXs3ywZm
         IZhaYp0wXbAJlkIbn1eOE2z4wsFhTKZqEoPEuvfZ3mYR+zRny9QIS0CFwD1fIBpAq5Z0
         Q7n6knPxM9XQEpj/+N5moRBDbjHh9Quv1TPXK8dUj91m09FIwr81Tun+i0H2YLSzyuwm
         5Q7w==
X-Gm-Message-State: AOAM531cdzSbtnEl5XI0BNb29S7P2DxFn6tCs2n33NLQ5MBXY6eLgwZV
	zLDHcZ0xlDOBB3t7g6gl8porKADwLC8IrgQn
X-Google-Smtp-Source: 
 ABdhPJzFMb8hTiPxKYfgBX8m6DR9moGkPEtw8OyAn/yNPn81m+e2/9ndEpY5AAdH7FvFn+JJ8MfOkQ==
X-Received: by 2002:a05:600c:213:b0:38e:6379:af70 with SMTP id
 19-20020a05600c021300b0038e6379af70mr5078278wmi.157.1648981306633;
        Sun, 03 Apr 2022 03:21:46 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:819:f853:3436:28c4])
        by smtp.gmail.com with ESMTPSA id
 z3-20020a1cf403000000b0037d1f4a2201sm6327981wma.21.2022.04.03.03.21.45
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 03:21:45 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/5] parse: Ensure any existing siggen is closed down first
Date: Sun,  3 Apr 2022 11:21:40 +0100
Message-Id: <20220403102144.1679700-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 04 Apr 2022 18:46:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13571

We're still seeing issues with unclosed asyncio event loops. At the
init site, make sure any existing one is closed first to try and avoid
this.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/parse/__init__.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/parse/__init__.py b/lib/bb/parse/__init__.py
index c01807ba87..347609513b 100644
--- a/lib/bb/parse/__init__.py
+++ b/lib/bb/parse/__init__.py
@@ -113,6 +113,8 @@ def init(fn, data):
             return h['init'](data)
 
 def init_parser(d):
+    if hasattr(bb.parse, "siggen"):
+        bb.parse.siggen.exit()
     bb.parse.siggen = bb.siggen.init(d)
 
 def resolve_file(fn, d):
-- 
2.32.0


