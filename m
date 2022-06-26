Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05C4C43334
	for <webhook@archiver.kernel.org>; Sun, 26 Jun 2022 14:09:01 +0000 (UTC)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by mx.groups.io with SMTP id smtpd.web08.30729.1656252536238990336
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 26 Jun 2022 07:08:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=d3vJhz4G;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.173,
 mailfrom: steve@sakoman.com)
Received: by mail-pl1-f173.google.com with SMTP id n10so6079066plp.0
        for <bitbake-devel@lists.openembedded.org>;
 Sun, 26 Jun 2022 07:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ulEpCeTYbpzvvNVOMCqiwcN+Phd7MOWwgrnt6CCBoVY=;
        b=d3vJhz4GzDfYQpxZoy5ed8tnXAEJ5aNLkX9oE3BCYcfIThUIUue8Lx1dIOznooqKiw
         Yo/bNJioW5RO+90MnubzEeCkkOwXvuR9ewhiD+rCxgd3OtD+2U+HOSkh9tCRuFDdxuVO
         uvzGPbSAkcs3akE8Am6XSEI2xrc2ZItGoS50A23nmaCxm+5eP0H3wNSC7aaYKHlfn1S/
         9KW8O7JEfTftVWVxU3VpMl1jIATPPYjZ2u5DWmhkj/0lfAXSNsnsJA7LTEP8xW/EIVB0
         cZerZA+5kQ1RF9J+oQWdAnjxcNc5Hf3BlcfdWM2hoj5WTgGF1wgaUySD8tUYE7bzUJPr
         bBWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ulEpCeTYbpzvvNVOMCqiwcN+Phd7MOWwgrnt6CCBoVY=;
        b=huus7rdWSV8fSPM6DcZrrk9DIkdRLInDOiaWk7L45Xk2cAWemO+YDAMC/9DpmRh8xY
         xB6YBuXtyOW3VNuQqJyhaxHgnlAGq+eE3RDHPrpWldL+wOi+TYMlrSBh1bti3YjTABPa
         q7ENfHgxFaH4b48C+VAYgvkEhZDP4mv12vD+C3zHdR+a7pzEF6lsIPv4nzJ8cyrr1+s3
         j3ds9hp3mL9tLdyuYuXJGl8v7yCTgKoyCwoWOypflXeyFibm/Kt/0cLxMLKcAfnFKSnh
         GDdSOas/ONTHpXenW4uDDlEJLgE2pklGInJyeZzk5PEC2raDHqDSfKu2IIaNyzsoChR5
         t9VA==
X-Gm-Message-State: AJIora+l5mohl8DwSKAwIwy9eWJ5vDb064NEfti7Aljnb/ohLdPlO+eg
	s8lq8SggvceoZ05xPYTbXDtyovDH+8UT7QrP
X-Google-Smtp-Source: 
 AGRyM1t+uh3aPIsfcpOJ7D04rIKlQUV4E4Iuj81E2xbQ7Fz/AlnINCtMUNq3qORsBgmRP9qQPXKQmQ==
X-Received: by 2002:a17:902:f813:b0:169:8f5d:c343 with SMTP id
 ix19-20020a170902f81300b001698f5dc343mr9488511plb.98.1656252534946;
        Sun, 26 Jun 2022 07:08:54 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 w15-20020a1709029a8f00b0016a1c61c5f7sm5233110plp.71.2022.06.26.07.08.53
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jun 2022 07:08:54 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0] server/process: Fix logging issues where
 only the first message was displayed
Date: Sun, 26 Jun 2022 04:08:45 -1000
Message-Id: 
 <506419dc1e0faeca02b6074dd4c26eb424f8c645.1656252284.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1656252284.git.steve@sakoman.com>
References: <cover.1656252284.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 26 Jun 2022 14:09:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13790

From: Richard Purdie <richard.purdie@linuxfoundation.org>

I realised only the first logging message was being displayed in a given
parsing process. The reason turned out to be the UI handler failing
with a "pop from empty list". The default handler was then lost and
no further messages were processed.

Fix this by catching the exception correctly in the connection writer code.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit d3e64f64525187f1409531a0bd99df576e627f7f)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/server/process.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 613956f3..f2c5c158 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -757,8 +757,11 @@ class ConnectionWriter(object):
                 process.queue_signals = True
                 self._send(obj)
                 process.queue_signals = False
-                for sig in process.signal_received.pop():
-                    process.handle_sig(sig, None)
+                try:
+                    for sig in process.signal_received.pop():
+                        process.handle_sig(sig, None)
+                except IndexError:
+                    pass
         else:
             self._send(obj)
 
-- 
2.25.1


