Received: from NAM02-BL2-obe.outbound.protection.outlook.com (NAM02-BL2-obe.outbound.protection.outlook.com [40.107.75.44])
 by mx.groups.io with SMTP id smtpd.web11.116903.1597948459635604703
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 20 Aug 2020 11:34:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=u1hxXf4f;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.75.44, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aQDe0JZbHCucYyAWBAldFIDgfsLHu7r1BiGjnhplILKzsKMIsf82hqNsZuFOpLhGNjPdUrXwNe2CgnF2FCLCCwDxPPpW0ztBrWv7D2sBhwPiYTLawDwqMfEhiK4zEqlL2UUOPuzgCaKl2C3E8Q0N47v7Buh3ub2c2YYgrzoSTZi1P37bgw8xYuBnsoZTgfp/pO4hflNFmtY+9LS+WPrC2qafrJ9SPNssVX5v509ahTRxAdF/9L/OwJeO09orD52oEl/56bRflgMdkpLRGu6GmPt2osCla9KQUY7E/2P1Q9F5jHnmeP3pm2zg6vwapLWOyA70PWr0xbt0lWaAVycT8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8e1PVrHI0Xf0Ui5rJAeGPnZ18WGguO0PaDG4OR6mRfQ=;
 b=RROSkEb+67eVa1qxjBwSooIvgTBbSm/tz/b+i+2/zHu1WRR7tsR0BZQhmJncbM5BceY4Djzh3FRJ1B3yaFx1bBaeYhGZrjwxVvBoMHKGqvpALJhGkKsJwMu38lJEarEgME1Poa9khiG203P9Zj1MwWBn4En3H5ie8UbKwysypAb3hs5gpqCXBmc2kQqex7pbeCMmO0M46CYzHvWG9IaP2dXhRXTShw+VEdP8ZMQDNGXH6QIaLBYnCGJ+QXuuDftztTF9Ieefks/RcFNp3/z7wFJIG3zTeQJKdDdMFhNWIwAznBovEslLnOAh9XKoWYN6lOVALFbdQx+FEh6/fWYWlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8e1PVrHI0Xf0Ui5rJAeGPnZ18WGguO0PaDG4OR6mRfQ=;
 b=u1hxXf4fOQmhatfmd23ELJULtmzhvrBW3L+BEaQqDJNdxkjp/CtPC1A6IE1p9IT5vwLPt8Uja/lxLQ3DWFy4mhlJ+cqg9ZeE3CU5b90wvayIKm1w9vQK6yiOC0Q5u7U6xkb5Tn/PYL+ebrNdlUaNQvVYtWd51AFCRb+2MZKglxux5rfZxue3sQ+F4IBjnTZTaFNKrsf6b30qkNYINV4r6TFwdOsu0IMsA6DSno3DvM/Svia3nDFjlBYhp3VlLFBcG1NAeK4kgbbMkH5kpav8WbsbaYufS/RncG+NVaetUcWTL7OPPMKMHdKIHcB8haBmesJFrXglou2wWfTOozK5lg==
