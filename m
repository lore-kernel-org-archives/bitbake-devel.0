Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BC7C021AA
	for <webhook@archiver.kernel.org>; Tue, 18 Feb 2025 14:32:31 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (NAM04-BN8-obe.outbound.protection.outlook.com [40.107.100.42])
 by mx.groups.io with SMTP id smtpd.web11.20693.1739889145174344221
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 18 Feb 2025 06:32:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=rczsy40h;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.100.42, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aT/E5084cQCnfc+AV1TLejUImOjQn4uHQOP8tHHfYUrNFvKuDkkf7W9KIDbs6KP4oqMODyfPc8w3L5EW8jqmjC7gMyH+vr4fHrWI1MAxACoLecfJLFpq6PjQ4I8zFu+jFZiS3MYwRtLUMp4fu/XKqewBt5BjCJIsiLVGXyA6ZfBGt7ku3+GkfIclXkQV+Sa1xp68IdXhrhqckUrZ0065H2HofKTWWhlT4Fhdh3QXbiRgjlmHJLbHdvksBTcy1iQ8hegt62WdLMNPMcs1dqMTBZwrAZpxs0eCt28cYjQ6LLI2yidrces3JTvN9OIyS1kA4W6fWffcVUx08DxbHBPDig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+LYuT8VZo5uU2e9BpI4QGdi5J+ghtkx/aXPc+qCXTfg=;
 b=jaJVSB90Tfql3veXUEo2e9X1naxpY1OeXL06zw7rEBjhZPhH0idXSt8G+oEcWqACTNEIAgpqbs9r4NYhyucF1d7jEbt9+dSzt4rINjaYjrgzHzsRXjH2AfeovyiwSQ1P/Bxyjc53FzNqVy9Vszm3hZZU2/4IAXQHgdEzt8GZRag6fL9bkF2qIfxl+q486mk5U6rrkKGzNJIxLZ5l7XTKR0i5aJKtLSVn83pXZCcMkMiDRYIyDG5C5yuGCZkF3GytIYDakVokW9cWRh5Ey5BbeWeV+sZZlb4Ccaf8nkFeMrpwQ9EyQy9mpd8RP9PQbVoX4S6SFR34b8Z4ufIrvfhRHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+LYuT8VZo5uU2e9BpI4QGdi5J+ghtkx/aXPc+qCXTfg=;
 b=rczsy40hM03fH+tknnNe4CH0+10NXCxF00zXmS7Yle75Sh32LC1+6qOO5oPN6CMqIDIKFyDzz/ZTvgqtWUmB3svEC2sebfsXFOCBy72FpyYJz18zUtMK/jA0a/neywEb4aBiwv+h9WwDM1hmTna3STWZjBdG11DnekAIGCBeKFvchkzVHcJhFD7bkNn5x3E6/zFnKvadE+wE8PTOwdN9CG0X69Y6dviSRphvMPE+gY2m5jT8hlkMNa9FvmnilQasgFPZTknBGf0XI97zejk4FW9/FqcNnPuKZPZ55TUhMjboO5Dr2MJ9d5CZ3rj+b2O02rDhQ9/6XwL0H4b84uh6Tg==
Received: from DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) by
 DS0PR12MB7702.namprd12.prod.outlook.com (2603:10b6:8:130::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.19; Tue, 18 Feb 2025 14:32:20 +0000
Received: from DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::604e:bc05:9357:c7d7]) by DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::604e:bc05:9357:c7d7%5]) with mapi id 15.20.8445.016; Tue, 18 Feb 2025
 14:32:20 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH 1/2] cooker/event: add cache validity
 checking events
Thread-Topic: [bitbake-devel] [PATCH 1/2] cooker/event: add cache validity
 checking events
