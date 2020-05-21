Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web12.3564.1590059389745105138
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 21 May 2020 04:09:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=IudzyYzb;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f53.google.com with SMTP id c3so2023307wru.12
        for <bitbake-devel@lists.openembedded.org>; Thu, 21 May 2020 04:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P2CcxFAieoUB9b3+ZwDzA7RuIWEKqdGZqxbAyhfPPPI=;
        b=IudzyYzbK2kfFBCWE6gBHN4w//2ibZwUf8vhCFuzHY1g1ONoE5/TvTkoBHhbkfh2hd
         0AxMfMhJ9s6w1JwF6JG8ZX1jIUWq/p14tJwPGp3IVu6xkmncsTMCHMbFlmlphDS18Q+H
         FmNbKbERtobL+9/AHatb9tVnUsvTwSO0w55LU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P2CcxFAieoUB9b3+ZwDzA7RuIWEKqdGZqxbAyhfPPPI=;
        b=TspkJh/ntPAUYOgjxR0h+9JGwD7pHYwCqj0l7llsoqgZUOSsrxORjNYypEdmRt8ZdA
         zpa+nbhRksarEKDFLASn8/3m8Cg0xeFWyWPNqonopOBbGeWThePG2JVpERdW395TFKTM
         8jTZ/JIEvimjsPUKwXY1O/6381QETRIfFAtG5IGyXRZRvhQkij5RxK7qsPIXzngAAhFh
         Ne3PpBPFZf+Dm6SbsWYU30jahT9iTdvJlClT453mBB1aHII22SST/Jx48eHUWY2HIIFu
         titp/FB1oeSLCTGT2JYnpy3WPRLj8ihbTchd4LklQcbqgDgs1cxKirRR/FKtwPfduw5c
         tjtQ==
X-Gm-Message-State: AOAM531hPU/xzhCXm+vfgRJPclyLZzp9D+aBf8ShqNWiIS186Ujeyv1u
	s0emqkW6gZW/w7/hRq58/YwJP/dbfF0=
X-Google-Smtp-Source: ABdhPJwB2HnB0wW9WurFALMKK4a/Sdn3b/gQqPY83LP0PubnNkXo/ex0tmzRc187ROHQrBJeD1vKyw==
X-Received: by 2002:a5d:56c7:: with SMTP id m7mr7973887wrw.256.1590059387963;
        Thu, 21 May 2020 04:09:47 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
        by smtp.gmail.com with ESMTPSA id l18sm5997334wmj.22.2020.05.21.04.09.47
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 04:09:47 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] event/ast: Add RecipePostKeyExpansion event
Date: Thu, 21 May 2020 12:09:46 +0100
Message-Id: <20200521110946.2202443-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/event.py     | 4 ++++
 lib/bb/parse/ast.py | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/lib/bb/event.py b/lib/bb/event.py
index d1359f0100..0e6d9b2964 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -389,6 +389,10 @@ class RecipeEvent(Event):
 class RecipePreFinalise(RecipeEvent):
     """ Recipe Parsing Complete but not yet finalised"""
 
+class RecipePostKeyExpansion(RecipeEvent):
+    """ Recipe Parsing Complete but not yet finalised"""
+
+
 class RecipeTaskPreProcess(RecipeEvent):
     """
     Recipe Tasks about to be finalised
diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index eb8cfa21b8..785aa974eb 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -338,6 +338,9 @@ def finalize(fn, d, variant = None):
         bb.event.fire(bb.event.RecipePreFinalise(fn), d)
 
         bb.data.expandKeys(d)
+
+        bb.event.fire(bb.event.RecipePostKeyExpansion(fn), d)
+
         runAnonFuncs(d)
 
         tasklist = d.getVar('__BBTASKS', False) or []
-- 
2.25.1

