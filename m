Return-Path: <zboszor@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6F0CCFA0D
	for <webhook@archiver.kernel.org>; Wed,  5 Nov 2025 10:59:45 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6989.1762340380989181699
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 Nov 2025 02:59:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=NVUpgyjK;
 spf=pass (domain: gmail.com, ip: 209.85.218.46, mailfrom: zboszor@gmail.com)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b6d2f5c0e8eso1266835266b.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 05 Nov 2025 02:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762340379; x=1762945179; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=el+YCL67tDUKR9V8GLmH7VI/LL/5MtrFBtHfQ239tiM=;
        b=NVUpgyjKpufY2G6nQ+ZmSOY+2d9MX7XyTjFCNZfJ6R5qVDAPqk9eRWKlEmkMnKavdc
         Ylb79snaanCNQh/Np/qDxx9nub39gJfFFNrDDuI+vpdW8ywkKBlmmItgfraGBLZBV8tN
         yi4nGhhyfH0Wk92BxjGrsY6zwfM/v3+aCl9DcGzhXYPNZAX88ER6pe2uR/1UuXTNJo5x
         v4Ks5M1a+dPuhM9i6ua66JaLYgZ0REU1KXgB+znGvZbKoWY5z6iP/fWcRSYwOMMyRanu
         a9CIQBK26RlbowKvitXVrqPys4oK8pc2OQubqYnPatgkCM7r8CPPLH+BXoFl2Lp9yjSl
         cDdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762340379; x=1762945179;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=el+YCL67tDUKR9V8GLmH7VI/LL/5MtrFBtHfQ239tiM=;
        b=VYdLFHx2uUd9tA9T7pvCwgTwEMFrkHVl0IF4g1bgF93fYDLEdnDFj+ZqTWqrmIs0ot
         l7uERrV34B04Gk11A4dlBpMAA8qATi6iXwr5Nh+M2A4EtHuTHJh2x/cWPJjcI0VF8A89
         PmCVgJanMH0g335idB36nhJ9zD+KveJa/gMDtvz0PCUEUWN7l7FZL6BTYPaL0X+gtk/T
         rCDW/B2XE7e9FwxEr2+8pCN9kmY4RehtkOFl1xrNjJhohpTugOVgD1xC7U1ZIj5hs5nv
         Q4Hrv/Cxg4XJF8Uw88Jm4g+1POT5eFBEsEqv1KgXBHOvrrY7QAdRuWNxKnKduaSH+GZt
         UAfQ==
X-Gm-Message-State: AOJu0Ywq1o1L1fggldG9IUKDf1yknBwWZVDfwtwz6N95zXsHKczTNe+9
	KugVHqye25a6e+vqydc1aFPbCWj93XLPRmRUnvGphP2/ORbAmVJmIegDUB1Yrg==
X-Gm-Gg: ASbGnctIvBFt4PhBAz26W6IPdeczbnGEi4yCRzwwd7ioUk4HJwJ9+jkzuJRN8qk/IQn
	7/7G94nRWIY498Nbb+Xjvpu4ocnn2+Eurf+fnnnLfKmjV/pyKNnYwIKSRrBJ5ImP1xWa88TOjfq
	E/GUVsbDl2FnhxWvTCcv5W/2PA6qy+/qyRj76iMYgvElhKwb7jkfa0kZ/KY67UnCwuq3V1i9YTQ
	7O01XjsoLoRKW0oOFz+6dx8hot13utppHO8uhMBnLsRXiWT/Ej6UGxnp8U6H7w7kbrwqzxHtdP3
	z06C0A3mX+bIEsdppocAKJmoXwfZODguhIFEH6CFrafgjGO1h75wVo2xA2WC/dXPOnM9Bp7MUPG
	1phCrv3n7T8z2iF9WuTaunE2NTtCbvEI6Dkew2cAinpoa5P2aEI2E6pM2IKgc09FhG6PGlzvOJP
	8xc1UbGCZsygJE2A7TCtrYAA==
X-Google-Smtp-Source: AGHT+IG0q2bFuYNQKb8oQRgiHiMVkH8xRDmwnfXTrsnLkJrdNXbpIxyiOhwnrtsqAW0nK8B6PTevHA==
X-Received: by 2002:a17:907:8689:b0:b72:3c8:e33e with SMTP id a640c23a62f3a-b726554b624mr234870666b.51.1762340378892;
        Wed, 05 Nov 2025 02:59:38 -0800 (PST)
Received: from fedora (dsl51B7D2F9.fixip.t-online.hu. [81.183.210.249])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723f6e26adsm458725466b.43.2025.11.05.02.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 02:59:38 -0800 (PST)
From: =?UTF-8?q?Zolt=C3=A1n=20B=C3=B6sz=C3=B6rm=C3=A9nyi?= <zboszor@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
	=?UTF-8?q?Zolt=C3=A1n=20B=C3=B6sz=C3=B6rm=C3=A9nyi?= <zboszor@gmail.com>
Subject: [PATCH] knotty: Make sure getTerminalColumns() returns two integers
Date: Wed,  5 Nov 2025 11:59:36 +0100
Message-ID: <20251105105936.3698613-1-zboszor@gmail.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Nov 2025 10:59:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18261

Python 3.14 complains about these:

Traceback (most recent call last):
  File "/mnt2/zozo/yocto-5.3/bitbake/lib/bb/ui/knotty.py", line 722, in main
    termfilter.updateFooter()
    ~~~~~~~~~~~~~~~~~~~~~~~^^
  File "/mnt2/zozo/yocto-5.3/bitbake/lib/bb/ui/knotty.py", line 339, in updateFooter
    lines = self.getlines(content)
  File "/mnt2/zozo/yocto-5.3/bitbake/lib/bb/ui/knotty.py", line 370, in getlines
    lines = lines + 1 + int(len(line) / (self.columns + 1))
                                         ~~~~~~~~~~~~~^~~
TypeError: can only concatenate str (not "int") to str

and

Traceback (most recent call last):
  File "/mnt2/zozo/yocto-5.3/bitbake/lib/bb/ui/knotty.py", line 722, in main
    termfilter.updateFooter()
    ~~~~~~~~~~~~~~~~~~~~~~~^^
  File "/mnt2/zozo/yocto-5.3/bitbake/lib/bb/ui/knotty.py", line 341, in updateFooter
    for tasknum, task in enumerate(tasks[:(self.rows - 1 - lines)]):
                                           ~~~~~~~~~~^~~
TypeError: unsupported operand type(s) for -: 'str' and 'int'

Make sure getting the number of rows and columns from the terminal
via the environment variables LINES and COLUMNS are returned as a
pair of integers. This matches the return value of ioctl_GWINSZ().

Signed-off-by: Zoltán Böszörményi <zboszor@gmail.com>
---
 lib/bb/ui/knotty.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 00258c80f..191731dda 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -157,7 +157,7 @@ class TerminalFilter(object):
                 pass
         if not cr:
             try:
-                cr = (os.environ['LINES'], os.environ['COLUMNS'])
+                cr = (int(os.environ['LINES']), int(os.environ['COLUMNS']))
             except:
                 cr = (25, 80)
         return cr
-- 
2.51.1


