Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B16C021AA
	for <webhook@archiver.kernel.org>; Tue, 18 Feb 2025 13:59:41 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (NAM12-DM6-obe.outbound.protection.outlook.com [40.107.243.59])
 by mx.groups.io with SMTP id smtpd.web10.19961.1739887180243820100
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 18 Feb 2025 05:59:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=WRZO6xWK;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.243.59, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MKvcdUB3NKy1VUx3qGcoah1rSyZ9lbxb3QYmyuGDeerBdQ44eBr25IyqnazbqS8l8Qleu3rKQrkX/tKoT2ZcdFqc9CvpPV+8KspGA4LeRAzVR9s1g3Un923aham9y1XS7LWjWe2CQ/e8eClnwIDDObqFYAb25kfcy4HRFL4cO7g8SmOyyGq1AMT+9mEEwHBKHDZr/xewnxbYw3Cn2JUyaYoyCGdIz1lN4RET1AIKtoWLmof5Rct+YxqfpnoY4jS8Sp1FDPQeparO07BOxgRCy3bcncooJc061R28HQ/7AlHyG+TjSYKxyzfZ9rr89F5LWW/bVWpaibDR2ik1qs+nMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Djj4QFUs5gTM6d+2j6h10BdFxHV+8xomGaheM8k11nE=;
 b=BihVCM35fXO6O6vwHuGsnOkMgqnz7gam7RWNL7PPNryYXLMmCw7FD7jCe9TXQL0QzUecmniN4COs7hT9291K4oKAzO9drnn+hv2/y7qVNRGqNcrofsSQBx9UyR9RO907P9kjG5fo9thYFvIM23bbs8ShyrrsPqYekg387ysXn/6T2R4raZ/Q3AqpeTK9McUiIeEoTvxYGHj5rb49L26Bnn3+bka7DU5Zmuvhb4sKC1ObsgtVHZ6Husz20c+HKp2xbyv7AJtmZceM7pqNEptYnuQO9q0Dhlo4CHC64TIKzNp53HXe+Mzuw14lSL2DTTrbV5DDI1U5SWnoVEwQ7QyXvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Djj4QFUs5gTM6d+2j6h10BdFxHV+8xomGaheM8k11nE=;
 b=WRZO6xWK9RXGstDxAr1+WtWmWnhTSN4oNuFfRaPQGs9SI0bG6n8nc9HK6DTNCnPXAFn+2NbqOUdPTmX8H0qOw0kJS9D/MjXiVHqPzgkylQtT8sA1mov8pmfA/22kSD0zoKBo5ckWHMMhl1hZDILDzH1ZFRk2u6UxT2BJGtAheRxnZrFBjrg3pbdVFJaSI0aEqMM43LjVv7eXIXDeYslFKO/8WFGxaQh6Lbc4sOELKpPW+svoZqp7JDQnx2Ai0wNm0X86rbDirKQKT5nc6DoQi1drlIjhaLBK12sPfNrkX4tONQoz7lqgsIA4+++mocnG2fmfw12GoLT9kPQVzeuINA==
Received: from DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) by
 SJ0PR12MB6927.namprd12.prod.outlook.com (2603:10b6:a03:483::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 13:59:37 +0000
Received: from DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::604e:bc05:9357:c7d7]) by DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::604e:bc05:9357:c7d7%5]) with mapi id 15.20.8445.016; Tue, 18 Feb 2025
 13:59:37 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: Ross Burton <Ross.Burton@arm.com>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH 2/2] knotty: report cache validity
 checking progress
Thread-Topic: [bitbake-devel] [PATCH 2/2] knotty: report cache validity
 checking progress
Thread-Index: AQHbfyVn3NnO8vYQ+kuGSEuEbln1cbNNEY+AgAAKm0A=
Date: Tue, 18 Feb 2025 13:59:37 +0000
Message-ID: 
 <DM8PR12MB54306F77D39DB95F838AB7578BFA2@DM8PR12MB5430.namprd12.prod.outlook.com>
