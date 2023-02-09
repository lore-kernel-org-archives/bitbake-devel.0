Return-Path: <george.kelly1097@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59905C05027
	for <webhook@archiver.kernel.org>; Thu,  9 Feb 2023 14:30:08 +0000 (UTC)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
 by mx.groups.io with SMTP id smtpd.web10.16495.1675952999935029079
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Feb 2023 06:30:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=FdU1gIA7;
 spf=pass (domain: gmail.com, ip: 209.85.160.180, mailfrom: george.kelly1097@gmail.com)
Received: by mail-qt1-f180.google.com with SMTP id v17so2042801qto.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 09 Feb 2023 06:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vIjRbGoiMx79Kmp231sjwSg0WV69sayT3b+Bj28jaHQ=;
        b=FdU1gIA7CKyojAmXLk6HGFezuraqAwAqHfpn0dg+6GVm65vx0PHmKi2Kgf15DRMSsc
         pQtrpsFcW3myOHOxP4BcbKBGdY8rji6tALLQ8u5x2YuKRMIszOOx2gUR0MPFE4zTuSZy
         f+JcWBM0ej3kmQZjGyQWGAMMQdOBpViTlI2HNAyXHeLA+TYRrK+FbIJ6imUU+thfuHAN
         RkWzOj/hZpK1eK4BIly0BQzqod1OZk0J8ISJrAJ6TWLvoQS9AvNQJBcFodscXatkWSq4
         rtEp5OoV3gwPCLUZa2vHdI+9YYYzP5s1Q7k4m+k6MnPsd4MDgB3cvzcSSwTPYp5J1osR
         3jUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vIjRbGoiMx79Kmp231sjwSg0WV69sayT3b+Bj28jaHQ=;
        b=nBcJh7cPd5gDkakhKu5PbHGtgqNKgt8gy9EP5B9V1qXJwysed+1QkOP78WcGYPrnJj
         ETuzFzpZD06M0h58bcsD7cEMDWS53kfV9BmqATxakQG9cv2OGEez7J7yod+ZoXkTQBqT
         irFP8EOS7KcrA5Uzql0L+AKHpGmo4qyg1GnxdSGi2ZiQGcIGGUKKJ9466kQ90UBqV4QA
         khS8jMObi0gWeG9/eYPnmpCkG9LmpToroRqr0qhniIqYo0V2MH6hubaF2M3f0VLlpz15
         asZuSUMR+N5ItOQOuXK0CqPG1L6elH2xxAEx3x8NYc0CFoBVWKHReB5F4MgOlKwukGV7
         sXCg==
X-Gm-Message-State: AO0yUKVG5w+T99xUbdkBiGcVWy9bA1YB/2hzBNW5KkD17cJn80QtVyqg
	jx/2ii9qiuGGr/x/mbswGUw5jj9ZAJo=
X-Google-Smtp-Source: AK7set+LTN7boszXqZwk9mY+hA371ifZoN695+aFTwhmdkiu1PMy3fWd48+LSwIkZ8Or16ZxfWYf4g==
X-Received: by 2002:ac8:5acb:0:b0:3b8:6b6b:28c2 with SMTP id d11-20020ac85acb000000b003b86b6b28c2mr20493678qtd.68.1675952998696;
        Thu, 09 Feb 2023 06:29:58 -0800 (PST)
Received: from gk-ubuntu.. (172-222-054-105.res.spectrum.com. [172.222.54.105])
        by smtp.gmail.com with ESMTPSA id e189-20020a3769c6000000b007062139ecb3sm1435682qkc.95.2023.02.09.06.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 06:29:58 -0800 (PST)
From: George Kelly <george.kelly1097@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: George Kelly <george.kelly1097@gmail.com>
Subject: [bitbake][PATCHv3] bitbake: fetch2: Add NODE_EXTRA_CA_CERTS to export list
Date: Thu,  9 Feb 2023 09:28:19 -0500
Message-Id: <20230209142819.9946-1-george.kelly1097@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 09 Feb 2023 14:30:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14389

If you are behind a corporate proxy, the npm fetcher uses the proxy
IP address already passed in the list of exports. However, it will
error if the proxy injects its own root CA certificate. Thus, the
NODE_EXTRA_CA_CERTS environment variable must be passed so the user
can include their company's root CA as a trusted CA inside node's
certificate store.

Signed-off-by: George Kelly <george.kelly1097@gmail.com>
---
 lib/bb/fetch2/__init__.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 5a7a6024..747356df 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -851,6 +851,7 @@ FETCH_EXPORT_VARS = ['HOME', 'PATH',
                      'DBUS_SESSION_BUS_ADDRESS',
                      'P4CONFIG',
                      'SSL_CERT_FILE',
+                     'NODE_EXTRA_CA_CERTS',
                      'AWS_PROFILE',
                      'AWS_ACCESS_KEY_ID',
                      'AWS_SECRET_ACCESS_KEY',
-- 
2.37.2


