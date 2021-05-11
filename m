Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
 by mx.groups.io with SMTP id smtpd.web10.11831.1620736851195713372
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 11 May 2021 05:40:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=exikLWkq;
 spf=pass (domain: gmail.com, ip: 209.85.215.169, mailfrom: akuster808@gmail.com)
Received: by mail-pg1-f169.google.com with SMTP id y32so15637879pga.11
        for <bitbake-devel@lists.openembedded.org>; Tue, 11 May 2021 05:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=oQ3AVIzFtzCgWl9CnUxq04awZtRiJEeCYanW1a+knIg=;
        b=exikLWkqlxABlIujGQjLwIOa52FkdfT/EyrQHK1Yl8qKfEOA79SfOEJ1+SnX/NAmut
         NKB8B/k4/8LjUkBUy1Xx7kL6G7G9933sIbkMo2QCDWYu5FE6f31+rR7wsJrh/1QcJ+Ac
         VenerE0oxBLOZ2DmX+PKY9KOrULhKOo68+kyy04M7plp5RFczacGUPRwwQdesXmCnof2
         WQlwRbMUkB3m4sUd+1G3YyupIwNqHnSJjpkyhvkdgMNVo9ydYpvXVtuWwV1x6VSRmQhT
         xpLGGSzDo6+g+PzmwucRjt3XZ5I7faIxihvSEZCFihDjK2oqNgUmYjPdHVoDq6hNH9aJ
         4D0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oQ3AVIzFtzCgWl9CnUxq04awZtRiJEeCYanW1a+knIg=;
        b=r6VtMfVTMNs7JOFt/nLr3/uQEahEW3qTM2ou4zCUs5FILu3yO1MayiqFUESJffkyQK
         ymHEEeSZp+wxXmtrHmp2XYvzwBl+4SYYxj5dwUGJptFbdyAb5TMQNzyAIh4c91bD5P0l
         iJ/80ERkcO2CXOngfRHXcy+WdfeTngJCYI0WipjnbNWYAISdkVKHtzPeE6SWkMF+GgxL
         DhE8QsGP7TzXcWXDeiffwYJyiqrMYAHYgqrJoLEonsOA3m8I8xr9nvRQSkRJzf0IC6cN
         QdNWohsidwgz1X6Gu2/xxWxpNZ95PjUeMagg+Zuw3bKT14oLhVcCHwIWxTPkFWE+IEGr
         jo7w==
X-Gm-Message-State: AOAM532hyUeYwhfmQWxhUT8VbD64TqI8BBBC6e7kkk7BlvdNwP1xHcvs
	vSFEVzxSd03NEvQObwTb78iLvLurqNk=
X-Google-Smtp-Source: ABdhPJy0KM6h9dU/oJrF/lENuwn18YvzL+ho193cLVqpbyNUkA9EQ0de2p0IHyCVhEa4NjWe9GLbCQ==
X-Received: by 2002:a65:6255:: with SMTP id q21mr30117300pgv.382.1620736850578;
        Tue, 11 May 2021 05:40:50 -0700 (PDT)
Return-Path: <akuster808@gmail.com>
Received: from hilo.hsdl.ca.comcast.net (c-67-181-203-136.hsd1.ca.comcast.net. [67.181.203.136])
        by smtp.gmail.com with ESMTPSA id x133sm14439043pfc.19.2021.05.11.05.40.50
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 05:40:50 -0700 (PDT)
From: "Armin Kuster" <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/2] hashserver/client.py: drop unused imports
Date: Tue, 11 May 2021 12:40:47 +0000
Message-Id: <20210511124047.2342984-2-akuster808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210511124047.2342984-1-akuster808@gmail.com>
References: <20210511124047.2342984-1-akuster808@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 bitbake/lib/hashserv/client.py | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/bitbake/lib/hashserv/client.py b/bitbake/lib/hashserv/client.py
index 53117096774..1a67c6982d3 100644
--- a/bitbake/lib/hashserv/client.py
+++ b/bitbake/lib/hashserv/client.py
@@ -3,11 +3,8 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
-import asyncio
-import json
 import logging
 import socket
-import os
 import bb.asyncrpc
 from . import create_async_client
 
-- 
2.25.1

