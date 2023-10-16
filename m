Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDA1C46CA1
	for <webhook@archiver.kernel.org>; Mon, 16 Oct 2023 16:36:21 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.131822.1697474177775246449
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 16 Oct 2023 09:36:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=XKzrvhs1;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id F05529C2CC5
	for <bitbake-devel@lists.openembedded.org>; Mon, 16 Oct 2023 12:36:16 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 89vkjMRkjjk3; Mon, 16 Oct 2023 12:36:16 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 5DD789C3188;
	Mon, 16 Oct 2023 12:36:16 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 5DD789C3188
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1697474176; bh=dySzsw3+gTRZH92Iwo3POH9jeNNXWQVR3ZIFWgF+6+I=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=XKzrvhs1C36Jj5EjME6GmumDxMNps4ebLXw/XHW3g7yqO+6WVkno0dP7fYyfGqxf/
	 Ktb9UgWmL/lk6oD/anv44wSE/5CeiHoRosT8WdC2exNI2p+/7jIn9NbQy8m4yfgzLC
	 Ym6USAROJcyAkRrq18iofcgYXJAY+HhHM7oa2SKjrWnbYg6kUs9rO3jlIFnMHvWB25
	 SACXIAgGyDx6iw/KryZZ0wRmIpj8GYqR7wZon3Oo14Kt9tAcmsttzZndK+S+t5dR6b
	 dgfn0bK3Z+5lqaT8naGNoNtILa3R1KMVs57Z4upGlN/F7mv+lFLTDHLHxeFOGcrgCO
	 zXk2QMktD4tPA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id KxT8ihl7pHji; Mon, 16 Oct 2023 12:36:16 -0400 (EDT)
Received: from jedi.. (unknown [196.117.75.249])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 996799C2CC5;
	Mon, 16 Oct 2023 12:36:15 -0400 (EDT)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH] Toaster: Bug-fix failure on tests.browser.test_layerdetails_page
Date: Mon, 16 Oct 2023 17:36:12 +0100
Message-Id: <20231016163612.313400-1-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 16 Oct 2023 16:36:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15245

Call wait_until_visible before send_keys to be sure inputs is visible oth=
erwise
we get followings error: selenium.common.exceptions.WebDriverException ->=
 Message: element not interactable
Signed-off-by Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 lib/toaster/tests/browser/test_layerdetails_page.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/toaster/tests/browser/test_layerdetails_page.py b/lib/to=
aster/tests/browser/test_layerdetails_page.py
index 71bdd2aa..cb7b915b 100644
--- a/lib/toaster/tests/browser/test_layerdetails_page.py
+++ b/lib/toaster/tests/browser/test_layerdetails_page.py
@@ -97,6 +97,8 @@ class TestLayerDetailsPage(SeleniumTestCase):
                             "Expecting any of \"%s\"but got \"%s\"" %
                             (self.initial_values, value))
=20
+            # Make sure the input visible beofre sending keys
+            self.wait_until_visible("#layer-git input[type=3Dtext]")
             inputs.send_keys("-edited")
=20
         # Save the new values
--=20
2.34.1


