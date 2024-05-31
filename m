Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61204C27C4F
	for <webhook@archiver.kernel.org>; Fri, 31 May 2024 09:20:34 +0000 (UTC)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
 by mx.groups.io with SMTP id smtpd.web11.7482.1717147225348366882
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 31 May 2024 02:20:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Q3kN37FZ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.167.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52b8b7b8698so303295e87.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 31 May 2024 02:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1717147223; x=1717752023; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=cUibcYLd5dZf0VzrqlvBVnuigM+/pYxtR2A+nY+Jn7o=;
        b=Q3kN37FZOI6jPy1p+GkSZWxb2AAGpmbKx5X40oO/SAPuEK6+MsVWAC0iHYJBu+CBVI
         9dXJsxybKFYHrZjEcRwJStRh24YdM2XmeX4ehqRxhj68SffptlPfc2ozKqLvFBpEgazI
         lIx9XAPJHCeGd6imIhkumuJsF3z3rrsbvXpu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717147223; x=1717752023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cUibcYLd5dZf0VzrqlvBVnuigM+/pYxtR2A+nY+Jn7o=;
        b=ILKfF4IbH97YSgoVM7RD2h6HvrWzfucrIlmk1iVNBLBQRyOyiSWqTgNylZ8uMFfp1q
         5JBuvnEW1QvFD9EnMmLJliAhJzBEIvJOKo9QhaHs5V7Y65/k3yRAnjCiJ0tAu0OrtcQk
         ml30lj1LIDCZQPmzIlHa18RlMQByxQ7JNIIzW7kbjMMvihxo6Op6SGIkTz9FdZVD905I
         AZTU33KQl7SD1dZO9iAKV9OwC1KQucWSURugSyxK+h/t2l0RA9MzSFEh8jrnIg/lmcrf
         XHQ4b50inxHo6TuT1ZBlJgxk3ez2lUxcmV8UjX+1M25epUeJ52Ly8Ja6rzaLHitXGpqi
         bMWg==
X-Gm-Message-State: AOJu0YyaBciiFHqOzWMnphpILHoqCoBQ+km6zzXYSdl3CMBt3pq0jmIk
	3vpkQ69TLgIoJp5hozaRG7BIiV8deNggbbsAhNESQDjiXi8/XTXawjpcsBc9uc+c1wiGEr9/aHe
	W
X-Google-Smtp-Source: AGHT+IHS5MaHvbsjTJ40RYWcrz91qAunbuK//+z56MaCcN2cuyYmXTkfhtzWI86G1MdH8OftaxeKmw==
X-Received: by 2002:ac2:4822:0:b0:528:ce56:96d with SMTP id 2adb3069b0e04-52b896c15e3mr781604e87.50.1717147222775;
        Fri, 31 May 2024 02:20:22 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:9173:4fa2:d1b3:c8be])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421270ad52dsm48590935e9.42.2024.05.31.02.20.22
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 02:20:22 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] fetch2/wget: Fix failure path for files that are empty or don't exist
Date: Fri, 31 May 2024 10:20:21 +0100
Message-Id: <20240531092021.3217462-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 31 May 2024 09:20:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16296

When we intercepted the file download to a temp file, we broke the
exist/size checks which need to happen before the rename. Correct
the ordering.

For some reason, python 3.12 exposes this problem in the selftests
differently to previous versions.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/wget.py | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index fbfa6938ac..d76b1d0d38 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -134,6 +134,15 @@ class Wget(FetchMethod):
 
         self._runwget(ud, d, fetchcmd, False)
 
+        # Sanity check since wget can pretend it succeed when it didn't
+        # Also, this used to happen if sourceforge sent us to the mirror page
+        if not os.path.exists(localpath):
+            raise FetchError("The fetch command returned success for url %s but %s doesn't exist?!" % (uri, localpath), uri)
+
+        if os.path.getsize(localpath) == 0:
+            os.remove(localpath)
+            raise FetchError("The fetch of %s resulted in a zero size file?! Deleting and failing since this isn't right." % (uri), uri)
+
         # Try and verify any checksum now, meaning if it isn't correct, we don't remove the
         # original file, which might be a race (imagine two recipes referencing the same
         # source, one with an incorrect checksum)
@@ -143,15 +152,6 @@ class Wget(FetchMethod):
         # Our lock prevents multiple writers but mirroring code may grab incomplete files
         os.rename(localpath, localpath[:-4])
 
-        # Sanity check since wget can pretend it succeed when it didn't
-        # Also, this used to happen if sourceforge sent us to the mirror page
-        if not os.path.exists(ud.localpath):
-            raise FetchError("The fetch command returned success for url %s but %s doesn't exist?!" % (uri, ud.localpath), uri)
-
-        if os.path.getsize(ud.localpath) == 0:
-            os.remove(ud.localpath)
-            raise FetchError("The fetch of %s resulted in a zero size file?! Deleting and failing since this isn't right." % (uri), uri)
-
         return True
 
     def checkstatus(self, fetch, ud, d, try_again=True):

