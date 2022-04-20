Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BFCC54F3E
	for <webhook@archiver.kernel.org>; Thu, 21 Apr 2022 16:46:08 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web11.7587.1650460943012052541
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 20 Apr 2022 06:22:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=WZoRWk95;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.50,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f50.google.com with SMTP id x18so2293812wrc.0
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 20 Apr 2022 06:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=mmq0SKSEnF3Ofzg2BsaQaxqx1kHDdsEwRPhe0rnUsks=;
        b=WZoRWk95g26E7kGWsPOa0Cgkng50zTJ5+sh3qnA3R8ewjZ87w4+9NAy2CBB80f/lH1
         aM2GfAraY594leOoxiMsuxEag2piklFcNP4MWpXLRV3s27FWUs7W082dTdCyEgT8pDsp
         MjdJ8b4m+TUNUlo5HHDR1pNr+ovFlaibFPiK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mmq0SKSEnF3Ofzg2BsaQaxqx1kHDdsEwRPhe0rnUsks=;
        b=dFVEGxIm0uRzlq8b8FC6hzpZzSeAsU5wKsi9AI9Awf3ANxq784QHf1fNUbeHOxD9f7
         JIqMyOS/sUIFfEMuzoXM2Hth4tuAKi03LpgBgojoo4bMBrFW19EpTI8PDGm0F1s31Wvs
         Bi4kaKORp2M+97Bl0HWN0C9w4etb6Yiogiqb31FPIkwyHIPzTv7k7f1SnbSkeQu7INi0
         Sn3+vIP/0xa9nkyg0utF+AMF3GNeRL6btAZhP2Hv7dmBDzoT5qKrpjK/EZWOpX1//Anp
         zqQDI6Hc4EIxW3uUuxgd7v64bPV91JuSOtaR4hvEci4VPi75/QGfjYe/HtCIAJkRwOUO
         Ahxw==
X-Gm-Message-State: AOAM531FSOi1NXVwW9h29JYHz4khSYvtbbznRUVdLDpRhKXrcB4Zl1Gn
	4uFlbQlEcDlLa6wMeFk+AMbaIHVQG/SCgA==
X-Google-Smtp-Source: 
 ABdhPJyxJ1cL1NhsAJUeLr5kmBhUWDDTCE52siiXg5LEW31IWjQFTpdkwsdoAL27SL55fqdPzh7LEQ==
X-Received: by 2002:adf:ef01:0:b0:20a:8068:ca5e with SMTP id
 e1-20020adfef01000000b0020a8068ca5emr15465746wro.661.1650460941000;
        Wed, 20 Apr 2022 06:22:21 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:9745:8b8f:81da:af07])
        by smtp.gmail.com with ESMTPSA id
 a7-20020adffb87000000b00207982c7f4dsm15213265wrr.67.2022.04.20.06.22.19
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 06:22:19 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 09/11] persist_data: Use a valid exception for missing
 implementation
Date: Wed, 20 Apr 2022 14:22:03 +0100
Message-Id: <20220420132205.2530591-9-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220420132205.2530591-1-richard.purdie@linuxfoundation.org>
References: <20220420132205.2530591-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 21 Apr 2022 16:46:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13651

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/persist_data.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/persist_data.py b/lib/bb/persist_data.py
index 9e20a837a4..ce84a15825 100644
--- a/lib/bb/persist_data.py
+++ b/lib/bb/persist_data.py
@@ -208,7 +208,7 @@ class SQLTable(collections.abc.MutableMapping):
 
     def __lt__(self, other):
         if not isinstance(other, Mapping):
-            raise NotImplemented
+            raise NotImplementedError()
 
         return len(self) < len(other)
 
-- 
2.32.0


