Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
 by mx.groups.io with SMTP id smtpd.web11.48811.1591048197397022219
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Jun 2020 14:49:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=gW3tIAIC;
 spf=pass (domain: gmail.com, ip: 209.85.210.178, mailfrom: jpewhacker@gmail.com)
Received: by mail-pf1-f178.google.com with SMTP id a127so2039608pfa.12
        for <bitbake-devel@lists.openembedded.org>; Mon, 01 Jun 2020 14:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pmL2un/UFUGkSZJ1ZqDsizlA8bYPghnetYIRIlaZDiY=;
        b=gW3tIAICwr5eNlp7Lao3+FLWVsRfNtsbd+NxXvTPK0Nan5Boa4cWvdUHoUpa7lmdEn
         fHM87u/u2hlifall05WC2Lg6dnZa6YrNHFpU31Cf6aEpfZi2YMp9jn5VkqNn6nZeBT95
         sNzRCzV7eJbcScRzBtnBRI+mSbp1ImFMr4EpFTQosfrcSa3IdPOqqNLSrhHFnbLJyLJj
         I5ZHr26pDrriKmp62NoQIAiFicGzOMHbkhr+TXEPa9P8ac9xgki13IIyIrExcaJFPfd7
         KHhE9BD2B90MwNlbzBAt8TDzydkwfNzJ6nJHyrRiqGA623UNsvKsTVHlnKTHvvXTS8Jh
         CoNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pmL2un/UFUGkSZJ1ZqDsizlA8bYPghnetYIRIlaZDiY=;
        b=U2CocRfEndv1oaf+xEPg8MyuqnxKO/Fcgbw1TaCDOTcptMv4/SnTxHDzsCVfpBV+/n
         kqEHJZs0fYO1otU47VhZYAVp3iW6dCxzOIji5CsFRkaROzcP6sjQYQTHsiRo2t270SKA
         ZeRERAr/yxJZRyJUEjePj8JpuqvPgzhqpi4CiL2RX36RjsyuY8HDtNPbV+FmmGWLOLhR
         NQDAjPW4R7RcBl+Y8GGLBJ1O3x9LW4QH/zh5hXuTLkPEaboS4vK3aCf4nBqlFedfAg7L
         AUqn6//7bodDzej9h2U3C1jke6CR1qDdCIhP1SCdqlDU1ETrVmVO0FklyO3Gogv2j3MN
         HtAg==
X-Gm-Message-State: AOAM533b2tNFh7hnuk/3o3DAcboVyttsbaRJfyFo/W0AbhcYLRCdTiB7
	R4yqRAIRmONtjdKFUEBw40sW9tPzTCE=
X-Google-Smtp-Source: ABdhPJztuEHIBpwF1unefXiE7SZZQ7IPwaUplbvU01rCixBOzY+unoy6FFBTPtFWv/ODCnqRsg/xcw==
X-Received: by 2002:a62:a50a:: with SMTP id v10mr23093502pfm.134.1591048196686;
        Mon, 01 Jun 2020 14:49:56 -0700 (PDT)
Return-Path: <jpewhacker@gmail.com>
Received: from localhost.localdomain ([2605:a601:ac3d:c100:ec76:791a:e792:c8c8])
        by smtp.gmail.com with ESMTPSA id o18sm385458pjp.4.2020.06.01.14.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 14:49:56 -0700 (PDT)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v2 6/8] bitbake: cache: Cache size optimization
Date: Mon,  1 Jun 2020 16:49:43 -0500
Message-Id: <20200601214945.32481-7-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601214945.32481-1-JPEWhacker@gmail.com>
References: <20200601202807.26357-1-JPEWhacker@gmail.com>
 <20200601214945.32481-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
2.26.2

