Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E15D3C43334
	for <webhook@archiver.kernel.org>; Tue, 21 Jun 2022 18:21:25 +0000 (UTC)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by mx.groups.io with SMTP id smtpd.web10.46486.1655835683687731131
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Jun 2022 11:21:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=WEylasN7;
 spf=softfail (domain: sakoman.com, ip: 209.85.215.171,
 mailfrom: steve@sakoman.com)
Received: by mail-pg1-f171.google.com with SMTP id 68so8413748pgb.10
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Jun 2022 11:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=RWreAhsu1Woco4xoJ+omiB1eNfLNCHaCA2c2QqR3pSE=;
        b=WEylasN7YnscbmmWqfNKP/x7OtqsZx9+SFmtkycr+fqwFTrWKXwLhLF976CPmtw1m9
         zAQIMra+7oPMib2QcQyVW9lQJjTmD6HUsoVXUONrZ9Xcy9+QcJB0tlYbbFB+ZFwf8JHb
         FM+9LB6B4Tbj4xmU5Y7Nmhoor+d9wMNYpGhRuxEf5ZMoD8k2ur7MF5osw5Eusb1+1c1q
         4iHE+c/bIRZ8IRSuwA9NdprHAN85ureBjutjrgfi/v9OI2mf4sbzVHJhg2khR0L96UbV
         PnovA/ZTBU8eNH6L7OluVtzOAD/2x40Jd0pu1OSdsLM6yw2w9HH09yrDkJg0V3ysLgS2
         FKRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RWreAhsu1Woco4xoJ+omiB1eNfLNCHaCA2c2QqR3pSE=;
        b=E1WPL/YllBWoDXSpElAzhIwUSZxClYbHcmCScrdQI3NJLUVkO8RqGh1574hoMbdmpm
         eqmdo1wA4X89bopPsTsrnWDh4xu/P1p4Aw6Wrr9IIdRoVJ+18lHtpmbeJ2i/Pz3uMlg5
         7tNtB9ePrq0ObrB/NRoFaVyyxtRbza//Jjyqn7ThFiz/ISpbJPRCbaURNd3LXyxchFv5
         TeLo6GVKjloJFw7h1sRGFQrLCun9PfuW5aEllntlpvUv+gbAIcIcQklV9jkX/+/8uWjc
         NO7HQeDMdiPltL6pN6asdBrezLbzsE58Oxnl1xlQ2LJL9reURk66yvSuyQgP4A20zVbt
         6dmQ==
X-Gm-Message-State: AJIora/GmR9btsPufZKoKj4n/OktyajuuZ5AYc0IDC8KF9r9A7p9HpMw
	2HO+zvUzHnJxiqfL5c3mGUik+/t4pqt8RglU
X-Google-Smtp-Source: 
 AGRyM1sBmvyMe9uLOH9KsKq9gHSApi4wRx8wxlXOrpLyOCfXLs/UPHMmL6XNXOkcMnfq7UU5JiyaOg==
X-Received: by 2002:a63:7844:0:b0:40c:9792:5d6d with SMTP id
 t65-20020a637844000000b0040c97925d6dmr14208726pgc.360.1655835682722;
        Tue, 21 Jun 2022 11:21:22 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 t13-20020a1709027fcd00b0016392bd5060sm9755503plb.142.2022.06.21.11.21.21
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 11:21:22 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 4/5] knotty: display active tasks when
 printing keepAlive() message
Date: Tue, 21 Jun 2022 08:21:00 -1000
Message-Id: 
 <36fe8bae9fec61547ee0b13bcb721033afd3ac0e.1655835530.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1655835530.git.steve@sakoman.com>
References: <cover.1655835530.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 21 Jun 2022 18:21:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13782

From: Ross Burton <ross@burtonini.com>

In interactive bitbake sessions it is obvious what tasks are running
when one of them hangs or otherwise takes a long time. However, in
non-interactive sessions (such as automated builds) bitbake just prints
a message saying that it is "still alive" with no clues as to what tasks
are active still.

By simply listing the active tasks when printing the keep alive message,
we don't need to parse the bitbake log to identify which of the tasks
is still active and has presumably hung.

Signed-off-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 30f6c3f175617beea8e8bb75dcf255611e3fc2fd)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/ui/knotty.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index e70c2464..71c5a3e9 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -227,7 +227,9 @@ class TerminalFilter(object):
 
     def keepAlive(self, t):
         if not self.cuu:
-            print("Bitbake still alive (%ds)" % t)
+            print("Bitbake still alive (no events for %ds). Active tasks:" % t)
+            for t in self.helper.running_tasks:
+                print(t)
             sys.stdout.flush()
 
     def updateFooter(self):
-- 
2.25.1


