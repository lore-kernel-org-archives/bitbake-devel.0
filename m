Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E481C433EF
	for <webhook@archiver.kernel.org>; Tue, 10 May 2022 18:06:13 +0000 (UTC)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by mx.groups.io with SMTP id smtpd.web09.623.1652205968899111144
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 May 2022 11:06:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=6CL0wv+J;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.174,
 mailfrom: steve@sakoman.com)
Received: by mail-pf1-f174.google.com with SMTP id g8so15573856pfh.5
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 May 2022 11:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=rZrcv8K+FV1dbOyTPnsjZOx1dN+Os5DaHV73XA6N3aQ=;
        b=6CL0wv+JuOWrWzUhVJuki+kXGzXKC5uJI3tgur0uyZCcHpmfJYBzXTUEPseT1E9KCB
         dGXMgh6cmqVAvx5EQYpxTeDClhaa40CFskdFE3KlNS7T9DLxCdZnIehPWJW+8Q+Las25
         TVHopnyNITLVkSYiYJWCzgsBefClJw4/TomqSpPlKqJm6p4IqZ0C14E/VLMqGO9iwp1S
         78hwsPhCsYWiew2N0E4ej8/+fHGTCyqs1WNYJeWg/n9Kgb1+amFBJOfLsxYLNdJcPNGv
         fJKpXdmmgq9a/jAZY2YoaQuhHcR1OtinoZ3fw0m5V7xh1aB2/YvWewMwlni3wzyq0Nqu
         WA2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rZrcv8K+FV1dbOyTPnsjZOx1dN+Os5DaHV73XA6N3aQ=;
        b=Iqz9pqQ6zHfQHcHfDBRr6nI4A+qsBlzgzHB5i+qHpUWSWpguRwpodHYlKXeVF+C0JS
         aGJBc2TXMEM14YyFjypToin3pqHewlnhqoe8hPp6xVFe/Z7DB4seYHH/MN1m/3aPRhQA
         BbKgYqHcbV3ZceWq7ZNKFqOxZRKVfBWn3JQM4ON+X/YhrrRa1cTlycyRowyhTJYooUWH
         Am6S/fz9ANehC+tgr7RrzhxfQU9gYSqa57xFqYCJzCm0IQDDlusMltWG/8FsCfaGyqeX
         w2IZPgtBKd4tOZoe1WtOQREoe8tJr+8M8L63HQYqTjZ+Rd8vSPjIi0pzOakDQJ2VaOgg
         0VaQ==
X-Gm-Message-State: AOAM53085OXBB1dMFAXM5oXDsYshp5XJNs5MG+RMjNPvNnpWnVV94ISR
	EMjbPPGTr/2Yapnzis/AxWtkE53gyQ1uSyuz
X-Google-Smtp-Source: 
 ABdhPJzVQ4pYbnRMdCuFtfaWikxkFmIWRdX7uwN//x5Dx5QhjrKKy9Hj+uUQk19YpdMDwAKSH0cyjw==
X-Received: by 2002:a05:6a00:168a:b0:4f7:e161:83cd with SMTP id
 k10-20020a056a00168a00b004f7e16183cdmr21531210pfc.56.1652205967845;
        Tue, 10 May 2022 11:06:07 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 12-20020aa7910c000000b0050dc76281c4sm10846777pfh.158.2022.05.10.11.06.06
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 11:06:07 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 03/18] server/process: Drop unused
 import
Date: Tue, 10 May 2022 08:05:28 -1000
Message-Id: 
 <8e03262d87804747c17da14fb2e3cc3a17b06eed.1652205806.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1652205806.git.steve@sakoman.com>
References: <cover.1652205806.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 10 May 2022 18:06:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13683

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 543315e6463f15ca7ab2b4ef3e8ed41bb4207ccf)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/server/process.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 19ef8398..613956f3 100644
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
2.25.1


