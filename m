Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB13C61DB3
	for <webhook@archiver.kernel.org>; Thu, 12 Jan 2023 19:33:50 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web10.65841.1673552028228594268
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 12 Jan 2023 11:33:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile-fr.20210112.gappssmtp.com header.s=20210112 header.b=PYp/OHHy;
 spf=pass (domain: smile.fr, ip: 209.85.221.51, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f51.google.com with SMTP id v2so8119458wrw.10
        for <bitbake-devel@lists.openembedded.org>; Thu, 12 Jan 2023 11:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=btPC/9PejBkL54XLsET819ePIWUFrN30XcdRrFUvJNY=;
        b=PYp/OHHy596cAClbRzGLi08blYf0cQboLh6tpzVWIu2QDM/vqxYG5r0I5FM0FZN0jZ
         D/0jTKlu2TWKpYfNsTFUJh1efZhvPdecIMFpLkNKdPRvPbLrVfBTEGuxfWQVtKD57mJY
         fwx9/UnOXdjLfqVpr3szZv4RVPpRB860HYqH5ehejLxKpVeHuTE4UiAzxB+5nHpy7kab
         4G5767KnCqUIruXq122BC/Eums77MmQ1ZugDGwfLVNjfq9ZxpWIY9k7yGVMBmRDJzR/b
         o+NnFMrfgxtvhbAomCF25jDeiZIQMgjugnXYfH8//pNNBDCXh2ir5PRARKQw3QydW7eP
         TXew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=btPC/9PejBkL54XLsET819ePIWUFrN30XcdRrFUvJNY=;
        b=ozLqFYwgY1qaMeFNquijG9TVdo75VWdm1lzX1spDijEEW9ob8MTV4qgQ+B8xx0wIO8
         zFq88e5W/SSFtajEi8od0GUiEBGnLPQPesxxGre3rOP0AUGDmg1O5JAtN8WCdogS4vkP
         ZDfcFzOikAQCX/1YPnu+FaFscDFLr+gaXeQZrXeufg+94SlFwqDgXlzd8tLXYP7D09SA
         cN3GOXzxc4ZODmNTOHVqVVa4/L82ytQKEQ56krEezdtEihtzXwH0w1vdlFzOLzMMUiXW
         qHGf2Tf8eHcHUK4iBeW8j8TogR5Od+V+9qGZ9LPEHKNlaN2zQogxiYu4DLFjB3/pgPmb
         A7gg==
X-Gm-Message-State: AFqh2ko3EdjfRsU92FrGETM1a5lI08rNDSEJPJmn2zgM/rjjev3yjqh6
	OkXntqru42Q6tteI7QapMdjzdfS3fGUcHQF/
X-Google-Smtp-Source: AMrXdXuL3Au4XFz45cvA/fdqUYejGi9YS5nPMiK85HNa28Mt01e1BoVGsXHpvjp5cf4+lJ5UxMJCwg==
X-Received: by 2002:a5d:5910:0:b0:27c:7c2a:f700 with SMTP id v16-20020a5d5910000000b0027c7c2af700mr35325955wrd.8.1673552026010;
        Thu, 12 Jan 2023 11:33:46 -0800 (PST)
Received: from P-ASN-ECS-830T8C3.local ([2a04:cec0:1054:ad64:c3b0:9f95:abda:1115])
        by smtp.gmail.com with ESMTPSA id q11-20020adf9dcb000000b00268aae5fb5bsm17488396wre.3.2023.01.12.11.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 11:33:45 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [PATCH v2] persist_data: Handle sqlite error when cachefile path is too long
Date: Thu, 12 Jan 2023 20:32:55 +0100
Message-Id: <20230112193255.38994-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 12 Jan 2023 19:33:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14312

Sqlite can't open the cachefile when its path is too long (>= 505 char by
my tests).

We do have a path length check in sanity.bbclass but this code is called
before sanity checks.

Treat the error in the exception instead of checking before hand in case
sqlite eventually fixes this.

Fixes [YOCTO #12374]

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/bb/persist_data.py | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/lib/bb/persist_data.py b/lib/bb/persist_data.py
index ce84a158..bcca791e 100644
--- a/lib/bb/persist_data.py
+++ b/lib/bb/persist_data.py
@@ -249,4 +249,23 @@ def persist(domain, d):
 
     bb.utils.mkdirhier(cachedir)
     cachefile = os.path.join(cachedir, "bb_persist_data.sqlite3")
-    return SQLTable(cachefile, domain)
+
+    try:
+        return SQLTable(cachefile, domain)
+    except sqlite3.OperationalError:
+        # Sqlite fails to open database when its path is too long.
+        # After testing, 504 is the biggest path length that can be opened by
+        # sqlite.
+        # Note: This code is called before sanity.bbclass and its path length
+        # check
+        max_len = 504
+        if len(cachefile) > max_len:
+            logger.critical("The path of the cache file is too long "
+                    "({0} chars > {1}) to be opened by sqlite! "
+                    "Your cache file is \"{2}\"".format(
+                        len(cachefile),
+                        max_len,
+                        cachefile))
+            sys.exit(1)
+        else:
+            raise
-- 
2.30.2


