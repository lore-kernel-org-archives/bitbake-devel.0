Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0BCCC001DF
	for <webhook@archiver.kernel.org>; Tue,  1 Aug 2023 14:38:20 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web10.14472.1690900699074839337
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 01 Aug 2023 07:38:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=eH6SYr8q;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-3fbea14700bso53895895e9.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 01 Aug 2023 07:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1690900697; x=1691505497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lhmHqDgb3DfaCTKvBsZiA1byhpAWcvHXDbDS37NaWdc=;
        b=eH6SYr8qtjZHRyKvFOVGgX22kYFkU/Vnrch7Ela03l8M8QsYxsEC5xn9Gp4N7OqUVa
         86PzG7PfYWeSU3ziB93yDZh8OvAlr4RZmH7sFwZ0qh6Y9zQ2ePOZhATMcWV1WjzJ1NMB
         5xHQFpLrAOKzBjGNpOR6dpykbCbpG5l4llBtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690900697; x=1691505497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lhmHqDgb3DfaCTKvBsZiA1byhpAWcvHXDbDS37NaWdc=;
        b=eqAHOPuhEZUHUmHgVOWeoObtFhrzwKkoLyB31j59iL13KFHDpd0C5kndjRT1FTiWbH
         u76PiwcOT1gPe+qtuTHBg/dM86YmvLfpoR+SdLnCe+Pr4sI41WJN1cJbhyzNwdzXU60Y
         Pz39UdrIrZuueSTv20cRWNVdz1ncu1cCO2m2JNNAux7fuHDtDzHz9rGthIOzFKkRE6EL
         XFmfgtDUYmuFg8LV8P9ywiaUhf0Ko2Z6MN8AL6I4U76TI6BO/TTStcL+GCslvHA2oKsd
         mBAG4rmCm0M4CpR3JlydRqgSy24fj6WQhZPfQOtPL9V2IWVqGXhphZS5K7CoYA+ZzHx9
         t2mQ==
X-Gm-Message-State: ABy/qLauHtwbsFNYDL3+UfaWyBU1NMkMSljnZyHGbRHLpl4s1g9ZXAdw
	uxhrh7oA0ffnEWPTAxZcGC2vZt0daECP5IoZRL0=
X-Google-Smtp-Source: APBJJlE7AQQXAi8o0CNQstIC4olYokb+tAJwECEyOSKyGI23tS0MSVSheB4zTWEnLTXvZf9QgA6zTw==
X-Received: by 2002:adf:e848:0:b0:30a:f030:8637 with SMTP id d8-20020adfe848000000b0030af0308637mr2487362wrn.22.1690900697334;
        Tue, 01 Aug 2023 07:38:17 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:e3b7:1714:595d:8417])
        by smtp.gmail.com with ESMTPSA id d14-20020adff2ce000000b003176053506fsm12572887wrp.99.2023.08.01.07.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 07:38:16 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Cc: Christopher Larson <kergoth@gmail.com>
Subject: [PATCH 4/6] tests.data: add test for builtin preferred over metadata value
Date: Tue,  1 Aug 2023 15:38:11 +0100
Message-Id: <20230801143813.2206785-4-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230801143813.2206785-1-richard.purdie@linuxfoundation.org>
References: <20230801143813.2206785-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 01 Aug 2023 14:38:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14903

From: Christopher Larson <kergoth@gmail.com>

This test makes sure that '${@eval()}' calls the eval builtin, even if an 'eval' variable is defined in the metadata.

Signed-off-by: Christopher Larson <kergoth@gmail.com>
---
 lib/bb/tests/data.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/bb/tests/data.py b/lib/bb/tests/data.py
index 251130b857..b7676859a6 100644
--- a/lib/bb/tests/data.py
+++ b/lib/bb/tests/data.py
@@ -86,6 +86,10 @@ class DataExpansions(unittest.TestCase):
         val = self.d.expand("${@testfunc(d)}")
         self.assertEqual(str(val), "testvalue")
 
+    def test_python_snippet_builtin_metadata(self):
+        self.d.setVar("eval", "INVALID")
+        self.d.expand("${@eval('3')}")
+
     def test_python_unexpanded(self):
         self.d.setVar("bar", "${unsetvar}")
         val = self.d.expand("${@d.getVar('foo') + ' ${bar}'}")
-- 
2.39.2


