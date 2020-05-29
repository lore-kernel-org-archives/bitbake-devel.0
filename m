Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web10.31509.1590746782686764529
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 29 May 2020 03:06:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=CcjZoowM;
 spf=pass (domain: gmail.com, ip: 209.85.128.49, mailfrom: maurofrqueiros@gmail.com)
Received: by mail-wm1-f49.google.com with SMTP id u13so2612560wml.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 29 May 2020 03:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PRPvBNfULF41X8uOeWS9ppU1dSp4coCQpdvN83aDveg=;
        b=CcjZoowMg/1Y9N/ap95Q4AiLEBu1Wa5IPsLGdAIa1a/i+ZhO/cUUC8A82AssxR2Ddh
         9A6HgSqLVfVBaiNYjKmNo1KhzEv5uy3y9xT7DRA8QjN51CviuLja7x7Lqouzsfqjko+Q
         o0iSTejoo6HNaoEZcx+sugcI9xEn3m10ZbTrOxlT85QyzjlX6/p9HuEuZNKEVg8bp+P4
         nB3S2azDd9eC+2r6UOetXEitc7gcG/NmrzbulD4NBX3ttCfNMctjIwCRd+Lin1tGVACv
         x0Mv4Zr+MoRpweAXUcZ7gyyhlQOmTgjECpkZJiW46eUSWUaTO5X4plAve8ciz/dgbbsp
         qK4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PRPvBNfULF41X8uOeWS9ppU1dSp4coCQpdvN83aDveg=;
        b=MVPS+5hLF2ZHuR4I05yZ+6SG/TaMB8i+UjJpE61RaHvn0wXxKlTw/vczZSLrquSWXN
         HaIBMie4bcAddUo7kgm4rMhIuB2br4icy21afbGF+bndx21l9ytYo/aT+8SolPJj349v
         T5oGTXSXBqOG+4Kdh/kqaMkGkC9OpvulTEq7OJbfWPHIwLrE9mJFEOGLduSUNQs7kIeG
         4IIW/VQjgU5848Xrgi9J89G3T1mD+66grndGZN/998meWXH/amVvYeFEC2WlClqqQ9rM
         pJopGQfhXBJo172OGKILCWtN2AKPU985ttfWlPzA+Cc4yVRl3n7rnU68ZKX7YUp4QBX8
         yhtQ==
X-Gm-Message-State: AOAM530zsl+7i1OwE9e4h9KGdkBzRc0ZhAtqJlo8pF1MXLJEKfHpzKKj
	+tXcgW58LY6zBEWEM0tDxJuTyNh500A=
X-Google-Smtp-Source: ABdhPJz/Fh0u0FjSXSSvIxMRtBT995RXWN08U1awWmiRG+Xei+chdp22yw6Vsw3qcTbBLHzs4WVzuw==
X-Received: by 2002:a1c:5a0b:: with SMTP id o11mr7578353wmb.74.1590746781026;
        Fri, 29 May 2020 03:06:21 -0700 (PDT)
Return-Path: <maurofrqueiros@gmail.com>
Received: from ctw-bre-003.criticaltechworks.com ([83.240.214.249])
        by smtp.gmail.com with ESMTPSA id c140sm9815871wmd.18.2020.05.29.03.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 03:06:20 -0700 (PDT)
From: =?UTF-8?B?TWF1cm8gUXVlaXLDs3M=?= <maurofrqueiros@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Mauro Queiros <maurofrqueiros@gmail.com>
Subject: [PATCH v2 3/3] git.py: Use the correct branch to check if the repository has LFS objects.
Date: Fri, 29 May 2020 11:06:09 +0100
Message-Id: <20200529100609.32456-3-maurofrqueiros@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200529100609.32456-1-maurofrqueiros@gmail.com>
References: <20200529100609.32456-1-maurofrqueiros@gmail.com>

Function "contains_lfs" was only looking at the master branch when searching for LFS
content. LFS may be configured in specific branches only, so we need to use the
correct branch.

Signed-off-by: Mauro Queiros <maurofrqueiros@gmail.com>
---
 lib/bb/fetch2/git.py | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index eab76a10..dbf87156 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -566,8 +566,15 @@ class Git(FetchMethod):
         """
         Check if the repository has 'lfs' (large file) content
         """
-        cmd = "%s grep lfs HEAD:.gitattributes | wc -l" % (
-                ud.basecmd)
+
+        if not ud.nobranch:
+            branchname = ud.branches[ud.names[0]]
+        else:
+            branchname = "master"
+
+        cmd = "%s grep lfs origin/%s:.gitattributes | wc -l" % (
+            ud.basecmd, ud.branches[ud.names[0]])
+
         try:
             output = runfetchcmd(cmd, d, quiet=True, workdir=wd)
             if int(output) > 0:
-- 
2.17.1

