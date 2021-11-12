Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C11C433F5
	for <webhook@archiver.kernel.org>; Fri, 12 Nov 2021 02:50:43 +0000 (UTC)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by mx.groups.io with SMTP id smtpd.web10.10211.1636685442394153849
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 11 Nov 2021 18:50:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@intel.onmicrosoft.com
 header.s=selector2-intel-onmicrosoft-com header.b=pDORxoV6;
 spf=pass (domain: intel.com, ip: 192.55.52.151,
 mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10165"; a="213789054"
X-IronPort-AV: E=Sophos;i="5.87,227,1631602800";
   d="scan'208";a="213789054"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2021 18:50:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,227,1631602800";
   d="scan'208";a="502284369"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga007.fm.intel.com with ESMTP; 11 Nov 2021 18:50:41 -0800
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 11 Nov 2021 18:50:40 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Thu, 11 Nov 2021 18:50:40 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Thu, 11 Nov 2021 18:50:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DdgzIgESH1P4UHEG9Fv0yffPIiQHHOURY06S3oChP0OvWkkqI33AmPSQ1Pmbbrx281fCJympwH/VjhDT4eujryvbQ1JQGWeV2R9kqtmuWpt2ho4xda49rw4BMxSvWia1Sd9F4yfxfIvhyBZFgrYJYmF8tfnrLEwZknIuUrg0V+/iKdnJoyQqx/ocvk8wIqq1oVv4q5YtZcXWouXWGcvzBdUnjJrZQF6S4KykKJzjBCcvKE2n0DMTC9xosiU6jKbDZN1MrhX+Nv3t8O8g3nbIRgl2D/CfbIRTM1d8Rn0hBLHA8nLjOQTkfxmB7jnjfc0ihV9p4FEBSsssSm2z94++ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZPkbLpZWjImtt8mC9SHiV3BMqi+enJWpomomtustvY=;
 b=e8k4eTIZoQ4AiHb/n4aNWsvWOwJM+eH7MEYipB+Ym4D0XHlhIX+dqHEkhvXxpPGog8VE48ID3Qo6mXsT4ZWivvFxKS5/xXSvtcPtr025jeljRSWbC0qsUpICrtBKmF4jABZ5pMBpiXkZKYsXuDGGJAbxlTxySqrEEAcqAZYRW/MuNuxz9mcsxftiy/NaJ4i6vy+aikDf2mAHUspvU49wL4NSmr8Wm3Ylr8zrV8Zxe/Lc7yedVlQluDqYjtYinoyV1o2ljSE9SAkvGITvz6G8VeQOEiE1sRmj+Q/oGfuMsJ6AXV74guURpIVIpVHow8gRwukb7+9BRQYnZJdv5w3TFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZPkbLpZWjImtt8mC9SHiV3BMqi+enJWpomomtustvY=;
 b=pDORxoV68KZS06u2lJK/e0XdaDhyiRKTmK1lJLsiCd8WU00OMuq6zHa3P2zow+KcTDiOeMD5zB+6Pm25bqSsOIQBQdwbLA9msrGQlENSNIECdGa/1e8SIR1Ze4KZOnW5Acb48fgl+R9inDd4ApWu79VgCPtfcNMgqxpQCZeIsyk=
Received: from SJ0PR11MB4896.namprd11.prod.outlook.com (2603:10b6:a03:2dd::20)
 by BY5PR11MB4387.namprd11.prod.outlook.com (2603:10b6:a03:1cb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Fri, 12 Nov
 2021 02:50:39 +0000
Received: from SJ0PR11MB4896.namprd11.prod.outlook.com
 ([fe80::2c3d:dccb:aa85:53c5]) by SJ0PR11MB4896.namprd11.prod.outlook.com
 ([fe80::2c3d:dccb:aa85:53c5%2]) with mapi id 15.20.4690.016; Fri, 12 Nov 2021
 02:50:39 +0000
From: "Mittal, Anuj" <anuj.mittal@intel.com>
To: "richard.purdie@linuxfoundation.org" <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [1.52][PATCH 5/7] cooker: Handle parse threads
 disappearing to avoid hangs
Thread-Topic: [bitbake-devel] [1.52][PATCH 5/7] cooker: Handle parse threads
 disappearing to avoid hangs
Thread-Index: AQHX1Xj393qDeVzBxEu8ZT2tlDN+O6v+MD+AgAEE9AA=
Date: Fri, 12 Nov 2021 02:50:39 +0000
Message-ID: <91f00870e81d5268157f7d6edb38e6683c1f0edb.camel@intel.com>
References: <cover.1636469164.git.anuj.mittal@intel.com>
	 <446269bcf62addbe55f6abee3b81a882f2fe2b94.1636469164.git.anuj.mittal@intel.com>
	 <1b791d5c581038f715d80a4d47a7c74d0b367a36.camel@linuxfoundation.org>
In-Reply-To: 
 <1b791d5c581038f715d80a4d47a7c74d0b367a36.camel@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.40.4 (3.40.4-2.fc34) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 57c56371-cc33-4e74-1f48-08d9a5873619
x-ms-traffictypediagnostic: BY5PR11MB4387:
x-microsoft-antispam-prvs: 
 <BY5PR11MB43878DF423078384D204E050F8959@BY5PR11MB4387.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 6BAMFFVuO9zkQJWq+SOv69KWzLWdoFXFZzOcDnWjf2jnC6SSslw8OKDEVKP9aNe3sZ6+2eKAHRmGdBzLR5Eri/PojOXsziRSNkhM605sYeUHbLJRu+Rpz/+mWuAuvv7Gp2aenXbiKa+MejeHaGSHpHG1T4kBg7c+v7vUQuKH9oNF0GscW318Bd2d4vGmzJyYtRc5oREH6Aq2/1Z9bzhv8la58Fwt1vBmO7SJT+k9BZiL3Gii5jSbTkHt/q0aLSAE1XBZofHYQRuJ2rVqugtQsHAuTWe0cvMEaFGnFnlXf/9tV/PZzynZIMHiI7bQ6blhsHFuWDnzHQBr0DpL5YYrvMncM59o/u1XjxKEFFftXk73ryOYJ6XJ1QUbtxqyyeBrpDQ2FDphBNyNMrOT+SbeiT+tWJaTDnEB4ohwEbD8n9mcFBh9g2IR9kYoV9gmlUjipvsRFTW23y0dqg6dsCtgwZaqSeNRfFF0YSkW/EAvRf9WfGgHpgEkhpHkn3mGoZmHMuWK8DOVATtuXVzXkDy8/lAP/r1o42+vPSzOWBY2IDbmuS4XRyj8wXf02PeiKfA16bGuXFHjUO/j0bkI16FnVfZvvd+KA6oN3qbqT3bl8sdQOS0J7s+QsZL5HnB1AgHzRF78PDQtT/Zw72bwGht/F8gKdMdsnmqlBbyvBczttDZ1NG0MFVC5ezbX+4Szist6eOq49IQ/woVn4u2qoJ38RQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4896.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(71200400001)(4001150100001)(186003)(38100700002)(83380400001)(76116006)(86362001)(26005)(5660300002)(110136005)(316002)(122000001)(8936002)(8676002)(36756003)(6512007)(6506007)(38070700005)(82960400001)(2616005)(2906002)(91956017)(508600001)(6486002)(66446008)(64756008)(66556008)(66476007)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?THZUWExKTS9NTS9HMjl6bkZWSGM5UDdJUElxaGtlUjlpTERNLzV0T3JNSzRK?=
 =?utf-8?B?ZUVWZzdLNTI5SVlBRlRMUU91ODJkMXkrVENabm14QVRLTTZCNytLZTYwbWNH?=
 =?utf-8?B?eG4ycGRybUQ2eE8yVVBXaU1BWkhYWWcreEhydzhON1o1S3Y4YmR5MkVEOHN3?=
 =?utf-8?B?R3UzekRLdXRDMmIzYm1xMnphOTZ2MFBZenQySG40M3kzaTRMNUVYdzRwQUZu?=
 =?utf-8?B?b0cxcHRrc0cxQXU3RWtVTDZPU0tQUlZZa1A1ZG9QK0pIbDNXVnhUa2U3cnU5?=
 =?utf-8?B?eThxRUtNc0pQWFhYZmJLTTJjZGdtV05CZjcrQUlIV0FYSFJuallDNWJZcHh4?=
 =?utf-8?B?NkZseU5OV2VvdjlZM2dpdFpuZDlkQ0RWNEhvb2w5c0t1a0lOL3R1bUZnOS9C?=
 =?utf-8?B?OTNaSGVucWVGL0xsbXdKL0VEZTQxZXFEeEtONFpsNDZrMXp0dk9VcnlmeHNV?=
 =?utf-8?B?NFhGd2RHeGNRT2EzWnE3T25Lb29KY2VyUjhReWJKOFoyOEdsaVBlUXJKTjBj?=
 =?utf-8?B?RE9XSWFMaG51aU95a29ObU9rT2RCTXBwSUh2R0RnOUxaSEIrNEtGc2M5cmRI?=
 =?utf-8?B?NW13Z1lXU0h4b2tjT0s1T2JncmJVUmtOQjRGTWhlRkwvSkpudi8vbUFCK1Z0?=
 =?utf-8?B?YkdlTGZEMVZJdlpXeVg5aWZpbW5kcHBXQ3U5bHRSL3J2ajN5b1RQeHZlWHRw?=
 =?utf-8?B?Z1ZnNHl2aGtYdFY3SmZUT0prelFpR3k2emFKSzBFdTJpSXg2akdDSDFPbVpB?=
 =?utf-8?B?RU9IVGE2Sm1oeEpITGpHcllNS1RIUXBWQUhYM3RPMk43ME15blFEYURtdnl6?=
 =?utf-8?B?Nkg4TU80UjU3V0JyVVpUSE9IR0lmODRHa29jWFFOc09UZFRzWnFRTmVwN0dh?=
 =?utf-8?B?MTdnQ3dYdmRXK3cwMWNGOWE2aUhXZ0lzY29lUzJka1R6dXladDlQMGFoOTVh?=
 =?utf-8?B?OVRjeElLalQ5aEREcStZaStmVUZVZXc1TnNMb1dFcnNjaVc3UDl0a2lzamNv?=
 =?utf-8?B?c1JHT2tOOWdyeVh0LzRzWlh6K0RPc2hlM1psWTNUZUdlbTBYUml0aHN4eGhP?=
 =?utf-8?B?Y3VjNCtaRXFDdFBUVDlSOFZ1aXJTeVpBNGdQMVhuR2swSlVtRUxwa0JrN0U2?=
 =?utf-8?B?Q3FDR0lDUCs2WUlHcS9JeFdkWm5GNy9ZVERVWW4zYjI3U085dmVXSDFyai9m?=
 =?utf-8?B?c0dkanBOQnl2RktNNnpwNHBnMVJnK0JsOWkzUGQ1eFptWFlwTVc2VDNld3Jp?=
 =?utf-8?B?TzRtVzUwMmVRT2xMbW12ZzVJekZWcVhHeFJZdmJmcHdPeUpvRUtGUU0yL0FV?=
 =?utf-8?B?K1dRbTViZ3ZhYTNtZElSTHFOdFFsM2U4SHVuMGRNMlBueDBPcEFzWjR6UnVH?=
 =?utf-8?B?TlFNWnpHODltdEQ0Qy84Q0Y3eXhjL1BwWktROUpVSXJkcXY3TUFucmx5eURO?=
 =?utf-8?B?OTVKUWNrY3lMVFBTSHc1RXR0L05qMGdKSUE5QjNJVkhNcXFtTnJaL2hrNUVT?=
 =?utf-8?B?SWNKYW1FYUVldnJWVU10TnRXeHBITkpYQ0VyYjZEZittT2hOK2oySmlLUUho?=
 =?utf-8?B?M0ZFbGRCWVNWVWZ4RkxJVzVOUnZCVFYvNDJlYVpzWjYrSWxiZ3lENnFML0l3?=
 =?utf-8?B?ZzJPWnFocHExSVpMM2ZrL21kYkVPWU9MOHJpVXp1MTA2QS9reVRnNlFNWEtn?=
 =?utf-8?B?T2hZd3UvZHdZR1crbm5HV1lIdU82TUNMazlmSVRJSGIzeldMRzNQTHBneE9Q?=
 =?utf-8?B?WjkrRUo3M01oSDdydTV6WUlmRWpBRVBERi9mTWRXQUt3RmpFMGh2ZjlLSGVV?=
 =?utf-8?B?aE1CV0Mxa3lHRjhhejdHZjJaRFl3WkVZbHpYZzJrKzNXUUpRWGtMYXpyclN6?=
 =?utf-8?B?ZUR3MUkwcHh5OUN6VDR3czQvSmVpYVFtcHBBMkY4VTZ6YldyY0NTczkvVktu?=
 =?utf-8?B?elpsMWNKNzZGSWZ3WWozUjNIc2RnNDEvek9PdjVuN0luQnFxQUp6dGVhaWQ3?=
 =?utf-8?B?WENuczcrd1FudHhBZEtlTE11UzFLNXZIajd1NGdUSDNDdmNRY2NBT0RPb1Iv?=
 =?utf-8?B?MEk0VWF3cW1GWTNoZGVVcURNaTNOR0dxNVNNdWZ5WjhucGZuUjhRMUU3Tk5J?=
 =?utf-8?B?SmxUVmI2RmVwNEp5cng2MWlRNFEzcWlMODZpQ2w4dy8wS2grdmp1SDdGRHJ5?=
 =?utf-8?Q?fRuEY2G2G9Mh8d0paXNLCpuWaRJV4Z+uNcDiX6IjgDvD?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BF4AABDBD28DED4F837A23AB7A14B2F9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4896.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 57c56371-cc33-4e74-1f48-08d9a5873619
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2021 02:50:39.5981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 APgv2ag5wO1pSy73tNzvbGSXP1u8Ik9M9F+eSJOuJkceVfSe3tCXRjoQQX1g3nxxUjy4c7r9wSpZSs/L3Ilqqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4387
X-OriginatorOrg: intel.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 12 Nov 2021 02:50:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13028

T24gVGh1LCAyMDIxLTExLTExIGF0IDExOjE2ICswMDAwLCBSaWNoYXJkIFB1cmRpZSB3cm90ZToK
PiBPbiBUdWUsIDIwMjEtMTEtMDkgYXQgMjI6NTAgKzA4MDAsIEFudWogTWl0dGFsIHdyb3RlOgo+
ID4gRnJvbTogUmljaGFyZCBQdXJkaWUgPHJpY2hhcmQucHVyZGllQGxpbnV4Zm91bmRhdGlvbi5v
cmc+Cj4gPiAKPiA+IElmIG9uZSBvZiB0aGUgcGFyc2UgdGhyZWFkcyBkaXNhcHBlYXJzIGR1cmlu
ZyBwYXJzaW5nIGZvciBzb21lCj4gPiByZWFzb24sIGJpdGJha2UKPiA+IGN1cnJlbnRseSBoYW5n
cy4gQXZvaWQgdGhpcyAoYW5kIHpvbWJpZSB0aHJlYWRzIGhhbmdpbmcgYXJvdW5kKSBieQo+ID4g
am9pbmluZygpCj4gPiB0aHJlYWRzIHdoaWNoIGhhdmUgZXhpdGVkLgo+ID4gCj4gPiBTaWduZWQt
b2ZmLWJ5OiBSaWNoYXJkIFB1cmRpZSA8cmljaGFyZC5wdXJkaWVAbGludXhmb3VuZGF0aW9uLm9y
Zz4KPiA+IChjaGVycnkgcGlja2VkIGZyb20gY29tbWl0Cj4gPiBkYzg2YTUzM2Q5NTFkMTM2NDNj
ZTQ0NjUzMzM3MGRhODA0NzgyYWZjKQo+ID4gU2lnbmVkLW9mZi1ieTogQW51aiBNaXR0YWwgPGFu
dWoubWl0dGFsQGludGVsLmNvbT4KPiA+IC0tLQo+ID4gwqBsaWIvYmIvY29va2VyLnB5IHwgMTEg
KysrKysrKysrKy0KPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkKPiA+IAo+ID4gZGlmZiAtLWdpdCBhL2xpYi9iYi9jb29rZXIucHkgYi9saWIvYmIv
Y29va2VyLnB5Cj4gPiBpbmRleCAwNmI0MGMxMzguLjhhZThlNGVjYyAxMDA2NDQKPiA+IC0tLSBh
L2xpYi9iYi9jb29rZXIucHkKPiA+ICsrKyBiL2xpYi9iYi9jb29rZXIucHkKPiA+IEBAIC0yMDQw
LDYgKzIwNDAsNyBAQCBjbGFzcyBQYXJzZXIobXVsdGlwcm9jZXNzaW5nLlByb2Nlc3MpOgo+ID4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmVzdWx0ID0gcGVuZGluZy5wb3AoKQo+
ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVsc2U6Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB0cnk6Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgdGltZS5zbGVlcCgwLjI1KQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBqb2IgPSBzZWxmLmpvYnMucG9wKCkKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGV4Y2VwdCBJbmRleEVycm9yOgo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBzZWxmLnJlc3VsdHMuY2xvc2UoKQo+ID4gQEAgLTIyMTgsNyAr
MjIxOSw3IEBAIGNsYXNzIENvb2tlclBhcnNlcihvYmplY3QpOgo+ID4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHlpZWxkIG5vdCBjYWNoZWQsIG1jLCBpbmZvcwo+ID4gwqAKPiA+IMKgwqDCoMKg
IGRlZiBwYXJzZV9nZW5lcmF0b3Ioc2VsZik6Cj4gPiAtwqDCoMKgwqDCoMKgwqAgd2hpbGUgVHJ1
ZToKPiA+ICvCoMKgwqDCoMKgwqDCoCB3aGlsZSBzZWxmLnByb2Nlc3NlczoKPiA+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBpZiBzZWxmLnBhcnNlZCA+PSBzZWxmLnRvcGFyc2U6Cj4gPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhawo+ID4gwqAKPiA+IEBAIC0yMjMyLDYg
KzIyMzMsMTQgQEAgY2xhc3MgQ29va2VyUGFyc2VyKG9iamVjdCk6Cj4gPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJhaXNlIHZhbHVlCj4gPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBlbHNlOgo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB5aWVsZCByZXN1bHQKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZv
ciBwcm9jZXNzIGluIHNlbGYucHJvY2Vzc2VzLmNvcHkoKToKPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgaWYgbm90IHByb2Nlc3MuaXNfYWxpdmUoKToKPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwcm9jZXNzLmpvaW4oKQo+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNlbGYucHJvY2Vzc2VzLnJlbW92ZShwcm9j
ZXNzKQo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgIGlmIG5vdCAoc2VsZi5wYXJzZWQgPj0gc2Vs
Zi50b3BhcnNlKToKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJhaXNlIGJiLnBhcnNlLlBh
cnNlRXJyb3IoIk5vdCBhbGwgcmVjaXBlcyBwYXJzZWQsCj4gPiBwYXJzZXIgdGhyZWFkIGtpbGxl
ZC9kaWVkPyBFeGl0aW5nLiIsIE5vbmUpCj4gPiArCj4gPiDCoAo+ID4gwqDCoMKgwqAgZGVmIHBh
cnNlX25leHQoc2VsZik6Cj4gPiDCoMKgwqDCoMKgwqDCoMKgIHJlc3VsdCA9IFtdCj4gCj4gVGhp
cyBwYXRjaCBjaGFuZ2VkIGEgYml0IGluIG1hc3RlciBkdWUgdG8gaXNzdWVzIGJlaW5nIGZvdW5k
IHNvIHdlJ2xsCj4gc2VlIHRvCj4gaW5jbHVkZSB0aG9zZSBjaGFuZ2VzIGluIHRoZSBiYWNrcG9y
dC4KPiAKCkkgaGF2ZSBkcm9wcGVkIHRoaXMgcGF0Y2ggZnJvbSBteSBicmFuY2ggZm9yIG5vdyBh
bmQgd2lsbCBpbmNsdWRlIGJvdGgKdGhpcyBhbmQgc3Vic2VxdWVudCBmaXggbGF0ZXIuCgpUaGFu
a3MsCgpBbnVqCgo=

