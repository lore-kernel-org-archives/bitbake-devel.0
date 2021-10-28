Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C8CC433F5
	for <webhook@archiver.kernel.org>; Thu, 28 Oct 2021 12:42:57 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.51])
 by mx.groups.io with SMTP id smtpd.web11.12393.1635424974946450704
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 28 Oct 2021 05:42:57 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify"
 header.i=@weidmueller.onmicrosoft.com
 header.s=selector1-weidmueller-onmicrosoft-com header.b=yJX+kD15;
 spf=pass (domain: weidmueller.com, ip: 40.107.8.51,
 mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VC6kq4sesRRFUbNXVDPXTglWO9SufUhVs4eHbljgLUT/EmlMib6sPhSXzMPL0xWp5Hm7Buf5wectMXSlFmdpExYYqg5OYfV/DhJ8k92Idg08P2WDkVQ6QokgM6uibiKRdiomeZ9EX2oguBt0cUMdW0EJbG3o3fFzyHcbSuK5Oji3IKeev5141NjDCa/ogWO0GUeBxvEbsdSrtoxvIq2r5oaau/D44hfzk2GOH/2D07R87EuaQsj/0u32kkqUmOgTgpWe1TljXH28frRdKWDljxlA8t64UYSr9S6unVrmsdAO4QIve99I4tvkUyQ8ZGrWSiOgdKozklUeQ/8s1FZx1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ODkhemT61sO25CHgYi1FoKg1usy1qDOa9ErrarnfUz0=;
 b=KFvPPi74oDxxNw5pl1dgWnLla+OaqQwqPhxKR70MNVOulnC7OUdvjhPiR0RgCmY5/xCmgKvbsTHO8k0nsWeF8dexLV6gjMryvHKPDJQ8Uk/3xFqAeHyMHdiNJRsBLp0Ho75gPewOTG/8MAzkpLiWYkRcWFlxCY606S3C6HJAAamzoeeebP9q37mBdjMd7inu2ozJvzeqrr4ORd13s4xF8AC+UN7S4wVgJbVyUWq0XoMoajYHrg0wFX24vcCSSd+mF2Jh9RF6PeigPfFo0xd83hqGXA1MORpxVoBI4UnF7YQ6Ol2fb3+tA1yppmws+8w/6vQW71eoyAAm4LLQFZqGgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ODkhemT61sO25CHgYi1FoKg1usy1qDOa9ErrarnfUz0=;
 b=yJX+kD15IA8coU3+jh8S54QYsThOOeEVYnVrlwhfwvs/gPpKa0eRvpj5tJkZfdf4f4aqOIB852ArekwHUAcFbB13TK+mrKyOIfvKpMOYXzUgzvcxKi0diQO5XkVYAeVEq8Av6MHD4jcTPVFHZh19p+rFH58KmAu/77JD/HgLMqc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by PAXPR08MB6559.eurprd08.prod.outlook.com (2603:10a6:102:df::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Thu, 28 Oct
 2021 12:42:51 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::8034:af5f:f101:d1f0]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::8034:af5f:f101:d1f0%3]) with mapi id 15.20.4628.020; Thu, 28 Oct 2021
 12:42:51 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH] fetch2: npmsw: Add support for github prefix in npm
 shrinkwrap version
Date: Thu, 28 Oct 2021 14:41:43 +0200
Message-ID: 
 <20211028124143.11011-1-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AS8P250CA0021.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:330::26) To PAXPR08MB6969.eurprd08.prod.outlook.com
 (2603:10a6:102:1d8::23)
MIME-Version: 1.0
Received: from DE10512.weidmueller.com (89.247.126.104) by
 AS8P250CA0021.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:330::26) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend
 Transport; Thu, 28 Oct 2021 12:42:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a57fee06-ea95-4135-da4a-08d99a10747d
