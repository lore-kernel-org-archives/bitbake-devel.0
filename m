Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
 by mx.groups.io with SMTP id smtpd.web12.11975.1620736464898044727
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 11 May 2021 05:34:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=oOe9mJjT;
 spf=pass (domain: gmail.com, ip: 209.85.218.45, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ej1-f45.google.com with SMTP id w3so29521221ejc.4
        for <bitbake-devel@lists.openembedded.org>; Tue, 11 May 2021 05:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/54Xvv0g31UHyNrv+mDQlgQHH33G8UdcrDFunn+Ry7M=;
        b=oOe9mJjTKb/x3h8WFXDsstGqalfuOqnet9gwtiKlDOtUj6Nb2DrJ2jdkA1xGOi/EvJ
         ZVQ0++ZyLtM4HQ7+ztHDdE2xBohfr/Lo2sVg6ytYNqZtNPBLqEWRm7Xxsyc7K5myMR7i
         lVWVZiLbYBQEcXSDhz6XXxPpKzQnsvuSlM/DgGwJ3G7wdW75Kc0tZpQKw0IjVIOGJyHL
         2kt84s4e5R/4wu5yQx88t95vbU0wDFTGWHHNAE6rcJiyA62iTvb/TD3eqp4O06DjcYj0
         4zMXJlonjE/XGNwLdQnJSmKlF7icEOSgVhHKbTe6wC2O0w+Xgj39YJz2fvWHGXdu9Jte
         gx1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/54Xvv0g31UHyNrv+mDQlgQHH33G8UdcrDFunn+Ry7M=;
        b=Vi0ySO4Ks12lTVWu9XraGrv+YE4XNkCauCsQfg+uxrISgu3x8i7J7I1mCnddUZJVem
         vMs9dFiqmLdcOLf615LRj3WX8Zy9ZABkz3q9DaKF7PRZ5opC6pR25GB6IUpzdXmvvZpN
         E5jgZzSwPFQF2BBQc/+I+AwOJF4tWtcRvR06kfwfG/h51lUGmHiJteYFbQ44pY+ST5W1
         wHFBulVDU8M91OzyqhP1PvT7yv05sMXcboRucudocA+q3yRfHxnnmy79zaFhECfK4iqc
         gJrFv9U1fIzmW5U96aBUQPwmTCyE3OL/ugP3Z9s5QSY53rhv+x18YfFs/idjmNZqfYlE
         0ajg==
X-Gm-Message-State: AOAM530JnV6VSBI2gr1piiFuosxmxI3rgKBhav+7yZElUDpRnXqOt6VF
	TmBlL0XY7bKq23bPIqVbPf4z43Y91mk=
X-Google-Smtp-Source: ABdhPJwrig4tXfxViVOQKMg2B3ecGJrUPjDeqFNjqadi+qqSO+147zonWiOWxMdE7SL8y281XyfbIw==
X-Received: by 2002:a17:906:6bd2:: with SMTP id t18mr30352697ejs.98.1620736463548;
        Tue, 11 May 2021 05:34:23 -0700 (PDT)
Return-Path: <alex.kanavin@gmail.com>
Received: from localhost.localdomain ([2a02:2454:2a0:cb00:eb83:2e01:3dda:5d46])
        by smtp.gmail.com with ESMTPSA id o3sm14651420edr.84.2021.05.11.05.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 05:34:22 -0700 (PDT)
From: "Alexander Kanavin" <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex.kanavin@gmail.com>
Subject: [PATCH] fetch2/wget: when checking latest versions, consider all numerical directories
Date: Tue, 11 May 2021 14:34:16 +0200
Message-Id: <20210511123416.976156-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously the regex was maching x.y, but wasn't matching x, which is a problem
e.g. here:
https://download.gnome.org/sources/epiphany/
(the new gnome version scheme adds 40-series at the end).

Signed-off-by: Alexander Kanavin <alex.kanavin@gmail.com>
---
 bitbake/lib/bb/fetch2/wget.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.py
index 6d82f3af07..784df70c9f 100644
--- a/bitbake/lib/bb/fetch2/wget.py
+++ b/bitbake/lib/bb/fetch2/wget.py
@@ -472,7 +472,7 @@ class Wget(FetchMethod):
         version_dir = ['', '', '']
         version = ['', '', '']
 
-        dirver_regex = re.compile(r"(?P<pfx>\D*)(?P<ver>(\d+[\.\-_])+(\d+))")
+        dirver_regex = re.compile(r"(?P<pfx>\D*)(?P<ver>(\d+[\.\-_])*(\d+))")
         s = dirver_regex.search(dirver)
         if s:
             version_dir[1] = s.group('ver')
-- 
2.31.1

