Return-Path: <jacob.kroon@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D366FC433EF
	for <webhook@archiver.kernel.org>; Thu, 18 Nov 2021 16:27:07 +0000 (UTC)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com
 [209.85.167.50])
 by mx.groups.io with SMTP id smtpd.web11.3930.1637252826685784213
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Nov 2021 08:27:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=p6CzVOh9;
 spf=pass (domain: gmail.com, ip: 209.85.167.50,
 mailfrom: jacob.kroon@gmail.com)
Received: by mail-lf1-f50.google.com with SMTP id b40so28829613lfv.10
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Nov 2021 08:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OKrG1JwbfcWqE3h/bXOr/RlMZpUC4v7iwzEYxpkTtFc=;
        b=p6CzVOh9nZJhMLU9HOAb0sz0bP7EbOwY2N8tFAQ+uO3mEJ9WkEwD/HF4sKPYX7JBcC
         GXpGOQv6Mkb8Vv/xc6OrPac4jZ9kiWjJbsAFpXKHBHppGT0xK7d4YHkZoFpuJw3qzfeu
         +e2LFHk31wSq1dbzmlOWcplcXr2be43Nl/Fg+9FaucZdgD5txx2nNZ4Q7nwMRMi8APxI
         ZefF+P1oeEY91k8Y755RgKHi2QhvxnFYV2B/6ZAso6y+DacBbNpsvV1sMs8bB1csC4pn
         vADwHvw7R8jPDA8EhrEK/EAxvpAlgxvmR/H7rD2YgFMGSmQ0z87jxqBUxcxa3XZIYgxW
         LTmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OKrG1JwbfcWqE3h/bXOr/RlMZpUC4v7iwzEYxpkTtFc=;
        b=2Bp6FwEYDWu9AvciPutuX1aqoD18iWvc9eGiYCA2SkjmD9jNENYaQapogHevI0gNQX
         +he3h6ZA8wVn/WYXLPacpcR3EoYXc8LYEhGjMzoyHo7TJOF/XH7f3bD86fiDVZGYSzyj
         /ADG07VoCClqZ5iNDts5w8z1WUbwVoH4CpY9nXEeoUBHysv2u9qCdkkfEM8IT/tViLXS
         jLKLCOUFjZ1Cjjw9oyFzwbqKeMq86vIuLWlixFgxqLTzTLMd5WoPl9BDHCA+9Ku3YGRj
         RvGUKcgI/EoDaFJTV86l+/9w7ycDAskg3xQ6mkUyZlX6VBqjpNetjJhJVPyFLKB+M/pw
         0p6g==
X-Gm-Message-State: AOAM533EwTCYCEv8+pBurmMPFic/eTqnwqenpjAyq9jP+x6+rEDB5qGi
	1AdxUnzFvHtp5GOUKvty9JO2o3r43WuO3XXm
X-Google-Smtp-Source: 
 ABdhPJyCU9pOFeVOiZ1OW9zJAx9CZ0l2ZlCJBfEd70vbQcm5/OkAe4HMn3jNViaHAkjjjEv1klouDw==
X-Received: by 2002:a05:651c:621:: with SMTP id
 k33mr18522167lje.359.1637252825138;
        Thu, 18 Nov 2021 08:27:05 -0800 (PST)
Received: from localhost.localdomain (37-247-29-68.customers.ownit.se.
 [37.247.29.68])
        by smtp.gmail.com with ESMTPSA id
 p17sm37252lfs.292.2021.11.18.08.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 08:27:04 -0800 (PST)
From: Jacob Kroon <jacob.kroon@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex.kanavin@gmail.com>,
	Alexander Kanavin <alex@linutronix.de>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [1.50][PATCH 4/4] bitbake: correct deprecation warning in process.py
Date: Thu, 18 Nov 2021 17:26:23 +0100
Message-Id: <20211118162623.3117035-5-jacob.kroon@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211118162623.3117035-1-jacob.kroon@gmail.com>
References: <20211118162623.3117035-1-jacob.kroon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 18 Nov 2021 16:27:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13072

From: Alexander Kanavin <alex.kanavin@gmail.com>

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit aff52fe21a0b27f6302555c1e52a864550eb46ce)
Signed-off-by: Jacob Kroon <jacob.kroon@gmail.com>
---
 lib/bb/server/process.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 07bb785a..fcdce197 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -659,7 +659,7 @@ class BBUIEventQueue:
         self.reader = ConnectionReader(readfd)
 
         self.t = threading.Thread()
-        self.t.setDaemon(True)
+        self.t.daemon = True
         self.t.run = self.startCallbackHandler
         self.t.start()
 

