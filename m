Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C082AC433F5
	for <webhook@archiver.kernel.org>; Tue,  8 Mar 2022 09:45:54 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web11.6474.1646732753400407954
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 08 Mar 2022 01:45:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=PBUiKhL6;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.47,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f47.google.com with SMTP id t11so27532907wrm.5
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 08 Mar 2022 01:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JpObsHeX6iMwsAnVao6vE+/oYFA6PihF0RpQkSaHgLA=;
        b=PBUiKhL6IW7JK9y6bmldb1u+FxHNG8qCV5xTSGQcf11j0R6SEU1Mh8aqbjgntf3rw5
         /y7R+5kBsYNQ/RQ0oNOBHOjYIWEuvSH6/y+FGxrDpKpQm4rZQrXdzNbvhGtv4vjetVua
         JRunhIQ0cvMKpfHPYn4x5b2KQlye7EW3ywFOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JpObsHeX6iMwsAnVao6vE+/oYFA6PihF0RpQkSaHgLA=;
        b=eqa8xhO9taeFQ7PDk+Zwwcfxlwtqjhfikns75Q/PrAkNpChxs//gADGdXyK0l9Qlm3
         r/yd0ngTQ+gjh5w1Ec/jinmPt2PB7relXNtDjMQhF30ghhSzKgKCBL159q5zCL1XmVYY
         8+P+oZEbZNFIlNMT7IhR4OwxZH/hNifNjWLPEuDGkJlbTYrPEwbd3jFijr2R2SFYwIE/
         9RTYLnW9uJw+PJqLgediVYlbig0kd3UBAb5DhKAH1zpGZFusSYZHkwDAJBcSmdLNPPEU
         kmDGlK6fKfEYoSDOIm+t+rKR/5RVCZ1KBw0u0DFhi7XxUtDamtqhQSHcSro+QOKZ5kBe
         BZ9A==
X-Gm-Message-State: AOAM531nkTKnkvmm0HsBbbZ5uRJiU5Fo1sdTjGLeZpOIXyXuRsMRfmfj
	fJAC10NypdZiHJ6Rx/rRKBuiE3Ez8SwpuifM
X-Google-Smtp-Source: 
 ABdhPJyEzOMfP3JqslGnHWit+Fn6qLRHZCiOyImAzh45zI+AsP2cBJ1eNoxqZe1BwdUEceXh6C+GRw==
X-Received: by 2002:a5d:5887:0:b0:1f1:fae9:a95e with SMTP id
 n7-20020a5d5887000000b001f1fae9a95emr5626533wrf.340.1646732751536;
        Tue, 08 Mar 2022 01:45:51 -0800 (PST)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:1a2:8f31:9d13:9148])
        by smtp.gmail.com with ESMTPSA id
 g2-20020a5d46c2000000b001f079ba0158sm10017712wrs.60.2022.03.08.01.45.50
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 01:45:51 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] server/xmlrpcserver: Add missing xmlrpcclient import
Date: Tue,  8 Mar 2022 09:45:50 +0000
Message-Id: <20220308094550.509927-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 08 Mar 2022 09:45:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13441

This avoids backtraces when starting toaster or using bitbake in
remote mode.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/xmlrpcserver.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/server/xmlrpcserver.py b/lib/bb/server/xmlrpcserver.py
index 2fa71be667..01f55538ae 100644
--- a/lib/bb/server/xmlrpcserver.py
+++ b/lib/bb/server/xmlrpcserver.py
@@ -11,6 +11,7 @@ import hashlib
 import time
 import inspect
 from xmlrpc.server import SimpleXMLRPCServer, SimpleXMLRPCRequestHandler
+import bb.server.xmlrpcclient
 
 import bb
 
-- 
2.32.0


