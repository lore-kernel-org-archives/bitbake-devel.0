Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7D4C87FCB
	for <webhook@archiver.kernel.org>; Tue, 12 Aug 2025 15:12:04 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (NAM02-DM3-obe.outbound.protection.outlook.com [40.107.95.42])
 by mx.groups.io with SMTP id smtpd.web10.77545.1755011519750478563
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 12 Aug 2025 08:11:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=tqkUMra3;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.95.42, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oft6nPqzFoN55ec4W6SXphovZcQn1OR4hR5sU+wAPhJGOipvRn/fFhgsa6fggURc57wmFlg9tqjkAotbNPIKRqxh0DrQzzXyGYp1Tyuidict/BUoI7VZocaUuc/Plg/Cfl4qVaROcQfQTpATOecisaaKNDGwYEBZ1Xwx8bbxvyYNpLu5WmR4SV/0NYFohd5xJxLvlFYfDfmQt0MyhfWJNIMefS7SaSx16KdCToSKic9vQzeBiluunV5lzK9B/XSvFJI0QbgA3J4Nebglk0D3xCFCznR2gfoYDMuZ6efA1/wJRaKf7alQ4fEBztCWSaAbERCo7OedMPqbrfevKnogpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+0U8fBw5euyi/Dri3RHL9rtaUu7eSP+Y2A6UlxZ+/8E=;
 b=aXN7XTKVC/Pk+0/z2K9ha5VeKVTXxpotde0Kmprf+n0DrM2Qw/sSHz2xon38P3j2AtENx2TQFQn9qg5YguoGmz+RjwZkmX0V8dHsUSHEovaovKA6p4zGQC9ysIhg6AwpZF6eVqAgyhWa8lNnDEDHjUTy3z/0/WsJQCcMfmgeT1mSeuCBN05I0HEX/6iye+77Jst5n69Jg/EO3DMA5s51cGIth23vQ7RuB7viKRoIjEN1edGyZj79tpxUO8561AMV+GAp5JtKYnxEwcvzGf8RMZnD3i/h1W9i+gkG6Kqd/Qb1n7215m6F0QA+n4D1I85vA3A0xBwAolOhpTvnduokuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0U8fBw5euyi/Dri3RHL9rtaUu7eSP+Y2A6UlxZ+/8E=;
 b=tqkUMra39G2uno/J6sUvZf6qTQFV3NHU97hnfM7WiA4QAAXUCxntNEXvT6Mrgu9U329iWyiNjoDNxWzPpGBMGm6/NoCR+lHDuu/0i7Ti3pvo261nEx54LHj04aeTYAgUFEsPW+XX0j8/ltT/71ewwIReSG1GpL8X1T51mY42xvt9xtDHYaaQk/pTeNtJE+erHApCeZtLgeuFn8TG3YVtzJbMv3idiRYoig2NIKmYbyXOJm6Nc51y2un3LsoGDju0nX7evtsf802VaZAqPjNSbC4D+ib6p7p+SNrW2FG9MWauTkaDtqNErxa4qKXXt6lqoq2uv/wUrEoKib5E4sSpVw==
Received: from DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) by
 DS7PR12MB6168.namprd12.prod.outlook.com (2603:10b6:8:97::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.22; Tue, 12 Aug 2025 15:11:56 +0000
Received: from DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::604e:bc05:9357:c7d7]) by DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::604e:bc05:9357:c7d7%4]) with mapi id 15.20.9009.021; Tue, 12 Aug 2025
 15:11:56 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: "richard.purdie@linuxfoundation.org" <richard.purdie@linuxfoundation.org>,
	"mathieu.dubois-briand@bootlin.com" <mathieu.dubois-briand@bootlin.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH 2/3] event/runqueue: remove unused 'd' arg
 from check_for_interrupts
Thread-Topic: [bitbake-devel] [PATCH 2/3] event/runqueue: remove unused 'd'
 arg from check_for_interrupts
