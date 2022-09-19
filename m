Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68BC3ECAAD3
	for <webhook@archiver.kernel.org>; Mon, 19 Sep 2022 10:18:57 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web11.18114.1663582732530774141
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 19 Sep 2022 03:18:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=Gqa4MQcv;
 spf=pass (domain: gmail.com, ip: 209.85.221.52,
 mailfrom: quaresma.jose@gmail.com)
Received: by mail-wr1-f52.google.com with SMTP id r7so5660926wrm.2
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 19 Sep 2022 03:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=t+53ErWQSsTEp8pUOVW+p9Zy2nyysUOjiTpN/gKFeFg=;
        b=Gqa4MQcv6WG9/ovpUMMbKxEtVru0dCG+2w5aD9jFfzxw235Xvqsue7idSX2GsLxh6s
         ups5tlGcY6Zg2ZDyV72h+qR6xtuCOAxHjM3s4VNspkeFRnrfmjsUWnT7H4N8pMfkmq3Q
         i9ayqVFMkjqD+x4xooH9/zM6UHKinu1s70bSRxl7R0YRstjAEo+/JMMlB5cP1ClhbHa7
         KHSdfuD33IVjfgPi3uHaKR4SiPuMdY9jLZmxNYxwXiDuzq/0S0OWnom7H2qrslJnhHph
         gLvZtEKQ5eSmRuhH/5JeNRuD5vD2AEBsR/B24rQ9s0w1zGs6h6qqzaKv37E41zmBp31D
         GgaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=t+53ErWQSsTEp8pUOVW+p9Zy2nyysUOjiTpN/gKFeFg=;
        b=gLVOs3mRx0qELjGgAauViRo+4mC+nuxvkbA3aDZSHmO7OmnEz7XcPl+fN+PO3oEzMS
         4r+GzuZ47UAQXMnaj0GpO2hUio0eM/wX1fw2s/e3MNPhTsNS/M1goKmdGj4I2sjWxnfj
         hB35Ph2w9T5QueV4XsHF3JLaXASxAtWqVRA/Aeicy7lQsyu+icQByvpSenc0NfPGLpv8
         OW+eBJpuDXR1F/Xd7PfnGgHSWQcvg7w+mlIROjNFr5k28Dvj0nnIJ/9ccAsAiHFbH+qk
         5dETVyA5mqNPTSmqtYWcdhR4uEn6r3HvEXrBYji5IlMsaeCO3zgu/BJ70pe9L3j4ZWZ6
         S5qA==
X-Gm-Message-State: ACrzQf1Et1KlxyoiRKF3PSJsHlwo6fVLRR0poGZ7iitxMe//1jZwqyZw
	fjuSwgHEB58DskiUBU8PUcTI6D8Tr6dwkQ==
X-Google-Smtp-Source: 
 AMsMyM7NNIeJ3VF0pbNtQG1WDQHc80lMkwIDmCb0WyPRSnYJjxqTPPxA4pOauVgF5p8nVwHtbhFmsg==
X-Received: by 2002:adf:dbc3:0:b0:22a:d393:bd84 with SMTP id
 e3-20020adfdbc3000000b0022ad393bd84mr10320434wrj.626.1663582730632;
        Mon, 19 Sep 2022 03:18:50 -0700 (PDT)
Received: from og-worker-dev-01.infra.foundries.io.net
 (51-159-19-113.rev.poneytelecom.eu. [51.159.19.113])
        by smtp.gmail.com with ESMTPSA id
 a5-20020adffb85000000b0022a2f4fa042sm13340378wrr.103.2022.09.19.03.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 03:18:49 -0700 (PDT)
From: Jose Quaresma <quaresma.jose@gmail.com>
X-Google-Original-From: Jose Quaresma <jose.quaresma@foundries.io>
To: bitbake-devel@lists.openembedded.org
Cc: ricardo@foundries.io,
	Jose Quaresma <jose.quaresma@foundries.io>
Subject: [bitbake-devel][PATCH] fetch2/crate fixup c212b0f3 loglevel
Date: Mon, 19 Sep 2022 10:17:54 +0000
Message-Id: <20220919101754.901485-1-jose.quaresma@foundries.io>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 19 Sep 2022 10:18:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13980

c212b0f3 change the debug log level unintentional when tryng to fix a knotty issue.
This will maintain the same debug log level 2 as before.

Signed-off-by: Jose Quaresma <jose.quaresma@foundries.io>
---
 lib/bb/fetch2/crate.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/crate.py b/lib/bb/fetch2/crate.py
index f4ddc782..f091200d 100644
--- a/lib/bb/fetch2/crate.py
+++ b/lib/bb/fetch2/crate.py
@@ -71,7 +71,7 @@ class Crate(Wget):
         ud.parm['downloadfilename'] = "%s-%s.crate" % (name, version)
         ud.parm['name'] = name
 
-        logger.debug("Fetching %s to %s" % (ud.url, ud.parm['downloadfilename']))
+        logger.debug2("Fetching %s to %s" % (ud.url, ud.parm['downloadfilename']))
 
     def unpack(self, ud, rootdir, d):
         """
-- 
2.34.1


