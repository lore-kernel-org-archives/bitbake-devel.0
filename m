Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A2DE77184
	for <webhook@archiver.kernel.org>; Tue, 17 Dec 2024 14:27:48 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (NAM11-DM6-obe.outbound.protection.outlook.com [40.107.223.62])
 by mx.groups.io with SMTP id smtpd.web11.82992.1734445667600406845
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 17 Dec 2024 06:27:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=ZDIuszu7;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.223.62, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g7FSEShSgCrAg924+KCsqVvxFtj9pz8e43uhlhkc3cZ/8pbLwQkFmTss/kKqw8UV+N9GpLrgtU/UFt/MZ7+XT0jab7EyXP1d6n7PyiMdBhji5J4Uc7+KYgAVODW+h98+Ci9ncbXqAQIpTLUA7Mu1yoGSvTTzJgejlsl9NgxKY7MjOJlF8KNDghu0TOWWYMSdN+Htcm51da25CJp7Fvr2VYIcsYAWBGm05N3f2CPU/WhSAr2c9BhXKfylg5tt+TwJ92rQuc+yscFN0y1spO6UY9napgM4nqvzNV37NV4vwllN9gauLggA/szcky1B4DQiyQaZUfKBpebfqmyVgV581A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJgTFYcqDxoE7W7mqkEfUmjV1nrIREo+ZnTdvqsCl7o=;
 b=x1lRfixQLcwCdJfbP2863n3oHpap/Iz+xsLg1Frndkrvby+jaI470/j5fHIMIpuPDhPwxH+OiIZvaArRXrcc9VYQ+BLLWsR93a8jXCcrwOVb02TO6FKbR8cud63SQrBdkpyBH02jOSkZv74mQdLXGirpt047xr1tLSD3Q+yfrlEByUc6Gc7bh5ZaEi2QY+MpylsQ6e5kPa7bkqdLkgMDUeS+Cw61XV0T13GM/qkMhpeVQVH/3yQ5MehpFRjdCY1GfSIXuGgeRihXZ2pgS0iLdh+9sh8ozWla9lazWDr89+TqFEQY1fBbjq7h7DFlYe11d9AJWMY0YzOl9/Ph/FEtDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJgTFYcqDxoE7W7mqkEfUmjV1nrIREo+ZnTdvqsCl7o=;
 b=ZDIuszu7xJRuuSQr2/r7mfLFocGS67HslR9Y5iksQd1dQXfP5D5gnVF5c1ex7EvuwpenOkI2nRc1d7dkqfxQV3EgIUHsZGRgtKVXs8bYhAiHfqTxM7Wxh3gDbZ/T1GV47Mq61o8Yei8xvOKDd0SbNQGst/mtxHA8iAbGqAfiMw9DtUOArh5WNJeiTaCJCRp9EVPNREuZV4VBHz8JQ85JV8DFGUSOnfKi164aT0LfddadG3lFLqqKnmSnNwA235ROtm/4Nz2pEewKO5wC3rC8n1zq9S4DSSEv26ENBJJB64WLuOuf79R5j1q6HYMxWZAYBoFZBuqzV1RLEr9E5Ejnug==
Received: from DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) by
 PH7PR12MB8037.namprd12.prod.outlook.com (2603:10b6:510:27d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Tue, 17 Dec
 2024 14:27:41 +0000
Received: from DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::604e:bc05:9357:c7d7]) by DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::604e:bc05:9357:c7d7%5]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 14:27:41 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: Alexander Kanavin <alex.kanavin@gmail.com>
CC: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] Potential compromise on adding type hints?
Thread-Topic: [bitbake-devel] Potential compromise on adding type hints?
Thread-Index: AdtP5KtnnMdrNAiwTgmvqLEZTRMWqgAJYkwAACCIRXAAAJRCgAAAB33g
Date: Tue, 17 Dec 2024 14:27:41 +0000
Message-ID: 
 <DM8PR12MB5430184800E9225BC51F8FBD8B042@DM8PR12MB5430.namprd12.prod.outlook.com>
