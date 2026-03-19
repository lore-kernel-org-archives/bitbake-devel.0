Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE491088E67
	for <webhook@archiver.kernel.org>; Thu, 19 Mar 2026 02:49:21 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2874.1773888554643045273
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 18 Mar 2026 19:49:15 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@axis.com header.s=selector1 header.b=A0ZtEgIV;
 spf=pass (domain: axis.com, ip: 40.107.159.51, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WaGtAHfY06Kk2uRT6n3u5kwDLPtmuiYqsV5vy8KlXrm+3D4DZUNl6W90fYAn0LmDl415XSEEnjUch3yfWLlNE3BYhLDtYSy8eXIyEF+4CGyNG3+dUKj/6GL/PIkMYnIFquSIW0Gp65X6RuS6CW6uumGFm3TXRME++Z1JxAmCnLoeyeslbsph6sxAVmeOcXiIUVleYrb5Cx3NPcWmJNbGQCXnzzMxuc7he7Y8lUq3tdPxCMzH8pedkq4igJ2kb13EvuxGyLhjHZuYpHHlvNZR+iahNXEEkD9h/NHeYGZzKr+N6uK/B/iFuanZ1xZTyJrYhoJ7QMrCwuYSqZRy6o8fEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z4YjIU8FRQ4rzyDfqpwP5GL1kn//vuyBDZsc1UNbP9g=;
 b=wRq7ceeYMxQ13cyU9zt6L8cqgfTC+PXNo4iD0ZBL8T3UPJpWN8NIH4VSBjWlR8aztCdNSDwk7/6S85m7+xJv8DZXL4UO0ED8AMDA4AnPG7Jzcxo89qRNzieYsLNWa+NPoPip2LTLpxbYzNEyCxgTG1MNK+CKI+jfAlmE3qk2Pq0usxRtKdN6UsiBMaoJBGWE+s++e+SyWnbg4YHSjojeeOcs1Gal7ZIHcq/+3t3hU/Ex6lUUjFXWo1WxyjrJgChRxhgEtvbG/45ZmasO9ELa5dGxWNkhZDCMsqCnRNKtyUEohDXM+46NgGh9FHYXTCp22HvqtmiiqaiK8v5jJW/UNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=axis.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=axis.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4YjIU8FRQ4rzyDfqpwP5GL1kn//vuyBDZsc1UNbP9g=;
 b=A0ZtEgIVHGCC2kEnVEsQby3NT+9rWj8lNxo+R8ph1uas06An9DZrfKRwN18Frf6oPOx9ruF1z/xiRjBYAzb7FWMrTfGb8bpz+oje+M9orWqQNvAfw1+CXJLuif6Q3I4pjsslg508UkevlFwR3mjIDi2hW7pftwnCfIZDi00aDeg=
Received: from AS4P251CA0028.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:5d3::17)
 by VI0PR02MB10927.eurprd02.prod.outlook.com (2603:10a6:800:212::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 02:49:09 +0000
Received: from AM4PEPF00027A65.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d3:cafe::73) by AS4P251CA0028.outlook.office365.com
 (2603:10a6:20b:5d3::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19 via Frontend Transport; Thu,
 19 Mar 2026 02:49:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM4PEPF00027A65.mail.protection.outlook.com (10.167.16.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Thu, 19 Mar 2026 02:49:08 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Thu, 19 Mar
 2026 03:49:08 +0100
Received: from se-mail11w.axis.com (10.20.40.11) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Thu, 19 Mar
 2026 03:49:08 +0100
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Thu, 19 Mar 2026 03:49:08 +0100
Received: from pc56063-2339.se.axis.com (pc56063-2339.se.axis.com [10.92.3.2])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id 24B17201F
	for <bitbake-devel@lists.openembedded.org>; Thu, 19 Mar 2026 03:49:08 +0100 (CET)
Received: by pc56063-2339.se.axis.com (Postfix, from userid 14323)
	id 1FA2E12089F; Thu, 19 Mar 2026 03:49:08 +0100 (CET)
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [meta-oe][PATCH] liboauth2: Backport a patch to build with glibc 2.43
Date: Thu, 19 Mar 2026 03:49:03 +0100
Message-ID: <20260319024903.1627054-1-pkj@axis.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A65:EE_|VI0PR02MB10927:EE_
X-MS-Office365-Filtering-Correlation-Id: de2563c5-8e36-4140-a7c4-08de856217dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700016|13003099007|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	FT3NvTMM+Bv1OLmeuXuYw/cieSWZGoc/dk3Y96IGWa5CaSqNaE0uHWhymkdy8EJKB0f3jePYcjlTyTYI9cUexkMbE1Rv/AnajGv5T4wafNEp+kKoqx/W+UNZfHovQ/xPDn1HGs9uNLKoHiLS+u2DEBYZd3Hgd32/xseraMVVo6NJR1GKbPgRsVwPultn2j1PDd88OvHZHzY4cX55oOMZ5eT+jUfLodjsvJaJCVNMhGftdx8aTkNIsdFZtlJjytIG3ks6C4E/T8l9+dLbpgOObDulYjg7/toYM+x3z63pHRSBP8wPKBAjgPRa6h3Wl0bajOcR0B1Xt0Nty1ufmoRlm+zfN+T/UwVwMx0li7jg7Ty+Ek8q5JDy09dC/fGzT0lsX/q+ct1a5XR2NTMAaKzXOdFMHMulqCBvS54HTOUB1KLzDNM9pDD3AQa9rZU4RJUQj6x2/vniFXoUesL8U+Aom1mD0iaC4eKd4oxoPxZXWHvOcbyI7vRg2vxhA4J5/KlQXIh3vATNJSUOHIupdj+UTWaCVD38XjYmqnxmXbkFihOO8iC8Z8oOa1i9nqDnN4maryHkaS0EuHCri84xujD3OZk2qv6/0+dTkgADyuejS3oNmiG9JrmkTNR5DrYl/lSLLd2NYw10W1qPrUCJeIvzM0rrIbssoC2uCKiQT/U2QSBBVxryIQ78bvzr5vdZ6BDxmQtTKp4dk54H/651+MusBG5/tvl9QVYFaAEq+zaUJUE=
X-Forefront-Antispam-Report: 
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(13003099007)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	6jn+6s3u3Htc0vacjFkg71pVTTu5UyJZ7zceWt5degLbjgNZCAx7KyLfG4yCnJlBU4sjc7Fje0aiA2BrzfC68t8kAZ1xhKOibWk7zRsWH85MaNpQVuV0Kzt4/GYEIbma0Py9Dege3Z+1xBtJZuRinrYm0+ePx82h0VsZXMSLsF3k5bFE2l4OXlKuCp2ozV05T3AV6HTPRXyUhGp3iuh/Uy5/QdSK8S1C88qsO0zkn92qiu2Vs4zufNpZscGgFp9lKdLXRfgqI6DoJzMXhw9INRpQ0akHRzMeSFFBkwODYzM7WIdVkOTb1dYr+2RJeV4I+7xMmOtKONeHyptergfXyArbE4pKUzuZz75duZiEuvrStNlq59CbVYh5NWNgmPGooAAQKMCNZzeAJ3KayezwetP2tJFE92GqoLct/bsGemv2ZRbhHGSJBjVIvRWUV9Zz
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 02:49:08.6490
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de2563c5-8e36-4140-a7c4-08de856217dd
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AM4PEPF00027A65.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR02MB10927
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 19 Mar 2026 02:49:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19169

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 .../0002-Fix-use-of-strchr-with-new-GCC.patch | 33 +++++++++++++++++++
 .../liboauth2/liboauth2_2.2.0.bb              |  1 +
 2 files changed, 34 insertions(+)
 create mode 100644 meta-oe/recipes-support/liboauth2/liboauth2/0002-Fix-us=
e-of-strchr-with-new-GCC.patch

diff --git a/meta-oe/recipes-support/liboauth2/liboauth2/0002-Fix-use-of-st=
rchr-with-new-GCC.patch b/meta-oe/recipes-support/liboauth2/liboauth2/0002-=
Fix-use-of-strchr-with-new-GCC.patch
new file mode 100644
index 0000000000..65340e806a
--- /dev/null
+++ b/meta-oe/recipes-support/liboauth2/liboauth2/0002-Fix-use-of-strchr-wi=
th-new-GCC.patch
@@ -0,0 +1,33 @@
+From 0dcba079907d559550ee8d9a201d26203bb8aebd Mon Sep 17 00:00:00 2001
+From: Alexander Bokovoy <abokovoy@redhat.com>
+Date: Wed, 7 Jan 2026 11:41:37 +0200
+Subject: [PATCH] Fix use of strchr with new GCC
+
+According to C specification, 7.28.5.1, strchr() is a generic function
+and its string argument's type is promoted to the result. So if it is
+const char*, the result will be const char* as well.
+
+gcc in Fedora Rawhide (15.2.1 20251111 or later) implements this
+conformance, resulting in a compilation fail with
+-Werror=3Ddiscarded-qualifiers.
+
+Signed-off-by: Alexander Bokovoy <abokovoy@redhat.com>
+Upstream-Status: Backport [https://github.com/OpenIDC/liboauth2/commit/0dc=
ba079907d559550ee8d9a201d26203bb8aebd]
+Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
+---
+ src/jose.c | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
+
+diff --git a/src/jose.c b/src/jose.c
+index fbaf661..a3441c8 100644
+--- a/src/jose.c
++++ b/src/jose.c
+@@ -993,7 +993,7 @@ char *oauth2_jose_jwt_header_peek(oauth2_log_t *log,
+ {
+ 	char *input =3D NULL, *result =3D NULL;
+ 	json_t *json =3D NULL;
+-	char *p =3D NULL;
++	const char *p =3D NULL;
+ 	size_t result_len;
+ 	char *rv =3D NULL;
+=20
diff --git a/meta-oe/recipes-support/liboauth2/liboauth2_2.2.0.bb b/meta-oe=
/recipes-support/liboauth2/liboauth2_2.2.0.bb
index 31d7aec69d..244cd51a2c 100644
--- a/meta-oe/recipes-support/liboauth2/liboauth2_2.2.0.bb
+++ b/meta-oe/recipes-support/liboauth2/liboauth2_2.2.0.bb
@@ -6,6 +6,7 @@ LIC_FILES_CHKSUM =3D "file://LICENSE;md5=3D2ee41112a44fe701=
4dce33e26468ba93"
 SRC_URI =3D " \
     git://github.com/OpenIDC/liboauth2;protocol=3Dhttps;branch=3Dmaster;ta=
g=3Dv${PV} \
     file://0001-fix-clang-curl_easy_setopt-takes-a-long-not-an-int.patch \
+    file://0002-Fix-use-of-strchr-with-new-GCC.patch \
     "
=20
 PV =3D "2.2.0"

