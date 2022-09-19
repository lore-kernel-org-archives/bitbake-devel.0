Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050B1ECAAD3
	for <webhook@archiver.kernel.org>; Mon, 19 Sep 2022 09:14:17 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web09.17857.1663578848473577890
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 19 Sep 2022 02:14:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=hdKy3ejd;
 spf=pass (domain: gmail.com, ip: 209.85.221.50,
 mailfrom: quaresma.jose@gmail.com)
Received: by mail-wr1-f50.google.com with SMTP id t7so46430643wrm.10
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 19 Sep 2022 02:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=X7XFgUXY7WYpZ0LODOAMw6lRV+N4xhhhMKJGw3uQ7M4=;
        b=hdKy3ejdECh3EoPg4cwTgDSkvhoE6ntN1oK9+X5Zm7wK+mSGl0BCvGDqbeLfVdpGbl
         e9Czlk6PiPW+SuFIbLkWxgBVskwc5IxFbYsYj7PbCS6wPXmwXexslpW1lV2m9q7cfT6o
         lbzfK+ssoolm3Ijrz4yVlOq0Whq6293nEqXd6aAp3xM12IwkbpWJS4hjiJTGrtA+shu7
         BIafB8zkLfyepI2a2AQIhRsSQH0gX+/oQ5Wi408wFXWeMdopmDlCT1kwbf8AkBrEYocH
         06nzDrjZ/4ztx/D8boEQ2L8k7hxVNg2KJRtQ4VX4wO7XvLit1aY+f0+M+00INvqOMx3B
         s8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=X7XFgUXY7WYpZ0LODOAMw6lRV+N4xhhhMKJGw3uQ7M4=;
        b=WEP7pTtMlr3XfUY/RblcauyQzoXbBxs1rSNoGOaS9G2SmoxpyghRq9AeXSp5sdOm06
         rGLRvzYxHddK7jzpqmkqhUAqXeakWnPaqPyov1ApNWPVlISmL5/9vjXJ32P7BkXRHNF6
         9Pm9tSVNhq4AG9L8u43NUSsMYtUdV28n6nlrn5JeWXh5s6ZMbvsVjwS0aCfg4yzhy9Vf
         9xkdvUYYZ6HwgXYNxdV/2WRcyWl13k+M6KFD7hndgYPVMoTxSOlrP3Ge28WfZi/KWIal
         5UIMKSX1C8LpPtLxRdglbNXHwrN9T37xWtFjGznGYJjP4Qd417BJurFRoEqcEsA7wYVg
         d38Q==
X-Gm-Message-State: ACrzQf1Skxblm1TKMpjOkJLiMntCc+PrKgtknAwxt+aNALKCWjVfT5oV
	WhHcDjhsQXj+4VlhFT/XHTZ+RmI443M=
X-Google-Smtp-Source: 
 AMsMyM4ItGgYv4mBXhHgyInlNuECeWlgwZjVZ9AChPdB1GoRXT6ZhbupSmGznqqZ7MwYpnusXr3Mjg==
X-Received: by 2002:adf:ee86:0:b0:228:6fe1:371 with SMTP id
 b6-20020adfee86000000b002286fe10371mr9677549wro.684.1663578846358;
        Mon, 19 Sep 2022 02:14:06 -0700 (PDT)
Received: from og-worker-dev-01.infra.foundries.io.net
 (51-159-19-113.rev.poneytelecom.eu. [51.159.19.113])
        by smtp.gmail.com with ESMTPSA id
 bg31-20020a05600c3c9f00b003a5f4fccd4asm14215262wmb.35.2022.09.19.02.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 02:14:05 -0700 (PDT)
From: Jose Quaresma <quaresma.jose@gmail.com>
X-Google-Original-From: Jose Quaresma <jose.quaresma@foundries.io>
To: bitbake-devel@lists.openembedded.org
Cc: Jose Quaresma <jose.quaresma@foundries.io>
Subject: [PATCH 2/2] lib/bb: fix bitbake debug logger with invalid args
Date: Mon, 19 Sep 2022 09:13:12 +0000
Message-Id: <20220919091312.894690-2-jose.quaresma@foundries.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220919091312.894690-1-jose.quaresma@foundries.io>
References: <20220919091312.894690-1-jose.quaresma@foundries.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 19 Sep 2022 09:14:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13979

f68682a7 logging: Make bitbake logger compatible with python logger
introduces the "_debug_helper" that change the api of the debug logger as
they call now bbdebug always with level 1. Any old code that uses the old
syntax "debug(lvl, msg)" is broken if they don't call the main debug log.

This issue can be replicated running "bitbake -D" with:

from bb.fetch2 import logger
logger.debug(2, "I am alive")

That one side effect is crashing the knotty:

| Traceback (most recent call last):
| File "/srv/oe/bitbake/lib/bb/ui/knotty.py", line 685, in main
| event.msg = taskinfo['title'] + ': ' + event.msg
| TypeError: can only concatenate str (not "int") to str

Signed-off-by: Jose Quaresma <jose.quaresma@foundries.io>
---
 lib/bb/__init__.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/bb/__init__.py b/lib/bb/__init__.py
index 81b5a628..6378bce3 100644
--- a/lib/bb/__init__.py
+++ b/lib/bb/__init__.py
@@ -45,7 +45,11 @@ class BBLoggerMixin(object):
             self.debug = self._debug_helper
 
     def _debug_helper(self, *args, **kwargs):
-        return self.bbdebug(1, *args, **kwargs)
+        lvl = 1
+        if isinstance(args[0], int):
+            lvl = args[0]
+            args = args[1:]
+        return self.bbdebug(lvl, *args, **kwargs)
 
     def debug2(self, *args, **kwargs):
         return self.bbdebug(2, *args, **kwargs)
-- 
2.34.1


