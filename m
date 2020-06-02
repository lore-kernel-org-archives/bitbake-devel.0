Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
 by mx.groups.io with SMTP id smtpd.web12.392.1591058403175844142
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Jun 2020 17:40:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=Dea09wIa;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.193, mailfrom: steve@sakoman.com)
Received: by mail-pf1-f193.google.com with SMTP id w68so3435028pfb.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 01 Jun 2020 17:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=XYeW8/l34LFrQrtld3XhISqF1kkB6knen7kKLghd2d4=;
        b=Dea09wIaPf81+ba+r8JbouR6cOWZQDMXCiSImvnAKC+vb9kdzPAwa/3P/uOH2lqT5V
         uiJsz2ADBrPW0g47Oo9YmaDdJzw4yclssFlqOdb7wthBle3hR4nFpt0OP/7i45ubIUwz
         37YIkXNZDFZTEIki03u3PsKCVLmGxao8L60njS0F6UkC/M81cTm6H9+E1l2SQ8KIhbP/
         Qui8apfzee1pS1bVWB2VBWJRG1I2+0dQQ5LWxuoLCNKWxkvSMEjk5GiwZGZi0e1cCSYn
         PMC2eJUhV5QqdbeIAJ1dPUTe5cJnzkDBF7603Jb1qLV+WldOPkV9Dch+8KHUAhqsRndv
         /wvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=XYeW8/l34LFrQrtld3XhISqF1kkB6knen7kKLghd2d4=;
        b=Jt26+ybL51Groy7/jlKBar2bGbrURUkgV6pGGjn4AV6MSZzr6XsmwLkWYhJlayJi50
         92GyuCQaLYMPWlRjMY1mcx5uIb8EtTHozfzW6YYKgavLWtyGKIFTiWI/3Apw9JWcAVfM
         UrK/VMgivOkH2oWP4C5v6StY6tKfMQ8DngosYU+gSXOva4R/RnTPdHGu4YLlRF5wNbI7
         vCN4kLsr3BOrwrW555o4iFWf4Rs5UwlnSr7qJvAhqn3tkWMBtnLkKr2WfElHkVZ/OiCW
         4sJFHfrVAcX994XP3e6tWuj0AchHdTmydCk1QDfBbJFxa0jPaHJTiZj7HDggEV+5Ijvs
         au0g==
X-Gm-Message-State: AOAM530Gu4FiRw//lRRF8v3XTVwqv344SNU9EKxs0cWpKwBvmsz+cN4m
	Fns5A6AY334QHmTfpDUhgg8R+RbnThM=
X-Google-Smtp-Source: ABdhPJzdo3/iQauPlXFt/Xtwwwd4OmwbIs02LxNdPayo05s12bzvsI1KeOwB90+ts9ZfvutQ7m+/Uw==
X-Received: by 2002:a63:5015:: with SMTP id e21mr21541048pgb.54.1591058402276;
        Mon, 01 Jun 2020 17:40:02 -0700 (PDT)
Return-Path: <steve@sakoman.com>
Received: from octo.router0800d9.com (rrcs-66-91-142-162.west.biz.rr.com. [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id l187sm465729pfl.218.2020.06.01.17.40.01
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 17:40:01 -0700 (PDT)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 4/6] doc: More explanation to tasks that recursively depend on themselves
Date: Mon,  1 Jun 2020 14:39:34 -1000
Message-Id: <f92e19a3b3d89eb26eeb74b18ca01248767035b5.1591058197.git.steve@sakoman.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1591058197.git.steve@sakoman.com>
References: <cover.1591058197.git.steve@sakoman.com>

From: Jacob Kroon <jacob.kroon@gmail.com>

Signed-off-by: Jacob Kroon <jacob.kroon@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit c92a266c8e452833f2a590721aa1c2bd6fbeb2e0)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
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
 
-- 
2.17.1

