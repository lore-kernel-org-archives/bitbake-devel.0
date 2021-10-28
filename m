Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CF6C433EF
	for <webhook@archiver.kernel.org>; Thu, 28 Oct 2021 13:55:39 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.53])
 by mx.groups.io with SMTP id smtpd.web09.13683.1635429336934400435
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 28 Oct 2021 06:55:38 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify"
 header.i=@weidmueller.onmicrosoft.com
 header.s=selector1-weidmueller-onmicrosoft-com header.b=Czp2l4zP;
 spf=pass (domain: weidmueller.com, ip: 40.107.22.53,
 mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LgLGd9cIBXHmuLTpm6dokAA7EN43JhkTq26Ygt7Jz4mtmi8Hddfy4Zoav3glzlCxgcp28rFmwOUShs4qMOz7oWIf/LOnXYFAeS8bGByF293DWK7y62ZG8ODxs3xHM2VthfZ1Tz68+7N4hjpu/0d5y8lpykIu1XTygdxNXW0u5YRI8s9YpuiK+rEAYdIyllGbWY3FrsuERDC3liYQg1FUqFWNae7Li20jew4RNK8MML8Ry4aTfcGU0jEYabL8Ok5V3ikYJVWpJkYG8wW8y+CyosMoatLXGRCPtbrlcdZa4stbRsAuHjeLpW9iWNMDaMSNFKrzD/nHsvYiJpp5TN7xzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jAC9KBoqmGGRmH0oadLuikJOUorvaAGvkCaklm/AeT8=;
 b=MSv4KBlkeUuoHoQAs7vvDcpuY6796KRXSq8PMytTUhAXkonT0kNB+fP9G5fDGCF3pSGpEomhUySmzDNyLNEwUMgYrrTU01hep352oaFXJfWo2dtjLPBarJINn2k7g5bZTmglnCrmInkQ6rF10VVxKpGUt9IcBf2vFjSZscmNDTf2ZbU66+7NwkDPlwAXEpXCZisS8muUCpdvw9kEm+wlltdMa2X16WZxu8ShroseFKngOOXKO+SWvjq26W3+vn3NTB2z0tjkeE14Thvlu0dbK0K1eHWFjc1e8V1bSl7Quf/8pmVLEMlVhm/IjwJziQFbb9eRZP2isRmG5QCVSy7iBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jAC9KBoqmGGRmH0oadLuikJOUorvaAGvkCaklm/AeT8=;
 b=Czp2l4zPSHkjSfTaZvvR0shmvdRJDSh5hq4JX/vU9rlwfTmI1tWky4hT3fh239hBRtu5ai/stodCqiRcXiq9Yio/2b8dRzJ5W7Djl/58Cqk9ZvYK/K0FUtbMNoOW5mDpkkSWEOXVlGhR96UEP/kt0AEi4FYUJkZS6s/f9mLstwo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by PR3PR08MB5676.eurprd08.prod.outlook.com (2603:10a6:102:82::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.20; Thu, 28 Oct
 2021 13:55:33 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::8034:af5f:f101:d1f0]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::8034:af5f:f101:d1f0%3]) with mapi id 15.20.4628.020; Thu, 28 Oct 2021
 13:55:33 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH] fetch2: npmsw: Add support for duplicate dependencies without
 url
Date: Thu, 28 Oct 2021 15:55:07 +0200
Message-ID: 
 <20211028135507.10643-1-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM6PR05CA0002.eurprd05.prod.outlook.com
 (2603:10a6:20b:2e::15) To PAXPR08MB6969.eurprd08.prod.outlook.com
 (2603:10a6:102:1d8::23)
MIME-Version: 1.0
Received: from DE10512.weidmueller.com (89.247.126.104) by
 AM6PR05CA0002.eurprd05.prod.outlook.com (2603:10a6:20b:2e::15) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend
 Transport; Thu, 28 Oct 2021 13:55:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f65c0d0c-3159-4981-dd01-08d99a1a9c6f
