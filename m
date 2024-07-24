Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308DEC3DA63
	for <webhook@archiver.kernel.org>; Wed, 24 Jul 2024 13:50:00 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (NAM10-BN7-obe.outbound.protection.outlook.com [40.107.92.59])
 by mx.groups.io with SMTP id smtpd.web10.11084.1721828990082309757
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 24 Jul 2024 06:49:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=U/ynQ1RU;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.92.59, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qrOvVJpGeLJiA8SeRXSVc5QC6bnr2/xUtvIrD3eAVRk6B2yqBaua4u2FCiqJ9IszbM2rdzEKkVSwSB/Riolqo/8oXSeLW7NjMQ1Pt0AHVGJ0bxITcp/mg88T0H3tGKikXoWxx1G0qXpIv2YwcxV0W3hXM4Kkgpm+yp6XH8xYau7V7rWLMij4Z3iILW/koiGD5lw7N7VCB5jLZgZNHBvuMs79lShz+MDBTP+D/VfJYO2nF0jOodh44hZa3gu7X/8KKgH6emgJDLfU0DfFU7TcNPjZ3CXKAuD/dr2VpksDnwXKAgsYI+hvlYKdrRhaticXgSS6ynALdvzqYSECvuDupw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WW4kHQIKP4QIz7EGq/K/JkxJNl2P/Sg4tGaXYc/mqb4=;
 b=I8zUKgJPtuZ3pEOUO8fMnnxvdb85PUFQAMEaredAJJoL132/9/aqlT1njD/zaYEx/2Eblxlyv2m/EbWFla/6kKZ6nSSFRYQAS2rp0nlWnJ5jYgFUSxHwHs/q26DT/E+bsiVvzu7f84A3l3LXsp9KtYI4U7yJzcJDow/iOVvbFLtOf8Sf5ycFhU3lqFHgUQU7T0D9oaG6ZCOxZAE/d8y3Ky9L0K6iwiqMwpspth2wXXqmQD3OuJiRdOqUytcsfsLV//H/XhkZmM6La9eeDT+rDtfwbFwpQK8a29JHWOxa+0ZIgF1su+ERLi3mmRjGihP7HYH6KOojVloHga2l/LAicA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WW4kHQIKP4QIz7EGq/K/JkxJNl2P/Sg4tGaXYc/mqb4=;
 b=U/ynQ1RUdwP6crjTTT315cT2L6ezyzjH078Ufyb4U2R2mgy5eotkkDvlDQOFAo0/T+7jwLMUtDhos9mN1Lr4rxPPKM+dldXFigPIFDgVwpCCRYdAYDuO1L9OPmL7f688kqCMiwrSWYG5x4m/xozZzMqCiVwyknAlIUXBRO+GEp9G9/39K4pl+mCZlHxNspX1j8vYWZqaW77nbCXaHxjAWMFHfkixqOEn6bsGx0m1IXT2bb96Uu6J3j0vz70IOj8BTOfJc3814lv8gaNJ4OYOikEy4DqTYp3uq7MIiGqqsv53DUqkC4qGwLJL2f48qBu0gk7yubNtJ796KmeGtN02uA==
Received: from DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) by
 IA1PR12MB9063.namprd12.prod.outlook.com (2603:10b6:208:3a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Wed, 24 Jul
 2024 13:49:44 +0000
Received: from DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::604e:bc05:9357:c7d7]) by DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::604e:bc05:9357:c7d7%4]) with mapi id 15.20.7784.017; Wed, 24 Jul 2024
 13:49:44 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: "peter.kjellerstedt@axis.com" <peter.kjellerstedt@axis.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [RFC PATCH] ui/knotty: print log paths for failed
 tasks in summary
Thread-Topic: [bitbake-devel] [RFC PATCH] ui/knotty: print log paths for
 failed tasks in summary
Thread-Index: AQHawPIapS/6pGKeAESDdgOaEDjIOLHNuM1QgDcBcXCAAWQL0A==
Date: Wed, 24 Jul 2024 13:49:44 +0000
Message-ID: 
 <DM8PR12MB54305463A787C28830751D948BAA2@DM8PR12MB5430.namprd12.prod.outlook.com>
