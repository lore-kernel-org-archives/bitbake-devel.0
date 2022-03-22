Return-Path: <ross@burtonini.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017BCC433F5
	for <webhook@archiver.kernel.org>; Tue, 22 Mar 2022 11:40:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web11.8799.1647949254499840278
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 22 Mar 2022 04:40:54 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8007E153B
	for <bitbake-devel@lists.openembedded.org>;
 Tue, 22 Mar 2022 04:40:53 -0700 (PDT)
Received: from oss-tx204.lab.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 31FE93F774
	for <bitbake-devel@lists.openembedded.org>;
 Tue, 22 Mar 2022 04:40:53 -0700 (PDT)
From: Ross Burton <ross.burton@arm.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] knotty: reduce keep-alive timeout from 5000s (83 minutes) to
 10 minutes
Date: Tue, 22 Mar 2022 11:40:51 +0000
Message-Id: <20220322114051.3409221-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 22 Mar 2022 11:40:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13495

The keep alive timeout is excessively long at 83 minutes (5000 seconds),
reduce this to 10 minutes: this should be long enough that it rarely
triggers in normal builds, but when it does it has useful information.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 bitbake/lib/bb/ui/knotty.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index 50dd4229da4..b2e7520ee7d 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -623,7 +623,8 @@ def main(server, eventHandler, params, tf =3D Termina=
lFilter):
     warnings =3D 0
     taskfailures =3D []
=20
-    printinterval =3D 5000
+    printintervaldelta =3D 10 * 60 # 10 minutes
+    printinterval =3D printintervaldelta
     lastprint =3D time.time()
=20
     termfilter =3D tf(main, helper, console_handlers, params.options.qui=
et)
@@ -633,7 +634,7 @@ def main(server, eventHandler, params, tf =3D Termina=
lFilter):
         try:
             if (lastprint + printinterval) <=3D time.time():
                 termfilter.keepAlive(printinterval)
-                printinterval +=3D 5000
+                printinterval +=3D printintervaldelta
             event =3D eventHandler.waitEvent(0)
             if event is None:
                 if main.shutdown > 1:
@@ -664,7 +665,7 @@ def main(server, eventHandler, params, tf =3D Termina=
lFilter):
=20
             if isinstance(event, logging.LogRecord):
                 lastprint =3D time.time()
-                printinterval =3D 5000
+                printinterval =3D printintervaldelta
                 if event.levelno >=3D bb.msg.BBLogFormatter.ERRORONCE:
                     errors =3D errors + 1
                     return_value =3D 1
--=20
2.25.1


