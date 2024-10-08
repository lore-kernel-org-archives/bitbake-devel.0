Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549B8CEF166
	for <webhook@archiver.kernel.org>; Tue,  8 Oct 2024 12:36:41 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web11.8050.1728390996243608117
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 08 Oct 2024 05:36:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=P7k5OE90;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cb1e623d1so57405395e9.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 08 Oct 2024 05:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728390994; x=1728995794; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=harKblW+l4zBr3bytm9a4M83D6H970PrS9fvj1rsaMM=;
        b=P7k5OE909/wEFlA79MlZENTGZjQEijZGhOaYo+hvRnAPdj+9ro2DPyba7y5ncjlPaO
         3uh4rfEX/nCDJuJB4eZVXFJTuBnjYzgZpGYzYGziGYlJl/5MslTU2zT0FX0mU9Af7/d2
         nPBKugXmkNBZoD/wy1YuFdTgF6WzmDvrxLvqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728390994; x=1728995794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=harKblW+l4zBr3bytm9a4M83D6H970PrS9fvj1rsaMM=;
        b=oMZgYfbfvIYyos91ODYu56Ve939ygMt6TT4Dom5GoKf1/CVA79JQYcDfkS+d0sJf+/
         a3dVitltQkkN1RI5RhpG7O1HJujWlPdI+xr1qD7+pCzUETO8Cf2GO2acuZ6MbU1zlkun
         iKiWzt7PniPrcX2gYLZ2n2obQQKblc7pNxwA0d1pxQgcwAaZLZaMmPc1XgOu/EsOCePP
         hcOYuylupa/XETruiFISTlbniuJf2AtvfVjIs9xH7mQl/z6EyxYfYBKNcmoWY6RScElJ
         Zc7w4mn6C9Ihcm8RL7KkgoWw+2KrsLclZLA6idrIdkBrwZm9/g3FKlJFCweglM/oLSYU
         DjsQ==
X-Gm-Message-State: AOJu0Yyuj/XCpPXU6/bPOtFgNzzZCWqz/AVzf8gBTgYf27tF8Mt23DeD
	uACGvOYMWgxK3xUy5hfJB7JsHPuEdyFFmmE7ryZqXCDmkm6pY7nzcIguC1PPQWWJpofZ8dAYFiu
	z
X-Google-Smtp-Source: AGHT+IGK300hoX+1qJX/kU22ARxaeU5zysH2Z8bKv8SdYjlswvAVcVRRDk1GChdxj9TF0vZkcChJDA==
X-Received: by 2002:a05:600c:a49:b0:42c:b52b:4335 with SMTP id 5b1f17b1804b1-42f85aad1c3mr128095965e9.10.1728390994271;
        Tue, 08 Oct 2024 05:36:34 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:3f9a:5ae5:8636:3d57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1691a47esm8019492f8f.28.2024.10.08.05.36.33
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 05:36:33 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 8/8] toaster/tests: Improve a test to give better debug output
Date: Tue,  8 Oct 2024 13:36:27 +0100
Message-ID: <20241008123627.252307-8-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241008123627.252307-1-richard.purdie@linuxfoundation.org>
References: <20241008123627.252307-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 08 Oct 2024 12:36:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16661

"False is not True" is not a helpful error messgae. "XXX not in YYY" is
much more helpful. Tweak the test to give more meaninful failure messages
using assertIn rather than assertTrue.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/toaster/tests/functional/test_project_page.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/toaster/tests/functional/test_project_page.py b/lib/toaster/tests/functional/test_project_page.py
index 0e36b44ffd..deb26812ea 100644
--- a/lib/toaster/tests/functional/test_project_page.py
+++ b/lib/toaster/tests/functional/test_project_page.py
@@ -719,16 +719,16 @@ class TestProjectPage(SeleniumFunctionalTestCase):
         remove_layer_btn.click()
         self.wait_until_visible('#change-notification', poll=2)
         change_notification = self.find('#change-notification')
-        self.assertTrue(
-            f'You have removed 1 layer from your project' in str(change_notification.text)
+        self.assertIn(
+            f'You have removed 1 layer from your project', str(change_notification.text)
         )
         # check add layer button works, 18 is the random layer id
         add_layer_btn = self.find('#add-remove-layer-btn')
         add_layer_btn.click()
         self.wait_until_visible('#change-notification')
         change_notification = self.find('#change-notification')
-        self.assertTrue(
-            f'You have added 1 layer to your project' in str(change_notification.text)
+        self.assertIn(
+            f'You have added 1 layer to your project', str(change_notification.text)
         )
         # check tabs(layers, recipes, machines) are displayed
         tabs = self.find_all('.nav-tabs li')

