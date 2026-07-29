Return-Path: <matt@madison.systems>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B001AC53200
	for <webhook@archiver.kernel.org>; Wed, 29 Jul 2026 14:32:13 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12857.1785335524098161711
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 29 Jul 2026 07:32:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@madison.systems header.s=google header.b=avAr0lYG;
 spf=pass (domain: madison.systems, ip: 209.85.214.172, mailfrom: matt@madison.systems)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2caea3f742bso13441105ad.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 29 Jul 2026 07:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=madison.systems; s=google; t=1785335523; x=1785940323; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UppswYahcDx3QcO2/gZnuqqNY710XJBvZs621KcXdaE=;
        b=avAr0lYG7glEt2yQHAlkKMx38iEc5RdfjbUqpmnB0hJFFdGWoNuQEenedp+/HCT2Vm
         ZZP7N/9KAjBBVHMwpUsOe8H9Qc3QNDLhip9cfkYuj35IlybgFf0zLfNFrDBg+gwPdrkU
         pzK+DsLYHNg6hMahoPylq+3/UvSnOGCNAcPTLtBXuhNSYoV+vbuCeVhmCTv9O1Z+UZ3J
         7qHA4gLHZ8fA4yRv3Jai2A4MTj1PQLlMGQmAZCAygrXuYs/O/lTSaCB2ZWxOiC4HIdHG
         o0Se/VyldsLmKNQ5fDx7G5QOMQqhqZr6JpHsvoxSn3y4li5GpSmoy5ozfE5Nk4GML1mF
         aPTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785335523; x=1785940323;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UppswYahcDx3QcO2/gZnuqqNY710XJBvZs621KcXdaE=;
        b=muG+XR0zRfsTmIEf2RB1Wm/6AlOU4DcEYnXqnrrEO1xVmyIYV0ra1XSsVs7pQ71px3
         PCrB4Gh+IfZQ+KGk7VRPiGLtJ8EJ9xtrESjHSyG/yW1cITQZjzP81BykxkR74zwLPjLR
         w7/kRARUa7q4R6d6Iqhj78/YjbQCMqd11jYqPHTEYJE7ZTpMS/KnBVf1cyGkc2v+VC/p
         HbdXH04Z7/Q2gTg99i44MdD0VM99x+SxLPFROekcyNOpdw2bsGF+YamvWJ40OxfJ05mh
         F5KyPalkNTp4qhykLetlDl/c78MBfiLqT9qesS01dsTAQ8l64+XH35rwDfJuL0YGVpCg
         OfLg==
X-Gm-Message-State: AOJu0YzAm3G+1jSkDWGFy7mG1Ipmp6rdAYiNXpX3HrrH8C1ZJDSEfe3Q
	ybM2nXriLnXvCIrnMNQkg9atez2djkSY/EO79hl2zUoM0vjT0qGW0YLSgfZYIB1gDE1seVOVfOH
	f6fV1
X-Gm-Gg: AR+sD13wSqsXZixLSn4yAfVUia6eb+Ol9Hy9/0fm1I3vJrIRMtUJMNGkvHRC9H9ZGPP
	afc5IZMXH23J899u+3wT3fRxo9U29y88ru+y/jsrMEoSScOMAmQqWuY8iWj348x58yvUejBQNQy
	d5aan8rrv2AqkgX7tUOqJ/xuwVtYcXXxFM1ves//uwD1nx3a2d/8mMEjjpFbGozFhBZTzpWIN4R
	3Lvd/AMulkdLJzNJxoroC92SHvKj1+EO9XVMNYWqzuVNTFVbcq5hY5dvMeLTtKCPh4DFM2r7EvW
	t6R78mPjVZTl3o/YtsYuwHkdjGWe/xApEWu7SGi7H85ige5VIWmrJWLVRiztYvNywVFQNahAJKv
	fCMraqGKF9sAz0JZaP+lOzEi4vwlSOH9nexaTcNHstWA0ISfn6G0w6ovJn3hFkfSPdXP2q04Vav
	Q5uF/wg4oUfg8RRlBmPxuTZPtx/PinW0H5R0+akn0h9xSYZVU88XEn8LiEdzWTtUx3Dxf1n38Bf
	CeaZ8en752b3+yWTg8cHFLzQBHCd8B+2q9tRgpc
X-Received: by 2002:a17:902:f54f:b0:2ca:f40a:be76 with SMTP id d9443c01a7336-2d015d94cb0mr72228055ad.36.1785335523446;
        Wed, 29 Jul 2026 07:32:03 -0700 (PDT)
Received: from visar.local (76-209-242-28.lightspeed.mtryca.sbcglobal.net. [76.209.242.28])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022c3b58dsm12295775ad.79.2026.07.29.07.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 07:32:02 -0700 (PDT)
From: Matt Madison <matt@madison.systems>
To: bitbake-devel@lists.openembedded.org
Cc: Matt Madison <matt@madison.systems>
Subject: [PATCH] parse/ast: improve error handling for invalid task dependencies
Date: Wed, 29 Jul 2026 07:29:24 -0700
Message-ID: <20260729142924.67335-1-matt@madison.systems>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 29 Jul 2026 14:32:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19873

The per-recipe providers handling that went int with commit
fb119c7888ae8a749aa824f8c51780176af077f9 throws a ValueError
exception if an entry in a task's [depends] list is malformed.

This results in a traceback of the form:

  ERROR: Unable to parse <recipe-name>
  Traceback (most recent call last):
    File "<top>/bitbake/lib/bb/cooker.py", line 2334, in parse_next
      raise result
  ValueError: not enough values to unpack (expected 2, got 1)

  ERROR: Parsing halted due to errors, see error messages above

which makes it difficult to find the source of the parsing problem,
particularly if the invalid dependency is added in a bbclass that
is shared across many recipes.

Fix this by catching the ValueError and issuing a fatal error
message with more information about the problem.

Signed-off-by: Matt Madison <matt@madison.systems>
---
 lib/bb/parse/ast.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index e23ef6db3..a372b3534 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -507,7 +507,10 @@ def handleVirtRecipeProviders(tasklist, d):
         taskdeps = (d.getVarFlag(task, "depends") or "").split()
         remapped = []
         for entry in taskdeps:
-            r, t = entry.split(":")
+            try:
+                r, t = entry.split(":")
+            except ValueError:
+                bb.fatal("Error, incorrect format for task dependency (task '%s'): %s" % (task, entry))
             if r in virtprovs:
                 r = d.getVar("PREFERRED_PROVIDER_" + r)
             remapped.append("%s:%s" % (r, t))
-- 
2.43.0


