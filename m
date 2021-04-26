Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web08.4093.1619425009642394294
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 26 Apr 2021 01:16:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=hAMzF1Ul;
 spf=pass (domain: konsulko.com, ip: 209.85.221.42, mailfrom: pbarker@konsulko.com)
Received: by mail-wr1-f42.google.com with SMTP id m9so42059144wrx.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 26 Apr 2021 01:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GyemhJ9tmH/3gbJJkuWDhakorLkq314SA61KNf7/m0U=;
        b=hAMzF1UlXldF3XrLWOlVzWH9h39jmmhWieL44l2go+QWUrXoj+Y4jxg9+KE+YYuW3v
         ARVLUDd0HX3zqbeoFEZC8hT1toAx4mDLzK8AQ47r9E7/eJbjYCX80GQFpWcbVC2yFk14
         wsCEfdLtJT+swLGaFUkXn9BGH+rDPlOPdLGxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GyemhJ9tmH/3gbJJkuWDhakorLkq314SA61KNf7/m0U=;
        b=fYu6IK5t2FFpceOl5oVwVdJmNZBfskvNhfD+xWLQFvhlKxePeEbZ0Q9prcN1UlVSs3
         EEDl8ZbQ7QcvGn+F2/LmTTIrsLTKx7YLrioyO61FAvQ0dI2EXuwnul0qswG8MPiSDuIn
         lrQCVMLa9WI8Qs9am2pOBrJsuE0exwiBMojHINPmYKmUfRkN405C0uSwbvj7x7f07dtT
         tRUJa3V1HVq/kmDO6xmyrpqcDdGNQruqfChcZChREwIdiKRTcV5RXz/MvRWpOHag8L3Z
         nUw64pDBU5VqrzEJcNfiKJkRgT44tFu2pq717xt4JdTkLCIbFAmGB4Y+wzUCg5nMzyjd
         F3QA==
X-Gm-Message-State: AOAM531KYVKqqPqx8Q63QkA/1lzn598Op1PxNnP4OsGNhLKffrxkzCrA
	4nBS7snSsmPtvvS+UejL4gDIrCPdBrJSqg==
X-Google-Smtp-Source: ABdhPJzVsN9OCyHN8yV64CIn+SpUIgYwMSH7/hVKmCJV1s98eD8DJv1mUEcEd95PBLvdlEBfdGN22A==
X-Received: by 2002:adf:ef49:: with SMTP id c9mr8452457wrp.365.1619425007887;
        Mon, 26 Apr 2021 01:16:47 -0700 (PDT)
Return-Path: <pbarker@konsulko.com>
Received: from alpha.home.b5net.uk (cpc76132-clif11-2-0-cust80.12-4.cable.virginm.net. [80.7.160.81])
        by smtp.gmail.com with ESMTPSA id a9sm4631320wrw.26.2021.04.26.01.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 01:16:47 -0700 (PDT)
From: "Paul Barker" <pbarker@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>
Cc: Paul Barker <pbarker@konsulko.com>
Subject: [PATCH 4/6] prserv: Drop obsolete python version check
Date: Mon, 26 Apr 2021 09:16:31 +0100
Message-Id: <20210426081633.5020-5-pbarker@konsulko.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210426081633.5020-1-pbarker@konsulko.com>
References: <20210426081633.5020-1-pbarker@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bitbake no longer supports Python 2 so this version check is obsolete.

Signed-off-by: Paul Barker <pbarker@konsulko.com>
---
 lib/prserv/serv.py | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index 25dcf8a0e..1cfbba864 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -18,10 +18,6 @@ import select
 
 logger = logging.getLogger("BitBake.PRserv")
 
-if sys.hexversion < 0x020600F0:
-    print("Sorry, python 2.6 or later is required.")
-    sys.exit(1)
-
 class Handler(SimpleXMLRPCRequestHandler):
     def _dispatch(self,method,params):
         try:
-- 
2.26.2

