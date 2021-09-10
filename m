Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web11.9548.1631282863334945109
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Sep 2021 07:07:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=WU3Re2xW;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f42.google.com with SMTP id m2so1332025wmm.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 10 Sep 2021 07:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fJ1i8s3MIAim80jk0Lc75WA6gIz6ck7WBjZb60fsA6c=;
        b=WU3Re2xW9Yu3MwZHNpd2p1Imc0SAKn83MgRj3INzYecQmGgWGWQWBphafnoxXIhzZe
         vJbBnBECo8ZOaccQNxXyVWxdC/0ujtTINi9ArsbFjmqys4/RKmYExoQlaJo43E57A3Qa
         lBGGY1mvzuZ2RxWzxCloQGQOjsr6VBmO4/o8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fJ1i8s3MIAim80jk0Lc75WA6gIz6ck7WBjZb60fsA6c=;
        b=y0hu9p2RZXN9cR8qg2oc0oXwALMJRnDsSQoN5pHha6SQlue0XNyOLH+LvupBqYfYwj
         kLZ0OQ5ihOQav3VxZwoqlGE+MaycqLvOVbM+lDCDNh6Oe1NhUDvzTb0PC34nA3vl/kee
         6BKNK/v3iBzWCAZDdb3Lcqd6zGUHpqhJGO6b6/uEKWMBR4XBiyhI3beL6ndmOa8GKf7i
         qlySHowbovZYVlMqpC+bDcF950JESYg9soMRv2of5W0XFcrxtxWr+kbzukftvQcZkNLC
         MgQ8hKj2FgeqZorz+wGUYnTbwyGIkIcQzaGFHKE/GL+S7RLiQK5Wkj2RSEeHUk8OpOZu
         9Jaw==
X-Gm-Message-State: AOAM532RgH+I2ZUW+ZkgrLKk3qpPhaoRGr6+lVwQVAzOm3Zkw6+RDYjP
	9uxXmt5HG5AEBNvyl9iO7nJIsKv6AGI+qDHj
X-Google-Smtp-Source: ABdhPJzjM6Ae5PcSZbkU93yv9NlSlaSWicUMcrDHyN/tM7GSWpR0cmC/erEHE0WG6FV56KEbPBvDrw==
X-Received: by 2002:a1c:2092:: with SMTP id g140mr2577744wmg.136.1631282861425;
        Fri, 10 Sep 2021 07:07:41 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:69c:dc1e:bcce:ea45])
        by smtp.gmail.com with ESMTPSA id l10sm5292231wrg.50.2021.09.10.07.07.41
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 07:07:41 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/3] build: Catch and error upon circular task references
Date: Fri, 10 Sep 2021 15:07:38 +0100
Message-Id: <20210910140740.1256597-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If there are circular task references, error on them rather than show
a recursion error. A simple reproducer is:

"""
do_packageswu () {
       :
}

addtask do_packageswu after do_image_complete before do_image_qa
"""

into image_types.bbclass. There is code in runqueue to detect these but
we never get that far with the current codebase.

[YOCTO #13140]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/build.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 1e062adb51..4249c0be2b 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -1034,6 +1034,8 @@ def tasksbetween(task_start, task_end, d):
     def follow_chain(task, endtask, chain=None):
         if not chain:
             chain = []
+        if task in chain:
+            bb.fatal("Circular task dependencies as %s depends itself via the chain %s" % (task, " -> ".join(chain)))
         chain.append(task)
         for othertask in tasks:
             if othertask == task:
-- 
2.32.0

