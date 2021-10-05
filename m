Return-Path: <ross@burtonini.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62622C433F5
	for <webhook@archiver.kernel.org>; Tue,  5 Oct 2021 14:50:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web12.1522.1633445406318422255
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 05 Oct 2021 07:50:06 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DBA9BED1;
	Tue,  5 Oct 2021 07:50:05 -0700 (PDT)
Received: from oss-tx204.lab.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6BA663F70D;
	Tue,  5 Oct 2021 07:50:05 -0700 (PDT)
From: Ross Burton <ross.burton@arm.com>
To: bitbake-devel@lists.openembedded.org
Cc: mark.hatle@kernel.crashing.org
Subject: [PATCH 3/4] fetch2: clarify the command-no-found error message
Date: Tue,  5 Oct 2021 15:50:00 +0100
Message-Id: <20211005145001.2717748-3-ross.burton@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211005145001.2717748-1-ross.burton@arm.com>
References: <20211005145001.2717748-1-ross.burton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 05 Oct 2021 14:50:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12724

If runfetchcmd() fails with bb.process.NotFoundError, the message output
is simply "Fetch command" which doesn't really explain what the problem
is.

Add "not found" to clarify what happened.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 bitbake/lib/bb/fetch2/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__=
init__.py
index ee29d89b18..259b2637a6 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -884,7 +884,7 @@ def runfetchcmd(cmd, d, quiet=3DFalse, cleanup=3DNone=
, log=3DNone, workdir=3DNone):
         (output, errors) =3D bb.process.run(cmd, log=3Dlog, shell=3DTrue=
, stderr=3Dsubprocess.PIPE, cwd=3Dworkdir)
         success =3D True
     except bb.process.NotFoundError as e:
-        error_message =3D "Fetch command %s" % (e.command)
+        error_message =3D "Fetch command %s not found" % (e.command)
     except bb.process.ExecutionError as e:
         if e.stdout:
             output =3D "output:\n%s\n%s" % (e.stdout, e.stderr)
--=20
2.25.1