Received: from SN1PR12MB2480.namprd12.prod.outlook.com (2603:10b6:802:22::21)
 by SN1PR12MB2576.namprd12.prod.outlook.com (2603:10b6:802:22::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Thu, 20 Aug
 2020 18:34:18 +0000
Received: from SN1PR12MB2480.namprd12.prod.outlook.com
 ([fe80::4c4f:2633:b1bc:c164]) by SN1PR12MB2480.namprd12.prod.outlook.com
 ([fe80::4c4f:2633:b1bc:c164%6]) with mapi id 15.20.3305.024; Thu, 20 Aug 2020
 18:34:18 +0000
From: "Chris Laplante" <chris.laplante@agilent.com>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
CC: "BitBake Development (bitbake-devel@lists.openembedded.org)"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: Problem with shell func backtracing and BB_VERBOSE_LOGS
Thread-Topic: Problem with shell func backtracing and BB_VERBOSE_LOGS
Thread-Index: AdZ3H5kzgzO3bGd5QKaII5Jeb0tgLwAAJtXwAAAMZxAAAAKeYA==
Date: Thu, 20 Aug 2020 18:34:18 +0000
Message-ID: 
 <SN1PR12MB2480CE4109DE172A161352C08B5A0@SN1PR12MB2480.namprd12.prod.outlook.com>
References: <162D0D4E94A43CAA.19371@lists.openembedded.org>
 <1646d05d5e7740a79978cfcbda7966a6@XBOX03.axis.com>
 <SN1PR12MB24804291B08431548D7AFC598B5A0@SN1PR12MB2480.namprd12.prod.outlook.com>
In-Reply-To: 
 <SN1PR12MB24804291B08431548D7AFC598B5A0@SN1PR12MB2480.namprd12.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: axis.com; dkim=none (message not signed)
 header.d=none;axis.com; dmarc=none action=none header.from=agilent.com;
x-originating-ip: [76.99.179.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce965da4-529a-4dbf-425a-08d84537a62c
x-ms-traffictypediagnostic: SN1PR12MB2576:
x-microsoft-antispam-prvs: 
 <SN1PR12MB2576738BB90E974B2DD188838B5A0@SN1PR12MB2576.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 1JQxI2gHgZb1aCAH9esxhiKBpprdkxPEZMA+bixbQ3Y+s4xS4yAGMLIaVa93PPJkq50o3oEPeJcWHkdktq8b5KO8JmgfW8mQ+cIqmrbxb1CXJtqHfL/o3DBcY4kUPZv9vviTUs/wW124vp3pAU/hH/4iO6Y9JYkJbTK3mUaiY+jAzH1YDxs5vSul195vUIIjaiSjqsyaGwCdvnDMsGTnYtGiF4YG9pmRL5NtZbMNC0dHjC5OeCepd+Cv7VVDclhK9/RvcsG2WcKXscObGIAlH2mf/kJmAGKHYN0C8q7i4P9+sugMtNYwiZpj9aulmpn59IFYSaq3XKb7W2kmr2VhOoz9RXqFKeH/gER/WIpc2CmXyL53yFsxmyf6lU+TZMmi
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2480.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(366004)(346002)(376002)(39860400002)(29502001)(71200400001)(26005)(86362001)(45080400002)(6506007)(33656002)(186003)(7696005)(5660300002)(9686003)(316002)(2906002)(6916009)(66946007)(66446008)(66556008)(66476007)(2940100002)(64756008)(8676002)(76116006)(52536014)(8936002)(83380400001)(558084003)(55016002)(478600001)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 KMAmnrri1jsksXCaeGKI4bg1FvXhHdjS7qJocJYfmctcEqAoiYrGL3WlOjj2ocK0Eh8t9yRuCTsw8bqH6F3KNhtHNkFZ4zbNk8J8hSasTKVNOKIb+AUwLUWOE42MkgFDeR6ZSyFRnpC4SVnZ7AA/ftcZ+LWegdJIbW3Jx/4F0vaG7wiiKgSpU9xD/bRItvJcqZw0IJWzzathm0rMOYEQNICsFyH+YH3cYYpxszEmDo+3kPzc5MKdjZ9M7ettEOnoYwXc/cVkPCAKytTRIH9A2ZPO9p0ICPA/6vUNqK1KdWoGNbRKt221FcYL1GiZQ2+Fzwim5z55drd3EkbLfGb6dgF+9LsMhFazzUOpsTJK66MdveX9YiDCyo0puCY9NIBlj/SzQcpd5a1aan5//4Glmb9h52N2+Awemc/z11eFcB86Yuuwpbu7++tRtScPkFfrV5aiIC53F0JsDnY7L4LSA5iVy4r4w0dcH3XfScdtoeh2H3HKRsT5AT8DkY8dRowNsrMoKFGfOmDZVOpNIIS5TuqM5ugYm6sjDout63nr2NpaEZd3tiT0tI+k7E9wpx3hkkzAfPH01GUQYhDquAylz/eZTViAOHakCtCaNVBcfxYKN+Crq7cmAKROGVcnci7NIyWULd3wErkLCcXjahyImA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2480.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce965da4-529a-4dbf-425a-08d84537a62c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2020 18:34:18.5731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zdz7AnKyWKoxvCjKt0NXaRcjWOeYuSzGUZ1sjMONL4kurl4vK2sTFPk2ub76DPd3Z+SU1lIZPWO7i8qeC6WlnbP0jsJKw3ewUnJRVQKrFpA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2576
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> > Bah, just ignore this. I just noticed that you have already sent a
> > patch to fix this. :)
> >
> > //Peter

[Damn, accidentally hit Ctrl + Enter in Outlook]

No problem :) please let me know if it is still not working after you give =
the patch a try.

Thanks,
Chris


