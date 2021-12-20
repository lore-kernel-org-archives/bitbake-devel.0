Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65457C433FE
	for <webhook@archiver.kernel.org>; Mon, 20 Dec 2021 14:39:21 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web08.5925.1640011160379601710
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 20 Dec 2021 06:39:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=KW2zfod/;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.47,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f47.google.com with SMTP id s1so15149598wra.6
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 20 Dec 2021 06:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=icWVk4qupD1aOCksvbBpW+WeaFGXglU7VeArnT22DLQ=;
        b=KW2zfod/nByr9b9MoftguR6K3lSLOihCd8g77TBUut5ancQO2+bz9QDUq1DdSbtTlX
         4+88tgPsqVyttc8fj+lH0/hzYsXJ/4CucoQtt7sD7HJ6CdHwngRn2Ri2LaLB/balFn1c
         WFrYgTpPXtR2n3Oc+zC9dkcu50cqajQTDPTxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=icWVk4qupD1aOCksvbBpW+WeaFGXglU7VeArnT22DLQ=;
        b=bF2IyNVHil1lvQvZEpOSoe+0X8DcpvDNfUpDLxdSBccn9bUOcBC8ZR59n/CzJh9+D3
         ceOw6z0WaZIG6vxNX57BIu/N8lIhUH0enhYSqR3Um1wL+fta8MGaUGEM3fr2tz6/tAut
         Z+mkTJumQRQD9hHZXoqP9NoNSvGUdNQMYlh0+Y0lAOQZABWdUK1ZClvdSR5ofQ0QRLTa
         2wvru04m/85bpBi6aDGdA4Ue2CqQW+ESyzPzvG32n2uddES51PInhpnUne+PHbuJypqu
         RLIhj5vjoRxoNucJNeut9Th7+v2jmGzkeYjWFvSLsmu2dCEL5NZ8sPLrnFVV8EtHRuKe
         d7yg==
X-Gm-Message-State: AOAM531goZ+W8LMQXe4tHBn2ZRa6V425dQPmtjQs8+5KODR+vwQp/x+n
	DprTt8+jaPFTZvMhJ+GTUKSgXo5xxV9SNA==
X-Google-Smtp-Source: 
 ABdhPJwwc4DvS4+tSfvB9jPA8NfPk7nJrXhspMh9hR8DHwwwp6hT2qUWFyfETRgbSn2Ndm/15GWjaQ==
X-Received: by 2002:a5d:4690:: with SMTP id
 u16mr13705734wrq.321.1640011158321;
        Mon, 20 Dec 2021 06:39:18 -0800 (PST)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:2f2b:ae5:15d4:240b])
        by smtp.gmail.com with ESMTPSA id
 s189sm18346176wme.0.2021.12.20.06.39.17
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 06:39:17 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] tests/fetch: Drop gnu urls from wget connectivity test
Date: Mon, 20 Dec 2021 14:39:16 +0000
Message-Id: <20211220143916.956523-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 20 Dec 2021 14:39:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13198

These urls are no longer adding much to the test coverage but the intermittent
network issues connecting to them are painful. Drop the urls.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/tests/fetch.py | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 6b77afe5f1..2a046d0ded 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1400,9 +1400,6 @@ class FetchCheckStatusTest(FetcherTest):
                       "https://downloads.yoctoproject.org/releases/opkg/opkg-0.1.7.tar.gz",
                       "https://downloads.yoctoproject.org/releases/opkg/opkg-0.3.0.tar.gz",
                       "ftp://sourceware.org/pub/libffi/libffi-1.20.tar.gz",
-                      "http://ftp.gnu.org/gnu/autoconf/autoconf-2.60.tar.gz",
-                      "https://ftp.gnu.org/gnu/chess/gnuchess-5.08.tar.gz",
-                      "https://ftp.gnu.org/gnu/gmp/gmp-4.0.tar.gz",
                       # GitHub releases are hosted on Amazon S3, which doesn't support HEAD
                       "https://github.com/kergoth/tslib/releases/download/1.1/tslib-1.1.tar.xz"
                       ]
-- 
2.32.0


