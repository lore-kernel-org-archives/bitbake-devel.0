Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55E0C282D1
	for <webhook@archiver.kernel.org>; Thu,  6 Mar 2025 13:25:02 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.86])
 by mx.groups.io with SMTP id smtpd.web11.12991.1741267501628270886
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 06 Mar 2025 05:25:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Xdj1gRal;
 spf=pass (domain: siemens.com, ip: 40.107.22.86, mailfrom: peter.marko@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OYYAjFEI2FxSWQ8ANQlwJHA9rcf6ildAVquHZ6TVE8/QSazXMsRQoQfik0rGPXZWK2TBHK8z0/jmwJkKiUB+KoEp4OSHRZTf3f9EHtX/AWLO9mhrDlGQhkiYh1oXZ37RlxfHencwMvG7rzMwuz58PHxPl7+rhOXS5Cfu4TlisEBivEu8x/nrAd3Ew1EEtRbBKDxUDkMhfrFnJpqHQxz5g/aLklWB7sadoI6IAL/CVFBt3m75Tfz5sWa48+f6EAkCil/LOnBVqYW8WeMDYqdDof5N1WwjQDrWIunR6lyDN7NfWqggJJHPpmpTpq7stT4+6jxd9RoVQEErZWjp35qR7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aCSSIoLG7V9rC3eg+zLxjV0a+tntjGxBPVerbK9Yox8=;
 b=VUZjykbkLMceV34SqLu+wV4fBDz7ZT+S5jnjZF3ApaHOOzU90vEGtN5uulA3LW2MS3wbxXMrDUe8KZNmeqxF40o2LmsSCZRaCNEAATi3IvgPv/GgyRAtFGz70L4O9j00WgU1r8n5KRV9N4IwJ3KLeM+gHl8Lz6Yqpnj7M2M/mqySHDDocRIvTcyEF/n1KozWoXIfTrLJybkiBALbwXwhiv/WOobblU9KmWj9LCIKVSNJfsEZgiwa1YJvx4bLf7z/M3RbW7BhgiBs6mLkcID00Y7NoDS7Vm3ovEq+JcOrSf0LFdoB24SgVBsLQD592KomPNM7l9HyQXWc2w1v1jVXQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aCSSIoLG7V9rC3eg+zLxjV0a+tntjGxBPVerbK9Yox8=;
 b=Xdj1gRal9QRxQ0tqUssEMfGdMj9hA4hf2vDSJruu0+b1mhnA5O4am1WXrL3/XiJ75xrEuRBLO3nN+BuDBRPa7OP9QZBrlHcAafUgMCovNOEhixopXoSIBVnt1hazfOaPIzewgVkDvb1KAXt0rQ9KXTA2u9ektCpiT4KYMf4W1EFd86LfevDtUlVfCBbAA4dWs26wVYV/RCjzA+KXsmSRFv3KAfkWJwxv787bjqQUGNuC4dFGjntSVBXkyHD/+LQI2iEQMRtm0Gwqgf5Hue1s42iReewrJkR+8mh3ZCMQqlH+GNRyHdl9hFP3QCnOVaSXI84w0ukLuPImTLacktEUiQ==
Received: from AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:479::20)
 by AM0PR10MB3233.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:183::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 13:24:57 +0000
Received: from AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6c68:267b:6fd1:d3f2]) by AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6c68:267b:6fd1:d3f2%3]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 13:24:57 +0000
From: "Marko, Peter" <Peter.Marko@siemens.com>
To: "richard.purdie@linuxfoundation.org" <richard.purdie@linuxfoundation.org>,
	"lgo@pengutronix.de" <lgo@pengutronix.de>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
CC: "docs@lists.yoctoproject.org" <docs@lists.yoctoproject.org>,
	"yocto@pengutronix.de" <yocto@pengutronix.de>
Subject: RE: [bitbake-devel] [docs] [PATCH v2 0/5]
 fetch2/github_release_artifact: fetcher for (private) release artifacts
Thread-Topic: [bitbake-devel] [docs] [PATCH v2 0/5]
 fetch2/github_release_artifact: fetcher for (private) release artifacts
