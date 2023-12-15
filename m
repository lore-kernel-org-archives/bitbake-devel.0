Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14273C41535
	for <webhook@archiver.kernel.org>; Fri, 15 Dec 2023 09:39:18 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.58980.1702633148331047742
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 15 Dec 2023 01:39:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=gZ69RMWh;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 01CF99C401F
	for <bitbake-devel@lists.openembedded.org>; Fri, 15 Dec 2023 04:39:07 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id SbDyjUqvffb6; Fri, 15 Dec 2023 04:39:06 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id AFDA59C3A2F;
	Fri, 15 Dec 2023 04:39:06 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com AFDA59C3A2F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1702633146; bh=BkeybDozN5OZVIQ0bVa2lGke12WHwRHsSfwhz4Ulb6c=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=gZ69RMWhDy9smCRDs5orGAp4/sCJvb3aPAgkI6snZD//KW7oA0o80NPehzLnSf+0r
	 bM2WKNjeK6+1uQuza15H0ihphgxqSBfVIB+p6l7Ot1qbLogr9rLiLF9EgktambHt1b
	 lnZAjOuZaXXya7FLc1JtZoDPW8EXOt7sljrtT8k5QroKCCYav+Ygw9h+Q5ec2iR/9t
	 vCnBUutPMAO4DjGzwyscPr2AY8jhTAyMDMnAkQKAJTdmW4ILq2FLvTQ6TEVbCrlziF
	 LCHYxEWkkHDfTcLvCom5by+IeidFXaoSKA8GLHu2SYXkReWyfjCrzeQ2wQGI9Tchbx
	 5gKMRZvMsFuOA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id tkH_gZKQWQIk; Fri, 15 Dec 2023 04:39:06 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 0F3149C3636;
	Fri, 15 Dec 2023 04:39:05 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH v3 2/5] toaster/test: Handle ProcessLookupError, log warning in console
Date: Fri, 15 Dec 2023 10:38:36 +0100
Message-Id: <20231215093839.99358-2-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231215093839.99358-1-alassane.yattara@savoirfairelinux.com>
References: <20231215093839.99358-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 15 Dec 2023 09:39:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15682

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


