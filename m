Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BECC433FE
	for <webhook@archiver.kernel.org>; Sat, 26 Mar 2022 20:35:04 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web09.7394.1648326903145747561
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 26 Mar 2022 13:35:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=JpEdz5nr;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id r7so6227990wmq.2
        for <bitbake-devel@lists.openembedded.org>;
 Sat, 26 Mar 2022 13:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B7qKs0RXdT8tcnKNLNvHNimytnJmiwAooEs5nIYh7Dc=;
        b=JpEdz5nrgfwWKVYkWGmueNH/ykgW4QSy59TDiK4wD0XMCloMVl/FKa9q9YASuw3qbD
         EJbp+SoxrsKXOkzxn3BIMIpqJb3iMT4faEHZJ55pBAr5Tcsuf+kL1ulqLBryQQ7fOPFx
         hhuSRmHAPARyv7TVjNDQMDy2CFHkTMQULXIlA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B7qKs0RXdT8tcnKNLNvHNimytnJmiwAooEs5nIYh7Dc=;
        b=O/T/kGwKlApzq0IpF6kSZg8j7VQS5pu+vOYv5ZaA/ZNCy16TUtKaAeGAO+m8a0HMWF
         qu1ninEFp3iFmmlLGdI/eJvUzncmLB5uHQ7ibaLM7ZccO9BD5rODJA6LaqD3rS9mCbOq
         AOWvP3iawMj+tWeUXlwYVqMvBNDILp36n4hhERbDc4TCpS/K6cuokury38IOsI6zFXXh
         rPx07UskpqpZjHE5pjJ1d7roDzTHKUQf1Uv60q9F2tpNFKY9eOsCWGKwy++IXqzbTaVB
         7EW7fc7UtVPOqFcEHl9O7tnqoNllOjbADh8SiNtH729tVZbbitIYsSp4tU0siwtVfJAe
         4PqQ==
X-Gm-Message-State: AOAM530BXj9GjntunKEHrtU45epNvdXsRJSB02D3S/6kNKEOt/CkDkgg
	3wyTzvO3MdyEsGd8YE8jHjkFe9tAlPqNoJvG
X-Google-Smtp-Source: 
 ABdhPJwHyzvfICXpR/PeipLQ1T+jAXlFTXc9PyLmnMCCfakUPYN1eS/OGiBK6/0y3ySG/VVn5UCB5g==
X-Received: by 2002:a05:600c:4f87:b0:38c:adde:1d99 with SMTP id
 n7-20020a05600c4f8700b0038cadde1d99mr25638585wmq.16.1648326901105;
        Sat, 26 Mar 2022 13:35:01 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:3949:59d4:6f55:52f])
        by smtp.gmail.com with ESMTPSA id
 a18-20020a05600c349200b0038ca453a887sm12242586wmq.19.2022.03.26.13.34.59
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 13:35:00 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/6] cooker: Fix exception handling in parsers
Date: Sat, 26 Mar 2022 20:34:53 +0000
Message-Id: <20220326203458.1391301-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 26 Mar 2022 20:35:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13513

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


