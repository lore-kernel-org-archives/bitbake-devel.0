Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B936FCCF9F8
	for <webhook@archiver.kernel.org>; Fri,  7 Nov 2025 11:07:39 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8907.1762513652461877898
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Nov 2025 03:07:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=selector1 header.b=ccdmRxLd;
 spf=pass (domain: axis.com, ip: 52.101.66.52, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EkC8SwQ5iRr25HwKaKkj0BRspubz2VJjgCwY1Zi3s2y0a4zowc1mD35vn360vw9UwdDoqLWUi4pNPDE0Ypvq0QOOJuALqxtH/caGe+AHn9jYmmT8ho543p9/YOib1LbD9G1OQ/W7W8gYQrNS6nQ83ZOsznvyCl3FtCN/YFi25fMvDmBOKCxt7ViV/Jojtr+zdcotOp7urSoVT0jrLjsDl0zy0op9DH2oLNBEZ5w730XTJ6d++ufKERKpZT8XD04vvxRuwH3IiUGRKoaWkOxlT69wLMNwqyIQt9efCZ5kMw0jdDC9xnVa2v9sfxHV9hp+laaGYrlzsA5YTingEidrNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iofnxEP/hwfExh+Z1p2tUpzF+6bEtEfVhHK+Afq2Ok4=;
 b=um2XMtm2nZlpD+egx8jau4teEffsq/zjSgBl2+oJdp+DQfbQDwCKWdd+TCg8xorTmKXnh872BEpzbMZWtX4AIogSlb/OULudRQGO3qa8UzKnTj5/30F3cbhQcXcB1iVb4JUI3f8Q4n4tHeiJ/mtwHxXamMHCWPElhshkVov7S8jT85qQuwId8fshN8x3JDfHVA5kpVW/dXwzptv9n1qD0ginRRsFF+8ZxiHnr90fyM4zxNrNF/CF1jUWasMZNLbsY8vw1n0JFP0UqQhI5jz+cPW4DggrTQWxPB3+XTaU2ChaKBEotzri5DwOgsTB99Oyq3/cTy9zIMzSc+zdgAsbOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iofnxEP/hwfExh+Z1p2tUpzF+6bEtEfVhHK+Afq2Ok4=;
 b=ccdmRxLd/4OYJ+E1KriRsR+V1+YeyZZk4+M68YmQjrVUSBbAQmPPZze60AN1ewLh3J77PyycNimApknowfNgxubaZxTJ6Kk/JPc5A7GopGfQac282CdybiR9MnGjgxF+ZXQzghW3YI3+2zAq2OU7JXifs1nnimwLw+6r1Gm4QIA=
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com (2603:10a6:10:4a8::17)
 by AS4PR02MB8055.eurprd02.prod.outlook.com (2603:10a6:20b:4e3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Fri, 7 Nov
 2025 11:07:29 +0000
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::1bee:3174:a078:5af9]) by DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::1bee:3174:a078:5af9%7]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 11:07:29 +0000
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: "richard.purdie@linuxfoundation.org" <richard.purdie@linuxfoundation.org>,
	"alex.kanavin@gmail.com" <alex.kanavin@gmail.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
CC: Alexander Kanavin <alex@linutronix.de>
Subject: RE: [bitbake-devel] [PATCH 2/2] bitbake-setup: unpack sources (e.g.
 layers and bitbake) into 'sources' rather than 'layers'
Thread-Topic: [bitbake-devel] [PATCH 2/2] bitbake-setup: unpack sources (e.g.
 layers and bitbake) into 'sources' rather than 'layers'
Thread-Index: AQHcT7yjDDWPxs4HsUiJLUVfqKaf1bTm+AuAgAAM7VA=
Date: Fri, 7 Nov 2025 11:07:29 +0000
Message-ID: 
 <DB5PR02MB1021360A5C5B050606199CD02EFC3A@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: <20251107080026.2599821-1-alex.kanavin@gmail.com>
	 <20251107080026.2599821-2-alex.kanavin@gmail.com>
 <13179deb9c814179d00e7bcd125c3999399c5819.camel@linuxfoundation.org>
In-Reply-To: 
 <13179deb9c814179d00e7bcd125c3999399c5819.camel@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB5PR02MB10213:EE_|AS4PR02MB8055:EE_
