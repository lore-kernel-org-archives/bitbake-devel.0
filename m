Return-Path: <paulg@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9A0C48BC3
	for <webhook@archiver.kernel.org>; Sun, 18 Feb 2024 00:51:19 +0000 (UTC)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by mx.groups.io with SMTP id smtpd.web10.9924.1708217477504304086
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 17 Feb 2024 16:51:17 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@kernel.org header.s=k20201202 header.b=sfp/XGtz;
 spf=pass (domain: kernel.org, ip: 145.40.73.55, mailfrom: paulg@kernel.org)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 2E49ACE0B3A;
	Sun, 18 Feb 2024 00:51:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F98C433C7;
	Sun, 18 Feb 2024 00:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708217472;
	bh=oYyuWz6NnMSFcCrOrWYDIy5/L6kYuPmBfT1tOtyoVUI=;
	h=From:To:Cc:Subject:Date:From;
	b=sfp/XGtzb0aL2Eq1vHPA44A/GataekVFZVy2zgGZAvKnC6O4YNYo7eBp3Q2exe6gW
	 AGW5lfwoa5LIjxfW72CMeVDZgz1uM48MKaVGCAJLgBznXWq38UOegJgp8ypsoNShEW
	 EVChE3TMr89FkJgFnZAD5O56RfWBFMkw8pxcbOK0CoYTe6trtEzANZBHtKZi26LzgM
	 sW2yI+PohJ8Kb9ghlphRj3G77Puy4BRhFlRwnMHXfq+xl/MrlI/yWBQpNMOkStgvQO
	 HstKitWaHmXtkWXrFchtw/p42Gs1UzqEkNVGDb9UgHfcIi7iAVhJPz52JZ1DL9oQo/
	 YVfvcKjHfCSTA==
From: paulg@kernel.org
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>,
	Paul Gortmaker <paulg@kernel.org>
Subject: [PATCH] hashserv: improve the loglevel error message to be more helpful
Date: Sat, 17 Feb 2024 19:51:06 -0500
Message-Id: <20240218005106.2268185-1-paulg@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 18 Feb 2024 00:51:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15909

From: Paul Gortmaker <paulg@kernel.org>

Coming from a kernel background, I was thinking along the lines of

	dmesg -n <integer>

for loglevel adjustments.  So I tried various large and small and
even zero number values with no luck before getting frustrated and
opening up the python.

Let us save others the frustration and give a hint what the args it
expects should look like.

Signed-off-by: Paul Gortmaker <paulg@kernel.org>

diff --git a/bin/bitbake-hashserv b/bin/bitbake-hashserv
index c913c4e3..4bfb7abf 100755
--- a/bin/bitbake-hashserv
+++ b/bin/bitbake-hashserv
@@ -132,7 +132,7 @@ The following permissions are supported by the server=
:
=20
     level =3D getattr(logging, args.log.upper(), None)
     if not isinstance(level, int):
-        raise ValueError("Invalid log level: %s" % args.log)
+        raise ValueError("Invalid log level: %s (Try ERROR/WARNING/INFO/=
DEBUG)" % args.log)
=20
     logger.setLevel(level)
     console =3D logging.StreamHandler()
--=20
2.25.1