Thread-Index: AQHcBuHhvp7hYqECbkKF0bUxeHKY8rRWxoEAgAAAf4CAAF9D4IAHnOAAgABlxNA=
Date: Tue, 12 Aug 2025 15:11:55 +0000
Message-ID: 
 <DM8PR12MB5430C01957449F87B4BF68918B2BA@DM8PR12MB5430.namprd12.prod.outlook.com>
References: <20250806145308.2052128-1-chris.laplante@agilent.com>
	 <20250806145308.2052128-2-chris.laplante@agilent.com>
	 <DBW0984EY1IE.31I0NJ43GU7N7@bootlin.com>
	 <DBW0AL5OM8CZ.1J05XYFYPMZ20@bootlin.com>
	 <DM8PR12MB543077160D85EADD9D5654358B2CA@DM8PR12MB5430.namprd12.prod.outlook.com>
 <f371c3b26e57f5dfad8b5ee109e1eab8852d6095.camel@linuxfoundation.org>
In-Reply-To: 
 <f371c3b26e57f5dfad8b5ee109e1eab8852d6095.camel@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ActionId=b91cd7e3-a8dd-4244-827e-b201da84738b;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ContentBits=0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Enabled=true;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Method=Standard;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Name=General;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SetDate=2025-08-12T15:11:10Z;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SiteId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=agilent.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5430:EE_|DS7PR12MB6168:EE_
