Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
 by mx.groups.io with SMTP id smtpd.web12.48794.1591048194708418488
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Jun 2020 14:49:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=mNHwDfRd;
 spf=pass (domain: gmail.com, ip: 209.85.210.182, mailfrom: jpewhacker@gmail.com)
Received: by mail-pf1-f182.google.com with SMTP id 64so4057452pfg.8
        for <bitbake-devel@lists.openembedded.org>; Mon, 01 Jun 2020 14:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yaTwAoxJJA5o2bHuTyf563bPNpYA2Imn+ouU1F4Y+uI=;
        b=mNHwDfRdcm/EXPj/hkGPHisyoz96SsLSlFW5wdYdThL4eNMSQcPDDDutxyRxVj0g9d
         CEkc+gKCvdCO/VYuknI6RvvIXFXyVZDWSGJ5wP7Gn3c2ZWiFRmSQLg/MPYk5s+CVL5FD
         C8VaqyVFrobkYgGTxn1ZApM7qfrK9K3xguE5YHtX3oXs5snMoSlVnzfmIFyIwV+4rZ9y
         N1GfDxu5OW+kAUfA1ZULf54Wc/3/96cCvCDpaqqPiAvqHdyWVzztWP/AqE2SMNEk4CRa
         bGXnclPj6AVliQidwV+3mU5+/1Fwl9EU37udyQ6DTTrs5BDSCzBS5dV7I6wuFT4tYCVd
         Up6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yaTwAoxJJA5o2bHuTyf563bPNpYA2Imn+ouU1F4Y+uI=;
        b=VJZ+qMhpNKy+cBT/kCk6gEMUk8dQAYBSz/NRZz6vPc1YmqnnlNZ8ZU0VS3giP8/V/z
         uSFvgYVJzVm+WdgeEecWcpGAmMrKEnLcoTKB7fcxRScWN/dLEJXR6XAG7fsQCJejzQ96
         nkBUt+TJYztT3dCLwW06eUbnDltQt1I816NAhr48Cd9jeWTklA2V0/aF+I1Eudk8BLxF
         g5jK9IBpojrZFHSS20VTgX6Gh6LKIEvdZe1EzTpTfCrKbeE21EMrT5oex2J2Mse09tFg
         B0lNj1zksqAn0t0QVyU+hVJ2bdjehh+dtJRP0eargC4AfRdlGWacJyP75leQM5aQ0GxB
         KjHQ==
X-Gm-Message-State: AOAM533Kh4sCrx//S0JltOECv4VVO96ArBkhOAjdpax/DeAqp2mDfQmC
	0kvQJIh0kjs5VAbeMz3z/X9Rs5Fod44=
X-Google-Smtp-Source: ABdhPJy+qJx8C0Tc3IyHH5rkgOPfM+3JS9vQuDcfs9CMqK6Pgy4hfh7LJmyrWABBfBdDXLBF9XG27Q==
X-Received: by 2002:a63:6604:: with SMTP id a4mr21176524pgc.12.1591048193944;
        Mon, 01 Jun 2020 14:49:53 -0700 (PDT)
Return-Path: <jpewhacker@gmail.com>
Received: from localhost.localdomain ([2605:a601:ac3d:c100:ec76:791a:e792:c8c8])
        by smtp.gmail.com with ESMTPSA id o18sm385458pjp.4.2020.06.01.14.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 14:49:53 -0700 (PDT)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v2 4/8] bitbake: lib: Add PrefixLoggerAdapter helper
Date: Mon,  1 Jun 2020 16:49:41 -0500
Message-Id: <20200601214945.32481-5-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601214945.32481-1-JPEWhacker@gmail.com>
References: <20200601202807.26357-1-JPEWhacker@gmail.com>
 <20200601214945.32481-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
2.26.2

