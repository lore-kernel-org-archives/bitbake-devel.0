Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30881CDDE5B
	for <webhook@archiver.kernel.org>; Wed, 23 Oct 2024 10:00:20 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web11.5161.1729677615380179801
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Oct 2024 03:00:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Z2XbNkMd;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d5689eea8so4389116f8f.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 23 Oct 2024 03:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729677613; x=1730282413; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gACg8tOh5BPuFPM/aY7snTNPj+82Y3ab0JtJdPY1SOo=;
        b=Z2XbNkMdy/iDN/I+HdRxNNGKFhn0+IgQMwk2bmxW7BEuQBqjBnaFxyoQUlcZQhZzLM
         BQpfKSf/WNlW+xpx8rOBan9zEIZgwcGdMHYeVMXIJgoKrLXFxvW/2hpq5EMC/RZjrmSk
         kI4i2binCRLn3Jwuj9GjWbV5eAJK7PnLrOIck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729677613; x=1730282413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gACg8tOh5BPuFPM/aY7snTNPj+82Y3ab0JtJdPY1SOo=;
        b=hEgmmeXLB0WRospGai3asGMiWwFgH6+PRrLmR0YXPthzKi5TiFLNCIVJdwD+seiMht
         PSyE5ffTw4MyBrOjaTvOgErir3UHBlVawuhDTtOnkGRCxPl+6kCoypjMWwhoPHC/nmUq
         zPBH/fBTOIC7qBlfIHIyPeReALkPaKvg45/Qu8vCS0Uo2AZogtocmQsNWwqrATUEo+QI
         hHZ2en/muR+qXIP1SQmM1TCDgjJS6zCoa5R1OhsdZPAc7x2rtEkV8iRd74zVQpHbK/gR
         ywDHM7IQ8uzkLW/wlKeRbC+2JjSs6IZdKFzrrfVGnYyT055ufnOSL1o0Plr8NZlO0dXh
         i2nw==
X-Gm-Message-State: AOJu0YzgdWSp6QTiqw2ibl4FR3UJUJT2Nf5OO4k57FfQT5De/Vn4im0R
	PImZ9z/li2KDK78ItmIDcEbLsg3F5sOo6wvVgfroicMsIK4yrm235GNDcEbcXNWSrpkOPcq1bLi
	p
X-Google-Smtp-Source: AGHT+IEPfamYXY38mq0bv8yIOSlipfKnHoRjam2dYggYwqOJZr8aHk4e8B9r1glvD3NQNGzE0pbABg==
X-Received: by 2002:a05:6000:1865:b0:37d:481e:fd3 with SMTP id ffacd0b85a97d-37efcf1111amr1629818f8f.26.1729677613482;
        Wed, 23 Oct 2024 03:00:13 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:ad34:30ba:19ab:e41f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186c001c7sm11668795e9.29.2024.10.23.03.00.12
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 03:00:12 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 21/28] toaster/tests/browser/helper: Add wait_until_element_clickable funciton
Date: Wed, 23 Oct 2024 10:59:42 +0100
Message-ID: <20241023095949.3351980-21-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023095949.3351980-1-richard.purdie@linuxfoundation.org>
References: <20241023095949.3351980-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 23 Oct 2024 10:00:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16712

Add a variant of the clickable function that accepts an element parameter.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/toaster/tests/browser/selenium_helpers_base.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/toaster/tests/browser/selenium_helpers_base.py b/lib/toaster/tests/browser/selenium_helpers_base.py
index 82defea0f2..4eea2267cc 100644
--- a/lib/toaster/tests/browser/selenium_helpers_base.py
+++ b/lib/toaster/tests/browser/selenium_helpers_base.py
@@ -239,6 +239,13 @@ class SeleniumTestCaseBase(unittest.TestCase):
         Wait(self.driver, timeout=timeout).until(is_clickable, msg)
         return self.find(selector)
 
+    def wait_until_element_clickable(self, finder, timeout=Wait._TIMEOUT):
+        """ Wait until element is clickable """
+        is_clickable = lambda driver: (finder(driver).is_displayed() and finder(driver).is_enabled())
+        msg = 'A matching element never became be clickable'
+        Wait(self.driver, timeout=timeout).until(is_clickable, msg)
+        return finder(self.driver)
+
     def wait_until_focused(self, selector):
         """ Wait until element matching CSS selector has focus """
         is_focused = \