x-ms-office365-filtering-correlation-id: a438a1a9-3c78-4516-f9fd-08ddd9b29395
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?TEU3VXo3a09BcExXdkRsYnYyZ2RNUkE0K3JJUjZxemtLZHRaKzZNTWVKUWMr?=
 =?utf-8?B?d0ZTbmhldnlsRStabkVqamo2Ti9zTk8xMDhHeDlZa3lkSHJuWjAzOHBVU1Vi?=
 =?utf-8?B?cmxZaWFFYXoxaFNqK1ptRW1NQm9XUk0zQ3FkanZXemNwYkJOMXlNeWlCMGVQ?=
 =?utf-8?B?bUg0NkMxU24xUVo0aGdpUG5BMHNXZFRicWxxb1pSQXRYcE5JdCtRTklWcE1Q?=
 =?utf-8?B?T0I4ZkxmREIraW5nRU1mY2pwdmViY2xDQ3dicStiNkVLdHFWVFF6c0EzSnZh?=
 =?utf-8?B?VVp3aTlKSCs0dU0vaE9SQ3oxVFJpM09nUUNWd3poN2pFOU9MRmY3SGdCOW5r?=
 =?utf-8?B?ME9HZEU5b2JVOHdrU2wxamYrQUxocE9Nb21lanJpK09Ubmh5OUJnbXlPNkVw?=
 =?utf-8?B?c0c2bms5Q1A0UWdJR3YvWUZSRW9tRVllVFFNb3JXK2ZJcEs2Qk5JQ2wwVGlo?=
 =?utf-8?B?MFY4WVdzMnpmbkNiWW91UlhyU2o3cVZMd1pwSFZ1R1BzTkZlUHcybTlOV3lq?=
 =?utf-8?B?Sk9jSnR6RFpmdVhtRmtaZXRSaVQ2N091dkN6REZ2NGwybEJSWDk2T2hiUE5X?=
 =?utf-8?B?R1liczhNczk5d2VCWEZGSHlmZGNqOVkyTW9NTUxVUVZjWVNYdzZ1Nmg2Qnhj?=
 =?utf-8?B?VzFHSmE1RXlmNDhBY2R4MXNEWFE2SlFEb2NUOTRLL1dUaHNQaDFiV0VRb0k1?=
 =?utf-8?B?M1RqYzl2bDkvaXlQeUZQQ1hrSi9IYVNzdVl4Y1RCOUhpNm4vVnVOV0xlTHU1?=
 =?utf-8?B?NTdqcW92aUNmc1EvWWp6K0ZqcmlQamJ3eHNqbUNvakg2ek9rV1NlcHdoUXU2?=
 =?utf-8?B?T2hncDNJREE4b0taS21Md1F5S3ZWa2VWZ0pJY3ljdmRUMFRFKzh2Q2lkY1ZF?=
 =?utf-8?B?aWVRLzh3RjZwbm9RcXpqdDNLSDBMUlIxVlJJeC9OVlUrQUo3bWFhVnoraGFD?=
 =?utf-8?B?dFdYaGthNEcxSVZsTFcyZUNtSzVPc2hCUHlPWldpbjVKTElQZ1RTNVcvLys2?=
 =?utf-8?B?Z1BsYkowRXY1THl0dHgrVktyNGt3OVdSdnlWbUoyRzBQLzQyMzQ0TVVvWVVT?=
 =?utf-8?B?MDRIM1pZdnRORDloZlNRcmdEZWJnRVpDTzlleFFEVmx6WG5obXI0QVgyZCtJ?=
 =?utf-8?B?Z1ZYdHVrK0VxSUZZUk95Y3phdVpLQXluUURXWlhuQWJraWQvSk9PQTYwOEZU?=
 =?utf-8?B?SzZqVGdvcTdlZ3F3VGU2KyttQUdsZDdxSlU3QXdlZ2Vja29lWjE4UEpQUk1V?=
 =?utf-8?B?Wmg2cWZ4RUx6Ymk0VEFyamZsK2xLSVpWVTV6MWloN1NISnhDNWRrWENCQ29R?=
 =?utf-8?B?UU1RbWd6Ly82K0ZkVzNRdzUyVkQ2OWpHU1pwRmp4ckxETHpDcWVIcVFFdTFH?=
 =?utf-8?B?RjRKUGthU3J5VG0xZjk2MEp5V3BqNDVZWDc0YlRMSWVXOUhnZE5EM1EyK2J0?=
 =?utf-8?B?UUgzKzgzNWhDSkdUMmtSKzRSUFhySkFvSHc0Zm1jdGEvWHZrUk1aZEd0RlA0?=
 =?utf-8?B?RjJvUmFHNkJSYi9YcTk2eFF3ejgwK1NrSVRPYmZzZVdXdmJ3c1UxOENzRFlF?=
 =?utf-8?B?OU12YTA2eHByeW13UTBtMFhRUTQ0WE5EV0t5cXRuazdPbjlVbzFXYk1lQ1lV?=
 =?utf-8?B?NEc2NnpEVjlUMm9Ka2J3alkrOW5FN3dmNTh3d1RLWmFLMCsvS2RYUVhYQi90?=
 =?utf-8?B?QUNieTZrWlFqZVgxSXQrblFXR2x2R29JTW1ZeTZoTEFiU1hSVE1WUFJxQWl3?=
 =?utf-8?B?ZWJxc2NHK05EZHo0Ym5Rdkd4OHIvVXdreHR4TFhLMVorb25sZHlTU05KSFBX?=
 =?utf-8?B?U1B6djlka0NBR2cxbHpFcDlxWUxWNHdCT2VrUUlJYWo4U0JhVG5hcnJaUTZL?=
 =?utf-8?B?N1I2dFZWUy9hM3FkSVY4REtpZ0xsbi9maG5ETDNhQUdpR2RuT1lrSGI3WnJL?=
 =?utf-8?B?RkNiQkhMajRFeDBhdjc4dnNKclFUbGd0eEVlbzl4NkY5S1hmWGl3NXRJa2gy?=
 =?utf-8?B?WWpFRGh3OVpBPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Qjl1VEI3d1B6SGNTaFhJTFNpT1k4OEVweTlDRmVRUzJyUUU3VU9ocm1LQlBn?=
 =?utf-8?B?d1VRbS9rVDZyZkllVFBnR2xtbkprMUQ1ODdkZjVncGUwRFQ1WENwUkQzaFU0?=
 =?utf-8?B?NWFMWTluTk5oRVh3dlU1NWlTbnBoZ2x4SXhlZ1paQXp0b0w5RUJKL0VkMmhj?=
 =?utf-8?B?YVhnK0F4bGpQbi9JQmdadnhIVTRTTTFhN3V1M3JqTFRURHFuK0FNdk0wTjJT?=
 =?utf-8?B?K3VobHhTUmpIaXlQUmR3V0plQzlxSWNVdEJ5aFNwSkZrMkZDSzltakVQa2ZF?=
 =?utf-8?B?a2VNRnpzWno2ZjExVjh1eDl5cWhyTmVXbmJybkdzRVlJL1B3QXprQzVUTTlh?=
 =?utf-8?B?NXhPZjZWOTc0WTA3R3pJTHV0SGV6cGZOWmdzT2VkVzVzV3dpdENlSXlST3Bo?=
 =?utf-8?B?Mzc0OGlxYTJ6alBCdFdSbExTQ0k1UThQR0hjSGhkZ0NnaGtCSU5KMG53WC9V?=
 =?utf-8?B?TVlSdEFjTmlKbzlua0pMbXNoa1ZUb2dWaWsxbmFORUtweEwvZVhTMHZRbzBD?=
 =?utf-8?B?Z0xpK3dWS0NId2JFQzRoMEtZV2ZvUm1wNFlWTEhaQ09xcjNRZHp6YXY2YWdZ?=
 =?utf-8?B?czNXWWxYNS92OHdJcVZKdDcyWFJPT05hK0RvekR6OVdjZEJiN2l0ZnNYQkRi?=
 =?utf-8?B?Tmw1YWpSTzR3RURIYVk1cHBFL1puWmo2L3VRS3ZEbkRTUmtqcmVsdEVxQ2R0?=
 =?utf-8?B?WUR6QUNORHQ1d3pXUTFsYkVsRXdBbFgyTElPVDNlS25PeWtBY3BYL2hPZkhD?=
 =?utf-8?B?YVBpaWxHTmJZNXYrS0lDdzBRbG5iTzlTZnQ3Y2o5TXVsRzJBV3czVlI1SElQ?=
 =?utf-8?B?djh5YW9OSStRZVZkdkdqUVNveHBpMGxwSWNlUzcrLzhkbHFPUmhNczRCeGVN?=
 =?utf-8?B?WlhIc2ZqWlBiU1h3SUt1ZXIzSjRkKzRTQWtRVlY0a2tNT1diL1VSN0FLTkxP?=
 =?utf-8?B?Rlc3NldMSU1MV0xxSVpIMCtIYVJQOVZ2Vk1VZXROYTFEU3YycFpzcW5JU29V?=
 =?utf-8?B?aVNUVXg3cVo0WUthRXdyWHVsTklLaGErZVI5dUM2K2IxeFkrbTlHbW1vSXUz?=
 =?utf-8?B?cFFicGx3SWxCV2F5SHk5eEIxOWZrQTd4UDduaS85M2hmQ2ZKQ2xuZjlRY3ZD?=
 =?utf-8?B?WlhIM3ZnZlNad1lyM0dQMzNxaU00MnRYNzN2TkJrampHWWdFcGZRaklXcGRs?=
 =?utf-8?B?TkorYkgyeFBWNWl3MnJCT1BkanlSaVg5RTUrbDNNdlR0QzlpOEtCL1BDSDRw?=
 =?utf-8?B?YU4wbm9FV3VwdnRmSDRGQ2dGbnEvWi9vMFdydXBxTG82bzJJRG53SER6U2Fx?=
 =?utf-8?B?ajZTNVA5dzdhNkdTd0krTFR5Y3BpU3RJcHF3Q3JVK0FmUlUvMjhhYnNBQXZQ?=
 =?utf-8?B?MzFWdCtDYzY3V25CNkpTV0lLTldka3FSeGdITEJJYkcrQThWKzhsRStyUDJ5?=
 =?utf-8?B?enNaelZKaTF4aFVMQ0EzSHpVeU0vNUVPK1Q5dkVNYXNWRUF0M2wxVW5Yb25W?=
 =?utf-8?B?Q0svVU1jOEwvYkMrdFlwZjREV0QxNWRLUW9idFNuS05FUXkwcm40NWFUeWhV?=
 =?utf-8?B?cGdzbzRaQnFXMkZJY1JrdEs0a2NrTk9qQkp6R0VyaTFkWERwRUpaU2dCY2tW?=
 =?utf-8?B?bU1ubmhQSG15ZnJoOVNwMVFEM2REUXRXOENBWkEyMk1kTDdzaHAyenJCb2lq?=
 =?utf-8?B?cEhuV2tHV0lkbTQvTVdNREpGd1VEY2lleUViUWxnTlpUMlUvZFlScmpIZXNk?=
 =?utf-8?B?S1psMVlNb2xJK1hPcWhzV3g5WEtuRWhIV01wYjRVR0ptUHRxZ0kvNGdsUisx?=
 =?utf-8?B?bHlVRU9pbyt1OHJ4bGx3aE5qTVlXYmkrYW1IN3RjZnhkQzRKS2czVFYzcnQx?=
 =?utf-8?B?aG9qRUEzMS96SmJTSFh0OFJGVDgvNFdhWlZRbWZxc1dobE12V3dMeVdnaXFP?=
 =?utf-8?B?aThKKzNYcmZHMGc4Q2pGZW80Zk1QMUxuemFPNExTV09XWUFkbTAyUDN1UTRa?=
 =?utf-8?B?alVXUnQ3eGZaaksrNFkwVFM1eTRDR2pVS21MZTc5WFluaFU4SzZ6Zml1RFZW?=
 =?utf-8?B?NWRmUGw3VGhjcVBBQm0wcXhYODQzSHMycGtOV3RzdVRKOVgvbUtDSVNBbWNK?=
 =?utf-8?Q?F/DJh8epwo5K8SxoFknYFCEsj?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a438a1a9-3c78-4516-f9fd-08ddd9b29395
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2025 15:11:55.9528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uKGSA75ikgWZ8ODgBniqodwHTR7gKzJ9yDRqJIhPTLQ0QRKhU5hVtAAJV526iGcRXNMAsn5QJXmf8rKMC2OAngMfTFAcZzn3jJBWnGi5TT0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6168
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 12 Aug 2025 15:12:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17871

