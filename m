Return-Path: <bluelightning@bluelightning.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298EFC77B61
	for <webhook@archiver.kernel.org>; Sat, 22 Apr 2023 03:05:36 +0000 (UTC)
Received: from mail2.g23.pair.com (mail2.g23.pair.com [66.39.132.40])
 by mx.groups.io with SMTP id smtpd.web11.1125.1682132731882047391
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Apr 2023 20:05:32 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=none, err=permanent DNS error (domain: bluelightning.org, ip: 66.39.132.40, mailfrom: bluelightning@bluelightning.org)
Received: from mail2.g23.pair.com (localhost [127.0.0.1])
	by mail2.g23.pair.com (Postfix) with ESMTP id 2B5D5E6117;
	Fri, 21 Apr 2023 23:05:31 -0400 (EDT)
Received: from linc.fritz.box (unknown [161.29.131.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by mail2.g23.pair.com (Postfix) with ESMTPSA id 3F2E4E5DE8;
	Fri, 21 Apr 2023 23:05:30 -0400 (EDT)
From: Paul Eggleton <bluelightning@bluelightning.org>
To: bitbake-devel@lists.openembedded.org
Cc: michael.opdenacker@bootlin.com
Subject: [PATCH 1/3] bitbake-user-manual: document BB_CACHEDIR
Date: Sat, 22 Apr 2023 15:05:21 +1200
Message-Id: <587973ae1e7967e15dd2c40c95a0831936ee3003.1682131637.git.bluelightning@bluelightning.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1682131637.git.bluelightning@bluelightning.org>
References: <cover.1682131637.git.bluelightning@bluelightning.org>
MIME-Version: 1.0
X-Scanned-By: mailmunge 3.11 on 66.39.132.40
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 22 Apr 2023 03:05:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14736

New variable for 2.4.

Signed-off-by: Paul Eggleton <bluelightning@bluelightning.org>
---
 .../bitbake-user-manual-ref-variables.rst                    | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rs=
t b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 25620fdda1..1cf37d5fcd 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -99,6 +99,11 @@ overview of their function and contents.
       the path of the build. BitBake's output should not (and usually do=
es
       not) depend on the directory in which it was built.
=20
+   :term:`BB_CACHEDIR`
+      Specifies the code parser cache directory (distinct from :term:`CA=
CHE`
+      and :term:`PERSISTENT_DIR` although they can be set to the same va=
lue
+      if desired). The default value is "${TOPDIR}/cache".
+
    :term:`BB_CHECK_SSL_CERTS`
       Specifies if SSL certificates should be checked when fetching. The=
 default
       value is ``1`` and certificates are not checked if the value is se=
t to ``0``.
--=20
2.34.1