References: 
 <DM8PR12MB5430AA0A8523E4086243CEB28B3B2@DM8PR12MB5430.namprd12.prod.outlook.com>
 <df46a810902511e9427023e23663c74f5094f16a.camel@linuxfoundation.org>
 <DM8PR12MB543038304FB52F448BB740078B042@DM8PR12MB5430.namprd12.prod.outlook.com>
 <CANNYZj-bJu6YteYxHDMc6cu+3J6zLf_K3pPaAyBew6ys-Cdr_A@mail.gmail.com>
In-Reply-To: 
 <CANNYZj-bJu6YteYxHDMc6cu+3J6zLf_K3pPaAyBew6ys-Cdr_A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ActionId=639b277a-7324-464f-b42c-9b42a9db77c9;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ContentBits=0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Enabled=true;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Method=Standard;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Name=General;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SetDate=2024-12-17T14:20:05Z;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SiteId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=agilent.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5430:EE_|PH7PR12MB8037:EE_
x-ms-office365-filtering-correlation-id: 15430d34-e4cd-4b67-227f-08dd1ea6f71e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?dFJtSDJhWWFHR05OTDRES3pMUi93QldkZ1lWTGQ3bEk2bDZGSy9ENTdKUGRM?=
 =?utf-8?B?SmdMOXMreXhkRVlGcDZCQ3d2em45SnN0TGQ0Si85Z0xoMnVYdE9wQnZZbzJJ?=
 =?utf-8?B?Q0UwODlpUlJGc2tac0dEL3REQ2FHeFFIaytYVVN4Vi9CVFFQVHlGUTNBNFNG?=
 =?utf-8?B?QkJEWEp4ZmZpTFFGVlpQeDMyM2Q0WEU1cGcwS2VOU2hRSmZscTJZdnlWb1lQ?=
 =?utf-8?B?aFhNaEg2SXU5WlJlaWZPcTk1ejJiVkdLVWhMWTltTkpZWXdBTFB0V25FdldE?=
 =?utf-8?B?TkJYZnRINWlzeC81TVA1a1IwMitRdnRUV3RXSVJ5Y1JoQUtaMGw2QjI4d2Ny?=
 =?utf-8?B?Um8yM0o0OUNxNnEzTDhiRmh2d1VTU1J3dW1kT0lhUkFGcW1qYUwxWG9Ud05I?=
 =?utf-8?B?YUpaK1B2eEp0ZXB1TGZMbmJHK1llNEpDb1Z3dUQxN1Bia0VWbFVRUU5QNFk5?=
 =?utf-8?B?ZXhCTWJzWXc4U1F1NGlpTGZWR2VEY3kvdWVUam92eDN1YloxUzBHVXZCaE5L?=
 =?utf-8?B?dmRsZngwbnJRdmFRSGdMdEtqVC9zb3NROTNBWHVyK3JQU0pqcDRXdS94Mjk2?=
 =?utf-8?B?TWtzV2JYUmY2b0RrK2tzakdhbDhjSlk0VnYvalFkbEptQ25vbFYwcEJUdm50?=
 =?utf-8?B?Y3cxUUdSTzJTaHdnVHVPZjVFYXhGS1V0WlIzSi9wWEluWjF4UE5tdG85WkJ1?=
 =?utf-8?B?Y3Fxd0N3aFZmM2hUL2dtSWsyWFRSUzY1dlZXRExZL0VRVE5SRzJ3aDhIR1Fm?=
 =?utf-8?B?d0s0VFUydXdxL0xjWTIwdHV2SW5rYjJGUkhSSjNmVmxqOFd5bFh6RkhHTmEy?=
 =?utf-8?B?RWQ0VmVROHJUQlpoUFBDcWFSMkdtbFU1eGlZRTBOUnFjYU1MSCtyMnloWHNQ?=
 =?utf-8?B?Z2pjcVlBL2p3RC9USHR4UmhDb1Q2RjhPVGM1WENTUTRHcUtIRzRLOFVldzZ0?=
 =?utf-8?B?cmF1TTZtcHRxL2dEcEMxUUlCQjJnRFM2U3UrQ3lreVhwSUJtWFB5UWtSWGN1?=
 =?utf-8?B?dDl1dmlsdlBGaWtrd1VzZjBvMk1aZTFKQXBsTTJaWWhsLzJYUW4yTVlWcG44?=
 =?utf-8?B?dEM5RDBUWFdWVUc2bjhrQU10d3RZUHU0ZnVXaU5TQ0pPQ2NEaWcyZWYwOGha?=
 =?utf-8?B?UU9WTXQ1bXFYV0hWSlNNelRBL0xzTVdIVlR4WWdaVTBQNEIrS1NQZ0lETkZ2?=
 =?utf-8?B?OHl0aXE5UTRZazMzdHd6WG1wQ2xVSjBLOEkwRXhFbXJtS3AxL1cvWEhSODBX?=
 =?utf-8?B?M00yQklSY09mUXNIL3JGbEdqd3IyK2lhS2tOOC8zYTFZN01iRVk0N2ROV2cz?=
 =?utf-8?B?c21ac3lKRW5ieVdRaVowRk1zZ3pDYzR4QW4zWmZQWC9XNWVidFpWeUlNVEZv?=
 =?utf-8?B?S0l2SytLMGFscWVMMzFPYU9hYmx1aXZIMENMV2tXYXdrMzFTSTBRcDFyZVhN?=
 =?utf-8?B?aVN1Z1gwWkR1am1rWUdJMXVGOTloUG9DSElYeXJMTnp3UkdhRVRUcXRxLzBE?=
 =?utf-8?B?SjlxN1l5emxjclhDS1dPRVU5SnliZDNXMXBPdElxZk90REJNYVJySkQ0Umgr?=
 =?utf-8?B?S1RIbnUvRXFEQWhsbjAxY1FBS2Q2amtCVE1mRk9UU0tHSUdRdFZLS3c2NWJC?=
 =?utf-8?B?WDBBMTd6UGxNUytnNm1qUzhiTS9FaXdjTW8wQm84QjdFVWxiTnFOaXBUY1VT?=
 =?utf-8?B?Y1lxN1d3N3NIdThhMy8zRHJXc1hyc1QxU1R4UWRVNWdVQmxaZ0M3TnltYkJ4?=
 =?utf-8?B?ajAzQnIxZ1JHTUVRNGM3TTlyQ2hBMEhhYlQ3UDh6cStjMDhnYUNlUDd0ekhH?=
 =?utf-8?B?L2pwSjNQeXdRUXVJT2RwcHUrT3ltNTNwM21tUzJaNm81T3Jlb0tEZElhZnpM?=
 =?utf-8?B?T3FHVytwN1RvM3lmNWQrWlE4WS9uNUpZa0x4eGw4ckhmRk9VV0VXS28xRjRC?=
 =?utf-8?Q?20+Qh72tC9kcWyfOTzsZNIZU+7o+va+a?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?NThsSDQwQkN2K1BXZnV4V0k5bTloTUVLZEtaVXpEd0RZcHAzZVdoeTZUSXBD?=
 =?utf-8?B?Qk8xbTBjb3ozV0c4OVZrUDBCYTlOUURMVzJYZlNtbmNJYmN2elpLZXI2eDlr?=
 =?utf-8?B?WDh2ZXZERHZpVExpYkkwck9uVXRDQnovVmhneXpVb2k5VE84eFpCenE1Z252?=
 =?utf-8?B?R0swQ1RLbHhSS2hMTXUrd0g2b1RwaEtYUkdaaXU5RDRtMzZPdnVlOXIwbjY2?=
 =?utf-8?B?MWhSb3NBL2xhRW9nZ01QbXg1Q0RyWFJKY29rOXdwMXRjRnBkUDVzOUp1dTZw?=
 =?utf-8?B?TUJBWWFPUDBaaUx0UGliVllPaUVpK0tkdC93aVdURnR2UldqbGl6VDdBNTh0?=
 =?utf-8?B?QnIzWnRhYkt2a1RyT2pHUEJDeTBBMFJINUlpNHJWT3dNU1Vib1BVT3VyMEpU?=
 =?utf-8?B?M3dzczlKbXVDdGp5Uk84a0UrTmNELzN3c1lkaVppNUg2b3NrOFVuZzlKRTky?=
 =?utf-8?B?dnFzS1NmZkliZzZ6dk1QWFNuN2JQV3JncE1INXJvdHJQY3ZqMkI1eFlpN0Qz?=
 =?utf-8?B?UGFxK1A5enpZdzdZbnVRRUVlNm0ySHIxUE53eDdJd1A2QWNzNUJrQU1VNmxK?=
 =?utf-8?B?VWtDNmN3NVJaWVpLQjJkdFFtbGlyTTdtYWo0S2lBRmIreWlBdmVDbXQ4U2ph?=
 =?utf-8?B?ekppQW5WcWtXa21LdHRqaVB2SVd5blV1d2N2bFA0RHgrMkI5SkdxR1ZpdUxa?=
 =?utf-8?B?RFN3bDdWdVI4Ni9LYWM0clkwVjB1K0phVkZXRko5YWdGY1F3Z0JwYXVlTnI2?=
 =?utf-8?B?MXRqNkJGd0VFbFVaSDlYdVVZVWhFUnlRMjRlN2lVdzdVUlhuL2ZtSG0xWVpy?=
 =?utf-8?B?N241ZGV1MExnS0pjUnYxZ3VOanVmcVhOVUIvdlE2cFJrMkc1MVRRc2dwdEJx?=
 =?utf-8?B?MmtZVHh0RDVSUzZmbVM0Smx5NHloWDVGSlVsbkhGaTA2anZSUm9iM21nQWVo?=
 =?utf-8?B?RUFOWGsvZTRSK1lQS2xBMTJjU1JCRGlCWEtvSVN5dk9FQ1A2MlVNTFRUVU0r?=
 =?utf-8?B?SjJZVHJOMzFwMXBSL3VKVXpvRlUwZC9ucFF5QmdWNXlzM3FGZ2RhaitmWjBK?=
 =?utf-8?B?bzluamxqWXZ5cElQazRIaUpma3NzWGovYmNPVkp5dmF2WlhkZjM4NVdrRVNo?=
 =?utf-8?B?bnJMcG40NThHTERlRXpoZTQxeiszVDhaMDcxTVNtSk1qRkpsalZtM3BtQm5y?=
 =?utf-8?B?T3p2YzhPSGpqcFNSbmIyYjZzeHgybmtnVjdnT2lkZlM5UGRXQzlPMEFMczdK?=
 =?utf-8?B?c01FN2Z4Sm42UU5NTGhzcEpDclJrbkI2NDd6dDQ3RzM2SS9Gcmp4ZHJZMFVw?=
 =?utf-8?B?S1BEc2tublhvbkJzQ1BLNjZtaTIwY1dvenZOVTF1UTIyQnhYN1phYk5ISk1U?=
 =?utf-8?B?emhIYmltZDZ1ckNVNXB2b3FOOWs2TlAvb1Y1dDB5N21qMGQ4SVYyMG16ZUV3?=
 =?utf-8?B?TkhnUWdKQ21YQUZGMFFvZzBMWERSMGdnTnc0VVRSbkIvVWJHYnJiejJzMGF5?=
 =?utf-8?B?UjA1cnNvYTZua3pHVW1PS2F2R2xIcmxaVlQvbnNkR21VdlI1T0l0QjJpVWhC?=
 =?utf-8?B?eTY0Q0MzU0F0R1VpYjZvbEgzdG8yV2xlUURQc3dzNjJkVVI4ZVhUeWRuRmJG?=
 =?utf-8?B?TXdkd0RSaTZLM0dEaHdmLzlkQjhsWGxOdm5vNmp0c2ZCVFJIZzFWWVZOL3VU?=
 =?utf-8?B?Mkd6clNNblBhNXVrb2pDajdUdXYvQzlIS0p3c2tjZHlFTUdFOTJWdDl4bi8x?=
 =?utf-8?B?YnZEbnVVLzkyVStMRnBDUmhoQ0M5cGE3UitLSUd3b1RFS1pnN01jOWFJRG9h?=
 =?utf-8?B?M1B3cTJqVDhPeE9Edzl0Qyt0dXUwS1cyVis4cEl6b2h4bGs4QnNIWFBhYjk2?=
 =?utf-8?B?TGVNdW1IMUc0UFh0QTJlUHpnMTNiMURoT0daMHhrN2ZSM1k1bzZvSjVDSlJV?=
 =?utf-8?B?NThraHMza29MUGhHcFdqSHp1NUNIZDE2bGRLTUdoWG9BY2JpY0lDNGw2QlJO?=
 =?utf-8?B?WVJKK2RDUlJ2SWkrVVdFcmtFc3dFY2pBLytSL0dJRkprVVVoOUNONzhXWHJG?=
 =?utf-8?B?UFNQSlhuZGIvOUhNSHBQZFkrYnVmTmhVY3Y5MFc3dmtTTzJmQ2VQeFhYemk4?=
 =?utf-8?Q?ESxeX+DlIEddhHm4s3fkffQuJ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15430d34-e4cd-4b67-227f-08dd1ea6f71e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2024 14:27:41.5209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aJ/zYKHDnM+7AKcjUL7+lBUbOPA9dzSUX61vXHJADC/PqBdAMLM8dt2/g4WZMV01bvZcnOHOnwwIwLsi+SF/fwX3yuToYwe/jF+BiY73uPY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8037
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 17 Dec 2024 14:27:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16917

