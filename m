Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954B4C001DF
	for <webhook@archiver.kernel.org>; Tue,  1 Aug 2023 14:38:30 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web10.14474.1690900701057741913
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 01 Aug 2023 07:38:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=XJ17oXDx;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-307d20548adso5139030f8f.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 01 Aug 2023 07:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1690900699; x=1691505499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9zQ4+h7HYsDcWko95jgu8wuevjqvDxJSY6eiOwUPJkE=;
        b=XJ17oXDxDt7VJY5/KTTl9XeAHFh2edw1a8rqavjg29/bnijpiizlEruEpxiMpW9Pt2
         X2Bfkx8JvI7gvdRGxTi8CN1QEQmGrtB4OzApe9BJQ8VKKzbD7PQ+MVfBI2R8ZMUmsYtz
         dIQZefe8tXAfKGXOm5sH/kgoaLrj9tecMJw/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690900699; x=1691505499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9zQ4+h7HYsDcWko95jgu8wuevjqvDxJSY6eiOwUPJkE=;
        b=ep019tqgKFpcslTrPYzjxQbycVdqbC9HZmg+ANGR18JrPyoVoPmvuCSPiuSKBDZ+IF
         9BWJoN+70q/0N3krbsJQfdcCjYgbnN5RWTgDstBx9tETK2HLFS+YdJIbH1Dk+LR/7DLg
         G2CmZ1orU7YAG7VUEM9urHGihhKONlTlgYf7pQQ7pBiPy4CKhHXT+R/p6hEniB6xMyBI
         emZWAu4NAvbM0gaxHP9X6BBXa1JMzCBYTnWTJlpJyiUzQ94q9mBLUJUfLq6hgGTMF/dZ
         5FZ8uyn3BDK/DjumxtrQPlTBRniNEX26Z0srPUq0qzV5Riq1IGGeO9MoTabn6xDSoyUO
         jxaA==
X-Gm-Message-State: ABy/qLaBeHElZChg7D+L5HZlaI2piOR3lsxr7gMF0+VrtgkVY+HnP1id
	ylT6SMzg0GAUERyTFY0DTNqzP2EZGx0jxQGqopo=
X-Google-Smtp-Source: APBJJlEBP17WZoBmJ4XHvT0NQ7K31MiaxSz6/+7oQrQ9wKEu2NdZqy9wq/ts4WV6ygCaJ2H8LCHAWA==
X-Received: by 2002:adf:cd11:0:b0:317:597b:9f92 with SMTP id w17-20020adfcd11000000b00317597b9f92mr2471541wrm.57.1690900699327;
        Tue, 01 Aug 2023 07:38:19 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:e3b7:1714:595d:8417])
        by smtp.gmail.com with ESMTPSA id d14-20020adff2ce000000b003176053506fsm12572887wrp.99.2023.08.01.07.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 07:38:18 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Cc: Christopher Larson <kergoth@gmail.com>
Subject: [PATCH 6/6] bb.tests.data: don't require the func flag for context functions
Date: Tue,  1 Aug 2023 15:38:13 +0100
Message-Id: <20230801143813.2206785-6-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230801143813.2206785-1-richard.purdie@linuxfoundation.org>
References: <20230801143813.2206785-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 01 Aug 2023 14:38:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14905

From: Christopher Larson <kergoth@gmail.com>

Update test_python_snippet_function_reference to not require the 'func'
flag, now that we know the real function will be returned for context
functions without the flag.

Signed-off-by: Christopher Larson <kergoth@gmail.com>
---
 lib/bb/tests/data.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/bb/tests/data.py b/lib/bb/tests/data.py
index b7676859a6..98e430ce2a 100644
--- a/lib/bb/tests/data.py
+++ b/lib/bb/tests/data.py
@@ -80,7 +80,6 @@ class DataExpansions(unittest.TestCase):
     def test_python_snippet_function_reference(self):
         self.d.setVar("TESTVAL", "testvalue")
         self.d.setVar("testfunc", 'd.getVar("TESTVAL")')
-        self.d.setVarFlag("testfunc", "func", "1")
         context = bb.utils.get_context()
         context["testfunc"] = lambda d: d.getVar("TESTVAL")
         val = self.d.expand("${@testfunc(d)}")
-- 
2.39.2


