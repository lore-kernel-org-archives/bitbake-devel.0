Return-Path: <jan.brzezanski@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8502EC433EF
	for <webhook@archiver.kernel.org>; Tue, 31 May 2022 09:46:26 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.104])
 by mx.groups.io with SMTP id smtpd.web09.47379.1653990383186136940
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 31 May 2022 02:46:24 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@nokia.onmicrosoft.com
 header.s=selector1-nokia-onmicrosoft-com header.b=GuibG1FW;
 spf=pass (domain: nokia.com, ip: 40.107.8.104,
 mailfrom: jan.brzezanski@nokia.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=do3awhO66Hlu9r0Zr1xoF/pNlMBCYfMI97whsfxga2+wYAmbPW5tL3tMC1QI2h3UnfWj9OxTcYvVmXd4/pAaCQWZFVPh4LHrUcOROez1s0+yb7doE56C9xuimkQSkrHkqc9mThZ+yDWJHTcFDEJVUP3bf2kOWXpUgvvD1POOVqbTB4MoenGyoYwyBIbzWFY/RZ3wxC1aOWEI0WMbGJNaS7ub+z9Payw28M+EXghUrBgLgUE8vMrW3KIoHTVNVmjDC8BvrQq3PofjGs5s3uNlsslFBd4IiaC6MRHukPOi40RZ/uZvCgKEifStpTIIfd6xXvYDT55SqyUeAhAY57gakA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1qZbISLgd/Lg58UQD/hZ/XqFxmkB3zSC5i675JFoqmA=;
 b=TFmA74CDKDlgIIplgjswWb4Fo6ADvK4uPX4DJkvxC7aFW6byCAguh9foBMYHvXblSdYBtxDAByUhhWOHRR6D58qqr/T3GthsLV9KzDlNYn6Xt5isuc4/peA5b4CHx4sELbvrwMgNx+DOYZn587/u0sZbR7xiJkB5Rfk9Wee9APR8OtzkMEUgL2jbQ6x9J1p+LfLhLhXu/ei/aOUH3ghY5VP0kAEJ9QLFpb5awQzMmThTQeikQb3VNxgBzqW7U6zf4/L0vpwsz/U0TwHCziwedv7Q4C+UdruFDO/17gOYaUD26grm8Hhdd2hDV+2v2IhCLT/GtQ0i1y/YUkrTUiYCnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=nokia.com; dmarc=fail (p=none sp=quarantine pct=100)
 action=none header.from=gmail.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1qZbISLgd/Lg58UQD/hZ/XqFxmkB3zSC5i675JFoqmA=;
 b=GuibG1FWqlNsW23A+J9ADcxjT/2jh2ikIo+s172I1lDAuHaQZ8RN0SNIYsb0Q+GHzAOv6tTSO7qj5znfPJMP/JK3zDXkcCRUFilClh+Nn3h6rPQwdXFJyL64SqnT93YxsF2Ms+e1m75jL6WuYGCHK85rLmelgCFD0JMBvjVa+eo=
Received: from AM6P192CA0012.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:83::25)
 by AM6PR07MB4741.eurprd07.prod.outlook.com (2603:10a6:20b:26::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Tue, 31 May
 2022 09:46:19 +0000
Received: from VE1EUR03FT051.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:83:cafe::6b) by AM6P192CA0012.outlook.office365.com
 (2603:10a6:209:83::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Tue, 31 May 2022 09:46:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.6.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.6.100; helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 VE1EUR03FT051.mail.protection.outlook.com (10.152.19.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.13 via Frontend Transport; Tue, 31 May 2022 09:46:19 +0000
Received: from ulling10.emea.nsn-net.net (ulling10.emea.nsn-net.net
 [10.159.35.81])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 24V9kHqT008571;
	Tue, 31 May 2022 09:46:17 GMT
Received: by ulling10.emea.nsn-net.net (Postfix, from userid 62230471)
	id 0F96720778; Tue, 31 May 2022 11:46:17 +0200 (CEST)
From: Jan Brzezanski <jan.brzezanski@gmail.com>
To: bitbake-devel@lists.openembedded.org
CC: Jan Brzezanski <jan.brzezanski@gmail.com>,
        Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>
Subject: [PATCH] fetch2/git: Ensure gitsrcname is not too long
Date: Tue, 31 May 2022 11:45:35 +0200
Message-ID: <20220531094535.9841-1-jan.brzezanski@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 563bd9d2-5ff7-4ad2-9d64-08da42ea69d0
X-MS-TrafficTypeDiagnostic: AM6PR07MB4741:EE_
X-Microsoft-Antispam-PRVS: 
	<AM6PR07MB4741EEFFC3D2BE3F71384E2897DC9@AM6PR07MB4741.eurprd07.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	LbR2oVariJdQhlqTbTW9s31E8CT8YxpcHPPpMI1pm4BemaosDBgtcjb0tjOV+gxqhOkSHiw0MW1VDOQQ/6b/NOfFQ0C8rBlhOaeJEgiyVh3xAupXPY9OkBPWzMLYG2qSR1h0v+pRmrYNAbTlTnuK5Mkj0Gpy77+0QjfJECHR2jCvtD5DFJAqtDfj+AJ/WBNOU0h1PiJj+TyeCTNR4VqENkx+GplluoCv4XVA6k1/LSapzWuXhHqM0IhAsA+YyboXhavUs/voRsN/oSG6RCZKMjNXishrCX+TT+FOPYf0UVzB8AQdjdoHsNJZ2ed6haKZT5ZX4fkkzwJ9bZMYl/BA8ZspQ3l2vY8G7Jdi2vhDuXRlTwU/hyLXxZkTv/JbC+xHFrAxIIURslFPwm9rkaZh+pJpl1fBSx2JFzh7iUexBJK/ryF5tLjBiSmKmJog0xVOhY4LdJB1C6eix06AjqRVXE9HU76qzbw8d10VqUpvief8h+TNf5ZhtYtzs5tgoRYDHvWYi4OJMCSvt+8IyBTQ4/bVBw/2aYRdYksyV6uE29NhicTQGZF4DPEY2ALHYyA0gh57OgJdGd3heKRQ3Q33IYVOQnqaE7+lS9BlIzJlrQM/lrG43TLwp/EFBePefuIBFl5+BIW+D3pYUmipvL3FIlsZyGiZxCP+A8wN688wKmAZLQCEiL9SlvISz6oXf3zQoKfhuWpRS7RXQFLsDWCrZU69L2guPmctcmhaYrjkBTi9XR5K5X6Bpd778siAzMmeAzhjjx6PqCdEcUjmQWOrH1qvclE00x9g8BrqtnZhFc9XSbZLVPtNC4L2M6Nu2Y6F
X-Forefront-Antispam-Report: 
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(8936002)(70206006)(70586007)(6666004)(83170400001)(508600001)(356005)(81166007)(8676002)(4326008)(36860700001)(26005)(40460700003)(54906003)(42186006)(82202003)(44832011)(1076003)(82310400005)(76482006)(4744005)(316002)(2616005)(83380400001)(36756003)(6916009)(336012)(73392003)(186003)(42882007)(6266002)(82960400001)(47076005)(55446002)(2906002)(5660300002)(45356006)(35450700002)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 09:46:19.0625
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 563bd9d2-5ff7-4ad2-9d64-08da42ea69d0
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR03FT051.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR07MB4741
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 31 May 2022 09:46:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13723

If SRC_URI is pointing to local repository, it can happen that
the path will be over 255 characters. When transformed into filename,
bitbake will fail/hang on e.g. trying to create lockfile based on this
name.

Thus we make sure to truncate this string to last 230 characters
(arbitrary number) when it exceeds this limit.

Signed-off-by: Jan Brzezanski <jan.brzezanski@gmail.com>
Signed-off-by: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>
---
 lib/bb/fetch2/git.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 23f8c0da..77bd9be3 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -259,6 +259,8 @@ class Git(FetchMethod):
                 ud.revisions[name] =3D self.latest_revision(ud, d, name)
=20
         gitsrcname =3D '%s%s' % (ud.host.replace(':', '.'), ud.path.replac=
e('/', '.').replace('*', '.').replace(' ','_'))
+        if len(gitsrcname) > 230:
+            gitsrcname =3D gitsrcname[-230:]
         if gitsrcname.startswith('.'):
             gitsrcname =3D gitsrcname[1:]
=20
--=20
2.30.0


