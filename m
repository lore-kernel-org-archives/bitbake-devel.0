Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44651C001B2
	for <webhook@archiver.kernel.org>; Thu,  9 Nov 2023 17:44:28 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.329.1699551859224159627
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Nov 2023 09:44:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=Qic4FySM;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 90E879C327A
	for <bitbake-devel@lists.openembedded.org>; Thu,  9 Nov 2023 12:44:18 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id kWRtYsMar-gt; Thu,  9 Nov 2023 12:44:18 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 13D869C2CF2;
	Thu,  9 Nov 2023 12:44:18 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 13D869C2CF2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1699551858; bh=+m/KNy2AMqWB1h1tnjZcHiD38duvHCRhaP6gbInNBKI=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=Qic4FySM9Gyz78W4dLx4oz6FdoUvitKQgrXZirwaRltP4/RIMEd5sqGjg3B4FrSAr
	 pHAcc/7IPAmHJsLkBRWbj24/Cyy5Ok7M+ZVpWmxreoMGZFk2cKGeCxI+jCzg4FvzOo
	 FwnuCdoQNW+eiLim0FYn5bRruoexEVkJ9kyphjm5m2yPszQEkS518gCZXFZldie7kp
	 yTFb4LvZxpjTTazEvnF/VFOvPIalmnu+0tnqIBlyODMInvZQpz81xyo6YySTKLkKLQ
	 CxaR25f0OMGSL88phiMFqI7KATwFIoOG8bmuQLuMSekH1KQ65PhaJloLCLwQQ5bvSN
	 u2CLwxtfBfsew==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id xFUCc59Et6fQ; Thu,  9 Nov 2023 12:44:18 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 2AF319C2CD7;
	Thu,  9 Nov 2023 12:44:17 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH v5 2/6] Toaster: Update orm.models to catch error ProcessLookupError
Date: Thu,  9 Nov 2023 18:44:08 +0100
Message-Id: <20231109174412.257199-2-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231109174412.257199-1-alassane.yattara@savoirfairelinux.com>
References: <20231109174412.257199-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 09 Nov 2023 17:44:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15479

- catch error ProcessLookupError and logs it

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