SGkgUmljaGFyZCwNCg0KPiBSZXF1aXJpbmcgZmxhZyBkYXlzIGZvciBjaGFuZ2VzIGxpa2UgdGhp
cyBpcyBhIGJpdCBvZiBhIHBhaW4uIFNpbmNlIHRoZXJlIHdhcyBhDQo+IG11Y2ggYmlnZ2VyIGNo
YW5nZSBnb2luZyBpbiwgSSd2ZSBqdXN0IHRha2VuIHRoZW0gdG9nZXRoZXIgd2l0aCB0aGF0IGFu
ZA0KPiBidW1wZWQgdmVyc2lvbnMgYnV0IGluIGZ1dHVyZSwgd2UgbWF5IHdhbnQgdG8gbWFrZSB0
aGUgcGFyYW1ldGVyDQo+IGNvbmRpdGlvbmFsLCBvciBhZGQgYSB0cnk6L2V4Y2VwdDogaW4gdGhl
IG9lLWNvcmUgY29kZSBzbyB0aGF0IHRoZXJlIGlzbid0IGENCj4gbG9ja3N0ZXAgY2hhbmdlIG5l
ZWRlZC4NCg0KU29ycnkgZm9yIHRoZSB0cm91YmxlLCBidXQgdGhhbmtzIGZvciB0aGUgZml4dXAu
IEknbGwgYmUgbW9yZSBjYXJlZnVsIG1ha2luZyB0aGlzIHR5cGUgb2YgY2hhbmdlIG5leHQgdGlt
ZS4NCg0KVGhhbmtzLA0KQ2hyaXMNCg==