References: <17D9E3841C981E13.27929@lists.openembedded.org>
 <DM8PR12MB5430FE1BDE5343FD142CA3D78BCE2@DM8PR12MB5430.namprd12.prod.outlook.com>
 <DB5PR02MB10213FAD2E238F7AB9390A4D2EFA92@DB5PR02MB10213.eurprd02.prod.outlook.com>
In-Reply-To: 
 <DB5PR02MB10213FAD2E238F7AB9390A4D2EFA92@DB5PR02MB10213.eurprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ActionId=df634e94-fdaf-4c67-8d26-2b3b695eef37;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ContentBits=0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Enabled=true;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Method=Standard;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Name=General;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SetDate=2024-06-18T16:34:10Z;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SiteId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=agilent.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5430:EE_|IA1PR12MB9063:EE_
x-ms-office365-filtering-correlation-id: 5450f3d3-f830-44d1-c4d5-08dcabe7799e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?7C2Bza94WlYK0O6+o4LUQPFBm+Ut1DfBKlMZEqM8Jq0hxGhlpuOuWcHY0NaF?=
 =?us-ascii?Q?ia9U3WzlclL2NOB+04Acq6EDtdk3PoP1D5xBB23zoFW9O88TQFXm08cavpDZ?=
 =?us-ascii?Q?vjd6X024/9uAmRm78WkG6Q+aNAQh1BPqK2/wsqQ+dW08VZoHSVaCItKXbq1B?=
 =?us-ascii?Q?RHdQWnv9ggjk2WEUL2uJNNi4k6VvzCKrG7YlrBLeIbD4VXVDFxTp9uzHLnDg?=
 =?us-ascii?Q?/rL6Mq5OIfGWMqSL4kisBcVAA+MF4TIEWZ4Q7Up2MO32gt2uRmlTp6Z2wJcm?=
 =?us-ascii?Q?9oFT4nctb9XlyJxVybD2bm/5mL4X2HwAe2mC4HBt6y50JRVMzWb8zC72oKsY?=
 =?us-ascii?Q?imO5C/3vC/qFKGV0sCXZmMhGAu6RhAdGZKSnVtm5yD0gklouxJuxRSYhheG/?=
 =?us-ascii?Q?k4aGTi7xHPpoTl1gMLDGxFgFmo1BdUP30FzHpglCP7pgIvfyN/etyd9HO63T?=
 =?us-ascii?Q?0sA69fc2SiB8CGbJAHv+4c7q9ISoQKozWBPdm2X/i+jihfQWvroYvUB6HTax?=
 =?us-ascii?Q?IZ9Cl+8bsAXtnLN19O0t6diACEQqV2cMHKfkyIgtA1+Ki0V7yTP5i306MEED?=
 =?us-ascii?Q?6Rs4Q1ePNCSrrmKMDsctpENV2JSv9MKvO+vs5sos44VJ5+UgRvgNeTn2nJfo?=
 =?us-ascii?Q?7R/ipbKSzL9GnNFVZx36xwgKzqSZGiXEM1hHmfURLhbwHQrZAe3G1ICZ9BTt?=
 =?us-ascii?Q?6tC+V3Ci/VHTMFTaTJ9tRX805TGjtq0LuUanwzpKrAHJd8OlBFkQjh+plvfQ?=
 =?us-ascii?Q?ASv4jlKBsbf0++cEUj2LoExXCmKd1UYprm5c1pF+ye5+xpQfd75PbAjjQfEc?=
 =?us-ascii?Q?H2EhVU3egHz2xt45oB694+JdlbRcuN6fGFE+/wWbRsHq00v9Ka0NFvcx0Vt7?=
 =?us-ascii?Q?moSNQInuVwUVS8yIDLq7l6hej+UJMsjogipsoQCIBGDWYdCg+WWExnv8lFuv?=
 =?us-ascii?Q?JSZq/R3DRnA0gHi6pJwVlaIDoOGgDFpyEINfygPriPpXh0EB19TW3WKOL3v0?=
 =?us-ascii?Q?QvDXAqIXu+njzhk2u8qVMgd9QZuVdQnkFkGjDDaiIOlInwkNUzdA4lX3MG1R?=
 =?us-ascii?Q?7FxEtyJYQpobIwk9L0HKKSKHsAvR+DbZxb+szRefU7NS83WeWY/yrhGFK65U?=
 =?us-ascii?Q?JQzo8vTj9v8wt8+OSBFJLGmJUVLz/HcxYqzeCAyXdDpqPyyEGRmL0o7pLjwT?=
 =?us-ascii?Q?7kg9X/lYLyc/QDzDbBVAuOYqR1rp5DSVbrWZXfjN7szTCMDae94vnvCfQ+9e?=
 =?us-ascii?Q?+Duzo4rlIfgDGdT6PwZGsUpqmh4j/USnxYF3R9/DA57aWnbyXJoXbylaYdO3?=
 =?us-ascii?Q?K0iBqeQS9KA77DAxCLFB/VQbwQwFDGSICyVVDngcDwsxPycnoIBkt+gRYzEV?=
 =?us-ascii?Q?YRZdgrRhQxrbvctZKRpbXdfii8lQnCfHFgZQp0VR5ZqmcTgHSQ=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?SX9uCizz16pMqiqkSGTDGfIG6I6cCbm5zgqJydXztss1ldvY9vr2BjZ0ax2H?=
 =?us-ascii?Q?8pGF7XpKgVhD2PUNbF6Fcs2pYC4Z1p0AUb7sm8ITYp29ik50y/sGNqeclWRa?=
 =?us-ascii?Q?nqEuO8sLw6STWo7m4DIlerd9XrN75Bf6FLId6WKFy7BkiVYFd9QfXzQcGQnt?=
 =?us-ascii?Q?HHXiAL6SGz9ZylRtcLfdGy1rpXGA/3H05W9KHBRkVdpTF8+h5Hsx1QVnWPuI?=
 =?us-ascii?Q?7zF4+ZbiS7R8POTlLZIeCNkmuzI/wnksQK+bVqcFJHCzwgdu8Z85Mk3aDyuX?=
 =?us-ascii?Q?yXA8nGH3KExjKGkFO9FpQXYaCKS2wUWMQ3Twm4Fv0Aeab8glrulq8vJnTR/s?=
 =?us-ascii?Q?6DXWfE4gx56NbqjJnY5/hqtblEuYR+0pdHJbTc4dCLYv+W2rZR6PXYvsk9Ub?=
 =?us-ascii?Q?d3bvb4nxdFWrmX5H3DLLJtHPexOblvobY9fMqBYLWoBAyz7AXc9cj9IT3bt3?=
 =?us-ascii?Q?Jl+ziRrcLd+mKKfyYYoCw1b52NPRAk4VENjWsQx8YPIUW+AYsRWd58/h+Qvm?=
 =?us-ascii?Q?vOXBLZMutjk1NB48fo1EYoNIFiNk4SfoV/Fqlhn98uOuUnU98iVmNg/fX7Z/?=
 =?us-ascii?Q?gRpQ5XaatgVhOvs8Cai83HiUVjtWXoXlHqfl9p8IGqcZZyXJUEBGt0fPbMdm?=
 =?us-ascii?Q?D25B7bEkVe4vta/vk02NgNh128yPcDG6YQ9m8irPnUGJBhj2dgtYsXcceP6v?=
 =?us-ascii?Q?o0OGxoZuMdQJUhKMEj06QumyT+AiKAtjFzaj5yBtML1Oqy6tAcfmraGqomOx?=
 =?us-ascii?Q?XzpGwjileBmcAGWxIb/kfw1/CuT5GE1ZB4rzTm20il89cDciUP/p2NrCVpBb?=
 =?us-ascii?Q?4VBknt5xJ/rXaSJ32Op1bABNYRNAcSPH6nvFuFcvRgpj4tLmYRp0PjjXXy13?=
 =?us-ascii?Q?mPyE9C0CmgePKgS29UQIaI3O7ddgvK/MLZFpzz+8MXKUKqdDWsmAT78slTuI?=
 =?us-ascii?Q?/VRQQgAUYvjrIYSpX+hdAYB42iStfeGHBUD/c6e/+eT/u5gRVlVu1rHal082?=
 =?us-ascii?Q?pnNx2pvsxPenZBhCjUeKe4GXJpwy6VdAnU4twGVtrlsYDWpH8onkDV6OrA89?=
 =?us-ascii?Q?XPCyZdBj1/zlvNZ0EFk75yDcymxD5nKEl8dhUJ09Id8pQ8dRjzPv5s8W6DA5?=
 =?us-ascii?Q?My5uVy+PJjNFRP/2ZtUJaJQGKWEIhYpBnhPoiLeb9Gx1SVB2z4wONiW+cfUZ?=
 =?us-ascii?Q?8KDt+M9crTluXlx5Kq3AezIrJT1k7UoDlZRAIIeNvMb0QYVinC5GyocJC7+n?=
 =?us-ascii?Q?a3XDxrzrvpifWJE+Xqmu39WkBnkHWey8XDyydxX552RP400IOtLQAbToCk3C?=
 =?us-ascii?Q?jtQpKVAp7/ln0jSYm6xSoaxrhy3/aaMxpO5hfVwvI/Z4zL+d8DF8yKURqyfq?=
 =?us-ascii?Q?EWuME8EOCPwLNuIWKDhMRMlwNK6hrt1AGuylXyV5PQ5aDPlVZ7RuYezTcJQh?=
 =?us-ascii?Q?6OEhzyuVIVzotFZLwxJm3OA58kw6ye/XAhLKxo9NxkBZyb06vWwxYiWXLK3n?=
 =?us-ascii?Q?xkBSwamhP3EInHVHYkBm6DsOHjpcnpT67rSh5iIoJOE9XCv2AgTdi3ERCsdo?=
 =?us-ascii?Q?cNHyVRuHrypJ163sAbFhaiTvQX7ByR/x7Hn7pXAN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5450f3d3-f830-44d1-c4d5-08dcabe7799e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2024 13:49:44.5679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lrECyapXrjFmUkEyvH4QRuPrOKd1hT1PbVdD7bBw/QI5I+xzcJxLKlKWOA9CgS/4S4o9tWs/cNOQA3DQWUoBjbDguSqTppX6UDd0rj/b2Vw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9063
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 24 Jul 2024 13:50:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16435

