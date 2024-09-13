Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DD8FA3755
	for <webhook@archiver.kernel.org>; Fri, 13 Sep 2024 13:32:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web11.73383.1726234359290448830
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 13 Sep 2024 06:32:39 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34B0713D5
	for <bitbake-devel@lists.openembedded.org>; Fri, 13 Sep 2024 06:33:08 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-04.oss.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7A0783F73B
	for <bitbake-devel@lists.openembedded.org>; Fri, 13 Sep 2024 06:32:38 -0700 (PDT)
From: Ross Burton <ross.burton@arm.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] fetch2: don't try to preserve ownership when unpacking files
Date: Fri, 13 Sep 2024 14:32:32 +0100
Message-Id: <20240913133232.3363082-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 13 Sep 2024 13:32:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16558

When copying files as part of the unpack we want to preserve the mode
(so executables are executable) and timestamps (for reproducibility) but
the ownership isn't really relevant: the files should be owned by the
build user and in situations where DL_DIR is shared between multiple
users there's no point asking to replicate ownership which cp will
silently fail to preserve.

Also expand the arguments to be clearer about what options are being
passed.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 bitbake/lib/bb/fetch2/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__=
init__.py
index ddee4400bbe..753a1c6ca9d 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -1606,7 +1606,7 @@ class FetchMethod(object):
                     if urlpath.find("/") !=3D -1:
                         destdir =3D urlpath.rsplit("/", 1)[0] + '/'
                         bb.utils.mkdirhier("%s/%s" % (unpackdir, destdir=
))
-                cmd =3D 'cp -fpPRH "%s" "%s"' % (file, destdir)
+                cmd =3D 'cp --force --preserve=3Dmode,timestamps --no-de=
reference --recursive -H "%s" "%s"' % (file, destdir)
         else:
             urldata.unpack_tracer.unpack("archive-extract", unpackdir)
=20
--=20
2.34.1


