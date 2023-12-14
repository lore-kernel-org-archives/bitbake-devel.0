Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 908ABC4167B
	for <webhook@archiver.kernel.org>; Thu, 14 Dec 2023 22:08:52 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.41360.1702591728313203411
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 14 Dec 2023 14:08:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=npRNQBCR;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id DA2BF9C40CE
	for <bitbake-devel@lists.openembedded.org>; Thu, 14 Dec 2023 17:08:46 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id MZCXiKFHiJgb; Thu, 14 Dec 2023 17:08:46 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 8E1589C40E5;
	Thu, 14 Dec 2023 17:08:46 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 8E1589C40E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1702591726; bh=T40SCCGTFfMaLWWT3BLktyOQva7WuILNuLJoE9FRmps=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=npRNQBCRJyCjtLoKiIpoRdEMm6zdqXGIw5aONVJTiSHaqth6NeR4UyCh3X1AS8agc
	 GgaHn8A+TXiOCMFM0yuQhYFGv00b7JTQQA7fT14sfDletEtqDJBByxMtgVQ8gVt2p+
	 /MaL15MDTD/DAIorItSPxjxj2Ukh9/9uCbZfUSGwnFjfCHSXlxfaW97FdD6XM7JPTi
	 Daa334iqFUNTZUOiZM0aY6YF+kZ2jD00pFjUdxyk1hih33GYnMMqzRl2MK7zcfuIx6
	 mUJ8oo0bvloBKnr0bbf/wWCsG0TwAd5crR4amMRU1HAF5xGKrACN5G+tQ/aRSDnPTv
	 0XJ+YGmdfeaWQ==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id FaF2m8yUVqZp; Thu, 14 Dec 2023 17:08:46 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id BB3379C33C0;
	Thu, 14 Dec 2023 17:08:45 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 2/6] toaster/test: logging warning in console, trying to kill unavailable Runbuilds process
Date: Thu, 14 Dec 2023 23:08:35 +0100
Message-Id: <20231214220839.598125-2-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214220839.598125-1-alassane.yattara@savoirfairelinux.com>
References: <20231214220839.598125-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 14 Dec 2023 22:08:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15672

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