Thread-Index: AQHbfyVn0VpHcPwmakS+19cKW2enpLNME66AgAEMH7A=
Date: Tue, 18 Feb 2025 14:32:20 +0000
Message-ID: 
 <DM8PR12MB5430BFB03252DC445A20E1498BFA2@DM8PR12MB5430.namprd12.prod.outlook.com>
References: <20250214211403.493573-1-chris.laplante@agilent.com>
 <30f3b2a2f541485d0f8762d76deec6e1de94dcf1.camel@linuxfoundation.org>
In-Reply-To: 
 <30f3b2a2f541485d0f8762d76deec6e1de94dcf1.camel@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ActionId=ff1f53de-6256-431f-a5fb-eafa0e57bc38;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ContentBits=0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Enabled=true;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Method=Standard;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Name=General;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SetDate=2025-02-18T14:11:47Z;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SiteId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=agilent.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5430:EE_|DS0PR12MB7702:EE_
x-ms-office365-filtering-correlation-id: 4975942e-4dd4-4de5-1170-08dd50290d6a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?bGRPbUdtRW1TS1NvTXdOcCtEQ09xNnI5TnVWVVhyZVJsZm96UlBRZFFVK3Mw?=
 =?utf-8?B?SXZ0TFEyYzFqcUQrbjlML2lldTVYcDJlNHBVOXEvbXJDYVdScjVYVTFzc3Fa?=
 =?utf-8?B?a3AycVlZcDV6Z0FtbU56ak04cTJHTUh5c2xZRjUrYkJ5WnlQTFNhZ3d2aS9U?=
 =?utf-8?B?Rk1LQ3ZOTFEzd1p4Y2pWN2NzNXlJdUVjYUMwZTZHY24zb1pldWdBYmgxenM3?=
 =?utf-8?B?Skx4VzNKd2o2MHorTEFyRHB0NDN1UUpTKzJFd0pXUmRLNFRuUW54L2VkNVh0?=
 =?utf-8?B?aklRZ1RYbHdkSnhic1piVzRqdzFhUytaMFNOdW96QVo0Mnc4dW0wZUpKNnBa?=
 =?utf-8?B?R2ZFWk1WdjNRR3doUVdHVzIwMXNXa3NvZXZPSVhHNUsyaG9udnEvOTM3eEVI?=
 =?utf-8?B?NVhQZGs3WlR5TWN6ODB4eXNRWW1ZT1hudmNIM1Q1cFgzQVorQU96MzAvbFl3?=
 =?utf-8?B?cERsMVFaUGoyMkt6eVNQWTJNS201c21qSnJXKzVTeTE4cmVFZktsaWJ1dUxL?=
 =?utf-8?B?eGZCV1R0d0UyTzBZQjh6bCtVcUJscTdwRnlVOFZJbTVOK3VoTXI2VlRrcDNM?=
 =?utf-8?B?UGUrVDMzNHVzSXRjWE5ySkZxdDNHTjNhU0N2QjFrNnBmbS9xbXlxc3hWVXFR?=
 =?utf-8?B?SUp2TkdpTllOYlJGeHh5STR0ODJpdFJQL3pad0R1WDMxcU51OTBiWnJaZkVi?=
 =?utf-8?B?WitQSmYyUEJmNCsrSVczTUxnbkVjZkUxMDRCeU5NRE9nZkZVcCt6YkZsMjU3?=
 =?utf-8?B?UHA1SDBuQXM1RytRcWV0WVVpbktvSlBBakhoVTlyWC9XeTZRUENYR2ZLV3Nm?=
 =?utf-8?B?UmQvVlYwZGpkTGRiN2Ywd2NsZlNyK25pOU92cEZTdnF1ZFVuWWV2eWZkYVpF?=
 =?utf-8?B?ZE42Q3NmTENGc0M3dmdERmphM0M2cFpLVmJLcUVIL0hGYVJ4TXdqQnRab2hj?=
 =?utf-8?B?c2V1ZjdVV3pkTGl2VFdBMTBjZHN3QzRSZk9taDVzR1dvTit4TFg4R0krQ1Q4?=
 =?utf-8?B?cTRVZmxuU0ttdEZsS0ZYVUozTXhCSGZ5UmFUc3pkRmZwYlp1Q1hIVzQzRUdT?=
 =?utf-8?B?V3RwSGMyTVRsdHNEZEFOUGlkaFJVbjYvVkp0NUFCOUp5WWhneU9LYWR5SGdH?=
 =?utf-8?B?cm5Cd1QzUDFlNTNjNmwxaEM5MGRhRHJZT0UrcjZxanB1V1dWMENwTk14TlRL?=
 =?utf-8?B?UXcvNXBKcGpieFNYZ21oaWZxL0dTZm1OMXBnN0pVZlgzbTl3b2xzcGlpc1VE?=
 =?utf-8?B?R0R3a2VxaHFZVmNac2hvQWlUOEtPY3U1dnhEVEMvSmc0QU52aStyY0FXWloy?=
 =?utf-8?B?ZlJJbEw3dTJyTlpFYmx3STNXdWhENStJMUZrSTJFeUc5cXYyWGVLSmN4MVhT?=
 =?utf-8?B?a0E3cTI3U3ZJWTFSaFphSTVQQTBqd0czZXRxMVVOWkNZRnhPRmtCU0JoNEhl?=
 =?utf-8?B?L2dhbkJMN2ZWdDQ3RExoTE5JZlRTOGp2OGpxa2Jhcm1QdnR2QkRjZURhdEc0?=
 =?utf-8?B?eXdLNlRjNGtBYU1vZ2RNbXYyUFNySklyckNkU2dyT05hT2xrdXhzRUxxZ2JZ?=
 =?utf-8?B?L3FBalVST0R5UnFTKzBwREtvRXl2ajVINDI3MlFISjlaU2xpMlZtMXlzRTdG?=
 =?utf-8?B?ZVl3YnRMUGJwQ2QrdHJ0OHM0K1l0eTg5TDYrKzBNaXdqaEhoSGgrVEpXT1ZL?=
 =?utf-8?B?c1dDMmxjdjBOQ1FRbnpBTDNjUzZ3Vk5MbzJCV3VSR0dqU0hMRnpIY21ZODlW?=
 =?utf-8?B?Tnd5dnpoNzVKc3NhYlpVMDJsTG1uNHBlRFVVbGIwMnF4dmlWS0FpNFEybHBK?=
 =?utf-8?B?aUZTdm84dkJUT05QcDF1eEFrcHZCbVJrWUJqWHZId2JwQ0w2bVU5eHNXKzgx?=
 =?utf-8?B?bWVJa1A2QUFiSGJDZ2NDNG94citMSkR4NHM4RmNjVUUvdGNWS05HVmNGSlhV?=
 =?utf-8?Q?KHRGe0Ux42pYOnkOMz47Qi7MRtueFMuy?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?MytteVhQZzcvM1NzUk1wcG1CZWUwb1NPZnlya29KRFpZQUVxaFZCL3REWUdM?=
 =?utf-8?B?Y1VQMHg5QmN2Ym5qdWh1bm5CMW9oR2hWMlpqYXFYQ0g5cDBBMHJucGhIR0sx?=
 =?utf-8?B?S0VMbXRXaGd6eCtrTHZxK3RIMjVINjBlWmdLR3pJSzV5SHUzYndiUjdPVVpG?=
 =?utf-8?B?enhNRmpscHp6cHcxWitGUlJ1SzZxTzJaUnlzbHBlc1MwUG1Db2hJQUNrV0d5?=
 =?utf-8?B?dXdZNzVKbWdpUWdmdyszZDZWWXpaY25HMEgzeGprSHppUGFic3FlZDNHd1JN?=
 =?utf-8?B?N2ZickYxa0dxQ1kyYllSSjlJWmd6Y2JCU1VaL0xGQmFLQWp5bU1kMHAwVkJm?=
 =?utf-8?B?OVE2QnVUSGI2MGNkTXZmTndQcUVuclU4eURaTjhrM0tlRXB0M0xZR3lQNTlR?=
 =?utf-8?B?RGxVSXQzYWIvdG9sSEpBR2JZdEIvc3VLeTIzMmhWYWdZRWNqUnU2WFVodFdP?=
 =?utf-8?B?K3IwZWgzdjRsWldPcURlVmFlTGZQQjNwVldHN2taNW10aGFCRlg4NkFCSlJK?=
 =?utf-8?B?Y3VoRDdzR0xIYmJKYnpIaUx0Rm9jTU4yUHFWQkNLU1VkY2NZVWxvOW9BVUpT?=
 =?utf-8?B?T3A3WFNQVzhxZkVxSVJEQURYdnFCMmxpYVpGV1RhVE41VmdSQjNjZm14Y1ZF?=
 =?utf-8?B?N0h1QWxsZ2paTnhYdDZXa21PMkdwRUhYblVac2N3a2xmSTZYZngrT3Z2SDcx?=
 =?utf-8?B?MWYwWkFEUVpidFhSRGM1Unc4T2oyblBjWWpwUWNTZHZuTERGdzJ1cmMwcXYz?=
 =?utf-8?B?c2NvNTUxbVJTdGNQWndGR2Z4T2VIVEt3dlNwc1BiRndQazdidDFRRHFjYjhD?=
 =?utf-8?B?cDNzTDZlQmw1K1I3U1lub1g2Y0x3WXVrR3h0dENpaVQyT1R4bDlQY3pLRjlG?=
 =?utf-8?B?em9WNy9LZWhYemVpUnhhZGw5MGRqclNCcWpMWXNrajdWRVIzcytPNklybWNW?=
 =?utf-8?B?ZnRpcXZFTnBYWFpFZTIyQlhsU2Y0TVFUU0pLMkpaekRCRCtoN293WHYxMnky?=
 =?utf-8?B?Vm5WRWVOd1B1Wm4rOWIyMjRCb0I3Rmg4dHMwSmh1a2cyMFA4ek01ZlgwSGNX?=
 =?utf-8?B?ZnQxYXo3VnBXRWdSeCtDanUwSnVFTnJOUFJrOXp2UmZmamxhaWJBTzg5eWQy?=
 =?utf-8?B?cC9pb1VydS9PTnVWMTFWLzBXWDVpK3B4aVdiL0h0dmY0R2JnQ29vWGsxVnQz?=
 =?utf-8?B?c1Q3RkdqYlFBM1hCU0xqakx2M0tmbXZjVERNMWtYTFk0NDVEUWRDeEl5OXg3?=
 =?utf-8?B?UmJEQlY1N29aVDNWUXAzQTRYUkNHN3pQRE01ZTV2aExvcjI5eEZWTUFFQlFx?=
 =?utf-8?B?bXNLTkdERHZHOHg4TGo4d3JpMUg2NFluNGF1R3Z0enIrdkV1SE13VDczTEJC?=
 =?utf-8?B?OHFJbExiQi9yU3NCbHY0VmprUTBSV29xemppdUJ2bzhKd2t2d1RLK0xOaWtK?=
 =?utf-8?B?eTlpVzd1OG9MOWwrdmFlSytWWUNLYVlYNTRWWmt1ZjI4aUZRNDlPanNUTWpv?=
 =?utf-8?B?bVZJcFhxbUhKZzZIQWdoYTNCOXNFMzJRUnVXb0lFajdVL0g3N2VNRE9MeTd3?=
 =?utf-8?B?TThSOU1nejdYbDJmcEJFclBTV1ZRRXZKeG8rQzdRVUFTMEFhV2lPa1oxZEYv?=
 =?utf-8?B?MmdLYjNoVlYwQUtGaUVXSFBEQ0VLQ3hod2Z5eDQzNXMwbjNaZTFTWTBnMnhj?=
 =?utf-8?B?ZmN6Wlkyc2lTV0JaNXRXOExiNVpwamcwVThEdDlWZXJqcjB6ZHkzVWVBVnln?=
 =?utf-8?B?aTZybCsya1hGR1NzWkZ0UkpTOWs3NlJHbVNaWlJMWXREcHVuWE9JMTN2OFRC?=
 =?utf-8?B?MGt5amhuQ1ZzSHFKTis0aXU0QVl0eWtCZmRzMHJCeG1ZYjNsUXIrQkgyWGRZ?=
 =?utf-8?B?aW9kUUlwRkltUFVZb0VzbVQrK2dsT0FUaU03THFWaVhsNnNaWENBZGkvbzNi?=
 =?utf-8?B?SDhYeEt2MzZ3OWI0c2pBK3llMHZVelNmM083VUVLRk1NUUMrMEFIbHQ5NEdm?=
 =?utf-8?B?WkpiWHUxOEZCcmFwbEt0eGZDbTk5anFYSTVCRXArTkFaNXNGWVZBZk9Ca01h?=
 =?utf-8?B?b2NURkVoQzNIeVNJaFdoQmVQdmdveTdBSGZCbC9VWTY0ODNKaHlmOUdEclhQ?=
 =?utf-8?Q?92IlwjutSvy+/KHJ7WhA3P78d?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4975942e-4dd4-4de5-1170-08dd50290d6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 14:32:20.4990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gz9gkZCjdzyEYWOBfQD59edU0FWH3rEn/mQs3WDGLgyB4NOgw5bpPqqDLxdiAXAhhJvIbkCCg06hgTtHH5b1Sx8wwXBLUDZgAgA5rwgDbdM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7702
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 18 Feb 2025 14:32:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17242

