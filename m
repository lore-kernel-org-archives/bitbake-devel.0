Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730ACEE209D
	for <webhook@archiver.kernel.org>; Fri,  6 Feb 2026 12:50:32 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10786.1770382231556968223
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 06 Feb 2026 04:50:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=selector1 header.b=qtjQOQE2;
 spf=pass (domain: axis.com, ip: 40.107.159.48, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lG/Hx4oDzIj02SX7o8On5nCVDEGwQapOJ93AxvCVLbacT/1sj7+94cEEzaJyQg48oc6l5/FmodBOH+h0E7aU6YQpM8YGcBhIo404xy/+iLgkabpQtQ/Ius/4tHyu7zti1J0cxyXCITDT46aVj+7TlqHn9MGtEBYvAjjdfi/Gn0GEyoUJmh1/v+pZ3vJ8aQwt3zVPX5iCvzpP3Tje/e4mp+mLUttInJPNW+vBBzNwxqqXiMAoClyKGOkCn+h+dmUZQeX10ap3wbCxdilJIVNzpCv2nxowF6IK4hLiiiTmFJnODuBTTxRuZG+pzvGV5tD0Y5xK9tpSJhYrZZeXJ/9TgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ET4Qi2lCRJyHPr2QOU4RwcRr4LYmzq9f/J071eH4gn4=;
 b=kMKyaCD9P81ZeDTSoTcco4OsFfOACQZ1N6TO9QS/t/ainErCdmg0NxF0GlS3P5iT7sIkb/OeO7AEYKJ/l0qf2fb9vS4aEglitLjCNPOzcR5KdMooO7oGvZWE4HVOHmfcrOnxytot/u/qA9nNRQEkC2x+t6yjEFpsTkyEg6Zoy0zFSw+6LRB35JqO4BAc21eTQ1KmzB1lc51/8f7TbqszRUar2eWtl84hBktWlWPyRnlGfgXnBgGVa9pn9rvZo/ksoR0i3vtNF4JmeHhlvsONUT1gP9OfdKpe3bbxYR1OBZGzuYQmZe7ARV0VvuQn+TJHAFVOklQdPFoFdSTP/H4k6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ET4Qi2lCRJyHPr2QOU4RwcRr4LYmzq9f/J071eH4gn4=;
 b=qtjQOQE2iUDZr2s8eEq5h5DfmTsClpy+wihaaO6bNr8MyM1rvWvhjf41ryCQjukR5mEIfFm1r0V28GDpW76X15CZzBBK9YiKkjFTrjaS/IdEThnWd7QhOnO/xdd7dL3TQMy+9tGk1hkO3QCQdzbs/Iig0F5qG2JIR6Rys8uSa/E=
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com (2603:10a6:10:4a8::17)
 by PAVPR02MB9595.eurprd02.prod.outlook.com (2603:10a6:102:300::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Fri, 6 Feb
 2026 12:50:27 +0000
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::e5b6:b9a8:2a5d:e0cd]) by DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::e5b6:b9a8:2a5d:e0cd%5]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 12:50:27 +0000
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: "alex.kanavin@gmail.com" <alex.kanavin@gmail.com>,
	"liuyd.fnst@fujitsu.com" <liuyd.fnst@fujitsu.com>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel][PATCH v2] bitbake-setup: Add strip to value from
 settings.conf
Thread-Topic: [bitbake-devel][PATCH v2] bitbake-setup: Add strip to value from
 settings.conf
Thread-Index: AQHclz3/orOg9bMl5Emy+pjj3iFyrLV1jgcAgAAQneA=
Date: Fri, 6 Feb 2026 12:50:27 +0000
Message-ID: 
 <DB5PR02MB10213463E2A774597488AEC60EF66A@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: <20260206075522.5620-1-liuyd.fnst@fujitsu.com>
 <CANNYZj-O91BPn5KMaO0FVcpLqdtU7MF5RfVLQmJQyXvEjfd0Xw@mail.gmail.com>
In-Reply-To: 
 <CANNYZj-O91BPn5KMaO0FVcpLqdtU7MF5RfVLQmJQyXvEjfd0Xw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB5PR02MB10213:EE_|PAVPR02MB9595:EE_
