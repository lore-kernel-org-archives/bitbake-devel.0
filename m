Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA924C433EF
	for <webhook@archiver.kernel.org>; Tue,  2 Nov 2021 17:06:03 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web11.755.1635872762971828431
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Nov 2021 10:06:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=NPtRUkY0;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.51,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f51.google.com with SMTP id t30so9536172wra.10
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Nov 2021 10:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rqpvLmjWb/lpUij4PeqSs6tGZcudvGd4VXbZW39BYL0=;
        b=NPtRUkY0zFAcYiYJgLUXUiw4hm9bwMSpfYowkbhQGMaUD6b4Tlfes5ny6Y+k71uQCv
         +nVSSNSVuHSuAzBqfmMLzMSCnWdqhBLYQEBB5fJ62xI7IOUNNDXF9YzdyMUVWSFI/v42
         J6AKk1LfZASPUSWKO0Zakzt3w+0d7kh7/BGBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rqpvLmjWb/lpUij4PeqSs6tGZcudvGd4VXbZW39BYL0=;
        b=2aAVS/q8fHPcrQ5u4qN636HIbCA1pXyfzdsYtpBfTW9Nj2xOfVbGBLn1TxHqUkaXAs
         g6aVSDdwEYsjOVd32TPLDJUpvmmR0mtpauOjS2g05UQF7+bG9EHkpmHxRjNyK9ZvRLOL
         /Tv+d6OD3tnjIltlHIX0JcfjvBrjkH8Sf9O6JN5QZR8Pktt0pl2sZ3Gl9Kv2aRW2Fa2A
         DqwISs/qNQC8QH7CZTBtEdrxYci1m/LHorES5r1ZKPBwAc/H5EHsIDzmwnCitR39BF05
         MiIso4nwio6vMa4/8nOTLT0xZINGtLIZbVmsLi10W3zQ6etoC9BfGcllyGl65mE8BgLA
         2izw==
X-Gm-Message-State: AOAM533WEdBb6Am+wPZ7M+qppJoMarqwx6fZFWa9AFWrTadGIEFKoJ25
	GFQY5E5gRSU9z4jplCl62JZJ2H+wxqiiiQ==
X-Google-Smtp-Source: 
 ABdhPJy0KUGXZYKpNCkhCU3nvfkTx6HXTCuAHPRmvpMr2WAFek86F3QG+vQ66xEclEsb+Oz93Oi81w==
X-Received: by 2002:adf:f787:: with SMTP id q7mr29591012wrp.1.1635872760980;
        Tue, 02 Nov 2021 10:06:00 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:e05:60cd:475e:19f5])
        by smtp.gmail.com with ESMTPSA id
 j40sm3019515wms.16.2021.11.02.10.05.59
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 10:06:00 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH v2] fetch/git: Show warning for invalid github urls
Date: Tue,  2 Nov 2021 17:05:59 +0000
Message-Id: <20211102170559.3553007-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 02 Nov 2021 17:06:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12868

On master, tell the users they need to update their urls for github.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/git.py | 1 +
 1 file changed, 1 insertion(+)

[v2 - add missing ud.url)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index f5be24d6ab..6546aef6a2 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -146,6 +146,7 @@ class Git(FetchMethod):
             # github stopped supporting git protocol
             # https://github.blog/2021-09-01-improving-git-protocol-security-github/#no-more-unauthenticated-git
             ud.proto = "https"
+            bb.warn("URL: %s uses git protocol which is no longer supported by github. Please change to ;protocol=https in the url." % ud.url)
 
         if not ud.proto in ('git', 'file', 'ssh', 'http', 'https', 'rsync'):
             raise bb.fetch2.ParameterError("Invalid protocol type", ud.url)
-- 
2.32.0


