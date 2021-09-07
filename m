Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web09.34268.1631013355014534967
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Sep 2021 04:15:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=QEj+8Rsr;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f50.google.com with SMTP id u9so13818095wrg.8
        for <bitbake-devel@lists.openembedded.org>; Tue, 07 Sep 2021 04:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=naqzq3EHvclwIkOF2QyKM6EIGafuzNwJUxqJ+Jxv9iY=;
        b=QEj+8Rsr9RSbnakGhw+1Su9YcgAW0KSiiCPzSanuNj5OIF6ZMWE0lZm+AL+rJDnX2+
         7b8Y6G1SI7J6i1rllDRNjRwEIp+MuKV4HIyPv2UyDB7sj2K4sT8eJSDalwTvqowmZDVo
         nGLH9Fvx1tkiNf9AZNZ4D8PoJyoksWnfkFltA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=naqzq3EHvclwIkOF2QyKM6EIGafuzNwJUxqJ+Jxv9iY=;
        b=oNnMhGVgS6FZqFtOrBVoey7lKCRG/eS6D2nQ9fKoIAqTQ6AlBVmIvDmBnhcqgeiRV5
         5pCEvm11X6P1kkg9R0cNt/qs2BAvorSZ/305vUCdzoB8kKt7SeUgPw8BV5gPR4YW34aw
         OAwYSjFBUpJbmaxZP5XQP/E8mSfwX/dkMvYRHen+wVT5yrtcR/FzenDM5WH92G5FTIJI
         8Wc1CS50RKqHRvnhD7YMWMLTOsV7EDoGv8qsU7GAWepglJLq7ySCvRFM60V+pdx5Lvx7
         tSIXIIVhpAxEYsvGrjVAQ7mGydWT8H33hLwNe8yfag2a7HMGCD5c9EqbvgmkJqEKH//D
         z4fQ==
X-Gm-Message-State: AOAM533P74Ady4n95T7GZpWybWxeqi7W9vYshwUDf05alLVci8BBG3V7
	60I53kLIUzIn0N4bZbRSTP8RS/okN5lM0g==
X-Google-Smtp-Source: ABdhPJyV7oCPSHwNJJTqsjPww1yJXe21QwUfUXdjlkDwZiqhpGsE8aNSIi6uYDKjQ78YkPyGpbHlRw==
X-Received: by 2002:a05:6000:363:: with SMTP id f3mr18411650wrf.142.1631013353274;
        Tue, 07 Sep 2021 04:15:53 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:7ba0:bddf:c938:8f16])
        by smtp.gmail.com with ESMTPSA id c14sm10626695wrr.58.2021.09.07.04.15.52
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 04:15:53 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/2] runqueue: Fix issues with multiconfig deferred task deadlock messages
Date: Tue,  7 Sep 2021 12:15:51 +0100
Message-Id: <20210907111552.1111144-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In multiconfig builds with large numbers of identical tasks, builds were
deadlocking after recent runqueue changes upon rebuilds where there was
heavy sstate usage (i.e. on second builds after a first completed).

The issue was that deferred tasks were being left indefinitely on
the deferred list. The deadlock handler was then "breaking" things
by failing tasks that had already succeeded, leading to the task
being on both covered and not covered lists, giving a further error.

The fix is to clean up the deferred task list when each setscene task
completes. I'd previously been hoping to avoid iterating that list
but it appears unavoidable.

[YOCTO #14342]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 25e012125c..c652f3eaf7 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2492,6 +2492,11 @@ class RunQueueExecute:
 
         self.holdoff_need_update = True
 
+        for t in self.sq_deferred.copy():
+            if self.sq_deferred[t] == task:
+                logger.debug2("Deferred task %s now buildable" % t)
+                del self.sq_deferred[t]
+
     def sq_task_completeoutright(self, task):
         """
         Mark a task as completed
-- 
2.32.0

