Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D8AC433EF
	for <webhook@archiver.kernel.org>; Tue,  2 Nov 2021 14:57:48 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web09.946.1635865067500141592
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Nov 2021 07:57:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=JepYVR48;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.50,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f50.google.com with SMTP id
 j128-20020a1c2386000000b003301a98dd62so2168170wmj.5
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Nov 2021 07:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=jF2YS+dmiFSzmr59eocTTtrfOPZgPCAS1PJPicmKNk8=;
        b=JepYVR48R4uLo/nKOet0ubnP/IAm7PbdOj6Or1ARFb12SgrkL7fgiYzpiSaI3gnMnh
         DHCIl0v6mzxlv6gbD5fJcgS+ReXDJjx5p3xd4op9IOFv571y996kk3p2UfKI/C7LENEA
         Be2c1o+baGHcilqHkL+wWOLQbJck8TVeVafDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jF2YS+dmiFSzmr59eocTTtrfOPZgPCAS1PJPicmKNk8=;
        b=si1AjOA1dF3FrDRG3txmzJ3NIuHGzIsouhYPXgRe0VwTxPqE47jRfpQViP5Zsmp4gD
         ye0goECxUqVXLQjbSdBSlrqSMGsyUhAQOYjj/WuPhmYX++2rvwMkUSkGAb/g66ZJdBOq
         5QjmmJMAJ7utHnXsYV3SWr4RBpebAgtZp4JtPvM3vpW+R7MB2+RrPvX6ah6czHccAy7Z
         OnurMBHk+qrGQntSt2ck/tgVrptRA+/4XbADZWrPlv0lCmK17fNXI9m0cHbNQobPEEXd
         AOUFFA5bA09+kpZe64x/pIyjs2jVuXqOJmK1X0PsA2riivGAElRA8bgSrwk2kd9YOuG7
         QRPw==
X-Gm-Message-State: AOAM531SAY4xo08mt2SIrOxP/oscQij9ivtKgydytChh2vC69E+srgP8
	yL9TTf8LkN2Rs2bPaxfWl9Z0D0HK3yL6wg==
X-Google-Smtp-Source: 
 ABdhPJw1CYcnTT0TO9YrW4NXAYX5V10vwPxlxOdT4siF5pFAcaspSsAFzJxzKwf6MIRWKYWXnn2l6A==
X-Received: by 2002:a7b:c153:: with SMTP id z19mr7460159wmi.171.1635865065909;
        Tue, 02 Nov 2021 07:57:45 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:e05:60cd:475e:19f5])
        by smtp.gmail.com with ESMTPSA id
 q26sm14916634wrc.39.2021.11.02.07.57.45
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 07:57:45 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 5/5] tests/fetch: Add test for url parameter rewriting
Date: Tue,  2 Nov 2021 14:57:42 +0000
Message-Id: <20211102145742.3550251-5-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211102145742.3550251-1-richard.purdie@linuxfoundation.org>
References: <20211102145742.3550251-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 02 Nov 2021 14:57:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12867

Add a test to ensure that a parameter like protocol=git can be rewritten
to a different url and protocol.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/tests/fetch.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 918fec9134..b83ec06450 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -430,9 +430,10 @@ class MirrorUriTest(FetcherTest):
             : "http://somewhere2.org/somefile_1.2.3.tar.gz",
         ("git://someserver.org/bitbake;tag=1234567890123456789012345678901234567890;branch=master", "git://someserver.org/bitbake;branch=master", "git://git.openembedded.org/bitbake;protocol=http")
             : "git://git.openembedded.org/bitbake;tag=1234567890123456789012345678901234567890;branch=master;protocol=http",
-
         ("git://user1@someserver.org/bitbake;tag=1234567890123456789012345678901234567890;branch=master", "git://someserver.org/bitbake;branch=master", "git://user2@git.openembedded.org/bitbake;protocol=http")
             : "git://user2@git.openembedded.org/bitbake;tag=1234567890123456789012345678901234567890;branch=master;protocol=http",
+        ("git://someserver.org/bitbake;tag=1234567890123456789012345678901234567890;protocol=git;branch=master", "git://someserver.org/bitbake", "git://someotherserver.org/bitbake;protocol=https")
+            : "git://someotherserver.org/bitbake;tag=1234567890123456789012345678901234567890;protocol=https;branch=master",
 
 
         #Renaming files doesn't work
-- 
2.32.0


