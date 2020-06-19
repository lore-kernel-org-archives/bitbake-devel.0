Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
 by mx.groups.io with SMTP id smtpd.web12.1310.1592592097034808264
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 19 Jun 2020 11:41:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=Vxb6ZhmA;
 spf=pass (domain: gmail.com, ip: 209.85.216.68, mailfrom: jpewhacker@gmail.com)
Received: by mail-pj1-f68.google.com with SMTP id i12so4406421pju.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 19 Jun 2020 11:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FDUkflwnj3HPLb0HQs4MZpF0IjDRfzt53dOBOZgqOPs=;
        b=Vxb6ZhmALk8/B9iaLzzbBdRQcEabTaQq19lnFGsjZBI44FDhYAsQrET4qlZMcBUEi8
         5y3Qs8NYT4IAtyb1VrWSl0yx6rSPqQ8GqwVCuxe+r5Mbrdiy9z4vkHI7jMKMFPNmOrD9
         MMFRG6Wij8Zo56Jsfu+1C+E5UrhyV5T0NcEiyaUURhf2uDVh88nt6JtzLVNNVw2h4csp
         fjTN3slH18I80CoRa6Fa61q/CJJWx9nrRA4bKOhG9UiF7LFL5G7WZsRiym0Nf47iUb2o
         vdtoc1iFddCBd9Iit6wo2/8K1Kv04Dr1L5JCsRemWi219W0W7t8Y97TjKcFJn4w9FMMf
         gJdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FDUkflwnj3HPLb0HQs4MZpF0IjDRfzt53dOBOZgqOPs=;
        b=otwQEcmEfelEli2IvS6UrxL9ZoYveUcVTkHcCcM1RDB5Oa0uET2vE9sHyGqH02K2UY
         rPYSesRwvppJgpaLgvoxdc8+YQQbnPiIj+iylDQfF0WdsZAtMuLHL4eXZY5khZRqB8dW
         KFWh1tEvgM0uMteO2hdlQcir0xoXZf5wamFCcusRKErxh6ob5t6jm/zLWOXjUb+W9dgr
         iA8kq+YxlzVurPrPA0HOPASWab/1iYRnZW6/W20PKA372F8Hk7V7a3QCO47H0jqBaHfG
         C7VF/YKG3kc+Xzp5pK9on85zo6K4nc0uCy0EejT/4VQxrVJtIBToSyMm8ftIiUGfBi6Y
         cTow==
X-Gm-Message-State: AOAM531HmZL2nwHVMVu+6PCYDVVt80JRS729SsEIkg+SuwCRsEaH+Wzl
	tAAh+0LJt+C/F5yEB7kCFnyUYPFm
X-Google-Smtp-Source: ABdhPJyeqp8SwO1JKnj1GavY3HOGFygkBMunQRZpzbiTvv9ZxiuyGZVAboj0voZFophp+mo3/OpxIg==
X-Received: by 2002:a17:90a:aa83:: with SMTP id l3mr4747902pjq.73.1592592096325;
        Fri, 19 Jun 2020 11:41:36 -0700 (PDT)
Return-Path: <jpewhacker@gmail.com>
Received: from localhost.localdomain ([2605:a601:ac3d:c100:c8b8:d6fe:82d6:2572])
        by smtp.gmail.com with ESMTPSA id o21sm6612025pfp.12.2020.06.19.11.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 11:41:35 -0700 (PDT)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] bitbake: cache: Bump cache version
Date: Fri, 19 Jun 2020 13:41:32 -0500
Message-Id: <20200619184132.6457-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The layout of the cache data hasn't changed, but the cache has now been
split into different files for multiconfig. If a user pulls in these
changes, it's possible that their base cache will still contain the
combined multiconfig cache entries, which are now unexpected and
generate errors like:

 Unexpected multiconfig: foo

Bumping the version fixes this since the old cache data won't be
considered valid anymore.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/cache.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
index c1e08511ba..b819a0c2da 100644
--- a/bitbake/lib/bb/cache.py
+++ b/bitbake/lib/bb/cache.py
@@ -26,7 +26,7 @@ import re
 
 logger = logging.getLogger("BitBake.Cache")
 
-__cache_version__ = "152"
+__cache_version__ = "153"
 
 def getCacheFile(path, filename, mc, data_hash):
     mcspec = ''
-- 
2.27.0

