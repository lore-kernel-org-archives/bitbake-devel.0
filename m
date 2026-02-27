Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D696FD7F95
	for <webhook@archiver.kernel.org>; Fri, 27 Feb 2026 11:08:41 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.23])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.93473.1772190516107691348
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 27 Feb 2026 03:08:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=bl8XNMNe;
 spf=pass (domain: cherry.de, ip: 52.101.84.23, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bKVmM2vOm7lrYrgv5q58qBi5MXo9LL0UBAfGAAJMOSzAxg/hpGO+dOFAG+cFjD3iAu7elBrHzo08sJ+wPxvlXGinntTYeZ1C1jzFxTS+tn8qHbJ+mVuFtZDuLnUt0MvOhB5+IrybPQvTsPqgwEv883EdURVbG4B6aJycxhEn5g5Od+35+4JyTts+dLcUxwEpjasVxMYbVBtx/6MT7iYvBo/kdCXo89sEG0Pza0uTHYPdIiUzO1plfdOb55S5Tgxx9I+ww2MnXD5KoDpS2BGSYT/QjlLOkrxtAXyWYatoMUa1FAuXT2NiXDQgowZho2R+MyMBaHgHZ/0WK3BxxrzLiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5C8YYRzJkpxCVg5Xfm2ez9Z5pUGgD8ETCLZdqZ6ObM=;
 b=AT8CvbNAv81ux7DcSxZ7phYsoNs8vOhJbIu71Bc/AKfZ5sk+ScSFLmHnuUfz9fma/rvSaWR+OZMuRNjNzuYnSjvFqlNluo55qUn/qt27si5X2xZ/sfPS5tReiXeYx0CyXO49noANgqLjv5JHWBVDPI1U1J+BPJbUp6bGfebQ9k7ETMGoo7823/Qdh8w0+5oh4b/TEDbUHRxa/49X9R89MfAz9FXSbryzhWM2anhlzNJe8qNv2tbsuamsnoUrnBBHHWlB/ARFKh6RlLpiDbHW8x5CTHDowxk0lW/XBQti16I+6ZzJ0fTr7zrkPyXygum/+f3PLXukty8mHaUZ5+hS2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5C8YYRzJkpxCVg5Xfm2ez9Z5pUGgD8ETCLZdqZ6ObM=;
 b=bl8XNMNelu35/ZA0XsVKWAcf2CJNYnYilAa1SJUBYRx17utuod00XS4XApparIiuuT1O7ogOTcyUTUlg/LvacoifPAT2gESFwTMik3cu6ZYq1dqxT5E5e5QpoNxNJ+NxhIrK9uxnREk6kDjKsGFzfjaHprcyktmLHK7DxBV3rW4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by VI0PR04MB11483.eurprd04.prod.outlook.com (2603:10a6:800:2cb::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 11:08:32 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%5]) with mapi id 15.20.9654.013; Fri, 27 Feb 2026
 11:08:31 +0000
Message-ID: <74e96311-22d6-42e0-91b7-2b22a0f6fc4c@cherry.de>
Date: Fri, 27 Feb 2026 12:07:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] Should the BB manual have a comprehensive
 reference for handler event masks?
