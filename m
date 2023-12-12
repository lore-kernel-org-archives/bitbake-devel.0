Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB02C4332F
	for <webhook@archiver.kernel.org>; Tue, 12 Dec 2023 14:17:31 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.2575.1702390645202734195
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 12 Dec 2023 06:17:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=N07SEFhF;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 939059C3675
	for <bitbake-devel@lists.openembedded.org>; Tue, 12 Dec 2023 09:17:24 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id LHpk5EjWXYnS; Tue, 12 Dec 2023 09:17:24 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 1C9599C354B;
	Tue, 12 Dec 2023 09:17:24 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 1C9599C354B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1702390644; bh=BkeybDozN5OZVIQ0bVa2lGke12WHwRHsSfwhz4Ulb6c=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=N07SEFhF5R9jxcO14ei7/vXYHG1yRUgSlhqKeOb6QW/hFCAVdtO//BzkwSGA9+w+P
	 mh7jyMo625cMLdckRNyCrFEqV0tU6IhS+ld61dwyXoy5LcyRByld98R59UvyzwPGp2
	 aOQLzVjY/ci5zjOND0wJE2Qlc+N/+/x+yP1fZcH0Oi4j46sW6M8R0YW4xfiKhLqzJO
	 kPS0z+YEdrA8GFnVurIHQwp+1M/1/22EO77Y5CmtK61WGnw5cZOceao3vwob/GDsQJ
	 a9cQqy/3R4XuCq0QsmWC/i0QSr6BebrdfugdE8F8sL5psf9Haye5U5U7ufKwba9g0P
	 dVk2u5mfHtZqw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id dpLca8v09xxN; Tue, 12 Dec 2023 09:17:24 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 3D4069C3279;
	Tue, 12 Dec 2023 09:17:23 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 2/4] toaster/test: Handle ProcessLookupError, log warning in console
Date: Tue, 12 Dec 2023 15:17:06 +0100
Message-Id: <20231212141708.19395-2-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212141708.19395-1-alassane.yattara@savoirfairelinux.com>
References: <20231212141708.19395-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 12 Dec 2023 14:17:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15652

Note: While addressing warnings on the autobuilder, we encountered releva=
nt warnings
where attempts were made to terminate processes that were not running.

To enhance visibility, we have opted to catch the ProcessLookupError exce=
ption
and log a warning in the console rather than suppressing it.

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 lib/toaster/tests/commands/test_runbuilds.py | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/lib/toaster/tests/commands/test_runbuilds.py b/lib/toaster/t=
ests/commands/test_runbuilds.py
index 738d36e9..849c227e 100644
--- a/lib/toaster/tests/commands/test_runbuilds.py
+++ b/lib/toaster/tests/commands/test_runbuilds.py
@@ -22,8 +22,6 @@ import signal
 import logging
=20
=20
-logger =3D logging.getLogger("toaster")
-
 class KillRunbuilds(threading.Thread):
     """ Kill the runbuilds process after an amount of time """
     def __init__(self, *args, **kwargs):
@@ -43,7 +41,7 @@ class KillRunbuilds(threading.Thread):
                 pid =3D pidfile.read()
                 os.kill(int(pid), signal.SIGTERM)
         except ProcessLookupError:
-            logger.warning("Runbuilds not running or already killed")
+            logging.warning("Runbuilds not running or already killed")
=20
=20
 class TestCommands(TestCase):
--=20
2.34.1


