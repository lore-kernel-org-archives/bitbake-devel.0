Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web09.3294.1631823773332316848
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 16 Sep 2021 13:22:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=XqZT2f3B;
 spf=pass (domain: gmail.com, ip: 209.85.221.52, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wr1-f52.google.com with SMTP id u18so9701648wrg.5
        for <bitbake-devel@lists.openembedded.org>; Thu, 16 Sep 2021 13:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=58H2ma+RWv17cnOiC/EMKkPETH0MFBCArWG2UzeyjLc=;
        b=XqZT2f3BFDGV5aXXaihSOdmVHJp/nLl5uHIRPKe8is/Qdvypud2dE+zCddBko9Q5Sv
         V5AQRgLRX7crxVnOy0ezF65n7wHsBfLT5KxWB12khGSDLHFec5yeR76kCKYiCz8Tb/KB
         fEYATw9wjnYDcuBvJCgLKxr8Q5hJQ7jFgG1CY9vXZD+7pmdCkb7mQyjxiVx0ba0EdB+k
         ts/hf4ujxK/joF+xkRhTF45Zvuk0vTtTGh1WLuUQrEiWoiUxoXBhGXNxAcHpvhyaGhSy
         bX+lUtYy29AW2Swc/0L4J4X7aAmLcAR8xq+ltASw4E2nbDeKfYBvtB8EiuYnHcrZkpQZ
         82Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=58H2ma+RWv17cnOiC/EMKkPETH0MFBCArWG2UzeyjLc=;
        b=B2C0jutH1Azr+liYI4Aohf4QvdcHApQa7V+HWOquc9hOVQwwuWfZpGl8T6V82nk9pH
         YchjCsKjUJmIL3/vKKyN9mhAEDedZ6nwZWfgK2cJPBDL+umAW4e2x4BLOxayibqZYjgy
         AiHCZsS27lhZNEDhEXYYUQ2qJ8jSOQk2D8jgaNv1nnOal2/Dy8svt+lp8Ak43RNcxkWX
         HLG4+D/xauudO0jsI9rvZ6B8xaIxjnKMsPI02I748szLAiC0LsUV0qwSIaCiB7JLDSk/
         wg+UHTI2avbvveCgpgyZtk0LuTmMwVvKKrgJiehOgcyEcn85sFCxyHodgJ0gAeVDCDwB
         kYcQ==
X-Gm-Message-State: AOAM5315E/+IyqaYCMheGtDNmGKcOKwWmhbNkZhgGcKw+zEBRPJWhtyD
	P+qBB14qS4fbY4yqN8J6M8qpEgznbFo=
X-Google-Smtp-Source: ABdhPJzz2fnZNMRsSUAHw+VMOwwhHAJEFQuxmMiXOmC+d7Ls/VBeoWNPF87ajqDXDQzjyd3k+ZXDug==
X-Received: by 2002:a5d:6da9:: with SMTP id u9mr8095031wrs.58.1631823772022;
        Thu, 16 Sep 2021 13:22:52 -0700 (PDT)
Return-Path: <alex.kanavin@gmail.com>
Received: from nereus.lab.linutronix.de. (b2b-109-90-143-203.unitymedia.biz. [109.90.143.203])
        by smtp.gmail.com with ESMTPSA id q11sm8644586wmc.41.2021.09.16.13.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 13:22:51 -0700 (PDT)
From: "Alexander Kanavin" <alex.kanavin@gmail.com>
X-Google-Original-From: Alexander Kanavin <alex@linutronix.de>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 5/7] bitbake: do not import imp in layerindexlib
Date: Thu, 16 Sep 2021 22:22:35 +0200
Message-Id: <20210916202237.1929584-5-alex@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210916202237.1929584-1-alex@linutronix.de>
References: <20210916202237.1929584-1-alex@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The module is deprecated and unused.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bitbake/lib/layerindexlib/__init__.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/bitbake/lib/layerindexlib/__init__.py b/bitbake/lib/layerindexlib/__init__.py
index 9ca127b9df0..3159bf2f668 100644
--- a/bitbake/lib/layerindexlib/__init__.py
+++ b/bitbake/lib/layerindexlib/__init__.py
@@ -6,7 +6,6 @@
 import datetime
 
 import logging
-import imp
 import os
 
 from collections import OrderedDict
-- 
2.20.1

