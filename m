Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFA3C3ABBC
	for <webhook@archiver.kernel.org>; Mon, 12 May 2025 11:20:34 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.66])
 by mx.groups.io with SMTP id smtpd.web10.47738.1747048830473823890
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 12 May 2025 04:20:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=aXl4xzKM;
 spf=pass (domain: siemens.com, ip: 40.107.21.66, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E2sh51dNjdO1xGuxVZwyImmgY0zdjaXyhNj1VoP/5YwBVFwZf6ZhpgZrGQld3YfPDycijBzBTv9nWggy1/XGyVPfaErUwYa3Ul0yIxH5Xbx6bTerpM48SVYrr8bw+2hxxUUAddZ1ojjwXRTTKYQ8CvSAIQ+kQcLXYx4wNzXTMR9/2jcNd2Dk9Nt2zIOjXudNB3tuelCnzuVL0V5sWWoRyJ2rQK995v+gGUnXj5Qg8BhJq/35qXL7/YPoQFKD1MHIIieoIlmoY2OaNs5mkLSe7iOG0Qt9+4AHrBZu5fjabF4akz6pSIRtbmWrMkYU8/yMWNeguT8arIO/YuZPu5nm7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pl3oJeQJ35bLQVZnKq1D6WBlmPSOX0hKp6kJqE2vK+8=;
 b=TbWYR9NjEaPswOVAE/ZvHy68fCwQk4Cjwb5AtN94af8/nMzL0yZW8Djeq19GNkyxpH5Ii4XXPGlcsuSE4Pvy4cfW+eP39OqAWyHboUrZ7rmxKsbilCAN/W00cuVu2kPIOqmydexR8Z3sbwYU7F6I4rJ2mgXPCyZ5PfGOiesDncLhK8FUAuP11bZ4DwXrc3fOUMkadhvrwb+3tzo6jeaQ2xVSjXjI+rftCrXTHOnfi15xznQvYIOmcoNLEDfmUtzN02VSAIBaFEGAZe0IWL3J4jBvxz5VI0CEwpB4HluoaejLDM1ZfhXODT0Nq/ZsmUcHJllI9gcRH/pc+eZ4PSKgaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pl3oJeQJ35bLQVZnKq1D6WBlmPSOX0hKp6kJqE2vK+8=;
 b=aXl4xzKMPGF5SCatIIzoauREz8kT5ycwCyTYzzTyJMK1D652qx8ibctUMwosZ0YZmactK7am4FNih1w6q7MjafwWXz6alfGcAPZS9kGa+NfWcEgryGTEVkGo88RM4ZZwmiyrjny7v6uAR8JlJDbMEuhW3SclNLokGp8e5B8JQP46gCSaZ+Z7c0RvwMylqScDNMXProfQoJLRqPc6wLU/BkIg7WvXTVXQtQPjDn7+J9AGK5kqtaJ/z4W/UEyBYSARTXJLAhWZNVkdCuAsQm5ftpmCku1OiUrIvy7X0f/PMrUDCNA9F50Yn0HxsgGXj0uQRrs6yZ2EjIdlW44RjS5DYA==
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:41e::11)
 by DB9PR10MB6572.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Mon, 12 May
 2025 11:20:26 +0000
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec]) by AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec%4]) with mapi id 15.20.8722.021; Mon, 12 May 2025
 11:20:26 +0000
From: "Koch, Stefan" <stefan-koch@siemens.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, "niqingliang2003@gmail.com"
	<niqingliang2003@gmail.com>
CC: "richard.purdie@linuxfoundation.org" <richard.purdie@linuxfoundation.org>,
	"liezhi.yang@windriver.com" <liezhi.yang@windriver.com>
Subject: Re: [bitbake-devel] [PATCH 0/1] fetch2/git: Use basename for
 gitsrcname when ud.proto is file