References: <20250214211403.493573-1-chris.laplante@agilent.com>
 <20250214211403.493573-2-chris.laplante@agilent.com>
 <8E5BC146-29FF-418E-9B84-DD82B3076D4C@arm.com>
In-Reply-To: <8E5BC146-29FF-418E-9B84-DD82B3076D4C@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ActionId=0ae89bf7-64a3-41bb-82ed-0b77a2cbcf05;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ContentBits=0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Enabled=true;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Method=Standard;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Name=General;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SetDate=2025-02-18T13:58:46Z;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SiteId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=agilent.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5430:EE_|SJ0PR12MB6927:EE_
x-ms-office365-filtering-correlation-id: d719d79a-5455-4d77-8a4e-08dd50247b4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?Xn/+EHxM4xBMlpVVhJXhCCoa1Xhecm2n67HLTj9hypjS8KtTnxXthrViVo6z?=
 =?us-ascii?Q?xzxPHdLs91DUvmSA8HB6nT8SaBDGC/tY1MKLzxTzrC2BI4m5LMwqBNsQtQJg?=
 =?us-ascii?Q?YAgMIRVyQ/HxuFIrYi70gioemv8ceYfobAInHB3rIn/2W/Us55MJZLIr7aZE?=
 =?us-ascii?Q?h/aP3xZW6e7Oy7gXlyREX1Y8/bfJu/eXfnWXqJzbjfaGeBsEoJNF5Ta1ulG5?=
 =?us-ascii?Q?MpPsYbXagclZ8hc5QtPlSYCRfLVz30jC/dhzevEXO/5/mjTeqPikBvo1ZYhq?=
 =?us-ascii?Q?xPqz/0df8E/1AITQcs0s/HkENXMj6muDd/IPKMq+PjbFvY+qvwrmxUhXNUAT?=
 =?us-ascii?Q?w7bqDeivjKppqxUa+l1RVAZ3ka5Qsv4wBjG+1DsxXKY0JhDD0ICZhDf1ANsn?=
 =?us-ascii?Q?4lyZesDrsU0UD/bhnKUjY9LTppvgRO7CZMQhGaT0MceALXc0QZGSpQykwkR2?=
 =?us-ascii?Q?oYAxtHBHY4Y476Gu59f7hQr3kcpJao7ge53+pLZIhII/3rHe1VbYPw2Pqg4t?=
 =?us-ascii?Q?F0ikWBkkYBzj8jm8gLkRLoFo1bSP3mzCWngmKnBXA0lmadW4+V97mTAuPG2G?=
 =?us-ascii?Q?BOI4Bsn3StCse2M10lL9KHCP4NsykIru/lcEfmkPqsViRfk0zEgyM3KWQ5Bn?=
 =?us-ascii?Q?kVz1E2qcPrKej2ghSl3okklaGtrKA1/xHgSfsZ6PE02JPMg3b0rQHkrnpM3G?=
 =?us-ascii?Q?N8fPZB8c4Izb+A/zmsr5xZX+pwu3m5VvA4nMvaUmRIdMSPFtFK7ELZKEPbp+?=
 =?us-ascii?Q?x7wwQulvbrvlzxgAklTJArBMDr3imjoMFKWEpQtLNdFWj6SXXr0ab/WHrJrk?=
 =?us-ascii?Q?FiUE5UVM9TossG4ezg2xaP12Psl1vrCduxQulO1Nch6+qIhEZfSrr4p5tOw2?=
 =?us-ascii?Q?TKXCt8sEwHRqNOWYvnltUklQ4tg0bbitpPVh6RPhGezRFEQ7+gXsruuGhANT?=
 =?us-ascii?Q?4Ptgp79GSyyUDQwNW47sYsu4xSR71FaHkSUm6Hb1vqSIvqlV37QZ9bmIHM0K?=
 =?us-ascii?Q?9QwgQ4AFTsYUbcViSMPJgSxMJz2+qDRWWiGv890t9owbY/pvQuwC37jYZT6J?=
 =?us-ascii?Q?ScPRgG2Zy8dSF9is3T/KXF9odL75iyMvAhBAL21IVRa3Atf5xt/PlIjMxfID?=
 =?us-ascii?Q?EQ4ty1dxkFPPBp5uOzyEItNqNqnxXKRt4Yp1Y+5BlV1tUHlLgmzlgHt/WFfr?=
 =?us-ascii?Q?Y1HoJV7OrRhkPXZk9TlN5qjAwFFp3awkfBjZOT2SORhJ9x20yqiSOO1FaxsY?=
 =?us-ascii?Q?Ujw77bORwqt3yKppMOcwV78+GVqzcaYRu1JbtnvbwVbvBr1uh8ouv7pP3KAe?=
 =?us-ascii?Q?xzExL4qObVoigOGbT5vMB9oJuLhkcCcFLEmnFObQubJ+omc4lKB9omDK7/Ne?=
 =?us-ascii?Q?XdkU/HbctOqxz4YRsNLMaO0WBnYhRNVAiUKoQXIHYwEgPCLIvT9veDCLCxqS?=
 =?us-ascii?Q?jO5W+YLb+ylebYilppZT/4AUVqEWs3VK?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?/3DdvzxgWdUgxLE/5EfO39OcJ7OZW/+XBN544CXYUgUmp4zVlZ7HCELZWGWd?=
 =?us-ascii?Q?6EFXoPZkWX3Z9bCMvwsvKDXqIb3kGJEEIc3M402tRFO2CYGk9GacHYoLHHzS?=
 =?us-ascii?Q?cHpnKq+eaBvsC2N7jj6Ixle3UnH8is5LIvISaazVf6Y4aG0rrAnlnebiScEB?=
 =?us-ascii?Q?tx8joJ331dClTswDo0yFyCtPXErEY5+dr6va7FG3J7R5LZpsyIAsgK23bCF3?=
 =?us-ascii?Q?hoQJ+r9MTGloK8hrbNT5QJfGfvcmESjDsj2ryRX2k47/WOJaZNPB+MKiBWc5?=
 =?us-ascii?Q?SEr90IyfZSk6w1OsGBpSjWZAdAsEjmnminu62msYoF6P9dikijkpcoHWYKK+?=
 =?us-ascii?Q?Mwsy3vIuorfnYI8LUklDUWSakC0QYb9aCXVlKHBwmdfbjGXgVMqbC6n2+NWp?=
 =?us-ascii?Q?K9y+BIwaDsENjUuprjjjh08DY/XWkdrt0qG/9MsxmSiFPq1A2IyhLoqPAZ+r?=
 =?us-ascii?Q?YH0hL0+xivvP+kgt+CGiKxJWYfrPvxf+T07cCOrso9JODUyHoifThBRDQJ3D?=
 =?us-ascii?Q?soAg/x2k4LvuncECix/bT0EwhX8zMo7ylVsDdsRG8sq8P/oXUr0Ff/zbOm0z?=
 =?us-ascii?Q?rKnGIFLeKhy8ZpsCrkVMNTNFI8uBMLxDqy1qpLKsJdQF46RoDSFqJarDqbqv?=
 =?us-ascii?Q?0f5273kYc3iog4naZUtsuFN8wer4bo9YDoyIUhr1duR9lN7/p/nrYWeofY4h?=
 =?us-ascii?Q?1pbElv/NHSDMHrqQL5WUuCAWsQT0fP52Z5WB3SGSpU8bFH2pFaV87lBx+mU5?=
 =?us-ascii?Q?USHeOQjCX+mIJOjo7JHWcqQrtU2U1uFU/Wd6MJf0q1Mj+X4iZ1j8KiwLtrpm?=
 =?us-ascii?Q?STqVJIHTE+tmvtksI191Zi5XhONUAcjSF7skxsKw1puc1ubVyTVpR+G8NdLU?=
 =?us-ascii?Q?biAQD4wspuqNj7OnhtfqROxkyzQmoPuuD6lYji66qjeLhypcQE6zXhMoIRvf?=
 =?us-ascii?Q?dRRqF70OgZKWWabPLYb3Kev71PtZzrqFke7tyBdgJbwAOPJjkyEUDTyl1bda?=
 =?us-ascii?Q?+yOIr6o89Ve24kXn1BpK+wFspYBPzbVParHKGggfs22glnSzUU2u9l0NTTo5?=
 =?us-ascii?Q?gckSTd45NVsgFYuHleZPWxVEEtrEuBWn1fZ76uc2exl/U09QqEvZQ7YC4P07?=
 =?us-ascii?Q?mrBFsoAW+RDZ6i/swnU167RFoYOl+vbx//D/0KIMrb1qD9FJRPrtQPAXpTzU?=
 =?us-ascii?Q?M/p+Fs96d8M4IMyShi8M6Sor0eVZU6pvZi8Zm5T3/uNopNCejeziT0Pu3Zg6?=
 =?us-ascii?Q?bRRfr3jNcBS4ZP6N4qQM6UIOmOjyS6uSLI4VbwPIrRQecgfhpKbNHdmR0o4Y?=
 =?us-ascii?Q?e70i0inlNLDLZgAvb9yevK+IxMjr7cwn8lnloephC/acrmzisgI8QdAnHvcK?=
 =?us-ascii?Q?zozl3V7kjV5nfZCuFo6IcHHH3AlXv22zjRztnbctrkFIAvxZzIiuarhyDlTH?=
 =?us-ascii?Q?6cAZ9er2L5sT9cHllAMuhsHZdj0W7GM7//DGxLXtaWCyD2nRtjfKX6EkW6uu?=
 =?us-ascii?Q?qwPafgFgZoNdu1lDjUcednsFhP6NIyGBbWjYZm0f9HRRUFKhMp1YCwOtR1gq?=
 =?us-ascii?Q?OJN3zereJD6uv+tU+24YuG1R8CHfm4/vz4Sn7tQG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d719d79a-5455-4d77-8a4e-08dd50247b4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 13:59:37.3746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NaReR65IDhvFpQbzvWH1H3UN+l67R6GpINbaaT9iIvC2ZOKPO/iPKlKgTmLGKg5k+T/xzELjpNQ2fhPYjQNoHEd2zqMJvo4Gf46cfB4f8pc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6927
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 18 Feb 2025 13:59:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17240

