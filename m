Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84839C4332F
	for <webhook@archiver.kernel.org>; Thu, 24 Nov 2022 17:00:41 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web11.28873.1669309240430745124
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 24 Nov 2022 09:00:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=cNOUjI6W;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f52.google.com with SMTP id b12so3308599wrn.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 24 Nov 2022 09:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=EwKYqDdtMR6W+NJdVQESOck9O309Wvc59qf2/DJO26c=;
        b=cNOUjI6Wrfg0rAfkRRvQQP5qzHSZmguyQjBMLWpzQNixgM4nFbaxcQKuqQL6y61LrA
         db4OoSmO8x599h977KFRbcmA420pKucqkfjlgf72V1ivnUhsq9OT4ETmoCotz+vBIAv2
         AI1XZQ7VSuAtNUUJ0Nnaf53es2TcwMhmkGlu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EwKYqDdtMR6W+NJdVQESOck9O309Wvc59qf2/DJO26c=;
        b=yCpqxKsI9frdY3CjWPrUGiY1dHbl0fV3hKQXsVNd6/QdMvtEbtwyvK/efW1Jdd39sW
         YkRAgtGdeF6H+QiUxwKeR2udvafKkAoKI+h/FNo6UUadKaPqh61pfriI0tmCV7zSL2LG
         sVWrBkfxqGJol2mWCqlm5sdtX2kmiRg9frT/YcfqFccTHIMI7canyAuWkhj28tjOxpAP
         L6PA+7XXCcKyCnk0+G/mIIC1Af4d1WAqU/MSUrjOZP0WIHxDRSV6MHVDYxQnxh0kT+75
         EjoVOKKEKCwHQboD29Rr++u9jgcYk2t/pescJqfOJzov6csu2FD5xvw3EfCw6iEmweqU
         Riuw==
X-Gm-Message-State: ANoB5pnzjSZO0qRXfbW2HpMWd5H7Qaed7H4uIeV3EY91oX+h9hgI9z7s
	D/qGLzmCm8Q9iA3J9m99GH9rjn6PEhAjiw==
X-Google-Smtp-Source: AA0mqf4gBsURla8rukTFDH9c7EKfn8m0EC6ZCEulGiBaKBJQBFy/3PMURj0dZ0XCIhAtMnM5UvE4AQ==
X-Received: by 2002:a05:6000:1f91:b0:241:ba9b:b47e with SMTP id bw17-20020a0560001f9100b00241ba9bb47emr19931267wrb.96.1669309238221;
        Thu, 24 Nov 2022 09:00:38 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:4038:3d32:5f00:5957])
        by smtp.gmail.com with ESMTPSA id bs30-20020a056000071e00b002364c77bcacsm1731539wrb.38.2022.11.24.09.00.37
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 09:00:37 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] data_smart: Add debugging for overrides stability issue
Date: Thu, 24 Nov 2022 17:00:36 +0000
Message-Id: <20221124170036.3976664-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 24 Nov 2022 17:00:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14109

If someone is unfortunate enough to run into override recursion issues
they're hard to debug with the existing message. We can at least show the
values that OVERRIDES takes to show there is some problem and aid debugging.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/data_smart.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 5415f2fccf..fd05451971 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -486,12 +486,14 @@ class DataSmart(MutableMapping):
             return
         if self.inoverride:
             return
+        overrride_stack = []
         for count in range(5):
             self.inoverride = True
             # Can end up here recursively so setup dummy values
             self.overrides = []
             self.overridesset = set()
             self.overrides = (self.getVar("OVERRIDES") or "").split(":") or []
+            overrride_stack.append(self.overrides)
             self.overridesset = set(self.overrides)
             self.inoverride = False
             self.expand_cache = {}
@@ -501,7 +503,7 @@ class DataSmart(MutableMapping):
             self.overrides = newoverrides
             self.overridesset = set(self.overrides)
         else:
-            bb.fatal("Overrides could not be expanded into a stable state after 5 iterations, overrides must be being referenced by other overridden variables in some recursive fashion. Please provide your configuration to bitbake-devel so we can laugh, er, I mean try and understand how to make it work.")
+            bb.fatal("Overrides could not be expanded into a stable state after 5 iterations, overrides must be being referenced by other overridden variables in some recursive fashion. Please provide your configuration to bitbake-devel so we can laugh, er, I mean try and understand how to make it work. The list of failing override expansions: %s" % "\n".join(str(s) for s in overrride_stack))
 
     def initVar(self, var):
         self.expand_cache = {}
-- 
2.34.1


