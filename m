Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A0EC49EA4
	for <webhook@archiver.kernel.org>; Thu, 21 Apr 2022 16:46:07 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web09.7558.1650460929836573856
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 20 Apr 2022 06:22:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Zrtm0Nd1;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.53,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f53.google.com with SMTP id
 u17-20020a05600c211100b0038eaf4cdaaeso3679685wml.1
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 20 Apr 2022 06:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=2ESB2HDp2j/b40LRr7ps7flFyl/LRPaWi2mr+t8F9hk=;
        b=Zrtm0Nd13zhQC47RcO8UsTfM4x31+qR+KhranvumgbwBZ+VASVFqT3UpJjfAH3M6Gv
         RnOStIVdtjf0x7MbVgvLJ2PmUWLhz5Art/6uKviUr0C/H3f0mE/r9Y2MdlBfacdFMQ8e
         szMmHGdnvG0W02cXDcX5YQh1n2sweNewzc6lY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2ESB2HDp2j/b40LRr7ps7flFyl/LRPaWi2mr+t8F9hk=;
        b=1Xz4v1I6oufslLDQroLQBKYQTZTqoQSRB1E/Md+uIQ5k9EBIftmCSOShv/J0YVOXZT
         fdu3Ky+6QKNSlJA6j6fw9X+QGvulGx/Mcd6BmjjnE1hBrWXCnjd+/55sNjYyE9DrvyfA
         ZfxA5K8F7KF4YRtF3/a15RFEc+mLXjJNq7yS8vRxdmT78oKaKM7M/OqEqSpJLvi+io+a
         lKwqfl2ObpL4Rnbeajnc4USYZxrri6gDiV4vdFC8XFG1f2WaN9PSaJWt3uT1r6pWQaIn
         vU+esKtt/GrdeZl8eT4mJQi8MFNncExdyVIzttxaOP3TTpnYc4vRp0zjqsomPJyp3T5H
         byXw==
X-Gm-Message-State: AOAM533HyTvhT30JhhkokXywHQt25kumAtUVZQMXrYDBLXIHGebLcrYM
	dQrrkJgSgMauhgpyaooIm7LISMWBILXrmQ==
X-Google-Smtp-Source: 
 ABdhPJy4CrF6qK0Ht1QIzSlOQqFRYAupOkvg3rcO/6yd1oSczjrDtGkV3V4izwvNCmYNOcWwsofFvQ==
X-Received: by 2002:a05:600c:c8:b0:38e:cff5:4cf6 with SMTP id
 u8-20020a05600c00c800b0038ecff54cf6mr3679768wmm.162.1650460927993;
        Wed, 20 Apr 2022 06:22:07 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:9745:8b8f:81da:af07])
        by smtp.gmail.com with ESMTPSA id
 a7-20020adffb87000000b00207982c7f4dsm15213265wrr.67.2022.04.20.06.22.07
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 06:22:07 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 02/11] ui/buildinfohelper: Drop unused import
Date: Wed, 20 Apr 2022 14:21:56 +0100
Message-Id: <20220420132205.2530591-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220420132205.2530591-1-richard.purdie@linuxfoundation.org>
References: <20220420132205.2530591-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 21 Apr 2022 16:46:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13644

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/ui/buildinfohelper.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 0761f73b3b..9c4215f9a2 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -45,7 +45,7 @@ from pprint import pformat
 import logging
 from datetime import datetime, timedelta
 
-from django.db import transaction, connection
+from django.db import transaction
 
 
 # pylint: disable=invalid-name
-- 
2.32.0