PiBPbiBUdWUsIDE3IERlYyAyMDI0IGF0IDE1OjExLCBDaHJpcyBMYXBsYW50ZSB2aWEgbGlzdHMu
b3BlbmVtYmVkZGVkLm9yZw0KPiA8Y2hyaXMubGFwbGFudGU9YWdpbGVudC5jb21AbGlzdHMub3Bl
bmVtYmVkZGVkLm9yZz4gd3JvdGU6DQo+ID4gKEV4cGVjdCBhbm90aGVyIGVtYWlsIHNvb24gcmVn
YXJkaW5nIHNvbWUgZGlmZmVyZW50IHByb3Bvc2VkIGNvZGUNCj4gPiBtb2Rlcm5pemF0aW9uIGVm
Zm9ydHMuKQ0KPiANCj4gSSBoYXZlIHRvIG5vdGUgdGhhdCB0aGlzIGVtYWlsIGNvbXBsZXRlbHkg
bGFja2VkIGNvbnRleHQgb3IgZXhwbGFuYXRpb24gb3INCj4gcmVmZXJlbmNlcywgYW5kIHRodXMg
aXQgZmVsdCBsaWtlIHlvdSdyZSBzZWVraW5nIHBlcnNvbmFsIGZhdm91cnMgZnJvbSBSUC4gUGxl
YXNlDQo+IHdyaXRlIGZ1dHVyZSBlbWFpbHMgd2l0aCB0aGUgY29tbXVuaXR5IGFzIHlvdXIgdGFy
Z2V0IGF1ZGllbmNlLg0KDQpJcm9uaWNhbGx5LCB5b3VyIGVtYWlsIGFsc28gZmVlbHMgY29tcGxl
dGVseSBvdXQgb2YgdGhlIGJsdWUgYW5kIGxhY2tpbmcgdmFsdWUgdG8gdGhlIGNvbW11bml0eS4g
DQoNCkkgZXhwZWN0IG5vIGZhdm9ycyBmcm9tIGFueW9uZS4gTXkgb25seSBnb2FsIGlzIHRvIG1h
a2UgQml0QmFrZSBlYXNpZXIgdG8gcmVhZC9tb2RpZnksIHNvIHRoYXQgYXJjaGl0ZWN0dXJhbCBj
aGFuZ2VzIGFuZCBidWcgZml4ZXMgZG9uJ3QgYWx3YXlzIGZhbGwgb24gUlAncyBzaG91bGRlcnMu
IA0KDQpUaGFua3MsDQpDaHJpcyANCg==

