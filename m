Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 167D7C001B0
	for <webhook@archiver.kernel.org>; Tue,  8 Aug 2023 05:56:08 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.55624.1691474158529610376
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 07 Aug 2023 22:55:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=s99mHi86;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=7584e0cf5b=qi.chen@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3785T0hv032597
	for <bitbake-devel@lists.openembedded.org>; Mon, 7 Aug 2023 22:55:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	PPS06212021; bh=V8G78Chfio5UTjBbRAC9K96GLaa+4WS4f8tyrDoibeU=; b=
	s99mHi86/MWF8gFc/2sQBcHLrBgtiuKBc3RA/yDM4e6BbYSgNKt87ewvQEooMR4O
	IObohUcm98IQJyfuRRBFSKMeoXPDdTlJ7m/PA09CnNQo1JGyNwlv1zczq2LyQxaA
	DinqMe6KY4v4ZRHMj2vJ7mtFPWl8poy3MAsicB/6C+MI+1rYUDD3SeTeWmL72xN2
	MUoi2NFQ3mRCrLR4dxF/IA2AuV9dJbPdAsgG1yLw+yYyWv2y0zIqWc0H2I8RXVGO
	YV7dmr8jiOFiceHJ2H9/Sjd7b22dbNVA0PjhnQLR/qpFBk8FVbAaAl8Mv0NO2KFj
	2RrMqADFFDYUbHyNeOVL1Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3s9hq0a5fw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Mon, 07 Aug 2023 22:55:57 -0700 (PDT)
Received: from m0250810.ppops.net (m0250810.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.22/8.17.1.22) with ESMTP id 3785tv9t012614;
	Mon, 7 Aug 2023 22:55:57 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3s9hq0a5fv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Aug 2023 22:55:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j1chdSX2xQSpza5HC/U5FZAEwzC5uaPUpClcNTdArRlK9DvMngNqa2PrlEStU3BPljmp/js0r3DpBvNx1kMuiq4cKsrWd1uiuXbcMqUPmc9pQchvuVkQN1Oohiu0fBm5JJtx5M3h41hfXWiKa+kQpe+C6/ErNb3YAKVRMCsoRnDYF99xRWdx+YaI+nXDFRmvbz7hg8F1oaAltjJPf8saNsbvaQgYJw0wu5WamNLmwxt9RinnDY99C8FBZcraEk/JbGbZ25MewkePgWvULVNK1c3zFTnctt2i6HYzXv3u79J1QmOR+vug8edsLguLzxkOkxHDs5TaMT/h4ujbjuOiXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8G78Chfio5UTjBbRAC9K96GLaa+4WS4f8tyrDoibeU=;
 b=Ec3a9iIie+iVUMpc+UyoSIoK7PJeAh+68iq8thnPorXcgewFakByttwU89Squ0wxPmqVzFWHcuwNOfJQspOr13I0YnCU6eXQ4lZ17Y6OMLjRkVauwng7XPjry6nBpyFwm9C1iDj3EY4Ozie0z7gDGAu8du5hBOHmrgubkP0ICuvDzgxvUxolooX7M+lOqcSQijbIjcTC/ZY+Ys7akmm+Rc103ljPUu+/5e9/0KdVbJ2wOFfGM7TXQSbo3F4S1lL2ZlgMDyamld382XOOh891KXevNMNLwmX+z4FyhGDvt2vqR7+76zCPtJd5hNwi13sJWTaHqAbHaNmDcWCBDq5+KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by SA3PR11MB7528.namprd11.prod.outlook.com (2603:10b6:806:317::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Tue, 8 Aug
 2023 05:55:52 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::86dd:2ee6:ac66:812d]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::86dd:2ee6:ac66:812d%4]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 05:55:52 +0000
From: "Chen, Qi" <Qi.Chen@windriver.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
        "MacLeod, Randy"
	<Randy.MacLeod@windriver.com>,
        "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel][PATCH V4] runqueue.py: fix PSI check logic
Thread-Topic: [bitbake-devel][PATCH V4] runqueue.py: fix PSI check logic
Thread-Index: AQHZxeASrO2VB6BZf0euz/CiEGifbK/e232AgAEQZ5A=
Date: Tue, 8 Aug 2023 05:55:52 +0000
Message-ID: 
 <CO6PR11MB5602151D76F55281E46F9E47ED0DA@CO6PR11MB5602.namprd11.prod.outlook.com>
