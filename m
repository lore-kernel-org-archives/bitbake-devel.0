Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web11.9770.1593089544434784969
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 25 Jun 2020 05:52:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=EigSBLHP;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f47.google.com with SMTP id k6so5732454wrn.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 25 Jun 2020 05:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JBiH41+y4cJ0/TdBM9AJYjpBuVz4ifSITEICT8D8ppc=;
        b=EigSBLHPG7Zmh+JaLj0AIoYZv9bx2SusmGcCyYsLUpOTNLmDQ+OaXUnJ0SccBbQvTS
         3yE3n1xjpG6LKmBC/Znbh8UGb6YxgpuDeddCb8s0JFioM4RouSFwUcBMgWd+pgMKC9xb
         wR8yLArpqqgdwISCEsm7ovoThyMHYxxyEZBMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JBiH41+y4cJ0/TdBM9AJYjpBuVz4ifSITEICT8D8ppc=;
        b=UVy59lFfL6xFj/Dgzzv4ZCOerUDExxGbRXhWvTeysv0C0sqSwLs88nQlfzwLijoHQg
         rE/lQWpCRm8+qc/it0Vl3XbN309OfWCYQ23x+ba7T5+lleznt4e1IsqjZCmPTkZ6zvZ5
         JmD5R+iHn2nqWgk1/gguuE3RXVEDHvrODsDBeGERCg793rDSdiU/kiimWRRQoc7aX36c
         KPdmJ/GRaEvWuW6u+JGuUSto3oEbGeyv5iXWFJzQtvirspB0EpOAlB9y3viZdL79JJSe
         gYqWUqsljdDfQafMI5DWG0xWfLcqsQL5SSfEWPmwe5IecpTJtHbT3f/6EkNMpCyUoJ42
         jvvw==
X-Gm-Message-State: AOAM530M8d/7kXhyZUYwBDPpJPV+UIPvBoGvQlRZSKPMvUO7FQhUjS4Y
	EF6G1LLvtdeGOWNxwYO+Q3Jlux+xLw/EIQ==
X-Google-Smtp-Source: ABdhPJxv3Dd+3JXjO9dCrySZpvkhdkA5Z5/tRrMz6FjcPbRWvfnp2PTid5hC8GxejnGzwZnIf8tbXg==
X-Received: by 2002:adf:e948:: with SMTP id m8mr33265384wrn.398.1593089542349;
        Thu, 25 Jun 2020 05:52:22 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
        by smtp.gmail.com with ESMTPSA id b62sm1948887wmh.38.2020.06.25.05.52.21
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 05:52:21 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] taskdata: Improve handling of regex in ASSUME_PROVIDED
Date: Thu, 25 Jun 2020 13:52:20 +0100
Message-Id: <20200625125220.650321-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ASSUME_PROVIDED can take regexs however the current way of handling
this in code is suboptimal. It means that you can add something like:

DEPENDS += "texinfo-nativejunk-that-does-not-exist"

and if texinfo-native is in ASSUME_PROVIDED, no error will occur.

Update the code to only treat something as a regex if a start or end
anchor character is present (which wouldn't be valid in a recipe name).

[YOCTO #13893]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/taskdata.py | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/lib/bb/taskdata.py b/lib/bb/taskdata.py
index d13a124983..ffbaf362e8 100644
--- a/lib/bb/taskdata.py
+++ b/lib/bb/taskdata.py
@@ -21,8 +21,13 @@ def re_match_strings(target, strings):
     Whether or not the string 'target' matches
     any one string of the strings which can be regular expression string
     """
-    return any(name == target or re.match(name, target)
-               for name in strings)
+    for name in strings:
+        if name.startswith("^") or name.endswith("$"):
+            if re.match(name, target):
+                return True
+        elif name == target:
+            return True
+    return False
 
 class TaskEntry:
     def __init__(self):
-- 
2.25.1

