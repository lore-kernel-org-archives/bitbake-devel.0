Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web10.31505.1590746778758165273
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 29 May 2020 03:06:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=gAiCo/9s;
 spf=pass (domain: gmail.com, ip: 209.85.128.46, mailfrom: maurofrqueiros@gmail.com)
Received: by mail-wm1-f46.google.com with SMTP id j198so6456632wmj.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 29 May 2020 03:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Pq1rjFiHyVfTgLwrY2X2NNS+e40M06+DBfE8mnJSS1I=;
        b=gAiCo/9sxSsbIyC3vA80vkHyO14GY4An3dCtv/D2Skw4StztYJjB9EfjUUQa1ev40m
         s+DOjIvBOD9Cq33nFOoPl/ITLldjmEE0MjybYnSWOr5BZUxk9AXrq++2rZ3S8Bb3db2d
         W0ZUUioAewnIEdovdbHDAhzwJm+7ox+XQAcJpQAkibUBeBDZisJjqjaLwKCWtQhMiwaN
         l7tXuGw3oH+KRVF9DIRPMrJGxOQ0lkZdZINwegNc3cfNa9SXUaa0Rdesjq+XAr80/p0C
         TrS8WpZUZ+bFVD2lTnPAbE5elK1kr5hgrFQjSDCab576nIz1EVHb5q5De0TrRG5Viuy3
         7LSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Pq1rjFiHyVfTgLwrY2X2NNS+e40M06+DBfE8mnJSS1I=;
        b=imHSZtrpysponvKidAfnfkLTvVxLDwKsD/vPO2utgBtPgwGnIjyWyFJNHBexdlwW3K
         t4EEPvF76Wlb5ihf+yhF7+Y1kpmqjVsFRlwszhBin6H3TGNqPVcvCcnnNow9Scgab1jv
         HwsteOK1kPSFresD+G74AxSz0QYArfhSCE5QLGkyjIpwtQl4eFdFLy1u23/BvwHRVi0i
         Cg3aaAqLaXEezNnCcQN8UwoZwkww+D9SSG2GeX6JlN4RVMoaP2VdJ2APqykx13Kn7G+0
         GugljsjK7oKgPyfvUJrKCaqfo9olKOhlXlwNzi7VSJZZExajeFmiWdeLnzBQEKRp1VWV
         CUGA==
X-Gm-Message-State: AOAM533897WpTDeEczKObiUB767CkN7HzIm574/+flRJnnkqjzkBir6G
	a0tlLxFVGRfQq+JpdcyvMrVUD2fFFIY=
X-Google-Smtp-Source: ABdhPJxliMtzx92NUPCWpRHIeJSSxnY2QPbdHoji3N/zTMTdSO7BfU79PhsO7r6yZ4ENoPUZeeFaog==
X-Received: by 2002:a1c:27c2:: with SMTP id n185mr8457152wmn.68.1590746777091;
        Fri, 29 May 2020 03:06:17 -0700 (PDT)
Return-Path: <maurofrqueiros@gmail.com>
Received: from ctw-bre-003.criticaltechworks.com ([83.240.214.249])
        by smtp.gmail.com with ESMTPSA id c140sm9815871wmd.18.2020.05.29.03.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 03:06:16 -0700 (PDT)
From: =?UTF-8?B?TWF1cm8gUXVlaXLDs3M=?= <maurofrqueiros@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Mauro Queiros <maurofrqueiros@gmail.com>
Subject: [PATCH v2 1/3] git.py: skip smudging if lfs=0 is set
Date: Fri, 29 May 2020 11:06:07 +0100
Message-Id: <20200529100609.32456-1-maurofrqueiros@gmail.com>
X-Mailer: git-send-email 2.17.1

Git-LFS objects were being fetched even when lfs=0 was not set.
This patch disables LFS smudging when lfs=0. That way, only the LFS pointers
are downloaded during checkout.

Signed-off-by: Mauro Queiros <maurofrqueiros@gmail.com>
---
 lib/bb/fetch2/git.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 5b3793a7..4c7d388e 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -475,6 +475,9 @@ class Git(FetchMethod):
 
         need_lfs = ud.parm.get("lfs", "1") == "1"
 
+        if not need_lfs:
+            ud.basecmd = "GIT_LFS_SKIP_SMUDGE=1 " + ud.basecmd
+
         source_found = False
         source_error = []
 
-- 
2.17.1

