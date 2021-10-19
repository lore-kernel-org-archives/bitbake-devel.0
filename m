Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACFFC433EF
	for <webhook@archiver.kernel.org>; Tue, 19 Oct 2021 20:06:42 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.web10.15684.1634674002329666497
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 19 Oct 2021 13:06:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=PUY8XyRQ;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.170,
 mailfrom: steve@sakoman.com)
Received: by mail-pl1-f170.google.com with SMTP id i5so8246556pla.5
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 19 Oct 2021 13:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=pRECOXAF3Ty48/BkSy7yZ5YjV9C7uEsKtw1i0GoIjPA=;
        b=PUY8XyRQ0M2Y1NkBZ5trZW4NOnke2KkGUAUsARo9d1YrCa2eToDoaS+4trEOI+q/zp
         Y4SPmJzRzzZedcHy5jeLrVDwpFMQP4mB4TxOlROU+jpLyBiHCd/6JiLxdpe//pll7OGF
         DM3ocLTla4xRAnsF1sQtGifmHr43a/WT3NHvFoeiooty+Xdq3CnQcnaUrLaAsy+E2brQ
         XsREXRDHran+2D+14duUhb5K9CXUntt0iE27VSCKJZN/gVpdL8RD9QqaMRkhe6CpicsM
         jo+tbKV+a+32ny9QjZUTuXD/O4SRGqk4bFIpolSEo0OVIdER/JqVJm51LzvfXsNecRl/
         wiSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pRECOXAF3Ty48/BkSy7yZ5YjV9C7uEsKtw1i0GoIjPA=;
        b=Zf0GIYXUnOWIbidtQ4SHxYEf0eA/yYuM5rI+bPTG4nRFrK93kCeWDScufwJ0rzQibL
         r2hCuecEvLTfZh6EkIzr/SAeygDTnxJWkuOrWaP1eBBa7N2F/piorwFRnulDTngCLMG0
         ktdH5KO5INfqTNIMlnbg6erDeslfEvnpgL8O12OC3SRSvmRS5TtlHtEwwK8he5HqeE7D
         hnpch5R9suDI4jDA14QhfHvAHKgosmNerCX5BWqRDmDgkff0/8Z72bKRb2NAGzJWToM0
         IjpJ8GPXD9uqvuqni8L75PdSSwpgc4+FTxJwTgHvOaBOqZ6dB+fNiLLAfHnskXSvySVa
         i6hg==
X-Gm-Message-State: AOAM531ZLXevg8xv3++S/JKe0mb3dHYfkcooU0N/uGi+uhsyws5PWVNZ
	1drG4W08gdNKtqhJFuazIWqua9Qs5yPnXy6j
X-Google-Smtp-Source: 
 ABdhPJyJ33gUdS/JPMrtSfd3AYzvyQSpWC7YDHLQHQHPphd8jd+Tmv/ApVBA5jL1q6V4PH4CZ+tzvA==
X-Received: by 2002:a17:90a:1507:: with SMTP id
 l7mr2090126pja.141.1634674001388;
        Tue, 19 Oct 2021 13:06:41 -0700 (PDT)
Received: from hexa.router0800d9.com (rrcs-66-91-142-162.west.biz.rr.com.
 [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id
 l6sm3533562pjy.23.2021.10.19.13.06.40
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 13:06:40 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 6/8] bitbake: correct deprecation
 warning in process.py
Date: Tue, 19 Oct 2021 10:06:14 -1000
Message-Id: 
 <8e293640075647d362846a6d2f926e54ddf654c4.1634673786.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1634673786.git.steve@sakoman.com>
References: <cover.1634673786.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 19 Oct 2021 20:06:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12808

From: Alexander Kanavin <alex.kanavin@gmail.com>

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit aff52fe21a0b27f6302555c1e52a864550eb46ce)
Signed-off-by: Justin Bronder <jsbronder@cold-front.org>
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/server/process.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 45f2e863..43061eb3 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -587,7 +587,7 @@ class BBUIEventQueue:
         self.reader = ConnectionReader(readfd)
 
         self.t = threading.Thread()
-        self.t.setDaemon(True)
+        self.t.daemon = True
         self.t.run = self.startCallbackHandler
         self.t.start()
 
-- 
2.25.1


