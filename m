Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E34CDB474
	for <webhook@archiver.kernel.org>; Mon, 16 Oct 2023 13:38:40 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.125781.1697463516345313536
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 16 Oct 2023 06:38:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=aPmm3OOM;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 6E1839C105C
	for <bitbake-devel@lists.openembedded.org>; Mon, 16 Oct 2023 09:38:34 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id jSwiBBPwzqXC; Mon, 16 Oct 2023 09:38:33 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id AB35A9C2AD5;
	Mon, 16 Oct 2023 09:38:33 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com AB35A9C2AD5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1697463513; bh=Vj+IxNioigsBCOh6DHQ/2kqH7GTqRdGROLaSNxpR3Ow=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=aPmm3OOMwb97gXnLZa/e3upuG8CyU8i712CWJgSyeITtgFtxBx2mzP99Okgq0yFsQ
	 GFmhKPsOAsuVjHY22vQvLbeaZ6S551bSAtoYTkGjtC8HGJnLtrWDSz38c/7l+2dL1f
	 l4w8z+O54A3IBknyb38qchF2iIJqx7CoiOovQpcVuQ8zaQ5VOUBmBi3bCO8jdnT1EK
	 W07nhSfv0WXsVleMn/a7cacCGoYiUBlMcJj44r+1pvZwWn4+3/grjnY9nm8gfmAHSS
	 UEFEFA7ZLsexgGGFICKwksmiO+SLCSYa3bEzWwBaZajx5vTqMkw8cnzKJtfkdSl7zW
	 DdZ6D2LjfYbhg==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 2srnoIaMRvE7; Mon, 16 Oct 2023 09:38:33 -0400 (EDT)
Received: from jedi.. (unknown [196.117.75.249])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id A47EB9C105C;
	Mon, 16 Oct 2023 09:38:32 -0400 (EDT)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH] [PATCH] Toaster: bug-fix on tests.browser.test_most_recent_builds_states
Date: Mon, 16 Oct 2023 14:38:10 +0100
Message-Id: <20231016133810.127631-1-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 16 Oct 2023 13:38:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15243

Fixed errors that make test_most_recent_builds_states failed.
Signed-off-by Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 lib/toaster/tests/browser/test_most_recent_builds_states.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/tests/browser/test_most_recent_builds_states.py =
b/lib/toaster/tests/browser/test_most_recent_builds_states.py
index a34a0928..949a9476 100644
--- a/lib/toaster/tests/browser/test_most_recent_builds_states.py
+++ b/lib/toaster/tests/browser/test_most_recent_builds_states.py
@@ -54,6 +54,7 @@ class TestMostRecentBuildsStates(SeleniumTestCase):
         build.outcome =3D Build.IN_PROGRESS
         build.recipes_to_parse =3D recipes_to_parse
         build.recipes_parsed =3D 0
+        build.save()
=20
         build_request.state =3D BuildRequest.REQ_INPROGRESS
         build_request.save()
@@ -100,7 +101,7 @@ class TestMostRecentBuildsStates(SeleniumTestCase):
             'Tasks starting', 'build should show "tasks starting" status=
')
=20
         # first task finished; check tasks progress bar
-        task1.order =3D 1
+        task1.outcome =3D Task.OUTCOME_SUCCESS
         task1.save()
=20
         self.get(url)
@@ -117,7 +118,7 @@ class TestMostRecentBuildsStates(SeleniumTestCase):
         element =3D Wait(self.driver).until(task_bar_updated, msg)
=20
         # last task finished; check tasks progress bar updates
-        task2.order =3D 2
+        task2.outcome =3D Task.OUTCOME_SUCCESS
         task2.save()
=20
         self.get(url)
--=20
2.34.1


