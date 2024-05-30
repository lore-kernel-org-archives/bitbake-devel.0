Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8A2C25B74
	for <webhook@archiver.kernel.org>; Thu, 30 May 2024 16:57:26 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web11.1848.1717088242810900847
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 30 May 2024 09:57:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=XspfXBlz;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-35dcd5377c4so368564f8f.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 30 May 2024 09:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1717088241; x=1717693041; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=J0F4ck0Xvd0Qk/xOnByHmyPr9CpAAPCTi4xfRr/rF+Q=;
        b=XspfXBlzjWrDbdM+8rIjN3efy6RbmoVnJ5Sl3egRItIoJm0AB+wx1CrCi9W/FRo6p2
         EeHvl8mYh7oce0WtD2Ng0jAWgQQC6XvnjMY3NPeu5zh9fM8sgxPtqyxmbSaEhsan5XAt
         XcQ8xkAg3PTJDywzH3sQURjzg5AjLDZYOTkR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717088241; x=1717693041;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J0F4ck0Xvd0Qk/xOnByHmyPr9CpAAPCTi4xfRr/rF+Q=;
        b=nvjoJa1x6g/KecxhZdX08vVzhprB8q/qWIl5nrWXqLm8t+IV09oC3I2MUbtcjHQSZb
         fQu4h98hKJuc1R4RgFGwdK4JWDHe4S4dBLxQuz5FtQ5XRWobc8WbdMRli+Kw79vnptVb
         UDUPQumaesCbof+iP+R2VsAo69t2xiGbyoobdl/ZMrayezNxnuxc90EwjXiqjJ1bbTCR
         UCT0WGksl7zozqs2+P9lrNR40JufIo6eBqqpOc4G4V/jSKWsu4hpU1F4GUKsv2EWvmxc
         y0bl5VYZ2D7XVeGv6pgPRZbDaYr82Ucx1pe7MCepOyB6SQnHsVbyLVVf1PMMM9Eq08jT
         WBPw==
X-Gm-Message-State: AOJu0YzxEDJe9OcavEVRsJyotutzH7ZEnl+wcjwCIn+K65Xb2PlphUQ2
	u9ZOaklUCSHD3JcyJmNDpA1EAXaMq55mPniljy3zCPe+bMpnjyzpnYMDgiF/s72r/MtHT6SzkT4
	V
X-Google-Smtp-Source: AGHT+IGG2SjbMmcHe/k84pvfcoq61QkM7YGygcvNazhBLhI3Ok+2+HAO0T7T+DDt+RYjTv6fvELyIA==
X-Received: by 2002:adf:f9d1:0:b0:355:841:aeaf with SMTP id ffacd0b85a97d-35dc009a637mr1922310f8f.33.1717088240785;
        Thu, 30 May 2024 09:57:20 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:e2db:3695:26f3:1f11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35579d7dd8esm17745316f8f.10.2024.05.30.09.57.20
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 09:57:20 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] fetch2/wget: Fix failure path for files that are empty or don't exist
Date: Thu, 30 May 2024 17:57:19 +0100
Message-Id: <20240530165719.3115747-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 30 May 2024 16:57:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16293

When we intercepted the file download to a temp file, we broke the
exist/size checks which need to happen before the rename. Correct
the ordering.

For some reason, python 3.12 exposes this problem in the selftests
differently to previous versions.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/wget.py | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index fbfa6938ac..3c213370b5 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -139,19 +139,19 @@ class Wget(FetchMethod):
         # source, one with an incorrect checksum)
         bb.fetch2.verify_checksum(ud, d, localpath=localpath, fatal_nochecksum=False)
 
-        # Remove the ".tmp" and move the file into position atomically
-        # Our lock prevents multiple writers but mirroring code may grab incomplete files
-        os.rename(localpath, localpath[:-4])
-
         # Sanity check since wget can pretend it succeed when it didn't
         # Also, this used to happen if sourceforge sent us to the mirror page
-        if not os.path.exists(ud.localpath):
+        if not os.path.exists(localpath):
             raise FetchError("The fetch command returned success for url %s but %s doesn't exist?!" % (uri, ud.localpath), uri)
 
-        if os.path.getsize(ud.localpath) == 0:
-            os.remove(ud.localpath)
+        if os.path.getsize(localpath) == 0:
+            os.remove(localpath)
             raise FetchError("The fetch of %s resulted in a zero size file?! Deleting and failing since this isn't right." % (uri), uri)
 
+        # Remove the ".tmp" and move the file into position atomically
+        # Our lock prevents multiple writers but mirroring code may grab incomplete files
+        os.rename(localpath, localpath[:-4])
+
         return True
 
     def checkstatus(self, fetch, ud, d, try_again=True):

