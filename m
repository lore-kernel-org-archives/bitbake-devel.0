Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1EBDC433EF
	for <webhook@archiver.kernel.org>; Wed,  6 Oct 2021 14:36:17 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.65])
 by mx.groups.io with SMTP id smtpd.web12.12839.1633530974766513842
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 06 Oct 2021 07:36:16 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify"
 header.i=@weidmueller.onmicrosoft.com
 header.s=selector1-weidmueller-onmicrosoft-com header.b=OCSEMVU/;
 spf=pass (domain: weidmueller.com, ip: 40.107.6.65,
 mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lvf+mneJe7BCHwxoTBhIVPJNE2KeQD168VcnKIBstG1jlRc1E/xmHGXupC5IGF1lmIL6/tiGR+hOolTfAQC7CShfewQkii3CuxSYeFEOKwLRyFaj017yrSJwOC/17smrGTm8RckQsDIx7WqwsT0XurCEf8EF89jpzre+kcLyPeoc8XEbTDj95PttZpy/D1xcLDyPYyJUaJk+/PrUmJzOOWm0x+b04AD8ThQLg0map5anvPRljtD6AhjQkMclvhR83bUd0fzZYP/ibjFUcr97Zu9pMVYiaYSt3OJwU6Q8b3G6k1xwlqOpXNiNTrVmu+8FVDCtkL7qq+FyyX1Gf0um9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qp7nQDCmrQVxxE/9gU1pTAth1G1HFdPKRbmCEPY41UM=;
 b=VvDG64jsygVlHXb7A2O6JR/xqK5bck643E3HyoIUXjIsWYSVoPlM5vWVWXTIWy6E8///ORJm5QapPwcPbp+w/ydPAzSQEusmCk+pXBx2BEUA4qCgNz9Kt7mWVxPPuZcNf7LOOSGtFuUqVtECgt3mVQsKoBOvFMgrEK3mNY/HvvGO+gq11oUxHcHK/j05dERYopTlxOOFy8pu34jFFSyc0D+xWhS3kPrHTjRWPVsP0oBqHZSoKCRBMuhq91mfxNxKP2sUz4WX5TafrusCphIgjgWbf6kNUwvGFJx8hehDcKDIh58y/A5fPNk8PosBRBKb2v9JI8PiMULMvq7FIjD6yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qp7nQDCmrQVxxE/9gU1pTAth1G1HFdPKRbmCEPY41UM=;
 b=OCSEMVU/KXK0veHWm4fdM7uVx7Bpdn2IzZbUisskIDGs8+uGsDqUGCtUXikO4rpIVUKJmHKsrVswOj8qykng7fmZMs2Zd3nlMJ8iXLPzFuUqhh14h10DRQ3vjuXKfdbGPxomBFcGiquIKZKWRsIIPmSD31AWYKUAXYKjim0IrcU=
Authentication-Results: lists.openembedded.org; dkim=none (message not signed)
 header.d=none;lists.openembedded.org; dmarc=none action=none
 header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by PA4PR08MB6206.eurprd08.prod.outlook.com (2603:10a6:102:ea::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Wed, 6 Oct
 2021 14:36:12 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::8034:af5f:f101:d1f0]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::8034:af5f:f101:d1f0%4]) with mapi id 15.20.4566.022; Wed, 6 Oct 2021
 14:36:12 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH 1/3] fetch2: npm: Support npm archives with missing search
 directory mode
Date: Wed,  6 Oct 2021 16:35:52 +0200
Message-ID: <20211006143554.3734-1-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM5PR0601CA0073.eurprd06.prod.outlook.com
 (2603:10a6:206::38) To PAXPR08MB6969.eurprd08.prod.outlook.com
 (2603:10a6:102:1d8::23)
