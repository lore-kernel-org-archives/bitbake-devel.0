Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9EFF364D2
	for <webhook@archiver.kernel.org>; Thu,  9 Apr 2026 22:49:56 +0000 (UTC)
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.144470.1775774988246274123
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Apr 2026 15:49:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=YZuEKcCS;
 spf=pass (domain: smile.fr, ip: 209.85.128.66, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso20240855e9.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 09 Apr 2026 15:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1775774986; x=1776379786; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+OGfQsZ47CujHWeRw0X9cbwNxshU2GdsZ4GTtnXbgHk=;
        b=YZuEKcCS2n5pw1MEiiPBGlUeAcZq+r+Oa2wBAzh4uGu65upz+bDcuLn3PewNn59+Qu
         BDgavzTzWQUVBux1CR+qKAqvz+hVyeNI+FQD7hZC64hrBY9z3wOK/+/mlm3pB20IX7Mx
         w7jBvgnOQ5G7NhCAuiuP7KU97DVfuTYgBRW6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775774986; x=1776379786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+OGfQsZ47CujHWeRw0X9cbwNxshU2GdsZ4GTtnXbgHk=;
        b=sv5oV/UYdigHAKpjqs5T69qO4D7QCCVjBmrhXwCtiPeVQsj0Q2xz+reK+TAjHyjuUV
         uLGEpR0umCAIDZ6Eb//ERk+TaDUKf1PRpfDHhiMAx7xBspffEUKEpZ5x9uG0tfeZQfRg
         OO09aXfPhvkTyTPdCUYk+fJpIQvaxjQHZEZBh/cnNSfzhqGLYq+K824awxkIRXt85aVB
         DUO2E1bHacE4TdwAijwwuVGLjVQ7+J5JgpgU8s7oSzgUBVjXtL/cHAeybMGt2IWTa2fI
         p06hiUjqxqXaEG68ImJg3134RteW75rXWHFQJwWlxfn9Ox1e/npVquNpsMZ8YoKb1s7s
         Fnrw==
X-Gm-Message-State: AOJu0YzWAm2aBU4yG4zHnKtTZLxZn0O4GCQcL30ec2Vq08iWhbM54fzk
	J5Wmx8rlrhdcJCzRAYrN5dNrp8XhRsODatP14QIJ3i652pvfUHQK8r19aRh00kxdfCoNAE9wHhi
	6r+lnphnTHXEQ
X-Gm-Gg: AeBDieuWJ3c5DB4hKY9H2NTjU4ilcFW2HiBUDOuhhwU2kRe8S7+7+ysNDtLzn6jViHO
	T+FGC4GXM3zT/QDGptokCZ40DvIvjTFxOSV4Apz789AgdwTHQLmn7BAoqJEkyv+o8/y3mcU98c2
	yX0wCBQs02RMaFu9cptvFg7YqTpXBgBBuyKXY6Q/WtD9L5Kq2p5fpYRKQ/FcDr/Wn0Q0ZtXTsZy
	VgNzMj+ZcKLFHMoOfxb3ZwIuNi2pbcMKExyWevq9LziGzxvt51MiEpoCWb4i9AA2xGVWvE0t1nl
	pTTmOQKPgwUPVjzpGLPX1XXSenDcW/mLoEaC+aDgLon3+unRrcAomS+5/sSLVO0nuHmNHeWnLJI
	j3YstVloJml3fQdUzZO2VUulou0R63yNTrvPYyPFfRA5VEynRk30Npc1zoBUq4ArzTSOVa3Bda7
	nP+NWEDTHBCitN3q+u/jjvk4+GaeoZOySIiMrt1kMBA/F7U9fkK09wYOjM4yJNgtvepFKJG+oG9
	DodRPvWQLHlfVdWdq6VRMLNE/+9
X-Received: by 2002:a05:600c:8218:b0:488:a14d:3d81 with SMTP id 5b1f17b1804b1-488d67c7034mr8638695e9.2.1775774986426;
        Thu, 09 Apr 2026 15:49:46 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00af4acfc73fc9518a.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:af4a:cfc7:3fc9:518a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d6839981sm4234305e9.21.2026.04.09.15.49.45
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 15:49:45 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 1/1] tests/fetch: Avoid using git protocol in tests
Date: Fri, 10 Apr 2026 00:49:29 +0200
Message-ID: <7fd0197fd5fedd23cc885b5e7e816d86a392fdf9.1775774593.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1775774593.git.yoann.congal@smile.fr>
References: <cover.1775774593.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 09 Apr 2026 22:49:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19358

From: Richard Purdie <richard.purdie@linuxfoundation.org>

A test was still using git protocol to access git services.
For the submodule test, the upstream repo has been updated.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 5d722b5d65e4eef7befe6376983385421e993f86)
[YC: Backport: only kept the part that applied]
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/bb/tests/fetch.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index e46278dcb..b3890ef41 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1053,7 +1053,7 @@ class FetcherNetworkTest(FetcherTest):
         # URL with ssh submodules
         url = "gitsm://git.yoctoproject.org/git-submodule-test;branch=ssh-gitsm-tests;rev=049da4a6cb198d7c0302e9e8b243a1443cb809a7;branch=master"
         # Original URL (comment this if you have ssh access to git.yoctoproject.org)
-        url = "gitsm://git.yoctoproject.org/git-submodule-test;branch=master;rev=a2885dd7d25380d23627e7544b7bbb55014b16ee;branch=master"
+        url = "gitsm://git.yoctoproject.org/git-submodule-test;branch=master;rev=38e61644af90dccd73c03ed3acaed98c8dda9294;branch=master;protocol=https"
         fetcher = bb.fetch.Fetch([url], self.d)
         fetcher.download()
         # Previous cwd has been deleted