Thread-Index: AQHbjoiNl0dwM0he60K889eHHIYeLrNmC0uQ
Date: Thu, 6 Mar 2025 13:24:57 +0000
Message-ID: 
 <AS1PR10MB5697C9D94BECC62E2E335BE7FDCA2@AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM>
References: <20250227090853.1632280-1-l.goehrs@pengutronix.de>
 <a147420295a67f1db7be369e6ad45b2fb2bb086c.camel@linuxfoundation.org>
In-Reply-To: 
 <a147420295a67f1db7be369e6ad45b2fb2bb086c.camel@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=fe63a056-7036-4d37-b768-2d58f6fcabc3;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2025-03-06T12:35:02Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR10MB5697:EE_|AM0PR10MB3233:EE_
x-ms-office365-filtering-correlation-id: c4b30b92-e24c-40ba-5b2b-08dd5cb24a23
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?WGZyRHpmaHkxMkNsTlhSTzJZYklIMTBKRis5SFh6Yzl4cUNDUzQ3R0FYVG5k?=
 =?utf-8?B?Z2YwOVpJYlRGK3pMREhCMXRFS2VHUXNCVHFwc1l3TndPY1RoUzhvajNjVWxF?=
 =?utf-8?B?bjBTM29HZWRZdVdTblc1dTVjaGRGbHBROUtTTXpLcXVHVTYxR2RJM212SlBU?=
 =?utf-8?B?YWp5Z3llT1FyWnNIS0VEVGJEaHFGZ0RRTG42SVVnQ2RYeXZvT0RhQmdQaU1j?=
 =?utf-8?B?eVM2Z1JpcXJ1UTNla2dBckVtSjdQWDU0d3dmWUtpRThyQ3BCM1p3dmZuQ0R1?=
 =?utf-8?B?V3NRZC9YWGEzeWJkRkQyMnJaSEpqQ2RydUFoSGdrT3BBbi9RNUZab0p2eTFO?=
 =?utf-8?B?NWgzUzdQUlB6K05sVEUweVRQcktwZmR5Z3RXTWNmNjhLUmdDb1paVWFrSVln?=
 =?utf-8?B?dlY5eFg0NU9ydnI0clhWNG1nZElPT2g4b3dlaENROGs3Tm5MREcvTUc0UzFm?=
 =?utf-8?B?UFZlNkJBR2VXRllTUzg3U3N3RndSM1hPR1loaDZEdmdOZnNScDV6cElMWmlX?=
 =?utf-8?B?V21QcCtxYW95eENUVE5pRUV1WUNpWUEycnNHaDhremVLOFIvVSs1VEtlVEVk?=
 =?utf-8?B?ODkweTVOd09QeXFWc3BDNVk3a1haSUt4VWdxWjYyajJYbFQzSE5wQ2YxZGM2?=
 =?utf-8?B?SEZsYnVpaTllWXlQcW1uRzRITVEzbXBRc0V6ZWNsQzZaajdQdkZVUDhkbitS?=
 =?utf-8?B?dnNtNXhqTDlPejdFWlZQcW5KM0R1b04wRlcvNmx2NXpOU0dCbGQ2d21KQi9x?=
 =?utf-8?B?dUhRQkxJanNidWtJNHNtYTVBYVVLaWsvUmROUDd2ZmtoTEMzbUdQQmhBQTZR?=
 =?utf-8?B?UzhpVnY5WXF4d3JVVUozWTdoTlBVdEQ4TDJsQXE2SlY4SHpsRzRsNWIvZkNH?=
 =?utf-8?B?K0dac3UyWW8wd1huNis0U1F1R2F5WWdGKzduNmxlcGxKazI3d25MMjRjWEV6?=
 =?utf-8?B?YnduclpWM0NHNUxTYVdZenhXWXduQXFESGtjQXZBOE5yNzFsL3ZPWjV1Vi9X?=
 =?utf-8?B?SDBWckJ5N3BXbXY4WWVFdC9RbXNteDNRbVJreVBkV0phWGdVYTRyRVp3Z0hn?=
 =?utf-8?B?QVlyYUZveE9RZHNoV09FVk5xNFVqZng4THAzbmhWa0tid1p1NDY4VHdQL1RX?=
 =?utf-8?B?UHVCM3pWb1AzcDFnSk0rcjFtQXJqVHR5YzNrT2kzWDF3QWh1MzZSdVFwYkV6?=
 =?utf-8?B?d3hIVUNac3ZQRjE1Y0s0UEd2V1gwWVI1Y0o0VUQzM1hITHo4S3pMSHQzQjdy?=
 =?utf-8?B?ZkZMRG82VVNORTVtOHRranZwSHZvVXNXa2hma3RtUE13ZDFzNURwYUE3enFW?=
 =?utf-8?B?bmt5dUFUTGhDbk9XT25NRUIvZ3NWUC9wNUl5dFliUldqK1NueG8vUEJYLzFQ?=
 =?utf-8?B?VmRsbUZ1VGJVRktRSGRZZW15MnJpa2Z6cDBPcWgzTElmYnYzamZXdWVwMHdv?=
 =?utf-8?B?bFBUUUdoRG1TNm9yNUJvRGx0c2pvMXZMZThreW5SbmFiNkZoREtlRU0wYmlF?=
 =?utf-8?B?ZldMbzdNbE9uNkJqWjA0Y0N2SWxjS1V0Vm5GTjBIbDFuTmhtTmJHWUVJT2cw?=
 =?utf-8?B?MXdKQ3c2dXYyUmV6NWhWSVo0TDgzMm9ZSGJRZWdvZGpHLyt1c1huaU56am5O?=
 =?utf-8?B?RThJNWtncGRyZ0d6U2xhM2ZuQVZ4SVRNVFRwMDJ0RjBiZXYwS2Q5QjFQMUM4?=
 =?utf-8?Q?g6MS5YZkOschIGnIfm5S?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?YWdLL0Z3VDUxZFM3QzZxUm95bVY0YjFTcU1LdUNNMUd5ZUxKZDRJM1FWa1B4?=
 =?utf-8?B?UTRJdDhqNFlBWE5sNDdLTkRDNkR5K0xqOEp0WGJYVlFJWmorZmVYUzJpd2JF?=
 =?utf-8?B?NUNuYWlSYlJTQktvTkJUQTdLTUt0c2lUejhSRml5U1dNcFhJcHdKN1hBVXlI?=
 =?utf-8?B?NEx2VXFPMG9XZ2tZUnVpRVJsd2srb1ZnZHh3eEhZQmdUczBkVHhoLzViUEls?=
 =?utf-8?B?TjlFTmlUR1VrWmVNSzZPSmtpeCtZSFV5N3JFZXA3emVWMG5ZRU9veWpyZHE4?=
 =?utf-8?B?R3U5S25aeGZsTkhBS2tKK0wyRXBiNTNVeThXbXFHaG9qTDY3Um8vaGhBT1U1?=
 =?utf-8?B?SnZXbUZNTjkvV2RTbXUwRjd0ZzRFRWdqRE9DNkQwbUhpZkNwZExEZnlncitw?=
 =?utf-8?B?OWh6K0dKVm1OTkxpWFNnTzkwMHhQK1VuZ0xwSHZaVGYrVU0xNnFwWk9vdVhZ?=
 =?utf-8?B?YWtaV3ZoMWk2ek5NRytxUm5TK0s0cm1HRDFOZlp1TjlGdDhJVWw0R1U2NlRn?=
 =?utf-8?B?U1NXUUYweVYxLytLa0wrSDdLMXl6eXllTE9uTnhhVkFLUXo5V0ZXc1c0SVNy?=
 =?utf-8?B?eW9OVFpSOWNiT0dZbjRQRGxmN0pYeEdneWNkK1p3eHlLUGI0eHc0ZlcyU1pa?=
 =?utf-8?B?akJjdUFwaDFoNmtLci9uV0lWU3FLOENMdlFPaUFlMmdES0VvZ2J2TFN5bnFv?=
 =?utf-8?B?TjRJVlVqWXEvZC9qTEh2UWhEaCtucEZGREZIeWFWU0gvZkU1em81U0t2ZTJu?=
 =?utf-8?B?ZzhZUm5FZlVQTmNtSURleEYzYzExRm14YlgrbHl0RzdOSVcxM2dqTGRpY0Zj?=
 =?utf-8?B?WWs3MEZPMVp2Z0ZLZkRTaTl3am5LZVF4QmRHWmVURkZTNlRvaTY3N0ZtWHdH?=
 =?utf-8?B?Tm1CUG8rV3J6amNOeWs3MmpSTHJmZk9lL0RwVkVOb2hSVXdlYzBwb0JvbmZv?=
 =?utf-8?B?Sm5mNS9VMGdsSGM4Y0pkOEt4NU1zQUlmRXpnTkdXbE1pejIyNjNhaFJZV3hj?=
 =?utf-8?B?dnpDVmErK1VRYmhXZ2RCTktodzh4azR1VkJKaXBXK2F1K0IzeU82N2dkRXRY?=
 =?utf-8?B?YlA3cUs0cnJSVXBXdzMybHRUSzhvQjJXUkx4cDJPbGJEZzMzdC9STjBqMGhw?=
 =?utf-8?B?UkpCUVJ0TXR1MVBSWFpsRlU4NmdzKzQzdU11ZTN1WWtlR2lxc3dtaHByUUZV?=
 =?utf-8?B?QjlxV01GdVowLzdkY0RTdmgrcWdETFh3NEtObzVoeC9MbXNjaWU0N2g2Ykxl?=
 =?utf-8?B?NjFINUYvVzhiWFNXMFgrM3QxM2M1NGlJd3NleGJud3FuN3hPZE1sQVBIY3dk?=
 =?utf-8?B?cHEyWUl5NFZBblkvZ09FckRRblFNRW0rSEJmSGxmRGJhOEp0YmppYVIwRjVG?=
 =?utf-8?B?WG1VOUd0M1FoeDQ1a09UREpxSnh2VW9QSmZYSzFnRFg3OVAwcW5BN1ZBVW1S?=
 =?utf-8?B?RHZ5L05jSWN0ZFQ4VUlpQUFYWDFnMWRUSVFhdithd0JOTHhacWhlWk9CZDY2?=
 =?utf-8?B?cjZJQWhmWGFHNHhDRUdLclZvc3BHWmthOTVUSnZzSWF3QldqZG5GaXlKMWI2?=
 =?utf-8?B?N3RaRzVzRkk5SUwrbFdXQ1Vua0hVcWhOR2ZFZ0xBeXFRUWhoRHdyeEFlMlQ0?=
 =?utf-8?B?SVhHSUEyTXZQbit1YWptTHRsUWxzUitYQzczckhnNkpxYWJvMUYwWEg1QnRn?=
 =?utf-8?B?dXl1dURVMlNHL2tDcGFKbjVtdUpJeU1GQVM4eGppSlMvSFAxcXRoZjZFT0ty?=
 =?utf-8?B?dHcrQWowanF1SXNOZUsvdEt5bVpkQmZXY2ErQXdHMHBiVU5BZGJvZ0EzSEFH?=
 =?utf-8?B?QVhNVmRETTNydHdwMjh2MXJMMFZlcGRsVnNlZWdTc0h0UDM0LzBRcE1pTGkw?=
 =?utf-8?B?SFRHMHA2bFROd20waXNveW1VVmwwNDhpOVBRMzlyODkxbXB1dFFCWkMxaHha?=
 =?utf-8?B?YloxbkFvcTJ6enRyTUFWVGNlWDVzOXRTZE5wYm15SStBZjdxbDZ5cXJ5eU1o?=
 =?utf-8?B?enNsSEFPV1lkRTE2a0pTTnZwc2RGTFJ1T2NZcHI1YXhPY0ZhK2pkMmkwYnhi?=
 =?utf-8?B?RS9YWEozMEpYSitTd0g3M085WXFoVko2VG5PcFpaTEtHcWpwZkRrNVp4aVlW?=
 =?utf-8?Q?SI9mIFofx5PlJ0aI+Zwfc64Qn?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c4b30b92-e24c-40ba-5b2b-08dd5cb24a23
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 13:24:57.3984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1qwPWtHdyNVtvXqIyMhXswxyG4StaYiR/3T76b55fWNSXZHrJT61zCxcEPAwaqDFP6V/9ERrZXhTNhO0doxvYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3233
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 06 Mar 2025 13:25:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17394

