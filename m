Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7707C54EB4
	for <webhook@archiver.kernel.org>; Sat, 21 Jan 2023 21:23:18 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web10.6416.1674336189293731324
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 21 Jan 2023 13:23:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=CBDvD0gg;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f49.google.com with SMTP id e19-20020a05600c439300b003db1cac0c1fso6617626wmn.5
        for <bitbake-devel@lists.openembedded.org>; Sat, 21 Jan 2023 13:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kiODrOxDLTX7OAao2Zl3XyRXGy62wfH5vN9Ot44z2dg=;
        b=CBDvD0gg5ssmCEYm+nfN5zAkV4A+uSqOgokU/DC+XDcT2kTHqTvjkPiNnhiPmXvpZ0
         WdQ9wkoznrjtUvXfHqufDM8ooBEwrmQW9cpZF5F8n8Cu2GXY6GEXRtv6BuCu1y1xIvHJ
         vtZf8ZSkaw23GdAcDPomcxtzuzLC5TktrzKyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kiODrOxDLTX7OAao2Zl3XyRXGy62wfH5vN9Ot44z2dg=;
        b=ufd+U3iewwOFkUNW18RqhXBupBwro3TysbYm1LVlCb31Ywfm62VCIByKHQR/e3th0y
         hvUzBT3bX4sjd8Cm/jMSqyaXoTBefU9w6vfpRMp6Z/w3Fcr7jAsSlEr7W1XEu24h7hMz
         0deetr/Tdj0OXneEbl7rrOj0hErNit7yrA0yBsesR9gAjIQveLcU6O9scsuDYX9r7KxA
         w6O2uzIRXIsVUcI/esSFrfzT/+RANKg9C0mcwZcPElkgIX1FPHzRe5BDk9e/rmIgEtQr
         KKGzk0Sy85mZV/eYd5QPWXC5EchqZeL6+8xi2RtOmWr0iJJu+RsH+BwqQOgiDkZ4x3vS
         pCZQ==
X-Gm-Message-State: AFqh2ko/8ZTjyk/8WFDqjk0N6k+PcE7yFB7EY21HOgFy167D6DIRPQTa
	DhtSVgLkF0yDw/PeymHQp81vFm4TsiUR48sG
X-Google-Smtp-Source: AMrXdXsHdqra0RrGn6JGYA5yVpSojin7h8TM8BH2w1vXp7ApO4+B25jFQ0xhzVzs0CJsNZgzaYKdoA==
X-Received: by 2002:a05:600c:4f83:b0:3db:eab:a600 with SMTP id n3-20020a05600c4f8300b003db0eaba600mr15570091wmq.7.1674336187664;
        Sat, 21 Jan 2023 13:23:07 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:3f1f:fd3b:ca38:d2c5])
        by smtp.gmail.com with ESMTPSA id p16-20020a05600c359000b003da105437besm6713089wmq.29.2023.01.21.13.23.07
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 13:23:07 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 3/6] cache: Only write files if we have data
Date: Sat, 21 Jan 2023 21:23:02 +0000
Message-Id: <20230121212305.2171310-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230121212305.2171310-1-richard.purdie@linuxfoundation.org>
References: <20230121212305.2171310-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 21 Jan 2023 21:23:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14331

By writing the cache files only if there is data to write, we can save a
bit of time.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cache.py | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index ee924b2d2b..c19fe26f1b 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -873,6 +873,14 @@ class MultiProcessCache(object):
         if not self.cachefile:
             return
 
+        have_data = False
+        for c in self.cachedata_extras:
+            if c:
+                have_data = True
+                break
+        if not have_data:
+            return
+
         glf = bb.utils.lockfile(self.cachefile + ".lock", shared=True)
 
         i = os.getpid()
@@ -907,6 +915,8 @@ class MultiProcessCache(object):
 
         data = self.cachedata
 
+        have_data = False
+
         for f in [y for y in os.listdir(os.path.dirname(self.cachefile)) if y.startswith(os.path.basename(self.cachefile) + '-')]:
             f = os.path.join(os.path.dirname(self.cachefile), f)
             try:
@@ -921,12 +931,14 @@ class MultiProcessCache(object):
                 os.unlink(f)
                 continue
 
+            have_data = True
             self.merge_data(extradata, data)
             os.unlink(f)
 
-        with open(self.cachefile, "wb") as f:
-            p = pickle.Pickler(f, -1)
-            p.dump([data, self.__class__.CACHE_VERSION])
+        if have_data:
+            with open(self.cachefile, "wb") as f:
+                p = pickle.Pickler(f, -1)
+                p.dump([data, self.__class__.CACHE_VERSION])
 
         bb.utils.unlockfile(glf)
 
-- 
2.37.2


