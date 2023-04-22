Return-Path: <bluelightning@bluelightning.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EF7C77B61
	for <webhook@archiver.kernel.org>; Sat, 22 Apr 2023 03:05:46 +0000 (UTC)
Received: from mail2.g23.pair.com (mail2.g23.pair.com [66.39.132.40])
 by mx.groups.io with SMTP id smtpd.web10.1116.1682132736007217427
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Apr 2023 20:05:36 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=none, err=permanent DNS error (domain: bluelightning.org, ip: 66.39.132.40, mailfrom: bluelightning@bluelightning.org)
Received: from mail2.g23.pair.com (localhost [127.0.0.1])
	by mail2.g23.pair.com (Postfix) with ESMTP id 5AF29E612E;
	Fri, 21 Apr 2023 23:05:35 -0400 (EDT)
Received: from linc.fritz.box (unknown [161.29.131.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by mail2.g23.pair.com (Postfix) with ESMTPSA id 6E601E6128;
	Fri, 21 Apr 2023 23:05:34 -0400 (EDT)
From: Paul Eggleton <bluelightning@bluelightning.org>
To: bitbake-devel@lists.openembedded.org
Cc: michael.opdenacker@bootlin.com
Subject: [PATCH 3/3] bitbake-user-manual: add BB_HASH_CODEPARSER_VALS
Date: Sat, 22 Apr 2023 15:05:23 +1200
Message-Id: <91ed713bc9a00b7ae5ea2994a8a7431025392902.1682131637.git.bluelightning@bluelightning.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1682131637.git.bluelightning@bluelightning.org>
References: <cover.1682131637.git.bluelightning@bluelightning.org>
MIME-Version: 1.0
X-Scanned-By: mailmunge 3.11 on 66.39.132.40
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 22 Apr 2023 03:05:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14738

New variable for 2.4.

Signed-off-by: Paul Eggleton <bluelightning@bluelightning.org>
---
 .../bitbake-user-manual-ref-variables.rst             | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rs=
t b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index fc7cb88238..6ccf58b212 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -108,6 +108,17 @@ overview of their function and contents.
       Specifies if SSL certificates should be checked when fetching. The=
 default
       value is ``1`` and certificates are not checked if the value is se=
t to ``0``.
=20
+   :term:`BB_HASH_CODEPARSER_VALS`
+      Specifies values for variables to use when populating the codepars=
er cache.
+      This can be used selectively to set dummy values for variables to =
avoid
+      the codeparser cache growing on every parse. Variables that would =
typically
+      be included are those where the value is not significant for where=
 the
+      codeparser cache is used (i.e. when calculating variable dependenc=
ies for
+      code fragments.) The value is space-separated without quoting valu=
es, for
+      example::
+
+         BB_HASH_CODEPARSER_VALS =3D "T=3D/ WORKDIR=3D/ DATE=3D1234 TIME=
=3D1234"
+
    :term:`BB_CONSOLELOG`
       Specifies the path to a log file into which BitBake's user interfa=
ce
       writes output during the build.
--=20
2.34.1


