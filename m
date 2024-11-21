Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A05D7879D
	for <webhook@archiver.kernel.org>; Thu, 21 Nov 2024 17:30:29 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (NAM02-SN1-obe.outbound.protection.outlook.com [40.107.96.81])
 by mx.groups.io with SMTP id smtpd.web10.4238.1732210219546881533
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 21 Nov 2024 09:30:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=p6ZxeWlg;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.96.81, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hoHxcsllerOaaWcAvpspETSmnogYfsMRTyMvvDqf2ZmZIIBRJ4dOHdtc0vt/GGYL8BOUDf5WXoK5aaVy87OGpdb37JdHWqFk01Xii/Sb/q9t/4Ow99M3ciRXClRZk/pt6cpv/6i2Nip9yK273iEly7Gsl6qzfQ1/Y7hgVgiSB44FnVU9GTUv86aqUWHgLQJSmMgTZEqECQ9HyYWDDgLW8f9mvvuPZreM5udKSQO/hosuKn5aclu8LtctWzgAdN1pYODoJzqxpM1MQQhGqBm5S59cc7Xfzlx/u2qOx3KypoY8jw0gsukTX8+vXrHk3GWDrTWgb5ysh9EWeaFLFeGh1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OwvLHZyPqk913WtBj9p9oFBE1YW5YzgRcDhy8p64I7g=;
 b=AdZZnJZ4jewpruKqNOV9qVJhdlJdg8/RlnvQHAP5RoW19frX1iRqmDY6jYiKWbZ/9d0/LQfGbL0clBBWBrF27h3ObcOeRaNNrqKYVFHxnwf56zwVSrxlw6/am4KwIDkjekTuTgZ3SwFvhXbN1MNlf+fBkCqFdWRpjvb3nA8vepauezmYl3fWy0hqza5CWAGKWcIXZm3676aynlDm0HsxIQs2wbrYZTAR11ru1MDSiT3vmEW+PPIvjckWuF069UQd4j9QOGK+jUDIzHqUeKdFQ5uwcjd78Mhc7vjggMUaRNLlcIbEBqUvrzIS5aeGZ2N00JuwgjH4MAHeZsaTNXdh5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OwvLHZyPqk913WtBj9p9oFBE1YW5YzgRcDhy8p64I7g=;
 b=p6ZxeWlgij4KEugwqMUuzfq8MRFcCFyanjYrh383pnFRDUXxJNSNST3n41j6kPVA1CcIcHl+vD40Dy3jLuPxyfqO+HvW3f8lghzzprk9p5P+UUpyiFOBwEdWGsMY42+TTeGUW6dB2btgXmU6NkdcbgV8rAe0LMvKXx8C8kqrPqPG46m0XtKqX15OOBbMmA9GAeCyB2RK8i/D88a1ncZXq5Ty24ZAxjKZHMKdL+SCYsx+09au4tXrTPGXyi8khWDuZZbhVJTLYe/zKDKkyBuw7HJCDPduXZvFxguUL1s8HHu9VApXKm28sceNIkD8M9zZBMrxm4uAF0S7n8gWmDV6ig==
Received: from DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) by
 SA3PR12MB7784.namprd12.prod.outlook.com (2603:10b6:806:317::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.25; Thu, 21 Nov
 2024 17:30:13 +0000
Received: from DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::604e:bc05:9357:c7d7]) by DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::604e:bc05:9357:c7d7%5]) with mapi id 15.20.8182.016; Thu, 21 Nov 2024
 17:30:07 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: "richard.purdie@linuxfoundation.org" <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
CC: "steve@sakoman.com" <steve@sakoman.com>
Subject: RE: [bitbake-devel] [PATCH 3/8] checksum/fetch2: Switch from
 persist_data to a standard cache file
Thread-Topic: [bitbake-devel] [PATCH 3/8] checksum/fetch2: Switch from
 persist_data to a standard cache file
Thread-Index: AQHbGX65WALcs3wjNUOGQEjavFXHBLK/znQwgAD1tICAAX2WgA==
Date: Thu, 21 Nov 2024 17:30:06 +0000
Message-ID: 
 <DM8PR12MB5430E29DAE622F328269C0E48B222@DM8PR12MB5430.namprd12.prod.outlook.com>
References: <20241008123627.252307-1-richard.purdie@linuxfoundation.org>
	 <20241008123627.252307-3-richard.purdie@linuxfoundation.org>
	 <DM8PR12MB5430F82E66A733A5687F5FB78B212@DM8PR12MB5430.namprd12.prod.outlook.com>
 <e7fcf2110ae769882a989d104e92bb7291245a6a.camel@linuxfoundation.org>
In-Reply-To: 
 <e7fcf2110ae769882a989d104e92bb7291245a6a.camel@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ActionId=c04fc1bb-4044-4103-aba5-ce0e3024ca7d;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ContentBits=0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Enabled=true;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Method=Standard;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Name=General;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SetDate=2024-11-21T17:25:32Z;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SiteId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=agilent.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5430:EE_|SA3PR12MB7784:EE_
