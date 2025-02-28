Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85223C282C6
	for <webhook@archiver.kernel.org>; Fri, 28 Feb 2025 23:15:19 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.40])
 by mx.groups.io with SMTP id smtpd.web10.227.1740784509393488584
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 28 Feb 2025 15:15:09 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@axis.com header.s=selector1 header.b=HWYtGV+M;
 spf=pass (domain: axis.com, ip: 40.107.247.40, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KqCxTWzciMifstJ6lXxkXm6ZzIGKFEszG4ygV7n9T7Q/e7Lv70r/t/gj7F0N1odfkN4r8WPGIaGjewRBVQm76zNttKzLm7F4mogULjLu+LJJr8JL0YHgtXyDu7ANQRO03oNk3HfSt0fbC/W0NjJlk/0euIf+BGXtia85zlKnX4P8pgQTjzq51hy7pBCWOBtD29nOoLG7nJnnrg/S2U6+wi7VLZjCeKBvuZh5RxIvH+ZRciqhaKhjEvCE3FgPFnCnqG/QXQuXoGZN3rTxnmaz3vLiXF3lnatoGzWcFbyaNBI82IhN+fWV4QbSigo3+nihKHvinyuvbIGFwpV9A3pmig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eFMAosinZVmTiaQjTOqo3pQ8qUAKnmlLYxjTdFm/nFA=;
 b=T4pQWLeTphcPp2WyykJ87ck/SkU9dYvHGzY2uYtgjBQNoN6CjL8PrpgH70OKVpw9TtL1VetoLT+AjMLObal8sRN2Eo3UDYv0YI0uS9ehCHPNKB6N6ldRWkfpMuE2QDQhUyobEgKRP+7Qd990438hcvJces81/DE2oV0zUdJ7tnpvriJal+Vqd1rUu6qMFmzHDaz0G/cyg0XgYDtinSJkZOHr4puki6fTUHjN/8j73FRr6qbQUv2YHQAppd18ZIUri0hrmZDPswgqDQyEJqCvKWKNHn4qS0IrcagJd+yogZQ99iNFLEEHF1hvryftcXz5hWfZHveRb8bDLuxK+YDY2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=axis.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=axis.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eFMAosinZVmTiaQjTOqo3pQ8qUAKnmlLYxjTdFm/nFA=;
 b=HWYtGV+MSZustVoJYqOSwUVnwyPy96NwuXu6Vh6Kg7LktEgomO1+jWb7LpJZKGFjQhGYC1mRf+kfsu7xF/e4nWGJ0/sUX7csa3RettxUqdbIeJacfBz8GhclqrshzqeKZuzQAyWvPCIhwA6Eg9LvG6lixXumadtSISp/8UtuXqM=
Received: from PR1P264CA0005.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:19e::10)
 by GVXPR02MB10480.eurprd02.prod.outlook.com (2603:10a6:150:14a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.21; Fri, 28 Feb
 2025 23:15:04 +0000
Received: from AMS0EPF000001AF.eurprd05.prod.outlook.com
 (2603:10a6:102:19e:cafe::c) by PR1P264CA0005.outlook.office365.com
 (2603:10a6:102:19e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.23 via Frontend Transport; Fri,
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
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 23:15:04 +0000
Received: from SE-MAILARCH01W.axis.com (10.20.40.15) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Sat, 1 Mar
 2025 00:15:03 +0100
Received: from se-mail02w.axis.com (10.20.40.8) by SE-MAILARCH01W.axis.com
 (10.20.40.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Sat, 1 Mar
 2025 00:15:03 +0100
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Sat, 1 Mar 2025 00:15:03 +0100
Received: from saur (saur.se.axis.com [10.92.3.10])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id 5730013B
	for <bitbake-devel@lists.openembedded.org>; Sat,  1 Mar 2025 00:15:03 +0100 (CET)
Received: from saur.se.axis.com (localhost [127.0.0.1])
	by saur (8.17.1/8.15.2) with ESMTPS id 51SNF3l63905108
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Sat, 1 Mar 2025 00:15:03 +0100
Received: (from pkj@localhost)
	by saur.se.axis.com (8.17.1/8.17.1/Submit) id 51SNF3Lo3905107
	for bitbake-devel@lists.openembedded.org; Sat, 1 Mar 2025 00:15:03 +0100
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 2/2] tests/fetch: Verify regular expression "URLs" that contain a ?
Date: Sat, 1 Mar 2025 00:15:01 +0100
Message-ID: <20250228231501.3905069-2-pkj@axis.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250228231501.3905069-1-pkj@axis.com>
References: <20250228231501.3905069-1-pkj@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001AF:EE_|GVXPR02MB10480:EE_
X-MS-Office365-Filtering-Correlation-Id: bf1ab7f3-3559-4190-0731-08dd584dbbd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?+trOpFJIy7QMLCPR34J7nDk13IGM/TlOWpJnSVC+O39HsSdzs/EaWLK6lL02?=
 =?us-ascii?Q?rZiIqNSw2hwn3Odta1ZFTQybG8eAlRZbubZd3BCVennkw1k2lB5Ua9V/8uSu?=
 =?us-ascii?Q?F6o0sVg792uC8H5OymiDS3HbfxO0mXNoszsiIWJW1zyjCPVVaJW0QQOQhsG7?=
 =?us-ascii?Q?k+SuFaf+bPkIHMaw8sc3yHItjU+vAnv+vqg+xD04wXqKowbInNNyFewt/AaW?=
 =?us-ascii?Q?fZT0u5e0DBNmMQjAhYfeWExWiTkR21tiO0chHOwz/5+rz2K1J17GBcHWDY61?=
 =?us-ascii?Q?ctuzgOoHX+WTVHr7EmBq7DD1gHwm9GYzATTOYXHiw/uu14fPq1QTgZ8DcgBX?=
 =?us-ascii?Q?5w/2oQWYoOXncfScnduH2GX4rpr7a0Xr7m9aSlpHmnNV1cruNLpDQCPW3fon?=
 =?us-ascii?Q?0pOATXjpncnM8Xi7asE7FmCqWX0TfV7YPBbnpXl9bTJcsZX2sn+3x28kP2X5?=
 =?us-ascii?Q?2BSKP7D/20a6k0fyWZYBkGepgcKz1jJFJJK9onPCaJYBcJbT7OTpzN5SV26P?=
 =?us-ascii?Q?QGaKiGfI6Jv7TpDg7PXli4FZHfGBor/2hcbxvoIn47f9mAnkOV/fx/9sgW86?=
 =?us-ascii?Q?gQLzjubyzo0IY7WSQvSbVEBDd6lnpevzTPS737pNspK8f5kmrwDNo4gVn8oI?=
 =?us-ascii?Q?nYTVC8NmajOEsxiw0q+Di9Nry7tAscXeCP0v+UxVOCLBxzG3t6hBpcI9DliZ?=
 =?us-ascii?Q?7ieJLl7FXkKZjpzOdf+Tbhk0jJz9pRcnztJZcX8Pq9qDIKwa8Z/dPWFycdTI?=
 =?us-ascii?Q?/Cl2HS8JDCaKHHrsus2Ce7k+bgehAiKW7C4PSCiy7iIT5wtzySMoN/Ye1eh/?=
 =?us-ascii?Q?gnqAoXj+7M753VzQ61nISfipf4rGUgb/0CUN9M+HYFoZl+9NKxKYcFyz6XKd?=
 =?us-ascii?Q?0fpgrsMkG6i4YArJVU4bqXd0BL5LAIYMb014jmzt/bIWpLJlsv999M5DsHOW?=
 =?us-ascii?Q?kmwGxkaTPuGfrbbmYDdFBAusBNIi2ODgxSBS6foRuTr+YXiRt+x4QX2nT+sJ?=
 =?us-ascii?Q?EVZrwlXzWUtlUrcG2cBjm4e6wWHVvMDMO5d9/xyNbV+FBrZYc2rxkk2NzrcH?=
 =?us-ascii?Q?YfhpsQQHuoBbdJFqNyD2Dt5GBBOL22SbdNkfrTCxGA6aLi/uN4KKBSF+YVKL?=
 =?us-ascii?Q?pWY/Su5A2+z5rZMHQvQ760GDJLyprE3BBwJZf5xFS6MKLs33pcKrry7arsqK?=
 =?us-ascii?Q?t+n/kJvsvjQHuAFfds80oi4mxeODkF8MnqCwwRNCORj92RsLkhJZ9ALpQ22C?=
 =?us-ascii?Q?Dfo8snAyUWVOOV2qudyuN7lgcIhg1YJuhbrzRQlXtjb1p0c51qZFgwRYXYQG?=
 =?us-ascii?Q?sDiZbfnQAN7smuGTNiXMdg4P347B6QnMInoI03VHUC2Sg4T9a0Ituzb9wPOl?=
 =?us-ascii?Q?bD9qGThapbb8ViU7oIfyvhqhzimiEIapqBoPvu4hvSvmDESeZHZZuxK5J3QM?=
 =?us-ascii?Q?gBvxjaQo40I=3D?=
X-Forefront-Antispam-Report: 
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 23:15:04.3232
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf1ab7f3-3559-4190-0731-08dd584dbbd8
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AMS0EPF000001AF.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR02MB10480
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 28 Feb 2025 23:15:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17365

A regular expression "URL" as used in PREMIRRORS and MIRRORS may contain
a ? as part of the regular expression. Make sure this does not cause
problems when parsed by the fetcher.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 bitbake/lib/bb/tests/fetch.py | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
index 48b9e4af16..be09a2964c 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -525,8 +525,7 @@ class MirrorUriTest(FetcherTest):
=20
     mirrorvar =3D "http://.*/.* file:///somepath/downloads/ " \
                 "git://someserver.org/bitbake git://git.openembedded.org/b=
itbake " \
-                "https://.*/.* file:///someotherpath/downloads/ " \
-                "http://.*/.* file:///someotherpath/downloads/ " \
+                "https?://.*/.* file:///someotherpath/downloads/ " \
                 "svn://svn.server1.com/ svn://svn.server2.com/"
=20
     def test_urireplace(self):
@@ -1415,12 +1414,17 @@ class URLHandle(unittest.TestCase):
        "https://somesite.com/somerepo.git;user=3DanyUser:idtoken=3D1234" :=
 ('https', 'somesite.com', '/somerepo.git', '', '', {'user': 'anyUser:idtok=
en=3D1234'}),
        'git://s.o-me_ONE:%s@git.openembedded.org/bitbake;branch=3Dmain;pro=
tocol=3Dhttps' % password: ('git', 'git.openembedded.org', '/bitbake', 's.o=
-me_ONE', password, {'branch': 'main', 'protocol' : 'https'}),
     }
-    # we require a pathname to encodeurl but users can still pass such url=
s to=20
-    # decodeurl and we need to handle them
+    # We require a pathname to encodeurl but users can still pass URLs wit=
hout
+    # a path to decodeurl and we need to handle them. decodeurl is also us=
ed to
+    # split the regular expression "URLs" that are used in PREMIRRORS and
+    # MIRRORS.
     decodedata =3D datatable.copy()
     decodedata.update({
        "http://somesite.net;someparam=3D1": ('http', 'somesite.net', '/', =
'', '', {'someparam': '1'}),
        "npmsw://some.registry.url;package=3D@pkg;version=3Dlatest": ('npms=
w', 'some.registry.url', '/', '', '', {'package': '@pkg', 'version': 'lates=
t'}),
+       r"git://.*/.*": ("git", ".*", "/.*", "", "", {}),
+       r"https?://.*/.*": ("https?", ".*", "/.*", "", "", {}),
+       r"git://(?!internal\.git\.server).*/.*": ("git", r"(?!internal\.git=
\.server).*", "/.*", "", "", {}),
     })
=20
     def test_decodeurl(self):

