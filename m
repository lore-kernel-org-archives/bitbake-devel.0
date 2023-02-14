Return-Path: <Joakim.Tjernlund@infinera.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA582C05027
	for <webhook@archiver.kernel.org>; Tue, 14 Feb 2023 14:07:04 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (NAM10-MW2-obe.outbound.protection.outlook.com [40.107.94.66])
 by mx.groups.io with SMTP id smtpd.web10.7679.1676383621547316053
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 14 Feb 2023 06:07:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@infinera.com header.s=selector1 header.b=kp+qXyYF;
 spf=pass (domain: infinera.com, ip: 40.107.94.66, mailfrom: joakim.tjernlund@infinera.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PLAoylwa62tupODnEs1bwo9GhA+v8RlAYOoNQthkuDqdEgwryEBShRH3qwxzupG0TnOZCFkOc5uPaJ08sfon44V9gC+QJgnU8YNlqK08XXk1HMYtS+xXrA4VrgKqu4oD3qbPJUcG2zcTG+oRV7iKRCh26cVCXm8FEOvquD7wYzyK9Z/U3vKQh+uMnf325dgdlEdGHDsi58E9WfX0vLdiX75cKcQZ72DWIx+lR4QU8juel4HZSi2W4QdVcGdjffLFZGsdYhXh3YMHzleF6AJ5dLNSg+pLu2nr2YyUx6SSPx6eddH8CnV0UVNJ8PCPXYnD0wU9HVUKxc2uYgoF3fVUoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=80SFB0gbtc76NzDLnGNA9/APxaEj06TpN5dkIl+RAAE=;
 b=ETqFxr91xez0TblJiwCW3/7jBNli9sfD/pqYDhgz+vFMLHx3wneCGkmBiVOhMicKq2r1Nl1aZu7rNuBAppfhH8J5wdbf/yAJSxZOhgO4sZFk7VSv6BJFF0ow+fRW5GmCdr4S9lufoRzvgnmrXdCfzlrAATKUmZi2cSqXRhcKZPlnYAg/k7Ho+efDD2S5r1ih6V8SoV9EXqXsy5aO81HuRjfvFiwG2dsaFSRvS35Rl4t/U3VbE4ArJmWDdAOPfAJjN66J1iABXH+vll5gBs/9znEuBRvb2X95hNnb8qyX9TN9JilRfABNYb36OLcloqm+mP1rz/LFS4kLuc95Cn6t4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=infinera.com; dmarc=pass action=none header.from=infinera.com;
 dkim=pass header.d=infinera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=80SFB0gbtc76NzDLnGNA9/APxaEj06TpN5dkIl+RAAE=;
 b=kp+qXyYFOPTl+GA8z+R5JtW80rNeI0M5QAqgcq1gy8nW5eCpe1vCz6Ld9mz5qvdY+WRPWy4/AjO75S+Sx/ik3tuOoCuv34XZ2xlUJUM2dOc1heQQyz1w39A+GNp45lvUGxVQnTxWDtOSVmGxtuvVtdrYK05UCSPy0m929gpIZHCu9Gav/eRVU/t7Ooh2IHT9WYergCT3AU0A2VkhZ7XvORsJxJiSPizD2fF2vXHAx7gI7pe+DDg0/ibVgED0aVD8XNFlhmJ+IQna903cnV5dgDCul6nMdmoH2W2hr69zK7jAeT/fjP2O7pRWCv8stNdFbVvDkX9VHWdKRfCrALvgSA==
Received: from PH0PR10MB4615.namprd10.prod.outlook.com (2603:10b6:510:36::24)
 by SJ0PR10MB5767.namprd10.prod.outlook.com (2603:10b6:a03:3ef::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.9; Tue, 14 Feb
 2023 14:06:59 +0000
Received: from PH0PR10MB4615.namprd10.prod.outlook.com
 ([fe80::84a6:e9c3:8c53:8369]) by PH0PR10MB4615.namprd10.prod.outlook.com
 ([fe80::84a6:e9c3:8c53:8369%8]) with mapi id 15.20.6111.010; Tue, 14 Feb 2023
 14:06:59 +0000
From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: kirkstone DEPEND problem
Thread-Topic: kirkstone DEPEND problem
Thread-Index: AQHZQHz/vCDk3+MvBUi910NR0enI/Q==
Date: Tue, 14 Feb 2023 14:06:59 +0000
Message-ID: <0c4d7472e556e555ef57032d7af7a9377c05fbc7.camel@infinera.com>
References: <50f86c1869166da73d083d3c2e86f112faa978b9.camel@infinera.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=infinera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB4615:EE_|SJ0PR10MB5767:EE_
x-ms-office365-filtering-correlation-id: 69b54444-a18e-4122-f208-08db0e94bd61
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 xPbpxVGCWi06/dasp/iRuCe+v+AZwluWMcPD1C42tFpNcm4qczWIK4Qm85gFz4UpomhaVwUYPPabqjxO0e6VVkEsWmokOtfiD2JQQM8Y/EzkN6P+QJ8OFJ2gGmtTDrK+LG6Nxbn1eqi+fXGd8I2NAgvJPosZk1E+q6fbEV+wWyqEmLtxJwjenZvmaFL5mV2rGGeseIb/Yl163mvFV5M/hYtzLIeEFk6giqw/+5+O1l7A718LIkTzJR3OKd3Y5zo4TyrXgICwYQv6oNOHiFmxmLHQaJT17mpp2sMRuj4YhytFsPggtZAGe83llMBRHGCtmKgxonJDOyqVpQ9/bAH3GGvsHrqxzBNfnP4TC3JNh+y0KPQbi7U7334mIWcCimMZrI+N5Swj/DAk1yuJ5a7qv7+O6WGCloLBjNYyt4UCC167NQZXCtw0YU+bXhLfUDE30WStJqB/ybxwOPXPpWkjpSUdLogwhTLuIvW4ZINhJMuyi+A1dBi6sNTN9htqZR6GjslS5rIkXMHLNlSOJMZ87NAxJ4gn4NdRqJwzWt505o6LUYI9BJGuoDEALJU/ReVkHB2AQB/bi41VxEWLiIXz3ClFVfo3GviKuaYaqAgOrFg1JfA0fIwgWXyfJtsgi2jGn59hwQkXi9tEmGgGwLlW1YF14/BODcFQnX2+pLZJc1ktjFSuiYGhxzUOCIDnTjgs
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4615.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(39860400002)(136003)(376002)(396003)(451199018)(2906002)(66476007)(6916009)(91956017)(41300700001)(66446008)(316002)(83380400001)(66946007)(64756008)(66556008)(8936002)(8676002)(5660300002)(3480700007)(7116003)(478600001)(76116006)(6512007)(186003)(6506007)(2616005)(71200400001)(6486002)(38070700005)(36756003)(86362001)(4744005)(38100700002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?LzM1ZE81RUFZN0pGM0dmUmlNdGZuWnVERWFQZGFUQ0FMNGR2TG1pMkcyQXdK?=
 =?utf-8?B?UWEzUDlpZjJpVnVjYktDYzk4djRXYkw3c2QwV1c2elFSSVBob2wzc3NPcWJB?=
 =?utf-8?B?a3dtQzVpanZFaXZGWGI4cnhaZU0rOG5tdnUwc1JTaUZNc0kya0lKdDBRbXNt?=
 =?utf-8?B?T0NqZVRWRUJNN0dOdDlLbnlMVG1TZld4Qm9pQ0xyUklueWZtc2p5WFRkOGNM?=
 =?utf-8?B?b2E1L0Y1bXZLT2FkNTQycVdsWUJJd2ZaeUNoQ0N6QjZ1bTFOVkhIYjZ3NUVJ?=
 =?utf-8?B?bjNZcVRIRnU4VDNmM1k1ZTNsbU1sNGVaczY2Y21Gcmw4aDA5N2tTUi9PU2Vu?=
 =?utf-8?B?SlZXZjNSN3NTMC9nbFZGb3d6bnBSNlVOWFA4bnZieEdBZGlDS0tEWWtMMnpv?=
 =?utf-8?B?TXh0ZG04UHF3eFgzdlVIUnB0SlRVc2kyd3JNcjV6OTRjZmgrbGpOV1FNQXMz?=
 =?utf-8?B?MGQ4R2cxMzR2NjMrZTNISVdiajhXVkdnMGkzamxmcW00bmN6UTkwWVNiaEU2?=
 =?utf-8?B?Mkc3RnEvQ1dORjhNS3NRN2dPM2l5RDBmSVpNZmw4VVVsWjZvc3EvTER1UDBT?=
 =?utf-8?B?b1ZZUkxJNm81Nk8rVlVaMm41M2RMaWo4Uzc2T0cvaEdvcUNwbHJMd2lvZzFo?=
 =?utf-8?B?ekhsSlhEZzJWUUhMRFNXaUNYWUo2bHg0RnlyVjVtMlk0ZmtmL2h3SXJDYi9i?=
 =?utf-8?B?OEVIZVZGTTMycUtqZFl6SzNUWGV6TTFYYUxPKzJodWVscU9aOTU5dXR0UzdN?=
 =?utf-8?B?ZURpVFhQOXhYR0Fwa1Z2MnhPcy9JVXp1UUpRNFQ3ZEFaTCtKSnZHeE14TURR?=
 =?utf-8?B?d0E3anZWK3M4SGxDOEI3RHZVbzhmdmV5R0V0UXlHa1lnZk5Jbk9vYnlVZlFh?=
 =?utf-8?B?aEFoejNMckswVE92UGZxZ0tCYmRvUGFxR2Q4UDJmV3FMWUlIUldEcjU0eUVY?=
 =?utf-8?B?YWwvUFdsUGExV1dwSllGd3RtbnhjVTYvMXcyVncrT3FVL09acEx3V2tNMk9l?=
 =?utf-8?B?YUZQVzJBQk1ZR3AwQUdMNnl1SStEZEx6dTdaVm02cFlCQldub3hQVDNrMWJ5?=
 =?utf-8?B?cDZNLzlFbWRQcG1sZ1VYK3VqMldwWmxOQ1V2Y1VTOGR5WkFnZmEvVUM4WTMz?=
 =?utf-8?B?WWYrVmtWSm4xZWEybjRxWGR6TnNqcElodGREWHhJbkVtaE1aRG4yaXVIOFJt?=
 =?utf-8?B?T1Zvdm0rcHpoR0hKNS9GckZoZlcyUFRGWVRyR2RPbFJrb09zQUNPNlQ4YjV0?=
 =?utf-8?B?dVBKOU56emdPZjlTa0M2bm41T3ZLcklqNnFCdldQYUNBSmlZS09sQlRZRnZl?=
 =?utf-8?B?NE5wekRnL1M0bmZmdGxuY01uM0lGOWtoN1oxUzRFaXJ4b1NyQlNFYWF3aC9C?=
 =?utf-8?B?bkJUTEV4bEtxMDJESEpaMnMzaU0wWVExUitPaVRGMVc2TGJUdU9PUUpnQnQv?=
 =?utf-8?B?YnpoL1g0cXNKY1dxS1J3R3ppMVM4c2tyTzF2eUFrQnlOUnJ2enNjaHFEODMv?=
 =?utf-8?B?bzIydG5TaU5uaVhkQXZmdGx1dDlrNnFYL2wrd0hsOGIzNFl5S1VXOGg3eWRG?=
 =?utf-8?B?eGJyUUZKY1hVS3diSndHSE8vQUVsL1Q3cUJrb2lWdUVkb1RDanF6Q1I5UlE2?=
 =?utf-8?B?U2t3WW1EUFhreXRBMUJUYVRLZk5WemdFczcwWTZXalc0Y0xScE9qVHp0RnZa?=
 =?utf-8?B?RmVqWUQ2MFk4N2toUDhPMDExMUN2cVdOUWhRYW1ROTE3K0ZtclRxOC9zSkhF?=
 =?utf-8?B?TnpnVWhKdldwbzJVMS9lSkdLM2VpaldmYUZyVWhmUk9lc1U0cEp0Y3pZTW9B?=
 =?utf-8?B?d3dkazFDYkdaamJYUUZKdzJ2dDQ2RGdYdCs0djBVOENkVWxFeHdGMzZ2bkw2?=
 =?utf-8?B?eVhkd2k5RG9Ya0hHUnZkZHB4WVZKVnRuNlgwTnMyMGNCYlZSaUxHeXZPdXhl?=
 =?utf-8?B?U0NiN1J5RXdJbjdvam1QM3ZCQlhtWnFHUVk2ckRSa1VqRGRwbDhEZlROZUVS?=
 =?utf-8?B?Ny9ZcXlKUEIvNms1MTJLaU5FaTl0Y09PK3ppUmYrdktXUTJhZ1NuQmJ5QTNZ?=
 =?utf-8?B?d0xuSUhhK2VuMXg5TWZ1MnhiTER1REhOTjFKbWhTWEpKOHBSNGk1R3U2UEQw?=
 =?utf-8?B?YjBkMXZHQThKNUVhQnhIVDZleDZZS0JKRW5EUFNDNVlUdWsxUDNsdmM2bW5x?=
 =?utf-8?Q?3gph/QTpNu5AcpSavaOz7wD57iCKeLpIt2qPjx2rA5kp?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1E0734EDF7AB4A4F846B960C915648E1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4615.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69b54444-a18e-4122-f208-08db0e94bd61
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2023 14:06:59.7849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hWmD6H0cTdhOrNDfE1yeULNdYx/1zUkY6dzWpB9KMIkxKHvGu9kx9quQezh+p64zCWXMkNZgVGRsxkyocp7eXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5767
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 14 Feb 2023 14:07:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14408

aW4gc3d1cGRhdGUuaW5jIHRoZXJlIGlzDQogICAgZGVwZW5kcyA9IGQuZ2V0VmFyKCdERVBFTkRT
JywgRmFsc2UpDQogICAgcG4gPSBkLmdldFZhcignUE4nKQ0KICAgIHJkZXBlbmRzID0gZC5nZXRW
YXIoIlJERVBFTkRTOiVzIiAlIHBuKSBvciAiIg0KDQogICAgaWYgJ0NPTkZJR19SRU1PVEVfSEFO
RExFUj15XG4nIGluIGZlYXR1cmVzOg0KICAgICAgICBkZXBlbmRzICs9ICcgemVyb21xJw0KDQog
ICAgaWYgJ0NPTkZJR19TU0xfSU1QTF9PUEVOU1NMPXlcbicgaW4gZmVhdHVyZXM6DQogICAgICAg
IGRlcGVuZHMgKz0gJyBvcGVuc3NsJw0KICAgIGVsaWYgJ0NPTkZJR19TU0xfSU1QTF9NQkVEVExT
PXlcbicgaW4gZmVhdHVyZXM6DQogICAgICAgIGRlcGVuZHMgKz0gJyBtYmVkdGxzJw0KICAgIGVs
aWYgJ0NPTkZJR19TU0xfSU1QTF9XT0xGU1NMPXlcbicgaW4gZmVhdHVyZXM6DQogICAgICAgIGRl
cGVuZHMgKz0gJyB3b2xmc3NsJw0KDQogICAgaWYgJ0NPTkZJR19KU09OPXlcbicgaW4gZmVhdHVy
ZXM6DQogICAgICAgIGRlcGVuZHMgKz0gJyBqc29uLWMnDQouLi4uDQogICAgZC5zZXRWYXIoJ0RF
UEVORFMnLCBkZXBlbmRzKQ0KICAgIGQuc2V0VmFyKCJSREVQRU5EUzolcyIgJSBwbiwgKyByZGVw
ZW5kcykNCg0KVGhpcyBmYWlscyB0byBwaWNrIHVwIGRlcCBpbiBkZXBlbmRzIHZhcmlhYmxlLCBi
dXQgaWYgSSBjaGFuZ2UgJycgdG8gIiIgbGlrZSBzbw0KICAgZGVwZW5kcyArPSAiIG1iZWR0bHMi
DQp0aGVuIHN3dXBkYXRlIGJ1aWxkcy4NCg0KVGhpcyB3b3JrZWQgaW4gZHVuZmVsbCBzbyBwZXJo
YXBzIGEgYnVnIGkga2lya3N0b25lPw0KDQogIEpvY2tlDQoNCg==