MIME-Version: 1.0
Received: from DE10512.weidmueller.com (87.129.248.106) by
 AM5PR0601CA0073.eurprd06.prod.outlook.com (2603:10a6:206::38) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend
 Transport; Wed, 6 Oct 2021 14:36:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 951d2e6a-4feb-43b2-1482-08d988d6a4bb
X-MS-TrafficTypeDiagnostic: PA4PR08MB6206:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<PA4PR08MB6206063C3DDC17401D6A0C3FD7B09@PA4PR08MB6206.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:167;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	OVmKPxWN/KmJOnt+TdAi61doyN7/KuhI15StrjjTS8f61UXRLut3nS6zZNe8HvFY3kaID9d7NvLWDZagkCmXpp1HSY3v2nlyFYSGc0uaaMBgQaJdTXYHDJuL9V92TRv8FlpaK9FP0E8tOnrVP3ngfdjfqHCxc3OGs86o3CXQWA+vR2r9Vxhaej/95BFeZGfBHCeQ8lQAx74F+X9ZPsGdgtEwh/H1E9sS5EELdfKqFznee2f155b+rF4xUqIBTHOOYLgL5CT/mKtwidNx62OeKj/5WTCQ2Nxaq9vmYzw/iITErY/iQ1yrMP5tnbKG6BkXu6LgrO22Ob8AaRfdCqZLebR1LN5OSnFmgbnVQrDw0U6LUP4OVT+QZPcOkqH+vZ4OYITOFdbCb1mHcjHI+h5qtLh+MJgOsQoGcreA+W8SFJiLYHJyl2jbU8okAzM9Ykz3m3mmjE2GRm0U/tnNrC++KDyeaBzISXzO/N63ggX43RedlG+dSOi7v/CGoVIQ6i+m2jDCrkM7dcihYSxSUaQdMIf0wIURkXZ7mpKXBOWA5k75YxtK/tfqmBqU8ijcakZCdrHj9mq0Vp49DEgL7Wkgkx7MgngRFXRxdS7WLCZwcxs9V5MPiPfN77ngFmoExw9mIC6kZRuGuaF4enIoWL0PCOQTfoPenb0+1Tp9KI8WxBBemyrPXu9fJL+DKLkCvX5TIOj8DHJW2Sq8rjtWOle3GA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7696005)(2906002)(83380400001)(5660300002)(6666004)(6486002)(316002)(107886003)(52116002)(956004)(2616005)(38100700002)(38350700002)(186003)(1076003)(6916009)(4326008)(36756003)(508600001)(86362001)(66946007)(66476007)(66556008)(8676002)(26005)(4744005)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Pw1ER/xg7SAVRQnGHNQ//Mm4+P1puJ4E0OI79FwL2lgbF/3FqQexqqih9LRn?=
 =?us-ascii?Q?rKLeCMBCjuJruxe6gIxyG6ioAF8BGTHCcT/bBYlU96YcGp3QeZynyCuVcZ0G?=
 =?us-ascii?Q?XeMcWaanZP6DH+A7lyho0kKnHdS22cQbxZiJua2sqDOAq8+rzooMQZiDg7+S?=
 =?us-ascii?Q?XLjD+JoJps4ggzIudZRC9HETj/s/ZTbKAXQTCx7c0fM6djp8gSiUc/jnw2sr?=
 =?us-ascii?Q?4ieY8MSiZFo9G2E2lzjdqQ6vgJbLS2zJTpB0rvNWqoYduMiCF+eoSFrV4mI3?=
 =?us-ascii?Q?Zh8842oNVJ3Ip0kCTjA1nWd7s47MT5yR9EYJtZ0Lq0UNcj1YVtgf/AWqNUVj?=
 =?us-ascii?Q?gTQcZmJkieKBJzxFKPepDBwSQi11NGnfbQsOx0KIlCTi4OX9G7Yf7Ees9XK4?=
 =?us-ascii?Q?jrqH8bGL+l2gLoJF58HEXWPivvs6CMcWdyPsDQYAofObJbATL6Zr7mwY9E09?=
 =?us-ascii?Q?j1z2PHk9X+FRoAE31RB3Ep8oF6wgLQO95Vl5YE1f38vcfhkOfMKlBpS9VhaO?=
 =?us-ascii?Q?79n6nzK47dNli2NNLiESB8dI4LHV9V5HXiR4+mdN3No6atH47ZSRcohwGJgw?=
 =?us-ascii?Q?ZR3OVdwaw+rJ0SvZsekdq4qSC4XONxUnonhVAIiWHdfEb93/fREUyQET8aQS?=
 =?us-ascii?Q?vJOPiIkMgiTpRXpwJt7AbsxkZt4T666SE4bztIWqbEA+Vfr85G7g2RjOJ69K?=
 =?us-ascii?Q?PtHEnArs9jsnEVqvLKfXmHz+3RugkqtkTBqQTEd+6wNBTLBsBPSSz2TOfpVt?=
 =?us-ascii?Q?AecAxCeveC5SkNhxUtZ16VWaOgPIlQ2XNO1Ys7nu2t1QxwigP/VWLx94jDKP?=
 =?us-ascii?Q?3WWjDSbym7LrPsZe68ctwEm8y4EzcmH7HWGcC70urrTL6GBLfyeeyEvATXun?=
 =?us-ascii?Q?XCf6CPIrJlaaeQOy1ws1UKHb5YfXX+Ya+fN7D9wh90ch8pCo7sVXLyB+lIMa?=
 =?us-ascii?Q?n32wY5/qw4oTxwDbzObI1PAuGYE7gTEGnvIcj/4Oox9UQygBWfeGs8q0MZ3J?=
 =?us-ascii?Q?4QMS5x7RQ+ESmY7mqJfpajag0V0nqcreA+kJAqXC68sr4mF6H/Os+4ToMQlq?=
 =?us-ascii?Q?nWHLnVoMP6rdwrw0fpKRC+9U4CmVw7XEsrEnlMLTR8qC9phP7JjjxeRAn1pX?=
 =?us-ascii?Q?ZOysaoTSC4SeTzm8Snl5KfxtA7KIpYej5dFS96bLIoB86eNXdLNOIjasnzbX?=
 =?us-ascii?Q?HD0+8EUCBkFwaS/H5D7PiOLm95AbebO6xNeVfPc6Kw6+9Lpa1WMVnfr2oGSs?=
 =?us-ascii?Q?QGJTrhzx1WZhZKaFWIYj8M6bUBW3SPssGtTqsTY3eobZ8TEi9wWbf/VAQyzj?=
 =?us-ascii?Q?VNaIsGj1fpkZ5TgoUVCet9wr?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 951d2e6a-4feb-43b2-1482-08d988d6a4bb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 14:36:11.9739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 A/NrZK9RhbzRkzxbflyNOijAcqwPoRXKSpLl+P1ZQ/5NbT3+/gPWoVinM5wQlf/3qpJP7TPA7Sd83huGSciOJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6206
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 06 Oct 2021 14:36:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12729

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Delay directory restore and set execute/search directory mode bits in
unpack to support npm archives with a missing search directory mode.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/fetch2/npm.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index 47898509..a39f1c19 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -69,8 +69,10 @@ def npm_unpack(tarball, destdir, d):
     bb.utils.mkdirhier(destdir)
     cmd =3D "tar --extract --gzip --file=3D%s" % shlex.quote(tarball)
     cmd +=3D " --no-same-owner"
+    cmd +=3D " --delay-directory-restore"
     cmd +=3D " --strip-components=3D1"
     runfetchcmd(cmd, d, workdir=3Ddestdir)
+    runfetchcmd("chmod -R +X %s" % (destdir), d, quiet=3DTrue, workdir=3Dd=
estdir)
=20
 class NpmEnvironment(object):
     """
--=20
2.20.1


