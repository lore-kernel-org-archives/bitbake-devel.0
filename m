Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94AC5CDB465
	for <webhook@archiver.kernel.org>; Mon, 16 Oct 2023 16:52:21 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.132296.1697475139598740721
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 16 Oct 2023 09:52:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=ZRxUwDTg;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id CD0BF9C2C9E
	for <bitbake-devel@lists.openembedded.org>; Mon, 16 Oct 2023 12:52:17 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id IGY6Oh1Wi78P; Mon, 16 Oct 2023 12:52:17 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 16F8F9C2CC5;
	Mon, 16 Oct 2023 12:52:17 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 16F8F9C2CC5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1697475137; bh=pdWlMTBWfzOQSCU3YlFpBz66yCThJ3UcBYl95fZ6paw=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=ZRxUwDTgE4xheLAsWUKaliZdBQWPWAtECzlEhrQ/8ymP4nux5MuQQkrFV1n003V7u
	 fKHCvzDuhCQwoSSJukF6DHgegpGugjQSCBpATk6wSOwiPvudI+lwutUqYM+cVWr0cy
	 bcqo1s1h+j2Q0i9wedTJHv0tTIRcCqXQJ9CDIrytnmL1Hrr4ckurnZMa8lfbys02HH
	 dsqWpZAK6elZpeL+tQtOnGEehj2OUgjKwH827pNMZgns1YCpVjK9XMgN22AMyiZJeL
	 deDWJG+JOUbBp6h6lzUJHYwIgVCXNx+esWVNMOHRjf50ZYO57Rl7HhEc+NKu9mf0dt
	 EueJXP+Y1QTIg==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id GRamP7n2GmxG; Mon, 16 Oct 2023 12:52:17 -0400 (EDT)
Received: from jedi.. (unknown [196.117.75.249])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 443D59C2C9E;
	Mon, 16 Oct 2023 12:52:16 -0400 (EDT)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH] Toaster: Fixed javascript issue on tests.browser.test_js_unit_tests
Date: Mon, 16 Oct 2023 17:52:13 +0100
Message-Id: <20231016165213.342109-1-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 16 Oct 2023 16:52:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15246

- Update /toastergui/static/js/projectpage.js to fix following
javascript issue that make fail test_js_unit_tests.
Uncaught TypeError: Cannot read properties of null (reading 'name')

Signed-off-by Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 lib/toaster/toastergui/static/js/projectpage.js | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/static/js/projectpage.js b/lib/toaste=
r/toastergui/static/js/projectpage.js
index 506471e0..a3c95810 100644
--- a/lib/toaster/toastergui/static/js/projectpage.js
+++ b/lib/toaster/toastergui/static/js/projectpage.js
@@ -61,7 +61,7 @@ function projectPageInit(ctx) {
         distroChangeInput.val(urlParams.setDistro);
         distroChangeBtn.click();
     } else {
-      updateDistroName(prjInfo.distro.name);
+      updateDistroName(prjInfo.distro?.name);
     }
=20
    /* Now we're really ready show the page */
--=20
2.34.1


