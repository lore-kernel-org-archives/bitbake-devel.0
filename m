Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C13BCD74960
	for <webhook@archiver.kernel.org>; Wed, 30 Oct 2024 16:01:39 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.web10.18844.1730304098525184556
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 30 Oct 2024 09:01:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=SwTIMDuO;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.170, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20c693b68f5so74658965ad.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 30 Oct 2024 09:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1730304098; x=1730908898; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q5ZdMEZnNDndoiECHv09aaVOYa6PzdQLXWVDWcyVpvo=;
        b=SwTIMDuOIUSWH8xsxuSEKs9bJCc5YMr75PzlsN6TfDs8ap0IwdTgqKc8bwgkxo5Dof
         u6avV0G858epJ8D7TizJCgLvCLV5rjsdpAM8//1sHFdb1y/KxzB1O4WXDdPm9N2MACxd
         Oems/fUqHEibs0c90CaWE3LnezgxDzTIahmYkf7wdgK8USeyopuNV6xkgGKGELY0Aoan
         wc/2m/aLcgRpzdOcbOOmS/ySJxnqnFudDTVM1MQM3d0ttcVsXvWlqr4H8KAfC2tcV/I5
         XKWHXVhstOQT80fMHrG9e9tyTn5HHJqxYefZmN2zH2kHuxSGI6raKGXiijTdPtpcxVs/
         VtrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730304098; x=1730908898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q5ZdMEZnNDndoiECHv09aaVOYa6PzdQLXWVDWcyVpvo=;
        b=npqpslnzQE2Fuj6suO7y3Bxl4PjFAXvz5iVWR8WQjZqOShlKrfVpV8HPTyN9OK3C7K
         2iAm/2o0DX6F9k6vb+9OAY0mlBfiiiljSsf0bmXV/xcpEh4j6ixMS9WAFe7sGIXE/F+g
         kACX9yTAkLhs6Rl+Bmyb+TLsiHXYlbeCp2hd9NkTevte6PDo0bWbZdy7vB2wmBm/k33G
         w+djVtjl7PzQ1Q1Jeaddtvax5PYLHE6K72MLjBr/rP+fjmOREVUCtzyAzlp5SZJXbFw9
         E5bFLJGeFlTLmpjldPavG0vnu1W9IXGbkAR+YbQBP3jiJzV2z+uSJGrcEbqoTfcET/Iw
         b0mA==
X-Gm-Message-State: AOJu0YzkDq0gNPPDKrejDwPXwYxfMXnN1jOpADpk7EISyEcZSDCJ3z24
	u1EtiCd4WjFVUyTL9i+Y0nHE6F/5Q56lxkVon54SDj5pGITpo2Q7I6WdmEyGHJOGiylsbGQtGD6
	S
X-Google-Smtp-Source: AGHT+IFc90RrNCby+WAXcIdg+JaklKKoiAoJb/JBGd8UcPoPg7XqltmbJ8VJFo9fZ7nWIxl+fYuLIA==
X-Received: by 2002:a17:90a:d90c:b0:2e1:a81f:5520 with SMTP id 98e67ed59e1d1-2e8f0f52f0dmr19855525a91.1.1730304097650;
        Wed, 30 Oct 2024 09:01:37 -0700 (PDT)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fa26a4fsm1911814a91.23.2024.10.30.09.01.36
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 09:01:37 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][styhead][2.10][PATCH 2/4] gitsm: Remove downloads/tmpdir when failed
Date: Wed, 30 Oct 2024 09:01:22 -0700
Message-Id: <a3b681b4634722547b7264910955f27ed8fd5fc2.1730303370.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1730303370.git.steve@sakoman.com>
References: <cover.1730303370.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 30 Oct 2024 16:01:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16747

From: Robert Yang <liezhi.yang@windriver.com>

The tmpdir such as downloads/tmplp3cnemv won't be removed without this fix.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 2ba8d3214759142afc11f0a88d80eb30a8bcde3a)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/fetch2/gitsm.py | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index 17aac6357..fab4b1164 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -152,9 +152,11 @@ class GitSM(Git):
         # unpacked temporarily so that we can examine the .gitmodules file
         if ud.shallow and os.path.exists(ud.fullshallow) and extra_check:
             tmpdir = tempfile.mkdtemp(dir=d.getVar("DL_DIR"))
-            runfetchcmd("tar -xzf %s" % ud.fullshallow, d, workdir=tmpdir)
-            self.process_submodules(ud, tmpdir, subfunc, d)
-            shutil.rmtree(tmpdir)
+            try:
+                runfetchcmd("tar -xzf %s" % ud.fullshallow, d, workdir=tmpdir)
+                self.process_submodules(ud, tmpdir, subfunc, d)
+            finally:
+                shutil.rmtree(tmpdir)
         else:
             self.process_submodules(ud, ud.clonedir, subfunc, d)
 
-- 
2.34.1


