Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80296C4345F
	for <webhook@archiver.kernel.org>; Fri, 12 Apr 2024 17:03:45 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web10.52662.1712941418112971057
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 12 Apr 2024 10:03:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=aI0lwkw2;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-417d14c3411so11469365e9.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 12 Apr 2024 10:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1712941416; x=1713546216; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=D5wD4mGDS9QrcFza+GqsKZ48foaV/gBWv+FVUTGKyho=;
        b=aI0lwkw2PeEjuSVnnt29DTbKVITSnp+d7KobFKUZTYlT6C8WFEcOtUtgIfs2kzNdLW
         PZiBk/l8MmCpb2oKJTLwmwcYcQ1oO4aH2R/ZeeKpPi5FEDOtuH45xLbRFIZLZMvR9eBd
         S9I38bl7CbSvN85xGUSc4udDHOJtw80A2ciaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712941416; x=1713546216;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D5wD4mGDS9QrcFza+GqsKZ48foaV/gBWv+FVUTGKyho=;
        b=SKlzWDjE9TwKPd6jkDUy+sezQJN2mIOA9qJi7QeD2sNFwTmWrCiAinTR5WT8F/cxXw
         sa7/KMS9J204DPj96FKv1KwyFUCqZW7ZYhRmbLuJds+BGZWH9+Gl74z52YMk7ofgW1V1
         SG7VE3m7noKXCjk6CWkUU1hIcm2zDEDBP1o8fhAA2kxttPdA5qa5G5bcjLy505GFsdvz
         BHezvvGCxzhW0znK3NWFkN/1C+ZwuqiWPi2/x9d7uOviU0XJ+BpQllyyMvtQRzmt7Ty/
         eEIN9fhjYsNGUq7PmjL7J2uOFF6Bf35CZmnmgveGvwxxHJRtJjGxr0r/4GZa4BxM+92h
         zLLQ==
X-Gm-Message-State: AOJu0YwgcNKv45Gyk4Z1S8YBUSC7fsOP4nLmOUWWotg/Re4lajm7hv+e
	Qt3dZFjPthdbe9LLsumaRjR7eMZXOCShrKvidBtL1MH5kqtUqrcS5pttUyY+2iNUf+MePHzpeqD
	XEj8=
X-Google-Smtp-Source: AGHT+IEieGfgOpzjoWbndaUeOIfJyTqLl9nSIlk4MLdOOIdDwe+BFufjdXngGOzQypSvrymunVNJyQ==
X-Received: by 2002:a05:600c:1c82:b0:418:19d4:f9eb with SMTP id k2-20020a05600c1c8200b0041819d4f9ebmr208950wms.12.1712941416050;
        Fri, 12 Apr 2024 10:03:36 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:555f:bec2:a7d5:9e31])
        by smtp.gmail.com with ESMTPSA id n21-20020a05600c3b9500b00416928e239csm6250787wms.35.2024.04.12.10.03.35
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 10:03:35 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] BBHandler: Handle unclosed functions correctly
Date: Fri, 12 Apr 2024 18:03:35 +0100
Message-Id: <20240412170335.2321226-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 12 Apr 2024 17:03:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16090

A function accidentally defined as:

somefunction() {
	:
 }

which is unclosed due to the space at the end, would currently silently
cause breakage. Have the parser throw and error for this.

[YOCTO #15470]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/parse/parse_py/BBHandler.py | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/lib/bb/parse/parse_py/BBHandler.py b/lib/bb/parse/parse_py/BBHandler.py
index cd1c998f8f..c13e4b9755 100644
--- a/lib/bb/parse/parse_py/BBHandler.py
+++ b/lib/bb/parse/parse_py/BBHandler.py
@@ -34,6 +34,7 @@ __infunc__ = []
 __inpython__ = False
 __body__   = []
 __classname__ = ""
+__residue__ = []
 
 cached_statements = {}
 
@@ -80,7 +81,7 @@ def inherit(files, fn, lineno, d, deferred=False):
             __inherit_cache = d.getVar('__inherit_cache', False) or []
 
 def get_statements(filename, absolute_filename, base_name):
-    global cached_statements
+    global cached_statements, __residue__, __body__
 
     try:
         return cached_statements[absolute_filename]
@@ -100,6 +101,11 @@ def get_statements(filename, absolute_filename, base_name):
             # add a blank line to close out any python definition
             feeder(lineno, "", filename, base_name, statements, eof=True)
 
+        if __residue__:
+            raise ParseError("Unparsed lines %s: %s" % (filename, str(__residue__)), filename, lineno)
+        if __body__:
+            raise ParseError("Unparsed lines from unclosed function %s: %s" % (filename, str(__body__)), filename, lineno)
+
         if filename.endswith(".bbclass") or filename.endswith(".inc"):
             cached_statements[absolute_filename] = statements
         return statements
-- 
2.40.1