Thread-Topic: [bitbake-devel] [PATCH 0/1] fetch2/git: Use basename for
 gitsrcname when ud.proto is file
Thread-Index: AQHbwx/opUOVic87G0a7cfInB6ZbI7PO2XSA
Date: Mon, 12 May 2025 11:20:26 +0000
Message-ID: <d743138a1b56d1f31f81d837a1136013737cde03.camel@siemens.com>
References: <b6ef29f5-277c-4df6-8f1f-a48274600cd7@windriver.com>
	 <29977.1747041969023320088@lists.openembedded.org>
In-Reply-To: <29977.1747041969023320088@lists.openembedded.org>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR10MB4959:EE_|DB9PR10MB6572:EE_
x-ms-office365-filtering-correlation-id: 098f3e33-670b-4ba3-901c-08dd9146fec4
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|4022899009|1800799024|366016|13003099007|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?MWVabUR2c1crQlpaSnczQzNTbGVrb2ZTdjFSNlR4dG5VZDI4d202bUIvNitS?=
 =?utf-8?B?TUViU3dzR0UvakgrN3dxaGtZOHl2MUkzYTdvQTRzMEx5R0Irakd6aytUWGxX?=
 =?utf-8?B?OWo5cEM3WCtpd1NpdVJ0VjBFQmFoeXhicDlmLzFKMzdHTlZQeHJZVkh6ZlU2?=
 =?utf-8?B?a0hSdlhlUGVZZE92NktyUWp5VSttdnc4aUVxK2hVSWNaNndpeFcvTGZCc2M5?=
 =?utf-8?B?UkRKV2pzQVZKalp2NVBEY2x1djRTbjQvWS9veXB2VEw5YVpXbXdKVWE0c2FH?=
 =?utf-8?B?SnUzUHRpQzZ5Zk9BSFExM25JaVhHREZ2eTRqdjVuSkNyTjduZU4xVEpXN3pw?=
 =?utf-8?B?ZTh3Y08rYTl5MUd1b3hySTF5b1JxekYreGZuZnQycU5wNHFmRmMxa2ZIVU90?=
 =?utf-8?B?OXNiQnR6c0dJQWVlL1QrV0NVY01kTTdna3pXbjNkclNrc1lTUldRc0RJb3A3?=
 =?utf-8?B?Ri8zdGVkZUlIZW1sNXF6UGNFYllna01QM2N3bVEzdHp5NnBDUTBqd01laW9n?=
 =?utf-8?B?M2lMTHZZbm9OVURTMFB1TkxLUHlNc1V6WkwwcWpGeWRpSDI1UEdONHJnOEhz?=
 =?utf-8?B?MmhSbSs3UElSeUx3K3pSMm15WDVRL09tc2JUR3JWckJXUktFalNvWHQ1eWdy?=
 =?utf-8?B?bWpGSGxiaHhDQ1hOV0RFZXBQNVhCQWJkL01zM2U4LzNnQVY1MzhsRnlYNmc2?=
 =?utf-8?B?VUFGVytPblhuSG45K3N1cXg1NFByNHYxQXdEaU9BMWV3WXVYUk5VN3pRWWxx?=
 =?utf-8?B?WEhpSTVxc3ErYzRTK01LdzExd3Nrenhoc1h6by83czZydVFnb2pnOS9KejZL?=
 =?utf-8?B?TnZzNlJKWGwvbk1Db255TkVrRmsrcTR2YlpMbHFvdFQzUE82ZDZneTVFd09P?=
 =?utf-8?B?K3lzdG1kYmhOSm9Rdk1malBKYmxEekFRZ2ZzeFFZWHRpbVFIV2VqQmRaanZm?=
 =?utf-8?B?SHB6N2NoaTZYMzFOWXZNQndEdlB0VnY1TExma0EzSUIxeDdwWUpYZnU4ZWJX?=
 =?utf-8?B?RG1PdFZjdW1URDYzcWFXR2lBYTdJVlZyQjNBR1N3YWtkVzVvRGl2d1A3alRB?=
 =?utf-8?B?NkYwVFovaFNoL2UySE9NMGdtRkVCUFo2dlYxeE81OVg0OUVGRS9UTUhYU3ho?=
 =?utf-8?B?dkZ0QkN4VlNqSDhlNG1YaUIxM1RpVTBKZzJNRWtNdDdHaXVkbGNRQ2ZROXJK?=
 =?utf-8?B?QVgxT0NQNC9uSmpqdndrRTh5YUk4T0xiNmFvc3RHM1FpWjFqMFlOdUpJQnl4?=
 =?utf-8?B?QzBXL24xN0loZFV2MGVRcHZPZGU3UE0yM2xZQWR5T0RGRnllVWJabUhmTm1t?=
 =?utf-8?B?MDZUVmhXUU4yZ1ZpZlVQQVlKcnkyaUNRVXdHR3RXQjh6UG1yMVFTQVZlRmxD?=
 =?utf-8?B?MUZXYnJMRXhBTmNUMVd0dk51M1NQUjdLK1pZS0Jxb3ZrK2dGWmtxVnB4bjBv?=
 =?utf-8?B?WEMwNFBSaHZNc1B5NHh4YjVDSnpqNUFUb2poNGM3SFZvVGRqZldvODIvZ3Zh?=
 =?utf-8?B?Y0pMc3V6dXhQUmRCUnI3VVFEY0pMc0hESythTllFeWY3Sm1PMFp1RkI1cXIw?=
 =?utf-8?B?NVVwUHJVdFBFbUNDdTIwcW1qS1BRYkFkVmd1M2lOa2JpUWt0TTd5T2FKbS9v?=
 =?utf-8?B?Yk9iMTQrakdoY1dFQlBnZjR1aS9zR3Q5UXBsNGZMNFh6QkpPWGF2MWRYYXZy?=
 =?utf-8?B?aFRZQW9PMTBkV1NVNGlGZDU1bzNQYlBtZS9GUnUrZm1RVllpa21NK0tKQmV0?=
 =?utf-8?B?eS9veXJvRDdrZGN1Y3Ewalk4bkxCMW5wbnR4NnJMRDUzMlBjdzR0Q1YwUEhC?=
 =?utf-8?B?Z0JNZEI2QmlTM0NnY01IZEs1QjlHRnRDdGVwQ2IyUFE0ZzNzK1h3Y2UyRmFr?=
 =?utf-8?B?RkJnNUwxTjAzMzQ5cFBkY3JEYSt1a1ZkTGlNa2NDelZqbURKMm5yYWorMG9y?=
 =?utf-8?Q?hZDRAyaOSeo=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(4022899009)(1800799024)(366016)(13003099007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?N21rWS92cXVrTGVaZmY0cGVJdGw1clFzWVA0aGQzNnQyNW9NbHNybXFoaEp1?=
 =?utf-8?B?Zm1EQTNOU1V0MHU5aTFyZ3VrdjQ1VnNkV0RjZ29WMWptYkFKK2dCcVFYMTNC?=
 =?utf-8?B?K1FQRmpBdjlyV2FtOFpsZWRGc2Q1VVhodnZoblRhNXdPd0I2OEl5OFdiczEx?=
 =?utf-8?B?WGlhUnpPemtxMDhSSXd6MkVjbXM2RzR1czBhRWNGZ0k0NE5GWk9KdU1LaCtF?=
 =?utf-8?B?aTJrRkRRMGFMV0dMNUxLV3VLbFMrRC9LQ05CdXdKOWZkbE1PcHdpY3A2SzVN?=
 =?utf-8?B?bE5pUjF1NmJQWGM0Y3c2L3NBMlJNQmZEVWhGL0JoNHZOZVBlQkVLUWVYdS92?=
 =?utf-8?B?Q1pRSlA4YTUyellNa0hTczBPUE1uMjRvaFNpQllYVkdDd1ZlZHFJVThkcnNi?=
 =?utf-8?B?SVRLdXdSbm1DQ1cxMjVLY1hrblRnZSs3RWhiVElDOW4zb3hZTGFZR2ZIdXhY?=
 =?utf-8?B?eVg3WGFoMjBTWFE0TCtVSjlqTmRkbGU4TWIvRm0rNTl0TFJwZVhtZkZmajFs?=
 =?utf-8?B?dFBodzBCdGpKWk5jamtUc3Q3TURlN1poQnFuTHRqMC9Mb2xQSjFadjJjREto?=
 =?utf-8?B?Z0hNZlR0RlZLczBrTUoxbyt1a3hHN01RcFlxVFZYVFovTWtCaWM0bGRUWVhJ?=
 =?utf-8?B?bmR1ZiswampUaFlxc1JDYUxLdjlXZEx6b2s5d0FnbUtleXhrMVhQcW9nc1My?=
 =?utf-8?B?RVpzUVdmU2RLWGlsekFPaXZHZHJKN25kWWdFcTcyaUpla0tlKzdqU1RKdWVl?=
 =?utf-8?B?RTBrYTdrOFk2cWQrZS9oajdQK1I4YWRFbStIdC9xNnRyWGdHOVQwWFBCQWZQ?=
 =?utf-8?B?V21MblErN2l0cGQwR294WldPWWVTSm9tdy81aWJ1cVJsbWljU0wzcTVZL3M1?=
 =?utf-8?B?Z1FvWE5CL3pmTElMMHZmN2o4L0l1YUJ5aXZtUHJzV0tiQmVrMnhQUklTM21P?=
 =?utf-8?B?QTZCU0F3d1JwZjZKeURKUXRGZ3QwdGxibGtKOVpweURzVTd2WkJBREQwNVBu?=
 =?utf-8?B?TUlCdFArblRnQ3BEQVA0c2VFaWU5U2JWUWFmQU10Q0N6blB3Yk1GdGhCamJB?=
 =?utf-8?B?bytndEZMMjFHNUtiK0UvTWxSODRjQUdWWFZOQURwVTZsVzZVcFpYSTVhMlVp?=
 =?utf-8?B?OWdiSzR3YXdEQ2ZKQTA4YlNwNElJYUpOcE9LZHBJeUFYTUxrbm84cVhtY2dr?=
 =?utf-8?B?Q2pHMTY5dTVMUGYzOFAxbXVDTVQrb3hyNnpGUHVFRDhDRVZabmowODhFMDlR?=
 =?utf-8?B?UEJpN080R2NCSFYvRE5CT0NoZlZ3cEFSaEplbVdhZFVsSU5ra3c2Qm53cEhX?=
 =?utf-8?B?SnFyd1pFa0UxaUViQ0Z2MHBYaTc3ck9OOW5TTW00eDFGOCt1cVVXUkhZVzRi?=
 =?utf-8?B?VDVDbXFzZ3R4NXF4RWZkc0pnbHk0UFc4VWlHOWJuQXAxaEc1SUo1ZUg2MUVa?=
 =?utf-8?B?c0JIUzIvSW9RQ04xWUxKcnMyMDkrRGpUOHBBeXVJVjNDQTcrUW5tb2lLK05k?=
 =?utf-8?B?Y1BEbXFTOW9iWkYrdXdvWUlYQjVsR2NWSS9OaGxhVWFkV1Vwd3N4QjBIK3RN?=
 =?utf-8?B?UTU0Y1Z3THArejVFUmQ2K1l3MzdjTWJrYlZMUnpWQnQydU0zTXhrQUFMU3Rh?=
 =?utf-8?B?MzIveGY4ZzVLVkdKc3Y1TEh1NXN1SmcyQWRjVG5mWWIxOWFneGZFSzg2WmdC?=
 =?utf-8?B?bkwyc3hsVnpKN3VucXRWTjdmd3Bwb2JNUTg5WWE1VlQ4N1VkVis4b3M5djJw?=
 =?utf-8?B?NjQyRWhuNXBIblhPKy9YZUdqUVFBckdLM2hiYmJjNE5JbDNaOG9teWRsaGUz?=
 =?utf-8?B?WXFsYVhqUEkvWnFlaG5xcmpaTUkrTGtwSm5CVExyMW5LWkRXd1pya1NUbndh?=
 =?utf-8?B?aVMzcFd5SVpDMEVBUG9hOGZjUTNNM3ZEbWQ2Zjl2L2IrR2FnaGp1RGQ0WTRu?=
 =?utf-8?B?Ukp5QXB2alVZTkNmUjJhcmg2cnRua0duaUV3c1ErblBjdU9kclcvYzk4cDJJ?=
 =?utf-8?B?dS9Pay9JOExzQTloVE5NVXNwMURwclFsZDdSMGkyZE5TZmZPU0pDVHRjUU9j?=
 =?utf-8?B?VXFRZEoyenpSMnV6R242S1dsSHhIYVliWEFjcG4rcmp3RkJ3WDZuay83QTZv?=
 =?utf-8?B?L2tvQmZoOUUvYVdTa3ZOVEpZMWVHQkdGVkZOTXZWbHRLOEVjWmlPZytaQ1dp?=
 =?utf-8?B?RUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF7F23AEDD48E84295550D823E440C3E@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 098f3e33-670b-4ba3-901c-08dd9146fec4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2025 11:20:26.4443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7S5xhwUPbH9sGFBQIQ16CRK0ZLQ1KXIkIlRGYU8Mxoh3C0Orv+NrgPXhyjMrrJGXuTDi1juX1D9FNzouGaLZlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6572
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 12 May 2025 11:20:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17601

SGkNCg0KRGVmaW5pdGlvbiBvZiB1ZC5zaGFsbG93X3NraXBfZmFzdCA9IEZhbHNlIGlzOg0KUHJl
ZmVyIGFuIGluaXRpYWwgc2hhbGxvdyBjbG9uZSBvdmVyIGFuIGluaXRpYWwgZnVsbCBiYXJlIGNs
b25lLCB3aGlsZQ0Kc3RpbGwgdXRpbGl6aW5nIGFueSBhbHJlYWR5IGV4aXN0aW5nIGZ1bGwgYmFy
ZSBjbG9uZXMuDQoNCkJlZm9yZSBCaXRCYWtlIDIuMTI6DQotIENyZWF0ZSBhIGJhcmUgY2xvbmUg
b2YgdGhlIHJlcG8NCi0gQ3JlYXRlIGEgc2hhbGxvdyB0YXJiYWxsIG9mIHRoYXQgYmFyZSBjbG9u
ZQ0KDQpCZWdpbm5pbmcgd2l0aCBCaXRCYWtlIDIuMTINCi0gRG8gbm90IGNyZWF0ZSBhIGJhcmUg
Y2xvbmUgb2YgdGhlIHJlcG8gKGJ1dCB1c2UgaXQgd2hlbiBpdCBhbHJlYWR5DQpleGlzdHMpDQot
IEluc3RlYWQsIHVzZSBvcmlnaW4gZGlyZWN0bHkgdG8gY3JlYXRlIHRoZSB0YXJiYWxsDQotIE9u
bHkgaW4gY2FzZSBvZiBmYWlsdXJlLCBzd2l0Y2ggdG8gdGhlIG9sZCBiZWhhdmlvdXIgYnkgc2V0
dGluZw0KdWQuc2hhbGxvd19za2lwX2Zhc3QgPSBUcnVlIGFuZCByZXRyeQ0KDQpHZW5lcmFsIGV4
YW1wbGUgdXNpbmcgcmF3IEdJVCBjb21tYW5kcyB3aXRoIHRoZSBMaW51eC1DSVAgcmVwbw0KYGdp
dDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9jaXAvbGludXgtY2lw
LmdpdGA6DQotIGBkZXB0aD0xYCAoc2hhbGxvdykgZGF0YSB0cmFuc2ZlciBmb3IgTGludXgtQ0lQ
IHZpYSBnaXQvc3NoIGlzIGFib3V0DQoxNDggTWlCIChkZWZhdWx0IGJyYW5jaCkNCi0gYmFyZSBt
aXJyb3IgY2xvbmUgZGF0YSB0cmFuc2ZlciBpcyBhYm91dCAzLjkxIEdpQg0KPT4gU28gdGhlIGJh
cmUgY2xvbmUgbmVlZHMgMjcgdGltZXMgbW9yZSBkYXRhIHRyYW5zZmVyIHRoYW4gb25lIHNoYWxs
b3cNCmNsb25lLg0KPT4gVGhlIHNoYWxsb3cgY2xvbmUgc2l6ZSBpcyBzaW1pbGFyIHRvIHRoZSBz
aXplIG9mIHVzdWFsIGtlcm5lbA0KdGFyYmFsbHMuDQo9PiBGYXN0IHNoYWxsb3cgYXJjaGlldmVz
IHRoYXQgc21hbGwgY2xvbmUgYWJvdXQgMTQ4IE1pQi4NCg0KVG8gZml4IHRoYXQgaXNzdWUgaGVy
ZToNCi0gRUlUSEVSIGFkYXB0IHRoZSBtZW50aW9uZWQgcGF0Y2ggZnJvbSBSb2JlcnQgIlVzZSBi
YXNlbmFtZSBmb3INCmdpdHNyY25hbWUgd2hlbiB1ZC5wcm90byBpcyBmaWxlIg0KLSBPUiBzZXQg
dWQuc2hhbGxvd19za2lwX2Zhc3QgPSBUcnVlIGluIGNhc2Ugb2YgUFJFTUlSUk9SL2ZpbGUgcHJv
dG8NCihhcmUgdGhlcmUgb3RoZXIgY2FzZXMsIHRvbz8pDQoNCk1heWJlIGl0IHdhcyBvbmx5IGEg
Yml0IG9mIGx1Y2sgdGhhdCB0aGUgUFJFTUlSUk9SIGhhcyB3b3JrZWQsIGJlY2F1c2UNCkJpdEJh
a2UgaGFzIGFsd2F5cyBjcmVhdGVkIGEgYmFyZSBjbG9uZSwgZXZlbiB3aGVuIHVzaW5nIHNoYWxs
b3cuDQoNClJlZ2FyZHMNCg0KU3RlZmFuDQoNCk9uIE1vbiwgMjAyNS0wNS0xMiBhdCAwMjoyNiAt
MDcwMCwgWWkgUWluZ2xpYW5nIHZpYQ0KbGlzdHMub3BlbmVtYmVkZGVkLm9yZyB3cm90ZToNCj4g
SSBzdWJtaXR0ZWQgYSBidWc6DQo+IGh0dHBzOi8vYnVnemlsbGEueW9jdG9wcm9qZWN0Lm9yZy9z
aG93X2J1Zy5jZ2k/aWQ9MTU4NTYNCj4gDQo+IHRoZSBiaXRiYWtlIG9uIG15IGVudiBnZW5lcmF0
ZWQgYSBnaXQgc2hhbGxvdyB0YXIgZm9yIGdsaWJjLCBidXQgd2l0aA0KPiBsb2NhbCBtaXJyb3Ig
cGF0aCBpbiBmaWxlbmFtZS4NCj4gYW5kIGxpbmtlZCB0byBpdCBhcyBhIHN5bWJvbGxpbmsgbG9j
YXRlZCBpbiBnaXQyLg0KPiANCj4gd2hlbiB1bnBhY2tpbmcsIHRoZSBiaXRiYWtlIGNhbid0IGZp
bmQgdGhlIHNoYWxsb3cgd2l0aCBvZmZpY2lhbA0KPiBzaGFsbG93ICh3aGljaCBmaWxlIG5hbWUg
c2hvdWxkIGNvbnRhaWwgc291cmNld2FyZS54eHgpLCBjYW4gY2FuJ3QNCj4gZmluZCBiYXJlIHJl
cG8gKHdoaWNoIGxpbmtlZCB0byB0aGUgc2hhbGxvdyBmaWxlKS4NCj4gDQo+IEkgdGhpbmsgdGhl
IGxhdGVzdCBwYXRjaCBmb3IgZ2l0IHNoYWxsb3cgcmVzdWx0IGl0Og0KPiBmZXRjaDIvZ2l0OiBB
ZGQgc3VwcG9ydCBmb3IgZmFzdCBpbml0aWFsIHNoYWxsb3cgZmV0Y2gNCj4gNDU3Mjg4YjJmZGE4
NmZkMDBjZGNhZWZhYzYxNjEyOWIwMDI5ZTFmOQ0KPiDCoA0KPiB0aGUgcGF0Y2ggYXV0aG9yIHNh
aWQgdGhhdCB0aGUgYml0YmFrZSBkb24ndCB3YW50IHRvIGdlbmVyYXRlIHNoYWxsb3cNCj4gZm9y
IGxvY2FsIG1pcnJvciwgYnV0IHdoeSBJIGdvdCBpdD8gSWYgc28sIG1heWJlIHdlIHNob3VsZCBz
ZXQNCj4gc2hhbGxvd19za2lwX2Zhc3QgYXMgVHJ1ZSBpZiBwcm90b2NvbCBpcyAiZmlsZSI6DQo+
IA0KPiAtIMKgwqDCoMKgwqDCoMKgdWQuc2hhbGxvd19za2lwX2Zhc3QgPSBGYWxzZQ0KPiArIMKg
wqDCoMKgwqDCoMKgdWQuc2hhbGxvd19za2lwX2Zhc3QgPSAodWQucHJvdG8gPT0gImZpbGUiKQ0K
PiANCj4gLT0tPS09LT0tPS09LT0tPS09LT0tPS0NCj4gTGlua3M6IFlvdSByZWNlaXZlIGFsbCBt
ZXNzYWdlcyBzZW50IHRvIHRoaXMgZ3JvdXAuDQo+IFZpZXcvUmVwbHkgT25saW5lICgjMTc2MDAp
OiBodHRwczovL2xpc3RzLm9wZW5lbWJlZGRlZC5vcmcvZy9iaXRiYWtlLQ0KPiBkZXZlbC9tZXNz
YWdlLzE3NjAwDQo+IE11dGUgVGhpcyBUb3BpYzogaHR0cHM6Ly9saXN0cy5vcGVuZW1iZWRkZWQu
b3JnL210LzEwNjgxMjY4NS83NzY3Nzg4DQo+IEdyb3VwIE93bmVyOiBiaXRiYWtlLWRldmVsK293
bmVyQGxpc3RzLm9wZW5lbWJlZGRlZC5vcmcNCj4gVW5zdWJzY3JpYmU6IGh0dHBzOi8vbGlzdHMu
b3BlbmVtYmVkZGVkLm9yZy9nL2JpdGJha2UtDQo+IGRldmVsL3Vuc3ViwqBbc3RlZmFuLWtvY2hA
c2llbWVucy5jb21dDQo+IC09LT0tPS09LT0tPS09LT0tPS09LT0tDQo+IA0KDQotLSANClN0ZWZh
biBLb2NoDQpTaWVtZW5zIEFHDQp3d3cuc2llbWVucy5jb20NCg==

