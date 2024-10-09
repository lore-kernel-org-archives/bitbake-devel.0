Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC81FCEE330
	for <webhook@archiver.kernel.org>; Wed,  9 Oct 2024 17:25:22 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web10.22902.1728494713369201941
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 09 Oct 2024 10:25:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=DwD1OZK0;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cae4eb026so288365e9.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 09 Oct 2024 10:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728494711; x=1729099511; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yaeAN1MgQnV5n5F7wKIfKjQT8vw9aVoClb7CSRdh2BQ=;
        b=DwD1OZK0CUzSjKgtkGaC2TDFDHm2ltf8AqvalYt+wJDKnRM01P+x7kmsbWka5AVR+B
         Rubu5F1ngelBW3G/ti7NVFfsADIWGHQvE8nAbVafbC9ntsGxoRFDNRIbCe66Uzpv1Se7
         1RGkrSf+ChXTv4voYSPgHJ6xRrXw5lngH9F8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728494711; x=1729099511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yaeAN1MgQnV5n5F7wKIfKjQT8vw9aVoClb7CSRdh2BQ=;
        b=Og9XVAM8HmKGQG4EIGGTZHDn43ZQQYNuSAeQCG1qtE5fcaQJ9kt1zQ8YFVNKPd4u9+
         gE+FfLAT3oCSWnsRXO5eZTdzfmkGBUmNeTQgVuo10TrtDYNeLowp37nKA1WEP2g7oAxW
         rc7h3A8VHQsp4t2Nx6ZAoCdvT3OeU8hKWCskf6NMqSXG/DegtVEKEb8eAK01916b0B2Y
         S1TRO+dO/YS0XKlc3ogBWx0V08F5lW1eBB+vnbuRQ0pyHZpsn2fEcAl8YUUox42XXbpD
         0mQGNekh9liLyVi+N+oF+ljHJi7bmWIwUTsXIDYWp7W58Lhc2waRxqtjPy1dZ4pk572L
         BMmg==
X-Gm-Message-State: AOJu0YzPcAcIKlaFzNO89RfssTC5CMf69rwtKchYV81crDYc8CWV6fC5
	7uvFSbb8PkYyyfJqD/F6Jc4DcfoMrxyu11cZuCRsPaRig/MvmZ3Yd7Z4ChqDK09QeBlwOhl8ffF
	8
X-Google-Smtp-Source: AGHT+IHCAVAwKZe4M9KK7j3otF04fLoAnib2X7KZqEpBEln7n9E+eDZMA1t/bD6UkWUDyFsaYaYOkQ==
X-Received: by 2002:a05:600c:5117:b0:430:4db0:401d with SMTP id 5b1f17b1804b1-430ccf434b7mr24263585e9.18.1728494711403;
        Wed, 09 Oct 2024 10:25:11 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:fb33:4e5d:4941:5018])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d3f568fd7sm1761267f8f.102.2024.10.09.10.25.09
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 10:25:11 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/3] toaster/tests/functional: Fix hardcoded database ID
Date: Wed,  9 Oct 2024 18:25:07 +0100
Message-ID: <20241009172508.447620-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241009172508.447620-1-richard.purdie@linuxfoundation.org>
References: <20241009172508.447620-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 09 Oct 2024 17:25:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16665

Using a hardcoded database ID for a recipe is a bad idea and causes tests
to fail when we change data/versions.

Remove magic numbers.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/toaster/tests/functional/test_project_page.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/tests/functional/test_project_page.py b/lib/toaster/tests/functional/test_project_page.py
index 6b6d45eaba..8b34658418 100644
--- a/lib/toaster/tests/functional/test_project_page.py
+++ b/lib/toaster/tests/functional/test_project_page.py
@@ -774,7 +774,12 @@ class TestProjectPage(SeleniumFunctionalTestCase):
                 - Check recipe: name, summary, description, Version, Section,
                 License, Approx. packages included, Approx. size, Recipe file
         """
-        url = reverse("recipedetails", args=(TestProjectPage.project_id, 53428))
+        # Use a recipe which is likely to exist in the layer index but not enabled
+        # in poky out the box - xen-image-minimal from meta-virtualization
+        self._navigate_to_project_page()
+        prj = Project.objects.get(pk=TestProjectPage.project_id)
+        recipe_id = prj.get_all_compatible_recipes().get(name="xen-image-minimal").pk
+        url = reverse("recipedetails", args=(TestProjectPage.project_id, recipe_id))
         self.get(url)
         self.wait_until_visible('.page-header')
         # check title is displayed