SSBzdGlsbCByZW1lbWJlciB0aGUgZmlyc3QgQ1ZFIGFnYWluc3QgWVAgLSBodHRwczovL252ZC5u
aXN0Lmdvdi92dWxuL2RldGFpbC9DVkUtMjAxNy05NzMxDQpJdCB3YXMgcmVwb3J0ZWQgYnkgdXMg
YmVjYXVzZSBjcmVkZW50aWFscyBmcm9tIFNSQ19VUkkgd2VyZSBiZWluZyBwdWJsaXNoZWQgaW4g
aXBrIHBhY2thZ2VzIGFuZCB0aHVzIGJlaW5nIGZyZWVseSByZWFkYWJsZSBpbiByb290ZnMgKHdp
dGggcGFja2FnZS1tYW5hZ2VtZW50IGltYWdlIGZlYXR1cmUpLi4uDQpCdXQgdW5mb3J0dW5hdGVs
eSwgaXQncyBzdGlsbCBpbXBvc3NpYmxlIHRvIGhhbmRsZSBhbGwgdHlwZXMgb2YgY3JlZGVudGlh
bHMgaW4gYSB3YXkgdGhhdCBiaXRiYWtlIGRvZXMgbm90IHNlZSB0aGVtLg0KDQpJIGJlbGlldmUg
dGhhdCBnaXRodWIgcmVsZWFzZSBhcnRpZmFjdCBmZXRjaGVyIGNhbiBiZSBpbXBsZW1lbnRlZCBi
eSBqdXN0IG1vZGlmeWluZyBGRVRDSENNRF93Z2V0IHZhcmlhYmxlLg0KVGhpcyBpcyBpbWhvIG11
Y2ggc2FmZXIgKHdydCBsZWFraW5nIGNyZWRlbnRpYWxzIGluIGxvZ3MpIHRoYW4gYWRkaW5nIGNy
ZWRlbnRpYWxzIHRvIFNSQ19VUkkuDQpXZSdyZSBzdWNjZXNzZnVsbHkgdXNpbmcgZm9sbG93aW5n
IHdpdGggR2l0TGFiIChub3QgR2l0SHViLCB2ZXJ5IHNpbWlsYXIgYXV0aCBJIHRoaW5rKS4NCg0K
UkVHSVNUUllfQ1JFREVOVElBTFMgPSAiJHtAZC5nZXRWYXIoJ0dJVExBQl9UT0tFTicpIGlmIGQu
Z2V0VmFyKCdHSVRMQUJfVE9LRU4nKSBlbHNlIChkLmdldFZhcignQ0lfSk9CX1RPS0VOJykgaWYg
ZC5nZXRWYXIoJ0NJX0pPQl9UT0tFTicpIGVsc2UgJycpfSINClJFR0lTVFJZX0hFQURFUiA9ICIk
e0AnSk9CLVRPS0VOJyBpZiBkLmdldFZhcignQ0lfSk9CX1RPS0VOJykgZWxzZSAnUFJJVkFURS1U
T0tFTid9Ig0KcHl0aG9uKCkgew0KICAgIGlmIGQuZ2V0VmFyKCJSRUdJU1RSWV9DUkVERU5USUFM
UyIpOg0KICAgICAgICBkLnNldFZhcigiRkVUQ0hDTURfd2dldCIsICcvdXNyL2Jpbi9lbnYgd2dl
dCAtdCAyIC1UIDEwMCAtLWhlYWRlciAiJyArIGQuZ2V0VmFyKCJSRUdJU1RSWV9IRUFERVIiKSAr
ICc6ICcgKyBkLmdldFZhcigiUkVHSVNUUllfQ1JFREVOVElBTFMiKSArICciJykNCn0NCmRvX2Zl
dGNoW3ZhcmRlcHNleGNsdWRlXSArPSAiQ0lfSk9CX1RPS0VOIEdJVExBQl9UT0tFTiINCg0KTWF5
YmUgd2UgY291bGQgZG8gZ2l0bGFiLXJlZ2lzdHJ5LWNyZWRlbnRpYWxzLmJiY2xhc3Mgb3V0IG9m
IHRoaXMgYW5kIHNpbWlsYXJseSBnaXRodWItcmVsZWFzZXMtY3JlZGVudGlhbHMuYmJjbGFzcyBi
eSBzbGlnaHQgbW9kaWZpY2F0aW9uIG9mIGl0Lg0KV2l0aCBsaXR0bGUgY2hhbmdlIGluIGJpdGJh
a2UgdG8gZGVmaW5lIEZFVENIQ01EX3dnZXQgdGhpcyBjb3VsZCBiZSBldmVuIG5pY2VyIHdpdGgg
RkVUQ0hDTURfd2dldDphcHBlbmQgaW5zdGVhZCBvZiBhbm9ueW1vdXMgcHl0aG9uIGZ1bmN0aW9u
Lg0KTGV0IG1lIGtub3cgaWYgdGhlcmUgd291bGQgYmUgaW50ZXJlc3QsIEkgY291bGQgdHJ5IHRv
IHN1Ym1pdCBzb21ldGhpbmcuDQoNClBldGVyDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogYml0YmFrZS1kZXZlbEBsaXN0cy5vcGVuZW1iZWRkZWQub3JnIDxiaXRiYWtl
LQ0KPiBkZXZlbEBsaXN0cy5vcGVuZW1iZWRkZWQub3JnPiBPbiBCZWhhbGYgT2YgUmljaGFyZCBQ
dXJkaWUgdmlhDQo+IGxpc3RzLm9wZW5lbWJlZGRlZC5vcmcNCj4gU2VudDogVGh1cnNkYXksIE1h
cmNoIDYsIDIwMjUgMTI6MTINCj4gVG86IGxnb0BwZW5ndXRyb25peC5kZTsgYml0YmFrZS1kZXZl
bEBsaXN0cy5vcGVuZW1iZWRkZWQub3JnDQo+IENjOiBkb2NzQGxpc3RzLnlvY3RvcHJvamVjdC5v
cmc7IHlvY3RvQHBlbmd1dHJvbml4LmRlDQo+IFN1YmplY3Q6IFJlOiBbYml0YmFrZS1kZXZlbF0g
W2RvY3NdIFtQQVRDSCB2MiAwLzVdIGZldGNoMi9naXRodWJfcmVsZWFzZV9hcnRpZmFjdDoNCj4g
ZmV0Y2hlciBmb3IgKHByaXZhdGUpIHJlbGVhc2UgYXJ0aWZhY3RzDQo+IA0KPiBPbiBUaHUsIDIw
MjUtMDItMjcgYXQgMTA6MDggKzAxMDAsIExlb25hcmQgR8O2aHJzIHZpYSBsaXN0cy55b2N0b3By
b2plY3Qub3JnIHdyb3RlOg0KPiA+IFRoaXMgZmV0Y2hlciBlbmFibGVzIGRvd25sb2FkaW5nIGFy
dGlmYWN0cyBhdHRhY2hlZCB0byBHaXRIdWIgcmVsZWFzZXMNCj4gPiBpbiBwcml2YXRlIHJlcG9z
aXRvcmllcy4NCj4gPg0KPiA+IEF1dGhlbnRpY2F0aW9uIGlzIHByb3ZpZGVkIHVzaW5nIHRva2Vu
cyB2aWEgdGhlIGBHSF9UT0tFTmAgdmFyaWFibGUNCj4gPiBvciBhIGB0b2tlbj1gIFVSSSBwYXJh
bWV0ZXIuDQo+ID4NCj4gPiBDaGFuZ2VzIGZyb20gdjE6DQo+ID4NCj4gPiDCoCAtIFByb3ZpZGUg
ZXhhbXBsZXMgb24gaG93IHRvIHByb3ZpZGUgdGhlIGBHSF9UT0tFTmAgbW9yZSBzZWN1cmVseSB0
aGFuDQo+ID4gwqDCoMKgIGp1c3QgaGFyZGNvZGluZyBpdCBpbiB0aGUgcmVjaXBlIGluIHRoZSBj
b21taXQgbWVzc2FnZS4NCj4gPiDCoMKgwqAgRS5nLiB2aWEgdGhlIGBsb2NhbC5jb25mYCBvciBl
bnZpcm9ubWVudCB2YXJpYWJsZXMuDQo+ID4gwqAgLSBJbmRlbnQgdGhlIGNvZGUgZXhhbXBsZSBp
biB0aGUgZG9jdW1lbnRhdGlvbiBgLnJzdGAgdXNpbmcgdGhyZWUNCj4gPiDCoMKgwqAgc3BhY2Vz
IGluc3RlYWQgb2YgdHdvLg0KPiA+IMKgIC0gRG9jdW1lbnQgdGhlIGB0b2tlbj1gIFVSSSBwYXJh
bWV0ZXIgYWxvbmcgd2l0aCB0aGUgYEdIX1RPS0VOYA0KPiA+IMKgwqDCoCB2YXJpYWJsZS4NCj4g
Pg0KPiA+IFRoYW5rcyB0byBBbGV4YW5kZXIgS2FuYXZpbiBhbmQgQW50b25pbiBHb2RhcmQgZm9y
IHRoZWlyIHJldmlldyBmZWVkYmFjaw0KPiA+IHNvIGZhci4NCj4gDQo+IEknbSB0b3JuIG9uIHRo
aXMuIEkgYW0gbGVhbmluZyB0b3dhcmRzIG1lcmdpbmcgaXQgaG93ZXZlciBJIHJlYWxpc2VkDQo+
IHRoZXJlIGFyZSBhIGZldyBpc3N1ZXMuIEZpcnN0bHksIGl0IGlzIGZhaWxpbmcgZHVyaW5nIHRl
c3Rpbmcgb24NCj4gVWJ1bnR1IDIwLjA0IHdvcmtlcnM6DQo+IA0KPiBodHRwczovL2F1dG9idWls
ZGVyLnlvY3RvcHJvamVjdC5vcmcvdmFsa3lyaWUvIy9idWlsZGVycy81NC9idWlsZHMvMTEyOQ0K
PiANCj4gU2Vjb25kbHksIGl0IGFkZHMgc3VwcG9ydCBmb3IgcHV0dGluZyB0aGUgdG9rZW5zIGlu
IFNSQ19VUkkgdXJscy4gSSdtDQo+IG5vdCBpbiBmYXZvdXIgb2YgdGhpcyBzaW5jZSBpdCBlbmNv
dXJhZ2VzIHBlb3BsZSB0byB3cml0ZSB0aGVtIGluDQo+IHJlY2lwZXMgd2hlcmUgaXQgaXMgYWxs
IHRvbyBlYXN5IHRvIHVuaW50ZW50aW9uYWxseSBzaGFyZSB0aGVtLiBJIGRvDQo+IG5vdCB0aGlu
ayB3ZSBzaG91bGQgZW5hYmxlIHRoaXMuDQo+IA0KPiBGaW5hbGx5LCB0aGUgbmFtaW5nIG9mIHRo
ZSB2YXJpYWJsZSwgR0hfVE9LRU4gaXMgbm90IGluIGtlZXBpbmcgd2l0aA0KPiB0aGUgcmVzdCBv
ZiB0aGUgY29kZWJhc2UuIEl0IG5lZWRzIHRvIGJlIHByZWZpeGVkIHNvIHNvbWV0aGluZyBsaWtl
DQo+IEJCX0ZFVENIX0dIUkFfVE9LRU4gd2hpY2ggbWFrZXMgaXQgY2xlYXIgaXQgaXMgYml0YmFr
ZSwgdGhlIGZldGNoZXIgYW5kDQo+IHRoZSBHSFJBIGZldGNoZXIuDQo+IA0KPiBDaGVlcnMsDQo+
IA0KPiBSaWNoYXJkDQo+IA0KDQo=

