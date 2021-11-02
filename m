Return-Path: <quentin.schulz@theobroma-systems.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF77BC4332F
	for <webhook@archiver.kernel.org>; Tue,  2 Nov 2021 14:57:47 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.43])
 by mx.groups.io with SMTP id smtpd.web09.945.1635865065919145713
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Nov 2021 07:57:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherrycloud.onmicrosoft.com
 header.s=selector2-cherrycloud-onmicrosoft-com header.b=ZajNuM7G;
 spf=pass (domain: theobroma-systems.com, ip: 40.107.6.43,
 mailfrom: quentin.schulz@theobroma-systems.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lFHexy9kTZNW1TEnwxVPdxouJpzkKV5XIRQAPBKhld9pMABqEfV/lWRSodbwtphJKrjdy+wnBS9ilgH7vHqNSqahIRJh6ij0DLa6CyJljJbspDK2DD7KSIXbgBbTjs2pBmxmQYnAa/RFNZARwqmdsApOg83CUup8ZGyE48mgq7AktbfQGLsMhVLnYPOIGMhhBE6mB4o5ndKtqUXKlw83xNxXiuhyuN8rjxxafGMCxRhLluQa3BDzBAJ8K0jEwmomhdTPgvFG4HoIK2ysBTk+kxCTQWdeirivwgZ/GWlS2lm+bpVlcSMb14aOMTpd4cXGEojTs/6GO34ghMio4fscDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CMn6K37LaGj84sQ43QGjXWz0ziNwcrKvPc4UtgbiUs4=;
 b=ChP0iQfkCp58US/4WAbrVj5QsQyu6ywqPYoCZTkkYf6qTX0F4JzRuwrOs0xEwMM2aNiRuREosOwoo1eSweJgPDQ1r69hlkSmkJTrqP1JWpctNyjXKwdplhel8HSNNhq+tqInW98jDcGLRlvH4Id4VTWTLNFSEIkbgyrZLab18Cf392Rd0pZSmUb7mS3D9Sv/I/+Z2tcyMtY126cFM3eRpyOJdwgO3Gq5DOFg4YJYDltSoVDb1gEDDTbvrXEacWbna7SsYk00Iu+7wEI5X1QGEShlpp3pgVQT6LRXhUOSsFzf/6gpUqVYmTdjSerBLIxtElmaXA1ibZTEXmSZLVez1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherrycloud.onmicrosoft.com; s=selector2-cherrycloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMn6K37LaGj84sQ43QGjXWz0ziNwcrKvPc4UtgbiUs4=;
 b=ZajNuM7GO5AqdR/R8IJYVYouIPD9ziKTM+4SDydI5Zpj/CytavL2i62SA91PbnzGCVw8KFV2Ou9vLnTcir/ObJo6b1PG7D9TYq7IjqC+S26U76YjdhWdLxmItqpXJ0rcTmmEJlBpxre1WsihJoxe+Rw34ax7aI8CRqVN/a32raw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from AM0PR0402MB3348.eurprd04.prod.outlook.com
 (2603:10a6:208:24::24) by AM8PR04MB7283.eurprd04.prod.outlook.com
 (2603:10a6:20b:1c7::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Tue, 2 Nov
 2021 14:57:43 +0000
Received: from AM0PR0402MB3348.eurprd04.prod.outlook.com
 ([fe80::d56f:ec59:3bd0:6d7a]) by AM0PR0402MB3348.eurprd04.prod.outlook.com
 ([fe80::d56f:ec59:3bd0:6d7a%5]) with mapi id 15.20.4649.020; Tue, 2 Nov 2021
 14:57:43 +0000
Date: Tue, 2 Nov 2021 15:57:41 +0100
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
To: Frank Earl <linusti@gmail.com>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>,
	Konrad Weihmann <kweihmann@outlook.com>,
	bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH 1/2] fetch/git: Handle github dropping
 git:// support
Message-ID: <20211102145741.inxodrxjabwiu67t@fedora>
References: <20211102124500.3542952-1-richard.purdie@linuxfoundation.org>
 <AM9PR09MB4642729BBF86DB48FCA16DFCA88B9@AM9PR09MB4642.eurprd09.prod.outlook.com>
 <7930bb9f4875fdc32c4fa43395da68bae76a24c0.camel@linuxfoundation.org>
 <CANepkxCNovifgi84YiXmoydUpQbTLoV-uGWVF_oJ6rp10+V4cA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: 
 <CANepkxCNovifgi84YiXmoydUpQbTLoV-uGWVF_oJ6rp10+V4cA@mail.gmail.com>
X-ClientProxiedBy: AS8PR04CA0007.eurprd04.prod.outlook.com
 (2603:10a6:20b:310::12) To AM0PR0402MB3348.eurprd04.prod.outlook.com
 (2603:10a6:208:24::24)
MIME-Version: 1.0
Received: from fedora (92.42.140.82) by
 AS8PR04CA0007.eurprd04.prod.outlook.com (2603:10a6:20b:310::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend
 Transport; Tue, 2 Nov 2021 14:57:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 959729e0-401e-449d-8024-08d99e111f9f
X-MS-TrafficTypeDiagnostic: AM8PR04MB7283:
X-Microsoft-Antispam-PRVS: 
	<AM8PR04MB7283E843400544F25F833EB1C28B9@AM8PR04MB7283.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	bojJSw4MEdXafFawafZbVyqs0SYjhQ0NM7j2qYudywAJsw7FCpo5puJUjNhipE3gG0NSYVgm2MvkFtXubKjnZk+0qyHQ/VpWy/eX/hzlwp1B+9nUc99etdrS/8EOX9y034FfCH8NduLq1SYcSmfD88bGUyLKfAk7L84OmtQ7fBJGbAdIepVjh28K61IdPpFjBq0tdWBAB/Hbr8NRigYhft3U1ghT2DiJwV6fuflydjrd10fciaGklxpmhtS0vAY4kr8oIee+FzA0FpTsxaIvPK8Mkr2MyDG3xM6iOF6EyR3mK7FdZ2lUogwAioDOt3Nve7SMdRP8gI9Lu0UEv164Jn/2mQieNpp3YHoHMRr1QqAb0t11w8jmvB4watQrOUkEQKj9088FPUBynJWEvG5T6x0Xkg4gNZfYl8bcKusJGH+Hiv+iHz+duXUIhuRbrfKgfifhV0U081Fr9q85NS+9Dv1ceTbDe2EwWrVHK6ZzIw2l0N03g0Lw01pY+V3FjVkrX9ANPBcZuAzSaEhJQDhHUD7zslNeE3qKkilL7UQ5a4fKC4sYcVFL5Rd2YKoW9UVGGTnFVUHO9ahYTYJonA1ubZKxblZFITQ4PYyF4f7bM+uzuFIy6dKq3f16Aeej9Rd2P/TN3c7TaMqRfqjB0136g/NbbbT8osYqwBMR8B57juadvh1/py639jlqWTi6F9madx70o7+1otlYoyS/3GBIyw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3348.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(1076003)(33716001)(4326008)(8676002)(956004)(52116002)(6496006)(38100700002)(55016002)(66476007)(44832011)(66556008)(9686003)(508600001)(66946007)(38350700002)(4744005)(54906003)(186003)(86362001)(2906002)(6916009)(9576002)(316002)(26005)(83380400001)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?nCRDJ8PhchrkM/M1XYom+qYybO4NaxsjE9SrO52DPIzMzohmaVZ77MuwGz5b?=
 =?us-ascii?Q?+i6GuyemlvAwVxkTOHLt2yLgl6dlywyJa9S7ZUD+R/Jnv36IjFYONN/gj3qv?=
 =?us-ascii?Q?73bVTotfIgGZRAKaXWmCrw4nYxXwr6/Nw3t12dApToWaACEE3f9GI1epbQl7?=
 =?us-ascii?Q?4/1mM5fMKwk9JJvqLd9yI1v52L6hRIJNsxrC5s31/SOhJ95bXrWtlVMjcDqL?=
 =?us-ascii?Q?xMl2gr9RXXckS4xahAzM8FfrXsCbvc8CGpR/Wd9TklRJeCGALxirf20PqHQ6?=
 =?us-ascii?Q?rup18fA54vD96p3EJe5On8Biz7ntOLUCAD0WkMd8LCGi6mF3rzk/QkpfKUZR?=
 =?us-ascii?Q?c/MKnxThYkhoXzmvCEx5uV5dfET+ONmjknf2bnOpC+I4IvNI4CZ8zzBeQbUh?=
 =?us-ascii?Q?hBJovZuULQImjVuHXzixPb2QnJpa52x6XqKLCFng5tQudHv563NUHLjyS7c9?=
 =?us-ascii?Q?ZTkDFN+xzKSpCeboONn+b+RLyW/Xnh54QdAlqam08MxAnW5xi722F0lnL7HB?=
 =?us-ascii?Q?R9R2auF/zDS8zgvxECxBgNIjVWeudnsPLisgzoboR8xorvpkyOFlKQgrV2Fa?=
 =?us-ascii?Q?XWyGvvHo9XEgWgPuMrpJ2e2HYJ4bcX6hQE+OELBPFM9mM//Oufg8tg0TMHNo?=
 =?us-ascii?Q?sANLYe+mUniGzIKahgDmnQ1BgKp7AJLKRbBVQ9nR//KJmDaoxj68wNNj9K1f?=
 =?us-ascii?Q?Op69FpGFquExvj6tmbSDGDqeCv0x9R15QoAb2/KiK79v8Q+aHiLW520geh8w?=
 =?us-ascii?Q?OrzqN6BG//ypoQiFXZPD8YhqjDS2c120sARvHpCJYSWo3pS6P4gLyjCSVzpR?=
 =?us-ascii?Q?HE1wKwzg2KDmn/GHwrEOvSEVAGl1cBQLewBeSDisLqvOaX6R6QLnEYuT9tLs?=
 =?us-ascii?Q?H79Zl4ZS8L4Afm2+3ltpMrF+YbP1d/XF3YpK7gNRLknNb+rSap8+1CduTwpq?=
 =?us-ascii?Q?rncZexJxT3jtMcuzr8H7y/qBnqTosdRKLfOZ+XBm/BV7HcQ41gmZ3D0wecXm?=
 =?us-ascii?Q?0zWabpwzBioFHolh2tgFpGrgl/Brq7wwdUn63+JPX+SUYRG4lJn8r5SeI754?=
 =?us-ascii?Q?Wty93HdJH7l1lHSBv/dlyhYatXOAjlO7skp5bNE6yOQcEyqBmQPJ/MNG3sFE?=
 =?us-ascii?Q?qgyjqpHghwNsuI1r3dZLxJi89rTHu9Ag2/DVJ/nRp+go+mT1FNHRYM3Lyvtc?=
 =?us-ascii?Q?t8QgNcwv1a+b8d9lAOU4vTDpVpptXWqsmW0LJDdXFeItmjmT8FgeMbYebxBa?=
 =?us-ascii?Q?Cs3qrHj+Zz9iongAk9/fSxTCHLUyUWo7CGiLyu6GdLqVj+Oos5bF7yfAXPmV?=
 =?us-ascii?Q?woJG6Yxm5YZ7obPWO1ejtWtMzOL0Xp0b7mXhKtHp+X0qBpxOUJRFPhyA5fSC?=
 =?us-ascii?Q?AmGOF5WwdlEPDQ44yKGmkNQq9hri76ARhmD6COwXDrnE/dgPjfU6RBCTdvxJ?=
 =?us-ascii?Q?ii9yaq+sW88lB7E4xHzCG2jK5E3PbtLVLQ7/q9XCqjv1rpR34eXsDHloMnEO?=
 =?us-ascii?Q?uSgM6RBG+iLAdsh23lucxoIqI0ccCGxtdzX7BHDO9kv+fGJSFXY+LlAI41Nw?=
 =?us-ascii?Q?TguxnxW9dJQy70706wMOsHt87zgTl0dABXPpuFyC0B2SK8Szx6x5oeNXHyHN?=
 =?us-ascii?Q?JMa8nkhAfYaCLHUy3wfwjMF0vU99vDaBM9hUia5mVvtjEUDiVaTvt5Ic6lj+?=
 =?us-ascii?Q?s+wXKMmy7m2iA6cqTn4sybpQ7kFLYgIywoCuTWpXo1bGQoGWE+eeyZhxY8G+?=
 =?us-ascii?Q?OIYjhhrCYA=3D=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 959729e0-401e-449d-8024-08d99e111f9f
X-MS-Exchange-CrossTenant-AuthSource: 
 AM0PR0402MB3348.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2021 14:57:43.3204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 nX3HOPh384myozuFW9/YKpalUqbHAya99LQCINqhNyVz5rLpoizRfkHQdAM+BXUCSeA9oFpLzSYpguXYuu7v/0HcelChzToaNi9R35NegcE/bxo9CIpqVzFSuEWOa3f3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7283
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 02 Nov 2021 14:57:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12865

Hi Frank,

On Tue, Nov 02, 2021 at 09:06:19AM -0500, Frank Earl wrote:
> (Reply to all, since I simply hit reply...not nearly enough caffeine
> yet...)
> 
> This kind of breaks other things- what if you have a server that you need
> to do protocol=ssh and it's authenticated (We have some of this at Motorola

I think in that case you have ;protocol=ssh at the end of your URL?

In that case, the suggested code does handle that because it only
replaces the protocol from git to https. git protocol does not have
authentication, c.f. man git-clone:

"""
       The native transport (i.e. git:// URL) does no authentication and should be used with caution on unsecured
       networks.
"""

So if you needed authentication in the first place and it worked, I'm
pretty sure this change will not change anything for you.

Hopefully I understood your complain and am not completely off-topic :)

Cheers,
Quentin

