Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9345EC02198
	for <webhook@archiver.kernel.org>; Tue, 18 Feb 2025 14:33:21 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (NAM04-BN8-obe.outbound.protection.outlook.com [40.107.100.71])
 by mx.groups.io with SMTP id smtpd.web10.20778.1739889200837272478
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 18 Feb 2025 06:33:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=Btrks/3v;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.100.71, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yl9DrT1CPSE+xxmot0H6f4wKvbXcnoLWAMrlU6weux3qljaB0FSJlOww7JVbkqVCbNjmIKVonNSZsfkv8eN7D6vft/IwiF+bB1C5vLDZSnl7akXhg9ElusGfgmOumcbI/603paskpKR02thLiVp45szB+mtiPBRNHaF/YwQXdYej+RBbvboJLZNI4Meyc80ggeczJP+c9Qj3Vyz/Gtxv+D1CQQwMjEHjLBaW5Go3MaMJJIOE7XjmLVEA27aYLQwtj9kS16RMJRfwreoJ1vYMY5B/LBYbub0i+cH6YrfW3igqD0yrvCoyBLtwTvbL91TPR7JUB4SAvVpel8ipLMP2LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=myHS1KkEyTVxJe/iS0OeOu7BEMZLlxhuH+HD36l4L1M=;
 b=wele7Tb2bongs9eNSaxvuwS+2ZEr+A6sB3S+UFx5Y0e+HV8KLNkLSah/fLXfHp5qbtV+bV2hig/gCj1oO3pNqXzwmOJVil13T1STDRlW7WeN/7xbNDP5BvNK/QODphgOv3GwhZmJTGeMK8SMFK3ObkZvBTCDOfEOKKXp5O78etX+7KBjexXb2Fuhm2T/5i1j/C8fOQgEg7n13ZD7s+CH69eQy9O0cMcAQlZ4nEFvIBr/iToqhqt2OSDGb71Uv7pGvoIZJPOQCozjEWtDgmdh0GzydDwVnVmAO04k/NFDfyc5+HtHxFYU23a4OuvDnacsiQYzVgf8r72rWWkAEiDdGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=myHS1KkEyTVxJe/iS0OeOu7BEMZLlxhuH+HD36l4L1M=;
 b=Btrks/3viTaJpukSKziCQAtD02VURO134UV/AKE0aq2metWFilbRyAasZkXLhlf5ADpCjDfSIUlLCESOjyaoFfHakV+a6fCCWjmf1h07cHIcizNTZ0ldcahdvpDipVmo4b7Fk4dO+W1hYVCxrIJG0iwPJ0EDVBV2JJcd5MSJy/7aY1sH7n24wyH34ZXzDif+UVPJ/Qfom5I6SeK5begVu1kJ2idKXr15lam9UY80hU0PO2gf6/HMtauovxy+nQlwtuKwzNJH2uxcKHKBq3tyDkoBpXMNrme4q/jnqfEyEoV/8ZhB/E8NmzWSwbYZX5JDt7msymXYViRRmRzVYj5RUA==
Received: from DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) by
 DS0PR12MB7702.namprd12.prod.outlook.com (2603:10b6:8:130::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.19; Tue, 18 Feb 2025 14:33:18 +0000
Received: from DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::604e:bc05:9357:c7d7]) by DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::604e:bc05:9357:c7d7%5]) with mapi id 15.20.8445.016; Tue, 18 Feb 2025
 14:33:18 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: Ross Burton <Ross.Burton@arm.com>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH 2/2] knotty: report cache validity
 checking progress
Thread-Topic: [bitbake-devel] [PATCH 2/2] knotty: report cache validity
 checking progress
Thread-Index: AQHbfyVn3NnO8vYQ+kuGSEuEbln1cbNNEY+AgAAKm0CAAAhdgIAAAF1g
Date: Tue, 18 Feb 2025 14:33:18 +0000
Message-ID: 
 <DM8PR12MB54301F61945B1B237904EE658BFA2@DM8PR12MB5430.namprd12.prod.outlook.com>
References: <20250214211403.493573-1-chris.laplante@agilent.com>
 <20250214211403.493573-2-chris.laplante@agilent.com>
 <8E5BC146-29FF-418E-9B84-DD82B3076D4C@arm.com>
 <DM8PR12MB54306F77D39DB95F838AB7578BFA2@DM8PR12MB5430.namprd12.prod.outlook.com>
 <F81B3295-404B-45B4-A18E-D76E4E57EC62@arm.com>
