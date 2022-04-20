Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7930C54EC4
	for <webhook@archiver.kernel.org>; Thu, 21 Apr 2022 16:46:07 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web12.7553.1650460929568080602
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 20 Apr 2022 06:22:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=aSpK+T6M;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.49,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f49.google.com with SMTP id x18so2292945wrc.0
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 20 Apr 2022 06:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cFZBQ9EZwvUIVW3U6Z6c5g9Jb1/X3JR5JDFv25fXGYA=;
        b=aSpK+T6MH0fhwHGS2upCzmqhgztziRc7vPdDtxfTnf1eMtt4r8vrqeEeIY7NOB15Z/
         +rTCefMnWdI0KkucCDcRTZJxJZXlkjZTIfAuZnA31jM+ZM9mGIzs07NMDX2xZgcvhWYh
         xgaxyd+TFVHSY2/FDvwdl1a4p4vG34Z1X3USs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cFZBQ9EZwvUIVW3U6Z6c5g9Jb1/X3JR5JDFv25fXGYA=;
        b=38ypFLCpwi5vWjFwv3f4lAFxlWmL8l0HwQA6alQuMwTqbApn7Lbr3OdqJivR6UAo7r
         zqc7GMrGBGC+ROE5PAzfH23BiMePwyQePc0kvr7FxCS1tq/QWi/7POPId3f7kJccNCO/
         CatsLJQEu5cHa6i4N2wfdwzGkKFlmzcRt4OIV8KFBcERCOb6oqw+xTLTKlHGNPYxijTe
         9Sm7g2XNb5oXb7KmOgTTdjwSwjMwGUVB1BoRm/mOwG1kK3ksmsx9rwtZ7fgHYMuI+4iT
         FezY8IWECUK9BjO+Ma5qm3tyHiZ7dr5f3P8gjAFF8wmJK2U+L0Cy1H2WothUI/9xvpml
         ELFA==
X-Gm-Message-State: AOAM532BXTAVU/yq5yWxfHlD7E5uPElqAhxczUhspTxvCifNJtu8uxSd
	hg822N0RRH4pRH74V5Tj2YOVfXnz9H+r4w==
X-Google-Smtp-Source: 
 ABdhPJy2T9LX8di90QSUfV4CeBIOG0YTFt9gFlWK19upbKi3LntlMOwfLTkwoa5++IJJ+aESpV1sww==
X-Received: by 2002:a05:6000:18c3:b0:206:1575:ec8f with SMTP id
 w3-20020a05600018c300b002061575ec8fmr15084579wrq.479.1650460927186;
        Wed, 20 Apr 2022 06:22:07 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:9745:8b8f:81da:af07])
        by smtp.gmail.com with ESMTPSA id
 a7-20020adffb87000000b00207982c7f4dsm15213265wrr.67.2022.04.20.06.22.06
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 06:22:06 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 01/11] server/process: Drop unused import
Date: Wed, 20 Apr 2022 14:21:55 +0100
Message-Id: <20220420132205.2530591-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 21 Apr 2022 16:46:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13643

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 19ef83980f..613956f30f 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -20,7 +20,6 @@ import os
 import sys
 import time
 import select
-import signal
 import socket
 import subprocess
 import errno
-- 
2.32.0


