Return-Path: <Joakim.Tjernlund@infinera.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073ACC05027
	for <webhook@archiver.kernel.org>; Fri, 17 Feb 2023 16:15:55 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (NAM12-DM6-obe.outbound.protection.outlook.com [40.107.243.89])
 by mx.groups.io with SMTP id smtpd.web11.10398.1676650553538746247
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 17 Feb 2023 08:15:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@infinera.com header.s=selector1 header.b=Td0jHyqF;
 spf=pass (domain: infinera.com, ip: 40.107.243.89, mailfrom: joakim.tjernlund@infinera.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1vwe8QE17ZkeqKdSDVk7V9i6vrF/CT9pgjjzfcCDvSSkOxhcJc4WKC+P/o+Qs6sB8PUy+j+rcE95EC7cLny+NjLDqfpYFm+D5D1iZAzU9hlL/cgcWFA8yQoUUS5UXZ+p3WPPuytl2Rsd5ADHePfQ3yYhn0TuUhZB4SfdkQ2gXGkJzXpcvIXJyjymIXpPOitiVcOk4+D26ZXYhYCRomM/zBSJslgQfZrY6dGDLX59onjccnkw4dcUVLsM5CMc5wBv3/7Yc1McYXiIFTjeDv4+AtJ9SmfeqmxqeuHl8qqUMQgS4QQjPPBHjuJCefGufsBw4AFm707IcAOSrWhFXJnng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZTJePpxWktSZkA2pvqownSwdSnEW5KQHlIC7bFl7H7M=;
 b=SUojFpS7jgzFmFni4ey7CD3eK8idJFQ8123wRbxQ7EnLyUnTf0fFFF97EioR0POX0xCFaXZ/T8SQ4gpPZROz/AAuMIn/wlGoUVlfsA3DKJLyUN/UBnf8kFKj2INm9ubQdNAp/3YoXOiG0hxYz5K8wtthytKfWxsDH4kFumowHWvKJ3Vpgi7+q0i/zbmTh0FgAKjfgFXXbB+3G/+gE1BAKB1fjLQlL9MTOcjRxeoccdmdHWqyx6XyW++X1ZK+yhtfZ4/gRr7iJtZGurUPsXsMaTrPTudKQ8dCJvRh86R8zwEW9E+rFf4Hdy5JwSPNr6XNCBYgkxKcaLrkpjuUC3kFcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=infinera.com; dmarc=pass action=none header.from=infinera.com;
 dkim=pass header.d=infinera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTJePpxWktSZkA2pvqownSwdSnEW5KQHlIC7bFl7H7M=;
 b=Td0jHyqFEDCXAC1F+1x5Jfzal7bndE2HsKw6ZVAUSxo/funpUibm11+fJIxqLOZ6QN7uYPNEjfwXJhkakDC8KJInDsE1TMeIC0TzcfgWEb6ZrATpGJpqONRDJB4f8l+1oBocNjzbPn3RZsEMf7ygZgebmhXZ1mTyjIz62r9D6yt6IP1htPERpjg/9/qo5sVATBWmdUNUrp10U63f2Qs4O3RLay8FIiTQrTvjmLOlaFlNnRSPpMazfYPa/FGI/M/KZUTingYpUbuJfWUgryDCSUUTRPgQMkhe8QylV/tkWgGgjvY4Q4PJTn98WZj7+FmQgUXEYsNWQOm0grZTE5yYWw==
Received: from PH0PR10MB4615.namprd10.prod.outlook.com (2603:10b6:510:36::24)
 by MW4PR10MB5864.namprd10.prod.outlook.com (2603:10b6:303:18f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.6; Fri, 17 Feb
 2023 16:15:50 +0000
Received: from PH0PR10MB4615.namprd10.prod.outlook.com
 ([fe80::84a6:e9c3:8c53:8369]) by PH0PR10MB4615.namprd10.prod.outlook.com
 ([fe80::84a6:e9c3:8c53:8369%8]) with mapi id 15.20.6111.010; Fri, 17 Feb 2023
 16:15:50 +0000
From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: ERROR: meta-environment.bb:do_generate_content, the basehash value
 changed
Thread-Topic: ERROR: meta-environment.bb:do_generate_content, the basehash
 value changed
Thread-Index: AQHZQusZ2dUcmLHEeUS+clmRTM/U3Q==
Date: Fri, 17 Feb 2023 16:15:49 +0000
Message-ID: <3f7b085dca10cfb5f14d3a8fd9dade0324f3b8da.camel@infinera.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=infinera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB4615:EE_|MW4PR10MB5864:EE_
x-ms-office365-filtering-correlation-id: 4e6fd2d9-ff17-4da2-003f-08db11023c34
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 eB0rN6PDQH3P3gOgs/y4RUnH2a6xCBiUDMuSljvgs3tOs1QFt8BRJD5BxO+JIAVcZJJpROLKrJgFxgrMpjW5YxODzo2/kjYM78os3u5aodF8MnlrMwoCq9Dhj9ACSyfe6dT1mPf8/ur0hVLZPGoYGOn5BnmLjkx4kEwPiBX0nlRdswvtLWFtztPzLSyoPgzQiV7mZo40heRcRzZYfewjA4awSvhOqlW59e5TCGmSPiZLzsSvRLu6x47y9nlmklSi3O2UoVDSxOBv2kR/S3oSb42RdQVCSyt0bcuc//yMpgjymMr+f6hTPTBPScBToVYx9XC9rftIs/3GSSq5HyrV4LkGast8gvk+/tweH1dWn2acKBY0GZp8mdB9YvncnBqIAtm3XvMrEM+bixNTzPrEkqtT6tziB8cOLHVGeGKUNyWeSWYIPDnO0rXLb4O3wEGdVHAgebC+lcdbyg6ctlv8vIZ2DQcPpyzXr0bJ36LYfgIUDYvGLjrzpt66NW/jiYrub06JiMD+Tv6T6G+/WQoMf1k+TOKzzxFCVSD/VX4fUBVwKuDxwRWQrGKUU7fdL44XzDwDTKuG5i+ERWQv08yQEDX36uooBMFVUMZIdT8qc8Mi+E1aQUVdo3J83Yru5Mn/5APxJlYHAK/nIilGrRecFiPbVIpwuAC87yXxoA7savajH9n9TfSwiuzPn3WzLM8x1cngun9CTyQRCEzE4OFUEA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4615.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(346002)(39860400002)(396003)(376002)(451199018)(41300700001)(76116006)(8936002)(8676002)(91956017)(66946007)(2906002)(316002)(66476007)(6916009)(66446008)(71200400001)(66556008)(64756008)(6506007)(478600001)(186003)(6512007)(6486002)(2616005)(36756003)(38070700005)(86362001)(5660300002)(38100700002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?RHB0QWJHODRxMTNKbmtCemxQVTNjczVXVEhvTkh5UTBCdWNhTWQrbjBQdTlZ?=
 =?utf-8?B?dU92azdZdGxkbU1WTXpLenpkcWlZN2ZteTF5aWlYdEpoYXd2c002R25oa0lV?=
 =?utf-8?B?Z2RVZzBpaSttT3RLS0x0cW5GT3N5c3JmRG1CRnY1SGozZmxKankvcEZIbk1y?=
 =?utf-8?B?Vk1QUzhSZXBGYU52NVpoNlFjVUM0N3k2VFdyc0RBQWJCTmFSOUNnQWlvdWJW?=
 =?utf-8?B?R2Y0YktiTTJjQys3UkpNQWVBK2wyMEhWSTIyRzFXNVN3b2VqNWFQejBPWDhK?=
 =?utf-8?B?UWJJdCtQenMwbEYydElLZGJQUkR3UjBlMjc3cUc5RWVadlU1NGZ6ZmtPM1Ro?=
 =?utf-8?B?L3l5bU1TWEZQa0RvZFU4U3NpUWtuaFdQZXFRb09RVlVDb0tqRU5kZmJad2hq?=
 =?utf-8?B?eXB2Uk1mWkhzanBHeGdNMWFYbWc3Tys5bXZGTWFqdWQxY0grLzVwcjdtZ1Zo?=
 =?utf-8?B?QnR4SmJ3UUQ0R1VoeGJxeHpuMDNNb0NFVVE3VXpFbWVMVDF2QVZWcUM0NE1B?=
 =?utf-8?B?cXlsbWpnejkxVHZhT2tJZFdSOVRhOWV1T0ZaWHA5cjN0U0dFUS9TUmhhanZ4?=
 =?utf-8?B?elNEbjkzSFJoaU5lSmVBQUtuVzEvM3AyelFReTlNRzU0RzFCK3JHcnNmUTZz?=
 =?utf-8?B?MTY3U2tQMjAzVmY3VXZJV0M1bytXTmRSdHRxbDdVb0paVmE1aWNLYzZmOW5o?=
 =?utf-8?B?WXh6Z3B5Z08rT0tyaFNYbnM1RHJUZ2JhV2hqRGZtUmh1bjhMMmZ5VmxnMFhr?=
 =?utf-8?B?b0o2SlhkRmRiYk1BUHZoc2FwMDFIdlVRb1VHamJCcE9WM09Cb2t4ZFh1V0x1?=
 =?utf-8?B?Y2N1Z2R5Q2h6MnVyaVRaK3VuL3lCZ0lOdzZxc29rMEIxajFvNGNxWVFpeExL?=
 =?utf-8?B?SEpWYzU1UGNaOGJrZUJPT3NHYmswNEh5Nko2RWMyZ1cxdTVETXVtdkNEY0pl?=
 =?utf-8?B?U1VodjVwdWliYVdlQTVMcEdZK2JHbENzUTl4YTVUSDk5MmUzVVljS1NqU0ZU?=
 =?utf-8?B?L3krYmVQbzkwaFFyejc1dXBJUm1ueFJPWkR6MWNxdHhCNmZ0dFFCYmViT1Bo?=
 =?utf-8?B?N283UlJhdTRxSzlGbXpCUzNha01oaUY0K1YyNUZHMERaWkk5a3dQS1pBWC9Q?=
 =?utf-8?B?MFVFKzc4SUhJRnNkOU9vTjZHV0JEQVptMUFpd3Y5K1crVzFhRjdTTVRLRGFX?=
 =?utf-8?B?K1Q0UXVIaU05eFhEME1JUWFpNkVmRzBDQXZ5UzJiUytXWUtrOUtobVUvV1Vm?=
 =?utf-8?B?TnJxOXdEOFhxeWd5TGE0NkJKemJQR2V3cDlRRnhBMWo3cE1JRmMwblBjTVFy?=
 =?utf-8?B?YVgrbDgvUmlRMWg1aGtNQ0w0d0RwTlRCV3hrOWxpcHRobENXL0NQOGM2cWIz?=
 =?utf-8?B?aUJxV2YxTXIyZ3p1WWxKc1FmVlNnRFViaStQY3YwN1BtWFE1Q0NJTTV4L0Zv?=
 =?utf-8?B?c1JxTTBtV2QxSjVWZlM2dEpvdWZPZHY2ZWVCL3A3NGh0UlNsUVlNUUFDV0F4?=
 =?utf-8?B?TDlRVlM4U3d0VVowQnVGUFZKMDlCMVBuQ1E5VnhiUVI3V3hoeDJEbEpQTUxW?=
 =?utf-8?B?NytxMGZDa21PN3p6alJHUWZWUElJeEFaL0FNdHBtYVJmT2R4UG41Z1lRV0Ru?=
 =?utf-8?B?dmdrZlFBNlRWekJ3dG5OdjhNb1NWRFc4VUdCajYwS3JMOEMvWmVlNlN0Tm1z?=
 =?utf-8?B?SVBjajd0c1pTdVMrQWJYRXdPOGlRUkU5Q3EyU1N3U3pBNXZCYU81allOeDZa?=
 =?utf-8?B?UDNaWmltQjczWHlLN0RUdmdPYXZsdG84c2tEWUZKWDFPNTFaQnRWaHlIcjZv?=
 =?utf-8?B?TVVTQjRPNklTZFZsaEQxVHE2Z0F5aFNkR2wydE03VGRJTzdLZ29NYW1UVzAv?=
 =?utf-8?B?OHlTSXZwd1RWNmlBdklFL1JGNzdwQ2RQVlNrdDR1N011ZnBqdWFYakpjNVJI?=
 =?utf-8?B?QzBKQzEyaDg5ckZVUEVHZDVudEFaczV0MXdMYW1zZlFpaGdHYTlpQ1NXVnVh?=
 =?utf-8?B?d0RsRXJLaFJoUzRxcnFhOFpidytWdjZqVzd6NVV2aHlzNGtiNjA2cVFaY1ZT?=
 =?utf-8?B?NWtzODVRdVFJT1VTSE9Xb3IwTVJtNURMZGJRK0p0a1dNeVZSUVVZU3NOT1NY?=
 =?utf-8?B?ekdzN1hRZUovYXdoS3BLaVJZSDlBMEFTbGV2Y3dSQ2dDSno3cjBxVWxPTEFa?=
 =?utf-8?Q?+1/dcaLRJqB73B1tV3gsTpziGeNifm6aq8ELirzUtJXL?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE741D4A5F35AA4E894AB13329F09674@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4615.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e6fd2d9-ff17-4da2-003f-08db11023c34
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2023 16:15:50.0392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1L0YcbAhv/zMNqdlG+chBl9ibsANGrcTYiDaw0zh8YI21f8anyDaYAoUHiJHGT2826kFFfa+xhiihkBc9zKOPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5864
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 17 Feb 2023 16:15:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14459

V2UgZ2V0IHRoaXMgZXJyb3IgZmFpcmx5IG9mdGVuOg0KRVJST1I6IFdoZW4gcmVwYXJzaW5nIC9k
YXRhL2plbmtpbnMvd29ya3NwYWNlL1hSX3lvY3RvLXhyX2pvY2tlX25vX3ZhcmlhYmxlX1BWL2Nv
ZGUvM3BwL3Bva3kvbWV0YS9yZWNpcGVzLWNvcmUvbWV0YS9tZXRhLWVudmlyb25tZW50LmJiOmRv
X2dlbmVyYXRlX2NvbnRlbnQsIHRoZSBiYXNlaGFzaCB2YWx1ZSBjaGFuZ2VkIGZyb20gN2M3MTA1
M2ZiYjFlZmIzYzBmZDdhZDYwZDNkYzZkNDBhMDc3NWE5ZDE5ODMzMzE2NTkxYWY2ZWY1NzA0MjU3
YyB0byA2ODc5ZWNhZDAxMzE0NTVlN2QzNTFjODI4OTRlNjYyMWMwNDI0YTYwYTNhZTYwODIxNmI5
NzA4OGI4Njg0Yjk1LiBUaGUgbWV0YWRhdGEgaXMgbm90IGRldGVybWluaXN0aWMgYW5kIHRoaXMg
bmVlZHMgdG8gYmUgZml4ZWQuDQpbMjAyMy0wMi0xN1QxNTo1MDo0Mi43ODVaXSBFUlJPUjogVGhl
IGZvbGxvd2luZyBjb21tYW5kcyBtYXkgaGVscDoNClsyMDIzLTAyLTE3VDE1OjUwOjQyLjc4NVpd
IEVSUk9SOiAkIGJpdGJha2UgbWV0YS1lbnZpcm9ubWVudC1nbWN1IC1jZG9fZ2VuZXJhdGVfY29u
dGVudCAtU25vbmUNClsyMDIzLTAyLTE3VDE1OjUwOjQyLjc4NVpdIEVSUk9SOiBUaGVuOg0KWzIw
MjMtMDItMTdUMTU6NTA6NDIuNzg1Wl0gRVJST1I6ICQgYml0YmFrZSBtZXRhLWVudmlyb25tZW50
LWdtY3UgLWNkb19nZW5lcmF0ZV9jb250ZW50IC1TcHJpbnRkaWZmDQoNCndlIGJ1aWxkIGxpa2Ug
c286DQpiaXRiYWtlIC1jIGNsZWFuIGxpYjMyLXhyLWltYWdlDQpiaXRiYWtlIGxpYjMyLXhyLWlt
YWdlDQpiaXRiYWtlIC1mIC1jIGRvY2tlcl9idWlsZF9xZW11IGxpYjMyLXhyLWltYWdlDQpiaXRi
YWtlIC1jIHBvcHVsYXRlX3NkayB4ci1pbWFnZSAgICAgIDwtLS0tIGR1cmluZyAgcG9wdWxhdGVf
c2RrIHRoZSBlcnJvciBvY2N1cmVzDQpiaXRiYWtlIC1mIC1jIGRvY2tlcl9idWlsZCB4ci1pbWFn
ZQ0KDQpVbmFibGUgdG8gZmlndXJlIG91dCB3aHkgd2UgZ2V0IHRoaXMsIGFueSBpZGVhcz8NCg0K
VXNpbmcgZHVuZmVsbA0K