Hi Ross,

> On 14 Feb 2025, at 21:14, Chris Laplante via lists.openembedded.org
> <chris.laplante=3Dagilent.com@lists.openembedded.org> wrote:
> > +            if isinstance(event, bb.event.CheckCacheValidityStarted):
> > +                if params.options.quiet > 1:
> > +                    continue
> > +                cacheprogress =3D new_progress("Checking cache validit=
y",
> event.total).start()
> > +                continue
> > +
> > +            if isinstance(event, bb.event.CheckCacheValidityProgress):
> > +                if params.options.quiet > 1:
> > +                    continue
> > +                cacheprogress.update(event.current)
> > +                continue
> > +
> > +            if isinstance(event, bb.event.CheckCacheValidityCompleted)=
:
> > +                if params.options.quiet > 1:
> > +                    continue
> > +                cacheprogress.finish()
> > +                if params.options.quiet =3D=3D 0:
> > +                    print(f"Checked {event.total:d} cache entries for =
validity.")
> > +                continue
> > +
>=20
> Multiple progress bars are quite a strong dark pattern: if you don't know=
 how
> many progress bars there are then there's nothing to be gained by seeing
> progress bar after progress bar.
>=20
> Personally I'd prefer it if these were collapsed into a single bar that h=
ad hidden
> internal divisions.  Yes, it would be bursty, but at least it would start=
 at 0% and
> end at 100%.

Which multiple progress bars are you referring to? Do you mean the separate=
 progress bar for loading cache and checking cache validity? If that's the =
case, then I agree and would be willing to combine them.

Thanks,
Chris

