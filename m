Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E6CC43217
	for <webhook@archiver.kernel.org>; Mon, 28 Nov 2022 23:48:13 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web10.135191.1669679287825634249
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 28 Nov 2022 15:48:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=FJb+IyAb;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f43.google.com with SMTP id h11so12239060wrw.13
        for <bitbake-devel@lists.openembedded.org>; Mon, 28 Nov 2022 15:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Did4kpmIeEPkp4baTCUZbikNzT5HugTSBzsHSNjFFo4=;
        b=FJb+IyAbGddZwQbRMleVaYmHDX0sgoWRRHdPkE1iqC4C2nwjHtrnlKcbRBlQTrhAvs
         BIKC77mlpDa8u/2fo0A6vbJRRqY4YmxDKrOoC8OXXsjR85l486VuZCKuj7intjw+T9sd
         CnnGwOfR18ONJd/+GcB7IfPE8YnFOiyo7/dos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Did4kpmIeEPkp4baTCUZbikNzT5HugTSBzsHSNjFFo4=;
        b=13gK20Mrr33ltL4ZQdWbCyU1ZY9z5xqHs45zcqvgYB9XhENvvEKk+9i+1ND+tS+NmW
         pLKkESM9wV8oBwqrxtBcoKcPc1nXS+nFBe+QdU3CKBvDkxVBgvKfxuBPUravGbAKcnPa
         eUCh5r3f2nWhKBLU/3AMJAVl7sBBplzFThHX2nKB4XouM5IGxRI5EjkRqRAUqSfeoxqO
         Ax5cBN4CfeU4CX2L3YzT01IeD6txTniLdKm1h1iX/vXK0hACYd9BU5kUfxM1WWMcAKJT
         F0OVnArcBFW8wa1xrazppmF5/PgxKBIfsEpOI7Gq6tTyayM2NVTltfG+trD+j4A/TN6T
         BZ2g==
X-Gm-Message-State: ANoB5pmi81OwR/Da0oiYc2/aYERc1duT6uBY+gDqBzMgn/eKVFP+idsM
	VHoK7Eb93LBRq/yqoIoXJcajou2HW6BKzw==
X-Google-Smtp-Source: AA0mqf7Nhlp/8SNXALXNmhD7D+Zuh1RXEM2gLYnNMHtFMzv9yRv92GlWvXfziA6lEOfrIQ85cwXBeg==
X-Received: by 2002:a5d:5a95:0:b0:241:65d4:8b41 with SMTP id bp21-20020a5d5a95000000b0024165d48b41mr31910958wrb.470.1669679286095;
        Mon, 28 Nov 2022 15:48:06 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:426:d29f:e451:e2dd])
        by smtp.gmail.com with ESMTPSA id q128-20020a1c4386000000b003c71358a42dsm99245wma.18.2022.11.28.15.48.05
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 15:48:05 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] data_smart: Small cache reuse optimization
Date: Mon, 28 Nov 2022 23:48:04 +0000
Message-Id: <20221128234804.752271-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 28 Nov 2022 23:48:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14124

Currently the expand cache doesn't work for "parser" return types, which
is the main type used by the build_dependencies() call that we spend most
of the time in when parsing. Tweak the code to cache the unexpanded value
in the expand cache and hence allow reuse of the parser in other fast path
cases for small speed gains.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/data_smart.py | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 246c446e4a..e2c93597e5 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -92,10 +92,11 @@ def infer_caller_details(loginfo, parent = False, varval = True):
             loginfo['func'] = func
 
 class VariableParse:
-    def __init__(self, varname, d, val = None):
+    def __init__(self, varname, d, unexpanded_value = None, val = None):
         self.varname = varname
         self.d = d
         self.value = val
+        self.unexpanded_value = unexpanded_value
 
         self.references = set()
         self.execs = set()
@@ -447,9 +448,9 @@ class DataSmart(MutableMapping):
     def expandWithRefs(self, s, varname):
 
         if not isinstance(s, str): # sanity check
-            return VariableParse(varname, self, s)
+            return VariableParse(varname, self, s, s)
 
-        varparse = VariableParse(varname, self)
+        varparse = VariableParse(varname, self, s)
 
         while s.find('${') != -1:
             olds = s
@@ -775,6 +776,9 @@ class DataSmart(MutableMapping):
                 return None
             cachename = var + "[" + flag + "]"
 
+        if not expand and retparser and cachename in self.expand_cache:
+            return self.expand_cache[cachename].unexpanded_value, self.expand_cache[cachename]
+
         if expand and cachename in self.expand_cache:
             return self.expand_cache[cachename].value
 
-- 
2.34.1