SGkgUmljaGFyZCwNCg0KPiBJJ3ZlIHB1dCB0aGVtIGluIHRoZSBxdWV1ZSBmb3IgZGlzY3Vzc2lv
biB0aG91Z2ggYXMgSSBrbm93IEknbSBpbiBhIG1pbm9yaXR5IG9uDQo+IHRoaXMsIEkganVzdCBn
ZXQgdG8gbWFpbnRhaW4gaXQgYWxsIGFuZCBteSBvd24gdmlldyBjb3VudHMgZm9yIGxpdHRsZS4g
SSdtIGp1c3QNCj4gbWVudGlvbmluZyB0aGlzIHRvIGlsbHVzdHJhdGUgSSBkb24ndCBnZXQgdG8g
c2ltcGx5IGRvIHdoYXQgSSB3YW50IGFzIHNvbWUNCj4gcGVvcGxlIHNlZW0gdG8gdGhpbmsuDQoN
CklzIHRoZXJlIGEgZGlmZmVyZW50IG1vZGVsIHdlIGNvdWxkIG1vdmUgdG8gdGhhdCB3b3VsZCBi
ZSBlYXNpZXIgdG8gbWFpbnRhaW4/IEZvciBleGFtcGxlLCBpbnN0ZWFkIG9mIGRpc2NyZXRlIFNv
bWV0aGluZ1N0YXJ0ZWQsIFNvbWV0aGluZ1Byb2dyZXNzLCBhbmQgU29tZXRoaW5nQ29tcGxldGVk
LCAgbWF5YmUgbWFrZSB1c2Ugb2YgdGhlIE9wZXJhdGlvblN0YXJ0ZWQvUHJvZ3Jlc3MvQ29tcGxl
dGVkIGV2ZW50cyBkaXJlY3RseT8gSXQgd291bGQgYXQgYSBtaW5pbXVtIGRlZHVwbGljYXRlIHNv
bWUgY29kZSBpbiB0aGUgVUlzLg0KDQpUaGFua3MsDQpDaHJpcw0K

