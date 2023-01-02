Return-Path: <enguerrand.de-ribaucourt@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C7FC4708E
	for <webhook@archiver.kernel.org>; Mon,  2 Jan 2023 14:24:14 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.36031.1672669443994905662
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 02 Jan 2023 06:24:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=dfc430d2-d198-11ec-948e-34200cb392d2 header.b=xn3mHU49;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: enguerrand.de-ribaucourt@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 415DD9C0846;
	Mon,  2 Jan 2023 09:24:02 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 6bLr4R5daeoz; Mon,  2 Jan 2023 09:24:01 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id AE18B9C083D;
	Mon,  2 Jan 2023 09:24:01 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com AE18B9C083D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1672669441; bh=oXoJL6E4keDsge+G8BDQvuNqXeYMZNsLxMS9HYULU7A=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=xn3mHU49gbzuEuwxs534JihggfAItAeJypCwxRC9NfWDv6cRULZsc9bvrbp38+5J9
	 KYOh8ZKN21GLqPmZmpVgt7TlD4uQ1NgLMSLJBk31ruZfk5aomV96lXd5H6zzXM4q+q
	 vuZBiH9DizxiTyRJGWnTtykyzlPBp+jat04eOOslPvvZCsgKAK+CR0HIBJ97FuIIyA
	 iF4wz20Ptc1WGIqxZsCFaFeQ0S6387P2KO3C8I8AD5roNZfxwOnKs3E1jpJo7wEnvV
	 RH2A5XTwV6s7j2o57bmqqvaO20wQYs1YNxxuvsmwlmdeASOzQTIQnioI6BxNZhXVq6
	 Df3K2dnW7OLtQ==
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id f23upYqMJlLK; Mon,  2 Jan 2023 09:24:01 -0500 (EST)
Received: from sfl-deribaucourt.rennes.sfl (lmontsouris-657-1-69-118.w80-15.abo.wanadoo.fr [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id E0CCA9C0814;
	Mon,  2 Jan 2023 09:24:00 -0500 (EST)
From: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: alex@linutronix.de,
	richard.purdie@linuxfoundation.org,
	Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
Subject: [PATCH] bitbake-layers: fix a typo
Date: Mon,  2 Jan 2023 15:23:39 +0100
Message-Id: <20230102142339.37005-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 02 Jan 2023 14:24:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14278

Signed-off-by: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirf=
airelinux.com>
---
 meta/lib/bblayers/makesetup.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta/lib/bblayers/makesetup.py b/meta/lib/bblayers/makesetup=
.py
index 22f89d81a4..834e9338bc 100644
--- a/meta/lib/bblayers/makesetup.py
+++ b/meta/lib/bblayers/makesetup.py
@@ -46,7 +46,7 @@ class MakeSetupPlugin(LayerPlugin):
         return describe.strip()
=20
     def make_repo_config(self, destdir):
-        """ This is a helper function for the writer plugins that discov=
ers currently confugured layers.
+        """ This is a helper function for the writer plugins that discov=
ers currently configured layers.
         The writers do not have to use it, but it can save a bit of work=
 and avoid duplicated code, hence it is
         available here. """
         repos =3D {}
--=20
2.25.1


