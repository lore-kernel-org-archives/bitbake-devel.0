Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD448CDDE4D
	for <webhook@archiver.kernel.org>; Wed, 23 Oct 2024 10:00:09 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web11.5151.1729677606218820841
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Oct 2024 03:00:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ijGnuRee;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43167ff0f91so46832585e9.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 23 Oct 2024 03:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729677604; x=1730282404; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b5vqNGYk03XSukKM0jAFxT3G9NXwuCbSiQcvJRD7XO8=;
        b=ijGnuRee12bGgotpDL9IzXCPL/31nkl5lWRS0+zcIbHfQRd8k/ioJRyfyq2Mt5SiSM
         r9H1Hz+QPsYYCxR20IatIg0BxNhtUmZD6S8XtlbxX6NjyepHavLul2mPsJi0fJydUJXe
         W2fI02nLLIb2PnB4QEV5iuY9QzM8m77Gr+i4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729677604; x=1730282404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b5vqNGYk03XSukKM0jAFxT3G9NXwuCbSiQcvJRD7XO8=;
        b=xSxOstaEJitKwxUPfZe3428zYhvDUrx7K79GxxWzBRSID1jVt5AfJcCWNF2UQLkci9
         HE0nQ7auN20HP8jfy8GZ+9eUeiiieb1LLuV7KboGT7mtiaNGpS3UpSqfDSKT3lbmmG/E
         IHgnojHv7z4HwBZovmOMMYo+XSp7QNp7bK4I/GwuPnX+Bn4V0tybNWq9XNn33EZvuBwu
         qKsreedJ600scPwaPal6i+bwVq0pBHdMz0XTdOPrP+qHrwfoI3DVB5l3p1PmPM6ruVMY
         zaGatFzxbVQGcXeGaL1s0l8X8uJEmr2KvP2iTbnppuKKYy7HGtvY/H7XQCD59jaqBqzB
         Vi6g==
X-Gm-Message-State: AOJu0YyJv5Lm+VRcH3rQROlaVLTdq518ZECCO3AX5c6glnxwKvhKp00a
	bGLCVZPUlrbnbI5gEtLa+Y7ccg/aruItjZ7w/bRKAjE+XiGwofci8S2Zv+n2nj7w/93+0QclLdp
	7
X-Google-Smtp-Source: AGHT+IFIdqo6WHxmAqlXliFbXAcXadyOTPEKnm1AnL/f0BOmkDpdrAxEI9J8XcdIwZZXl+njn4WHxA==
X-Received: by 2002:a05:600c:4f48:b0:431:5ecf:2a39 with SMTP id 5b1f17b1804b1-431841b2ef1mr13000005e9.35.1729677604395;
        Wed, 23 Oct 2024 03:00:04 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:ad34:30ba:19ab:e41f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186c001c7sm11668795e9.29.2024.10.23.03.00.03
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 03:00:04 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 13/28] toaster/tests/functiona/project_page: Drop pointless test covered elsewhere
Date: Wed, 23 Oct 2024 10:59:34 +0100
Message-ID: <20241023095949.3351980-13-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023095949.3351980-1-richard.purdie@linuxfoundation.org>
References: <20241023095949.3351980-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 23 Oct 2024 10:00:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16704

The project creation test is well covered in another module so just
drop this one as there isn't any extra value added here.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/toaster/tests/functional/test_project_page.py | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/lib/toaster/tests/functional/test_project_page.py b/lib/toaster/tests/functional/test_project_page.py
index 40ef5f486a..7e73cac438 100644
--- a/lib/toaster/tests/functional/test_project_page.py
+++ b/lib/toaster/tests/functional/test_project_page.py
@@ -182,15 +182,6 @@ class TestProjectPageBase(SeleniumFunctionalTestCase):
 
 class TestProjectPage(TestProjectPageBase):
 
-    def test_create_project(self):
-        """ Create/Test new project using:
-          - Project Name: Any string
-          - Release: Any string
-          - Merge Toaster settings: True or False
-        """
-        self._create_project(project_name=self.PROJECT_NAME)
-
-
     def test_page_header_on_project_page(self):
         """ Check page header in project page:
           - AT LEFT -> Logo of Yocto project, displayed, clickable

