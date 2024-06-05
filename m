Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A656FC27C52
	for <webhook@archiver.kernel.org>; Wed,  5 Jun 2024 17:33:38 +0000 (UTC)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
 by mx.groups.io with SMTP id smtpd.web11.22289.1717608814177952750
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 Jun 2024 10:33:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=aVz+DOfM;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.208.179, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2eacd7e7ad7so1071021fa.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 05 Jun 2024 10:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1717608812; x=1718213612; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=OQ6BL2yYen4XHD0oPdTJx8pzIpbHOKvGpJ07qDf/EoI=;
        b=aVz+DOfMX2oEHzBvc0kfWrUW3mmtEyGO+gsd/kXBxaf0BhhjREMpTFJT88aYv+8mtS
         FZnWpUmql6XSZw4gyoYnayRvTUsJLa0jdIGNgARdTrK5pKQzvkddjdhrBnZ0SuxZ/khn
         0hszuuE8C9ncma82FCVzuUyZY9QepuRmAeIvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717608812; x=1718213612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OQ6BL2yYen4XHD0oPdTJx8pzIpbHOKvGpJ07qDf/EoI=;
        b=DGcvl+CXehH6/VHWRAb9/xZMXPNZbEU8AxI37OBd9hEXMPwrW3AJaNLAD1eaIPmxyX
         7ZEEpV5ym7fDbONykZDPMKgpiY3bUWsoL2H9o6iTqm9OxS0mbyA1p7B3+WbSQbIZxP5C
         5xpauOzpQj/rbtX6GLbWIaCN7SnXtiDe4uR9q/tX8q3u4/4Ek2MV2dgYHl+GtDV2MkCn
         dF06c2yDj0+RQPiLAfwHJModRJcRg+iofjiQ58ehYq6y7FTMksznatOjZAlmxgOGFRSb
         R4i2G52+N/D0796qu5xaehR6APhF8Jf5d09+pEIH+FVHc4C9Wl+mtr0/MCGuMI7Sb2U3
         GcaQ==
X-Gm-Message-State: AOJu0YzKrtVNVxLAanROdGDAYCFpaQvAld/l+p/iJc0evMW4NOoViWwd
	zMmsV1G8iK0qc1cLvWUhO0gKYLlw65Oog/ZuOiD7pUQdGJnsEq1udX9NgLJNEMdxAExBeWv+6PX
	S
X-Google-Smtp-Source: AGHT+IEx8doing6g5AEgciTCmIuJysUdigv5Eqda5mkXbkCK9/VicgEPnGNhxFgwh5ayDMZpuGdk3A==
X-Received: by 2002:a2e:2c19:0:b0:2df:1e3e:327f with SMTP id 38308e7fff4ca-2eac7a72b83mr17772621fa.38.1717608811508;
        Wed, 05 Jun 2024 10:33:31 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:e518:8da0:d67c:ea72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42158134932sm29863745e9.30.2024.06.05.10.33.30
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 10:33:31 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] tests/fetch: Tweak test to match upstream repo url change
Date: Wed,  5 Jun 2024 18:33:30 +0100
Message-Id: <20240605173330.3750636-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Jun 2024 17:33:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16320

Upstream changed their urls, update our test to match.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/tests/fetch.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 1e55cdd299..701129d138 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1429,7 +1429,7 @@ class FetchLatestVersionTest(FetcherTest):
         # combination version pattern
         ("sysprof", "git://gitlab.gnome.org/GNOME/sysprof.git;protocol=https;branch=master", "cd44ee6644c3641507fb53b8a2a69137f2971219", "", "")
             : "1.2.0",
-        ("u-boot-mkimage", "git://git.denx.de/u-boot.git;branch=master;protocol=git", "62c175fbb8a0f9a926c88294ea9f7e88eb898f6c", "", "")
+        ("u-boot-mkimage", "git://source.denx.de/u-boot/u-boot.git;branch=master;protocol=https", "62c175fbb8a0f9a926c88294ea9f7e88eb898f6c", "", "")
             : "2014.01",
         # version pattern "yyyymmdd"
         ("mobile-broadband-provider-info", "git://gitlab.gnome.org/GNOME/mobile-broadband-provider-info.git;protocol=https;branch=master", "4ed19e11c2975105b71b956440acdb25d46a347d", "", "")

