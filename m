Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59D0C4332F
	for <webhook@archiver.kernel.org>; Mon, 30 Oct 2023 19:51:14 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.159174.1698695471682002168
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 30 Oct 2023 12:51:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=cW0thYrV;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 45AD59C284C
	for <bitbake-devel@lists.openembedded.org>; Mon, 30 Oct 2023 15:51:10 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id VldZ5c-60Hab; Mon, 30 Oct 2023 15:51:09 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id E18F49C2A91;
	Mon, 30 Oct 2023 15:51:08 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com E18F49C2A91
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1698695468; bh=BJJCHJagV8wWB7OftgGDU0y8IUJUDqTzkxwOyUfE7YE=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=cW0thYrVXlOVnVHX1Ang4mqoR84EuI19ECHU7Q3OZBtzm6yPeGSn8+atJ+csghAKT
	 SZqNY1dS6Hk4W+rqX2VRnLoqF97yLxam/eUvrevWnVQ7USa8Bz9kii0oVB2WfFiS44
	 dPIoDifZUOQ05uv6zq2JRjs2xkQ4n7CwV/Bi8o5u6KpnIp+yyqERccp6QNCthiHE1E
	 9RCuUMfUazvgPxLPL5Dta1wyIOQ3hXb7IjjMnlydqJK2drLvvkFgpg/TkbuF6KEdmf
	 ltLR/c7sxZwQCdvMqVbM2DjC6YESeZ2PKR8QhY7fcgdj2JEeP4AkzenJ82HBny4Tg8
	 aqvEIRukP1WBQ==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id brulBryg4fWi; Mon, 30 Oct 2023 15:51:08 -0400 (EDT)
Received: from localhost.localdomain (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 089C69C2848;
	Mon, 30 Oct 2023 15:51:07 -0400 (EDT)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 2/8] Toaster: Update orm.models to catch error ProcessLookupError
Date: Mon, 30 Oct 2023 20:50:31 +0100
Message-Id: <20231030195037.232912-2-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030195037.232912-1-alassane.yattara@savoirfairelinux.com>
References: <20231030195037.232912-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 30 Oct 2023 19:51:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15325

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 lib/toaster/orm/models.py | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 0d503a51..4f6d2147 100644
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
@@ -1838,6 +1835,7 @@ class LogMessage(models.Model):
     def __str__(self):
         return force_bytes('%s %s %s' % (self.get_level_display(), self.=
message, self.build))
=20
+
 def invalidate_cache(**kwargs):
     from django.core.cache import cache
     try:
@@ -1845,6 +1843,7 @@ def invalidate_cache(**kwargs):
     except Exception as e:
       logger.warning("Problem with cache backend: Failed to clear cache:=
 %s" % e)
=20
+
 def signal_runbuilds():
     """Send SIGUSR1 to runbuilds process"""
     try:
@@ -1853,6 +1852,9 @@ def signal_runbuilds():
             os.kill(int(pidf.read()), SIGUSR1)
     except FileNotFoundError:
         logger.info("Stopping existing runbuilds: no current process fou=
nd")
+    except ProcessLookupError:
+        pass
+
=20
 class Distro(models.Model):
     search_allowed_fields =3D ["name", "description", "layer_version__la=
yer__name"]
--=20
2.34.1


