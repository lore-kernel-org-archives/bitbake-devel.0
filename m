Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
 by mx.groups.io with SMTP id smtpd.web11.390.1591058397676618406
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Jun 2020 17:39:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=VztaqIfu;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.65, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f65.google.com with SMTP id h95so594928pje.4
        for <bitbake-devel@lists.openembedded.org>; Mon, 01 Jun 2020 17:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=9gpmxKDgYHajvbIk02jCd+t7pUqn2Ko8QIZ6HYI8h8c=;
        b=VztaqIfuRIwiW95oHnyIngzA4Ca9rkCQEWMNaQTRTEUSx4B0xQpNxIWuDBhBwRBp5V
         NbKGtsI3cZ8qBcQwuXMn09ciGZX9erRY1lBjgV94iWWQEqSEmV16r4nyU7j+nEzTqz6+
         cldk/5mcR+XNBmtnHJg88z9pkB5cYmseCiIAhtUQtbryHU8rBTyaSJ2Uq2LbhN70pimK
         KOJZdbP1f8pIfnqys6mO/QZ8y47dn66nSy8mQDVGsgZr0suu0mk9+jnWalCK8v9BpoiY
         O098kd7bvxHrNZEh4awzjcbNHbxZrgY9bUFG3lXHa4danQwbEf5OCEIv3YK7fmRUWgZd
         RDAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=9gpmxKDgYHajvbIk02jCd+t7pUqn2Ko8QIZ6HYI8h8c=;
        b=kMqp18RJw+HL+NGSd3QX9QCgenmM6kEN3RLIa7Z786301Fu+iJ+1czZ8LBMNQgbqyJ
         BYMDJfkUUqIKh2be0KyHbA/7WtuUZvN3cH2aAPTnqwTtRA84YKgWo1VmhCrCIhAgoUvW
         ngqxahQ7UeK0NYqwlT/W6xDTI0yJ89MdvP+40fd+au97AoAmUv03ypIAjgCOVGQBS/V3
         znTvaxsRBYPUfdBDv/zhUjwYPA5v0r+hbo5+beHGjFncUiQ2u5y1ff88Vaq2tGDllHuU
         8HR5mKJwrbIFrmlKTPIJ2Jbo7PPR7Ci6Z2RkfbnXsx6KkYEzz0wjbQUhnM3iBbM6OYx4
         xaUA==
X-Gm-Message-State: AOAM532pelj55GmN+JEICOcpRMWtOWCvZNfb+KqxwXeyTtaNKTAagcSH
	IkeTYcH/n1cgmAVODHHyCWR34A8ocM8=
X-Google-Smtp-Source: ABdhPJy+i6BwYStHnv0upO0paImBqjv4T2OZJ6XTw5PtrL164vg1EI7WHcVKMFVGP4bE5l6wrM3Jag==
X-Received: by 2002:a17:90a:9292:: with SMTP id n18mr2259094pjo.3.1591058396735;
        Mon, 01 Jun 2020 17:39:56 -0700 (PDT)
Return-Path: <steve@sakoman.com>
Received: from octo.router0800d9.com (rrcs-66-91-142-162.west.biz.rr.com. [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id l187sm465729pfl.218.2020.06.01.17.39.55
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 17:39:56 -0700 (PDT)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 2/6] user manual: properly tag content as <replaceable>
Date: Mon,  1 Jun 2020 14:39:32 -1000
Message-Id: <25c5c79bbe814eaff03c72cc2680414a73cff7f4.1591058197.git.steve@sakoman.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1591058197.git.steve@sakoman.com>
References: <cover.1591058197.git.steve@sakoman.com>

From: "Robert P. J. Day" <rpjday@crashcourse.ca>

Tag a couple fields as replaceable to be consistent with rest of
manual.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 647c13d4ae746a1bb9bd76ff318477dadb4d292f)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-execution.xml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-execution.xml b/doc/bitbake-user-manual/bitbake-user-manual-execution.xml
index 6c5234ed..e4251dff 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-execution.xml
+++ b/doc/bitbake-user-manual/bitbake-user-manual-execution.xml
@@ -618,12 +618,12 @@
         <para>
             Tasks can be either a shell task or a Python task.
             For shell tasks, BitBake writes a shell script to
-            <filename>${</filename><link linkend='var-bb-T'><filename>T</filename></link><filename>}/run.do_taskname.pid</filename>
+            <filename>${</filename><link linkend='var-bb-T'><filename>T</filename></link><filename>}/run.do_taskname.<replaceable>pid</replaceable></filename>
             and then executes the script.
             The generated shell script contains all the exported variables,
             and the shell functions with all variables expanded.
             Output from the shell script goes to the file
-            <filename>${T}/log.do_taskname.pid</filename>.
+            <filename>${T}/log.do_taskname.<replaceable>pid</replaceable></filename>.
             Looking at the expanded shell functions in the run file and
             the output in the log files is a useful debugging technique.
         </para>
-- 
2.17.1

