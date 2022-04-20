Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE2FC54EFE
	for <webhook@archiver.kernel.org>; Thu, 21 Apr 2022 16:46:07 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web09.7560.1650460939231133469
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 20 Apr 2022 06:22:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=dwkzv2Y/;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id
 v64-20020a1cac43000000b0038cfd1b3a6dso3661765wme.5
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 20 Apr 2022 06:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=cWwsacm422l5Pf/H7s9KB01hac7eP+1uQMl/d4y469A=;
        b=dwkzv2Y/+9EGMjx+vJic3Dz0yKOR1xmi6N+5/DZx3lEr3ajcSDSQEVqnz+0+vQ1lYY
         5cr7LMe7tVmvhvTNFTzr851Ef96wNB4boTXCyaMogbCOgSf1aegTXSgPUbSypvH0C5/0
         LpvwMjXYSLRqxCPeBHJFSjpj2zqI7Bi0J+fk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cWwsacm422l5Pf/H7s9KB01hac7eP+1uQMl/d4y469A=;
        b=kVRUMCYza/6en+AE3n5TVp9mCmCLzyrJLlBiettNwI9oDy2lGI3DOYdPvuQArMQmPO
         tF1Umkxutl53Mf3O8d0FQhndbnx0QQrKmZfACPYTDVp5h1MBGNcWEsp/wy1Sz0z9NGiG
         ytJ1u77nKttBZsd1dpnzgl8PDWuDZlDg4aJ/v/F+8Jdzwcq+pa4cu1JxqMEetIKinrpg
         o2HTeBy0iRk/IBwhRvsGqgxYUN2U7cJedP0t0TiGw+h/v2oaFioCYre66Dilr0yn8bsP
         B2+tVd5Ub2g2fvF6q6DxD2qiKgmxCepMVNQJU8hYEBbbdyUOpyFkB0Pv2kzWezgDii5/
         ZfmQ==
X-Gm-Message-State: AOAM533TTt0uL1JViepH9VEyTBVb9a9LYpKt12UpUY6En80TVaHkOiE6
	DQ4ockYF4gpAeEP95LuVZpadI2W2PoMLwA==
X-Google-Smtp-Source: 
 ABdhPJxR+NEKTx1yof4aEdPJ5CjPVYID7QphFmlUzQXcyap4t6o6Njz2AMRMjv9twpbdMmROmbK9FA==
X-Received: by 2002:a1c:35c2:0:b0:38e:c75d:90a3 with SMTP id
 c185-20020a1c35c2000000b0038ec75d90a3mr3692973wma.98.1650460937302;
        Wed, 20 Apr 2022 06:22:17 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:9745:8b8f:81da:af07])
        by smtp.gmail.com with ESMTPSA id
 a7-20020adffb87000000b00207982c7f4dsm15213265wrr.67.2022.04.20.06.22.15
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 06:22:16 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 07/11] siggen: Drop pointless break statement
Date: Wed, 20 Apr 2022 14:22:01 +0100
Message-Id: <20220420132205.2530591-7-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220420132205.2530591-1-richard.purdie@linuxfoundation.org>
References: <20220420132205.2530591-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 21 Apr 2022 16:46:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13649

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/siggen.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 130b38d8a7..9fa568f614 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -40,7 +40,6 @@ def init(d):
     for sg in siggens:
         if desired == sg.name:
             return sg(d)
-            break
     else:
         logger.error("Invalid signature generator '%s', using default 'noop'\n"
                      "Available generators: %s", desired,
-- 
2.32.0


