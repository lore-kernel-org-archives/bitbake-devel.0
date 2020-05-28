Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
 by mx.groups.io with SMTP id smtpd.web10.13153.1590675546716025988
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 28 May 2020 07:19:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=j12/ez7w;
 spf=pass (domain: gmail.com, ip: 209.85.128.65, mailfrom: maurofrqueiros@gmail.com)
Received: by mail-wm1-f65.google.com with SMTP id r15so3338736wmh.5
        for <bitbake-devel@lists.openembedded.org>; Thu, 28 May 2020 07:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Pq1rjFiHyVfTgLwrY2X2NNS+e40M06+DBfE8mnJSS1I=;
        b=j12/ez7wO4igtL6wX5qOF4a2RqIVckUNBut0yedeSst8m2hhKDlvN9760VL3Q8lV8b
         HMFPkKivH9upzmx3U7KX1yGgdl/Tk/Z3Xsmp7+f68ngpRRYYp5/reyRBFIzbr0fD9jB4
         j+QTUryqRL8x+TrLKkoJ+WAD0YDNfSoyce1idEtpxQ0zuwoSEIPu/upAf7Ci0LxAsdom
         uPUeQoAg9VhD4g47GgEVr2jCDnJErylJOGO6K1VO47Fe+qqBQA6imlJUFnj/MSUA0JLh
         5ZzudqDFfiWdZSmif1LkyFHGfpElfvt8VRll7M7vq9un2VUlYbUDk4fMZInf4sRjpePb
         j0cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Pq1rjFiHyVfTgLwrY2X2NNS+e40M06+DBfE8mnJSS1I=;
        b=V9f/b4BQJ9i0jtzE7RRvFrVEzUkArhJkOHOXqij4C3P6WiYNT35Co3WW7KJGLoOALd
         EqRpRqvP9Sc/JT2Utj4xlABwbQFFXF60/2Ei/iVl8d/V8+ztwTZF7F2f22sP4T3c91XL
         lZ6O8Qf1hXgwowqQkUh6QlEjmSVrFiFOrPJObc3dDf+Q+3zo/kmqGsge716nWPh34yFV
         kWSSayLzhM8OCmOah9Xj+2VsU/me2Mwke8NLg4GjS3Zcb7uCX+Vwh7erquBPZCYEEsYW
         TK3cQrMkANbNjm3e3MsBoryvPz0GW+iVBNXE57XtMaqtT0PU6BgeIVewiAFq5hCD2Zpm
         ra0Q==
X-Gm-Message-State: AOAM533Ljyg6QCb8guy2BMwC2SMoq/DxCx3TzrX7KlPcy0TAOob1QT31
	cj8E0cpmrQssDeJ0D2x5ixcya59FUsw9Og==
X-Google-Smtp-Source: ABdhPJynhszua9Q5ebt3zFjQg0Ow+Yz7c0oFdm85pEFEr6nre7HSf7QctISjEmui8R+2p3w2AuxwAw==
X-Received: by 2002:a7b:cc92:: with SMTP id p18mr3733980wma.174.1590675544926;
        Thu, 28 May 2020 07:19:04 -0700 (PDT)
Return-Path: <maurofrqueiros@gmail.com>
Received: from ctw-bre-003.criticaltechworks.com ([83.240.214.249])
        by smtp.gmail.com with ESMTPSA id q4sm6942497wma.47.2020.05.28.07.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 07:19:04 -0700 (PDT)
From: =?UTF-8?B?TWF1cm8gUXVlaXLDs3M=?= <maurofrqueiros@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Mauro Queiros <maurofrqueiros@gmail.com>
Subject: [PATCH 1/3] git.py: skip smudging if lfs=0 is set
Date: Thu, 28 May 2020 15:18:51 +0100
Message-Id: <20200528141853.213890-1-maurofrqueiros@gmail.com>
X-Mailer: git-send-email 2.17.1

Git-LFS objects were being fetched even when lfs=0 was not set.
This patch disables LFS smudging when lfs=0. That way, only the LFS pointers
are downloaded during checkout.

Signed-off-by: Mauro Queiros <maurofrqueiros@gmail.com>
---
 lib/bb/fetch2/git.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 5b3793a7..4c7d388e 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -475,6 +475,9 @@ class Git(FetchMethod):
 
         need_lfs = ud.parm.get("lfs", "1") == "1"
 
+        if not need_lfs:
+            ud.basecmd = "GIT_LFS_SKIP_SMUDGE=1 " + ud.basecmd
+
         source_found = False
         source_error = []
 
-- 
2.17.1