x-ms-office365-filtering-correlation-id: e739ec11-4d1c-4674-1e7a-08de657e4d55
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: 
 =?utf-8?B?d3VKcWxhL3VIQlA0T21vWE1HTmtVOTZqUUVWR2Z4TnBQd08rZkRCMG5TTkFC?=
 =?utf-8?B?dmhCSUFXcEhGRVQyUDRoMnhyNExvR0Z0cjVCUGd6a3pNTjBqVzZtd09jM3NN?=
 =?utf-8?B?cjhNbnp0d2ZLcDd1R0x0aCtHNkh6eW5ocVZzVytPVWIraS8wQm9MY1JRYWxG?=
 =?utf-8?B?QnA5T2FUU2J6bVVKd1U1RVZPOFBsQzNuWSt3Rm8zSmE1VW43SmZReS9qVFFH?=
 =?utf-8?B?QUNWNEdzOHo0WGVYeFNMU1cxc2FFME5PYktpT2lRTjkvYVhUNkQvejFPU2Nu?=
 =?utf-8?B?QmFkSW5IQkRZalZKN202djRhSWwxT1Q1OXU2NUJCWmRQTllGY2t3VnZUYnZQ?=
 =?utf-8?B?SUJxV3pHNG9kcW42RG1hYnRpMGJyYkN1a25GT0dlU21Gck9xcy80Q0VtNDBB?=
 =?utf-8?B?em5vdjdjNkRsTDgvUEowSnBuTDZmUnlZTnFXWlFNUCtVSGFTQ0FpbzUrTlZT?=
 =?utf-8?B?blM2N1I3bGE1cDNISzJ2R3BualQ2aXlUTjJzTlVrOTRzcTJ1bXIwZzJlcjBs?=
 =?utf-8?B?VStZdTlTdFFBZXRMdzhyZTI2L3FnTjQ4Ry9CYTRsbDRTNkVIVDhLa2xjTU9K?=
 =?utf-8?B?Qlo4Ym5DVnpwOUlRcVBOcTc2ZzFCRytPUmdQVUJpSzdaSE1KZFdSanZtZzBY?=
 =?utf-8?B?Y3NvaThacnBGcVNCVHQwQjVtdXhCcEg5VWVETWh0VUZ4a3ZkMER3QWx5aThJ?=
 =?utf-8?B?WkxwU0ZTejU0UmkrSFp0czI2NzNSREd4WFNaT0xOSEg0RVN0aXNQTzVsWEk0?=
 =?utf-8?B?Ty9DYmtRVjZwOU9lR094Vnd5cndIWTFqa2R1dS9pZzlWOFFLc29zdXI1VjFE?=
 =?utf-8?B?RE9iSmE5N1JQUEd4ek1lVWo1aEl3cExkVldNbEdmZmFVU00zSGpBVjBCTVRX?=
 =?utf-8?B?bTlFRHlBV2hiT1BtTmZEV0l2QjRWcUk0d282VkNiZjhWb0xrZkdPaThVNkdw?=
 =?utf-8?B?RnR0TG9lL3hmeHlkRU9tNWhWbDByNmtqNHNqb0tqbEpKK1k4VGdlZm9NY0gw?=
 =?utf-8?B?ZzJrU0tadUxhVXJWSi8vVW11dk45Tnl2a1ZtKzEzMHJiT3JQTEMwN0dzcEI4?=
 =?utf-8?B?aEIxc0gxTVlBRkMyZDRwSURWeGlvZzNEYkhaK2lFdFdsVEVlbFpqYXpUSUpC?=
 =?utf-8?B?bHdCRmppSVB3MWJkS1I5ZTZ0My8rdmlRSzk0b0FFeWVUL1RiR0ZQNjVHTkFW?=
 =?utf-8?B?MlVPM1JoWDZ1cFA0U3lyM3V6VXhWWEFXd0lEWEMxN0p4dnkvSW5MMnRkUHBG?=
 =?utf-8?B?YlF2cU9hL2tUdGZGdis3RTlhK2t6OTgzcHFKdDJBWWZVMjVYL0VLUFlodVkw?=
 =?utf-8?B?T1hrUlduMzNCd1FwbFdGRG4wa1RBM1RjRXBYMkRHVi8zNkgybExCcnNUL1o3?=
 =?utf-8?B?dWIzUVFMMWNPNHJzemZFdVltbWwxTFFxNXp0Q051SDYxV2dpUUFpd2hhWjVD?=
 =?utf-8?B?Vm5BZVprNjFqUkl2alptZVMveVBFZHVnalYvQkxCbGR3MGF5WERycG9LZzV0?=
 =?utf-8?B?MUxUNGdtbkt6WHlhd2pJUXFGNXU4MW1xQVUwclR0NmVLSU1xUStrMC9sczBs?=
 =?utf-8?B?RWtHc0VpSlpnZEFkdGljTFQrT2RsNlFBNE1kTThybmRsTnowd1ZDQUVWc0lq?=
 =?utf-8?B?WUFLZW4yc3psL0crdmZPdUlaYVBXZ2pmV0thVjk2ZG9pTFFwL1N4clllUmo3?=
 =?utf-8?B?N1QvWHg1Q0tITVdQUnQrZ1ZrRWh6K1RPT3B0Y085eDFUSCtQVWRHVFFXQnRJ?=
 =?utf-8?B?R0tNNWpPdFp2Y1hIVjVVVDZKWjFseWNpZDd0Njg4SUJkSHIxVUw4cmN1NG9y?=
 =?utf-8?B?U2V2MUJ3SEtYb3FmZzJFV0w2NG8yVkhxTGZPWU9zUzhCTWQvOHlMdXJSNnM4?=
 =?utf-8?B?RWZvMGJzKzNOVEFuSzRRbXBPVW84UTBvMjQrNGZ1STFwNWYzQ3JPME1sOFY1?=
 =?utf-8?B?QytvblJOL2xLRXdtZURzWGdNUlFKVDZ0RnZ1eFNqNFRGdUlJU2VoS3FBYVFq?=
 =?utf-8?B?MFlDbWd2NmIyUVNwZ1IrZVh2alpnUFYwZjhYQjk3TlBFUEgyM21QWVdYRHNV?=
 =?utf-8?B?K3NtUndCQS84RC9VNGs4cmMzbGVBL1B1WU4xc21tR3NpdTZhNXBHTEVPdjl0?=
 =?utf-8?B?ZmJETXZBOGJJa21wWmoyQ2pIUytKK1pDVFV5ZHlqVzRReWF0NGVQd2EyT0VH?=
 =?utf-8?Q?F5XCiR+CvCWtIGtlicRqgzA=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10213.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?LzkzbXI3Y1AxMWRmT280RHk2ZGtWWmI4b1c1V1cyQytnd0kxWnhqZ2prYkUz?=
 =?utf-8?B?NkJQdmVBekVaaFd5RmJJYzYxbldGcTBqQjFNK1lsUENrS25jZkd3YjFsTUpE?=
 =?utf-8?B?SzZ2UW0zL3d5Zzhhb3ZtcnpiMnlFY0RWUHh4SU5YMHBmRVVHZU1nQ3dQY3Fw?=
 =?utf-8?B?b2dGZndUMG0wUy9HSDdsMjdONzNCalpnZllwY0E1STQxaXAxVmk5SVRkenNt?=
 =?utf-8?B?TU5nTlBYekhQQUR1L1UrVVBqUU9vekVpYWdmTjhpZWdlMWIxc2JSZm1vdUJ1?=
 =?utf-8?B?dUdaZEpkTXVhMDhBVjBIbzR0enJmRjMyR2tVeDYxNVJ3cEh3NlZ0dnQ2bUdw?=
 =?utf-8?B?M0VMVE1rT2ZHYVc3czljMjVwcW8xdVdDbUlaWHN5VndmaXU2M3UyVEJFYlNj?=
 =?utf-8?B?L0tDSzRUMFNLVFRNTXYxdWJvZEtPWGFXNm9KVEhvaG96WXFncEFWNXJXN3Yv?=
 =?utf-8?B?dFZQWVMrZ1UzR2V5TEg2YU0rY3cxOEYvYkFnVVNNQ1dGN2hRNkFKYmhRUkNE?=
 =?utf-8?B?cTI2blZRcnBBOGpUWlhOTUlSM1ZtM01VT0p3S0kxNFlMR0JCakpRcHhwbkty?=
 =?utf-8?B?Wnp2a242dk1VSFp4MC9EcFE0Zi9pREVoWFRDZTBGQmx1RmpHZHd0bWlSZFA2?=
 =?utf-8?B?UGxGcGNrOWJmb1JRSTlpbzhPVVJDaElZY0ZsQzlpN1UyL1FsdURLNXhHM2tP?=
 =?utf-8?B?R3RPK00zcTZhSmgyRVNhSm9HQlQ2QXNzT2d6Z21DMDVMTy9qVlRocFZDZ0xW?=
 =?utf-8?B?Umx0WHdVcHk4N0FSMXhEa2oxTmphNU9Db2VHNjZMR1lHeDZuYTNxMWQ0RnlK?=
 =?utf-8?B?TVZyQmlJZGNiZW8xM1NzdFNLSWFLejdheWEydFVIdXJBSEswQXpFdXZ1MzlV?=
 =?utf-8?B?TTdIN2dMdnRqZ3psU3lYMUdHaGl0aHYyWXhkcFQ4U29jLzZMQWNFY052Z1Nx?=
 =?utf-8?B?TFJ2RmRFT2JBWUNUekc0ZDRIL2lLUzk4V0l1aTNCaGt1RVBSeE1JRXdGYzR4?=
 =?utf-8?B?YXJHbXVTTVM4SVR4MHJ0KzgrYkNUTWJjTGhybGpKK3dSdUFMQm1hNkJMaVJS?=
 =?utf-8?B?bjhkalZ6RHp1Z0hqb1NIMjRNUG9CbWN2WTI5Y0VnVjdlZlVCdnJwRWV3S3hQ?=
 =?utf-8?B?d2JiQUF5T3Npblp6T0xTRDNjR1lES1pIQnA2VS9HVlpxZ0RKRThaUnBKUkcv?=
 =?utf-8?B?aGthQ25vYjFkK0xZVGlhakdjc0IzRk1VSlRYdm0xREhjOXJGSFpnNEZkWXlO?=
 =?utf-8?B?OXBzaG0vRUZGai9KYXo1OEVxbVMwTUNMV0lvSTFmVDl6YjV0QXJPNmxXaldp?=
 =?utf-8?B?d2Nqd2tEM0E0am44Y3hVWHp5bTBzV2I4cVlXeVhEbmRRNDVNYnF3SVhGKy9J?=
 =?utf-8?B?aUdIWjdTSXRjbWwwQmJ5eTgzTTJ4OXZZTVZIbE1tbWdnaGxUcTRhRlkrZkZx?=
 =?utf-8?B?MWJLWUt0aDBmWUtxMkJhdGhkQng4VkpnSzVTa2Z6UnJ5NVNBZVhMQWNMQzEv?=
 =?utf-8?B?V3FtaG04VWhMcVlYNWw1eXVZaHFhaFVocW92bkZTYW81ajVLOUl5cmtMTWI4?=
 =?utf-8?B?K0FEdElyNkVTa0RybVF5d1JlSEFuR2RNUHFJRCthVkF1cUYyQ2N5KzRIdHVy?=
 =?utf-8?B?RGNDNHIrRFdZWE5jVzgzVzdsMUV2MGdCMUU3Y09LU3FJQWFNRWgyR3I0b3FE?=
 =?utf-8?B?algxdmYzR05sbmhQdUo4WjlIdGtPaGJkU0pvVVM0T0s0MWRURlk0RytUNHRN?=
 =?utf-8?B?dnBJWEVaSWE5cXVIeXdLdU1FM2g1eVJKWlVobWdKM29lVFpRUmUxTnFUa09H?=
 =?utf-8?B?VVNodDlITytPWjhRUlJqUjF0a2s0aUN3U1hnWUVVaEhCaEcwUFFSdkh1VTU1?=
 =?utf-8?B?djZtZUNhVS85dWFyNjZUcWxMY29mRzNjSlJOdEthL0RRNnF3NEo1cmV4cTZp?=
 =?utf-8?B?aGFEZ1NaSWxkWWxNNGR2b2YzZ1JWa25DWkI2cVVIYklRZitGSEFnSTlPU0Jh?=
 =?utf-8?B?OW9QTVFWMytTZ2ZTTmdxelZ2ckxndmZTRkdONm4zbDBKMXJIcUxpRzlReW93?=
 =?utf-8?B?Sm5EVUlQVVk3SWd1eVc1cy9idk0rR0ZyK1ZsZGhlcnhSN050M1VxR3hwVjhL?=
 =?utf-8?B?WjJsUjVibkdOa1RJRno2SDhoY1ordnB3ZGZaTEJMcTF3cWZvdEw4azZHYkdv?=
 =?utf-8?B?QU1nR2lLTHFhdXJNZzJjQkhsYnIvNE9NZFM4cTBlMU50MnM3Z2VnTTdISWYv?=
 =?utf-8?Q?COayS42y54qqZzfpv+GjYp8tMRYy24PlOXTBoka2lA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10213.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e739ec11-4d1c-4674-1e7a-08de657e4d55
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2026 12:50:27.0395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rkkBfQpiuNNa31KdBkLu+q59xmq0ZqsCjt8LUcZbEB5lVDAAYBedALLM5MFgMRxd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR02MB9595
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 06 Feb 2026 12:50:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18981

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBiaXRiYWtlLWRldmVsQGxpc3Rz
Lm9wZW5lbWJlZGRlZC5vcmcgPGJpdGJha2UtZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9yZz4g
T24gQmVoYWxmIE9mIEFsZXhhbmRlciBLYW5hdmluIHZpYSBsaXN0cy5vcGVuZW1iZWRkZWQub3Jn
DQo+IFNlbnQ6IGRlbiA2IGZlYnJ1YXJpIDIwMjYgMTI6NDcNCj4gVG86IGxpdXlkLmZuc3RAZnVq
aXRzdS5jb20NCj4gQ2M6IGJpdGJha2UtZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9yZw0KPiBT
dWJqZWN0OiBSZTogW2JpdGJha2UtZGV2ZWxdW1BBVENIIHYyXSBiaXRiYWtlLXNldHVwOiBBZGQg
c3RyaXAgdG8gdmFsdWUgZnJvbSBzZXR0aW5ncy5jb25mDQo+IA0KPiBPbiBGcmksIDYgRmViIDIw
MjYgYXQgMDg6NTUsIFlpZGluZyBMaXUgKEZ1aml0c3UpIHZpYSBsaXN0cy5vcGVuZW1iZWRkZWQu
b3JnIDxsaXV5ZC5mbnN0PWZ1aml0c3UuY29tQGxpc3RzLm9wZW5lbWJlZGRlZC5vcmc+IHdyb3Rl
Og0KPiA+ICsgICAgICAgIGZvciBzZWN0aW9uIGluIHNldHRpbmdzLnNlY3Rpb25zKCk6DQo+ID4g
KyAgICAgICAgICAgIGZvciBrZXkgaW4gc2V0dGluZ3Nbc2VjdGlvbl06DQo+ID4gKyAgICAgICAg
ICAgICAgICB2YWx1ZSA9IHNldHRpbmdzW3NlY3Rpb25dW2tleV0NCj4gPiArICAgICAgICAgICAg
ICAgIHNldHRpbmdzW3NlY3Rpb25dW2tleV0gPSB2YWx1ZS5zdHJpcCgnIicpDQo+IA0KPiBJIHRo
aW5rIHRoaXMgaXMgb2theSwgYnV0IHNob3VsZCB3ZSBzdHJpcCBib3RoIHNpbmdsZSAnIGFuZCBk
b3VibGUgIg0KPiBxdW90ZXM/IFNvcnJ5IEkgZGlkbid0IHJlYWxpemUgdGhpcyBlYXJsaWVyLg0K
PiANCj4gQWxleA0KDQpNYXliZSBpdCB3b3VsZCBiZSBiZXR0ZXIgdG8gYWJvcnQgaWYgYW55IG9k
ZCBjaGFyYWN0ZXJzIGFyZSBmb3VuZCBpbiBhbnkgDQpvZiB0aGUgc2V0dGluZ3M/IEJlY2F1c2Ug
SSBhc3N1bWUgdGhlIHNpdHVhdGlvbiB3b3VsZCBiZSBlcXVhbGx5IGJhZCBpZiANCnNvbWVvbmUg
c29tZWhvdyBoYXMgZW5kZWQgdXAgd2l0aCBhIHBhdGggbGlrZSBmb28vImJhciIsIGkuZS4sIHdp
dGggYSANCnF1b3RlIGluIHRoZSBtaWRkbGUuIEFib3J0aW5nIHdvdWxkIGFsbG93IGJpdGJha2Ut
c2V0dXAgdG8gZ2l2ZSBhIA0KbWVhbmluZ2Z1bCBlcnJvciwgcmF0aGVyIHRoYW4gc2lsZW50bHkg
aGlkaW5nIHRoZSBtaXNjb25maWd1cmF0aW9uLg0KDQovL1BldGVyDQoNCg==

