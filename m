Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A63C41535
	for <webhook@archiver.kernel.org>; Tue, 31 Oct 2023 17:42:23 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.2154.1698774135514806046
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 31 Oct 2023 10:42:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=slc0gFFj;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 6B1F99C2C3E
	for <bitbake-devel@lists.openembedded.org>; Tue, 31 Oct 2023 13:42:14 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id dobroo4e5Srv; Tue, 31 Oct 2023 13:42:14 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id F3A279C279F;
	Tue, 31 Oct 2023 13:42:13 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com F3A279C279F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1698774133; bh=JhLwEPCsmDfLpE/oLx8JWsAus2WbbiL787g0liGl4FI=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=slc0gFFj+oAo3YSs3dtxlTaoJqUN2n8Jwp5Vm3nuSkXn1oyoX3q8TzrDFumEaXcB/
	 zbHsgDO5eHIT1QsR4kF9e2DRQWLSVR7FJhcuzriVwOLURXjyf2Jru6ZwguKZW8lhFU
	 AS0tsUBNhX83YfRb5IzA6S0kxH7+viwmv9xN0s7S9v9Xg0WJIq79xtTttKXTQb7JKx
	 B8xzcV/I1V5PW5zzSW8v9fqrD85tuANBYuonvOiWBoHObgQtjJ9N2V+Ae8usHis+XJ
	 xnsS0gWeAsSujGaRj5IHqHJZYojUKHWqkFFu/zsqRv54Z6KAbKoG5WPHkbQAxwsb6G
	 XB8aIBgDhnufw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 8u1OgmVEqwMJ; Tue, 31 Oct 2023 13:42:13 -0400 (EDT)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 35C9A9C2BE3;
	Tue, 31 Oct 2023 13:42:13 -0400 (EDT)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH v2 2/8] Toaster: Update orm.models to catch error ProcessLookupError
Date: Tue, 31 Oct 2023 18:41:57 +0100
Message-Id: <20231031174159.696667-2-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231031174159.696667-1-alassane.yattara@savoirfairelinux.com>
References: <20231031174159.696667-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 31 Oct 2023 17:42:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15374

- Remove extra line to keep standart in file.
    Yes, there are PEP8 style guide:
        - Two blank lines between each function, class declaration
    W'll update whole file for PEP8 standard style guide when need.
- Added logs for catched ProcessLookupError

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 lib/toaster/orm/models.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 0d503a51..1098ad3f 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -1389,9 +1389,6 @@ class Machine(models.Model):
         return "Machine " + self.name + "(" + self.description + ")"
=20
=20
-
-
-
 class BitbakeVersion(models.Model):
=20
     name =3D models.CharField(max_length=3D32, unique =3D True)
@@ -1853,6 +1850,8 @@ def signal_runbuilds():
             os.kill(int(pidf.read()), SIGUSR1)
     except FileNotFoundError:
         logger.info("Stopping existing runbuilds: no current process fou=
nd")
+    except ProcessLookupError:
+        logger.warning("Stopping existing runbuilds: process lookup not =
found")
=20
 class Distro(models.Model):
     search_allowed_fields =3D ["name", "description", "layer_version__la=
yer__name"]
--=20
2.34.1