X-MS-TrafficTypeDiagnostic: PAXPR08MB6559:
X-Microsoft-Antispam-PRVS: 
	<PAXPR08MB6559E7725B57A49B831D427CD7869@PAXPR08MB6559.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	MiwTa6nGiy4cGl6ijLhLL6XhmFfupBfiBtmN90Q01+zow9iacyrkD3roEVAuKYq7/1ilVKfNGFrpz+VJSnefYNpR2OXIthE5s0HR+xI7LUlPZH/9sS/I/8AP2qh9zoXdRQnPE3w9pPHl1TKQzD4QwhcftmlBtx2paxXwdK/dqbMQP1Kybz3Ante/0jF5Gg286zKhYOYdNDcQgxQMS/mixAp7p9SrG2HRAVReZlpPyZupCTexQ/NMtY8pULlFAjUjeBBYcUnx43gf8A6DrnRVLXidDofBFt8N6MRxAnwxF77lp1ddcKHV8mxxMmBbxppEvkNpiqnCGa+pISuf0Vl3VayS0YzVCljykwRrZxlrr3AwSyrGSi4MPIrr9yo3UTkr+llVaKorcc/M6kfGXaR9Y+KDB34Bl0jmtgCT1K4WcinUTfHL3OeyzFK3k5ttaCKrtLo8qjpKHs52Cv6NI493/uqWk8KlxG3ZLW/SH4VVD8oecH3weH0/skxdE3i3GDM6wXf5SdW+moiDAZOcyPDP9sn/l8FVotnsdN66kpX1mCKBIIkKjj57QMEzmOXfgARgdsq1iH5Y7YmqkWIVNAt/xWudZrL1dFoB8c0M9Ta9ZMotEjcHp2DcqgjWGTklxOtFGvFk/uPThR2Zg5cc3nkjJ9x/eRr9I3xZQTLBTpiPJT6PnsroGBQBRRGujByDXf06haTm3zxWiIGwIkddcK7PmtbPC/TyCE9xk2oUSpQpvwdz9MhUDD77EBBQn0S21fJl2u2WWCpknffKlqrFHY2igkE3AJpVTFmjtwg4zu/K9ZA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4744005)(8676002)(956004)(38350700002)(26005)(36756003)(186003)(66946007)(2616005)(508600001)(6916009)(66556008)(5660300002)(66476007)(2906002)(7696005)(1076003)(4326008)(52116002)(86362001)(6666004)(316002)(6486002)(107886003)(8936002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?vuuHYHaJgg5WURy4qJhgdDVAFuMap4Qi+Q2U7gZuGbBbgGMFiErzEiv37cL2?=
 =?us-ascii?Q?q9HNWFN+sbcN5aYizhdXFOIAO2HVjGl/QKnIlZMdsCDLiBaRE/JTUJQFhhDm?=
 =?us-ascii?Q?XY7kQLEokqM882Wzrx1IX7D5LDGLvIa+mWxjgCQvfWydRtJU++mr6ooy5u6Z?=
 =?us-ascii?Q?KtnTgnXt+aIvKLzS18ViklmInvaek0eVDzte2lH4ng1hXIS7BRXT57fKppdl?=
 =?us-ascii?Q?oSOkjhBbn4ldnl//ZgeKo3BpAVroKtoXDaRfebqCT3EdUGw/THgOeqUVrPCx?=
 =?us-ascii?Q?I4JPhFQLN0IBgUU0CsyGnBJnL9OctWrB66ByRa1B1B0bROvZxRE1y8cod7AD?=
 =?us-ascii?Q?l4szmaVBQhzX0+OPEtT4aP2mTorI4TM9DBq6y9d/2PcH7C64msCZlyCKWsAi?=
 =?us-ascii?Q?xkEV9l6q7+6z6/MAe6xKaemV4MRYglvEkcNwXgQEBWGKIHyXWCXSa7T/L6OM?=
 =?us-ascii?Q?+ksedOXNw1jeXamxTShvg5k0wHQ5rcjsZlQs0axowYMJH6skshkXtWTZCVgs?=
 =?us-ascii?Q?QxzWr/1qwfk3JCgm24vXnVBaBVi7mOOukJXsU06qzE/gEZtse42ucFnk/0cZ?=
 =?us-ascii?Q?8Sxt/wa6Yt0bq8mZ3pnhwhyOsccifZTw99bROqJ3w0xd/pbBUXnGHTRfFJdx?=
 =?us-ascii?Q?TElGO3D7JUKZBdnYVFzUa2ROY+kVZvIeDWlDt8W16d0+QnkHJ02yC0yeyFQa?=
 =?us-ascii?Q?+NwzWX8Wv9COlHyBDH7x7UKmNUfFDl1MmUsI8O9hHw2v+N3nuCEJVOAB4Ki6?=
 =?us-ascii?Q?LexJ1ZfkhL9ZACS7BLhJWhhmXqFD/7dLUeKH7XTwyV0eWinWzme2Vr7UB3fR?=
 =?us-ascii?Q?0RQKK1PlphtFp2srrQJN2vVfmIG8qT073IZHJEa9hYGSet0NMrytmxMpqnJI?=
 =?us-ascii?Q?eA14Ke7Uf1kwSkqWaWTkVt82Q6yrPeNHwsgo1UDe4ugMCVu5NhBHGlYBZCpU?=
 =?us-ascii?Q?Bgnkz7fNpkt6VWPGUAj/e8Mv09H3Pjp61QGFLNKVzy5fec2JLF67Op3q+KnJ?=
 =?us-ascii?Q?AGoaR+QucwNXA16yAClzj/TH++ES7R/9yNKbRpuyiZZGH8v0I9SCBSVef/pk?=
 =?us-ascii?Q?lEONcU7qK845+4h+nr536v3w4A/a9c/NVxZM/88Ion+rySUDgJyr0nCOuBUy?=
 =?us-ascii?Q?fzf2JOuT5m9OckcBHMbAlCoEU1BHUSGfVp927WHuLiOE9YeEDP+qKxU7wUbl?=
 =?us-ascii?Q?Wm9MfPZXw40Q5cAMOUDk56XRqC1FcoOqJwx6QqoWT/u3sOYx4CPgVGPjetcJ?=
 =?us-ascii?Q?+9vSo+Is1WvQ449EK6krJ+Hve0PyPk0oWUmFy3cTv/bO4iwh+b0kIhuYoT0y?=
 =?us-ascii?Q?ERFMs9FQ80U5cJpvgrv2UfC5xeY8KQS3tt26JSyrca10VIe11sAZUUELc2CI?=
 =?us-ascii?Q?S/6hLPLx+B9qZTw1MUZBxoj1iAXFMwBC34wJXSVtLwjpewETMrjlMSmmbYlh?=
 =?us-ascii?Q?+2PzA/icdjRxR+LUzsTMg8Bddxv5/048RHzrT1NzCn6z4r7CiTQTU9eEEaZg?=
 =?us-ascii?Q?ryZCogSubgsmir7za+/o7trBcJBR/3OD0fzFCHYFmVBFRdOcPDaRmW6wnK9c?=
 =?us-ascii?Q?HnEWJFFU2vdQrJldZ1DUngL28HrNg6P0OkqvJo4AmNuSRjwBtYEl9zr1ECoq?=
 =?us-ascii?Q?VI/Ko7iATpL8PzCMWU7DXMI=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 a57fee06-ea95-4135-da4a-08d99a10747d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 12:42:51.6913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 nJt6f34931I+ygjtvFQTXaQRd6wEB+2R6TPeX7eN7C/YmWSmjWoLnLHtzn1M0QtDD8Bunkh/EUKBYWpprWlyeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6559
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 28 Oct 2021 12:42:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12844

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>

---

 lib/bb/fetch2/npmsw.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/fetch2/npmsw.py b/lib/bb/fetch2/npmsw.py
index 426a1396..06e66bd5 100644
--- a/lib/bb/fetch2/npmsw.py
+++ b/lib/bb/fetch2/npmsw.py
@@ -127,6 +127,8 @@ class NpmShrinkWrap(FetchMethod):
=20
             # Handle git sources
             elif version.startswith("git"):
+                if version.startswith("github:"):
+                    version =3D "git+https://github.com/" + version[len("g=
ithub:"):]
                 regex =3D re.compile(r"""
                     ^
                     git\+
--=20
2.20.1


