Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA3AC433F5
	for <webhook@archiver.kernel.org>; Wed, 23 Mar 2022 14:50:49 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web09.10184.1648047048704835209
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Mar 2022 07:50:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=OwV5Rizy;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.54,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f54.google.com with SMTP id d7so2480933wrb.7
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Mar 2022 07:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ice70PKGiDNW9o4HBjRO+xKxJ3Jwg8Pv+ieIL8BvgYI=;
        b=OwV5RizyWj69QNcJ9Gd+Eh4KHltQVZFbXH/YCpiH37clofhSZOKVWKSUAHXjZU2/Li
         y8xVL/os/OzcqxJQBeiRePpVbdiLfRUj3bE7btiJGCI9M1pu4C/P/+13GXy1zOxCExF+
         apDvBh8ccoFiqAMQIriLcaIYcGIkJnxAA1rHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ice70PKGiDNW9o4HBjRO+xKxJ3Jwg8Pv+ieIL8BvgYI=;
        b=osk1bflgYLGvamwoHV+uqIuEbCL4EuwYCh2O/yZgMEkzStSj99wv7TgrLSa9ftDZqK
         ECK1Nbi5VbErM7vwiPqIN2H7MF3ZrexLwFJHnFFVj7Kb04bIfKJZd2VeIqXkGYMlbKma
         VPJlAHg54pno7tx1ev3NgRwkfXjP0CrEW1eLrjgvYtKYiwslPxDDCkTQ/1ELV6oR95UM
         1kxaB+ojzPnqcE9lAhm1X6Zw9aIERsshrSnlvAe7vc4T9JvDB2Ip4MtbBk2b8ltHP1qf
         bYWmVKPyhezXYUnxvwGuDSdxg8MKeMyafEwqW/nkbiVGwZI0e/BPL6cSSeIwu83Gy3S6
         YGpg==
X-Gm-Message-State: AOAM530N5KZ/+efCfpNxr9+79MVB8hkA5+I08f1DW1VhmIvrGRnKjjeT
	5p+7dWyHu4iWE486pPE8bNplxahm9RPyOc2T
X-Google-Smtp-Source: 
 ABdhPJyGuT5Cz15//TgiSvC0qifTRQnLS2U7OE98fi7FIzuGiFZcvSb+6dXk3nFmXmAxAd/x4h0GEQ==
X-Received: by 2002:a5d:588a:0:b0:204:1f72:2d90 with SMTP id
 n10-20020a5d588a000000b002041f722d90mr119312wrf.651.1648047046163;
        Wed, 23 Mar 2022 07:50:46 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:aaba:716e:9c38:ad87])
        by smtp.gmail.com with ESMTPSA id
 l10-20020a05600002aa00b0020414b4e75fsm82342wry.85.2022.03.23.07.50.44
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 07:50:45 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] utils: Fix lockfile path length issues
Date: Wed, 23 Mar 2022 14:50:44 +0000
Message-Id: <20220323145044.1277801-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 23 Mar 2022 14:50:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13499

If the path to bitbake.lock is in a deep directory, bitbake will hang. The
reason was that the max file length limiting code (to 255 chars) was including
the directory name and it should only act on the filename within the directory.
Fix it to just use the base filename.

[YOCTO #14766]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/utils.py | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index fcaeb99162..d11da978d7 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -453,13 +453,16 @@ def lockfile(name, shared=False, retry=True, block=False):
     consider the possibility of sending a signal to the process to break
     out - at which point you want block=True rather than retry=True.
     """
-    if len(name) > 255:
-        root, ext = os.path.splitext(name)
-        name = root[:255 - len(ext)] + ext
+    basename = os.path.basename(name)
+    if len(basename) > 255:
+        root, ext = os.path.splitext(basename)
+        basename = root[:255 - len(ext)] + ext
 
     dirname = os.path.dirname(name)
     mkdirhier(dirname)
 
+    name = os.path.join(dirname, basename)
+
     if not os.access(dirname, os.W_OK):
         logger.error("Unable to acquire lock '%s', directory is not writable",
                      name)
-- 
2.32.0


