Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B060C282C5
	for <webhook@archiver.kernel.org>; Fri, 28 Feb 2025 23:15:09 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.67])
 by mx.groups.io with SMTP id smtpd.web11.191.1740784507640288031
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 28 Feb 2025 15:15:07 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@axis.com header.s=selector1 header.b=gZN3xjxh;
 spf=pass (domain: axis.com, ip: 40.107.105.67, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CgurqI4E5il+SioygygtdTN1v/EqyWSa8xDm7wTeLW2c9/6Gox6WI4uEzq0L0B47sPHSuAeZtY0zwT0wguOgNmpNXZL0P0uY5+/wCv77bblYYxmNvhE+HwZMkf5dNCXMT6u+L3etXEaYeGConoNrJAIuQBsr88WHu+t/2Kh6gA154I/b3SZ3s9gGvv7p/J1wny65ub1rYetc8jJ5dYuKuWL1cmWxnggUpGoYELOOiXAJI+eBsXSaoRDxCj5hS3FvdnJxgHRxTZFSkWsMIgLNMfBVGOULZlPgwY71SR7jWOymYAK0FeVaPz0gWkAGDvM/p62tllOYaM29yFrqS8u+sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SoUB7DZWMjt0D5CR6k12keV3fayAF65J8wIjWlikRaQ=;
 b=y8IHDasw7mFJmYHRD/G+akd42eopG+Wb3rh1gCOpa6QhXlubY/V33mwlG6tDk6NtooxrxmhD59qhMRMb6AKhbyjkh74MEsNll/c3CgJf5Ja/Y/bLK5I3X7JYjrof90aS/JaokzfMLVsBJtZ6UfAG0WaOVrGBbrk1CnISYLNbNTPrbGSzJwsjDUAC9yxOSPUGl3Q07ZqCOB1+6hnvlAsUQFXKTJocFhdVde6gAArxXQbDapiJfoBKOcqWYxpsEsbsZKEEwrJ0cX90MflQBENplhGBOXwKwqjpk+Nlhhwkc1Fq7aUrLP3l7Rnm1xwyV72TwIopLc9z6jVctCieKLK8Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=axis.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=axis.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SoUB7DZWMjt0D5CR6k12keV3fayAF65J8wIjWlikRaQ=;
 b=gZN3xjxhO/cBFive4aNsiR193UqHlRbR9MJY4FRGpjb3nsVw7gES8I/b2dMRg7UOE2FBxhfRQOvbfWZfN2PMKXtaDIwmgZz2AHctVoN6N6zwHTlU+vQolUYb7NnDuVFc1oFnxcamoeMY0Xma+preAKYyyUQQ0SyW8pBcZ1V+yYI=
Received: from PR1P264CA0017.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:19e::22)
 by PAVPR02MB9063.eurprd02.prod.outlook.com (2603:10a6:102:2fd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Fri, 28 Feb
 2025 23:15:04 +0000
Received: from AMS0EPF000001AF.eurprd05.prod.outlook.com
 (2603:10a6:102:19e:cafe::58) by PR1P264CA0017.outlook.office365.com
 (2603:10a6:102:19e::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.22 via Frontend Transport; Fri,
 28 Feb 2025 23:15:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF000001AF.mail.protection.outlook.com (10.167.16.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 23:15:03 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Sat, 1 Mar
 2025 00:15:03 +0100
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Sat, 1 Mar 2025 00:15:03 +0100
Received: from saur (saur.se.axis.com [10.92.3.10])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 3391C28D
	for <bitbake-devel@lists.openembedded.org>; Sat,  1 Mar 2025 00:15:03 +0100 (CET)
Received: from saur.se.axis.com (localhost [127.0.0.1])
	by saur (8.17.1/8.15.2) with ESMTPS id 51SNF3J33905104
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Sat, 1 Mar 2025 00:15:03 +0100
Received: (from pkj@localhost)
	by saur.se.axis.com (8.17.1/8.17.1/Submit) id 51SNF2PY3905103
	for bitbake-devel@lists.openembedded.org; Sat, 1 Mar 2025 00:15:02 +0100
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 1/2] fetch2: Revert decodeurl() to not use the URI class
Date: Sat, 1 Mar 2025 00:15:00 +0100
Message-ID: <20250228231501.3905069-1-pkj@axis.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001AF:EE_|PAVPR02MB9063:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cb61b74-d357-40a1-d1ab-08dd584dbb60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?wp7QhjJ79L1ITxMu5ycGH52O9BhNefwloM3Zky9G67UZenidhYKKj4rhEien?=
 =?us-ascii?Q?7D3pNqXFjXU3UtzShapzzc2c5aIE31d0UGZPrMrwt1vpkKTv4Zu+TDk38OC0?=
 =?us-ascii?Q?K+FoHZFHVHEg6S2x/m/eSA0GspcaBvEi9z2qqxB57R6cJLDHvOid5ddFoxI+?=
 =?us-ascii?Q?175kMNbcQqOkYsM1FwQnEE/BxJhIsvo6eiGEXPpjGbEPnEEKpquXK+SBTXO+?=
 =?us-ascii?Q?qGf2I3T7oAzAGl0rsAlnsa0kGxYzDpXGc4TECtSY4Kl6e/1JO5ZWXh7MfZqe?=
 =?us-ascii?Q?OL/LF9b1AD1OKv4txhFNY2Zh7uVCoRBzZ5mMS3baPmv7GzyKToOCULWkOlvW?=
 =?us-ascii?Q?8nag2WR4Yx9PVgpOust/glkPll8fmY8vwuLw8OUfswg4rIauUUhpKnOxzC67?=
 =?us-ascii?Q?Fco3IqHibkIXWzRXogNE/jsHY3420WZkHO82ZK1RBgaxcuheW+07rFZv4CWD?=
 =?us-ascii?Q?zgzoSfsJVFa4zcrsYfrxGvkR/+6asZDCyvrRPmQYckLZYmgAs5H6csj3mKyP?=
 =?us-ascii?Q?lJzKEay7atRWNdQRXubLStAq70tCDd/I0qQd/VonhfknY+F96hVhO8xcT1sK?=
 =?us-ascii?Q?olyWYG263qbB8Z34z4lVkA11hzUKfwmlWtj6rRB3nD3OnhxIGrctE/APrJLR?=
 =?us-ascii?Q?Vn1Dcnuxll7SSgLWbRQE/t4LnPKgRTSkmuyRQIFB+nXbw3+lfH44O+OAUuj0?=
 =?us-ascii?Q?ovZefJT6pOmuwdTm76e2CymO4bQK+miah4Q9MbAX/uE2GQo5noZLuuoE/h/2?=
 =?us-ascii?Q?OJX/PR/OSQCQORhMp42WZCnlxo0j6aRb++6VFqyU+YvEoP84n0KgA3osHC4f?=
 =?us-ascii?Q?8U1ig3THov+eKnQfsuwLHe15BF9ojagfuc8SHtp3WBzY78+J1lKQWzzg6tn+?=
 =?us-ascii?Q?wbfIQCelABPxCIBMfkM4vW5mXhW4X2+4STM8mDFzuYw6otLMlNtvNMm0KQG7?=
 =?us-ascii?Q?99+dM10MEdZMuu7ZdnCzrTbkaBNLA4JmjsS1XsBdJJiDF7ITbqg63TloOGpr?=
 =?us-ascii?Q?xzHz751g+zb1pfpJtUMfgKnR/IFIndaxJ9QdFq6XfUxfonucbBPiLbc7ZEfH?=
 =?us-ascii?Q?gUuyLAkCmWduODnZ9k+CMuQ9Zk11fDQGj3AP1oqa4FtE7jK5gj/kvZRdCYmo?=
 =?us-ascii?Q?xOLWhTV8APu2T1V23WcLS+9n/0BwyQDrSl5QTC/Apgs4Qswi6K65CZ6eDiQ1?=
 =?us-ascii?Q?MaD7W8jTHh6otQdjitqWeLMPkvLuBKtBKwEQsZ4eFTQGfMTxoVZm6Ym4r2dc?=
 =?us-ascii?Q?ZqZQS7o9dF7rt4qHIjpBZtAgh7MUUTaPXXIhBVlcMoiHgdmpLtH++VJ2WZCB?=
 =?us-ascii?Q?kpgH066G+BcP1YE9gqtGrPf3fLKVON3bujJKdcXHh8pWqUOYSpVz4LTItHLr?=
 =?us-ascii?Q?TKbu1toXaJYP7gQem3ktImypcURgrJUU7GXzX1b4gCPXoDKafoVx+6Jw18Y/?=
 =?us-ascii?Q?hBf1+KbRYuPX/GWjkG3VXF7FYi+MUt7c2e5hPSBGoFcKAWb6tijxzfzDUgu9?=
 =?us-ascii?Q?Rkr8tjxQk4bn0aQ=3D?=
X-Forefront-Antispam-Report: 
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 23:15:03.5420
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cb61b74-d357-40a1-d1ab-08dd584dbb60
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AMS0EPF000001AF.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR02MB9063
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 28 Feb 2025 23:15:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17364

This reverts the recent change of decodeurl() to use the URI class to
parse the URL instead of doing it itself. While reusing code is
generally a good idea, using urllib.parse.urlparse() (which the URI
class does) to parse the regular expression "URLs" that are used in
PREMIRRORS and MIRRORS does not work. A regular expression URL
containing https?://... would be silently ignored, while a URL using a
negative lookahead such as git://(?!internal\.git\.server).*/.* would
result in a cryptic error:

  Exception: re.error: missing ), unterminated subpattern at position 0

The problem is that urllib.parse.urlparse() treats the ? as the start of
URL parameters and thus stops parsing whatever part of the URL it was
parsing.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 bitbake/lib/bb/fetch2/__init__.py | 46 +++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__in=
it__.py
index 93fe012ec3..464b9ee4c3 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -353,9 +353,49 @@ def decodeurl(url):
     user, password, parameters).
     """
=20
-    uri =3D URI(url)
-    path =3D uri.path if uri.path else "/"
-    return uri.scheme, uri.hostport, path, uri.username, uri.password, uri=
.params
+    m =3D re.compile('(?P<type>[^:]*)://((?P<user>[^/;]+)@)?(?P<location>[=
^;]+)(;(?P<parm>.*))?').match(url)
+    if not m:
+        raise MalformedUrl(url)
+
+    type =3D m.group('type')
+    location =3D m.group('location')
+    if not location:
+        raise MalformedUrl(url)
+    user =3D m.group('user')
+    parm =3D m.group('parm')
+
+    locidx =3D location.find('/')
+    if locidx !=3D -1 and type.lower() !=3D 'file':
+        host =3D location[:locidx]
+        path =3D location[locidx:]
+    elif type.lower() =3D=3D 'file':
+        host =3D ""
+        path =3D location
+        if user:
+            path =3D user + '@' + path
+            user =3D ""
+    else:
+        host =3D location
+        path =3D "/"
+    if user:
+        m =3D re.compile('(?P<user>[^:]+)(:?(?P<pswd>.*))').match(user)
+        if m:
+            user =3D m.group('user')
+            pswd =3D m.group('pswd')
+    else:
+        user =3D ''
+        pswd =3D ''
+
+    p =3D collections.OrderedDict()
+    if parm:
+        for s in parm.split(';'):
+            if s:
+                if not '=3D' in s:
+                    raise MalformedUrl(url, "The URL: '%s' is invalid: par=
ameter %s does not specify a value (missing '=3D')" % (url, s))
+                s1, s2 =3D s.split('=3D', 1)
+                p[s1] =3D s2
+
+    return type, host, urllib.parse.unquote(path), user, pswd, p
=20
 def encodeurl(decoded):
     """Encodes a URL from tokens (scheme, network location, path,