x-ms-office365-filtering-correlation-id: 34848b62-f29e-4ca7-05a7-08de1dedd783
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: 
 =?utf-8?B?YXM3ajgzeWhsM0J4T1FPMTNIeDdUUXZ6UG54UWxlK0ZaK0lnTFlxL2kwYlJZ?=
 =?utf-8?B?SlZyWGIrem9kSXNFNXFNZUs4Qk1tTk01bTlSQUYraVdSb3NsM0YzeUpVVElV?=
 =?utf-8?B?bXdWL3Q1Y0JJbm9Sa0VnRGJidyt3eWtkS2JCR2FwSGhLaVQwMVd2aHJIT0tG?=
 =?utf-8?B?NS9KUzhjeEtsK2FQU2MvWG5NdFFSZWFjNzFMSFJRbmQ5aWhwNVRseUxycXFJ?=
 =?utf-8?B?ODF3Mnk2aGFUVVVUWW5lcy81VjhSUmhIN2NMb3QvTVNHc0hBeXkreGE4Q3U1?=
 =?utf-8?B?TlhPdGtIUUpLb3ZVaXV1WitjdWVIc1FtUjVXcjVDZWR6YXdQTHJzSUZvdWhF?=
 =?utf-8?B?NWVUYkVVLzJtQ0NPalJ3V3BQbGNXNmh0dFBCTUx3L0ZEcjhRYmVXTlI2cUtv?=
 =?utf-8?B?TnVCRkw1K25BZlNGUmhtZm44WEtvNm9id2o4QWVBeDJObm5DK1I0M0RZa1ZU?=
 =?utf-8?B?c05SdUw2TVRFTnRLS09zRHZtZXc5bHJhZytsWWR1VmxsaWRuWEJSSUtXbWlT?=
 =?utf-8?B?WERpREE0Vnp6VHVFYlVZN2o1MHE5amJLYjA1WW1vVERxeDl6aVpSTTJETzd6?=
 =?utf-8?B?VXMwQy8xV3NoMWZORjJTcnZsdlpFQk1Xc2lRUVRjM01MaXdKNGltcEgxR0N0?=
 =?utf-8?B?YjRLUEo0M3hGQllMZVh0aVB3aHNQNTdFZkRlSWFwRlFjZWFjZCtKdnAvZEcx?=
 =?utf-8?B?VnFXRXFDS3NvSWtSTkViMjlROVl0UGpkeC9FZmVSY3Urc3NxRldFN0VnbEJO?=
 =?utf-8?B?NnBoVlArc3NVNTdZZ0kwaGIxZ1NpSFE1WUdVcnByVGxTVEsraWROeHRzZXJH?=
 =?utf-8?B?YmE0REFBTHAxQi81Z0xEYWFnMXZrdTE1N1IycGJnamd6aGMwZmFjTlZRYW5W?=
 =?utf-8?B?dUFyTW9WamNUNWFFcTJyRzBpS3RPdXBSeTJzZ0JRRW9vTjFYb0hFT0YyRlJw?=
 =?utf-8?B?Tm03cjBHbUtxN2pQZUVRUjhZRXNUMngxSnFWNFEwdFhjMnp2WEJCeERBeWxz?=
 =?utf-8?B?QXpqRVZWcm5OMzdmNHdiSDNKejFQMENtUUpySlcydk5MU3BDOWd5bjdCdGU3?=
 =?utf-8?B?dUg0Y3crbzNCdzhDbTg4QnV6SzZrS0ZPQk9iWnFuU2NqT1FtRWZCRGZBeXNY?=
 =?utf-8?B?OW52S1dsYmNYMDhibWZQeWJVaWRGUG8wV2FoYlo2eTcyeTdUNXdKVERJSmR2?=
 =?utf-8?B?ZGtCTUE0WWlIZENZSURkSy9TN0sya0o4OGV2cG1KR3RYSWRLcFMvVm9wd3Jp?=
 =?utf-8?B?Tmt1eDQzWjNyQnBndGozY1UrWi8zVVpTeWc2Y3RndGdrdUdNcjdabXJ2dW1B?=
 =?utf-8?B?WGhUUHkwd3NWVERhVUdScHVyQStnVnpWd3AyN2dYSzhHR1R3S2x4R1d3dzVr?=
 =?utf-8?B?cm1MSlI4ZlR2a2tHM01HSS9taG1FL0FFK1M3enFFR1V2QkxBQ2grU2NxU3VC?=
 =?utf-8?B?L3d4V3kzd1pSTUo4WEdISURMZjJkZ0tjYWFHaXFobm05c05CUFNxYjNjci9y?=
 =?utf-8?B?SllqeERHSGpHTmhKNm01TncrNG1ncXdRc3Z5clFQcTMzSlNMdTh0SEdSUHpZ?=
 =?utf-8?B?YWtpa0tHVmE4dEpyOCtPUUZBRXd1RDBMZWtDM3kvMHBJZEk3SDBWTFZyM1I2?=
 =?utf-8?B?RFhMMDlLQkJFZDdKVWF4dHVGWlByalVieGdGU2Y4a2lmWGdzbStoZjR0YXFU?=
 =?utf-8?B?eXFEMzROOTFSMHB5R3pwUjhXMEFtSjNKTlVGbEl6NElDTWNJNWhiYUhjM2lM?=
 =?utf-8?B?Z29Ed0pMazloODBDQW1lcTNhMnE0Q1dTdHpITkN2QWNwUURiTklQQXB0WmZ6?=
 =?utf-8?B?RFB0dU4rWVYrMTBRekR2VEt2S3dNRm15YU95WlZpY3ZQTE8wdGovU1VsZEd0?=
 =?utf-8?B?REhGZG5zZlJIaHEvNm5aRWpBVERFTWQyMTh2SFkxOVg5SSt6RlF2dUVvM2FF?=
 =?utf-8?B?SERTdUVTNnNCemF5R2ZsMTZJOXlHb0lMeHlRU3FJUGs3NjZjS0Eva3JBWllu?=
 =?utf-8?B?Y2kzQjc4Yy9STXM2WVVBaHBJRkFxVjB5Z2hRc0NwNnFZWThNTGNUZDZaN2lX?=
 =?utf-8?Q?2jfXzY?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10213.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?MElWRS9Bcys4UmI3cVhsbHRMeW50VmVWd1M4N0ozSTZXSXZPRXU4ZUx5ZmY5?=
 =?utf-8?B?RUM5SDRwMXpLeGxTeFBTVmxlbXVpYk81cjZUZzRwVVpLRnh3cEdxL2FWSjlp?=
 =?utf-8?B?TFBaaW9IQmMyemxCcWdlMkVCV1g0cVBIdzd1WWpma1R2amVTM0wrWWtLYlZ5?=
 =?utf-8?B?cHc0UHpPSDh0aGsrcDB1eEJGTmw3UjlWODNIMURRaFo0Y2NnVTBNZFdBSVJL?=
 =?utf-8?B?ZU1xb3gvZVdQdmRlK2FUY2RiWWtiVkNVZUx0NWVobXl1c2p1bVBlakNBajQx?=
 =?utf-8?B?U0RsS3VLODNEbjROOWJsQTZybTRzRjlpVURtYk5rWUk5T1NjOHhOaXpaREU0?=
 =?utf-8?B?MnF6NkozVDFTdldKamtxckVHSW01UjNvaUV4WnJybnowYWlaSjY4UUtTSHNk?=
 =?utf-8?B?VDhIR0w4WHl5OTdCNlE2dFVqNUM0TEpYTkd6UDRuUFhmTmgyTmxLdGQvUkZL?=
 =?utf-8?B?Wlk5U0c2YzVxOFhtS3pTclcvUGpmUWpCWlpLODdwK2xyOXkzTklXbEtVZmNM?=
 =?utf-8?B?WW9BMFBUQWJNdXdxbThGMDBOTWwwQW5XSWVNYXk2bmJwSTNnVzBOVXhwWGxV?=
 =?utf-8?B?ajhlKy93Wnl3cFB2Z04vK0UzRGlsRkI1MUhFWDV5UWUwb2puR2RlbjY3R0x4?=
 =?utf-8?B?V3J0VFFBRDNJOXdEczRVbzN5MGUvbS9BejZjRDJWMnZWWjZtMFJ5Y1AxdENI?=
 =?utf-8?B?eFhCZHk0UTFibWJYUEQzMWtPMldZRm1rUXZ6MjN4OUNrWnZXTTh4c1Excmo3?=
 =?utf-8?B?aytwYW1pSVlCWWg1WmhjRUczakZPYWk0ZnpSM1VHV1REWkFMV3lweThhaVVz?=
 =?utf-8?B?WUNJVzZsOE9UaW54NkJ0bzFKUUtrb3c1VjdMWjRMWWxranBlcFdYZzBOcmtl?=
 =?utf-8?B?Z0tHZFNYY1pFallsanVnUUhLeStuUjhpVnQwdm4vTjY3cXhTOUMyYytLY2lo?=
 =?utf-8?B?M1JkWVNLUnhUSDFXUldmMHdmWGpCT080bklmRzR1TU5nWUhBbFRPbVZ5Q0pj?=
 =?utf-8?B?dytEQ3Avclk0V0hBRDl4SUsrRDhHRzUzK0VxUGpzakRwdzA4eUVibTRlVCsz?=
 =?utf-8?B?Umx5UXpFSE5ISmZzMUZRR1hPNXJDeUdYK0lHT3VBbVJMMkFEZEVJMDNFWVNm?=
 =?utf-8?B?azN3NlFDRk9HNGJmZDJJck1VREx2NkVnQWR5Qm93UFZJSy9vN21aTnNmVWlm?=
 =?utf-8?B?MVFGZTV4aERTbHRGZFAxWDllZVRDekxkL1lZbUx4U1IwVFdIaWFvenlrV0I4?=
 =?utf-8?B?RGh0TE8zcDNUSFRDRUd6VkZ6MCtTQVpURXNvYnpmQ1QzVm40ZXR2U3dCNzZZ?=
 =?utf-8?B?K0g3OFlGNm8wWW1YWG5xc2VlR2twUHFpeW1tWE1kSnpheHdiOTJ4T042Q0sv?=
 =?utf-8?B?YzJBTGQ2RjFmVGp5Z3VMbnI5MENrN0c4YU5TdVJsSEdxNjNZNGR2YVVlK1N3?=
 =?utf-8?B?NVpHQXUzeGJGcUM3QzlGYmUyeW1Hb1BaQjE3TzMxWVloM2R6c3pxZnVuNXhJ?=
 =?utf-8?B?RTJIdE44bm82MEg5K0pBaWRRcGlnUlFGdDdCaWx4TWd5bGZRUmZReEFLZ3FY?=
 =?utf-8?B?cEE2Ym9oTm1tb1ZraGZZcHVVOUIyRTdCZVpOUWtGZnBIa0lJcEZUMlRTSlVj?=
 =?utf-8?B?ekFHSHhzQk1Ma2V3bG5iNGt2ZzFaWGxvQ1l6L2R4UVIwY2pTUm5FN3N4cHdz?=
 =?utf-8?B?WGlFZWFKQ2FMZFJscER6clJ2QU91SHVHVXFIcHJtTTM0ZEFsQnNjckNQOEFX?=
 =?utf-8?B?aWNnSXBHYWdhcjJRUGdTU0RZbzJKUmpOYytQZHNCTWF0Nko3SHFld1RZaVlP?=
 =?utf-8?B?dkFuZmZnK0ErVEQzV2R5TDM0ODd4cEsxMTBhTkdkRTlId2pJWmFSaXZPSDg2?=
 =?utf-8?B?bnFBOWxNdjBJRzJ1c1h5Z2hIM2k5Tk1pemFrZUlwYmdLTi9QMklyakFGSThV?=
 =?utf-8?B?bEFSU0JHS3FCYkJHaFBOSnNaVHFVcnhoUnpzSklCdDdCM1R5T24vYnp0LzBV?=
 =?utf-8?B?MHc0QjVWc09lQnBFVGliejZoaFlWMEtKVGtMR2xDU3piN2lNSG1GeVorTnBF?=
 =?utf-8?B?N3pDcFRkTUcwdENxUklsL1doeUk4MUNzdmVLQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10213.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34848b62-f29e-4ca7-05a7-08de1dedd783
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2025 11:07:29.2678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c90lt5Tr6F2j1fWFH7mKCsb20gWkVLVGePlqyPJhu7qNz9RV9QDFFgOLu9Hb0lPX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR02MB8055
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 07 Nov 2025 11:07:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18306

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBiaXRiYWtlLWRldmVsQGxpc3Rz
Lm9wZW5lbWJlZGRlZC5vcmcgPGJpdGJha2UtZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9yZz4g
T24gQmVoYWxmIE9mIFJpY2hhcmQgUHVyZGllIHZpYSBsaXN0cy5vcGVuZW1iZWRkZWQub3JnDQo+
IFNlbnQ6IGRlbiA3IG5vdmVtYmVyIDIwMjUgMTA6NDkNCj4gVG86IGFsZXgua2FuYXZpbkBnbWFp
bC5jb207IGJpdGJha2UtZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9yZw0KPiBDYzogQWxleGFu
ZGVyIEthbmF2aW4gPGFsZXhAbGludXRyb25peC5kZT4NCj4gU3ViamVjdDogUmU6IFtiaXRiYWtl
LWRldmVsXSBbUEFUQ0ggMi8yXSBiaXRiYWtlLXNldHVwOiB1bnBhY2sgc291cmNlcyAoZS5nLiBs
YXllcnMgYW5kIGJpdGJha2UpIGludG8gJ3NvdXJjZXMnIHJhdGhlciB0aGFuICdsYXllcnMnDQo+
IA0KPiBPbiBGcmksIDIwMjUtMTEtMDcgYXQgMDk6MDAgKzAxMDAsIEFsZXhhbmRlciBLYW5hdmlu
IHZpYSBsaXN0cy5vcGVuZW1iZWRkZWQub3JnIHdyb3RlOg0KPiA+IEZyb206IEFsZXhhbmRlciBL
YW5hdmluIDxhbGV4QGxpbnV0cm9uaXguZGU+DQo+ID4NCj4gPiAnbGF5ZXJzJyBpcyBub3QgYSBn
b29kIGRpcmVjdG9yeSBuYW1lLCBhcyBpdCBjb250YWlucyBiaXRiYWtlLCBvciByZXBvc2l0b3Jp
ZXMNCj4gPiB0aGF0IGNhbiBjb250YWluIG11bHRpcGxlIGxheWVycyBvciBubyBsYXllcnMgYXQg
YWxsIChlLmcuIHlvY3RvLWRvY3MpLg0KPiA+DQo+ID4gV2hpbGUgdGhlcmUncyBhIGNoYW5jZSwg
bGV0J3MgbmFtZSBpdCByaWdodDogJ3NvdXJjZXMnLiBUaGlzIGFsaWducyBuaWNlbHkNCj4gPiB3
aXRoIGJvdGggdGhlICdzb3VyY2VzJyBwcm9wZXJ0eSBpbiB0aGUganNvbiBjb25maWdzLCBhbmQg
b2UtY29yZSdzIHVucGFjayBkaXINCj4gPiB3aGljaCBhbHNvICdzb3VyY2VzJy4NCj4gDQo+IEkn
bSBhZnJhaWQgSSBzdHJvbmdseSBkaXNhZ3JlZSB3aXRoIHRoaXMgY2hhbmdlLiBXaGlsc3QgImxh
eWVycyIgaXNuJ3QNCj4gaWRlYWwsIHRvIG1lICJzb3VyY2VzIiBpcyB3b3JzZSBzaW5jZSBpdCBp
bXBsaWVzIHNvdXJjZSBjb2RlIGFuZCB0aGUNCj4gZ2VuZXJhbCBkb3dubG9hZHMuIEl0IGlzIGFs
bCB0b28gZWFzeSB0byB0aGluayB0aGlzIGlzIGdvaW5nIHRvIGJlIGENCj4gZG93bmxvYWRzIGNh
Y2hlIGRpcmVjdG9yeSBvZiBzb21lIGtpbmQsIG9yIHdoZXJlIFMgbWlnaHQgZ2V0IHVucGFja2Vk
LA0KPiBhbmQgc28gb24uDQo+IA0KPiBGcm9tIHRoYXQgc3RhbmRwb2ludCAicmVwb3NpdG9yaWVz
IiB3b3VsZCBiZSBhIG1vcmUgZml0dGluZyBkZXNjcmlwdGlvbg0KDQpJbiBvdXIgc2V0dXAsIEkg
aGF2ZSBjYWxsZWQgdGhlIGNvcnJlc3BvbmRpbmcgZGlyZWN0b3J5ICdyZXBvcycuDQoNCj4gYnV0
IEkgdGhpbmsgImxheWVycyIgaXMgcmVhc29uYWJsZS4NCg0KUGxlYXNlIGRvbid0IGNhbGwgaXQg
J2xheWVycycuIFRvIG1lLCBhIGRpcmVjdG9yeSBjYWxsZWQgJ2xheWVycycgc2hvdWxkIA0KYmUg
dXNlZCBmb3IgaW5kaXZpZHVhbCBsYXllcnMsIGUuZy4sIG1ldGEsIG1ldGEtb2UsIG1ldGEtdmly
dHVhbGl6YXRpb24sIA0KZXRjLCB3aGVyZWFzIHRoaXMgZGlyZWN0b3J5IGNvbnRhaW5zIGZ1bGwg
cmVwb3NpdG9yaWVzLCB3aGljaCBtYXkgZWFjaCBiZSANCmEgc2luZ2xlIGxheWVyLCBhIGNvbGxl
Y3Rpb24gb2YgbGF5ZXJzLCBvciBtYXkgY29udGFpbiBzb21ldGhpbmcgbm90IA0KbGF5ZXItcmVs
YXRlZCBhdCBhbGwsIGUuZy4sIGRvY3VtZW50YXRpb24uIEkgaGF2ZSBzb21lIGlkZWFzIGZvciB0
aGUgDQpmdXR1cmUsIGFuZCBjYW4gc2VlIGEgdXNlIGNhc2UgZm9yIGEgJ2xheWVycycgZGlyZWN0
b3J5LCB3aGljaCB3b3VsZCB0aGVuIA0KdHlwaWNhbGx5IGNvbnRhaW4gc3ltYm9saWMgbGlua3Mg
dG8gdGhlIGluZGl2aWR1YWwgbGF5ZXIgZGlyZWN0b3JpZXMgDQpzb21ld2hlcmUgd2l0aGluIHRo
ZSAncmVwb3MnIGRpcmVjdG9yeS4NCg0KPiANCj4gPiBUaGVuIHRoZSBzZXR1cCBkaXJlY3Rvcnkg
Y29udGFpbnM6DQo+ID4NCj4gPiAtIGJ1aWxkIChiaXRiYWtlJ3MgYnVpbGQgZGlyZWN0b3J5KQ0K
PiA+IC0gY29uZmlnIChiaXRiYWtlLXNldHVwJ3MgY29uZmlndXJhdGlvbiBkYXRhIHVuZGVyIHZl
cnNpb24gY29udHJvbCkNCj4gPiAtIHNvdXJjZXMgKGV2ZXJ5dGhpbmcgdGhhdCB3YXMgZmV0Y2hl
ZCBhbmQgdW5wYWNrZWQpDQo+IA0KPiBzbyB0aGUgbGludXgga2VybmVsPw0KPiANCj4gSSBzYXkg
dGhhdCB0b25ndWUgaW4gY2hlZWsgYnV0IGl0IGlsbHVzdHJhdGVzIG15IHBvaW50LCBuZXcgdXNl
cnMgd2lsbA0KPiBub3QgdW5kZXJzdGFuZCB0aGF0Lg0KDQpBbmQgSSB0aGluayB0aGV5IHdpbGwg
ZXZlbiBsZXNzIHVuZGVyc3RhbmQgd2h5IGEgZGlyZWN0b3J5IGNhbGxlZCAnbGF5ZXJzJyANCmNv
bnRhaW5zIGJpdGJha2UgYW5kIHRoZSBkb2N1bWVudGF0aW9uLiBJIGJlbGlldmUgJ3JlcG9zJyAo
b3IgdGhlIGxvbmdlciANCidyZXBvc2l0b3JpZXMnKSB3b3VsZCBiZSB0aGUgYmVzdCBvcHRpb24u
DQoNCj4gDQo+IENoZWVycywNCj4gDQo+IFJpY2hhcmQNCg0KLy9QZXRlcg0KDQo=

