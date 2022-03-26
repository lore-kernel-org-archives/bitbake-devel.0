Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3503DC433FE
	for <webhook@archiver.kernel.org>; Sat, 26 Mar 2022 20:35:08 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web09.7398.1648326906979227936
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 26 Mar 2022 13:35:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Au4bgELc;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.41,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f41.google.com with SMTP id r7so13964978wrc.0
        for <bitbake-devel@lists.openembedded.org>;
 Sat, 26 Mar 2022 13:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=UFVsoLpNIWkR4K/8j9+y3Z4oAAAD1Nsg1NnP9wX8mXw=;
        b=Au4bgELcVm0dFxstwqrTIxg0hwa1ywwqvwGDI8M+TS8Z7qAnJV1GgpKgHWld4C57xR
         wMrjr/Sr4HOIpX/MvPPqg5YSjOsmrEhPn/Ysn1B5mWnioM2fKRwTe1c3fASheAyCdF94
         91o8oFIF2rA7ZkrA/SXfncgP9c18nnJjltYHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UFVsoLpNIWkR4K/8j9+y3Z4oAAAD1Nsg1NnP9wX8mXw=;
        b=0WibSD2PIzhBmso9YfYvTPLL5O6L0mGzuze53YIM9npEYIrlRLtd8eIaAqbF/l4nze
         S/4mQJj56LhwqXnnDGBakFkvVqWTuFmPgGYf4k3tpShWENrqhHMgH14HNPvlxxzMWmwQ
         9k89LI0ycXKmwRb7TSwQYljZiFwVrH8X2Z1caRcql1hxupTHRQA7HlSqLtfFEhEWB6Td
         gxLtO472QACydFBWPiUd0NMRUYbN2sm/iRs4KdNpvjmWkblrWSx3A/7dLICoTGiYCcb7
         8OFOuxpzKvNnGXkbCQhqd8tA5XpR/8IrC8M/BUARaxTeXYL7Da/FiAqmjmDld5L4pRbD
         9upQ==
X-Gm-Message-State: AOAM533dJTUYf6FlzQFPCwJgCbh7v3WMPjzzFanhnT2Plz1usW/hiHZU
	5tGIXIKXTO5ysblbb6LOaGWcYU+p3lNYgufW
X-Google-Smtp-Source: 
 ABdhPJwl+gJux3ZVa8l/oIt2kqSSRThwugEpHfwLL4ITHGVL8hCFMO6pyj0YQmvgawfM+7DvyflX5Q==
X-Received: by 2002:adf:e748:0:b0:204:fbe2:932d with SMTP id
 c8-20020adfe748000000b00204fbe2932dmr15535819wrn.305.1648326905242;
        Sat, 26 Mar 2022 13:35:05 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:3949:59d4:6f55:52f])
        by smtp.gmail.com with ESMTPSA id
 a18-20020a05600c349200b0038ca453a887sm12242586wmq.19.2022.03.26.13.35.04
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 13:35:04 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 5/6] cooker: Ensure parsing processes have close called
Date: Sat, 26 Mar 2022 20:34:57 +0000
Message-Id: <20220326203458.1391301-5-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220326203458.1391301-1-richard.purdie@linuxfoundation.org>
References: <20220326203458.1391301-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 26 Mar 2022 20:35:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13517

With pyhon 3.7 there is a close method which collects the process' return
value and ensures zombines don't hang around. Add that call. Also join terminated
processes before closing since the signal might not be instantaneous.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 2264b18c54..4b8b18a68d 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -2198,8 +2198,10 @@ class CookerParser(object):
             if force:
                 process.join(.1)
                 process.terminate()
-            else:
-                process.join()
+            process.join()
+            # Added in 3.7, cleans up zombies
+            if hasattr(process, "close"):
+                process.close()
 
         self.parser_quit.close()
         # Allow data left in the cancel queue to be discarded
-- 
2.32.0


