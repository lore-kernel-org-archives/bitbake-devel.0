Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF091C4167B
	for <webhook@archiver.kernel.org>; Sat, 11 Nov 2023 19:18:26 +0000 (UTC)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
 by mx.groups.io with SMTP id smtpd.web10.2086.1699730301023379036
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 11 Nov 2023 11:18:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=hnNGPVb3;
 spf=pass (domain: gmail.com, ip: 209.85.216.50, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2802b744e52so3235768a91.0
        for <bitbake-devel@lists.openembedded.org>; Sat, 11 Nov 2023 11:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699730300; x=1700335100; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ia777dEs0VZ6+vVp+Dl0+Hu2tjfpahYymuppdg/a3S8=;
        b=hnNGPVb3BNZFTpNTHw2CBANPNejDzStQhmgHi96a1xDAFBZxVdINy7CESpSSTpJkwD
         E/27uiVIMke+OMvMMddaVZ+0/sGOD2OlJEmtU+ikoJEoYxx12d8rEZt/gDW6eyZtsap9
         0DLh76pyJibsJ19VlK3r53C8w9mcovUumyMUMF1nM6IjAst9248GMfHYBM9Cp5Oca/Qa
         wtOI7ivvFvV3f8ORIiXQxGgLd1lPJANO27ldHhRx2gApfSk8aNhSUnDPwRdLuBHOB1xa
         5gXU2QXBW40l5rJqgnzgHzKG4CRJC/rOyTZEVkrhceON7VuWhHT/HcHN+sqWmL351loF
         SQBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699730300; x=1700335100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ia777dEs0VZ6+vVp+Dl0+Hu2tjfpahYymuppdg/a3S8=;
        b=wvrG0/ETQX5fY42swY9LkMApY8uky07us2raba1AHdD69aBXXhFZjj8caPhGM8vOxW
         5TOc52lcwIsOuHmuxm81LP3sNvFHXuPhqdT2jWJieGiHF65zJ2MLLW6/mYJl+iXcDlRq
         C2aYVIgInYxmt8NnOIkhJnnEXIPhOj99k2NuYrnOivDIRtl2gLHKzrgDs6fKAjFy3L9K
         q/fVr0wOMUyQBVtkPJ5V3+3oRIiBHjbdcPEk15OxvSGzlT/TAlnfLHMHDcq3326FQZGM
         AHNvrK2+36MgjKzkfJ79LyVvcbdsKjugHC5jFE5hn3nJzJ7BjHQNoHF8KAeYPRXZAEGr
         wIFQ==
X-Gm-Message-State: AOJu0YzcoxA2/vgwEPrAoVdEHeWBepaNcVtwPxgKiI3RiMoy0JyH22Vr
	PLpRvqso87zvK6qE+67jKjc3rTikJpTPUQ==
X-Google-Smtp-Source: AGHT+IENE+17WpL1s+Zds67hVT8pntNiF4AW/YmG44N/WgsSEyG7HYFG1Oxg8Y7W8TxYjq+0f2akeg==
X-Received: by 2002:a17:90b:3b48:b0:280:280c:efe3 with SMTP id ot8-20020a17090b3b4800b00280280cefe3mr3831863pjb.14.1699730299683;
        Sat, 11 Nov 2023 11:18:19 -0800 (PST)
Received: from chiron.hsd1.or.comcast.net ([2601:1c0:ca00:cea0:3313:4488:79b1:32e])
        by smtp.gmail.com with ESMTPSA id oo3-20020a17090b1c8300b0028328057c67sm1255997pjb.45.2023.11.11.11.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 11:18:19 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	toaster@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [PATCH 1/3] toaster: use docs for BitBake link on landing page
Date: Sat, 11 Nov 2023 11:17:53 -0800
Message-Id: <20231111191754.2322314-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 11 Nov 2023 19:18:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15516

With the webpage refresh in November 2023, the old BitBake link
https://www.yoctoproject.org/tools-resources/projects/bitbake on
the landing page is no longer valid.

Point the BitBake link in the landing page to https://docs.yoctoproject.org/bitbake.html

Fix the test_landing_page.py test case to test for the new link.

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 lib/toaster/tests/browser/test_landing_page.py | 2 +-
 lib/toaster/toastergui/templates/landing.html  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/tests/browser/test_landing_page.py b/lib/toaster/tests/browser/test_landing_page.py
index 7b425344..e010c59c 100644
--- a/lib/toaster/tests/browser/test_landing_page.py
+++ b/lib/toaster/tests/browser/test_landing_page.py
@@ -80,7 +80,7 @@ class TestLandingPage(SeleniumTestCase):
         bitbake = jumbotron.find_element_by_link_text('BitBake')
         self.assertTrue(bitbake.is_displayed())
         bitbake.click()
-        self.assertTrue("yoctoproject.org/software-item/bitbake" in self.driver.current_url)
+        self.assertTrue("docs.yoctoproject.org/bitbake.html" in self.driver.current_url)
 
     def test_yoctoproject_jumbotron_link_visible_and_clickable(self):
         """ Test Yocto Project link jumbotron is visible and clickable: """
diff --git a/lib/toaster/toastergui/templates/landing.html b/lib/toaster/toastergui/templates/landing.html
index 08b40fb2..22bbed69 100644
--- a/lib/toaster/toastergui/templates/landing.html
+++ b/lib/toaster/toastergui/templates/landing.html
@@ -12,7 +12,7 @@
             <div class="col-md-6">
               <h1>This is Toaster</h1>
 
-              <p>A web interface to <a href="https://www.openembedded.org">OpenEmbedded</a> and <a href="https://www.yoctoproject.org/tools-resources/projects/bitbake">BitBake</a>, the <a href="https://www.yoctoproject.org">Yocto Project</a> build system.</p>
+              <p>A web interface to <a href="https://www.openembedded.org">OpenEmbedded</a> and <a href="https://docs.yoctoproject.org/bitbake.html">BitBake</a>, the <a href="https://www.yoctoproject.org">Yocto Project</a> build system.</p>
 
 		          <p class="top-air">
 		            <a class="btn btn-info btn-lg" href="http://docs.yoctoproject.org/toaster-manual/setup-and-use.html#setting-up-and-using-toaster">
-- 
2.34.1


