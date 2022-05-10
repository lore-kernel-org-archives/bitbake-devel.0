Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE3AC433F5
	for <webhook@archiver.kernel.org>; Tue, 10 May 2022 18:06:43 +0000 (UTC)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by mx.groups.io with SMTP id smtpd.web10.609.1652205998184472247
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 May 2022 11:06:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=azg2g8ls;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.176,
 mailfrom: steve@sakoman.com)
Received: by mail-pf1-f176.google.com with SMTP id x52so15580907pfu.11
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 May 2022 11:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=N1Y0EIx1oVrzRhafJE7gCCEntMxO5O0I07rapMu3228=;
        b=azg2g8ls6UGRikcBt6IA6VFSeg2YvNjhlx1l1Wg9RHbrLrzsHlkBpNCA/gpzBgOD6B
         BP2CZSBB+yAxOB3kL1AY26Okj/ENZ6sq6TZ5hOyQifQXOaFmibyMeKIBiXZXzfLAmVMa
         MP6oFmEeggiRgEvSJPq4MwmOp1NDUOY1lcZ603QAza4p5LFSd/eCL7gIC0RQdVPbbGvI
         H5NQ+5Y6dOgiRfdNtSWYq8fsnpthQ6xN66HlBtCKkFV4mk8HO9tmfkmYEzNgJlz8MYQd
         CWY4tH+HmwVbNgbEwOBajHrJRJvsjLIqimqzU3u0CgflTFnev8m46+gqL60s62dFctCn
         yeiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N1Y0EIx1oVrzRhafJE7gCCEntMxO5O0I07rapMu3228=;
        b=aiN7RBG7pSfraxWa5A8dNsc+mPzQX0rZQDJuHDdqBf12DgTkOMNcPrvGQwQhXnGTb2
         GmZ2RtrbPHB5waQa9oE6Doneeiog9LUs1ytDbUeKEiibNZmnkPHoqoIOAoNIxJjZ8uMv
         lC6gw2/I40ZrwMJSvobMrEAWSG/BqBh4UPBNx1oa1oNQNObcFrLHWYy9vvj/9QlhfazT
         zM/UJarfUAkecgug/ETjI3GJvAQgWJSi4D/nGaxKbl0C2aMrcJ8OmVv09tgTDP9kG5z1
         wSN5wb/zAYxaLiCEipLU/xq5f35jPylEm/QOrdBt9qsPr9pZIgzoWMAuy59K0TdZXZt8
         cryA==
X-Gm-Message-State: AOAM5310m0nedXNPgivLO69KmU98p8D0C6HR7XyUNSCE6p5KqsLkUltp
	GyNxXRqTJ/VQj7nLsIezCXIaRTGt1uzE2E8F
X-Google-Smtp-Source: 
 ABdhPJwrC230EyWP8vyNlHeTKRUl8wtVsecLgoQDVlvwy7cb4lVlxKbnCe8rybxl3XqCGynNVTrK5A==
X-Received: by 2002:a62:1687:0:b0:50d:3364:46d4 with SMTP id
 129-20020a621687000000b0050d336446d4mr21563569pfw.74.1652205997107;
        Tue, 10 May 2022 11:06:37 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 12-20020aa7910c000000b0050dc76281c4sm10846777pfh.158.2022.05.10.11.06.35
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 11:06:36 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 14/18] fetch2/osc: Add missing
 parameter
Date: Tue, 10 May 2022 08:05:39 -1000
Message-Id: 
 <f4617c0bf54f9c033ae080ff52a8652433b86c0c.1652205806.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1652205806.git.steve@sakoman.com>
References: <cover.1652205806.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 10 May 2022 18:06:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13694

From: Richard Purdie <richard.purdie@linuxfoundation.org>

This probably means the osc fetcher isn't being used but fix the missing
parameter.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit a23c201cb6efc5c0abf763c26f905442f0eebb68)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/fetch2/osc.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/osc.py b/lib/bb/fetch2/osc.py
index d9ce4439..99a529e5 100644
--- a/lib/bb/fetch2/osc.py
+++ b/lib/bb/fetch2/osc.py
@@ -43,7 +43,7 @@ class Osc(FetchMethod):
             ud.revision = ud.parm['rev']
         else:
             pv = d.getVar("PV", False)
-            rev = bb.fetch2.srcrev_internal_helper(ud, d)
+            rev = bb.fetch2.srcrev_internal_helper(ud, d, '')
             if rev:
                 ud.revision = rev
             else:
-- 
2.25.1


