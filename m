Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D17FC433FE
	for <webhook@archiver.kernel.org>; Tue,  2 Nov 2021 12:45:20 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web11.218.1635857103498096726
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Nov 2021 05:45:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=gknQV+Ly;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.51,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f51.google.com with SMTP id 71so13216529wma.4
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Nov 2021 05:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=vGH5dJ8ZlvtFRdr+d9Vye5EvYahWxbgqB7QntGLmd1M=;
        b=gknQV+LyCM0RJguJe11ud9QX/Ty7rblh4jdRtDpUix3hvLOyflOHAP5mqh0i+GfeRl
         Sj7zSb6rGbAhkQlglzvUDheX0WXYGyicNulQEgFj77ChQguN9hPCQGib7A23umGsaTsf
         9L+gogbESF+xAQqS3l7iETz1y6paNVlRW8AOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vGH5dJ8ZlvtFRdr+d9Vye5EvYahWxbgqB7QntGLmd1M=;
        b=5jxAY5tSFUDM1KvD8KXYSRmy/Db9bd8ei7Or8Eg87NJdcA+/9cOEIEfA8Aw+Mn29rr
         dpySRrLan/9+83xeMrENEwrPVffvnYkt+t2u1ngcelI16Vcml524Gztt48jP0k+XDlgC
         8expsi40iDNTeHtgtQaHHB8h/qyrbcokcAxACa+XxYoI+bf2JFgYVKAAZrM2JV3RM03Y
         PmlDj0+btkm2h6R+zca9auLjzJr1bpYDnS94yZrPMJftT49pnq+1OLOI/4S9Cf8CzvE6
         4LsYGNH3w0kQHyfVIndSiakwG/F2B6NmZUAJNFNYhmGkNPOofeVNaKADrBKmRIvvZ3Fs
         msxQ==
X-Gm-Message-State: AOAM533SRxRkvpHJfV81pUfjn/FWwAfjo8rAoKto4I1k+BGRsCfM+4d/
	JOxSH0z8A1C7tRuJ6QDe4++xYA0i/OQ7aw==
X-Google-Smtp-Source: 
 ABdhPJyDlhSoA3bMXa552QuFWZkBMVhvmhrCYRuHKHMd2V1BqMR6aRhLOJ1McS0rW3/4jwoHA161Ow==
X-Received: by 2002:a1c:1fd6:: with SMTP id f205mr7002179wmf.98.1635857101912;
        Tue, 02 Nov 2021 05:45:01 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:e05:60cd:475e:19f5])
        by smtp.gmail.com with ESMTPSA id
 b6sm19748349wrd.85.2021.11.02.05.45.01
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 05:45:01 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/2] fetch/git: Show warning for invalid github urls
Date: Tue,  2 Nov 2021 12:45:00 +0000
Message-Id: <20211102124500.3542952-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211102124500.3542952-1-richard.purdie@linuxfoundation.org>
References: <20211102124500.3542952-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 02 Nov 2021 12:45:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12857

On master, tell the users they need to update their urls for github.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/git.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index f5be24d6ab..682efa323f 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -146,6 +146,7 @@ class Git(FetchMethod):
             # github stopped supporting git protocol
             # https://github.blog/2021-09-01-improving-git-protocol-security-github/#no-more-unauthenticated-git
             ud.proto = "https"
+            bb.warn("URL: %s uses git protocol which is no longer supported by github. Please change to ;protocol=https in the url.")
 
         if not ud.proto in ('git', 'file', 'ssh', 'http', 'https', 'rsync'):
             raise bb.fetch2.ParameterError("Invalid protocol type", ud.url)
-- 
2.32.0


