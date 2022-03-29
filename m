Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D64DC4332F
	for <webhook@archiver.kernel.org>; Tue, 29 Mar 2022 14:28:02 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web12.7341.1648564081034558569
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 29 Mar 2022 07:28:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=hKv7j19b;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.42,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f42.google.com with SMTP id h4so25070156wrc.13
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 29 Mar 2022 07:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B7qKs0RXdT8tcnKNLNvHNimytnJmiwAooEs5nIYh7Dc=;
        b=hKv7j19bDqV1c7o6MGoPABEVvW/n3ljbuw5yZW7bL5NRIYIAAzKr3W8EQygnlFj71t
         1meyIJXY23OkxLApAHq/EQBvb+oC/bZ4N565AFK/vgCxZSqY2Ukm9+vB1mTPLDLrxVpZ
         PJMGT6MWPMRbF4n9bLDFZkNp2tajN3SsWWGUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B7qKs0RXdT8tcnKNLNvHNimytnJmiwAooEs5nIYh7Dc=;
        b=5RLPcqhpXF9nhWT56xPi2ccUzIqHpgLeS2tI6fFIIlWkaq4Z8vQLUvyIMyIIEAG4/u
         wZxox9FjVb8jv8aretCj6eH7FAJ8aOj+wXXx9RNJCVMiIQZS4bm+bpVmaIFwGoS4KJlO
         nCE5IOFVU7E+umse5dMbdRP5UIw8occxyOWQDThrIgsAbPB82Axtn6g6TzRWZjC7Okba
         Vv8izNkXeWhaYgbDK6k3ICLPqydvXakPSx5iGGmtv2lWr3nSb9/8mYwkCn01+UoKqM3q
         TqIN4EPV4xEz3vpaQsvDQi12rWI1v36ET2Ev0/SdPqS90PJdNbYmS1mM2tVPmnrleHvp
         lKvg==
X-Gm-Message-State: AOAM533wu9+SNZkD9Ohs2USw47HPzBHLA3mviwPzQw0dpbmW/tCh21ZI
	eQuFlJ91CTDySkb14PlyjwrvLxRgPrU/G5PP
X-Google-Smtp-Source: 
 ABdhPJxbpakXZVV7+SvIFoif0YrVTxAS9K4nUWsKL8Y8T4C/LPUWoquJJYKnlJWQC2cgzEE33Nyiaw==
X-Received: by 2002:adf:dfc2:0:b0:1f0:262a:d831 with SMTP id
 q2-20020adfdfc2000000b001f0262ad831mr31152605wrn.589.1648564077012;
        Tue, 29 Mar 2022 07:27:57 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:a144:3266:4a07:b254])
        by smtp.gmail.com with ESMTPSA id
 bg42-20020a05600c3caa00b00380deeaae72sm2529043wmb.1.2022.03.29.07.27.56
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 07:27:56 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/6] cooker: Fix exception handling in parsers
Date: Tue, 29 Mar 2022 15:27:50 +0100
Message-Id: <20220329142755.1473185-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 29 Mar 2022 14:28:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13542

We shouldn't be generating exception inside a generator. Rearrange the
code to improve the handling of this. Also fix the misconverted code
from when multiconfig was added and pass the exception as "result".

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index eac956aa97..c4d720a6b6 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -2087,12 +2087,12 @@ class Parser(multiprocessing.Process):
             tb = sys.exc_info()[2]
             exc.recipe = filename
             exc.traceback = list(bb.exceptions.extract_traceback(tb, context=3))
-            return True, exc
+            return True, None, exc
         # Need to turn BaseExceptions into Exceptions here so we gracefully shutdown
         # and for example a worker thread doesn't just exit on its own in response to
         # a SystemExit event for example.
         except BaseException as exc:
-            return True, ParsingFailure(exc, filename)
+            return True, None, ParsingFailure(exc, filename)
         finally:
             bb.event.LogHandler.filter = origfilter
 
@@ -2252,11 +2252,7 @@ class CookerParser(object):
                 pass
             else:
                 empty = False
-                value = result[1]
-                if isinstance(value, BaseException):
-                    raise value
-                else:
-                    yield result
+                yield result
 
         if not (self.parsed >= self.toparse):
             raise bb.parse.ParseError("Not all recipes parsed, parser thread killed/died? Exiting.", None)
@@ -2267,6 +2263,9 @@ class CookerParser(object):
         parsed = None
         try:
             parsed, mc, result = next(self.results)
+            if isinstance(result, BaseException):
+                # Turn exceptions back into exceptions
+                raise result
         except StopIteration:
             self.shutdown()
             return False
-- 
2.32.0


