Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web12.31211.1618227721385887803
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 12 Apr 2021 04:42:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=PFbbktVN;
 spf=pass (domain: konsulko.com, ip: 209.85.128.52, mailfrom: pbarker@konsulko.com)
Received: by mail-wm1-f52.google.com with SMTP id 5-20020a05600c0245b029011a8273f85eso6694162wmj.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 12 Apr 2021 04:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GyemhJ9tmH/3gbJJkuWDhakorLkq314SA61KNf7/m0U=;
        b=PFbbktVNVAxeB7p9TqM1UmVKFfg4f7DSlmjbs1NVBideiX/Vv0YCMS2nvqNIeeTelq
         4k1RyZ8FfIMvneB72o0kPa0tS61QIN/0HmUEiU9s0cMT0yNMui1iVuyxivHGSaPaKPTr
         vCMwNR1cre46Yk9LpkTCatt65133pelPZwHS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GyemhJ9tmH/3gbJJkuWDhakorLkq314SA61KNf7/m0U=;
        b=jLe+TEGhl4b9NFEJaK2Yvibw+ffGi9WX39TDyb7UjNjFGaBnOmq2jFg99Db3l2n+UG
         8Z71oL7S1KLloIE4wBqNCTjyGwvPTrqJzWV1l60AEgI5x46uiXXYv332CHQf2GxA4Di2
         Olf14bGYqff/Wi5d5RkJR9NlxPLw/z1eiMgaxz8RW9GtfCg638BpiCLa4Xz+wdfj8oOE
         awRH9V/uJBBa4WzN18qPlVG0OwQl7tI09+h8kFo7DEpVrYO495eYmzNVXZ1Lj9Xp/8E1
         ro4DcSlqKf0UMsXZ2M5vWyqqlXkdg3e5hKTM9MkExSvIV6YzXN6swId7x9BE87jk4pyI
         QRkQ==
X-Gm-Message-State: AOAM533/WC3+zCZHnNyUsQV0W0OP23UgwwCmOr2IDOMgN4Esy7q/jqRH
	XqnvkEHSig5SA4y68ttFgXIN3WlgozTxjQ==
X-Google-Smtp-Source: ABdhPJyvaVEhR/3eouZgeSzAiKpYwqGlfJ2u3q930Zbp7C33K0TYohNWbS6+dOb3XDRs0MEDjLRiRA==
X-Received: by 2002:a05:600c:210a:: with SMTP id u10mr10125337wml.18.1618227719792;
        Mon, 12 Apr 2021 04:41:59 -0700 (PDT)
Return-Path: <pbarker@konsulko.com>
Received: from alpha.home.b5net.uk (cpc76132-clif11-2-0-cust80.12-4.cable.virginm.net. [80.7.160.81])
        by smtp.gmail.com with ESMTPSA id 3sm17931294wma.45.2021.04.12.04.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 04:41:59 -0700 (PDT)
From: "Paul Barker" <pbarker@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>
Cc: Paul Barker <pbarker@konsulko.com>
Subject: [RFC PATCH 04/11] prserv: Drop obsolete python version check
Date: Mon, 12 Apr 2021 12:41:42 +0100
Message-Id: <20210412114149.4750-5-pbarker@konsulko.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210412114149.4750-1-pbarker@konsulko.com>
References: <20210412114149.4750-1-pbarker@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bitbake no longer supports Python 2 so this version check is obsolete.

Signed-off-by: Paul Barker <pbarker@konsulko.com>
---
 lib/prserv/serv.py | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index 25dcf8a0e..1cfbba864 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -18,10 +18,6 @@ import select
 
 logger = logging.getLogger("BitBake.PRserv")
 
-if sys.hexversion < 0x020600F0:
-    print("Sorry, python 2.6 or later is required.")
-    sys.exit(1)
-
 class Handler(SimpleXMLRPCRequestHandler):
     def _dispatch(self,method,params):
         try:
-- 
2.26.2