To: rpjday@crashcourse.ca, YP docs mailing list <docs@lists.yoctoproject.org>
Cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
References: <d6529c1a-8b4a-d5e6-d8df-ef5fe27fe74d@crashcourse.ca>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <d6529c1a-8b4a-d5e6-d8df-ef5fe27fe74d@crashcourse.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: FR3P281CA0167.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::6) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|VI0PR04MB11483:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c756065-24e9-466f-662d-08de75f08af5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	Fg3/x8dMpSQFFXWDsLTjCLKKyUNwuC4mlVdsD78eblKvjKzDkbvcLuGNkfUTg3I0Y/6i4HoI5Qceyeg+JwwHKqbemfqrHwyrLRlZHk/CEBs2iBSvSZkwfv39vbSM/5uLySlA9dZnKNlPvX2JHpQn1eZpw6zyEvexoRhw+lqECxupakcemXPQYvDYMk3rVpH/aGxQODzYKN3HpiCXs6eLD/NZsRsSW0x2ffkYe5UNe6B7SLR6iC0YM8ldbTYihc/dI5Qouhhs+rmhoIFDqTGuzOjNMdtRZhWu4I9AzsOD/cWZweTS1tktPNUXmOEGlucnz3rEKwjedtKyDiO38obyYFPqlytBeUuk4sAT0I3TCOT6yrffIQOkjhwfTFLTwhJ+xSntnBuOc0tq75UooUCrVeBVpeF58ZwgT+VfxT86cnwiCq1aJQDY6rCQtoWbS5akiK49paionvQ6LQhJsjw6ra/Zawo0xrdj7sCmPinkT68LgvBkwCxMXsayHO38O+8hXzcpVs72HfUMICQ4UJqooF8c7HIiFtVmIkUQEfQjWJCGqO3Y9YpEjXJvyOV809eVjWEQ9H5P3YBqTBiLGpYRRhdpax90MVsjw52dMXemglpreMpWVdDE/KqSbtyKmR1T1k8+DDjDxIeFQr8ORqAMjM/hFTjc2CNmGmpzvpbMwv4bbRVwRmL8DAtHeEnuCyeS
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12038.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QXp0d09BbE5VZDRFTmo2aU9LSHlBV0NNNWhCaTBTZldOQWtXSWdNMDB4YmpQ?=
 =?utf-8?B?UG9PN1lPMjNPekdhcUZ1UzQxYUJtQlFRd2Fhc2xaUHlRRXBIczh2WlFXWFZ6?=
 =?utf-8?B?SFh0WlF6MjA1K1M5OTVOMkJtcG9ESm5PcHVvUnhFUlZJL1lKdmpwVEI4cG5q?=
 =?utf-8?B?OWJDWGRBQ05xV05TOWRtZ1BOVm9aUW5odVpueVlCZ2tjMWp4Q1BpVFNteFp2?=
 =?utf-8?B?NU5aN3JpVElWTEExWWFOcHlFVFZvM3F4andYbkh4YWZaZ1gycFoyaHpxSGhM?=
 =?utf-8?B?Z2REczNQWW5WamF5WjNVZHc1T1NXeGdBUXg5ZEFTY2hQM0E2cnBnZnkxaHVj?=
 =?utf-8?B?VmsrZk53U1lJUUxnVEFES09IbTlQRjdxejZzZVdlWW9qNGRxVnJvdWlaSVhD?=
 =?utf-8?B?K1lVdjBSQ3RpeWRjTHRDR1M2QmRMZVJZamlZV3V3Z05YMDV0ZjhqMlRjeDMx?=
 =?utf-8?B?RUdDc2FpUXlseDA2RllWSkQ0YjNUdGFLa0gyYTY2QVNHYVg5MU0xV0thRVR2?=
 =?utf-8?B?QWdOd0lrSG1UcmY1MHdra01hS2dTVEhZU2RlV1B6ek1ZRzhsYk9NaVVaVTBi?=
 =?utf-8?B?RkJoMVQ0cnlsMnUzaDNiamRnb1J3TWZxdlNRbUxtNHRsVEw1VmxrYWk1ZWpL?=
 =?utf-8?B?SGNDWDlNcndHRWdYVWdNWW9RZ3pnc2k3OEt5dy9yWE5xd1pDLzh0aStHZW5v?=
 =?utf-8?B?d3dRejBta2NVVVhDdjVtTEszcCtnRHpqYTgrdzJXOTI2N1o5QldWRzl0NW1s?=
 =?utf-8?B?R2NBOWRjWUxMNC9Dam1Qczl0YzMweURvTng1bDVkQXdaL1FpYU1DK0xwRnFl?=
 =?utf-8?B?MEVKRG9lK2tvbUV4TE1lVzN4cFZxT00ycDRiMXIzeEY3blB2bWN4ano5TXBK?=
 =?utf-8?B?YzNhSzdiWWVLc3h4ZVpmTTRkSWZpblBWcWpFYnd6TjhENmJTeU1TUms4TXZ1?=
 =?utf-8?B?dkNRQ3g0VEdGS1M0R1NMNy9pNFUzTmZpT1RCKzl6NTZOR2FacWYyM1ZlVmxi?=
 =?utf-8?B?YjhERVh4b0kxcVpvaDQvWW1SVC9HUStrTHQwNEt6amV3QlZCcW9iRHZFWEpn?=
 =?utf-8?B?eStxa3R1SSswV0pJSE4xb3BTSnJwVWFhampEZTA3YUFEM0tXM2liTnFEM1My?=
 =?utf-8?B?anZDTC9vbVcvcjl0Q0h2SFJkdDZCN0xBK2dCdHdMTzZPdWxSbGF4SE5WWUcw?=
 =?utf-8?B?WEd5andTdXBKckNJdkpONEJEUXN3U3NBSUxOQkFRWlEvN1RHMkNxSjF0ZGV0?=
 =?utf-8?B?dk5Cd1N1NnU1dThZM2RybXUyTFQrK3BKQzFaVlU3aG95R1IvdDFTb2wxRE1k?=
 =?utf-8?B?dGpET1lrc0N3NmdzWjRQMkZTc2ViclFPbFZ3YmYvZGxOY3ZqNFVCbzNtbFI4?=
 =?utf-8?B?Sk5MT21hTFlKbVQ1NlpiM1JHME5DTVZycFpuMHRPbkdKNmUreHM2dVY4Nkl3?=
 =?utf-8?B?VGFVNWY5cW1uNzU1N1VlYVlzR2hrZ3FFSjRDalJkWUd4VnNMVEl2ZVFTa0ZW?=
 =?utf-8?B?UlBNb2RvN2Q2T29lVWJYM3hMVWorbmN1ak4rQkhpS1h5WFdWK1dRNVlyaHpZ?=
 =?utf-8?B?UVppUWZWRDRwMThJN29OejZydnNvWVNyL1hiaU1nT1J0aGIwUTFiUTNQTDBQ?=
 =?utf-8?B?K3d3QTM5NmMvdmVMWVdNU3BoSEhtNU1OcVFSZkFwTzdzYVZCd2pTOGtRTmVu?=
 =?utf-8?B?TXFBbkREcThkMjhGdVpzZi85cnlwTDZlSDByamtIeHhSYVpBTnY0a2NLVm03?=
 =?utf-8?B?OUJXOGpFbEVpQmQrOWNXSXRzR0FBZW5Qblk4NlVMMzZQVFpsWVBoSDVvUFND?=
 =?utf-8?B?dS91dzM1ZjF0eE9rRlB3RHY3bFFHblRVOWxmdzFIeTJkNEQxM2ZzcUJqaDly?=
 =?utf-8?B?endaQ211ZjdoNERrSXh6ZVF6OGV4VkNJc0RUMnNtdkpYdTgxYmd2RTFTZXZ2?=
 =?utf-8?B?R3dibG5QVnpPL1l1TXMyck9vUVVabjN5bmc0S2c0bkdibnVuV3E0R2ZhWml1?=
 =?utf-8?B?UkZ4OGpWc2dZK0lZUVJXMENpZkY4TjhtSVlqOFRhdXJSVWVWeVB5RHJ2TFdY?=
 =?utf-8?B?YUZ2dVh1T3RnMWVYbTgwN3o4bnRmNlZQVmpMNWlLaVR5UFhRR1BuVnlVQ25v?=
 =?utf-8?B?YlhTbkM5amlwNm5SdWhBOEMvTHBJb3FKWVVEaW9sMmlYRHNPV0ZQVC83aXRN?=
 =?utf-8?B?VjNFanlabUlMMEptQURZaHR0RmQ2RFRaQW13djdHaU5rVm16enZTSHZiNE1o?=
 =?utf-8?B?OWFtSkFJUFhOK1o5VmpLOXZIUmZCYzlCN3BsQnVxYlpIOXNaRUpZdUlQV3Vn?=
 =?utf-8?B?bC9rRVJhMGtlM2NNYkI5SmpGN0VqUnJEVzV5Uklrd3B1ci9KUDFjdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c756065-24e9-466f-662d-08de75f08af5
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 11:08:31.8597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eJe6VBlGYDAnZa3HBhX33ZGMaKwA+5vn+Pe/ZTHJltwnt1wPAEUNSdouIWE56mhGOGORWc8lEg18aSyEjU4+FNIfSu2V9MHBoSjXmEHLbt4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11483
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 27 Feb 2026 11:08:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19086

Hi Robert,

On 1/30/26 7:33 PM, Robert P. J. Day via lists.openembedded.org wrote:
> 
>    While perusing some vendor's code, I ran across an example of
> setting a handler eventmask to "bb.event.SanityCheck". Out of
> curiosity, I looked up the current BB manual for that event, but it is
> not listed here (many others are, of course):
> 
> https://docs.yoctoproject.org/bitbake/bitbake-user-manual/bitbake-user-manual-metadata.html#events
> 
>    Is there any value in having a comprehensive and complete list of
> BB-supplied events? If not, how do we expect a developer to know about
> the ones that are not documented?
> 

If we've a partial/outdated list in the docs, I think it's safe to 
assume we would like it to be up-to-date, so patches welcome :)

Cheers,
Quentin

