Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C543C36008
	for <webhook@archiver.kernel.org>; Wed, 26 Mar 2025 12:25:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web11.21065.1742991927229069746
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 26 Mar 2025 05:25:27 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 845A412FC
	for <bitbake-devel@lists.openembedded.org>; Wed, 26 Mar 2025 05:25:32 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-04.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 87C273F63F
	for <bitbake-devel@lists.openembedded.org>; Wed, 26 Mar 2025 05:25:26 -0700 (PDT)
From: Ross Burton <ross.burton@arm.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH v3 2/7] fetch2/wget: don't conditionalise --continue
Date: Wed, 26 Mar 2025 12:25:18 +0000
Message-ID: <20250326122523.293551-2-ross.burton@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250326122523.293551-1-ross.burton@arm.com>
References: <20250326122523.293551-1-ross.burton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 26 Mar 2025 12:25:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17496

If the target file exists, we pass --continue so that wget will try to
resume the download instead of starting from the beginning.  However if
the file doesn't exist --continue has no effect, so there's no need to
conditionalise the use of the argument.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 bitbake/lib/bb/fetch2/wget.py | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.p=
y
index df3e649312f..ee7afd3fda4 100644
--- a/bitbake/lib/bb/fetch2/wget.py
+++ b/bitbake/lib/bb/fetch2/wget.py
@@ -122,12 +122,7 @@ class Wget(FetchMethod):
                 fetchcmd +=3D " --user=3D%s --password=3D%s" % (ud.user,=
 ud.pswd)
=20
         uri =3D ud.url.split(";")[0]
-        if os.path.exists(ud.localpath):
-            # file exists, but we didnt complete it.. trying again..
-            fetchcmd +=3D " -c -P " + dldir + " '" + uri + "'"
-        else:
-            fetchcmd +=3D " -P " + dldir + " '" + uri + "'"
-
+        fetchcmd +=3D " -c -P " + dldir + " '" + uri + "'"
         self._runwget(ud, d, fetchcmd, False)
=20
         # Sanity check since wget can pretend it succeed when it didn't
--=20
2.43.0


