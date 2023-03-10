Return-Path: <Martin.Jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F4A5C6FA99
	for <webhook@archiver.kernel.org>; Fri, 10 Mar 2023 20:45:41 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web10.30832.1678481135095935614
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Mar 2023 12:45:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=CfmrVWz1;
 spf=pass (domain: gmail.com, ip: 209.85.128.53, mailfrom: martin.jansa@gmail.com)
Received: by mail-wm1-f53.google.com with SMTP id az36so4262675wmb.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 10 Mar 2023 12:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678481133;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8Xuet9e0HwGpmOG3ug9oYD6YSpptRFLHOOjlo8cEuhI=;
        b=CfmrVWz1K4oJIiC2LV8e0zd8najft58T/VzW2be6Pqce7kwX1BRn2wJzWeBAuYAKha
         CtK0CSRd8xgpLQeUW5uErts2vJeCH/qhxlcILeJDuNzegNy3mtZYPC4AdhTKSJ9zOsk9
         xygb9zh0XMHNMdHYwfJjwn/jRDdArdKSngBajdOt+Add4DMl2vEHKWwUNeccqgtvh238
         /opAqYsXrYhibVJeFtl6rSI2MITyGHfU0it4CR13XndSRMt32AClrloazWnzZ/oKCBec
         FSvKMk1z4jAZp2XfG5NuyVpmUuBBr2+Xl3X7juiAawGBowrfs1dCKZu5g2GOd/IUNSda
         Pmuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678481133;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Xuet9e0HwGpmOG3ug9oYD6YSpptRFLHOOjlo8cEuhI=;
        b=FZ2G/ZUw7tqESHnmI45g0khd5LwGVhENvEZfXrg+YBSsmsuQZrQNZlz3Z4Jd1adC6r
         LXcgx/R7iFI/DOZCQyTjbH7Mr6cH9f7z9KEX0aYIgq59K3oTZNKjvSGkJcpLFxfvZd5c
         91S4eYaecUnUR4KIaYlbRDHfyKQ1tQuSoAokAbcRvq9NhfmoPABaWYGMKVrRMMZhjQjX
         DPQ75ZrIkb/+d6hqZKTx1p1UcJJN3mKE3Ur3PJZhf8M1sCl4Bx6Lt03X48eAb648l1Um
         2yUrcCeJtAblqsU83DMhqvR3h5SOS0vdeOaLpsyg1OV74MmAVsrHGDWUnh1iyzc79Pco
         leBg==
X-Gm-Message-State: AO0yUKU8xIkVUo6rYuoMZSK93FNrBUlfhaKKa4K8ofLFkDeKGB8b8g9q
	L7I4HmfSainEg/WcMhKLbLfJZ8Yb8dw=
X-Google-Smtp-Source: AK7set/r+FdwxOYf+XxjZRGfm5bxlUt4DyjwHeklDBoaRTTNZ+HwraCfvOsv2GI/sN9UY5KtRRSHoQ==
X-Received: by 2002:a05:600c:4fc4:b0:3eb:2de8:b732 with SMTP id o4-20020a05600c4fc400b003eb2de8b732mr4360749wmq.0.1678481133381;
        Fri, 10 Mar 2023 12:45:33 -0800 (PST)
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with ESMTPSA id x1-20020adff641000000b002c70c99db74sm660333wrp.86.2023.03.10.12.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 12:45:32 -0800 (PST)
From: Martin Jansa <martin.jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: steve@sakoman.com,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [2.2][PATCH 1/4] utils: Allow to_boolean to support int values
Date: Fri, 10 Mar 2023 21:45:16 +0100
Message-Id: <20230310204519.706973-1-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 10 Mar 2023 20:45:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14540

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Some variables may be set as:

X = 1

as well the more usual

X = "1"

so add support to to_boolean to handle this case.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/utils.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 3ce98d317..2f6d9229a 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -992,6 +992,9 @@ def to_boolean(string, default=None):
     if not string:
         return default
 
+    if isinstance(string, int):
+        return string != 0
+
     normalized = string.lower()
     if normalized in ("y", "yes", "1", "true"):
         return True
-- 
2.39.2


