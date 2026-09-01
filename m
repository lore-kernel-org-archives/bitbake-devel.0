Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C49C61DD3
	for <webhook@archiver.kernel.org>; Tue,  1 Sep 2026 22:56:13 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.220.1788303367966249849
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 01 Sep 2026 15:56:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=aUAOfswp;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-482e257a23aso359470f8f.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 01 Sep 2026 15:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1788303366; x=1788908166; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BvJbwRp2Hcrmco6StfUAa0vPB9tuEpEQG9IqlbMpDgQ=;
        b=aUAOfswphy4PFT/8na26EU5ts0NltdEHGNAId/XbgEufifoTEt8C6HRClEjyGgi4iA
         +Kt+JZafuilIToHVhWKuns0xpL70CzlgQbTtTq5RA6O1kQ9A8dTaG6ozKsgWnq45b6He
         Xx2oJ1dqLP/RneKAEhn5bC5Av73ZPblYCsXhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788303366; x=1788908166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=BvJbwRp2Hcrmco6StfUAa0vPB9tuEpEQG9IqlbMpDgQ=;
        b=S6Z0AWw3wvpSAg33wU2rI+vdcGqkAJtL0FCEd5Yo5yFRpqyOSlHCELTGhXlAP8shMc
         cKn70Zl3ISeDmqTUo2745I2gZLXkvaOIjM50vMU/bgOiMMozt+dvBUuj8xPS7n0PSTkV
         El5wzFcM3FyV38KxZdp3uG7U2ZFMx0KbxwTTFsphUCenPeBzyKNdH8TQm5InVldMwtDh
         WunKWlnI+BDsflgtM4VCdUMZ7T5MRXTU89CKDOMbKW196b39ztZ+IRxYbJbcoyGbUQLV
         A09BocCQj1VSxOuCgeVnuz5PNayax/ZaGh7FRHkQKjIcfBiz1m/0sg9KUI9hxKdtTfzt
         LHOA==
X-Gm-Message-State: AFuF++nMkZrViEuncbszPb1vipVfX1QzQ2rHkg/wqeDXscIywOet8GV2
	IqpBf3QBRsIx8fnzmZuvbGDY9np4V0GP+6YSlhoAghgiKJLoZxbN/gZDieXq4Brnjx82EUBToyM
	Y5ZJdmH4=
X-Gm-Gg: AYBFou2StJEoDVZLGyFsFLW0NfiqsBsen+YsJy7pHtgkWXx2fQQLV+CsBz33XfdjOuq
	EMNGZkdXZPmuOFL7iWNfio7K3J/oRd3GMqzrvmbGGqTtpb8snd8slCUqIHnKpU/Wdlt9nSoL8go
	rE/pWX2XBDX8MtVO24JTRuVP1M0/rs+AMiW72M5ymh/zW32JrPIxIg7ozmVZCXYmknbOb/8iwEo
	OyQEZdZknTGgzZmG1TQPaSy6nY67RZQHHYaf39A/IM9N6BTBcWEQPciEpRFEmWnH0npV9DNLkEd
	StiK023/dIO0EPLrbPEC6sLbssXJ+6hgl2ZrhS/qgjJw/fgwh4d69juRWh09FODpgfSlOBJui5K
	c+s+ROCMG3lBdiT2IS8T/sMK6CyGJGwTOX1nCpMZ3s6T3zIYqPZymssWu+QTSOCjVeSlsncfyGG
	4T/A6HLv+P64yS8bpVDgJDxmblbY78k2Ys9nB0BaMylOhEDYLVDDi7MXvkHbfrriPGnTaQp6u+R
	84buLM9jlLKGTLMi1Y=
X-Received: by 2002:a05:6000:420b:b0:45e:e1a4:c4c3 with SMTP id ffacd0b85a97d-48488f20a4cmr807463f8f.15.1788303366111;
        Tue, 01 Sep 2026 15:56:06 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:9e4b:8577:fa6f:4727])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448ed37c4sm1644388f8f.21.2026.09.01.15.56.03
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 15:56:04 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 5/5] toaster/tests/layerdetails: Update tests to use labels and scrolling function
Date: Tue,  1 Sep 2026 23:55:55 +0100
Message-ID: <20260901225555.2254932-5-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901225555.2254932-1-richard.purdie@linuxfoundation.org>
References: <20260901225555.2254932-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 01 Sep 2026 22:56:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20144

wait_until_element_clickable attempts to scroll the viewport if needed
which improves the test robustness from timing issues.

Also switch to dedicated element labels added in a previous patch to
remove ambiguity from the test over the different textareas so we don't
randonly iterate them (which caused some test issues).

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 .../tests/browser/test_layerdetails_page.py       | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/lib/toaster/tests/browser/test_layerdetails_page.py b/lib/toaster/tests/browser/test_layerdetails_page.py
index 0b45ca6e0f1..476a8fa522c 100644
--- a/lib/toaster/tests/browser/test_layerdetails_page.py
+++ b/lib/toaster/tests/browser/test_layerdetails_page.py
@@ -78,17 +78,20 @@ class TestLayerDetailsPage(SeleniumTestCase):
         self.wait_until_visible("#layer-git-repo-url")
 
         # Open every edit box
-        for btn in self.find_all("dd .glyphicon-edit"):
-            btn.click()
+        self.wait_until_element_clickable(self.find("#edit-layer-description"))
+        self.click("#edit-layer-description")
+        self.wait_until_element_clickable(self.find("#edit-layer-summary"))
+        self.click("#edit-layer-summary")
 
         # Wait for the inputs to become visible after animation
-        self.wait_until_visible("#layer-git input[type=text]")
-        self.wait_until_visible("dd textarea")
+        self.wait_until_visible("#layer-git-repo-url")
         self.wait_until_visible("dd .change-btn")
+        self.wait_until_element_clickable(self.find("#layer-description"))
+        self.wait_until_element_clickable(self.find("#layer-summary"))
 
         # Edit each value
         for inputs in self.find_all("#layer-git input[type=text]") + \
-                self.find_all("dd textarea"):
+                [self.find("#layer-summary"), self.find("#layer-description")]:
             # ignore the tt inputs (twitter typeahead input)
             if "tt-" in inputs.get_attribute("class"):
                 continue
@@ -100,7 +103,7 @@ class TestLayerDetailsPage(SeleniumTestCase):
                             (self.initial_values, value))
 
             # Make sure the input visible beofre sending keys
-            self.wait_until_element_visible(inputs)
+            self.wait_until_element_clickable(inputs)
             inputs.send_keys("-edited")
 
         # Save the new values

