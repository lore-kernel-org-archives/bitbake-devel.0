Return-Path: <Joakim.Tjernlund@infinera.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23262C636CC
	for <webhook@archiver.kernel.org>; Wed, 15 Feb 2023 10:38:46 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (NAM11-DM6-obe.outbound.protection.outlook.com [40.107.223.50])
 by mx.groups.io with SMTP id smtpd.web11.12096.1676457518506302080
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Feb 2023 02:38:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@infinera.com header.s=selector1 header.b=GkCKzgdl;
 spf=pass (domain: infinera.com, ip: 40.107.223.50, mailfrom: joakim.tjernlund@infinera.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IjnJZtvxhM5w05OmTaP7iamEXgm+4R9EfHMxY9IolMdykHqndPuay2Krzusz7NeaHc3E8CLnt7nihPMgHbb99PzbBLqRe/3fHh1iYlM8i7NM9yYkVNkUi5kD8rJ/JKrJN9KPIFaS9KauGSoQ7elH/rSSGVkFuNzAhQtl5EX9XdEmgM3zxH0S+ZiqqXDOnO6N3hFyyQQ98+VcaSHWgDcYUhm3iepMcnsGE7XXrcPX5Dwpg9MPKaDvvjpmGw6XYq/DrFH3gA6iqvF17DiS7UsuBrdDeirSY0p4hi60+fA1IKGIn4shRZsMbTbgS8FlHRbi8+S5r12cF5K5YDURqptU0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t2RCTBVa8C8apNCM49Qq3luEAA+kiP3JoewdK4wSlvA=;
 b=DuGpLkxc1Q9JpHpIOlt89PDWPwtVQyehL6MRBQXbjXQcCsE5wbrS5wIDnX8raHG5jOpkBuDinqf0uNOr0xAOhURto9TIq211PDrOrsJUsUpdDm05VoMW7AgMx/cysW8GyKozxdPsoToVwaXdlOGWJN6MV0USwttidUwf7s/sd+OFOWBVsmKDzjKrnDxuBCNUQF/cxZjnplzJ6SEhcTea6KSueCqAPIxcK61enKJTcNUMS3fkexYds5hqnRrmVRCcRapkMjNvHAsgrjlnZC0JXoe+WJRW1+nj9YaMwvHFkDED3KF7AZjl/yhUHXzXCCZCFrsbtFsjyydkNmhPVWXXOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=infinera.com; dmarc=pass action=none header.from=infinera.com;
 dkim=pass header.d=infinera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2RCTBVa8C8apNCM49Qq3luEAA+kiP3JoewdK4wSlvA=;
 b=GkCKzgdl9ev7mojYOb710F+Sxj/wwvRlovSPr9HesOQStLqfdkJOGe6Ped3MWndvZcdPISaK8pCHBVjhXVAgmzau5iyV3D3aL4CsktJDuURxNrWQnWG65otbRRA4o3Latz4Sp5FZD42m+tt1sY6Y/rVNvZMSaG+g2GlSrYqlYdkPcKFSckMHVHbJsmWd+RfuBG3sQj2e+lnJ49n1EjM0MgC4NuiMZwFjC0yC9qIVMRD4TpOybymvkRR5pmc9FQa5RDt56wrw0SddCdsXBpw+/GRiBixv/rNT5S8qhBbLZkcsKvq14KIdu0yngyLssQs179Ggbou6BqDd0MXqh4xwOw==
Received: from PH0PR10MB4615.namprd10.prod.outlook.com (2603:10b6:510:36::24)
 by SJ2PR10MB7016.namprd10.prod.outlook.com (2603:10b6:a03:4cf::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.12; Wed, 15 Feb
 2023 10:38:36 +0000
Received: from PH0PR10MB4615.namprd10.prod.outlook.com
 ([fe80::84a6:e9c3:8c53:8369]) by PH0PR10MB4615.namprd10.prod.outlook.com
 ([fe80::84a6:e9c3:8c53:8369%8]) with mapi id 15.20.6111.010; Wed, 15 Feb 2023
 10:38:36 +0000
From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To: "richard.purdie@linuxfoundation.org" <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] kirkstone DEPEND problem
Thread-Topic: [bitbake-devel] kirkstone DEPEND problem
Thread-Index: AQHZQHz/vCDk3+MvBUi910NR0enI/a7OfnQAgAFJ0QCAAAoQgA==
Date: Wed, 15 Feb 2023 10:38:36 +0000
Message-ID: <aeeff77922efed8c645fcebb1b91732ba31f1be7.camel@infinera.com>
References: <50f86c1869166da73d083d3c2e86f112faa978b9.camel@infinera.com>
	 <0c4d7472e556e555ef57032d7af7a9377c05fbc7.camel@infinera.com>
	 <913e646320fa02fd174566d8bfc5ca04cae269a4.camel@infinera.com>
	 <e952433b38bd2cbde4efaffd0e2c1699ecfdbe8c.camel@linuxfoundation.org>
In-Reply-To: 
 <e952433b38bd2cbde4efaffd0e2c1699ecfdbe8c.camel@linuxfoundation.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=infinera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB4615:EE_|SJ2PR10MB7016:EE_
x-ms-office365-filtering-correlation-id: 1dbb7747-355e-4384-2154-08db0f40cb05
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 ZDZTcBfCiuLHc9gJ7CMdljg/P8M5i68ziN6xiOBWIs67jtSKjfEE+VcgbXoT9w69azafKyD2zw7xR3ABwZDxxSptfNSIoCyH1nBJybcC0C3xbUi++qg3zdWmmlx+PzHDqyL4WnHr7QJQAkm+PlPjSUfA+sw0JeuVGTZ089LwEfz+kuIJ9dpNGCz63fu5pRmn+m6Wc+I0XvyWtr56hkKLNaIr4gHYMU0YvmR8OUOMEyatRHLPtVydCbq6k4yuVzlNiureZSGmiokm9+UjFwA/EejGNOuwNUSYmRTP9eryQWVKYG0e51s+w7zoThU7gj9Gx3QNGZs+RInagZ9fBRI0COCB+CZ5+Ak8237w/gplSsLdfFBvD0x+FfyjdVZ2bHfuFV6DlEXrCiTOrsu6Axnr9GVG9OSizm02/Ahex2i4ZCIakpEBENh39vbPCL5BkgSXFtyZhIECYtxMyPnswBvejlCcRnWnoyJYPCk2jr2aRrsRAEkHI3dWOMppRChmanUZr4I7ukbLcYiPf48Jolxo35pCrQbR2DHjJs0p0Oa1qzHz8JoAWaOS7IPUXrf5N0mMCw2gZoBJNyDKYt3lak8UTP340+sOSt6Bl4KElyLR7ecc+Kz+pp7WGT5H5NHBjxuwTf83Eao0mI2z9C3GxJxtVkZCQE9xLV+zO7AQz2BAx+F2/fxF26zkXR0QBuqEdxH3LiqX2RdinRgzPO51a0vZww==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4615.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(366004)(376002)(39860400002)(396003)(451199018)(36756003)(2906002)(71200400001)(38100700002)(38070700005)(122000001)(83380400001)(2616005)(91956017)(76116006)(66446008)(5660300002)(8676002)(66556008)(66946007)(64756008)(66476007)(316002)(41300700001)(110136005)(8936002)(6512007)(186003)(6506007)(86362001)(6486002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?MFgreENzV0M0VFc4WUc1aHlZWHl1TlBDcjEweGVVWk45Tk93Rk55cWVzRTRH?=
 =?utf-8?B?d0o4VE5sM0UxYWExQVJ4WHFZeDdOZzY4dzd0WGxsMENFa0gxbTk1Q3djblky?=
 =?utf-8?B?T2J5aUFpdHFQcS9TVWxMb3dFV2NKK2xKT1hVSVpRcTlvNHhyOERSY2V6VFVl?=
 =?utf-8?B?MW1DK0JrTU90RFJaSjdZbzBKYXVUM1VRTGxGcjQ5YnBHUUdTQzVwVmxjd2RR?=
 =?utf-8?B?aXNGbVBJVHBpLytBMUVUNG85WElEcGM3eEh2T1RHWkpXWWVFeHE1OS9qV21T?=
 =?utf-8?B?cHhmdGhRQmFWWloveDhUNUZVYi9DSnhoK0VidDIwQm9JRjhzK3Z2Z012Tyto?=
 =?utf-8?B?V09IT1R2VE5jK1lEZXNKWnVqUGdKL3M5RmYzTzQwUlFzcERXMlhqRm1WRHUx?=
 =?utf-8?B?VXg4TUFQMjN3aFErRU5zZW5Ibm1xaGhEaGt1emkxbG5sb2REcFY0SHdrc253?=
 =?utf-8?B?aE5KdEsydmVWVVJpS1pPVUhuODZkVjJIbzhQdmJRQW1JZXZIZklJdmsvNGJZ?=
 =?utf-8?B?dkZ0NnU5Y1pDcjlQcmNQZjF4dkpoWW1Hd25YTlZ4Y3dsMk92clpTVDErWjVT?=
 =?utf-8?B?RE5nbnc2VUczRXI5Rk9kNjFyNGNrdmxhMmhxcXNXc05VRW1QeU5EdWM3SVJh?=
 =?utf-8?B?MC9aMzcrbnBXSU1yUEJONnBtOGxRV3cyMlZTM2dodjM3NjNOeWxpZi9jdGNj?=
 =?utf-8?B?MDNxWmNwSnBoRktzSTdmNXlqRDY4T1d2UnJvM2xEbVJvUDZ6NHd1T3dEL1Vk?=
 =?utf-8?B?NlQ1MlNNRitqT2RnbEp6blJVUDVSMElLNlF3OU5ydjNTNU42cWI2dHE0Y1ZQ?=
 =?utf-8?B?RDUra0J4SWJuc3dUUW51bTVSejVlVVAyb2FkWCtrbVVxNklKbWcxb0tEa2N2?=
 =?utf-8?B?c3RQVC94SnhsTmJlM2k4cUR0WUNJZmZJeHRIeUZHMnQvcURqNnBWdGpwS2pJ?=
 =?utf-8?B?bVZReXlNRW9WU3JReFoyZnhiSVR2MUJkUXJhSkE3K1Q1bktGdVB2THpBUFYx?=
 =?utf-8?B?UTdVY2lQWlVYSkRxK0FnL3dKN3FxSWY1ZSsxeGxRMGtTREZFbVNhV0d0VGE5?=
 =?utf-8?B?UlE5Ryt4M1JyWmczeEpPOTZxT05GWUJuaytDYmtCNzNpNEFIcTB1SVFhUTRT?=
 =?utf-8?B?cUdmT3lPWlNUYmlTV2FBWXdKcjMvN0kxSHVETmNrVjRnaytwcGIvby9LYW9u?=
 =?utf-8?B?NkJNNlM5WUwyRHV4NkgxakdaSEI1OS9zNEl4U0xGYU84WG9CdGtRN3pnWDNv?=
 =?utf-8?B?SzBhYXp2NkZ3bGRjK2VJVFBPTmVURDB5d0phRnE4cGYvdEFPNlI4czFwdXZT?=
 =?utf-8?B?NVc2TSs3MDQ3SnAyenVBRXBKSVNFVjRsUWJ0SnJMdnBDZHdZdUJPSFFqTCtG?=
 =?utf-8?B?ZTVyMXNScWV4TnhDUFdreUhpNWhkalY4NlhPbXptcXNYUmEzbllac3RueWk4?=
 =?utf-8?B?QkI2R2pMUHFoU0NZdVc5Z2tqSjN1VUw3SjdjWlhzVTFYZ2RVeUgvc2FnVDl2?=
 =?utf-8?B?cGlHSG5aUmpNelM3bC81bFEza2lLWVhXcnJIbkVzQ0s1WTY2QWc0TFgzUEhD?=
 =?utf-8?B?Q2YxVDkvQkpQc2pqUHRIeGE1dFNnQ0lOeHZwdCtSNXlSb1QxL1NNWW5jdDdC?=
 =?utf-8?B?a2xRTlpnemtQaEtpVEtzRFFhV0toTEJjei9FTy9wUEk2enh2M1g0S3J3a2Nh?=
 =?utf-8?B?ZWNNOXZTMGhrSlVMKzRhSUxBSGJJOFExdWE2dTA1N0gxbjhnMXpiSmVaeUxn?=
 =?utf-8?B?SllXbUZYT0VCZXlCeUloRzlVczFRZkMrN3FqWnh1Nk1wM3NUMWFNYWJyZzBU?=
 =?utf-8?B?TGJJMnFTOGZRbEkzYjdOOXk3QmFUVUFNbUtXVytNV3cwOEEzWENCRFR3RjR6?=
 =?utf-8?B?ZzI1eSt5cHVMeHBkd2R4c2Y3NXQxTk9SMWt5ck9rN2gwcDBlWW01V3Eyak9t?=
 =?utf-8?B?Znd0QlpZdzNkcEJvWGN1ZFlvb01IdlNSbjlyNzlzWFZlbSt3K1Exc0dTVmlR?=
 =?utf-8?B?TEprOU5LRG55aUhpT1l6QmdKcVIxcGVhcWxIZ0lPa3JYUFZqWDF0S012MnJU?=
 =?utf-8?B?YUlpMytzcUFLSUozUWdMWGRFZzY0a1BZN2lmR1NtQ1NRditsNWhPeGVHZGIz?=
 =?utf-8?B?QzBsMmhyYnpHZGpzUXlPekZkeTNWbUx3SWw0Q2xZNHpzWFlrOVV2MnBheWRR?=
 =?utf-8?Q?EOd94YMvlGP1L9DLsIli5OYequNqW+hcGH8pYTQLcq/G?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6FA58696B647ED48AC1E82C3D8944424@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4615.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dbb7747-355e-4384-2154-08db0f40cb05
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2023 10:38:36.1179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zQwgfB/orFjjC5KZaCpXKwAzDD6ZvAU+0kC/V04EN9Gui4IA7ENnlqtyfSOjUI7pW6HT3dWZSOVwdfoHU3vGzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7016
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 15 Feb 2023 10:38:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14424

T24gV2VkLCAyMDIzLTAyLTE1IGF0IDEwOjAyICswMDAwLCBSaWNoYXJkIFB1cmRpZSB3cm90ZToN
Cj4gT24gVHVlLCAyMDIzLTAyLTE0IGF0IDE0OjIyICswMDAwLCBKb2FraW0gVGplcm5sdW5kIHdy
b3RlOg0KPiA+IE9uIFR1ZSwgMjAyMy0wMi0xNCBhdCAxNTowNiArMDEwMCwgSm9ha2ltIFRqZXJu
bHVuZCB3cm90ZToNCj4gPiA+IGluIHN3dXBkYXRlLmluYyB0aGVyZSBpcw0KPiA+ID4gICAgIGRl
cGVuZHMgPSBkLmdldFZhcignREVQRU5EUycsIEZhbHNlKQ0KPiA+ID4gICAgIHBuID0gZC5nZXRW
YXIoJ1BOJykNCj4gPiA+ICAgICByZGVwZW5kcyA9IGQuZ2V0VmFyKCJSREVQRU5EUzolcyIgJSBw
bikgb3IgIiINCj4gPiA+IA0KPiA+ID4gICAgIGlmICdDT05GSUdfUkVNT1RFX0hBTkRMRVI9eVxu
JyBpbiBmZWF0dXJlczoNCj4gPiA+ICAgICAgICAgZGVwZW5kcyArPSAnIHplcm9tcScNCj4gPiA+
IA0KPiA+ID4gICAgIGlmICdDT05GSUdfU1NMX0lNUExfT1BFTlNTTD15XG4nIGluIGZlYXR1cmVz
Og0KPiA+ID4gICAgICAgICBkZXBlbmRzICs9ICcgb3BlbnNzbCcNCj4gPiA+ICAgICBlbGlmICdD
T05GSUdfU1NMX0lNUExfTUJFRFRMUz15XG4nIGluIGZlYXR1cmVzOg0KPiA+ID4gICAgICAgICBk
ZXBlbmRzICs9ICcgbWJlZHRscycNCj4gPiA+ICAgICBlbGlmICdDT05GSUdfU1NMX0lNUExfV09M
RlNTTD15XG4nIGluIGZlYXR1cmVzOg0KPiA+ID4gICAgICAgICBkZXBlbmRzICs9ICcgd29sZnNz
bCcNCj4gPiA+IA0KPiA+ID4gICAgIGlmICdDT05GSUdfSlNPTj15XG4nIGluIGZlYXR1cmVzOg0K
PiA+ID4gICAgICAgICBkZXBlbmRzICs9ICcganNvbi1jJw0KPiA+ID4gLi4uLg0KPiA+ID4gICAg
IGQuc2V0VmFyKCdERVBFTkRTJywgZGVwZW5kcykNCj4gPiA+ICAgICBkLnNldFZhcigiUkRFUEVO
RFM6JXMiICUgcG4sICsgcmRlcGVuZHMpDQo+ID4gPiANCj4gPiA+IFRoaXMgZmFpbHMgdG8gcGlj
ayB1cCBkZXAgaW4gZGVwZW5kcyB2YXJpYWJsZSwgYnV0IGlmIEkgY2hhbmdlICcnIHRvICIiIGxp
a2Ugc28NCj4gPiA+ICAgIGRlcGVuZHMgKz0gIiBtYmVkdGxzIg0KPiA+ID4gdGhlbiBzd3VwZGF0
ZSBidWlsZHMuDQo+ID4gPiANCj4gPiA+IFRoaXMgd29ya2VkIGluIGR1bmZlbGwgc28gcGVyaGFw
cyBhIGJ1ZyBpIGtpcmtzdG9uZT8NCj4gPiA+IA0KPiA+ID4gICBKb2NrZQ0KPiA+ID4gDQo+ID4g
DQo+ID4gQ29ycmVjdGlvbiwgYml0YmFrZSBzd3VwZGF0ZSBidWlsZHMgYnV0IGJpdGJha2UgbGli
MzItc3d1cGRhdGUgZG9lcyBub3QuDQo+ID4gVG8gbWFrZSBsaWIzMi1zd3VwZGF0ZSBidWlsZCBJ
IGhhdmUgdG8gYWRkIGRlcHMgZGlyZWN0bHkgdG8gREVQRU5EUyB2YXJpYWJsZToNCj4gPiAtREVQ
RU5EUyArPSAibGliY29uZmlnIHpsaWIiDQo+ID4gK0RFUEVORFMgKz0gImxpYmNvbmZpZyB6bGli
IGx1YSBtdGQtdXRpbHMgbWJlZHRscyINCj4gDQo+IFRoZSBtdWx0aWxpYiBjb2RlIGNoYW5nZWQg
YmV0d2VlbiBkdW5mZWxsIGFuZCBraXJrc3RvbmUuIEkgaGF2ZW4ndCBnb25lDQo+IGludG8gdGhl
IGRldGFpbHMgb2YgaG93IHN3dXBkYXRlLmluYyBpcyBjYWxsaW5nIHRoZSBjb2RlIGFib3ZlIGJ1
dCBJDQo+IGNhbiBiZWxpZXZlIHRoZSBtdWx0aWxpYiBpbXByb3ZlbWVudHMgYW5kIGZpeGVzIG1h
ZGUgZm9yIGtpcmtzdG9uZSBkaWQNCj4gY2hhbmdlIHRoZSBiZWhhdmlvdXIuDQoNClNvbWV0aGlu
ZyBlbHNlIHRoYXQgbWF5IGhhdmUgY2hhbmdlZCAod2UganVzdCBmb3VuZCBvdXQpIGlzIHB5dGhv
biB2ZW52IGRvZXMNCm5vdCBpbnN0YWxsIHRoZSAicGlwIiBiaW5hcnkoc3ltbGluaykgaW50byB0
aGUgdmVudi9iaW4gZGlyLiBJcyB0aGVyZSBzb21lIGNoYW5nZQ0KaW4ga2lya3N0b25lIGhlcmUg
Pw0KDQogSm9ja2UNCg==