References: <20230803075638.2355913-1-Qi.Chen@windriver.com>
	 <ac05a465-6da7-3441-b45d-ab65c73f244d@windriver.com>
	 <1c7bfcd4-3880-55a0-61d0-06d934d3e98a@windriver.com>
 <eb48693137116c26346d2eb07d726022d3525f50.camel@linuxfoundation.org>
In-Reply-To: 
 <eb48693137116c26346d2eb07d726022d3525f50.camel@linuxfoundation.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5602:EE_|SA3PR11MB7528:EE_
x-ms-office365-filtering-correlation-id: c83430de-8a64-4b03-277e-08db97d41fd1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 6ZLSl9eTQOmAKUCphbPOxGXdkhhFLz8sLsQaiNIGIRQUDpFvgNqID146cVPxfufRjFYOHM9pl2gYvgBdLhLbKvLXtU5mAlxRpMJyuESpXptfCnEaHkvCFM4bs8Xw1Nm+Dns6lFS18vL5Umdx/GuuLdIDBNWGQqktW9C3j9OOsrcMSjusto/vljbVo3qhmSYuFaNdte6TpiAl5xOg8KpUih72mpw1K0wi2RLUZWqolCeLlStmVOfetAiThIFKM7RYqmAPckItACynsUT15bhie+pHyPRA2lPelutcB3opjFlTfm9IANvCNYoSq2je4nUyyV7nyTTkBfT9qdygiqXDFYLQtwBAI1pvY/aUai0obCiKZvCQbAhSY9XhtQ/n//L723kLC/9dJYbCn5dQLtXcokN7yvHJMu1haqUiWsr2jQ+ZXpjR3n+CJfMOcjjjMQHUET+zXcc1kWdKU98h3gnOnlsWTGoq91d4t5sy6S8hfLDgaz7PEvFNrzvnIceQbDo1gJ5bl+JITokkMKFFuvAkubEGaIKpqpgqrS5YYuShI1u+fe+bk6roBpWWNmaqNy+5TTpp7ZwEsDDatCYn357bASzdEdoNjAwdQkhYNZ7/RMvxlsoo95ywePIvMB1RBTfN3GyiJZVq15ft+Ncgt8dokitfcePP0Wj07V3lfLqbHaWCylmpIL8lahMA6OxtU7Qi9zPLpWNi37VpiwniruhCgQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(136003)(39850400004)(396003)(90011799007)(451199021)(90021799007)(1800799003)(186006)(71200400001)(55016003)(7696005)(478600001)(966005)(86362001)(33656002)(122000001)(9686003)(26005)(6506007)(53546011)(110136005)(38070700005)(316002)(5660300002)(8936002)(52536014)(38100700002)(8676002)(2906002)(41300700001)(66446008)(76116006)(66476007)(66556008)(64756008)(66946007)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?NnBlWi8zeHJoZUhNa0ltVzBGNy9ySVNzREpXdVdzNHFqNWRDeVlsc3NZbWUv?=
 =?utf-8?B?WFp4Q2JpUVFZcjJVaFJTNktuY2R0ZGJSOHp4YXN3NFFRQUVSUm9oOTg0cUVU?=
 =?utf-8?B?alg1Zi9GTlRXNFM2OFRhTTBGN1VxN0lwaUErQU12VTB3V0MrU2dnd2Q3TFhq?=
 =?utf-8?B?cWU1aFBZS0hSOXhNc05kN05jUjFIOHpEdWRmTWFIS1FqeDRMcHMvOGtXL1RV?=
 =?utf-8?B?KzBiUkJpajZVRnVDMDNmSjkwbEVpS0RGTURSNDAwejNqbWovT2NmdUFlM25R?=
 =?utf-8?B?bXNsZkNLMk1VTklBRmdhKzNCZHFFS0t0ZFduODE1clJJM1VEbStmcVlNZ2VR?=
 =?utf-8?B?c2grMkRjbzFCdC9lVm4wL3JzeVJNNHpEYThBZEpyQXo2ZmxHbVhhRG5yZDRL?=
 =?utf-8?B?V3ZxMGdSVnRGM1hpeDBNQkY4aHd6TDh0cGFVb2tkZHdPaXVxODM1Q2wyVksr?=
 =?utf-8?B?blYxUEFtRGdxRUpFcVNPSGFrdlNIdGhkZ1JOanRZcVVBRzFLYlRTd0toVVJN?=
 =?utf-8?B?QnpnbnUyUVF5dEVGQy9FaTE2RlYwY0VTT2FDaVdNN0p6cEJRVGVQMDN0ekFp?=
 =?utf-8?B?RzQ2RHNycVFPTUtCTDAzOUZJbW9uWlNaR0JjUVZTT2NFbnYyamRGdTk3ankr?=
 =?utf-8?B?NmtDcWY0eVVMUGt0NDdFWVVvVUZaVitlTlh6eTJnaWtCOXZZc2RydjV6Z05E?=
 =?utf-8?B?SGVLRzBCMW9ERE4rcm9MdkJ5cExXVlhEZ3BBYk9naU1LRDVoTy9FMk5XVXM4?=
 =?utf-8?B?T01oM1VXOG5WemFEWk43bWY1TFIvL3RVZ2tmdUowb2ZHZ3dQVE9KS0dlZGlG?=
 =?utf-8?B?eUkyRE9sOXUrWU1saWtWQ2U0eFUxcUZBOUVIK05NYVR1Yld6bG1VYzAxMzA1?=
 =?utf-8?B?RmYzakZIR2picGI4aU91ZEtTWGJOV3RyU1BqSDljUVFyT2dSdWtrNkJEQmU0?=
 =?utf-8?B?a2dqdFhnZFZJaTVvSTlUOXJVNFQ1dFN4bEYvL09jSUxOdUdIRHM1UHkwZUxj?=
 =?utf-8?B?cTRjd1NJMkJaaldkSTl2YWRjU29VN1hheTNlOHNiQWI3a3BScGpiTGxjMC9i?=
 =?utf-8?B?ZUxoTTBxZDZubCtPMlVweHo4TitXNmNDOTdPUjlZMnhVbHJUMjdsVFNvTXMy?=
 =?utf-8?B?dGkrTStuSWlxbFNTaUgybWlTcVZaUGFZZTIyTHpxTi9aU2wwQWRGTTdLc3Ew?=
 =?utf-8?B?bFU4S1dueGtxTS9nRC83T1VTRFVuRm4yWm16SFpycERIc3BCS2VqcWJ0b3ky?=
 =?utf-8?B?VzY0M2N3dFgxS2lGOGlyWjhlcEJQM0phQURVeHJVaTREUHBNNnRoR0t4S29z?=
 =?utf-8?B?QnptNy9EckJXb1BuaFU1THV1bGIwSStrL1dDTkppcGJPMzJ6K2dWS1liWlhw?=
 =?utf-8?B?Y0RsNTBJR3hLbXVwR05yVHRwQlUzeFRjRXlCYmVIcDBBUWYyU3Z1dnFUTjhW?=
 =?utf-8?B?ckJ3ejQxZDIyWmpES1QxNXlGQ1hIZWl3TGtvSEk5Njl1SGhXOGYycjBZNWd6?=
 =?utf-8?B?MmgwWGltS3dmdld2andZay9WY2N0NHdEdGdoS2hOWXBON1R1NDBhaVA2bC91?=
 =?utf-8?B?MnpocUpmNUhkeWR2bllOTy9NL1FFSWRYeEdjaW5rSk5XVDJLdVAwMk5hRE1N?=
 =?utf-8?B?enNqK3drNDdxbHJDUUhKUlU4NVJoUXZ6cVhhcWpXTHZMTEFUVzZOMjV2YjJw?=
 =?utf-8?B?SG5Hb0tqMWZ1ejdLUHpvaGF5WEJLOTlsdmVsTjR1OFExWEh0d3dQS0NpNTFt?=
 =?utf-8?B?aHk3VGRicnBubkZ4WThscW5nVkpibUE4ZXpaREZEZUlUeHh5S0RRT2dOQ2NS?=
 =?utf-8?B?bkwvZmxyRDk2N3VrTUpiYk00dWFsRzQ2c0pjbWtqQ0REWUtCNXJXK0tleXdu?=
 =?utf-8?B?a3VhTG5JMWhYTThYeTNpVjBiaTZxcEhOUDQvTElvR0pldGtTb01JbUZVcjgy?=
 =?utf-8?B?cHVPcDRqUkhMTmZFaHpoR3FFdGZLSTZSai83ODVEcVp6dEtKWTdkOTF6OFhn?=
 =?utf-8?B?V21uVGFCRkEwaU42MzRIVW5NTi9uOTJLeHNIbkkrOGVyNDhyemVlMDZ6Nity?=
 =?utf-8?B?c1ViWjdNWWx0SThFelpuZ01pakgrOEtkK0duQWRVVmx0c0tsdFN0Qk0xRXBn?=
 =?utf-8?Q?gCifWHaq+wWgZWMkumRMgcTCS?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c83430de-8a64-4b03-277e-08db97d41fd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2023 05:55:52.5694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GMeFccMLiweLR3t4lwGud0E5Kj4R5GC1TUtnAqyxxIIQVGzX9EfPQQz1qBSQiIBCg1TPbMmbaXhW6IpG/lzy5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7528