Hi Peter,

> > I probably should have included a cover letter, but FYI the reason
> > this is RFC is that I'm unsure if we should disable the hyperlinking
> > in response to NO_COLOR being set. I'm leaning towards 'yes, it should
> disable'.
> >
> > Unfortunately there is no universal reliable way to detect if
> > hyperlinking is supported by the terminal (at least according to
> >
> https://nam12.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgist.
> github.com%2Fegmontkob%2Feb114294efbcd5adb1944c9f3cb5feda&data=3D
> 05%7C02%7Cchris.laplante%40agilent.com%7C3bd654f041734bd60ee508d
> cab4d8dc1%7Ca9c0bc098b46420693512ba12fb4a5c0%7C0%7C0%7C6385
> 73596794212235%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD
> AiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&s
> data=3DqFMRLWNPjXTL11pB%2Ft97P4CzJ4QRzBXcWS9AUnCXxcQ%3D&reserv
> ed=3D0).
> >
> > Thanks,
> > Chris
>=20
> I don't have anything to say about the link support as the terminal I use=
 does
> not support it, but I would very much like to have the support for listin=
g the
> log files integrated. I have added this patch to my two main build trees =
and it
> helps a lot to not have to go hunt for the log files when there is a buil=
d error.

Did you have to tweak the code to suppress printing the hyperlink ANSI code=
s, or did your terminal just gracefully ignore them?

The feedback is much appreciated, thanks!=20

Thanks,
Chris

