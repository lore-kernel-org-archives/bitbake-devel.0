Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666B4C433EF
	for <webhook@archiver.kernel.org>; Fri, 22 Apr 2022 16:51:59 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web11.48.1650571368324857766
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 21 Apr 2022 13:02:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Oe6ALpb0;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.53,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f53.google.com with SMTP id b19so8105727wrh.11
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 21 Apr 2022 13:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xgh55u3hruTGBL8ryEH4G4hR7jCMoM0oO/iKYGsAG04=;
        b=Oe6ALpb0kKqNrbkayjYpBFY+Fmh7wQJHFkcLbTecH4zs7EJCOLfpBlNogBBAdfumHy
         mJptcG0RyBUyOWsz795buUzdiZZYY5ohMoKciAmmDGTdoyBOQB9SF7r1l2GMXW+MXRqg
         lvu2Sy4IkvXVyHxnwUrXvdxA8PVQ+qMpzR60g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xgh55u3hruTGBL8ryEH4G4hR7jCMoM0oO/iKYGsAG04=;
        b=KcsN29K4F+0ubbV/nGxs/6+AgPUOxX1WfUi9dXMuAe7xv/xYT4Yk9uhf+qCgKItXQ3
         /VT14kQ5akHnOMv0fSoLsk9/I4EaEmpLNNXbQPdOELiyitSrYS9PFsB2m14ms8ZAGffM
         mwqmcuPg+PqIczXelYk9ddydD0PBj05aw5hNIh1CoFkw0egCCIA2tRGyezx+IoPgGpUc
         8Y0zHEloh23Xa2T2gPmWWe74wSXDMr3V42kKsp6qIkOSvcpz3jNVbMXfSLi1YiZfLwE6
         bXtx135JwAuYCdPjT6TnaM3gcGaQha1TnSeWqcHbX+5ELh/uD31MABhkUHI4097xfMKz
         yaSQ==
X-Gm-Message-State: AOAM530pTiPKZNxiyaIS0b0AjueNbjTxBJjf+Aw3NX4roSE8g3Zs8TAb
	4F0EUpiHvBU7D98JjMxcCDLK7XoMRGOYfw==
X-Google-Smtp-Source: 
 ABdhPJzKlplRKSthTC2/lpNPrKnWDLrrp5Ez6piHmFtPwahKO34xUNlqNrBKx2kQuMPIoWUvkFP+Cg==
X-Received: by 2002:a5d:6d8b:0:b0:20a:97c4:bdc6 with SMTP id
 l11-20020a5d6d8b000000b0020a97c4bdc6mr976867wrs.156.1650571366295;
        Thu, 21 Apr 2022 13:02:46 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:9788:6d00:bfe8:c84e])
        by smtp.gmail.com with ESMTPSA id
 x9-20020adfdd89000000b0020a839cdab1sm2801wrl.52.2022.04.21.13.02.42
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 13:02:43 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] fetch2/osc: Add missing parameter
Date: Thu, 21 Apr 2022 21:02:41 +0100
Message-Id: <20220421200241.2608546-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 22 Apr 2022 16:51:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13657

This probably means the osc fetcher isn't being used but fix the missing
parameter.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/osc.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/osc.py b/lib/bb/fetch2/osc.py
index d9ce44390c..99a529e5bf 100644
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
2.32.0


