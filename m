Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02683C27C75
	for <webhook@archiver.kernel.org>; Tue, 11 Jun 2024 16:14:25 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
 by mx.groups.io with SMTP id smtpd.web11.714.1718122462616658486
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 11 Jun 2024 09:14:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=iERhVJUf;
 spf=pass (domain: konsulko.com, ip: 209.85.214.177, mailfrom: tim.orling@konsulko.com)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f70fdc9644so19154185ad.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 11 Jun 2024 09:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1718122462; x=1718727262; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qmOAtfAynGFhf7i1avHqAQG9+gNlepM2sThqxdnU3vc=;
        b=iERhVJUfPHsR9n/QMQ7g5muEr0CPsmzOxM/Bfs4vFGcFXjYCjdIrMkxS+tahCDkktI
         9OG/qXVm4Q07ePcB7GBZSjEdS+VWOfMbyD7l5KoTY4x07KMRF+2njDoP8RoxobLxaJp7
         p/Q1L7vC/GY4iwe+A9O7azRuCI2lMG7/4LIk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718122462; x=1718727262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qmOAtfAynGFhf7i1avHqAQG9+gNlepM2sThqxdnU3vc=;
        b=xTb8vxo9vBjjuY6otGNMLeDBajrunCgkVB4kcAAJDhBK4yJcXgOuSnoyYLTbanwooE
         Oriv2a7XSVNY6jXsIk5yAB7G2agK/l0akAgvXhew7yCuk7r5JdOva0ivBCX7Gw5dedbr
         5949U+TahZ96pEfwYnYpp+nPsKcyDpG6Rzz8TsmDnoTc6sMFwg8+AboAK/QyyxBsCc1x
         7mgvsp770dFxD3J5oM+IscmLfCqf/PMk7K78t9GjFcSYXjl7dXk+6hwRwUJOIqx61r3t
         3KCtSj2y5SLEQvT0NLbxwnnJ5Z/m0W5/Q0PyauXoMeQSShTFt0K43RcMZv69ImBx6p8L
         tFbA==
X-Gm-Message-State: AOJu0YwKTYbTK77mkbi5dx6RBsOr2Wf8tNG2X5dwHK3ko3oL8EiRdryC
	KyPP2c/m+BhiKL1g8MbA8SJBnNSCW+QxrQ+aI5DEpH64S3dLXfF1gKn6A07YL46DTUZ+IQ1g2an
	qwcs=
X-Google-Smtp-Source: AGHT+IHH375yo6TjBYPzo8P6JtWhvooDRvXXL9ZMH1VTTb0l0sjy8vZ7W6pAylQ/KDXnCWllLNrAsg==
X-Received: by 2002:a17:902:ec83:b0:1f7:1bf3:db10 with SMTP id d9443c01a7336-1f7288cb99bmr47929475ad.20.1718122461612;
        Tue, 11 Jun 2024 09:14:21 -0700 (PDT)
Received: from localhost ([2601:1c2:c182:4da0::2bc4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f7167dec34sm39059745ad.101.2024.06.11.09.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 09:14:21 -0700 (PDT)
From: tim.orling@konsulko.com
To: bitbake-devel@lists.openembedded.org,
	toaster@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [toaster 2/3] toaster test_cerate_new_project: add scarthgap
Date: Tue, 11 Jun 2024 09:13:34 -0700
Message-ID: <20240611161333.2794231-4-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240611161333.2794231-2-tim.orling@konsulko.com>
References: <20240611161333.2794231-2-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 11 Jun 2024 16:14:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16350

From: Tim Orling <tim.orling@konsulko.com>

In line with changes in gen_fixtures.py:

* Add projectscarthgap
  - Add Scarthgap to slot 1.
* Move Kirkstone down to slot 4
* Drop projectdunfell
  - Drop EOL Dunfell from slot 5

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 .../functional/test_create_new_project.py     | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/lib/toaster/tests/functional/test_create_new_project.py b/lib/toaster/tests/functional/test_create_new_project.py
index 94d90459e..cdfdd9ab2 100644
--- a/lib/toaster/tests/functional/test_create_new_project.py
+++ b/lib/toaster/tests/functional/test_create_new_project.py
@@ -88,15 +88,15 @@ class TestCreateNewProject(SeleniumFunctionalTestCase):
             False,
         )
 
-    def test_create_new_project_kirkstone(self):
+    def test_create_new_project_scarthgap(self):
         """ Test create new project using:
           - Project Name: Any string
-          - Release: Yocto Project 4.0 "Kirkstone" (option value: 1)
+          - Release: Yocto Project 5.0 "Scarthgap" (option value: 1)
           - Merge Toaster settings: True
         """
         release = '1'
-        release_title = 'Yocto Project 4.0 "Kirkstone"'
-        project_name = 'projectkirkstone'
+        release_title = 'Yocto Project 5.0 "Scarthgap"'
+        project_name = 'projectscarthgap'
         self._create_test_new_project(
             project_name,
             release,
@@ -104,20 +104,20 @@ class TestCreateNewProject(SeleniumFunctionalTestCase):
             True,
         )
 
-    def test_create_new_project_dunfell(self):
+    def test_create_new_project_kirkstone(self):
         """ Test create new project using:
           - Project Name: Any string
-          - Release: Yocto Project 3.1 "Dunfell" (option value: 5)
-          - Merge Toaster settings: False
+          - Release: Yocto Project 4.0 "Kirkstone" (option value: 4)
+          - Merge Toaster settings: True
         """
-        release = '5'
-        release_title = 'Yocto Project 3.1 "Dunfell"'
-        project_name = 'projectdunfell'
+        release = '4'
+        release_title = 'Yocto Project 4.0 "Kirkstone"'
+        project_name = 'projectkirkstone'
         self._create_test_new_project(
             project_name,
             release,
             release_title,
-            False,
+            True,
         )
 
     def test_create_new_project_local(self):
-- 
2.45.2


