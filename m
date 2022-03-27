Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C877CC433F5
	for <webhook@archiver.kernel.org>; Sun, 27 Mar 2022 16:44:15 +0000 (UTC)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by mx.groups.io with SMTP id smtpd.web11.771.1648399454724646241
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 27 Mar 2022 09:44:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=jHfsLaz4;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.43,
 mailfrom: steve@sakoman.com)
Received: by mail-pj1-f43.google.com with SMTP id
 l4-20020a17090a49c400b001c6840df4a3so13310946pjm.0
        for <bitbake-devel@lists.openembedded.org>;
 Sun, 27 Mar 2022 09:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=y2Ua9hYJ8rg1bt9LialMyvNzL4XUyfNX7KYr2pkHu30=;
        b=jHfsLaz4mOh+FTpw7La0E8UUSW/20Hr8H/kZqcGI0oYvLfTjeuDXKsucwuJvEP+QbH
         VMHSg+DDuXd+5bfXQlAkaxlCuffbQ0xhVSHGYFCWPTGRmrNimhvSzAPeeKAa/EHqx4Q7
         DnoFpfXLTlsIFH3P3YUz8NK/1KivHlhtwGyNYEyLfjmyOU/krvV5hKBOOYuzRNE0pd3J
         rmZj89wr3/9gsTMPWCF3du8slRs/I+eixfd6kFd1dT5+zkmHy/6PkqAxtRgbbeNQaXh6
         4zlI0Ibm4+AWP179Ut5/fAJsNJqJvkjxMPKh0i666jLra9QJ3WV7Yl/fTZsC8LfNF+0C
         u1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y2Ua9hYJ8rg1bt9LialMyvNzL4XUyfNX7KYr2pkHu30=;
        b=oRhw+2JqYBmF0zo4KXjfC2SY33o2+9izBK6VKtPWaf6MNXiSgATsXUO/OTZJbWclR7
         aeoyOGFtxjO/cQPAIXhzOS1Bs8nJyJcRa+hc14plT8tyuZ8irLdKOT25JRjNL7l2dBNv
         Yv+qmpyKrbrBtU5+Mg0mU5t4YYKNsUQVcSOPNsFRLl4FqaCdyjtqNXyhHcR6Eh3+h2Ip
         u2eSshpIQ4t358XykQSXyN/in6oJoSWJk7n0/BzLWhemszIJLLWWcszG9/veg3FWk2x0
         Hww3dzi01uMrGISNJPr5G+sf60crhwhnbErYc1Re3HMl//4kpCJaTTRPFzLuCJWiIT1F
         AM9A==
X-Gm-Message-State: AOAM530HO/fd7iurUTZLkxkYUNIwklG61qH2dxRoVkCeUaZbWwZ2Yvrw
	K8WTsRX/+3H9eOt7qM0p7braCsk7CuW3bObGiOg=
X-Google-Smtp-Source: 
 ABdhPJzwt/LBWx0rs9Zxcx1SxlmZVn2/rtC+PE/BATx3FzSqqLzKkfMa+kkNIH1nJOl9T2YEbbXv7Q==
X-Received: by 2002:a17:902:d488:b0:154:6df6:1e81 with SMTP id
 c8-20020a170902d48800b001546df61e81mr21726490plg.105.1648399453896;
        Sun, 27 Mar 2022 09:44:13 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 k13-20020aa7820d000000b004fa72a52040sm12935630pfi.172.2022.03.27.09.44.12
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 09:44:13 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 1/2] server/process: Note when
 commands complete in logs
Date: Sun, 27 Mar 2022 06:44:00 -1000
Message-Id: 
 <cd44a4882650598da3f2827db3637c294e00bae7.1648399312.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1648399312.git.steve@sakoman.com>
References: <cover.1648399312.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 27 Mar 2022 16:44:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13520

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Its hard to tell from the server logs whether commands complete or not
(or how long they take). Add extra info to allow more debugging of
server timeouts.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 56285ada585ec1481449522282b335bcb5a2671e)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/server/process.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 7b135762..3c9ed706 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -221,6 +221,7 @@ class ProcessServer(multiprocessing.Process):
                 try:
                     print("Running command %s" % command)
                     self.command_channel_reply.send(self.cooker.command.runCommand(command))
+                    print("Command Completed")
                 except Exception as e:
                    logger.exception('Exception in server main event loop running command %s (%s)' % (command, str(e)))
 
-- 
2.25.1


