Return-Path: <liuyd.fnst@fujitsu.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5FDE91269
	for <webhook@archiver.kernel.org>; Thu,  5 Feb 2026 06:25:18 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.5])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14933.1770272714825310374
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 04 Feb 2026 22:25:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fujitsu.com header.s=selector1 header.b=CV9O8gld;
 spf=pass (domain: fujitsu.com, ip: 52.101.229.5, mailfrom: liuyd.fnst@fujitsu.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tJpt0amRWLDxnFXnQYsy+DkIK9tqpC+wgKzmI2ex69xbuj2YAfXs3ogXIuHtecPFmcRzrRYuGD0PcmiG3ZRwee+zdhQppbP3gLakOiuwZGcddqBZsOrO3tbm82DjuGT+ok/XD1wF7u/7QTAuMvhMpiSZnlaItLOpd1+XEA7+UqrglESYdotjCq95RGwoczBA7ERN7MmRK81ad51zgjzb57p1Dc57qVBDA4S9OO83X/yFkeFNez2Ym1MpsdhjcawslsD3lYWqqtv55JmOP2OgQBGNfAbYUJfUF4GT1Yu21BfOy2pW0vhqquyTj1c327yk65o3DVRzfe8y61BWjc8igQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lT3sCMEEaSRATnAqMyXwzzQITBj6YbJZG+wA3GIueeQ=;
 b=RV7vXqxTDiyFkrEODkkPQ6vSGZ6cr9LOh4d8Bn+N6gMNWtpwGcHunR8PqB6yfcyVPnMMb3yRy5U6fZbHiTc4CEWyaBrZPVQGXK7aTIctDJQ+JTbYUZXX8Yrmzldavl0+TQwyZbYQvbVGnzlSJ6aVGAdAD/eCzlsTH4o1UU6rvvzwHtlTeQzWxgFCiqT1iEsGYfcDcAhUhYIYOiQeJ/ZCdkJTTXr5IG/KEPqem2TNXC646gPKYjwbR7RsBYxTRjMLLGbd+6zHfTQIBGY59YiLbvHayMe31D2iygkzzEb+st6A6+eSrPZO1GhmnQ0v+1Yq/4ii5T4gxy4k3APlkg2DAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lT3sCMEEaSRATnAqMyXwzzQITBj6YbJZG+wA3GIueeQ=;
 b=CV9O8gldbi395+Kbu10C/lLjMCZHqY6zS1EaOVuasPf8Fv8CvwX3yLFSXyeNAqoBxGidlG0SMf3Jvf3CwMqpGlGjj7n1MPUk3ehlSXXYMilUVw1Jn5a/c/hYyce47ZC956HQjFCMaRoBJtFqOA+HZ1qDebWB400B/8lbi5UoLRfH3By0Uh/6XO++4w77XpNAuFZ4S+z4vkwSqpLbEgWytlSnrPhJ6W92i/3RASRDUIx83dV36g9FbRep5F0HFBJy2WoDghCynqqeb61mQofXqBPHMRQBGN4VkXyyGgZ+Id2lAVULCtS8AEmDyP2axMcWadQXV8DWteIx67vDGBE2Tw==
Received: from OS3PR01MB10106.jpnprd01.prod.outlook.com (2603:1096:604:1e3::9)
 by OS3PR01MB7063.jpnprd01.prod.outlook.com (2603:1096:604:127::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 06:25:11 +0000
Received: from OS3PR01MB10106.jpnprd01.prod.outlook.com
 ([fe80::3f28:58af:d760:e254]) by OS3PR01MB10106.jpnprd01.prod.outlook.com
 ([fe80::3f28:58af:d760:e254%3]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 06:25:11 +0000
From: "Yiding Liu (Fujitsu)" <liuyd.fnst@fujitsu.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: [PATCH] bitbake-setup: Add strip to dldir
Thread-Topic: [PATCH] bitbake-setup: Add strip to dldir
Thread-Index: AQHclmfsB4/YIqoN+UK91m8tcDefzA==
Date: Thu, 5 Feb 2026 06:25:11 +0000
Message-ID: 
 <OS3PR01MB10106185D7C9D269B00593CA79B99A@OS3PR01MB10106.jpnprd01.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=True;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2026-02-05T06:25:10.790Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB10106:EE_|OS3PR01MB7063:EE_
x-ms-office365-filtering-correlation-id: 4dda12d9-e296-48c5-1c87-08de647f50cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|1580799027|38070700021|8096899003;
x-microsoft-antispam-message-info: 
 =?gb2312?B?dmRWa0ZqRi90eGQ4dy9vWktNaVVjQ3llMjZQTlZ1USt2L241dDh1Y2hlemxn?=
 =?gb2312?B?WHFsSHdtKzNaejRzRWltZHVTVE1xMFErWE52WHZwaFB3UzZ3UnB5emF4SGty?=
 =?gb2312?B?Ly81NTJGUFhqbmprSDMwUlZlMlVZeG5TWlUrc0xJeDF6ZTM0YzQxR0JLVUJP?=
 =?gb2312?B?OVRMYzE1RUhld0dvakl4UXNNQWdkcFRNMDUyVjA2N1B1dUpyc0RObENKeGdn?=
 =?gb2312?B?Q2FtZnRLUXJxbkJxTkJDOUhybVpVOVhmQ2VJTG9wcUFweXMzMEpjUWlxZmFn?=
 =?gb2312?B?cmxwWjVRK2d0b3lLa1loY1Jhc21NYjFmR0RJd241cGRKcHcrby9SSGlPWWJ0?=
 =?gb2312?B?NEh1bTJ5Q1F0OU5WSEFEZVNoM3FiT29CTDBXTi9BbDJvVzR1Ukd2Uk85N2hp?=
 =?gb2312?B?eFAyOS8xYndXS2JCV1FoQUE4QTQwNHZWckdmajBXdHMwNS9MOEtBOHkrZCtC?=
 =?gb2312?B?NlRnRDBiMlVubkFJQWNOZDJKZEZFa1Z4cWsrNmltNmsxOHlEbXB5MzEzYjda?=
 =?gb2312?B?engzcXF0aE9KRC9ta0FvQ3ZLMmJocThMS0hwVUVyWFc2bFliR3A1SXF3Wlc5?=
 =?gb2312?B?MW5lbDZkK25GbXFVS0tOMmx4YnpPY21LZ3JwalFDK1pmUTZ6TUdidXJQNkE4?=
 =?gb2312?B?cGpUdkl2SzdTOGo1eWpQVXRtaG96c1U4eHY3ZzN5bjR1Sk9RVHUyUGxudHIy?=
 =?gb2312?B?bUZlaFU1SHJubnNqa2VsTkV2ZlhnbmRqTHNwdk5lcm8rQUUzMTZ0R3pZRGFM?=
 =?gb2312?B?eHd4WEJGcDBPbitkcHU0RHUxMks4c0l4bnJCRmtRNXhWUGUwekc2U0hhd2Y2?=
 =?gb2312?B?YTJjTjZ0M1EwTFdrVDF4OERWbFRwRkkvNFZHRFNIUU9EbUlDUVpaUiticmFz?=
 =?gb2312?B?UzdzdUF2WXR3L3p0S0czdU1idjhuYmx1TExNTitDS25EWDhrb2prbE9ENUg0?=
 =?gb2312?B?RUJYYnFWNTdDbnJwMnhRZVZBSnBkdzlCYlB2SS8rK3gyWTF1N1UvMHZsRnR6?=
 =?gb2312?B?azYrakVXT0M0dlFwdHJVMW1idkNVOW9iUmpyOEZCZUVtaU5rc3NyMG1ESURz?=
 =?gb2312?B?bldqV1F5a3VTRjdaN1NtcTRaa0ZzNitVNXJTQ0FpYjlCQktrdjNJQ3JSbmlt?=
 =?gb2312?B?cm5ORmFlSGpPa005Y0Mxc2ZsbENMZkRpTXhPcThwa1YrdHEwSnlMV0plQTNK?=
 =?gb2312?B?Q2NKVmQ4RkJDMTZQNlNNalBYOGNLOE9yTHNzbGJMK1oyd1dSbEl0U0IyTWN5?=
 =?gb2312?B?YVBvSTVQL0RTK05VdHQvYUhHaURYN3prSi83TFlJbjFhU2FIQUM2TnE4QUtF?=
 =?gb2312?B?TXU1RVVXcjJpanBIVm15Rzd0R3B5SGFWbUNTMDEyMjBHcTkxYmdOZUQvMXRY?=
 =?gb2312?B?ekcwQVRrb2lRRlBQRFZ1QStoTmFDUjZ1QjRkQjltQTdBNjNLTkUrSFFPWUp5?=
 =?gb2312?B?d3UyZ2NQSVF5UU8xdXhxdE5mdG9LVHF3VTFnNURSWUMxdmNISC93UHB5QmJ3?=
 =?gb2312?B?ekRuVDlrMXNpUE9BQnlxdmJkNllkcW9WUFhoY0JsQzlsclJ0M0g4bjMxTmwz?=
 =?gb2312?B?bEZKOTNWd25nYzJ1aHIwbXNJQXkrYi9qOTB4RDRQUjlPMTNWWkk2bTd1RkFW?=
 =?gb2312?B?Nkp1LytTNnMwMkp0UVV2cGlaMnIxZ0t4cVAvY0c5NGdGeDJNdlpGYkNkR215?=
 =?gb2312?B?M3luQUFZV280UXoxU0ZuUUNnNVBFSEtqSTRWc2ZCaUJZU0EvV0MrOFVBVXFx?=
 =?gb2312?B?ODFHN3NXaE90MkRVUzk3RmFkTFkzckZSazMwU1cxaHFFcmRLT2Z3S2VtT3Bh?=
 =?gb2312?B?M3Y0aitIWHAxekFKelBqc1Qvc1lTMVFsVWVDMUxTL3FlOXp0N2cwQnVQbzUw?=
 =?gb2312?B?ZFNnTis4VFQyaWZpK0Y2MFhaaFBUb1pVZ3htVWU2RlBjNjA1SldCNmFmVGN2?=
 =?gb2312?B?RXdzNnNCWHA4cTVYRW9Pa1hMZXZCYUtsa2R4emhWdnFrRkpZSkd2Y09RUHVV?=
 =?gb2312?B?aVVxQ2c0WTM0WUduaVBrU2p2RTdJNnAwV09kMGl4Y2UxM3g3UHZNOEdHbmVJ?=
 =?gb2312?B?bWNYZ00wa2ZjT3lKNWR4dEtXbXZINUY1TWFMYmV6WHQ2b2tMazhqa2ZlRXl1?=
 =?gb2312?B?cFEzaUFPWWNPZm8wSWRwaUFEbXJ1R3VYTFh3dlZxVS81N1hDSVpjelVrRitk?=
 =?gb2312?Q?pFSrdkNHYayIQ7a/ZLtFFDHLBDSp7LRc1At4u2ew0C8o?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB10106.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(1580799027)(38070700021)(8096899003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?gb2312?B?V1FEcGw3NTU4eTRBbk0vY0pUVmFRck82ZmhOSG81ZjdyaFFLcW5HMjREMktW?=
 =?gb2312?B?aFpQQTY1UzRERlFaNGhhSlliL01OQTBZUVJLekxDcVJIbGlZN3cyRkV6cmpl?=
 =?gb2312?B?aVp5cGI0NHIzV3BFblBBQmJ4bXc1ZHVtZVQ1VlJJaHkzUGIyTVdRMjhUazg0?=
 =?gb2312?B?amYxemh6a092NEFOdit2R3p6WVRJMnNOa1pzODZBMFdMSXlYV3BHdjdaUEli?=
 =?gb2312?B?b2wvYUgveXpEMXdvYVBsUlZwT3d2NFJNekVKWk9VWlpKZExhcGZQTXNHS083?=
 =?gb2312?B?TGNISXUvcld5QUpzVGV3YVNVZ25jTW9HaHh1VVE4L2x4a1ArYXJRSW8xbVFJ?=
 =?gb2312?B?YlJNWlBNc0czSitNdm4yMTRSbEFLQXFPZVgzOVhCbXVxbTdGdktlSVREL1NC?=
 =?gb2312?B?QWx0NnBpdDJITmQ3MytQY0lMTFNzOGhvQWR5U3ZqTmIwbG5PbWM2WEl3b2Vz?=
 =?gb2312?B?Ykw0bzNPUERRN2ZnTk9tVGs3UFlQRWhhS0pTT1daUDV6ZFMxSE8yZFlCd04v?=
 =?gb2312?B?L25ldXg1UzBobjlFN3czblowelc3UGRab3hYcjF6d3ZLc1poKytnNm4vcGhV?=
 =?gb2312?B?ZmxxY3pvMWZ2SkRORmU0TFMzMHk3UFoyOHVDM3RIVjRXT0piRnBzSHNaY3Jl?=
 =?gb2312?B?RXlXYVBYNDB4NWpHZTJQbENLajMrNlppYnVkQUxpbXRYaW52Zy9CV0l0d1JC?=
 =?gb2312?B?c1N5N2hZWlBtaEdTN2VaUmhET1NxbW9YdHVJbTZVd0hGU3NmS0RPaUtvNHJP?=
 =?gb2312?B?QmZOMVFCODdNODJad0hKQm1SK1dxRGppK2RiOWRsQU0xbXZ5WUhLZlh1V0Qx?=
 =?gb2312?B?aGlUVnpjM0h5OEdqbjh3bk9qVU1DUnlnOUFKaHg1VWlVOFh0QnQzM1dWcThO?=
 =?gb2312?B?RWhDcXBZNWhRaCtodVl3Wi9zdTYxMXpNcFZUU21qU05NRkJTb2hJaHZ0ak5i?=
 =?gb2312?B?WXFpbVJDSWdoSExDNTRvZzgvQlhnNkhibnVnSXE3L3ZObGJXVGJQbXNrYnRm?=
 =?gb2312?B?THhScUJleDAyZndZS2JmSlkwZEpmazdpTkRYUEJ0QXFnMnZidEJQbTZvendx?=
 =?gb2312?B?S29IR1pXZEorbERtMXV4NzNxRm8rby9kRVlrRVJOQVJoYXQyQVR3dmpMYzl0?=
 =?gb2312?B?Qzkxb3RVTXgxOEJIYUk2WmtEZml2RHZxcUlEcmxQbldwVW1GSE9EUnQ0dUpW?=
 =?gb2312?B?cVVDbEc2blhMS3JSWW43ZTYrY0lrMUVpaEtpL3k5VndOSUJCNzdlTkNBQm45?=
 =?gb2312?B?WGdIQmdEQVloRGRyUE02dHJJZnU4NUg1c2I1KzZnWlhiNHVuMU1QU2NDT0NL?=
 =?gb2312?B?OEdOUUl2MENpV1pEMlpaR2tGTlNuc3dKODJTUlNxNmtMUlVjN011ZzZLK1lQ?=
 =?gb2312?B?TzRBQ2dLRHhQeUttSm82Ukc3Si82NmlWSWEwWVlqSU83RFpYUDZKL1llT3Zl?=
 =?gb2312?B?Y2RoRzRRS1pqVkUxS0ZMMU5tQnJ4dkJ0ODN4ZmZPa0N4VEZEK1ZGR3NBb2lx?=
 =?gb2312?B?bzdKNHhaSVhxanFpVXpsZm1xODl5SXNHNFhTVnJZaG9nbjF5d1lVci94ZG4z?=
 =?gb2312?B?T2ZobDk5Z2tmNnJVSE13M0VqUmNGS29sTVdDUllFS0RJRlhBYjNRa3Yvb3Jj?=
 =?gb2312?B?S0tzbWhIblFmeXkyT0ZIWm1oS0VFbzJUenVKTHd5TmMyUjJlOCtRUGhEYUYw?=
 =?gb2312?B?RldMVXFoK3Y1ejg2b0pKcVhrS252KzV3VFE3T0NaNFhJdjZIWmhLOHhxNjBw?=
 =?gb2312?B?bHlTTHorR24yQlVYTU1UNmk2cDR3VDhDNS9RU0trUE92OHQwajUxZG5ob0hW?=
 =?gb2312?B?TWpmN2FkSWJQOFdXMU1xQ1lPQnRYVC8wUTVlbUdxdVpDN3RZY3I0d2YyZXR2?=
 =?gb2312?B?UlVYQTNBTlBtUHFZdlNQMTZQZmEveHBGNUZNWjNZRTBIblZ4ZFZnRGYrUHVR?=
 =?gb2312?B?NHBvRGJFN2c3d1Q4cHg5YkJwZjl1UEIrUEhtRmNtK3c2UmtJNkl2L2ZhYTRB?=
 =?gb2312?B?MmlJWkVYN0dsMldPMk92MWNFQ1d4M3Z1ZDIrL0JBa0lhMEs2TkpFNHpYbDk5?=
 =?gb2312?B?aytQRlNWYzh0OG5OTXZFc1ZDM0g0Q1FOeExRZ0JYb0x0bWhLLzRPQmo5anFq?=
 =?gb2312?B?TUVpY2hZUGRPYmgxejlyWnRCb2k4MUpUMndGNlhGS1pQRTQ2ZE1hOFR0d0lL?=
 =?gb2312?B?MG81RkJsOVZHUFhrVTRiRXhiVUdIMXJmN0ZEdDBjT2xYSFFaNVNpczU3TjBX?=
 =?gb2312?B?cFNTa21hRmx5VWxaSGhsSU85cFZpenRqT3cxY3kzNE56R2tPaG9sTUhqRXFL?=
 =?gb2312?B?STFSOHc2OGwvWU0wRVZMY1hrbkZwazVqcVkyNGNPNmRxYTZidWJ2dz09?=
Content-Type: multipart/alternative;
	boundary="_000_OS3PR01MB10106185D7C9D269B00593CA79B99AOS3PR01MB10106jp_"
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10106.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dda12d9-e296-48c5-1c87-08de647f50cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2026 06:25:11.1986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kaQtl05vJQ0Ede/XNZM9Ts9laoK7VGCTwZ78ldh0c17ucTuSOX0oa+HqsGMIjfsGti/CWCWJaS7YzfDz1uL7wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7063
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 05 Feb 2026 06:25:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18958

--_000_OS3PR01MB10106185D7C9D269B00593CA79B99AOS3PR01MB10106jp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

SWYgdXNlciBhZGQgIiIgdG8gZGwtZGlyIGFzIERMX0RJUiwgaXQgd2lsbCBzaG93IEZldGNoRXJy
b3IgYXMgZm9sbG93aW5nLg0KDQogcmFpc2UgRmV0Y2hFcnJvcigiVW5hYmxlIHRvIGZldGNoIFVS
TCBmcm9tIGFueSBzb3VyY2UuIiwgdSkNCmJiLmZldGNoMi5GZXRjaEVycm9yOiBGZXRjaGVyIGZh
aWx1cmUgZm9yIFVSTDogJ2dpdDovL2dpdC5vcGVuZW1iZWRkZWQub3JnL2JpdGJha2U7cHJvdG9j
b2w9aHR0cHM7cmV2PW1hc3RlcjticmFuY2g9bWFzdGVyO2Rlc3RzdWZmaXg9Yml0YmFrZScuIFVu
YWJsZSB0byBmZXRjaCBVUkwgZnJvbSBhbnkgc291cmNlLg0KDQpCdXQgZnJvbSB0aGlzIGxvZywg
dXNlciBjYW4ndCBsb2NhdGUgdGhlIHJlYWwgcmVhc29uIHdoaWNoIGlzIHRoYXQgdGhlIHBhdGgg
Ii9hYS9iYiIgaXMgaW52YWxpZC4NCg0KU28gSSBtYWtlIHRoaXMgZml4LCBldmVuIGlmIHVzZXIg
YWRkICIiIHRvIGRsLWRpciwgdGhlIGRsLWRpciB3aWxsIGJlIHRoZSB2YWxpZCBwYXRoLg0KDQpT
aWduZWQtb2ZmLWJ5OiBMaXUgWWlkaW5nIDxsaXV5ZC5mbnN0QGZ1aml0c3UuY29tPg0KLS0tDQog
YmluL2JpdGJha2Utc2V0dXAgfCAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9iaW4vYml0YmFrZS1zZXR1cCBiL2Jpbi9i
aXRiYWtlLXNldHVwDQppbmRleCBhYmU3NjE0YzguLjJlYTVhNWYzYiAxMDA3NTUNCi0tLSBhL2Jp
bi9iaXRiYWtlLXNldHVwDQorKysgYi9iaW4vYml0YmFrZS1zZXR1cA0KQEAgLTQxLDcgKzQxLDcg
QEAgZGVmIGNhY2hlX2Rpcih0b3BfZGlyKToNCiAgICAgcmV0dXJuIG9zLnBhdGguam9pbih0b3Bf
ZGlyLCAnLmJpdGJha2Utc2V0dXAtY2FjaGUnKQ0KDQogZGVmIGluaXRfYmJfY2FjaGUodG9wX2Rp
ciwgc2V0dGluZ3MsIGFyZ3MpOg0KLSAgICBkbGRpciA9IHNldHRpbmdzWyJkZWZhdWx0Il1bImRs
LWRpciJdDQorICAgIGRsZGlyID0gc2V0dGluZ3NbImRlZmF1bHQiXVsiZGwtZGlyIl0uc3RyaXAo
JyInKQ0KICAgICBiYl9jYWNoZWRpciA9IG9zLnBhdGguam9pbihjYWNoZV9kaXIodG9wX2Rpciks
ICdiaXRiYWtlLWNhY2hlJykNCg0KICAgICBkID0gYmIuZGF0YS5pbml0KCkNCi0tDQoyLjQzLjAN
Cg0K

--_000_OS3PR01MB10106185D7C9D269B00593CA79B99AOS3PR01MB10106jp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
If user add &quot;&quot; to dl-dir as DL_DIR, it will show FetchError as fo=
llowing.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp;raise FetchError(&quot;Unable to fetch URL from any source.&quot;, u)=
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
bb.fetch2.FetchError: Fetcher failure for URL: 'git://git.openembedded.org/=
bitbake;protocol=3Dhttps;rev=3Dmaster;branch=3Dmaster;destsuffix=3Dbitbake'=
. Unable to fetch URL from any source.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
But from this log, user can't locate the real reason which is that the path=
 &quot;/aa/bb&quot; is invalid.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
So I make this fix, even if user add &quot;&quot; to dl-dir, the dl-dir wil=
l be the valid path.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Signed-off-by: Liu Yiding &lt;liuyd.fnst@fujitsu.com&gt;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
---</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp;bin/bitbake-setup | 2 +-</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
diff --git a/bin/bitbake-setup b/bin/bitbake-setup</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
index abe7614c8..2ea5a5f3b 100755</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
--- a/bin/bitbake-setup</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+++ b/bin/bitbake-setup</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
@@ -41,7 +41,7 @@ def cache_dir(top_dir):</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp; &nbsp;return os.path.join(top_dir, '.bitbake-setup-cache')</d=
iv>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp;def init_bb_cache(top_dir, settings, args):</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
- &nbsp; &nbsp;dldir =3D settings[&quot;default&quot;][&quot;dl-dir&quot;]<=
/div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+ &nbsp; &nbsp;dldir =3D settings[&quot;default&quot;][&quot;dl-dir&quot;].=
strip('&quot;')</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp; &nbsp;bb_cachedir =3D os.path.join(cache_dir(top_dir), 'bitba=
ke-cache')</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp; &nbsp;d =3D bb.data.init()</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
--</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
2.43.0</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
</body>
</html>

--_000_OS3PR01MB10106185D7C9D269B00593CA79B99AOS3PR01MB10106jp_--

