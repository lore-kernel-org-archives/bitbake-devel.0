Received: from mail-io1-f66.google.com (mail-io1-f66.google.com [209.85.166.66])
 by mx.groups.io with SMTP id smtpd.web12.46944.1591043302182382172
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Jun 2020 13:28:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=DyG6d9aV;
 spf=pass (domain: gmail.com, ip: 209.85.166.66, mailfrom: jpewhacker@gmail.com)
Received: by mail-io1-f66.google.com with SMTP id y18so8390625iow.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 01 Jun 2020 13:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PEBcphqM2v0NiIqdt5yTpmQG0r3eZr4bAC2MdojXqjI=;
        b=DyG6d9aVUPIrEsG4LHkBdw5i4DmT8Sb+JsSOQ6d03bcWAfMQRbCukCUMFGNDw2c2EH
         iv2Sx2pQXCb/AXxbhvcHlwQkadsbAc6i+z6tqANSZhBqjSadTp8yHSKkeMG9ZVeYycm8
         NUXWPcMXezZB4qujTONGf19dj2bPTtW4l2CQxOYHL9a6xwTLn4qyUXJH4xS60+M4q/lL
         NdlMDdpTidk5ox8bf1hfiKWBPZ2ArApzA+cJLpMWCA1sqX1SWKymUHdjqvNIEboHnnc6
         1mRkFT/bluIB36FI5fmfErShRHDreIjEAU4dr3mhXC3sIlJhYcwZn7Hn5MpQO573iBUu
         g0PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PEBcphqM2v0NiIqdt5yTpmQG0r3eZr4bAC2MdojXqjI=;
        b=Aea3AwyRurZ+NgYrzgqSs5jHh1gtmEJxgn7Vs7ZsXPeRRMN1/gURXI04jRM4L947oD
         8a47CSgIXlINGDhGrrRgqTlhKqPICiksZBwlhG2SYJgQTXGJYsQqm3uVUPZMoBObPROb
         +Ouh3RJbUop0HVsNmv1jWi4VIg1OgF+MNN0gmVGw1u5IVCN3sOh/sjLzXXs1w6ml8z0m
         Xojupz4f4UzUafYZVV/i8WFo/JnJfLj6w8ipC89SXWaylNvfTU+LHZ+br2BxmH8m3EvY
         bAmwhAvROdbnF+EeckxGCsV+BFuVwXD3hIchXNfet/njirsepZI6KX1UBd7KdgSGYtzd
         t7zg==
X-Gm-Message-State: AOAM5314HBpk2NdoE61aTWITxIZSZxi6NFnEPCeuiSqO6JYaVhnHOC18
	3/j2nCDyjSqQqj2bC4fGikI3a4dYlwA=
X-Google-Smtp-Source: ABdhPJx2cJfXWljN+NSPfZHDeUtuER1Px0+12dBmtcA31N+VjWhZjUuFJ5oPuS5Ko0h188UVf45Czg==
X-Received: by 2002:a02:5448:: with SMTP id t69mr23176250jaa.37.1591043301390;
        Mon, 01 Jun 2020 13:28:21 -0700 (PDT)
Return-Path: <jpewhacker@gmail.com>
Received: from localhost.localdomain ([2605:a601:ac3d:c100:ec76:791a:e792:c8c8])
        by smtp.gmail.com with ESMTPSA id v16sm300705ilo.47.2020.06.01.13.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 13:28:20 -0700 (PDT)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH 6/8] bitbake: cache: Cache size optimization
Date: Mon,  1 Jun 2020 15:28:05 -0500
Message-Id: <20200601202807.26357-7-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200601202807.26357-1-JPEWhacker@gmail.com>
References: <20200601202807.26357-1-JPEWhacker@gmail.com>

Now that there is a cache object per multiconfig, it is not necessary
for each cache object to parse all other multiconfigs. Only the base
configuration and the specific multiconfig that the cache is tracking is
required. This significantly reduces the number of files parsed and the
size of each cache when there are multiple multiconfigs enabled.

This still doesn't get quite to the ideal case, since each multiconfig
cache still has a independent copy of the base cache, but removing this
is more difficult and invasive.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/cache.py | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
index b34bfa9b5a..3683ac6246 100644
--- a/bitbake/lib/bb/cache.py
+++ b/bitbake/lib/bb/cache.py
@@ -328,7 +328,7 @@ class NoCache(object):
         bb_data = self.load_bbfile(virtualfn, appends, virtonly=True)
         return bb_data[virtual]
 
-    def load_bbfile(self, bbfile, appends, virtonly = False):
+    def load_bbfile(self, bbfile, appends, virtonly = False, mclist = None):
         """
         Load and parse one .bb build file
         Return the data and whether parsing resulted in the file being skipped
@@ -344,7 +344,10 @@ class NoCache(object):
         bb_data = self.data.createCopy()
         datastores = parse_recipe(bb_data, bbfile, appends)
 
-        for mc in self.databuilder.mcdata:
+        if mclist is None:
+            mclist = self.databuilder.mcdata.keys()
+
+        for mc in mclist:
             if not mc:
                 continue
             bb_data = self.databuilder.mcdata[mc].createCopy()
@@ -500,7 +503,7 @@ class Cache(NoCache):
         """Parse the specified filename, returning the recipe information"""
         self.logger.debug(1, "Parsing %s", filename)
         infos = []
-        datastores = self.load_bbfile(filename, appends)
+        datastores = self.load_bbfile(filename, appends, mclist=(self.mc,))
         depends = []
         variants = []
         # Process the "real" fn last so we can store variants list
-- 
2.17.1

