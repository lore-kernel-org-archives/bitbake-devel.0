Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com [209.85.208.194])
 by mx.groups.io with SMTP id smtpd.web10.7212.1590648096798518345
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 27 May 2020 23:41:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=rWM9sn7i;
 spf=pass (domain: gmail.com, ip: 209.85.208.194, mailfrom: jacob.kroon@gmail.com)
Received: by mail-lj1-f194.google.com with SMTP id a25so20335291ljp.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 27 May 2020 23:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xb9mb4J0aqFk2HMweUzJ9/t27MkInr8C/ACHQmso+hM=;
        b=rWM9sn7io6A9GQzqpCQYLdlV5PHIRCHoTad0MCYZUfcIfYuUC16H7KOhX6j6qSqTd7
         tzmGaHusjTZoGHezHxzEV1Q/NoKHKE4ghIF8BVzQAEOncqyaOb09p/X3F+Z3iaeduxeL
         y9CWOtJVt7cum/iWpa7usIMdgmqB7RSv7FQtKfrSCrKHHVV4OKbBlE44SBbwxbmpscL6
         jtb5L2cAH4xzNPTTDtG+fVkU6pSKCVhM2XYFACeBCoAFNh8cEYpcFW5JZl4Rw+Jy8+t6
         h9Ax6MTBFy4nw5EK9jzOmVo2BFrWaK9nWV1LEk5ZHXcvqT2MBlh8dgk4uZTh+XquMJEZ
         b/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xb9mb4J0aqFk2HMweUzJ9/t27MkInr8C/ACHQmso+hM=;
        b=KIw959JzPGCAFStZKidcm0VyctJVE//nkCgNsTB1NcQSeFmt3tXPKOCDw+2dIP0qEh
         LRIeSGiFqcyljvPlji/aQBEt5K9cs5FxcHSKYr8lqg0vDWOVZ3AhBbDADJffIT8CooB8
         e0UV+3pAEQxUU7/KHDd2cLwB2h9kTZe8bCkdSseR91B85VeahmrBqd4YrG/IwlM1PunU
         szPHGC14QGIcJcfp5ChH6y0WxWYDFXr4X7xEWEq9VVzk3ffg5/Uz/IUuOFpHwrZ5x/yZ
         GT/avyN3qwlRzNPpu883WlpUGiA4gbBc30jxYhCclBplbBuStNb0uToTM05TqonaLWfT
         W55g==
X-Gm-Message-State: AOAM532n3LOYwgRwFeNUS1iqKbOrSVVeHYQNtiH7w+vQanMLuHF0OofV
	g2viOrZ22hettiaBvB3jNr8n4+ZVd10=
X-Google-Smtp-Source: ABdhPJy3of/dXkb/dT0xR4Z/InJPW2IMf6fvqx1r+X76n+nhHyIpDA9RpksdXE5kGYn5vYH5XdPWTg==
X-Received: by 2002:a2e:b52b:: with SMTP id z11mr710352ljm.313.1590648089188;
        Wed, 27 May 2020 23:41:29 -0700 (PDT)
Return-Path: <jacob.kroon@gmail.com>
Received: from localhost.localdomain ([213.185.29.22])
        by smtp.gmail.com with ESMTPSA id u8sm1403367lff.38.2020.05.27.23.41.28
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 23:41:28 -0700 (PDT)
From: "Jacob Kroon" <jacob.kroon@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] doc: More explanation to tasks that recursively depend on themselves
Date: Thu, 28 May 2020 08:41:15 +0200
Message-Id: <20200528064115.35703-1-jacob.kroon@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Jacob Kroon <jacob.kroon@gmail.com>
---
 .../bitbake-user-manual-metadata.xml               | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml b/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
index 95a8b95b..069a0ec8 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
@@ -2565,15 +2565,17 @@
             </para>
 
             <para>
-                You might want to not only have BitBake look for
-                dependencies of those tasks, but also have BitBake look
-                for build-time and runtime dependencies of the dependent
-                tasks as well.
-                If that is the case, you need to reference the task name
-                itself in the task list:
+                BitBake allows a task to recursively depend on itself by
+                referencing itself in the task list:
                 <literallayout class='monospaced'>
      do_a[recrdeptask] = "do_a do_b"
                 </literallayout>
+                In the same way as before, this means that the <filename>do_a</filename>
+                and <filename>do_b</filename> tasks of the current recipe and all
+                recipes reachable (by way of dependencies) from the recipe
+                must run before the <filename>do_a</filename> task can run. In this
+                case BitBake will ignore the current recipe's <filename>do_a</filename>
+                task circular dependency on itself.
             </para>
         </section>
 
