Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E60C352A1
	for <webhook@archiver.kernel.org>; Wed,  7 Dec 2022 14:31:11 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web10.16548.1670423463070512705
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 07 Dec 2022 06:31:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=OdjDPZU0;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f49.google.com with SMTP id ay40so7031456wmb.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 07 Dec 2022 06:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6BBptugipsqoBLp9oxc1owfRVYhpyei5HncY77/sz7A=;
        b=OdjDPZU06oPvFCA/M1naaIAVtgbKcQp1aCohdGbQEuwQNeeZWZqGsHcDrWItdrCdZR
         jUh7vegcF+J+SAv3xWv++zWHuevje6wcLd+duTsnlDtNF8enZmI3pTm4uhYlWAUZp3jM
         XI/n9GoQjkQiRlCNCN6Kr2Y9hOzLXCGxYr1uE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6BBptugipsqoBLp9oxc1owfRVYhpyei5HncY77/sz7A=;
        b=on+X3rjkibVJQ1EvEq38tDCZdCzxAO5rQtTe+j4mqye8MX+Cf2R+yUwMp9q4N7m+/o
         D8BJMNykrVcahCbw5D6jn42klFIcVAuiB0XL06q+aXkhgEHrWS7hyIyxGrEOfocxBRas
         69xKDHyUH+8uJEhkiIFuF2kkQ5UtYsSVquMjD1EraEwlbvZt7Dlrjsm8xULA47oKzsTm
         36sx97YoKLAWz6kxa9trceGizk2k30nymlIeeWya9QOcWRk1khG/ZERA8x/PEtyY02Tx
         NmYsMOQ3/LqZQczZyEz9lK8NLn6ZlDBiH60o+uGE62EJIbqyWSExe5gy7akHtkIwSdCl
         94hw==
X-Gm-Message-State: ANoB5pl71HsWlw8jQTsDRsde23dC+J1D/W5QFlptAzXjgZzbTVepxyWn
	PPZqKfxJync5AIzNjytSfnnxxvUkuIYZNMTg
X-Google-Smtp-Source: AA0mqf7Cy/LIutSzWl4azUO7NjKACx6RH/ISr/YAaizRRojE4CVLvJDXneLsWOasgfGUD9VtqGINtg==
X-Received: by 2002:a05:600c:46c8:b0:3d1:f0e3:722c with SMTP id q8-20020a05600c46c800b003d1f0e3722cmr3897393wmo.33.1670423461341;
        Wed, 07 Dec 2022 06:31:01 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:a7cc:35cb:98f7:71b8])
        by smtp.gmail.com with ESMTPSA id b11-20020a05600c4e0b00b003c6c5a5a651sm2104153wmq.28.2022.12.07.06.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 06:31:01 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [PATCH] cooker: Start sync thread a little earlier
Date: Wed,  7 Dec 2022 14:31:00 +0000
Message-Id: <20221207143100.2131119-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 07 Dec 2022 14:31:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14144

From: Joshua Watt <JPEWhacker@gmail.com>

Starts the sync thread slightly earlier to give it some extra time to
dump out the caches while the main process tears down the parsing
processes

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 7f232f2b36..728ef09675 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -2222,6 +2222,13 @@ class CookerParser(object):
         else:
             bb.error("Parsing halted due to errors, see error messages above")
 
+        def sync_caches():
+            for c in self.bb_caches.values():
+                c.sync()
+
+        self.syncthread = threading.Thread(target=sync_caches, name="SyncThread")
+        self.syncthread.start()
+
         self.parser_quit.set()
 
         # Cleanup the queue before call process.join(), otherwise there might be
@@ -2252,13 +2259,7 @@ class CookerParser(object):
             if hasattr(process, "close"):
                 process.close()
 
-        def sync_caches():
-            for c in self.bb_caches.values():
-                c.sync()
 
-        sync = threading.Thread(target=sync_caches, name="SyncThread")
-        self.syncthread = sync
-        sync.start()
         bb.codeparser.parser_cache_savemerge()
         bb.fetch.fetcher_parse_done()
         if self.cooker.configuration.profile:
-- 
2.34.1


