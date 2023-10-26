Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E0DC25B67
	for <webhook@archiver.kernel.org>; Thu, 26 Oct 2023 14:13:57 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.201364.1698329634920909747
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 26 Oct 2023 07:13:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=jJhcwfwb;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 311089C2BD5;
	Thu, 26 Oct 2023 10:13:54 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id FU88j4mwfkCj; Thu, 26 Oct 2023 10:13:53 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id B28449C2BF6;
	Thu, 26 Oct 2023 10:13:53 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com B28449C2BF6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1698329633; bh=NzuNxM4wE0OFoYTR7HX2zx3eKx31JlgpCK6zh8E76NU=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=jJhcwfwb9hwM0VOmBq9a4tvjNPzPZ8LWFYYUkDeWUxZq2rN6Xf5jhnoM5T6y5DcTv
	 aAOjrMCDvighw7p+XGMmivByfj6nzSm4EWunfoM7oPD8lBm9x6MLwfekcaBPd55h5Z
	 SbEfzK+W/tilNv7BIvZiHjWs6ESSDNDpqOSMjwaKez5twXLPLa6mFYMF03um25Yh41
	 bt33p0EirFszS2NxlhtQjGyrnEtO9XAVbRCRrxewwHFRqcmPKfMvDcD+9Xdw67pOoL
	 D/t8UbH1JgHh8u7e5aDdmN1K1P4zKwHrZScOuxT+D8iAax55+4jJBxO8HgS696ptZ3
	 UhJFWvjLpHgYQ==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id XJGZgontSVSq; Thu, 26 Oct 2023 10:13:53 -0400 (EDT)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id B86179C2BD5;
	Thu, 26 Oct 2023 10:13:52 -0400 (EDT)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Tim Orling <tim.orling@konsulko.com>,
	Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH v2 3/3] Toaster: Bug-fix logging permission error in docker
Date: Thu, 26 Oct 2023 15:13:38 +0100
Message-Id: <20231026141338.800428-3-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026141338.800428-1-alassane.yattara@savoirfairelinux.com>
References: <20231026141338.800428-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 26 Oct 2023 14:13:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15292

From: Tim Orling <tim.orling@konsulko.com>

Update toastermain, write logs to BUILDDIR
Maybe we should use TOASTER_DIR which is set by bin/toaster

Developer: Tim Orling
Reviewer: Alassane Yattara

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 bitbake/lib/toaster/toastermain/logs.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/toaster/toastermain/logs.py b/bitbake/lib/toaste=
r/toastermain/logs.py
index 573fbef9e5..f8042db165 100644
--- a/bitbake/lib/toaster/toastermain/logs.py
+++ b/bitbake/lib/toaster/toastermain/logs.py
@@ -110,7 +110,7 @@ LOGGING_SETTINGS =3D {
         'file_django': {
             'level': 'INFO',
             'class': 'logging.handlers.TimedRotatingFileHandler',
-            'filename': BUILDDIR / 'logs/django.log',
+            'filename': BUILDDIR / 'toaster_django.log',
             'when': 'D',  # interval type
             'interval': 1,  # defaults to 1
             'backupCount': 10,  # how many files to keep
@@ -119,7 +119,7 @@ LOGGING_SETTINGS =3D {
         'file_api': {
             'level': 'INFO',
             'class': 'logging.handlers.TimedRotatingFileHandler',
-            'filename': BUILDDIR / 'logs/api.log',
+            'filename': BUILDDIR / 'toaster_api.log',
             'when': 'D',
             'interval': 1,
             'backupCount': 10,
@@ -128,7 +128,7 @@ LOGGING_SETTINGS =3D {
         'file_toaster': {
             'level': 'INFO',
             'class': 'logging.handlers.TimedRotatingFileHandler',
-            'filename': BUILDDIR / 'logs/toaster.log',
+            'filename': BUILDDIR / 'toaster.log',
             'when': 'D',
             'interval': 1,
             'backupCount': 10,
--=20
2.34.1


