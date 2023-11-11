Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96EF4C4332F
	for <webhook@archiver.kernel.org>; Sat, 11 Nov 2023 19:19:16 +0000 (UTC)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
 by mx.groups.io with SMTP id smtpd.web11.2198.1699730352854982817
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 11 Nov 2023 11:19:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=TH40lwau;
 spf=pass (domain: gmail.com, ip: 209.85.216.45, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-280cc5f3fdcso2696359a91.1
        for <bitbake-devel@lists.openembedded.org>; Sat, 11 Nov 2023 11:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699730352; x=1700335152; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6lcimKX0lS1WF0t4vmyNpoJBPBwPFbiVJoafNRCkItU=;
        b=TH40lwauwiBF4dbknDSRm5jngbs8/6g0u8tLxUSRSB8Natfg27bv5Zv9uIDPa1NIks
         cSYoQP19dNL0dX2cgQlocirY2MwA967oU1IZEs8A/aoa11C1S8h7RUpsGJyjqrqmUOT8
         FLgWVqEAU1OZqqnbMLhMS8nIYvNz6mFUGH694KOhCwFeMm9nFTIusqQwW9k3uZSMlHIl
         dsvkGRfI39tAHeHKfUBGBuQBcf/JDFeofi4/fCY1rHND8mANSfcU50pP+ECuqVoNNVHA
         ESV+PEtXcefLui6i4kL3NaIn2mBxFryw7K2AbKeu1Y9Jjq66/3FJ9P1mHZI85oY/hwz5
         7O8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699730352; x=1700335152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6lcimKX0lS1WF0t4vmyNpoJBPBwPFbiVJoafNRCkItU=;
        b=G6oXa1Bx1W/TFFbBNaz4ukuQemguYt461LcXu+G+ZgSVJFig1Wn2LevdgZZ9VIHJ6q
         7H2rkDL6RXTDbPU+uIvPoOpLXCMXC3hM12KKoV35Cs9zkNlY4oP+Nl2tQskNZQIaQQnJ
         LnH+0jgVXVSR0aoN+K/5dtdzuijDnL8HURtTP2exhhC0ftFlqsGMVrJAjorNZ4FDlsoC
         0KKBq3fXOAO6ADo9j6Ukdox4OJmX5eo7oPB6smdapLUt7jMt3NVFSzgMFqbOMMrNmZKm
         yNXjqmXyqMafd5qzjmfk+Aao37KSd9X6wKsAsgtSnWsDJA5nPWD7lD42uQyOKEe+uopQ
         nZaQ==
X-Gm-Message-State: AOJu0Yx+nSKG/sw7M6djaU4facDZF6fOHQDyor3XLSaSJzU4XhH8AWfX
	YGKxHOVQ2PEJXqZvht9Eaj0HU/65BEZcDw==
X-Google-Smtp-Source: AGHT+IE4wn0dduHk9jh0oi30DBv/UbfPAa5ULhifkpMjcEfjQ1Dq0xRK8fBiCJDaVvQS8TG5MxWvDw==
X-Received: by 2002:a17:90b:350d:b0:280:f534:6b9c with SMTP id ls13-20020a17090b350d00b00280f5346b9cmr2069697pjb.21.1699730351904;
        Sat, 11 Nov 2023 11:19:11 -0800 (PST)
Received: from chiron.hsd1.or.comcast.net ([2601:1c0:ca00:cea0:3313:4488:79b1:32e])
        by smtp.gmail.com with ESMTPSA id oo3-20020a17090b1c8300b0028328057c67sm1255997pjb.45.2023.11.11.11.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 11:19:11 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	toaster@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [PATCH 3/3] toaster: test_create_new_project typos, whitespace
Date: Sat, 11 Nov 2023 11:17:57 -0800
Message-Id: <20231111191754.2322314-3-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231111191754.2322314-1-tim.orling@konsulko.com>
References: <20231111191754.2322314-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 11 Nov 2023 19:19:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15518

* Cleanup an extraneous # at the end of the hash bang line.
* Cleanup some trailing whitespace errors.
* Fix typo inf dunfull -> dunfell.

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 .../tests/functional/test_create_new_project.py        | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/toaster/tests/functional/test_create_new_project.py b/lib/toaster/tests/functional/test_create_new_project.py
index a211d8b7..051709b4 100644
--- a/lib/toaster/tests/functional/test_create_new_project.py
+++ b/lib/toaster/tests/functional/test_create_new_project.py
@@ -1,4 +1,4 @@
-#! /usr/bin/env python3 #
+#! /usr/bin/env python3
 # BitBake Toaster UI tests implementation
 #
 # Copyright (C) 2023 Savoir-faire Linux
@@ -49,7 +49,7 @@ class TestCreateNewProject(SeleniumFunctionalTestCase):
 
         element = self.wait_until_visible('#project-created-notification')
         self.assertTrue(
-            self.element_exists('#project-created-notification'), 
+            self.element_exists('#project-created-notification'),
             f"Project:{project_name} creation notification not shown"
         )
         self.assertTrue(
@@ -57,7 +57,7 @@ class TestCreateNewProject(SeleniumFunctionalTestCase):
             f"New project name:{project_name} not in new project notification"
         )
         self.assertTrue(
-            Project.objects.filter(name=project_name).count(), 
+            Project.objects.filter(name=project_name).count(),
             f"New project:{project_name} not found in database"
         )
 
@@ -101,7 +101,7 @@ class TestCreateNewProject(SeleniumFunctionalTestCase):
             True,
         )
 
-    def test_create_new_project_dunfull(self):
+    def test_create_new_project_dunfell(self):
         """ Test create new project using:
           - Project Name: Any string
           - Release: Yocto Project 3.1 "Dunfell" (option value: 5)
@@ -116,7 +116,7 @@ class TestCreateNewProject(SeleniumFunctionalTestCase):
             release_title,
             False,
         )
-    
+
     def test_create_new_project_local(self):
         """ Test create new project using:
           - Project Name: Any string
-- 
2.34.1


