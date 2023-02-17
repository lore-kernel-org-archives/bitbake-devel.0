Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 904C7C636D4
	for <webhook@archiver.kernel.org>; Fri, 17 Feb 2023 12:15:43 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web10.5084.1676636135978585703
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 17 Feb 2023 04:15:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=IGn2lbd1;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f41.google.com with SMTP id a12so897636wro.7
        for <bitbake-devel@lists.openembedded.org>; Fri, 17 Feb 2023 04:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+j8L+J8f8EhR6KrMrD0pZegrMQDLMc/3pe4WztKEkgY=;
        b=IGn2lbd1x49ULPveYdcTbhhanhz/4N1qTXDEiUjDBSnR0CsKDGdKKmHRVF2kRUHFPM
         4ygm7lOQbrt9FJLzJi9R+tY0PyjEyvtNd/SIwtQSc/jVlzSIVsn1XPZ6Xr8NuUWm/vha
         dJK1UXEJTK+PbZJXdu4NLziG0i13t5KRFpExY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+j8L+J8f8EhR6KrMrD0pZegrMQDLMc/3pe4WztKEkgY=;
        b=xcNNSUP1JGaZRACq69V2TcFvjuN07J262Phmux3pj64MavEsHBT6FZAdaJeGV1gHQX
         TLH/6MOG6uQm5OSgYsBdZQMqXpXDj6tVaf8oEnKGB5zlgaBEu3uPiJ4oqbj3p1ZbEMHM
         Xxa6OTLZXayOkk1srhCipodOAmlj0ptnk4lsA34hq6ZRtygLCM2AgBnUEJJHI9noQ1GX
         54Ti/0svhiVPw1Di+UtKCRiJ3AYDuZyYEVv0ZP96xKDNGzieMCIZXug1faFpTuV0q5K9
         AAQgLHcioAsQ86zdZ8sP6XNY+e5Hlk/o7nsVPja9NIMKygQsOFbEEpAHjfYayuVQ5mWw
         /0pg==
X-Gm-Message-State: AO0yUKVvvSRjzjkIiC4jTdPceEUSJ6NLXEj3OSbuiwZN3+X3gBQqcfE+
	XBippCDWrYqrUbp8M9a0S7Pre/41t+G1zltj
X-Google-Smtp-Source: AK7set/30OJZmuiYXS3N6z9AAmcq+Kfw9A0eviQc1+Y82XoHbDoSFZyyvDXjddDc4moY3nr03p/7dg==
X-Received: by 2002:adf:f10a:0:b0:2c5:60e6:ebe with SMTP id r10-20020adff10a000000b002c560e60ebemr7831284wro.66.1676636133971;
        Fri, 17 Feb 2023 04:15:33 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:33b5:dd6c:d0ba:e1ab])
        by smtp.gmail.com with ESMTPSA id d8-20020adfe2c8000000b002c3ea5ebc73sm4047424wrj.101.2023.02.17.04.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 04:15:33 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Cc: Martin Jansa <martin.jansa@gmail.com>
Subject: [PATCH] cookerdata: Improve early exception handling
Date: Fri, 17 Feb 2023 12:15:32 +0000
Message-Id: <20230217121532.340416-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 17 Feb 2023 12:15:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14448

Martin Jansa reported that if you put a syntax error into an imported
module such as qa.py in OE, no error is shown.

Part of the issue appears to be that the catch_parse_error() decorator only
catches certain exceptions and SyntaxError isn't one of them. As far as I can
tell we should remove all the special cases and use the more advanced code
in all cases, not just expansion errors.

I confirmed this now prints a proper error message for a qa.py syntax error.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cookerdata.py | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index 1658bee93c..2d52ce4c8f 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -160,12 +160,7 @@ def catch_parse_error(func):
     def wrapped(fn, *args):
         try:
             return func(fn, *args)
-        except IOError as exc:
-            import traceback
-            parselog.critical(traceback.format_exc())
-            parselog.critical("Unable to parse %s: %s" % (fn, exc))
-            raise bb.BBHandledException()
-        except bb.data_smart.ExpansionError as exc:
+        except Exception as exc:
             import traceback
 
             bbdir = os.path.dirname(__file__) + os.sep
@@ -177,9 +172,6 @@ def catch_parse_error(func):
                     break
             parselog.critical("Unable to parse %s" % fn, exc_info=(exc_class, exc, tb))
             raise bb.BBHandledException()
-        except bb.parse.ParseError as exc:
-            parselog.critical(str(exc))
-            raise bb.BBHandledException()
     return wrapped
 
 @catch_parse_error
-- 
2.37.2


