Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0518DC6FA82
	for <webhook@archiver.kernel.org>; Mon, 19 Sep 2022 09:14:17 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web09.17856.1663578848030398255
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 19 Sep 2022 02:14:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=kV43w7Eb;
 spf=pass (domain: gmail.com, ip: 209.85.128.53,
 mailfrom: quaresma.jose@gmail.com)
Received: by mail-wm1-f53.google.com with SMTP id ay36so10860120wmb.0
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 19 Sep 2022 02:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=DC2aF5Oi1ZSfaTkXltstj5/WPIZ/qpwagVJIPBOyQvo=;
        b=kV43w7EbxZ8CGa9TkNwZI4ujn/uLUPcDAlv/CLV57EM8SGOMgEwcif5EEZWsFJAaJW
         MdaQYVPt8H3gbzOuMhHZf9Df13kQ32seNwBUCmS4vkDcy6p1W3hG8cPiwmXLTc28w3yb
         zN7tX/cbvbJcmEggMUBdlU+/kCR0MAmS8l2dIoPt8rV+BON7AB9BWfqRl4olAWdOaJb3
         6/xjt4qWZK5tZHJQ36aIly1cUyq1arwBvBKzwaByZrMHUx8HU+M9E0ubseJS5OKgqU6h
         Bu64SXrUBy/cLh6GtiJ9Vo9gkLLXnhmlVhqvaLIPCd7X/QXaknaMeOu9Ub1c1e5oUtJ4
         tMbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=DC2aF5Oi1ZSfaTkXltstj5/WPIZ/qpwagVJIPBOyQvo=;
        b=S3hB4zrEwii6ObNHU1fWsaa5RHfplj9rFLKQotGdTK1Xq6MAMe6WAr3DUZrmYkjHQM
         mEx9oKRyoU3QWhseR4dPsFVaw6z56GURHKh7CQfjbMWMzG92WXL4Sj71z/pwVZvlAnTY
         HGYXZxTcA0heD+O9UPFyftkptTwYNJfcwUQUF+n5+Zyk43DmlK1/8C9VShBrjnCxzOFQ
         jmg0JQkrxj/W4VXetMRloWaKrWk87Gaj1ldcmjt4L9KCoNBhS30KPjIXerum+S13Mk0u
         paVrjDAKbmo9f3NpEaW1FUJ4WNZeS+QymrYVvfzWKearB69NdnxBj7laYfWNsCZx/mvc
         QoNQ==
X-Gm-Message-State: ACrzQf3jlkKPMZzD7ubKzk+bHRJlnTV4Mu8WH2RTGo7JYjPgvAQe1DvM
	/jbRyL/1v//V0RsPqStVKXGxkhqeN20=
X-Google-Smtp-Source: 
 AMsMyM4B3KpAYKwO2lKMKLUJLIWEnFTeg6yC1CYG8lxRlYYqlM24cr6t7b4vRHIzYbe05lHdTxxuqQ==
X-Received: by 2002:a7b:cd14:0:b0:3b4:8680:79a7 with SMTP id
 f20-20020a7bcd14000000b003b4868079a7mr11851554wmj.28.1663578845688;
        Mon, 19 Sep 2022 02:14:05 -0700 (PDT)
Received: from og-worker-dev-01.infra.foundries.io.net
 (51-159-19-113.rev.poneytelecom.eu. [51.159.19.113])
        by smtp.gmail.com with ESMTPSA id
 bg31-20020a05600c3c9f00b003a5f4fccd4asm14215262wmb.35.2022.09.19.02.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 02:14:05 -0700 (PDT)
From: Jose Quaresma <quaresma.jose@gmail.com>
X-Google-Original-From: Jose Quaresma <jose.quaresma@foundries.io>
To: bitbake-devel@lists.openembedded.org
Cc: Jose Quaresma <jose.quaresma@foundries.io>
Subject: [PATCH 1/2] lib/bb: warning when the debug message is invalid
Date: Mon, 19 Sep 2022 09:13:11 +0000
Message-Id: <20220919091312.894690-1-jose.quaresma@foundries.io>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 19 Sep 2022 09:14:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13978

There are many messed up calls for the debug log,
so is better to warm about this as they will not work
as expected.

The level need to be an integer and the msg a string.

Signed-off-by: Jose Quaresma <jose.quaresma@foundries.io>
---
 lib/bb/__init__.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/bb/__init__.py b/lib/bb/__init__.py
index b8333bdb..81b5a628 100644
--- a/lib/bb/__init__.py
+++ b/lib/bb/__init__.py
@@ -60,6 +60,10 @@ class BBLoggerMixin(object):
                 return
             if loglevel < bb.msg.loggerDefaultLogLevel:
                 return
+
+        if not isinstance(level, int) or not isinstance(msg, str):
+            mainlogger.warning("Invalid arguments in bbdebug: %s" % repr((level, msg,) + args))
+
         return self.log(loglevel, msg, *args, **kwargs)
 
     def plain(self, msg, *args, **kwargs):
-- 
2.34.1


