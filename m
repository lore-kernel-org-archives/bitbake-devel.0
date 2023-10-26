Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF85C25B6B
	for <webhook@archiver.kernel.org>; Thu, 26 Oct 2023 14:06:07 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.71449.1698329163586461798
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 26 Oct 2023 07:06:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=jl4+8W29;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id C0EE59C29B3;
	Thu, 26 Oct 2023 10:06:02 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id u7NGYu3uJTf2; Thu, 26 Oct 2023 10:06:02 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 311229C2D0E;
	Thu, 26 Oct 2023 10:06:02 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 311229C2D0E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1698329162; bh=NzuNxM4wE0OFoYTR7HX2zx3eKx31JlgpCK6zh8E76NU=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=jl4+8W29qe8DMq31/EPDks3rjazGqRixz0TCYxH36VAD7kZIwOZkzz1BcMX/EXBtJ
	 SPMwMXzsQ0upn17fvo4ASbnNecJn7RaPqU9KxkMS12HSFeoIhAdtkf6aVb94N4EvDS
	 nu+yvrpMFFesFLnV7EtgTWX6muWX2bHuydmqpb8lD1hrRevngpP6kihmyWWeKUCbDG
	 LGlnMyHSQqmFKvScWIIOOloaPBgfnljFWt5pnM5QCEe09NZDak06OiYP+PZmUOs+ki
	 wxjbRMzEpnsO3T87T+scX8VYyBRj882ySXAwaQf62fqDdvipzvaIbfedulBi//9Ty5
	 CRqRtV6p5q+HQ==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 7gw42dis__hU; Thu, 26 Oct 2023 10:06:02 -0400 (EDT)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 185AA9C29B3;
	Thu, 26 Oct 2023 10:06:00 -0400 (EDT)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Tim Orling <tim.orling@konsulko.com>,
	Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 3/3] Bug-fix logging permission error in docker
Date: Thu, 26 Oct 2023 15:04:53 +0100
Message-Id: <20231026140453.790676-3-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026140453.790676-1-alassane.yattara@savoirfairelinux.com>
References: <20231026140453.790676-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 26 Oct 2023 14:06:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15289

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


