Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96531C46CA0
	for <webhook@archiver.kernel.org>; Wed,  6 Dec 2023 14:45:08 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web10.33382.1701873898997394794
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 06 Dec 2023 06:44:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=S+PWTtWa;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40c09f4814eso49862635e9.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 06 Dec 2023 06:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1701873897; x=1702478697; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=852hOmjs9KgegKi4RKP/aebyr37rxk2jmHAODKUIz7k=;
        b=S+PWTtWauhwimN8un8o1wTO3xK8hczoIw0JQCgd9Uvxm3MZ19hsxC3UyWXpe/JS8Vj
         QhhcnL7kyvUxNGejdESULW6jepWLdMiDFMLfIGUUs6QxG5mSSQ+9t606JMxkM+AWgdM0
         wntX3b1Ko0XYAgJE6nVdjSCoLujl6fc2CIRD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701873897; x=1702478697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=852hOmjs9KgegKi4RKP/aebyr37rxk2jmHAODKUIz7k=;
        b=MGNj5usve9gCzF4ZWllXkpeOnmrFuPMbFQPGkJO8WAIuEEhemWbzCOU3Trt2hycPOu
         bTEF/ho2laLNoZNSpeVfHsfZ8U2lNnaEgEStyoc45TPDTiduW5/vSIh0DIZMeRakvnNR
         ushMCp+Qe5+VOUG2et9XHdUPIzIv5ENLUrlBtUYfj2ccR+ISo9LakfXvbaXuU2UhE2hL
         zQGfcMfqdvSAksrmNaD0Qh/jf9K6UKXy7pOoIq+HTemHakxhDqjwxPVVX9uHBaDcUwF/
         TeU8tzB8wPlgGtZ/uQTcUV3mSgRIRVJWc0I1CzpxhCEAT5E/CFtXFeBOiG746E8OMuZx
         cOEA==
X-Gm-Message-State: AOJu0YxMIFWq9eCeFvimakadDfdrEgaeaRdQGiG2QC52cT6uwqhgl2A+
	dXvQyrPGF2bjhPWaqnxJTfVK96vIkKC11dS0Jpw=
X-Google-Smtp-Source: AGHT+IEte108F0YvsQKbeLou4Jrj0Jq1eWbWgAeUgq8mGdW3p1TIQdlBKK8J+U6x1RgZTXNjFaRlDw==
X-Received: by 2002:a05:600c:524e:b0:409:1841:3f42 with SMTP id fc14-20020a05600c524e00b0040918413f42mr685195wmb.13.1701873897098;
        Wed, 06 Dec 2023 06:44:57 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:3cca:8f76:d5f9:e02c])
        by smtp.gmail.com with ESMTPSA id r12-20020a05600c458c00b0040b4b66110csm22108082wmo.22.2023.12.06.06.44.56
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 06:44:56 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/3] toaster: Fix assertRegexpMatches deprecation warnings
Date: Wed,  6 Dec 2023 14:44:54 +0000
Message-Id: <20231206144455.1604879-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231206144455.1604879-1-richard.purdie@linuxfoundation.org>
References: <20231206144455.1604879-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 06 Dec 2023 14:45:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15619

Fix:
    DeprecationWarning: Please use assertRegex instead.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 .../tests/browser/test_most_recent_builds_states.py       | 8 ++++----
 lib/toaster/tests/browser/test_new_custom_image_page.py   | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/toaster/tests/browser/test_most_recent_builds_states.py b/lib/toaster/tests/browser/test_most_recent_builds_states.py
index 949a94768a..c13d328e47 100644
--- a/lib/toaster/tests/browser/test_most_recent_builds_states.py
+++ b/lib/toaster/tests/browser/test_most_recent_builds_states.py
@@ -47,7 +47,7 @@ class TestMostRecentBuildsStates(SeleniumTestCase):
         # build queued; check shown as queued
         selector = base_selector + '[data-build-state="Queued"]'
         element = self.wait_until_visible(selector)
-        self.assertRegexpMatches(element.get_attribute('innerHTML'),
+        self.assertRegex(element.get_attribute('innerHTML'),
             'Build queued', 'build should show queued status')
 
         # waiting for recipes to be parsed
@@ -97,7 +97,7 @@ class TestMostRecentBuildsStates(SeleniumTestCase):
 
         selector = base_selector + '[data-build-state="Starting"]'
         element = self.wait_until_visible(selector)
-        self.assertRegexpMatches(element.get_attribute('innerHTML'),
+        self.assertRegex(element.get_attribute('innerHTML'),
             'Tasks starting', 'build should show "tasks starting" status')
 
         # first task finished; check tasks progress bar
@@ -186,7 +186,7 @@ class TestMostRecentBuildsStates(SeleniumTestCase):
         selector = '[data-latest-build-result="%s"] ' \
             '[data-build-state="Cancelling"]' % build.id
         element = self.wait_until_visible(selector)
-        self.assertRegexpMatches(element.get_attribute('innerHTML'),
+        self.assertRegex(element.get_attribute('innerHTML'),
             'Cancelling the build', 'build should show "cancelling" status')
 
         # check cancelled state
@@ -198,5 +198,5 @@ class TestMostRecentBuildsStates(SeleniumTestCase):
         selector = '[data-latest-build-result="%s"] ' \
             '[data-build-state="Cancelled"]' % build.id
         element = self.wait_until_visible(selector)
-        self.assertRegexpMatches(element.get_attribute('innerHTML'),
+        self.assertRegex(element.get_attribute('innerHTML'),
             'Build cancelled', 'build should show "cancelled" status')
diff --git a/lib/toaster/tests/browser/test_new_custom_image_page.py b/lib/toaster/tests/browser/test_new_custom_image_page.py
index 34d1bd45c7..f4d95b1acd 100644
--- a/lib/toaster/tests/browser/test_new_custom_image_page.py
+++ b/lib/toaster/tests/browser/test_new_custom_image_page.py
@@ -136,7 +136,7 @@ class TestNewCustomImagePage(SeleniumTestCase):
         """
         self._create_custom_image(self.recipe.name)
         element = self.wait_until_visible('#invalid-name-help')
-        self.assertRegexpMatches(element.text.strip(),
+        self.assertRegex(element.text.strip(),
                                  'image with this name already exists')
 
     def test_new_duplicates_project_image(self):
@@ -154,4 +154,4 @@ class TestNewCustomImagePage(SeleniumTestCase):
         self._create_custom_image(custom_image_name)
         element = self.wait_until_visible('#invalid-name-help')
         expected = 'An image with this name already exists in this project'
-        self.assertRegexpMatches(element.text.strip(), expected)
+        self.assertRegex(element.text.strip(), expected)
-- 
2.39.2


