Return-Path: <quentin.schulz@theobroma-systems.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4EB2C433F5
	for <webhook@archiver.kernel.org>; Thu,  4 Nov 2021 16:43:50 +0000 (UTC)
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (EUR03-VE1-obe.outbound.protection.outlook.com [40.107.5.54])
 by mx.groups.io with SMTP id smtpd.web10.218.1636044228595800118
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Nov 2021 09:43:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherrycloud.onmicrosoft.com
 header.s=selector2-cherrycloud-onmicrosoft-com header.b=XIxRKo+4;
 spf=pass (domain: theobroma-systems.com, ip: 40.107.5.54,
 mailfrom: quentin.schulz@theobroma-systems.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=idK0WwH8NSlKQNam7LlGUvw+qBpNW8vCX6P06b9viDPXHUCwsaBBQ73g+r4TWdYSwP8nyzC4Z/WxTRhxnIDJJxPuwU4HLWDf+2sGKy/M9YEfo0vRGCj6bWQ460ByVXDDeTglD0MWpq37+emIxwaSw+qvqM3T3aRGxsEQHUu1UtAtEh6izwoQoLziWyeG7iGsOFWMEGiQv07O0TbEOfiJNHIz1l2YQyKv9hdLiqz83E9rFSGTkqiKaxuz/s2oCAfWXvYA3GhILX3awhjswcGX8yQAceKw3AAtEtjFO5ufDpqksgJT8gzp4B9U/bJ+56C+/QkVvYQ5ymQrhqd/IyQHYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qxFhqFI5CG1D3NbI1z7f7FTkR0tL5Q9cHLmLI5Uf1bE=;
 b=nYUe0HciiSI0YyM26EJkpmNnss+d2GrhzE66Vqvdb5yZOIq+6R2qVj0T89cZAWoj9nFbimMFH2tL6aKOBBqpQB2XTQLzSpiBn8zSqqb1xPbZhh0rx0gnt4IbSanu+r8Zf0U6oB22LA6OW0D8dbkbg60S1gal+C5yII5FNYayV0FgShTQ4LmnzHf5Yji5jQUtnz/1qB29uxW3Bnsx4dDHj0ivN3l+3jIIpfUdYUzcM0VrmWsFIDTGnEV/7lMXFBl4J2Z2+UXoQbcmJzzzzmnrnzzNZVDAc7kT00to5qWwMpZnF0/cCEU2f+z85tsWgywvDwxLXwy1zGsK0wbO840NbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherrycloud.onmicrosoft.com; s=selector2-cherrycloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxFhqFI5CG1D3NbI1z7f7FTkR0tL5Q9cHLmLI5Uf1bE=;
 b=XIxRKo+4rMEZjiynIKkoTLsKYwGwxMF4qF+Blz6HfDSztk7FC6zrs/QbhwyjiX18URkWTMTHXq1PxQQyv8ZcmYmUlnCfLiVxClISAcIcLZWZ7J3HqHegf2P+oS/KXkI/mStP08+YRgJ2JGdqcWcg33+cYDDDEkyQi88dC4iKRl4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from AM0PR0402MB3348.eurprd04.prod.outlook.com
 (2603:10a6:208:24::24) by AM0PR04MB6450.eurprd04.prod.outlook.com
 (2603:10a6:208:173::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Thu, 4 Nov
 2021 16:43:44 +0000
Received: from AM0PR0402MB3348.eurprd04.prod.outlook.com
 ([fe80::d56f:ec59:3bd0:6d7a]) by AM0PR0402MB3348.eurprd04.prod.outlook.com
 ([fe80::d56f:ec59:3bd0:6d7a%5]) with mapi id 15.20.4649.021; Thu, 4 Nov 2021
 16:43:44 +0000
Date: Thu, 4 Nov 2021 17:43:42 +0100
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
To: Konrad Weihmann <kweihmann@outlook.com>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>,
	bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH] parse/ast: Show errors for
 append/prepend/remove operators combined with +=/.=
Message-ID: <20211104164342.xn4a25owkt7wrmhh@fedora>
References: <20211104135848.3621936-1-richard.purdie@linuxfoundation.org>
 <AM9PR09MB4642D846F590EE6FA7CB00E6A88D9@AM9PR09MB4642.eurprd09.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: 
 <AM9PR09MB4642D846F590EE6FA7CB00E6A88D9@AM9PR09MB4642.eurprd09.prod.outlook.com>
X-ClientProxiedBy: AS9PR06CA0068.eurprd06.prod.outlook.com
 (2603:10a6:20b:464::32) To AM0PR0402MB3348.eurprd04.prod.outlook.com
 (2603:10a6:208:24::24)
MIME-Version: 1.0
Received: from fedora (92.42.140.82) by
 AS9PR06CA0068.eurprd06.prod.outlook.com (2603:10a6:20b:464::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend
 Transport; Thu, 4 Nov 2021 16:43:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18af5881-7e23-44a9-c8f9-08d99fb24411
X-MS-TrafficTypeDiagnostic: AM0PR04MB6450:
X-Microsoft-Antispam-PRVS: 
	<AM0PR04MB64502291DFFE40DE55015FBBC28D9@AM0PR04MB6450.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Lm6wdswFI3bInlCLzTw6UtQI3ztB1BmzeoJT0klLbsiLmwHu7nsDl9navLxZdwlzAa9GmjT8E3cJoPLIFszBLzgh1jMljqkJKWmOCjwFd94/RRTLanp5i8v3jmbCr6n3PeT06rJd3ABrzgiC7ChPv4H6gF1rU+kwboyd3UjDz9vkSugdBX6isETyP5D6P7FyNVUxUHCQTdtKvFYNMMtfL3whU41pB9LXMRJOJ0LPxny449Ws5696QUZlIBYQRiB+AOvj7niGonvtb0fCMKSlid04Mqs2o6EJlxi5Vz83kBl2ByPDYidMiohnvw1N4RVYYOJzEWttVcGzOeSj4AKW5m9CewQ5I5fj3fjzxpNSp4RvB/WaOZtUBKSSkFv6N0kyNj7p5wHVedsLhKiEUd3vmjhw0CM2Pucb4LbVCRNCiW5M+4rF7X8GjCzt7OBZr/FnVerYIOqoVb9erm+NMDn682ikWJz3Oo73eFpIFBL6XYKfhiE9SHTwvUiQ194MptUtBV1D0HzYzaeynbYLyx6EijjuekZ89g0y4NSPQS7Riu1KF2M8xMvhuse1KO0nNz4o5DgN25TPBjv4qJ47FShJDoxMdsILYARG/eEBig1Fx/8X3z35kbM/j4N9gsmbR6IQZ09QtaFhmrOv6NWBjrdbvnlyuuTgAB5zkwogiJXYJp5aY28R7rl+tYBCRZDOpSabM7h0OLFWY/r15DDKlJjanmFOpqJfHVlsxqTAkC25icU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3348.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(5660300002)(66476007)(4326008)(53546011)(55016002)(66946007)(2906002)(9576002)(508600001)(9686003)(956004)(316002)(52116002)(44832011)(83380400001)(38350700002)(33716001)(26005)(6916009)(6496006)(1076003)(186003)(8676002)(86362001)(8936002)(38100700002)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?DAWGi3GtSQ6YaPWmLof2u5OZAFpc31QZsMrIojoNu6bZOkfBxg7DDwjdOayo?=
 =?us-ascii?Q?8PIpXRB23Wgu6bxTV7YVd/5qfraO/oX3ZkJfNqJ9PRWku8Z+wbY2icyD2gnx?=
 =?us-ascii?Q?dC/U17HxKKYMCKMgywNd9VpeRWbqEbN3DdohYmzSKbKXbzMD9+//Vr8E+FBb?=
 =?us-ascii?Q?DWABqkAoOb6Crd5OCupqSXwazpdcdy/mm7iIeHp8zKNBDwj/qWOesPrdo2q7?=
 =?us-ascii?Q?N/hhMMB07Kckd//QbXrFmmUVBYBQSYqWLnPLvU7+hEwpCq96mTld4HeMgmC7?=
 =?us-ascii?Q?DHOOkdwqW5vMdvCefzrOKINnn8IeTUlnDiJMEQxWU5rDaJHPOYvX21HyAYqA?=
 =?us-ascii?Q?OrvHInhztO9YKwH6Qlr8s+o6LFQlzin/E9MU1lTPgNdFyhReFQG/8PJsw1Y0?=
 =?us-ascii?Q?++guoeHTAEVMoA64bkG4Ndgi/dbJCrrCXXFP6dWK1bdbNrLxrrsn7Pja3Dh5?=
 =?us-ascii?Q?UvQ73NvhmqU09s5cfHJNa4lM9rhbseZ1NufUn842e5VDfHblLGb/qCTeXHpq?=
 =?us-ascii?Q?EmA7r3sVOExdLGsA0YialGWKVVLQcC/emOLQ0kHJ8y1PRvv/NTtxDoQiXej6?=
 =?us-ascii?Q?MhN9ub4ri5tO7tpsF3PYtvP1abRDBzxjrjgKJ/JLVIhDBJ9hLzvrNRJTGnWi?=
 =?us-ascii?Q?+0JTDWnpV8OgJatIp68EVvlLSI3VlEcVY6D1RSzrbIfk/+L2BEOgwfZQZPUA?=
 =?us-ascii?Q?WxD6trC6P/LwGinc5rl3gAVgCdoJmzAcEfXiOSoU2v1waOnCuYiJKPBJSXNK?=
 =?us-ascii?Q?0CGphnIKgBrE9f/vMR4cgs6fi0lCJPmBYcOI2z6KSiBG9rcJLyJbBDyDAgNE?=
 =?us-ascii?Q?FP4ohPWXo8pGRV/f76rT4Jmhy/B4qZVlesusfS/iNhKpZXhO0jLbCTUr6beV?=
 =?us-ascii?Q?jQZrXYiisuhAshFX23sTuEP/zuCoOFjJLRDkgizxnyfHJgDRq3/dTdRpZJoC?=
 =?us-ascii?Q?XNgPGHpalXeG9CkOAwByk5ukz8IJz6cPV6iGFsmScAx4JSEwoZ1LVJzOyHZ6?=
 =?us-ascii?Q?yy07Ku+jiaI1jwm94M68xBMflHSFoy0c08sBNYoPKTs75PdLsQteerHVp/rT?=
 =?us-ascii?Q?jwdtrO7QKCs7T/dM9BwW4b5FAzUf1T4ySRA/LCLE7+lKhqzUZVGbpeKa6pwW?=
 =?us-ascii?Q?kcBpGA9jzye3JYkq9qOkTbdkJHZRIVRipUme4FSeQVnaqvZ2VMIxink6DtGI?=
 =?us-ascii?Q?T9dPWkLmlPYIakJ8aUQTDvD+DpoGPxIWZNK+ZssvEPBjc7i118K71GRIuly2?=
 =?us-ascii?Q?0cYMC1Opk6DceSO/wX9LBolagDYXB3VRqhiNn1LOnZryWoJPVuPHeVAf0/rO?=
 =?us-ascii?Q?VIkeOG/uqeRLv/MTJK1HAmxDSkLlviDjWLcumC+mbkaA1Pv/CLme20HZc18Z?=
 =?us-ascii?Q?7fcUpcBcrYyBIsW9Q9zrf8SQlp4UXxzljMGiocOHLl2s2Y8XcbLcWi5eqUf5?=
 =?us-ascii?Q?YgladTRYTdgrAkDQcPiIQNXXJM5FltYbPgN808rq0Am9u1BbStgtiuy7M3PD?=
 =?us-ascii?Q?E/6G8zHJmK9paFvTbwUYORKrfqK+cQP2wOLbwSF6SBe6Qqg+VBA609hfBwva?=
 =?us-ascii?Q?uTWXHZ26p1qaRnNpN13Hu7M8nXhMi6STn2vOHveY/QdQ9fCr4sqVTpnclk0H?=
 =?us-ascii?Q?OPvNVxgWG5uduRBVeBCq1QqTvwON6jFlPpT0a1u49x5kVUB+382I3c+3j+LQ?=
 =?us-ascii?Q?o7xmbgvnPoEj6nSOAyZWoXj6491OJOhEjNl4JIwbR0y3k9MNUy5YVM3VoiSa?=
 =?us-ascii?Q?bFiQxRtaNQ=3D=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 18af5881-7e23-44a9-c8f9-08d99fb24411
X-MS-Exchange-CrossTenant-AuthSource: 
 AM0PR0402MB3348.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 16:43:44.6306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 O4OcGVx9XIdl+fqsVuSJUtL8FY5kkUDhNB/j2sVXm+YH/dHTdJZUwZaVVr+hJfl2b5MSPngIqhfkkynLYbJWyeYs5MIzjH22HRd3Zoy9UDkgLAhLsWGkR0ovloxnhK/3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6450
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 04 Nov 2021 16:43:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12882

Hi all,

On Thu, Nov 04, 2021 at 03:02:58PM +0100, Konrad Weihmann wrote:
> 
> 
> On 04.11.21 14:58, Richard Purdie wrote:
> > Operations like XXX:append += "YYY" are almost always wrong and this
> > is a common mistake made in the metadata. Show warnings for these usages
> > with a view to making it a fatal error eventually.
> > 
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > ---
> >   lib/bb/parse/ast.py | 4 ++++
> >   1 file changed, 4 insertions(+)
> > 
> > diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
> > index 743ea0dfc0..93cbf285ef 100644
> > --- a/lib/bb/parse/ast.py
> > +++ b/lib/bb/parse/ast.py
> > @@ -130,6 +130,10 @@ class DataNode(AstNode):
> >           else:
> >               val = groupd["value"]
> > +        if ":append" in key or ":remove" in key or ":prepend" in key:
> > +            if op in ["append", "prepend", "postdot", "predot"]:
> > +                bb.warn(key + " " + groupd[op] + " is not a recommended operator combination, please replace it.")
> > +
> 
> I've seen also weird combinations like
> 
> append:remove
> 
> with multiple contradicting override operations out in the wild, might be
> worth to warn about them as well in a follow-up
> 

I assume :append:.*:append is also something that should be avoided.

And I think we can even go as far as saying that you cannot have any two of
append/prepend/remove ?

So...
:append:.*:append
:append:.*:prepend
:append:.*:remove
:prepend:.*:append
:prepend:.*:prepend
:prepend:.*:remove
:remove:.*:remove
:remove:.*:append
:remove:.*:prepend

are no-nos.

Cheers,
Quentin

