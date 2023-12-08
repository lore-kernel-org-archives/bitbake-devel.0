Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D078C46CA3
	for <webhook@archiver.kernel.org>; Fri,  8 Dec 2023 01:53:39 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.10262.1702000409036156472
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 07 Dec 2023 17:53:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=koIoeFx8;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 83ED39C33BA
	for <bitbake-devel@lists.openembedded.org>; Thu,  7 Dec 2023 20:53:27 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 6Qn86ZF31RUQ; Thu,  7 Dec 2023 20:53:27 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 0B1C69C319F;
	Thu,  7 Dec 2023 20:53:27 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 0B1C69C319F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1702000407; bh=kXHiGTTvkSE94RAwVf732AXnJ0fLRLfhLbc5yfgtXf8=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=koIoeFx8fL+fSzx3Rc269o68IOk866J5vY+R3iS3fc3qCkNY+kKX3/KovRdFd4b32
	 qCGO2Z5EodoiBgzMABzVAy59cirapyTV0pNyEO6Yw9aaxAYOt989WwKOdrwuFuh98J
	 ukTfe5TOjT3WwUR6D7yvUtXnDJ7oLf+b41u7YlhYNG8s5togudXfRahtyuyK+etZcK
	 lw6MBgUnJwKUkCf280B/lDDckSC+ifqg6OEjGYK0+5koCjiI6xqdbnweh0FI89V5sL
	 hMkKep9dImpp35sl67VcATOYRN4i5J/leSBhqjr7TdUt7dONhy13BjVVdZF5suJBSX
	 sw6dxq7cCjHgA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 7pZjqnSjAEJQ; Thu,  7 Dec 2023 20:53:26 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 3B50D9C3188;
	Thu,  7 Dec 2023 20:53:26 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 1/4] toaster/test: Ensure to kill toaster process create for tests functional
Date: Fri,  8 Dec 2023 02:53:16 +0100
Message-Id: <20231208015319.677993-1-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 08 Dec 2023 01:53:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15634

Toaster background task runbuilds continu running when even if tests is
done
Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 lib/toaster/tests/functional/functional_helpers.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/tests/functional/functional_helpers.py b/lib/toa=
ster/tests/functional/functional_helpers.py
index b80d403b..c37c5f8d 100644
--- a/lib/toaster/tests/functional/functional_helpers.py
+++ b/lib/toaster/tests/functional/functional_helpers.py
@@ -33,11 +33,11 @@ class SeleniumFunctionalTestCase(SeleniumTestCaseBase=
):
=20
         # start toaster
         cmd =3D "bash -c 'source toaster start'"
-        p =3D subprocess.Popen(
+        cls.p =3D subprocess.Popen(
             cmd,
             cwd=3Dos.environ.get("BUILDDIR"),
             shell=3DTrue)
-        if p.wait() !=3D 0:
+        if cls.p.wait() !=3D 0:
             raise RuntimeError("Can't initialize toaster")
=20
         super(SeleniumFunctionalTestCase, cls).setUpClass()
@@ -58,6 +58,7 @@ class SeleniumFunctionalTestCase(SeleniumTestCaseBase):
         with open(os.path.join(builddir, '.runbuilds.pid'), 'r') as f:
             runbuilds_pid =3D int(f.read())
             os.kill(runbuilds_pid, signal.SIGTERM)
+        cls.p.kill()
=20
=20
     def get_URL(self):
--=20
2.34.1


