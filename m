Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5F0C433F5
	for <webhook@archiver.kernel.org>; Tue, 14 Dec 2021 08:07:57 +0000 (UTC)
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (EUR03-AM5-obe.outbound.protection.outlook.com [40.107.3.69])
 by mx.groups.io with SMTP id smtpd.web11.23091.1639469274157243362
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 14 Dec 2021 00:07:56 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify"
 header.i=@weidmueller.onmicrosoft.com
 header.s=selector1-weidmueller-onmicrosoft-com header.b=DJ8IZQPD;
 spf=pass (domain: weidmueller.com, ip: 40.107.3.69,
 mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EDU4a2dNuUzrVwIS37rE1Gx7FNwbsDIOcQXGZLZ+A++4+VRN6hV2148jWt20y3WRVUKhKv+tcMTAFDPqBjM4O83PQ8HNND9AmoBDh2K5mnZy9l2xB8EquDI6DJCyBRK2TQ8y/jfwp24nXoO33oCM8+rO1w26UtadRdT8Eoa2jAtqSCDIzBCxAhivNcYljT+L3bzGYc/toOUZ2bfMX1TRVE6ZrYD17rESvyGFcMv2PgrDwlOIQd3d1ySwjbrLg5D9P+mRqN4YaT3N+cENmjYU/JAB58CzMPKzP12VdWTkbUF1kfZxuXBiTwMNgPKVmzyhZIzW5dQu1NLtTgrzHRPtew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QEB9iVMJKBAXlBmMf5Hk6FprT5jzA8Vjg1hkWMD1gf4=;
 b=bkFHM/GiPD+YiHEd3UpK0IW0wlJNN4YU90xRukBlOXjzYAKK8ifRy+MdLMOeBdrnmOImzqojvn+trh3h9WfVrMPOovS8x5Bd34J8BMDyGOW6h1xb/v0bRmEzn12bwZ1orB3w2b0cOXgqH18bgujnU6VXzwCt1BubYnkOkyPOvLIzRKhoCxD0OsJzGmdcTZWtbTtfIAr3oN3iEkr37Qp9BuoeIkJFhhmNOuvazCdDiWM1W3XUXQFa/3xRzmIKkRZfkK8HibliZ32ZmdAVVoco3Np8Ip+uHPfNFezkh8b4+CbqWD+f42Sh7UVXhilq0ZMUqVwi9xt8GzavlV0v7XdwjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QEB9iVMJKBAXlBmMf5Hk6FprT5jzA8Vjg1hkWMD1gf4=;
 b=DJ8IZQPDNWu2H7CPbngbW/LxIyx1gGA1jBr2vVN1ZMhYs6/BjosHeXaHUCYTsRhoZi58VIlVilbx/+uWablUPhPkfrd2pBgYsyxvdP7gfRd1Y5JQ8UQfvlWV2hEgiDe4Vmu9aCBtY5EI28iYtZCHrISkXYWGFCldb7Ye0vRTTns=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by PR3PR08MB5577.eurprd08.prod.outlook.com (2603:10a6:102:81::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.18; Tue, 14 Dec
 2021 08:07:51 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::f:41c4:eb10:5010]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::f:41c4:eb10:5010%8]) with mapi id 15.20.4734.032; Tue, 14 Dec 2021
 08:07:51 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH v2 1/2] fetch: npm: Quote destdir in run chmod command
Date: Tue, 14 Dec 2021 09:07:25 +0100
Message-ID: <20211214080726.958-1-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM6P195CA0010.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:81::23) To PAXPR08MB6969.eurprd08.prod.outlook.com
 (2603:10a6:102:1d8::23)
MIME-Version: 1.0
Received: from DE10512.weidmueller.com (94.134.94.40) by
 AM6P195CA0010.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:81::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=) via Frontend Transport;
 Tue, 14 Dec 2021 08:07:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f6968f4-568c-4484-8ebd-08d9bed8d300
