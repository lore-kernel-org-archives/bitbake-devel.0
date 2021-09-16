Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web09.3293.1631823772816647874
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 16 Sep 2021 13:22:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=RQoMUMm8;
 spf=pass (domain: gmail.com, ip: 209.85.221.47, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wr1-f47.google.com with SMTP id u15so11432009wru.6
        for <bitbake-devel@lists.openembedded.org>; Thu, 16 Sep 2021 13:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=udC6dmYxiCWxFe1FyaDRANh0oG2Srb2LUi7BZ/5X9+g=;
        b=RQoMUMm8ko6V32Q3ATJ7ao4zl7rORxaNi1UFh9Lwd7974ZJ/j4KZA4BOuyNUet/gYC
         ZYrYDcdqS0PQyhzIV7B3BtiD9BXNHE+IiUtImZh2++cXaQY5gRjMQBCDadcpoQiY1Mg+
         vOIpeItNPbyYermcA09qFtfl9OmNykeajPMcran+297BmhlfyCO+yIcW2+BZiclvH/N+
         9/7rdHho7j1rFV9DMhaTFUS1LA7qU9e5ep3/R9POxY8jFZWr7vRpdzmjLBiuaVAeXMIn
         //z4LqfIQVUBptG7zZVPGSIJxv/95ku+islSCPGBW8Zg4SUructl7Vj4WTfxS4TBQs1y
         8imQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=udC6dmYxiCWxFe1FyaDRANh0oG2Srb2LUi7BZ/5X9+g=;
        b=zyhC9xALUz0PXRSWLvZWiz13vSWvTFyc63kpVRVNDFs/YTn+N761TwrZ1u38b+MxYZ
         OrEuVlTQ8eh/jHhfy8bJ3WI/NI/6IDPK5hOY49o/s81zTySfSalkHuEd8SALAkK6bK4a
         ACI5TvjFvLmyOSFQwflrLMIIPhxvrXDxOrg3YMmv6rfR+oUY3EOi1IWPGqSaM4V9TNrN
         Dt0iUI28GBlnK0qRbNyoi4TTINgYNqAK5pi2nVm11Tsu19GEOy6x+jxFaJK5vVbipiPp
         AHCpfL4F0L/HL5OfKV3exMvZiMdLT9dLWhFnn7+M7WOLFKQd0Vh1HAybimeQ7KkeZdeQ
         89oA==
X-Gm-Message-State: AOAM531734yCTtZ2DthunGE0VEpE+B7CmkwNu1Z+4lcriZKG8ACer35h
	wZo6uMNsorucNEDQsH6F8p67rJJ7I1M=
X-Google-Smtp-Source: ABdhPJw+2DhXIbO2Y86qBUceagioYa5q4Rq3imXAv1yC8GedQtmWFsX9+wruUdaXyt76UFDIaybxIA==
X-Received: by 2002:a5d:568a:: with SMTP id f10mr8177430wrv.314.1631823771379;
        Thu, 16 Sep 2021 13:22:51 -0700 (PDT)
Return-Path: <alex.kanavin@gmail.com>
Received: from nereus.lab.linutronix.de. (b2b-109-90-143-203.unitymedia.biz. [109.90.143.203])
        by smtp.gmail.com with ESMTPSA id q11sm8644586wmc.41.2021.09.16.13.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 13:22:51 -0700 (PDT)
From: "Alexander Kanavin" <alex.kanavin@gmail.com>
X-Google-Original-From: Alexander Kanavin <alex@linutronix.de>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 4/7] bitbake: fix regexp deprecation warnings
Date: Thu, 16 Sep 2021 22:22:34 +0200
Message-Id: <20210916202237.1929584-4-alex@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210916202237.1929584-1-alex@linutronix.de>
References: <20210916202237.1929584-1-alex@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

See here for details:
https://docs.python.org/3/library/re.html

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bitbake/lib/bblayers/query.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bblayers/query.py b/bitbake/lib/bblayers/query.py
index 6e94c83076c..525d4f0d476 100644
--- a/bitbake/lib/bblayers/query.py
+++ b/bitbake/lib/bblayers/query.py
@@ -441,10 +441,10 @@ NOTE: .bbappend files can impact the dependencies.
                     line = fnfile.readline()
 
         # The "require/include xxx" in conf/machine/*.conf, .inc and .bbclass
-        conf_re = re.compile(".*/conf/machine/[^\/]*\.conf$")
-        inc_re = re.compile(".*\.inc$")
+        conf_re = re.compile(r".*/conf/machine/[^\/]*\.conf$")
+        inc_re = re.compile(r".*\.inc$")
         # The "inherit xxx" in .bbclass
-        bbclass_re = re.compile(".*\.bbclass$")
+        bbclass_re = re.compile(r".*\.bbclass$")
         for layerdir in self.bblayers:
             layername = self.get_layer_name(layerdir)
             for dirpath, dirnames, filenames in os.walk(layerdir):
-- 
2.20.1

