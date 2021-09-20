Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web08.84.1632167112414334616
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 20 Sep 2021 12:45:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=U5kEIpV3;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f45.google.com with SMTP id w29so32856204wra.8
        for <bitbake-devel@lists.openembedded.org>; Mon, 20 Sep 2021 12:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HVdWrjFckOJnFXkoA52L/HpZu7mVt5sudt44De5pClU=;
        b=U5kEIpV3o5U7/rKoL5LYxLeYUTc568GtlfxE/sXWELqIkkgPZ19AEGjVLbuMTELBvt
         STx785XlGMkCq+A1Yp5isnVhYrnSYkZTxM9mw4P+4esjDZB1S3SR5CvpIiztg+5JU/YX
         WzescbuVtIQjdCa7A3jeOkS0xjhKt0mRvEgUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HVdWrjFckOJnFXkoA52L/HpZu7mVt5sudt44De5pClU=;
        b=Jsg9TxaeU1d6VDLl6VeR1vjQl2vRqofihi/6QsEPdDJeMiZU3dKHWJbAXo0u2K8nom
         1Lm9sRsAvK9kZpeEMSqw5gKp2tS2UTVdRbgLtYqdD3VRB/wMvU1JVgJCFs89t/TwHJVg
         axiuBBXNSn/ULVronTA2WRbfRSdZeZer9qqUnqR2zdX3cnl1ze2gauZuoAfT6Kuar/T2
         b7GgCcSt6WEzldeLFTOlpKJS4QOHCYIKO/beVpddJz0fXhdGWpdtyWvmi5P7l6zvVciL
         pIsCj/LzbYhSsAghVJak0h/FceYq1YYPd2+/U0gP6ALUZfzWhFFkZT01YyqNP51gJCCQ
         cuig==
X-Gm-Message-State: AOAM533E/cDzrYXtGYE6tXbxVL9g6/goDt2stdGDgcsaA3aSQmqnCF6Y
	kh0xknWTx3HkCFjbkHaPkMgHZRWP6JBmbkVO
X-Google-Smtp-Source: ABdhPJzCMcwgGxh90m7/yZUPfpRHOLGo1Y97YQ5h54KphNG1mYfDoNaI8A00Ruy5CryyoTEPyu9m2Q==
X-Received: by 2002:a1c:f302:: with SMTP id q2mr478539wmq.56.1632167110704;
        Mon, 20 Sep 2021 12:45:10 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:97b0:b8a0:39a5:2c93])
        by smtp.gmail.com with ESMTPSA id c4sm10244772wrt.23.2021.09.20.12.45.10
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 12:45:10 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] data_smart: Don't add None to ExpansionError varlist
Date: Mon, 20 Sep 2021 20:45:09 +0100
Message-Id: <20210920194509.1586681-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a "None" value gets into the varlist, it doesn't display properly.
Ensure we don't add one to have the exception display properly.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/data_smart.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index ec7bb561cc..8d235da121 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -151,7 +151,7 @@ class ExpansionError(Exception):
         self.expression = expression
         self.variablename = varname
         self.exception = exception
-        self.varlist = [varname or expression]
+        self.varlist = [varname or expression or ""]
         if varname:
             if expression:
                 self.msg = "Failure expanding variable %s, expression was %s which triggered exception %s: %s" % (varname, expression, type(exception).__name__, exception)
@@ -163,7 +163,8 @@ class ExpansionError(Exception):
         self.args = (varname, expression, exception)
 
     def addVar(self, varname):
-        self.varlist.append(varname)
+        if varname:
+            self.varlist.append(varname)
 
     def __str__(self):
         chain = "\nThe variable dependency chain for the failure is: " + " -> ".join(self.varlist)
-- 
2.32.0