X-MS-TrafficTypeDiagnostic: PR3PR08MB5577:EE_
X-Microsoft-Antispam-PRVS: 
	<PR3PR08MB55775FB3704F8367DB6775CED7759@PR3PR08MB5577.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:239;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	b/SGiNEvkuHFwGq5NHwmmPwfasUS4gmbuY4nBAyAub9emHx60gnKh1uMHxf1z33LQVgLbJFTNr+6Hgye3C9HshS6qDXnyCZ0ouegcgbCJAHJ9EKjGw/F1I8JaV0V4Sev/mHi82hH3bfN6IujWNtqqIFDVIfjZRxeU7nQINjKPlIttYmvHnfTNkZVHfA2Yi1VIMa2ZSYlmz3HbmMAIGUaShS1ss0xO/EBApknvlotgdSRQg+JZGyrZ+SpYSae/2eqXNDEAjNcfZIy6jasTs7RSntm7nW5qP12xbIpZFlu/H9rYwuj3vQ/STWZgOf/mq28n0GPFUIWeKtRik+L7/Y/7vMpy0A1n4afgex4YO3dcxiFz1ANy2xA3IeuaD0Ao9BI03qNt5cYyP6Iy+UTzo51BzljLTnhCQUJax7J6hwK7drzxk6KCjbye8QcgcqeBWQa7yJMp4b9zE0lRysleH1nVTVWm0P21PWC2A/BxpZu4JxteZCSzQG36ACxvwlYqQsadOicCG0XN0uKps3PLWdwCGWh1/u2nm1+9+EdL1qHQu4ARHwlsRfKdjI6UG9XnQ1Q08H4vmZz/E48Uz2qa31bmPIx4ah2mH/ukL928iLf1ozNJnj/9V/3SASsjU1ph76CptlyQc31Aqc3oNyjzZd+9xympX01u+WEgtpxTF91PZBz9MeonAcHstLZvwjXZT6r
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(7696005)(52116002)(26005)(107886003)(6916009)(956004)(2616005)(508600001)(4326008)(186003)(83380400001)(86362001)(1076003)(2906002)(8676002)(8936002)(6666004)(38100700002)(38350700002)(5660300002)(316002)(66946007)(6486002)(66476007)(66556008)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ckbg9sCSS+oJO3sA93biq5/0ozpIsvfYWnXJslMl3q2slRKBqujdP3N3ju6z?=
 =?us-ascii?Q?GJMYG69PopMMxWBf/U0eezClMjczLzfzYc17FerjnAk06rFIWU3HneREVfX/?=
 =?us-ascii?Q?YJtjAjGVUVu5Mz+3M5LZ6FM4YuelfJ2L0mJp1MpcVkuqLyLc8tnYfGVcStIO?=
 =?us-ascii?Q?ujyD4KUqlZ5q0vaWm0bbZjHrnrHj6je8jGmuPtiTRUqHnF/GqYG7d8fss9Rn?=
 =?us-ascii?Q?St0/H0JCXurSaWwmN7dUsincvLA1LOa02kkFcK0jnSKNSBlgr4ex+UIoCd/W?=
 =?us-ascii?Q?dD/3PE7Lrsfl7BBES+ORi0sgmvkMl18hpwOVVIybLdlkLMdlWbbB8SJuHiJy?=
 =?us-ascii?Q?7kC2rxefx/lUil/0NSImiG36ayH1tqd3Gcnll3xDK2t6k5dPsUSLX33Xo08W?=
 =?us-ascii?Q?HILAdQD+XG084rDrmbNGOaox1jRp3ckYWy/wrODeMV6IndbsCzHixa2rhEsY?=
 =?us-ascii?Q?Q4Ki6sDAB9WIIGpsr6GM8Hkp2WHzy2z1gsp1ttWVzc2kpLy/B7u3hvqoIuzK?=
 =?us-ascii?Q?Vfvzb85xvCbHc0ngggTK390CCU94Ng0z6wDTfCNJ1Hd18YhIJsfZ7W7a7Sqt?=
 =?us-ascii?Q?+5Slovftd3SVqhc3HxUMQJGIvzZfTRKeAGnkk/PclgXFHLSYchLIw/YmVYqJ?=
 =?us-ascii?Q?QHn8yPBqbdYIzABPK1w4bIIsfUQoGa/omoJgK5VPRr/umm94jXI7Hrtm1Dg9?=
 =?us-ascii?Q?KFiIxOc2ENCVxRWhQrx8MF+ImkMgqm90jptBKjzEWcp2IeWFOfsUxZUgL2et?=
 =?us-ascii?Q?fFGFZhP67XE3jf0/5cMDOyY9TKurxy7vTGXotwWx3GeNH9jCTpqIvuWK+C52?=
 =?us-ascii?Q?1sMU43aANVKdGR/cY+U3nzcfh/W3YvhUNklp68uuRm6RBm3pAS4VhNkrI6xK?=
 =?us-ascii?Q?5P14LT34zHaoE83Rcsw3ImFnazIFDKwXRsA5YS0jhU+GyNOVSgk5meP7NuAJ?=
 =?us-ascii?Q?/0mcrHAVhKbmIpVGUqu3N1fypu14bDjZrlsMR41DSxnwjLZavB+G0uNfGw/J?=
 =?us-ascii?Q?FJs6w6hRrX6c4HSfkL+C+PCs5hUf8fUKb56A8XqfgONdLFoicYJFy33jRaOt?=
 =?us-ascii?Q?NWlEKyQU6fEg8+o5/LrGadLcLc455x1THrBQFwmvfaLzLvtWBJxFxzj8ZZBW?=
 =?us-ascii?Q?Fv+BTTp8D9O2IErJwH1zJLousuuu7Fowe0RzvrQqtQeJnWyaFd1fWuBFmDkP?=
 =?us-ascii?Q?W4OOVNwUnItWvd3MjautZkEm64R8I2ROApuFUTYK9VIyrlEiUxoOVpkFTxqM?=
 =?us-ascii?Q?sluUUKGpPm8oweT8+ksKdBwZtznJDVFwGLl08Z981vL+lZ1yJbp9gopUfE6/?=
 =?us-ascii?Q?wA0cdWWCnEBlY7fXPhYgL6CWDDbe8+BLgkFERlCs7kVOwJK/2u5NxhHQhqHx?=
 =?us-ascii?Q?SPP+frRIeFNibIl+LVqWfVzOJFucqIfwlsntee67zpkG2bygiqyVakwktAFj?=
 =?us-ascii?Q?oX1JsQlXifyKdYZBj+XIxGnq4sLsSfxqgfxaIH5IL3Yndcun2a0jgGbCq0PM?=
 =?us-ascii?Q?zzSX7+88ugE/b6CG8NhZ5Pvp4TIUd6xw3uWdY7+/kbpraB8DkVZIU1h93oGU?=
 =?us-ascii?Q?L5F2sHS+I2yzWshZ3kkrd53W/0tIXTqGR0fcfU1F5ZoMX8at36SSMIq7Arpi?=
 =?us-ascii?Q?ympoHLm/M86vgGi1lsphSDY=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 9f6968f4-568c-4484-8ebd-08d9bed8d300
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 08:07:51.3770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 4izcaYUmusAXW30bWqdN1vIBrrcYLrfcTrWfMW3hMBx1jg821VtUStOduZUo4/oqkb72kc+dTKrauHgu3GTETQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5577
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 14 Dec 2021 08:07:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13155

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Quote destdir in run chmod command to support special characters in
package name and to avoid syntax error for packages like
'@(._.)/execute'.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

(no changes since v1)

 lib/bb/fetch2/npm.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index e497c38d..d9daec20 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -72,7 +72,7 @@ def npm_unpack(tarball, destdir, d):
     cmd +=3D " --delay-directory-restore"
     cmd +=3D " --strip-components=3D1"
     runfetchcmd(cmd, d, workdir=3Ddestdir)
-    runfetchcmd("chmod -R +X %s" % (destdir), d, quiet=3DTrue, workdir=3Dd=
estdir)
+    runfetchcmd("chmod -R +X '%s'" % (destdir), d, quiet=3DTrue, workdir=
=3Ddestdir)
=20
 class NpmEnvironment(object):
     """
--=20
2.30.2


