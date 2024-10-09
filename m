Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB24CCEE336
	for <webhook@archiver.kernel.org>; Wed,  9 Oct 2024 17:25:22 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web10.22903.1728494713960896750
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 09 Oct 2024 10:25:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Mn/M6gBo;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42cb57f8b41so308025e9.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 09 Oct 2024 10:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728494712; x=1729099512; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G98zfSEKSMScD3RxO2+QhPxjQkXzmDHbXA3dc163vjs=;
        b=Mn/M6gBoEqs4yCiCCzsndnNcINAk5DzD3xoWhwrt6UmM5CoY6LLknZsnbkysNkkqL5
         vB19+OBdvlsWJc4vZs3Ofj6W1wNvzrAY3cs4iqDu5fQGVVPNC+CIsbxQE5dOb6y2KqiL
         TX1BCQwggMMXDTO3Aeee3G5etL8HpieGj6l+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728494712; x=1729099512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G98zfSEKSMScD3RxO2+QhPxjQkXzmDHbXA3dc163vjs=;
        b=J7CLPod3atTZ+myerZA8n9FC7Op+ecUdeUt6bAe5M8uqF5oILji840USFf0oJ1uNdm
         2HDApyb6e+UDQJ8DmSoMer+ILR+8Mape6ePxs3ZrL6uEdJzOw5gyjj78HG6RvwJooxag
         ZnKtzfCCOBU1x+YSjxHezqhHLMH9ksGSaRZffNc0Q8EG0A/8S25ZsgoTzX5amVLqTFr5
         X08qNLQfcO0zlzihRL33h1aMzG7c4TKDQDfrzL55vEAsc8LJdJVDeqy+VRjEpmiY196J
         1/WJBmqIFQbSrwJKu2eJgFuN38orxUxblHx/9HQyqxsy3zKVrlH7tUnCA0FTt4BUIyYO
         86lQ==
X-Gm-Message-State: AOJu0Yy9w5oT2s/geuWYe1vwq31xxRHG/akQoVrY29YC0n8fSp/g+1F5
	pcYRf1lct9OFzl6qPix4hF+E3dtr+NBUu6T1XZJ1bKnc8CyEqq3xLYcDivIL8QPIzUunl2XS7gt
	8
X-Google-Smtp-Source: AGHT+IHrnWLV6E+iMlIO3iTyoZj98ssceoFvHUWAC6xALbSAKNpDx74fFldQllVLSz89itXNkSTp4g==
X-Received: by 2002:a05:600c:354f:b0:42e:94ff:7ac with SMTP id 5b1f17b1804b1-430ccf517d8mr34116975e9.21.1728494712060;
        Wed, 09 Oct 2024 10:25:12 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:fb33:4e5d:4941:5018])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d3f568fd7sm1761267f8f.102.2024.10.09.10.25.11
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 10:25:11 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 3/3] toaster/tests/functional: Fix test race on alert
Date: Wed,  9 Oct 2024 18:25:08 +0100
Message-ID: <20241009172508.447620-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241009172508.447620-1-richard.purdie@linuxfoundation.org>
References: <20241009172508.447620-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 09 Oct 2024 17:25:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16666

THe test fails on faster systems as we need to wait. Fix that and
a typo.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/toaster/tests/functional/test_create_new_project.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/tests/functional/test_create_new_project.py b/lib/toaster/tests/functional/test_create_new_project.py
index c3b5679514..f7d17847ae 100644
--- a/lib/toaster/tests/functional/test_create_new_project.py
+++ b/lib/toaster/tests/functional/test_create_new_project.py
@@ -172,8 +172,10 @@ class TestCreateNewProject(SeleniumFunctionalTestCase):
                                  "import-project-dir").send_keys(wrong_path)
         self.driver.find_element(By.ID, "create-project-button").click()
 
+        self.wait_until_visible('.alert-danger')
+
         # check error message
         self.assertTrue(self.element_exists('.alert-danger'),
-                        'Allert message not shown')
+                        'Alert message not shown')
         self.assertTrue(wrong_path in self.find('.alert-danger').text,
                         "Wrong path not in alert message")

