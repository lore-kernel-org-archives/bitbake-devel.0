Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59D5C27C65
	for <webhook@archiver.kernel.org>; Tue, 11 Jun 2024 16:15:04 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.web10.718.1718122499579436584
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 11 Jun 2024 09:14:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=FPbIR9r4;
 spf=pass (domain: konsulko.com, ip: 209.85.214.170, mailfrom: tim.orling@konsulko.com)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f717ee193fso9472015ad.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 11 Jun 2024 09:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1718122498; x=1718727298; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YVe4Q+JWjCPABRSHdemZc1kbgt0mgfvaLHj8346jaX0=;
        b=FPbIR9r4aPZBhP+Wf7yYdQP6F+wDtN3czENUAO151EfgosjzrkactxoKKic0SDL1mn
         TWGmS2HVVuiQfmlV21dy6sQ4u9PokTg6j5iP4BiLI47X4HTM+wz1ZDX6qRpf4NOihteI
         bgo7xDkQXGaDU/zPR4S7YShtU+43vb7l13TRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718122498; x=1718727298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YVe4Q+JWjCPABRSHdemZc1kbgt0mgfvaLHj8346jaX0=;
        b=pkUaf7AQpvgBRYr6a8KwvA8CEO4QjxiKxi0fES/3Ad4s2ex6DvUCeNAnbPlmi7xKRf
         abHmkV1/2KerCWwTe+2IUtNxdnEkv/KpsEGbyTcUi2VXA/+m84GpQnhrkszCU4hqnW+d
         l1zdQ/6FUmEnlXEiUTAHqvuS58aFz6ElqphJJyJ8yn8WivxXBBkZeXB2siV1mhWCtMVj
         ZqD5bYt3Bcdqve9PgmQ+3v6P2mQ/oZV6kBJSuissuph+9BFD0U92WQjJQxWVRab78Nik
         Wy4o4TePhuSHcAhX6MjkH/Xw0WKQz81Z8GYpgVCAn1z4seoOEKtel0+VcbcI+Z/I7wcG
         Aswg==
X-Gm-Message-State: AOJu0Yw2yZYL3RcLprJ2vQEIuvDA/cCYRZTxVH4Xtg1hGLgsUWcNPiTD
	GJu+fcxGbm4g/j7YUHPvAy77gjTpQFE5DFBLFftI6ROjfRjXke+2UBW5UToESwJgX6lIQKhgjvl
	Hs+I=
X-Google-Smtp-Source: AGHT+IGeWfgLWyHLWCPkqfYNLfzo0MpqoyBYxOOLa1YUtC2Y0y4Nwzpu4wZ7jFrP5AthZ6bvniaSpA==
X-Received: by 2002:a17:903:40c1:b0:1f7:35e0:5af9 with SMTP id d9443c01a7336-1f735e05bb3mr21935655ad.9.1718122498574;
        Tue, 11 Jun 2024 09:14:58 -0700 (PDT)
Received: from localhost ([2601:1c2:c182:4da0::2bc4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6fbc25401sm58226145ad.171.2024.06.11.09.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 09:14:58 -0700 (PDT)
From: tim.orling@konsulko.com
To: bitbake-devel@lists.openembedded.org,
	toaster@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [toaster 3/3] test_project_page: fix failing test_single_layer_page
Date: Tue, 11 Jun 2024 09:13:36 -0700
Message-ID: <20240611161333.2794231-6-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240611161333.2794231-2-tim.orling@konsulko.com>
References: <20240611161333.2794231-2-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 11 Jun 2024 16:15:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16351

From: Tim Orling <tim.orling@konsulko.com>

The test_single_layer_page test case consistently fails. It is not obvious why
but if we change the argument in the following from 8 to 7 it passes.

  url = reverse("layerdetails", args=(TestProjectPage.project_id, 8))

E       selenium.common.exceptions.TimeoutException: Message: An element matching "#change-notification" should be visible
=========================== short test summary info ============================
FAILED ../bitbake/lib/toaster/tests/functional/test_project_page.py::TestProjectPage::test_single_layer_page

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 lib/toaster/tests/functional/test_project_page.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/tests/functional/test_project_page.py b/lib/toaster/tests/functional/test_project_page.py
index adbe3587e..0e36b44ff 100644
--- a/lib/toaster/tests/functional/test_project_page.py
+++ b/lib/toaster/tests/functional/test_project_page.py
@@ -708,7 +708,7 @@ class TestProjectPage(SeleniumFunctionalTestCase):
                 - Check layer summary
                 - Check layer description
         """
-        url = reverse("layerdetails", args=(TestProjectPage.project_id, 8))
+        url = reverse("layerdetails", args=(TestProjectPage.project_id, 7))
         self.get(url)
         self.wait_until_visible('.page-header')
         # check title is displayed
-- 
2.45.2


