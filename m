Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBCCC433EF
	for <webhook@archiver.kernel.org>; Sat, 26 Mar 2022 20:35:09 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web09.7399.1648326907765045724
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 26 Mar 2022 13:35:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=EAVKXjME;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.51,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f51.google.com with SMTP id r7so13965010wrc.0
        for <bitbake-devel@lists.openembedded.org>;
 Sat, 26 Mar 2022 13:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ty+YthLjsrx5Q54ndd2odgUrNeaz/zyoQXuoqYS5K48=;
        b=EAVKXjME4LqgqjbbzQa+cvG8Ko+4jRRFx7SLAgA44WrFGb+SRtBfsy3Oz5kV7+bOSq
         U3g/VTs/ngkYv1UmRkz4zvW+EZVnCIgqayDNbCYe0R2vl9YtTktA7sMR0u+nYlGs6kGi
         WCZHRuj/dWGO6YUJ7KHXMXLoGRfwfz3KfUizQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ty+YthLjsrx5Q54ndd2odgUrNeaz/zyoQXuoqYS5K48=;
        b=k1VZz42usF+DoyGhdWvDjKQkMwryR6Ls9gp2bNm3Lrs+Fle3Sjsh9/yd/6iF63/1Dc
         pXeLGjpWXcucjnpZubpw5GWOMph7dl0b6az3oHoyNpyJikuXlMebINr30Zg8Me+YiZDE
         28QV54DH/j5IhPSig5Vtnyy8cgiphBIr2rVprQ4s5ei6npmHIbU8PQplzm3jP4Q3AL07
         kXZo3Y4kj4m5dtwpuzy+7hX1oi3bbSuf2AOMc1aeb8DHOVz8ZP2TC4kJ6SojVQXvm9Fv
         44BpMWuI/rGXVr4KjaEzSX1PD8Y7FLGOuLGMd2SFXYlp4YWKnXRnWOq8Dy4uvcAg31Vp
         JM+w==
X-Gm-Message-State: AOAM532InPJ7xTD41wrGsEfiq96Jv/JfbO9Imx43nQoP0xrhToBOv0Ih
	tgfRguy89BLOoUN+L3PQpnpxIMX4eodCVXzV
X-Google-Smtp-Source: 
 ABdhPJyHu16oyS39HQj/HS8KM7LXLHUOVtVw9fOlXOT1+VfNMWam8Ffvsf8VyebvzgUAkoTa1HHNYA==
X-Received: by 2002:adf:f40c:0:b0:203:e768:ae54 with SMTP id
 g12-20020adff40c000000b00203e768ae54mr14581334wro.488.1648326906073;
        Sat, 26 Mar 2022 13:35:06 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:3949:59d4:6f55:52f])
        by smtp.gmail.com with ESMTPSA id
 a18-20020a05600c349200b0038ca453a887sm12242586wmq.19.2022.03.26.13.35.05
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 13:35:05 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 6/6] cooker: Pass SIGINT to parsing processes at shutdown
Date: Sat, 26 Mar 2022 20:34:58 +0000
Message-Id: <20220326203458.1391301-6-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220326203458.1391301-1-richard.purdie@linuxfoundation.org>
References: <20220326203458.1391301-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 26 Mar 2022 20:35:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13518

To try and improve shutdown, sent SIGINT to parsing processes now it
is handled safely around locks, perhaps avoiding the need for the more
risky SIGTERM.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 4b8b18a68d..bd7ab8ac3c 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -2146,7 +2146,7 @@ class CookerParser(object):
             def init():
                 signal.signal(signal.SIGTERM, signal.SIG_DFL)
                 signal.signal(signal.SIGHUP, signal.SIG_DFL)
-                signal.signal(signal.SIGINT, signal.SIG_IGN)
+                signal.signal(signal.SIGINT, signal.default_int_handler)
                 bb.utils.set_process_name(multiprocessing.current_process().name)
                 multiprocessing.util.Finalize(None, bb.codeparser.parser_cache_save, exitpriority=1)
                 multiprocessing.util.Finalize(None, bb.fetch.fetcher_parse_save, exitpriority=1)
@@ -2194,6 +2194,9 @@ class CookerParser(object):
             except queue.Empty:
                 break
 
+        for process in self.processes:
+            os.kill(process.pid, signal.SIGINT)
+
         for process in self.processes:
             if force:
                 process.join(.1)
-- 
2.32.0


