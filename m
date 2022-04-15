Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20C5C65BA0
	for <webhook@archiver.kernel.org>; Mon, 18 Apr 2022 14:26:02 +0000 (UTC)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by mx.groups.io with SMTP id smtpd.web12.3950.1649998830625236836
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 14 Apr 2022 22:00:31 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="unable to parse pub key" header.i=@intel.com header.s=intel
 header.b=d+bHvp4f;
 spf=pass (domain: intel.com, ip: 192.55.52.43,
 mailfrom: anuj.mittal@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649998830; x=1681534830;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=II4dEdb8jnpRxQ84f1LUN/vIw4mIb8UxyoG89/YNTWU=;
  b=d+bHvp4fetbFWlJO3E6/FsN9KOmb7SEKD9kNZlcw+NCzx2mO7sM7m2lD
   yj6J8KXKs1yICgHy9N3qs/GvXlnz15TussrnChWLuh1Gf0AaStRj8GjGB
   PPW+a735oAJqFXU9IZS1x754nGL5vgUpFNu694xB+K2wQo+LV1WQ51vJ2
   vBNYJEHCpHWjyJx4kNiE7ZknK67htXC7/sFCnaCrgFsfWH6BXfmwfnAaK
   MEqD8d03JfAerP9hX6nmEgYqv8weMkNxkY2rfqsDgknwID1+bIbm0rjXa
   9qLZonaVvveiYUB/9LaOkJoDqro0KOpHMGinVNnKPNI2QtuhWX3+63r/0
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="349529988"
X-IronPort-AV: E=Sophos;i="5.90,261,1643702400";
   d="scan'208";a="349529988"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2022 22:00:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,261,1643702400";
   d="scan'208";a="591447385"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 14 Apr 2022 22:00:29 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 14 Apr 2022 22:00:29 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 14 Apr 2022 22:00:29 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 14 Apr 2022 22:00:29 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 14 Apr 2022 22:00:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PAxtnLOVwQ/1DHep91/xZXLlA9EkeO7crSzT5PsJMfcdvFL39PLz3WMbe8JpNAxBaVsL47XgjnY1f2GELV8SY9jiyoMzCRx8kH6JJWZQRaPY0kvh3EPYm/fnr+e4UjB6RkkRmpRMt5r05aHi7q6wvKtDKy6eE8WVExc6HPZmVZBEf8KYtkkxBuTpk0noBs0Gc2HCs0xChVwkpFjsn6oT9Nk3v9CFxqQWNxdwutFvcPDfRFnU/vzWyzrWwBedG0bC3SlwzOotwjnK2fpCHsxDOK1e5VvzWIvVN09IZ8p26jY6qPT2qMYt1oRrDsk4wyRVOD7Px3114ifYg+rbGYfZyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=II4dEdb8jnpRxQ84f1LUN/vIw4mIb8UxyoG89/YNTWU=;
 b=knOr6gdejJjk8eHnjpZLH0fbf0e2UcOtlmo5iFWk1/CSZ4OelHCGNfqCrLuFuVH/7VXtOl4el37pTE4sFY27do/I5J+T0lgJ2x/3NilOa7VCTps8ExhMz64HzFlwqjGFA0OCwHGKec+oYIQLWwCqnmCajDqjV9m3OE8ADHCAwvNo8SlckNYO0N9e3+LPjwqAxMofNGiHBXaWE9B54zge7hmHpu72kvV+wXW3ykZqB+FxoCwUBJPDN34tC5UO2BDY5zBssJ74b9ElBUek/W05PP4YY9X287Ly5wFp1CiaH+4IZ4c4DyG/fFCbfjj6HxswkdYI2ZLnnabNCFV9Ea1czg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB4896.namprd11.prod.outlook.com (2603:10b6:a03:2dd::20)
 by DM5PR1101MB2314.namprd11.prod.outlook.com (2603:10b6:4:58::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Fri, 15 Apr
 2022 05:00:26 +0000
Received: from SJ0PR11MB4896.namprd11.prod.outlook.com
 ([fe80::8159:14f9:7d9f:9bdd]) by SJ0PR11MB4896.namprd11.prod.outlook.com
 ([fe80::8159:14f9:7d9f:9bdd%5]) with mapi id 15.20.5164.018; Fri, 15 Apr 2022
 05:00:26 +0000
From: "Mittal, Anuj" <anuj.mittal@intel.com>
To: "luca.ceresoli@bootlin.com" <luca.ceresoli@bootlin.com>,
	"marius.kriegerowski@gmail.com" <marius.kriegerowski@gmail.com>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH] scriptutils: fix style to be more PEP8
 compliant
Thread-Topic: [bitbake-devel] [PATCH] scriptutils: fix style to be more PEP8
 compliant
Thread-Index: AQHYT/R1H1zziU0JGUOBUtXnYEWKO6zvgyoAgAA12ICAALKEgA==
Date: Fri, 15 Apr 2022 05:00:26 +0000
Message-ID: <21a09c414ff08dcb87f1b5a2c127069e9aacfe45.camel@intel.com>
References: <20220414114009.56067-1-marius.kriegerowski@gmail.com>
	 <20220414170846.55417ac0@melee>
	 <9418ABBB-4F3C-4062-860A-53068272E18A@gmail.com>
In-Reply-To: <9418ABBB-4F3C-4062-860A-53068272E18A@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b1e8f1ee-d5c6-408e-2208-08da1e9cdaea
x-ms-traffictypediagnostic: DM5PR1101MB2314:EE_
x-microsoft-antispam-prvs: 
 <DM5PR1101MB23141257F6273F016019B2A5F8EE9@DM5PR1101MB2314.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 mphd5uJMPgjYYdaqBOl/Ur46UG9Bibq3d1UHSXULhrq5rWoPWErKS+Kfs1SeA9beC6e00ASuXbkxWhcgeDM7c266r+Agsg5QXvjCGrqQXTKF8Sz0DkDD/E9R1dtx1dTdMjy7+xqU7KwdPaVUQIABUWrCZ6Et6bDqy9Tgdb6wqZxFW7s/YpinnC+uXilZksyInbOaP0YiysM8YVXeWrPYutJrxA8Dwdg4+6DEryQPx7MR/JN37QQ/3/vEtNrZLhLW22/jhkoLrKvqgsR0+4dclrrc3HPPUn7ZCvd97lzYqCX8P9mpD1vdZWvrnVOVqvkLvvxwo4pSJUW/LGQB7iht+Nf+WBmr0y24JQ2qcqQkgdoK5dnW084q6WCrqWKMQwBcnZNmTCodoOZ92e8crk+ja28aRN4GbIyFA5Xiajhj8kBFVYqWgL2/h38pZTLS84I+Z+ow6PUa5pGq1zjhpb41NYE1s576EThIz5fi0ECcDEmkJpoNHmVY+6+jdm389A8xxOpLvYRdrcZf3gs2HdtLxXNjr+M2RjkzFlpHecIrVOZYhj5LpoIr0er50ZVYTdUW58KM6E9vFKk7N5PXxwC6hoSwD1BaKk82N6tIjQOvwum0RPLfyyKrEW+vHK3N6zYe65yMNek46yJxIRkjKLy9kS8WLFQXNK4S+LHf4f0I1AN1inf2A4pT4SE56Mc8T8+Cj81eAsN3oI2q0OnBxCwEYnbDCG1Tg6YBJ+U1UNovzrqSY3PB0G9sxuzvPOBHSCX7OXiDvTie/HezBnwjddX81uQphREg9QV/YwXMaOwWtFdrumQd5j8KyDPkVOE4NZeunCv6joC/dRz8BwMT28007w==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4896.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(122000001)(82960400001)(5660300002)(4744005)(2616005)(36756003)(38070700005)(38100700002)(110136005)(316002)(83380400001)(2906002)(86362001)(91956017)(66446008)(8676002)(4326008)(71200400001)(508600001)(966005)(6486002)(66946007)(76116006)(66556008)(64756008)(66476007)(8936002)(26005)(186003)(6506007)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?RUJYL3FFTzl4MHVoVDlIWTlWZXYvak1iMk11Q2s0ZUgyaC9tU3NURmdvcnc0?=
 =?utf-8?B?eElsTzJTLzVmeDJaRVBRT203WnRpaEN5aUdhdXVwUEdpeE1tbFZ2Y3dTTVBJ?=
 =?utf-8?B?RmVBSEdNc2EyZHVwV1d5bUVuaTNPdmY3QkV3ZkZsRmdwVURTQnoyaytZWlE5?=
 =?utf-8?B?OFZocjVJN1BMMitLWXd2NHIxRllRMlRFeElsNjNMSVlVZVIzb1ptVVpHVjlB?=
 =?utf-8?B?TmRmeElkcUJleDR6UnpoTXkrUGg5UjVDZDNoMFNQWDBWUEd0Q0oxSFNlU2Ni?=
 =?utf-8?B?eUVpWDhabFZLa09MRXoyclYzZnAzTVcvei9pdG05cGUxSEJWUExTMW9nRnZy?=
 =?utf-8?B?T3lCK25oQnVyNVRrTVFzd1BuUFY1MFVBb0UyQWtGVzVzSnBUL1JQV1ZSdDBp?=
 =?utf-8?B?STJYbmdQNzJjQWh4TzZRY3FRbGZKOUFuOHdEcWVOVjhkem8yK0xxc0dlMHBO?=
 =?utf-8?B?UDAvQUJhVnJzeXYvUTVlT0NrdFpjVlVoYTdCcllVNkZDZTY0TmMzYkJtMGti?=
 =?utf-8?B?MlRMMmVRMEQ5c2Q2dzBmRUY5c1EwSUdQTXN2UmZJY01SUmxxVlU3Q01CY2k1?=
 =?utf-8?B?QzUxMngxVjJrRHN4MWgzZ0VDQ1MxNTJOYkdKNkRLTDRBTzRJS3BYTTk0dzgz?=
 =?utf-8?B?VkI1S00vR0hXdHk2cTRLWFRaeUlWTWMwazNQVXdmeWFCQXNhdFdCZDFBdHBR?=
 =?utf-8?B?THgyRklNL3IyVHpBdks5NE1ZUm5USDdQM29FYzFhWTgwUUxBdUVDUmNNN3Zn?=
 =?utf-8?B?a0x5ZTBzMVJLRDVNclAwSzlISzl2VU01V3FwNzRGRGFIVHRpMTJLaitqUE1M?=
 =?utf-8?B?VkUvQWppQllLd3dhTVBiRVdRa1RSWElCWkxUZTlhaDloMjVSVTNiTlJhQzhk?=
 =?utf-8?B?UnJkQXdTRnZjaXVMQnJ6Q0xDdVkzbGNzdWN5eElQazlTWG1DdU96VXJwdWNU?=
 =?utf-8?B?WDhoT09GRm9VOTJsTVI3OFBCcVI0OHJ2TmErSU5qdlJGV2lHZmdwbURQQ3BN?=
 =?utf-8?B?QnYwbVRjclF2QmpscHUxdVQvWDRwK3VXMnJqNjlWTmRtSmxJNHFUSHFHTisx?=
 =?utf-8?B?RHF3UktiZVREaThpUnlUdnhDYTFWTVRIamlselJqbnBWNmtkVHh2ejVyRC9P?=
 =?utf-8?B?NW5nbHo4V29xTGc5eG1Vd1NRNHppMktWRnl5eDI3UmRpN3NreklVdFpEelJO?=
 =?utf-8?B?MjluRDhYd2VnbFFFZ09OdVdZczAxUnJLbTMvU0Jha1Q2encwQS9mY1J0UEZE?=
 =?utf-8?B?QmNRZ1BGN0hZaGJZNFZhbmpBanpNRGc0RThKWlF1OTRZbUt6RVh4Zk0wZlcr?=
 =?utf-8?B?S3djOHJhOXhqL09rMjFTMGgwRnJzMEFqdk1EeEFjNHpvNm9KOVNvWXRqUjBR?=
 =?utf-8?B?ZEo5eTk4ZUJzZUJaZVFMdExTNnZUcWdYdWZXMEJpaElHTk1vUWR6R2hpSmRB?=
 =?utf-8?B?d2ROTU1pWEptQVJUekpaTGhOM2NTemF0SFVoL0o1NWRQNG1nQnpBQXA0QjRG?=
 =?utf-8?B?R1Voek9vT2VuQTY1OU9uMEp2cFBTUUVuc0hKd2VVS2Z5d3Y4T0JqTjlwTGlO?=
 =?utf-8?B?WEhoMklvR2ZGbWRKWm5sdXAvOHdUYThqSGU0WnJBQUtpVzN5MjhkTlNTdko1?=
 =?utf-8?B?aktPYmI2OURoUW81TmZmZ1dSQzU3eEdwKzg4M1FTL3dwMHZIT093dkI5dDgz?=
 =?utf-8?B?RlFCRERKbXFEV1VTMU9xcXY5UWJHRFc0YkVXakcrWHM2UnQ4MVJJQ1cvdytt?=
 =?utf-8?B?VGFLZWxPUEpBNDZCeEo0V2JJeHNwWXBhZTcrUCt0ZHFyNFRVa1hxVHZrMEZ3?=
 =?utf-8?B?WEhWTXQrWkhKVmV3TjBrYVByVVo3cERDb3E0MFlibzlvc1JuZElza3NTczBR?=
 =?utf-8?B?K0ZuZ3RxaXVKekNWT0NxbE1HaUw5dm8veWVPdHAyOFRtZzVuNkhmZEJwbC94?=
 =?utf-8?B?Y0d2VUlZdnl5c0tmSFVlMzB6cmZLSVdURUp5WFAySjJGY2RnOU1MdS8wQ09a?=
 =?utf-8?B?N1J1dnpNSExiQU9CZXVkSlgxek4vaTNnVTNKS1ZlRDJBdEdXb29NblFsMnR6?=
 =?utf-8?B?V2xBZDBmYVdoRDFZYjRRT3JjOEFXSHJNYURFZmZtdlpVcDBJaFVITG5TQXhn?=
 =?utf-8?B?cmRoZlZ2MXhVQ1FxSzhZUjVsa0lkYmhxYXp2N25BbjI1YjRmWENiNEkxSDRY?=
 =?utf-8?B?M2Q2dlZDNGFoeHFTZGNibTFFdVRSZHBqajZjMWMvQW1CbkN5ZDlZRjNySmtv?=
 =?utf-8?B?V3gyZnRzTVNvYVAzSHF4Yk5ObDAxU3lIbnpET0hjdkkrMlRadGFFNFkwUTl6?=
 =?utf-8?B?SG1HQy9SaXQxOW5hb1l0Z0hmZlhCcm42ZTNabWwrRjBuSEUyeDBnMnBiUEFo?=
 =?utf-8?Q?2unp4k/tX7Xjn+0M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F09E73DEB45DA74CA1473C904C38E3CB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4896.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 b1e8f1ee-d5c6-408e-2208-08da1e9cdaea
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2022 05:00:26.2074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 hsCO50mb/JYxybyjlvVK6+HE7Inzeg4KEqC/AHv+qhcI8A9siV/07mqhyy0pjv7XRvjqVRhrL1TTNKyIKStwRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2314
X-OriginatorOrg: intel.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 18 Apr 2022 14:26:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13628

T24gVGh1LCAyMDIyLTA0LTE0IGF0IDIwOjIxICswMjAwLCBNYXJpdXMgS3JpZWdlcm93c2tpIHdy
b3RlOg0KPiANCj4gVGhhbmtzIGZvciB0aGUgY2xhcmlmaWNhdGlvbiEgUGhldywgaWYgb25seSB0
aGVyZSB3YXMgYSByZXBvc2l0b3J5DQo+IHdoZXJlIEkgY291bGQgb3BlbiBhIG1lcmdlIHJlcXVl
c3QganVzdCBhcyBJ4oCZbSB1c2VkIHRv4oCmIDspDQo+IA0KPiBBbnl3YXksIHNvIGp1c3QgZm9y
IG1lIHRvIGdldCB0aGlzIHJpZ2h0IGluIHRoZSBmdXR1cmU6IFRoZXJlIGlzIG9uZQ0KPiByZXBv
c2l0b3J5IG5hbWVkIHBva3kgKGh0dHBzOi8vZ2l0LnlvY3RvcHJvamVjdC5vcmcvcG9reSkuIElm
IEkgcGF0Y2gNCj4gc29tZXRoaW5nIGluIHRoZSBiaXRiYWtlIHN1YmRpcmVjdG9yeSwgSSBzZW5k
IHRoYXQgcGF0Y2ggdG8gYml0YmFrZS0NCj4gZGV2ZWwuIElmIEkgcGF0Y2ggc29tZXRoaW5nIGlu
IHRoZSBhbnkgb3RoZXIgc3ViZGlyZWN0b3J5IEkgc2VuZCBhDQo+IHBhdGNoIHRvIG9wZW5lbWJl
ZGRlZC1jb3JlPw0KPiBJcyB0aGVyZSBhIHBsYWNlIHdoZXJlIGFsbCB0aGF0IGluZm8gaXMgYWdn
cmVnYXRlZCBsaWtlIGEgdGFibGUgd2l0aA0KPiBsZWZ0IGNvbHVtbiByZXBvL2RpcmVjdG9yeSBh
bmQgcmlnaHQgY29sdW1uIG1haWxpbmcgbGlzdD8NCg0KSXRzIGV4cGxhaW5lZCBoZXJlOg0KDQpo
dHRwczovL2dpdC55b2N0b3Byb2plY3Qub3JnL3Bva3kvdHJlZS9tZXRhLXBva3kvUkVBRE1FLnBv
a3kubWQNCg0KVGhhbmtzLA0KDQpBbnVqDQoNCg==

