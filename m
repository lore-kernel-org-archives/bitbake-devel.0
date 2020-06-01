Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
 by mx.groups.io with SMTP id smtpd.web12.46941.1591043300756383895
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Jun 2020 13:28:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=Ccf14/uG;
 spf=pass (domain: gmail.com, ip: 209.85.166.173, mailfrom: jpewhacker@gmail.com)
Received: by mail-il1-f173.google.com with SMTP id r2so10690201ila.4
        for <bitbake-devel@lists.openembedded.org>; Mon, 01 Jun 2020 13:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0tcE2PcMtL0hMutQzVMV7qwQeUE4JdpqPaziagWyELo=;
        b=Ccf14/uGyaO1Q35+aOQG1dQLs3oUA5WQtRD8gLH1/d1avmYmmJNCPB789GL7awBldv
         H8Wez7lF4pepO5w7v4Gy9xBFaFtoR4jn8pGrdVGApt+dCyvCF3YZPKwYIkePIGpM1lkp
         YZLzgBA+5dmys3q4v8hIzoCN++8WileKYq5K4acBt4/hV+YmIOufm+qjwHvArViUZZAf
         9oxm3UQWKq0AMCNMBaPZhvCs7hqNsBz+Cqzs1/FalnLOc8+RBLK/+MsudR4EcilyzzER
         I1Gs4g9L2cSlXrlbhGlWn/15O0uy6neTnW4h9bbwMx37rxgaAkrw9do3bhll1yvWLEZw
         ItdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0tcE2PcMtL0hMutQzVMV7qwQeUE4JdpqPaziagWyELo=;
        b=tdBrlK/CTYdFiR/iG4hEmclRPX0AVMNFHxUFR8AzAP3aCHY9nNlz7LU+gr2DRPZpXF
         H1uTdkY/1d0G51A0aEaFD8svVMHSiKJ5BQ006dZ7VEWBqyGCfXaNoAUQgs+Xl28HJ78R
         ETH1eAQPOibnlfY+thbpnM4LRMoskglH7ANB/6H5ZKS6IfrQdJ4+22PCgBfaB5dfzVR/
         aQgr9oEEW/3XPhyZe43ddUBm4tNNg363Wc1k8/O8K7QtXIr9TcDT0L9zrkrMXLXwzQhu
         kMvUi1prluyaixD47c9eIKVEoJk4TIrkCL/mFXnrKf7teMEZNTdVzcj49aidrCg6ZhQ6
         +JuQ==
X-Gm-Message-State: AOAM533WLBzMl8kUU4yDYCXYziEOPd1uUiTy7iX6pstWBw6BpndlSezK
	/QVwHnaq4JDvimcaNGYLxE1NYR2x2So=
X-Google-Smtp-Source: ABdhPJxEY8kl1uImayT9n/mLWuxiGsYHIW8mDlQBPiziN/BPNE5iL/G82G+eJbqwthF5dbyuk6/6HA==
X-Received: by 2002:a92:5acb:: with SMTP id b72mr22969213ilg.76.1591043298616;
        Mon, 01 Jun 2020 13:28:18 -0700 (PDT)
Return-Path: <jpewhacker@gmail.com>
Received: from localhost.localdomain ([2605:a601:ac3d:c100:ec76:791a:e792:c8c8])
        by smtp.gmail.com with ESMTPSA id v16sm300705ilo.47.2020.06.01.13.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 13:28:18 -0700 (PDT)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH 4/8] bitbake: lib: Add PrefixLoggerAdapter helper
Date: Mon,  1 Jun 2020 15:28:03 -0500
Message-Id: <20200601202807.26357-5-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200601202807.26357-1-JPEWhacker@gmail.com>
References: <20200601202807.26357-1-JPEWhacker@gmail.com>

Adds a helper logger adapter to add a prefix to all log messages. This
is useful to distinguish log messages between multiple instances of a
object.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/__init__.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/bitbake/lib/bb/__init__.py b/bitbake/lib/bb/__init__.py
index 2e2966c3b9..1de32041ed 100644
--- a/bitbake/lib/bb/__init__.py
+++ b/bitbake/lib/bb/__init__.py
@@ -84,6 +84,14 @@ logger.setLevel(logging.DEBUG - 2)
 
 mainlogger = logging.getLogger("BitBake.Main")
 
+class PrefixLoggerAdapter(logging.LoggerAdapter):
+    def __init__(self, prefix, logger):
+        super().__init__(logger, {})
+        self.__msg_prefix = prefix
+
+    def process(self, msg, kwargs):
+        return "%s%s" %(self.__msg_prefix, msg), kwargs
+
 # This has to be imported after the setLoggerClass, as the import of bb.msg
 # can result in construction of the various loggers.
 import bb.msg
-- 
2.17.1

