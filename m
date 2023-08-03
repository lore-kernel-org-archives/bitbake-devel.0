Return-Path: <jermain.horsman@nedap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13121C04E69
	for <webhook@archiver.kernel.org>; Thu,  3 Aug 2023 11:43:18 +0000 (UTC)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
 by mx.groups.io with SMTP id smtpd.web10.12519.1691062989229554870
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 03 Aug 2023 04:43:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20221208 header.b=fm9JSbkH;
 spf=pass (domain: gmail.com, ip: 209.85.208.169, mailfrom: jhatnedap@gmail.com)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2b9bf52cd08so12137411fa.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 03 Aug 2023 04:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691062987; x=1691667787;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hwIQQikuRRKKnOR2RUxIQBBkxLneAOeyQAAc4orYDuE=;
        b=fm9JSbkHGD9yhzqb5nxRUShEHVp3XEWELlHaVOGoGTCHUCTbM0nx9IWaOmoUjxBgWD
         yduoiCOK7S1+m35LUtLzuNzIL0ZeubQY+OePLISnaZ2kW3KwUUmOF7u0W5ALiAwDeqk3
         +DGciENTZ6/Iwm9mfqCqT9iQGO3NVYVh4wEXZFVc4/OwUEzf3qmsSpWCN6Jj4IswKPco
         t/I8ux/a3f1Xh0fV1KDDN5LB28j3uRMq4CqYSVgpW/O+2cHsqbdxR/q7+gpb8PI6n3pw
         q3pISwmrj6vM06fbK1FjeX+fmD8sdEBFTYbg8oHygvEnBid2zn8svTQckGExs2Cph79/
         Vr2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691062987; x=1691667787;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hwIQQikuRRKKnOR2RUxIQBBkxLneAOeyQAAc4orYDuE=;
        b=NFy2UpW2am7g0uj8lRdPIj6P3fHcJT/iXdHtVe5+s+9T2gYCYLdmUlwJzm2xpov2aL
         MIMfj3+cqQelGd4YiHojIu6NF8E5yYfONR7t/grwOmuAamFi+bKYj/G5A5xtvN9lgK57
         dnS8NsLMHg4oGLv8YmkBLNnfNo6zRqy7nicP8u8eAv3Y81bzn/npLkqfhPzi5lqbkeno
         3JbewM7LXKAIJYVfeKBMK+ou3bvZrORmJIGOfQ1BPiOqkv3Vc5iJzh54BInRCC9yboon
         gIwhIztB3W3APu4PhcibbI/CYlas7po2ZDN2wgru5pHp7BkiDdW4C6q0VV2pbEgW7Ain
         s2YA==
X-Gm-Message-State: ABy/qLYSnKgTuPIzlTx6OuU5zKec+rbXhPQ+KDas79pv3BFiWDWZnKF0
	AHFDyIJRJA2NfOVIM3wPZP/wMwF+sWseRg==
X-Google-Smtp-Source: APBJJlFzqYcdJXBaC6yhBHzkcdcsGtiJ3R+hrakrbZ5/hiscjp9OUFWD9NTsEZE8ziihGqd0VEmbIQ==
X-Received: by 2002:a2e:93c3:0:b0:2b6:dd85:1206 with SMTP id p3-20020a2e93c3000000b002b6dd851206mr7245278ljh.49.1691062987237;
        Thu, 03 Aug 2023 04:43:07 -0700 (PDT)
Received: from NVC4181.nedap.local ([149.3.168.10])
        by smtp.gmail.com with ESMTPSA id q26-20020a1709060e5a00b00992b50fbbe9sm10392060eji.90.2023.08.03.04.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 04:43:06 -0700 (PDT)
From: jhatnedap@gmail.com
X-Google-Original-From: jermain.horsman@nedap.com
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex.kanavin@gmail.com>,
	Alexander Kanavin <alex@linutronix.de>,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Jermain Horsman <jermain.horsman@nedap.com>
Subject: [kirkstone][2.0][PATCH] bitbake-layers: initialize tinfoil before registering command line arguments
Date: Thu,  3 Aug 2023 13:39:53 +0200
Message-ID: <20230803114210.604-1-jermain.horsman@nedap.com>
X-Mailer: git-send-email 2.41.0.windows.1
Reply-To: jermain.horsman@nedap.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 03 Aug 2023 11:43:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14914

From: Alexander Kanavin <alex.kanavin@gmail.com>

Plugins may want to use it (e.g. the layers-setup plugin that would
want to discover writer sub-plugins with it), and so it makes sense
to make tinfoil available a bit eariler.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 2f6c7523a622f59ddf84a1a196927492bc5fa7a2)
Signed-off-by: Jermain Horsman <jermain.horsman@nedap.com>
---


The layers-setup plugin that has been added to the Yocto Project
recently is unfortunately not available on the latest LTS (kirkstone).

After a discussion with Alex about this, I set up a mixin layer to
enable this functionality, however this commit is required to get it
working.
Normally LTS releases would not get new functionality, but I think
this commit is fairly minimal and would allow for a valuable addition.

If people want to try and test this I have published the mixin layer:
https://github.com/nedap/meta-nedap-mixins



 bin/bitbake-layers | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bin/bitbake-layers b/bin/bitbake-layers
index 449434d4..d4b1d1aa 100755
--- a/bin/bitbake-layers
+++ b/bin/bitbake-layers
@@ -68,11 +68,11 @@ def main():
 
         registered = False
         for plugin in plugins:
+            if hasattr(plugin, 'tinfoil_init'):
+                plugin.tinfoil_init(tinfoil)
             if hasattr(plugin, 'register_commands'):
                 registered = True
                 plugin.register_commands(subparsers)
-            if hasattr(plugin, 'tinfoil_init'):
-                plugin.tinfoil_init(tinfoil)
 
         if not registered:
             logger.error("No commands registered - missing plugins?")
-- 
2.41.0.windows.1