x-ms-office365-filtering-correlation-id: a215d817-e2a8-4d73-f3bc-08dd0a52246e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?NaEl9wdFU5syvLeTyfQ23N2sZhW73CSaoLQHBNT4RMXPpEmDXwBbktMNkNzH?=
 =?us-ascii?Q?3f4U5cRtaEv4h7LU0+0qqxednU4rcuuN8516WNeHsi+M/r5pqnMN/f0gWjrs?=
 =?us-ascii?Q?8AtcF7HyxNnBpilkxjMvRRiUOfLMXwa13Z94TplyR9ZMnKS/QgZLXsZKeN7N?=
 =?us-ascii?Q?FOGDx+FCNbpkNPNTpCWjR57DAYQGYpTrzaFmiQ201UhcJFVRZO4VY3rQP4kr?=
 =?us-ascii?Q?sPuHOBAKVXLewvLRdTSLWCpytYsNSTAHqsfFznfE8kJ+8MDQ8TjrBCWfXX9b?=
 =?us-ascii?Q?5tPyvupD7OAm/ipSmh4AGdzwEkFW+PcGbnzcYCUX10LVfAtpBoh7oVgXuX89?=
 =?us-ascii?Q?JYEZY3FuQMSnjprmJW+HTQd9BMHUAf5N2srUC3QQ4WgX/FbYN4YAVILmS854?=
 =?us-ascii?Q?5OIbd4ZxjKjGK2VUDTpDhYm82IqNIi+czrg/yk7t0yPCTTQXfRw3b+OCobq1?=
 =?us-ascii?Q?fdLR9zzdZazedkW3ca4/5Ahg5/cWonOjSVeiTyDqDzwUXTkcPa9s50Sn4Xab?=
 =?us-ascii?Q?Gp+FqV5tJODiW4Rqtbi3FZm0GhAZih2fowsx/qwhqTGbHyrioN93pouiGKbQ?=
 =?us-ascii?Q?4kzwMbFavLvYa/lzgSAfstLaMojDst+e/2ULhKWOzxUl5P8Jg/Gpna+cG1ES?=
 =?us-ascii?Q?/Jg4tRYEwVneJEG2Nn9FhrrxlyLwR8/icZYexP6EDBIIy8eXXtvUWFqxb/br?=
 =?us-ascii?Q?vzyUDWCnnFy+FUEh7N7x4p681poZkuPUKy4GuexcHECYEo0g4KOOlhbo6tyN?=
 =?us-ascii?Q?/o5ljOQqK/ZAIXhKtStcoN0aLDZLOX7VOGdq84dWZX1SXJQlGSIuU6PrzGiu?=
 =?us-ascii?Q?K59+99h0YxtJDnWGtZHIgUL0DRkF13qqR5gnqZES6OZBESjQHuQah4JCGs2q?=
 =?us-ascii?Q?tXlLXLWwrwZV+cKgztl9PkkI2yiad86v8yA/t5554vdIr61sJQofIQ0mAvXO?=
 =?us-ascii?Q?PSD0iMVHO8pf/+SPjsjw81lgxF1Y+nd+F++g5zVgcX3TDGXCJvWL6J3JqsQc?=
 =?us-ascii?Q?iApYBV4YmezOpPVEOu2KE2KqvQzlw7Qn82KoMHbNdmcefMsibD59hniNuzJz?=
 =?us-ascii?Q?nribI2tot1Q4WNpU5VbJHyIO5qEJLS/btOvPqrp4D996U2Nz6KC1xN8IYkeh?=
 =?us-ascii?Q?GDEk7OG8Mdb17PdVf0ya8yJENUM1KBJjuwTgFlDTBkuA5foaOIezyZmxnUPT?=
 =?us-ascii?Q?3wU7qG97gV0NkMXOOtPdIXr1f0wipWnWf08NCqElsFEZ8/GYgR0mKd51ywr3?=
 =?us-ascii?Q?4G+vd5rTYzoDx+pZc0BDkTj3h5dW7WO4ZIMI5YD9SjMISUceffSDz0nrW2NP?=
 =?us-ascii?Q?UeEBTKk6XM0ErZAq6eSm396h?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?X7ULZ8DC3ypE8oPgNbBvhY1t78cYLaDlwUQmxVWdOD+1m7KZOt4E3tpx+oB3?=
 =?us-ascii?Q?TkN5WwjOH4/emV7uXc/Mim76CRP5ttZN+bfWcekWrXogPxBTtSL7MZMqYNU5?=
 =?us-ascii?Q?Yyh1JhUSXyoN1zm0ghGYjneaXeYe0TF2UZR3O+O9N9B9QbTZSastRa5pSTSL?=
 =?us-ascii?Q?bTmL3yLnv/xAXS5fKRVysIyUtJ0+rUe4WbAVM62pjziDmFG8Ps37pqoJ37CS?=
 =?us-ascii?Q?HSZ5hEEoC449ISLCon2OpshF8jYaII/cutzKpZ+pw2pHbkSlCBj/LhI3Z46u?=
 =?us-ascii?Q?2ZMCRCpSq9JJ35WI66b18hUCJd/2QjmJQbTWcV9tPC6qCZ+IuFO+Y9l5EGTZ?=
 =?us-ascii?Q?24MlfVJKHDOA0J/naXfqtG97bP8k+7LLZ/sn1n+lazfM6z0cVIUUVtaPGw9u?=
 =?us-ascii?Q?12eQpZWYgUe7FZV5Oc1qCpLSxEItkKqkhRNiKvEpYsNjRVxlsfzRvAeULkSw?=
 =?us-ascii?Q?zSed5PGo5nt9OHGjTO3robvRYVoFZ/niWAopLJAKeMoxH4H1FnADl4ZLU9uB?=
 =?us-ascii?Q?llsq1Gn1sOG/taMQVEFdIO9d3qh10d9L/JRLCQsm/T9Ml1FqVFoZPW0Cayv2?=
 =?us-ascii?Q?2mm26EJRjUtGDoV6I3Bnb8Y3YvY42AHt7TR0MIkoOWL9qFx5kAK3wOMrGFMT?=
 =?us-ascii?Q?8ChMBNnrf3cjHbZrzptRjzCxOuU1uoK9qss1QRHNcL8QKk9p4jaKdJYuGCjB?=
 =?us-ascii?Q?XZ1DJRXa9cj0AZmjrO+GFMMpwWxhoiDVTIm0i8/n+3EIL5yHO0aVbtKKR/Oj?=
 =?us-ascii?Q?fZx8eVR2+Cu7BNmTeBXLM/6uV+7A3TEuvCVHUlF8nohhyDaPXauc752AooGj?=
 =?us-ascii?Q?Q8kR2nnu4uthKs/bmLa3Qk8IeUW0OfxGHH+I9Jjz1WUq6NKslM1+im2SyChM?=
 =?us-ascii?Q?9zgYOj0RLIlIGcxlV4SmzbzwOjMF7Q24GGJB1A2sGgHEjXUfkeswrCPmgICg?=
 =?us-ascii?Q?+eX5oo4R0qjBfPApTJwhDQ2AkmUYcNLQVPIFlO2X+KOY+jxLkNRSEWJIll37?=
 =?us-ascii?Q?Du6W0c89sGcRCyRJh3ZqxLDfittQz39vj4gXDZb8+iGMkTDI2QJ4MsH8p+LX?=
 =?us-ascii?Q?OOR1O2rGOC9JpnolZ46pbKSZD1i62h+TheHvVijaB3haYpiBM2uyRkCOPviD?=
 =?us-ascii?Q?QCJM2cqNXyXFZ55gUIxshlB5DLqAWQ7H+/GW0kxa/tDepqnDrX+da35y0UDk?=
 =?us-ascii?Q?hKq9LfjCDr8MJSCPEXxcp2hAGfq1UwTmmuhrM+mIhImWlKVfk+r76fcljQqR?=
 =?us-ascii?Q?GF5wCP9zYN9enRdZI+8u+LnGJY+RlGUUFScV/eOd1fVXUX3xY6ChUxkqhWhz?=
 =?us-ascii?Q?Uy87k82B0qO8xSjuK8wdSQbcDBksTjLGsfR4MdTKUAky7zmkg4P378yiaxFB?=
 =?us-ascii?Q?HcuHrpazKY0SSy5DPKIkho5LOGEZS66Y7m2f0uK+e/odA4XSHRVbUM7Wogsl?=
 =?us-ascii?Q?W85w6OM8X/7+zC7Hgls5FTHB27PO2lVdaAocoNVICNHaFc83NhekYiR7UDbl?=
 =?us-ascii?Q?s/iTGquUaXEXBrjqCehP5fpy6og2TyhExY9mkBcDMDlqU7z02P0k7L7v7fIA?=
 =?us-ascii?Q?bp8vQfSqU/XUcESyZalPwVIvEftqLqr9VfIeXPqU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a215d817-e2a8-4d73-f3bc-08dd0a52246e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2024 17:30:07.0749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: McDDg1huzbj2eo8kJEP/6uXs86LYefCpCMU6BSFmnfLnkQdluPzrjMMdmGHErMoKut9T3z/BBM1uL8EElTb5GNwOwFoAn3/8GDj3H7AahVc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7784
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 21 Nov 2024 17:30:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16823

Hi Richard,

> > I was wondering if you or Steve would be interested in a patch for
> > this to apply to Scarthgap. If so, I'd be happy to send one in.
>=20
> I think scarthgap and older users would probably appreciate having this f=
ixed so
> I'd be willing to take a patch.

OK, will do!=20

Question about sending the patches though: I don't think there are stable r=
elease branches for BitBake, so do I just send the patches to oe-core with =
the 'bitbake/' path and 'bitbake: ' commit message prefixes?  (With the [sc=
arthgap] subject prefix, of course)

And if so, do you want me to update the stable release section in the manua=
l to mention this? https://docs.yoctoproject.org/contributor-guide/submit-c=
hanges.html#submitting-changes-to-stable-release-branches

Thanks,
Chris