In-Reply-To: <F81B3295-404B-45B4-A18E-D76E4E57EC62@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ActionId=a2c5b91a-3b14-493c-a68e-02853ad246d9;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ContentBits=0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Enabled=true;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Method=Standard;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Name=General;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SetDate=2025-02-18T14:30:00Z;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SiteId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=agilent.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5430:EE_|DS0PR12MB7702:EE_
x-ms-office365-filtering-correlation-id: 05193884-9490-401d-2907-08dd50292fd0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?DbK1seT8mpLgj1Mo1ha4a7AH74/iO1fZNMHz7BOLG6SxsIqP4dwMYJ1m4Nit?=
 =?us-ascii?Q?sDaaLI8SvuHO0iZzqoiH2XQYlIxJsfbnjr5c6mJV0jjt5wD8G6jj/Uo85oUX?=
 =?us-ascii?Q?7n3HB5mFtTrVMXjks5KT0YHSdTUSSPzPMH2cd4J7WU9NJSzJ5HNIFjH7yxwq?=
 =?us-ascii?Q?cFQ5Ng+J3pNJychf2DMQNU8hKKciwP6EOtDeEwNTl0u7pOLGufUv5+TRQk2+?=
 =?us-ascii?Q?XrSQTxlW16eYBVmhCt/FJiMpS4tXoel8DZsn3H/GRZo98sMvokqkO5Sbrn6/?=
 =?us-ascii?Q?o0R9V56zY0GrXCvOjxXjzrkc11Emk75JkB85iNkDY/E9u457qCZmyHYAqaVZ?=
 =?us-ascii?Q?y6zH7VnNYn4gKufPXdRtetQzNnq3DO/Vt543DBnwTlGo7szvpoOZTMs0sZAG?=
 =?us-ascii?Q?tQN5Rqk7CEVcZp93cHluvwT/RK0H5gSGd41LjpRNpCHJsumnVm05UvCnGAsK?=
 =?us-ascii?Q?PCSrfKI7EO5ose3aPSwPouT1GKIkEUtrKJK15kYe9LavXKEDz6KGjYV0YMzQ?=
 =?us-ascii?Q?62ZR8B2s8EWSdPdpCGRgOnMyYgSpn6mE7HJuKiC7AtpkFFRwQA8A2qdTJyrq?=
 =?us-ascii?Q?KK1VGiGL3aeRmQA3ng9Jue2ayAQET6qE5hZZbl8E0DRitNcf6+FUIsE7rMdj?=
 =?us-ascii?Q?Jruupw+jcOgakUndH/zsPANMIzOPctVd+KLHd/yCxLP2F7/5kwDSrt4pMWrj?=
 =?us-ascii?Q?E3ijHLTNKF8M7UCyy4IcGPKZ5aKXcSvSkRaMwxCRFFOCK0oDwwvgpPm/9y+D?=
 =?us-ascii?Q?rnQcjIe3POUxn8DAthYOj6BzK7QR/i21xpbU10BvoT3egj3322qYiKLvrO9C?=
 =?us-ascii?Q?p9ckzC0Om01Qlo/B7P7szao+vumN2V2T2JtzwmDPcJ8xAuSH00YC+c03D3kD?=
 =?us-ascii?Q?NbHE8pzfgWrprZJ1gd+awYl/mlW6TknDklRAu6U3pJLGIYanyBezftQGgZ6P?=
 =?us-ascii?Q?UaSfkNAj2poP5dNql/S5cAh8GTh96yY536hTSS8HtKckV6nwXWcXgFoAWl5n?=
 =?us-ascii?Q?PwhuE5XWor1RrGjRIdMrQlDFeCpH5/BeoeMvcrjPrOM5Y4VVFRBt3dJW+gqN?=
 =?us-ascii?Q?V0dBO9XCN/bjsj6kn+kaxXszhVDMn/hNlLqOqRIH4Sn/0o4tbBbSB8bpOk2x?=
 =?us-ascii?Q?UsJBuHJRWWyMimGeUeySCKQ+OLNt8l4h/FF8y/cxdXaQBGja3akA5zAQDS/N?=
 =?us-ascii?Q?am97PWLXXAo52uyR2d+m8WnovGy6bXW9+uWUsR/sZf3YExilhaTDRnpkgk49?=
 =?us-ascii?Q?rrbfMM2Q8+0UEUewDGJ5MAxnZoOnzuZePT6OeblSkzknXJSQrQ5maklrZTVc?=
 =?us-ascii?Q?RIT9z3AVUJ8NHPSafpDULV9Edqh28M2m8cntEwZdYX5B4ZKaX+tuzt2gtwR6?=
 =?us-ascii?Q?SXBT+EpSQPU8XTphGhHbk8qMNkuuZ8d/yy7mGuSxPdEj+5s9AoNiO8cLzOfk?=
 =?us-ascii?Q?Usk29bmhe3tacP7ntAvLqK308y7pAUo9?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?4zmogyFasK9c/hlJrFkvbZ1CPKni3B+vXH9FX09VvDIWa98EK/oErgqlyShR?=
 =?us-ascii?Q?VBIHoz3syJAI8nCPgBV6b+yKIa8ow2pPZYblIimI7zZGpO0rFykLbGQpF3N1?=
 =?us-ascii?Q?I0G6cxnT82PFJPzzsmgv2wJSn8CmYHWBdQPHJF8XQGlOHT6pR75uY+jEQJsH?=
 =?us-ascii?Q?Ytor0+ouMHQqH0Dxi++8RYm5VRqfO2O5w5Q7oGVExP/ekOWEUT9N+bDnBTYg?=
 =?us-ascii?Q?8Q/9AlT1MKFcfpgxTswEDnO2ZX+flKunIRr12vcx2R5bsGzt3kpkCFJdb5bC?=
 =?us-ascii?Q?+TAwKN2tHojrxc+olQOhapUs7pMzu2ZdP+9NHTp6xNds+M8QGn7eX/kyb6b2?=
 =?us-ascii?Q?IQYt5Xo8EiPCoKP9FZU4f3IXzBmJnmQLYWnSYfkT4Hj/G50oI8a9Mh5g54lt?=
 =?us-ascii?Q?BDru9/kPJZPaI+yB6Q1VSNX3i9vGuxiVKVpUvD5hTLIkWjnGQdlVHhgEtAVP?=
 =?us-ascii?Q?hhRQ8qksnmcqki4F3WbLubGv96vhqYEqwcMYQVtYUyiLCfQZMPHY4qF0tv8V?=
 =?us-ascii?Q?U51yJ7QO3C9mZgnhJ6FWtMdOI3fUtatOYDn4F5S6vq6NdaSTDNCFsyp/HfOl?=
 =?us-ascii?Q?XABTfYRwheKtXBuOHiDnmsHdIeTvxeCkHvzCrFEEUUA0o3toMUCrO7WtxzAO?=
 =?us-ascii?Q?kTRv+p9brdepD+YH/aTXe4hgmsYqcIWXzusIc7ZUoBD0B7OeypWPlnh0q01i?=
 =?us-ascii?Q?Y3YUB2f9MpORY++RowO4LljZxYItups7xfp45ceKM+uoszliBn+L7HTx520k?=
 =?us-ascii?Q?S6hr65y0gldK9NEE9ApQXfgkb2UCJHioipBitTsll6+B1Z3c0Xh22KSswRRR?=
 =?us-ascii?Q?/IHHj+xDzxvx7LtKYA7E8mrmir3CPU8/t4H2B2TdkrNHTv6sVYP8fcx8i/wp?=
 =?us-ascii?Q?0cx/dJ1Gw8en95iAE+2EiH07T08k5WDhEsAfEHFMBOT6bs7+ZYYrUV5vhv+5?=
 =?us-ascii?Q?Z67hwyiM1y2XR6QbJqBTjoHeqU8/o9DTGkLDXi/Im0VCOkjwcF19t0Kkid/g?=
 =?us-ascii?Q?XPIPcxF2Qi6OaW4nizQnow/QeZtSrPzz61tjEPAE91l3EARpMlW0u8vBLR93?=
 =?us-ascii?Q?0ZeSq5IGC6/BOsIe4dDxXO5vbZJQkNC4Bg+R0XByg692HHhC/pmXkPJoJaWd?=
 =?us-ascii?Q?RHTl4zDu31MNyEGPjxVlpQXhRkrNaLQG5FChazGChppUdnR5lKQwkomSM0tY?=
 =?us-ascii?Q?emLXKGvFX5OQv1hQEWcZV/sqxnN89rOZUROVejUXrzuiqQ+yBl9FaeFUV54d?=
 =?us-ascii?Q?RJd7pe40Nw3UxyesOrOEARMlWGgT9v8OXrIKPFJVFbqyhEhCz1ZKuYwgNyNg?=
 =?us-ascii?Q?Aj878R4NXzEaKUL/oJ99Mu9rK9ZzGS/+ITSNfh3UoVxYlxzQ0VPUtE50SXWI?=
 =?us-ascii?Q?2iVbTsZ0+VbpLoT09M7EJFa8y+ojDyng+3EbSI4GeT6nMx/ZAcy6jyDTOjE7?=
 =?us-ascii?Q?rv7pwGU3/L/JSeruOhYNcujLDwdPUkLc3rNYdB1fGMO6hu9ps00YRa8TvwTd?=
 =?us-ascii?Q?YFun9gCDerpsFhSnzRXqmD3ohFoFLPp4ac0SxLGM4ghBJQnpFlZYjnsp0Jzn?=
 =?us-ascii?Q?ztKtuuB9+2Jj2M6IuXrplbZ2tUS7vkEXYA6cYwIb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05193884-9490-401d-2907-08dd50292fd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 14:33:18.1971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kxBtCW4dEzEObylYrLFEjfYEoOCSUyztNv0v2xhTwcWB52pQIbVULgseKbvixYnS9+Tvsf1Ag85vGrzgIgzW9x75qjqq7VGB3u4CLP2ox/U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7702
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 18 Feb 2025 14:33:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17243

> On 18 Feb 2025, at 13:59, chris.laplante@agilent.com wrote:
> > Which multiple progress bars are you referring to? Do you mean the sepa=
rate
> progress bar for loading cache and checking cache validity? If that's the=
 case,
> then I agree and would be willing to combine them.
>=20
> Yes, that's right.

Understood - I'll play around with it.=20

Thanks,
Chris

