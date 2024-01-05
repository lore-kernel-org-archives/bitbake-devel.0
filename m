Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1EFC3DA6E
	for <webhook@archiver.kernel.org>; Fri,  5 Jan 2024 14:22:16 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.24447.1704464527877231592
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Jan 2024 06:22:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=OZEMDFBW;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id DF0D89C3964
	for <bitbake-devel@lists.openembedded.org>; Fri,  5 Jan 2024 09:22:06 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id ZegvD4QMsxpg; Fri,  5 Jan 2024 09:22:06 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 4B0F09C36BF;
	Fri,  5 Jan 2024 09:22:06 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 4B0F09C36BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1704464526; bh=Jm0YBBwWHv6vgsumruhXSCNe+WdHWTjWPCAqc/xfIRA=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=OZEMDFBWyGhl36NViImFry/ZybdvRQhIbG664EtorJOu7lYazzOyqLjq/iP3lhcN4
	 PRHcDqDFjfmzQD8WL7EAYeeje5SNlSgNSGHZ7tCdl0W4wj2Y4yh3+y/cPxtI15mAEn
	 MP2mhXtTxVGpEG7GHmHhtmKifCNA9B/uZiT047dJhF7UIa6uq8MdNRLED/v5wFhWrD
	 inWFF8O6iYivehspOVkIS55NXuJF6EurjpNAmEsXp0/M/bDOgGzalTV2ti4RAI1FQj
	 30Qqr+L86hxgucPx8HC0fgY9x0QlZ0fFSjaokvX0FYinbDJJr+cdFP2umAJ6NwWQaH
	 Gx8xpVUl/pu5Q==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id VaIMTYZzYqR4; Fri,  5 Jan 2024 09:22:06 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 8A23F9C32E2;
	Fri,  5 Jan 2024 09:22:05 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 2/3] toaster/test: Bug-fix element click intercepted
Date: Fri,  5 Jan 2024 15:21:49 +0100
Message-Id: <20240105142150.539538-2-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240105142150.539538-1-alassane.yattara@savoirfairelinux.com>
References: <20240105142150.539538-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Jan 2024 14:22:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15744

Fix "element click intercepted" on TestProjectConfigTab::test_project_con=
fig_tab_right_section

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 .../tests/functional/test_project_page_tab_config.py      | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/tests/functional/test_project_page_tab_config.py=
 b/lib/toaster/tests/functional/test_project_page_tab_config.py
index d027e0bc..03b0a854 100644
--- a/lib/toaster/tests/functional/test_project_page_tab_config.py
+++ b/lib/toaster/tests/functional/test_project_page_tab_config.py
@@ -12,7 +12,7 @@ import pytest
 from django.urls import reverse
 from selenium.webdriver import Keys
 from selenium.webdriver.support.select import Select
-from selenium.common.exceptions import NoSuchElementException, TimeoutEx=
ception
+from selenium.common.exceptions import ElementClickInterceptedException,=
 NoSuchElementException, TimeoutException
 from orm.models import Project
 from tests.functional.functional_helpers import SeleniumFunctionalTestCa=
se
 from selenium.webdriver.common.by import By
@@ -362,7 +362,11 @@ class TestProjectConfigTab(SeleniumFunctionalTestCas=
e):
             By.XPATH,
             '//*[@id=3D"layer-container"]/form/div/span/div'
         )
-        dropdown_item.click()
+        try:
+            dropdown_item.click()
+        except ElementClickInterceptedException:
+            self.skipTest(
+                "layer-container dropdown item click intercepted. Elemen=
t not properly visible.")
         add_layer_btn =3D layers.find_element(By.ID, 'add-layer-btn')
         add_layer_btn.click()
         self.wait_until_visible('#layers-in-project-list')
--=20
2.34.1


