Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439ADC0015E
	for <webhook@archiver.kernel.org>; Tue, 15 Aug 2023 16:11:53 +0000 (UTC)
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
 by mx.groups.io with SMTP id smtpd.web11.138395.1692115905966039948
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 15 Aug 2023 09:11:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20221208 header.b=rnF0o92j;
 spf=pass (domain: gmail.com, ip: 209.85.161.41, mailfrom: jpewhacker@gmail.com)
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-56d6879dcaaso4055091eaf.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 15 Aug 2023 09:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692115904; x=1692720704;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6CpzZhJMs5T3HtLPV+g+fK3/INugHMZsBYslTI7KyqA=;
        b=rnF0o92jeWHQHjkAYvjNpXQVRrQaLitrKt0G3P2UBeP9QmOkG7P1FVQAZJRvL1pUfs
         o9mW8JA1l8JeIOtynO2pPKIKxHQQFa1YG2Yi9XjJkFjTAIbfLWFKxEC2cZPu8TrvS9mn
         k6lWYRRgI2AQszMd2KxEQWFxdGE6crUwafPf3upi6YNPxh9nILBKahPTTQVYEbXxaOUD
         ysnD8+oafT/3mVmPb/x+ttYeLxJnvXa4ATv6lYWBU0MEa4GqYZW07B9B3XXQdWJ4XSNQ
         b1s0e8Pl2K9zRCMtDjV9ysujP0mDjGKBOu231izrkupseGZN6l6vKTF5cx53n2GvB6X8
         aXRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692115904; x=1692720704;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6CpzZhJMs5T3HtLPV+g+fK3/INugHMZsBYslTI7KyqA=;
        b=JExMNpq8NXD4/Sr2QtU3Fdd+jnc1FDRfTyFuVLK2Up8w31D3jnkzDg1TUlVqpY3lDP
         +uM66qda7AS26kW3R25ZefPn3Vu/pK5Uz5BjO5aamJwzcdFwEmsUXXaT9+RXl8iVdYoe
         C5heOFqfo1Xd104K/yDBI7EDR+XvjvhxDtbME4aiS9MEhYtatm1e2IC1+FIxcQhmfANh
         LeLVkGT8ZvRdqFd/yUUzIpRM/UvMFj2kkEEG1vvYd+t3oFpvSKfpMB1f5fXudUmWtRUH
         31rKJntRLxQqGTnoa4Kosn/g0yU0/6Ja4j5ACwltbc6C5q1UN5ZfxgLBa7ajkKWZtEQv
         aexQ==
X-Gm-Message-State: AOJu0YxzChAN8IpbtBiiz1hv0Tc/nRMd1k50WkigZvb/qZAGvl32eFHL
	HlQo2lglh/nvmtPuO4EvB0f5caW4Kus=
X-Google-Smtp-Source: AGHT+IEXFhj9c6g+dpWh+gSuzmxy97+5I65Mg/ayDdWyJrd2wBG5icnQIW03NfmNL3UtTwt20vZk4Q==
X-Received: by 2002:a4a:ee07:0:b0:56c:8c66:cea6 with SMTP id bd7-20020a4aee07000000b0056c8c66cea6mr12377770oob.1.1692115904413;
        Tue, 15 Aug 2023 09:11:44 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::6897])
        by smtp.gmail.com with ESMTPSA id v123-20020a4a5a81000000b0056d361ca33fsm5822288ooa.16.2023.08.15.09.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 09:11:43 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] bblayers/query: Add multiconfig support to `show-appends`
Date: Tue, 15 Aug 2023 10:11:39 -0600
Message-Id: <20230815161139.1513406-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 15 Aug 2023 16:11:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14943

Adds a --mc argument to `bitbake-layers show-appends` so that users can
filter appends for a specific multiconfig (instead of always showing the
default configuration)

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bblayers/query.py | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bblayers/query.py b/bitbake/lib/bblayers/query.py
index bec76db98a1..bfc18a75939 100644
--- a/bitbake/lib/bblayers/query.py
+++ b/bitbake/lib/bblayers/query.py
@@ -282,7 +282,10 @@ Lists recipes with the bbappends that apply to them as subitems.
         else:
             logger.plain('=== Appended recipes ===')
 
-        pnlist = list(self.tinfoil.cooker_data.pkg_pn.keys())
+
+        cooker_data = self.tinfoil.cooker.recipecaches[args.mc]
+
+        pnlist = list(cooker_data.pkg_pn.keys())
         pnlist.sort()
         appends = False
         for pn in pnlist:
@@ -295,7 +298,7 @@ Lists recipes with the bbappends that apply to them as subitems.
                 if not found:
                     continue
 
-            if self.show_appends_for_pn(pn):
+            if self.show_appends_for_pn(pn, cooker_data, args.mc):
                 appends = True
 
         if not args.pnspec and self.show_appends_for_skipped():
@@ -304,8 +307,10 @@ Lists recipes with the bbappends that apply to them as subitems.
         if not appends:
             logger.plain('No append files found')
 
-    def show_appends_for_pn(self, pn):
-        filenames = self.tinfoil.cooker_data.pkg_pn[pn]
+    def show_appends_for_pn(self, pn, cooker_data, mc):
+        filenames = cooker_data.pkg_pn[pn]
+        if mc:
+            pn = "mc:%s:%s" % (mc, pn)
 
         best = self.tinfoil.find_best_provider(pn)
         best_filename = os.path.basename(best[3])
@@ -530,6 +535,7 @@ NOTE: .bbappend files can impact the dependencies.
 
         parser_show_appends = self.add_command(sp, 'show-appends', self.do_show_appends)
         parser_show_appends.add_argument('pnspec', nargs='*', help='optional recipe name specification (wildcards allowed, enclose in quotes to avoid shell expansion)')
+        parser_show_appends.add_argument('--mc', help='use specified multiconfig', default='')
 
         parser_show_cross_depends = self.add_command(sp, 'show-cross-depends', self.do_show_cross_depends)
         parser_show_cross_depends.add_argument('-f', '--filenames', help='show full file path', action='store_true')
-- 
2.33.0