X-MS-TrafficTypeDiagnostic: PR3PR08MB5676:
X-Microsoft-Antispam-PRVS: 
	<PR3PR08MB567667ED8723DFDFA87C0F5DD7869@PR3PR08MB5676.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:639;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Wcd7hWQW2DL8UYGKkwZad42wdyLUM/KQqBwlRIUXH4QJoHEQHhBarK1HzoGVW38OV7E9OeQ/zZiCwfPKRTI+xS/DHGkPBt7dV82PUmC0RBpJuwLNSgrBHrBYMN+AAzDOtgX6lrLarSbWEZnxa7fR34WkCtlISKksR8w6tEsDsYU+yN+AGqUzRq/DjJkdcz7lZDVJa9WuPIkd3DbpvpC2XBRQXJ7wd6psIyQLYJvf/rlkCBcD2lO7w5jvq4lDXZzz9CZVUm80uQNa9IH7TJ6fnTxmkZX+7f13uTSxbB/oWXlatuF+hqRK1s3YNHhITB/5iwSEp4hnSp40nfFZ9Cl9KG/maxMAi2brpt3xgdD5pwZPmPGVNQs14Pz3aOgs210LKr2P/DTFxVgsBeJMVipzegTkshIbk+TImuQOCAFVidToQ9vMgc41m8Tq9r3cLqwnKPPXMir0W+GP7ywSoYXkSrjJkTz+ZNVG4/QCV/R2jCtuSJapOUKMFb+HCJrxLt/rYRUn6UUuYJXLlCM/x/T+ALD7XKXQ+nFET16G2+owF4JtYLIBuBEx8cLNucifoewRF/eAvfpVuqJWx6dHjHUzhJ/BzoMMpxUF+OvD8b3RqMtXtsQrKVqXVJKD0FhQcaTulu9mgfGwBTT0iFlVL6LaPrrlSM6e9uKgSHiozst9lEmNwaHcIKXTeeG4ZkHXbFNSrwTwc3j9uz5gf5K9iykWkg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52116002)(8676002)(7696005)(86362001)(107886003)(66946007)(38100700002)(186003)(2616005)(26005)(8936002)(6486002)(316002)(6666004)(66476007)(38350700002)(956004)(66556008)(6916009)(2906002)(4326008)(83380400001)(508600001)(1076003)(36756003)(4744005)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?jfAsoNR67YFblH607dSCxv2CP9x8T/rn3UseRMQyGpZiEK7PUAUXToZWbeu+?=
 =?us-ascii?Q?cqw7ZnrP/h4CypUconIPEVzeVwJl9ZHE2Ha1//O/lzA0fsXV9N1vs+wldCA9?=
 =?us-ascii?Q?AtVoWUTJmO6AZYYQb1BlfjnDLUw+YrUB/NyvtkLHH4BH97ck2PbZInE/ozOY?=
 =?us-ascii?Q?k+HKdvC0nkcYhI/c/qUibLXfHfOsNeWKhEIIAQE8sZvqHf6iFmh/7KKyxRPH?=
 =?us-ascii?Q?Euqwz3S9wOd0/pYkngpfqR4n2NCx7ksrRv0Y7JuqTqqA051NzGQSw+v3K2Qx?=
 =?us-ascii?Q?c3sdU8luZwHxYFMQnEoascGOF6q5PgFCmCbyrmVE00j1skQ1LeP6o4yCErXL?=
 =?us-ascii?Q?ZpXYz2Ap2RpVVaVXGW5Xzqp3zV5hY8mAaVdnj2ghGwESIdq4krtlRP2+ROOs?=
 =?us-ascii?Q?KQcMqQdSts05uZEjyHaHzvX9tNURj3KxwFrKADimQFUuO3PlE+nKb+G7EU00?=
 =?us-ascii?Q?5Nc1+OgEq6Izg4QWmITHL6k1x6oFICFBp7elOC7hcYhUGUFP4Ixzr02NPD7O?=
 =?us-ascii?Q?1mXWmIB5gF4ZZ5n+ffMlDHUhWWzk+bOkt1G5chSFA/P0gz/7c2S2Swvg9f/l?=
 =?us-ascii?Q?pqgHqqRIhrgxpD+PHZiKqGCHr10Xf1/STPUhY9ZyaNZcTDnYWiRnQ+2uZqKI?=
 =?us-ascii?Q?2eQK9CghhgXdrFjszelgRBWPnyj/fMW5aQivAtzoPghE/3t3ZFe9DTqSPWI0?=
 =?us-ascii?Q?6qxm/kh0je9ty6EwFxKco67wCqarLDzQetADcStSvas/ofv0jxZNwabDQYfs?=
 =?us-ascii?Q?bbPjFCyyLzYFm+//c0DMlz2hnuCY4E2Vs6UxIbTN0ot6679n4K0f1krf2QLP?=
 =?us-ascii?Q?oyqoWKteHkbrDE2/STpHnfTVk/mUsTZRGTbKceWIdQogcaYXbJUp96zux9EE?=
 =?us-ascii?Q?aaAKbZ7mqDXpmtXa25xiKyv035WT+pwr+R8geqyJhmES4xHv1F1lQJD3qSrx?=
 =?us-ascii?Q?Cm3V52jyDnxZRLESItWBZRJdehnkBpBihZVYyMACVMCQP1vGsaH2NKYz1472?=
 =?us-ascii?Q?N6sq1z4CZlC4pS/GLmo80dr+tU6Ykr/qkStlKdl2X5HYTXFrEruwyQdC/8d1?=
 =?us-ascii?Q?bY2BbdNxU/11J4WLt3lD9zCuLS/wVGdo/SLJJxziMBp858xriyVWFiFR5YBs?=
 =?us-ascii?Q?bvTbPwcwCU9jKs87dFLqpuv0ca1vdEzyKKceJJ7f52FlkwagclHqPAlEkBdd?=
 =?us-ascii?Q?n6kgl8LcLgtqXjOm7QqrF6PGrqxPNBZkW6T9dBDEJof9r0hF2rA0EHzK6neh?=
 =?us-ascii?Q?k+EGx/96JgMSr4hypJGvMd7+/444cMZLVkBTsu815mHsGVdzhIUL+JTzWV6m?=
 =?us-ascii?Q?+qjNQLkwtzJ6JZZyjx17PLkbs/DuiNliPKp39/YF1r9g7ti6naexLd+AbJGc?=
 =?us-ascii?Q?WTH+DI65cWL2nF6Mo9iLkzhfiR4FhE8AwRCSBPMo7Imw+vQz1uV7tpl8tcOm?=
 =?us-ascii?Q?nnCffn8JJguw/0A+CWYm5rT+WGhqyJaeXUXv/1Ua29IUrpzV2conxNCWyndo?=
 =?us-ascii?Q?I5xhHUr5KctU2ZgqquF7tATeqJv+KvbmKqIl3pGwKe+++D5mTXN1CMS8SuUa?=
 =?us-ascii?Q?ZinCKPezm6yKMDUx1USXa2ZbTLVH4RVMaSan+nYMDyEXOd5Ybn1+8LeMdcaV?=
 =?us-ascii?Q?TiEdMFrmXV3R3p2ZdKG2oKs=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 f65c0d0c-3159-4981-dd01-08d99a1a9c6f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 13:55:33.6479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 uLe2zMI3s8/RDMhlSf1PyF6tNXkZqxZ8aXxRQ4xnSouls2C3u6UtzF1KhyQq/vlzpLRrd4xOXaspSH9XGAhZ+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5676
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 28 Oct 2021 13:55:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12845

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>

---

 lib/bb/fetch2/npmsw.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/npmsw.py b/lib/bb/fetch2/npmsw.py
index 06e66bd5..879ba5de 100644
--- a/lib/bb/fetch2/npmsw.py
+++ b/lib/bb/fetch2/npmsw.py
@@ -88,7 +88,11 @@ class NpmShrinkWrap(FetchMethod):
             version =3D params.get("version", None)
=20
             # Handle registry sources
-            if is_semver(version) and resolved and integrity:
+            if is_semver(version) and integrity:
+                # Handle duplicate dependencies without url
+                if not resolved:
+                    return
+
                 localfile =3D npm_localfile(name, version)
=20
                 uri =3D URI(resolved)
--=20
2.20.1