X-Proofpoint-ORIG-GUID: DWCXpI75WBtmrN0RqvVaEeaPjHgdsVag
X-Proofpoint-GUID: uX-q70bL-cfoV8_OylewrgDabChdCanR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_03,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 impostorscore=0 spamscore=0 clxscore=1015 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2306200000
 definitions=main-2308080053
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 08 Aug 2023 05:56:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14924

SGkgUmljaGFyZCwNCg0KSSBpbXBsZW1lbnRlZCB0aGUgbG9naWMgeW91IHN1Z2dlc3RlZCBiZWxv
dywgYnV0IEkgZm91bmQgdGhlIDAgcmVzdWx0IGlzc3VlIHJlbWFpbnMuDQpJIGFsc28gY2hlY2tl
ZCBteSBzb2x1dGlvbiBzdWdnZXN0ZWQgaW4gdGhlIHByZXZpb3VzIGVtYWlsLCBidXQgdGhlIDAg
cmVzdWx0IGlzc3VlIGFsc28gcmVtYWlucy4NClNvIEkgYWRkZWQgbW9yZSBsb2dzIHRvIGNoZWNr
IHRoZSBQU0kgZGF0YSBiZWhhdmlvci4gKEkgcmVhbGx5IHNob3VsZCBoYXZlIGRvbmUgdGhpcyBi
ZWZvcmUhKQ0KTXkgc2V0dGluZyBpczogQkJfUFJFU1NVUkVfTUFYX0lPID0gIjEiDQoNClRoZSBy
ZXN1bHQgaXMgYSBsaXR0bGUgc3VycHJpc2luZyB0byBtZS4NClNlZSBodHRwczovL2dpdGh1Yi5j
b20vQ2hlblFpMTk4OS9wb2t5L2Jsb2IvaW8tcHJlc3N1cmUtbG9ncy9jb25zb2xlLWxhdGVzdC5s
b2cgDQphbmQgaHR0cHM6Ly9naXRodWIuY29tL0NoZW5RaTE5ODkvcG9reS9ibG9iL2lvLXByZXNz
dXJlLWxvZ3MvaW9fcHJlc3NyZV9ncmVwLmxvZyB3aGljaCBpcyBkZXJpdmVkIGZyb20gJ2dyZXAg
aW9fcHJlc3N1cmUgY29uc29sZS1sYXRlc3QubG9nJy4NCg0KVGhlcmUgYXJlIGxpbmVzIGxpa2U6
DQpXQVJOSU5HOiBpb19wcmVzc3VyZSBpcyA1MDQ0OC4wMDM5Njk4ODQ0MzsgdGRpZmYgPSAxLjA3
ODEzOTc4MTk1MTkwNDMNCldBUk5JTkc6IGlvX3ByZXNzdXJlIGlzIDAuMDsgdGRpZmYgPSAxLjAx
NTA2ODUzMTAzNjM3Nw0KLi4uDQpXQVJOSU5HOiBpb19wcmVzc3VyZSBpcyA1MDQ0OC4wMDM5Njk4
ODQ0MzsgdGRpZmYgPSAxLjA3ODEzOTc4MTk1MTkwNDMNCldBUk5JTkc6IGlvX3ByZXNzdXJlIGlz
IDAuMDsgdGRpZmYgPSAxLjAxNTA2ODUzMTAzNjM3Nw0KLi4uDQpXQVJOSU5HOiBpb19wcmVzc3Vy
ZSBpcyAxMjQyMzYuNzkwMTU0NDExOTQ7IHRkaWZmID0gMC45OTk5MzcyOTU5MTM2OTYzDQpXQVJO
SU5HOiBpb19wcmVzc3VyZSBpcyAxODYzNDYuMjY4MDEzMzU1OyB0ZGlmZiA9IDEuMDAwMDIwMDI3
MTYwNjQ0NQ0KV0FSTklORzogaW9fcHJlc3N1cmUgaXMgMC4wOyB0ZGlmZiA9IDEuMDAwMDg5ODgz
ODA0MzIxMw0KV0FSTklORzogaW9fcHJlc3N1cmUgaXMgMC4wOyB0ZGlmZiA9IDAuMDc4NzQzNDU3
Nzk0MTg5NDUNCldBUk5JTkc6IGlvX3ByZXNzdXJlIGlzIDAuMDsgdGRpZmYgPSAwLjAzMzQwNTU0
MjM3MzY1NzIzDQpXQVJOSU5HOiBpb19wcmVzc3VyZSBpcyAwLjA7IHRkaWZmID0gMC4wNDkyNjE4
MDgzOTUzODU3NA0KV0FSTklORzogaW9fcHJlc3N1cmUgaXMgMC4wOyB0ZGlmZiA9IDAuMDEyODE2
OTA1OTc1MzQxNzk3DQpXQVJOSU5HOiBpb19wcmVzc3VyZSBpcyA1NDk2Ni43NDk5ODA1MjUxMjsg
dGRpZmYgPSAwLjExOTM2MzA2OTUzNDMwMTc2DQoNCkZyb20gdGhlc2UgbG9ncywgSSdtIHN0YXJ0
aW5nIHRvIHdvbmRlciBpZiBub3QgdXNpbmcgdGhlIGF2ZXJhZ2UxMC82MCBQU0kgZGF0YSBpcyBh
IHJpZ2h0IGNob2ljZSBpbiB0aGUgZmlyc3QgcGxhY2UuDQoNCkJlc3QgUmVnYXJkcywNClFpDQoN
Cg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFJpY2hhcmQgUHVyZGllIDxyaWNo
YXJkLnB1cmRpZUBsaW51eGZvdW5kYXRpb24ub3JnPiANClNlbnQ6IE1vbmRheSwgQXVndXN0IDcs
IDIwMjMgOTozMyBQTQ0KVG86IENoZW4sIFFpIDxRaS5DaGVuQHdpbmRyaXZlci5jb20+OyBNYWNM
ZW9kLCBSYW5keSA8UmFuZHkuTWFjTGVvZEB3aW5kcml2ZXIuY29tPjsgYml0YmFrZS1kZXZlbEBs
aXN0cy5vcGVuZW1iZWRkZWQub3JnDQpTdWJqZWN0OiBSZTogW2JpdGJha2UtZGV2ZWxdW1BBVENI
IFY0XSBydW5xdWV1ZS5weTogZml4IFBTSSBjaGVjayBsb2dpYw0KDQpPbiBNb24sIDIwMjMtMDgt
MDcgYXQgMTc6MDYgKzA4MDAsIENoZW5RaSB3cm90ZToNCj4gT24gOC82LzIzIDAxOjI5LCBSYW5k
eSBNYWNMZW9kIHdyb3RlOg0KPiA+IE9uIDIwMjMtMDgtMDMgMDM6NTYsIFFpLkNoZW5Ad2luZHJp
dmVyLmNvbSB3cm90ZToNCj4gPiA+IEZyb206IENoZW4gUWk8UWkuQ2hlbkB3aW5kcml2ZXIuY29t
Pg0KPiA+ID4gDQo+ID4gPiBUaGUgY3VycmVudCBsb2dpYyBpcyBub3QgY29ycmVjdCBiZWNhdXNl
IGlmIHRoZSB0aW1lIGludGVydmFsIA0KPiA+ID4gYmV0d2VlbiB0aGUgY3VycmVudCBjaGVjayBh
bmQgdGhlIGxhc3QgY2hlY2sgaXMgdmVyeSBzbWFsbCwgdGhlIA0KPiA+ID4gUFNJIGNoZWNrZXIg
aXMgbm90IGxpa2VseSB0byBibG9jayB0aGluZ3MgZXZlbiBpZiB0aGUgc3lzdGVtIGlzIA0KPiA+
ID4gaGVhdnkgbG9hZGVkLg0KPiA+IEFncmVlZCwgdGhlcmUgaXMgYSBwcm9ibGVtIGJ1dCB3ZSBk
byBoYXZlIHRvIGJlIGNhcmVmdWwgdG8gbm90IGEgDQo+ID4gbWFrZSB0aGluZ3MgdG9vIHNsb3cg
c2luY2UgdGhlIGdvYWwgaXMgdG8gaGF2ZSBtYXhpbXVtIHRocm91Z2hwdXQgDQo+ID4gd2l0aG91
dCBoYXZpbmcgdG9vIG11Y2ggY29uZ2VzdGlvbiBhbmQgY3B1IHNjaGVkdWxpbmcgYW5kIElPIGxh
dGVuY3kuDQo+IA0KPiBIaSBSYW5keSAmIFJpY2hhcmQsDQo+IA0KPiBJcyB0aGUgY29uY2VybiBh
Ym91dCB0aGUgMXMgYmxvY2tpbmcgd2luZG93Pw0KPiANCj4gSSdtIHRoaW5raW5nIGFib3V0IG1h
a2luZyB0aGUgYmxvY2tpbmcgdGltZSBjYWxjdWxhdGVkIGZyb20gdGhlIA0KPiBjdXJyZW50IHBy
ZXNzdXJlIGRhdGEgJiBtYXggc2V0dGluZyB2YWx1ZS4NCj4gDQo+IFRoZSBpZGVhIGlzIChjdXJf
cHJlc3N1cmUgLSBtYXhfdmFsdWUpIC8gKGN1cl9wcmVzc3VyZSArIG1heF92YWx1ZSkuIA0KPiBJ
biB0aGlzIHdheSwgdGhlIGJsb2NraW5nIHRpbWUgaXMgaW4gdGhlIHJhbmdlICgwLCAxLjApLCB0
aGUgYmlnZ2VyIA0KPiBjdXJfcHJlc3N1cmUgZXhjZWVkcyB0aGUgbWF4IHNldHRpbmcsIHRoZSBs
b25nZXIgdGFza3MgYXJlIGJsb2NrZWQuDQo+IA0KPiBXaGF0IGRvIHlvdSB0aGluaz8NCg0KSSB3
YXMgdGhpbmtpbmcgb2Ygc29tZXRoaW5nIGEgYml0IGRpZmZlcmVudC4NCg0KSWYgY3VyX3ByZXNz
dXJlIGlzIGxlc3MgdGhhbiBzYXkgNzAlIG9mIG1heCwgd2UgZXhlY3V0ZSB0YXNrcyBhcyBub3Jt
YWwuIFdoZW4gcHJlc3N1cmUgaXMgNzAtOTAlIG9mIG1heCwgd2UgY2FuIGltcGxlbWVudCBzb21l
dGhpbmcgbGlrZSBhIDAuNXMgYmxvY2tpbmcgdGltZSBhbmQgdGhlbiBmcm9tIDkwJSB0byBtYXgg
d2UgY2FuIHVzZSAxcy4NCg0KVGhlIGlkZWEgd291bGQgYmUgdG8gb25seSB1c2UgdGhlIGRlbGF5
IGlmIHdlJ3JlIGNsb3NlIHRvIHRoZSBtYXhpbXVtIHByZXNzdXJlIHZhbHVlLiBXZSdkIG5lZWQg
c29tZSBleHBlcmltZW50cyB0byBkZXRlcm1pbmUgdGhlIHJpZ2h0IHBlcmNlbnRhZ2VzIGFuZCBi
bG9ja2luZyB0aW1lcy4NCg0KSG93IGRvZXMgdGhhdCBpZGVhIHNvdW5kPw0KDQpDaGVlcnMsDQoN
ClJpY2hhcmQNCg0K

