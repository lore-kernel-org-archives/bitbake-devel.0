Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8BB4C433F5
	for <webhook@archiver.kernel.org>; Fri, 12 Nov 2021 06:19:59 +0000 (UTC)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by mx.groups.io with SMTP id smtpd.web08.12020.1636697998907778971
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 11 Nov 2021 22:19:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@intel.onmicrosoft.com
 header.s=selector2-intel-onmicrosoft-com header.b=DDgJDOwq;
 spf=pass (domain: intel.com, ip: 192.55.52.120,
 mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10165"; a="231807296"
X-IronPort-AV: E=Sophos;i="5.87,228,1631602800";
   d="scan'208";a="231807296"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2021 22:19:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,228,1631602800";
   d="scan'208";a="453037965"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga006.jf.intel.com with ESMTP; 11 Nov 2021 22:19:57 -0800
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 11 Nov 2021 22:19:56 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Thu, 11 Nov 2021 22:19:56 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Thu, 11 Nov 2021 22:19:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mRZEUcOmI033f1g1m3lISwa7qR/RpAQNIk/BqSoUy39K60FZeEOGzXxFc8zYzbYuZKzRoyki0vTRiPslcjTCDhJIwuMuoHqMBcekUN2El8PUz57/9GGkiAi9HDTx3imK/lPFZ0bolPWLBhZgRkaiMcpaPWQl+PoceMYecT/hiO0gdP1cFhV868xsKEI+P74TaR6vxuQYsGajoH9hlda3Mj1DDO8L6DcEw3Y5RWfQu3VMCbfKlcU/jdGfFW7QGWmqsprrMupDC5ikqmWOzjSUSnh6MvDaRsGoCSkpiHH4rUIIRACdria7eagI0jwwLFUTMQLDNTsHpn5wX8G929aHCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/dWYS4QQSfft6qXW9Gr+ckEXISvyGZ+jSGC818TRdKc=;
 b=mFIM4l5LnuxD6XGjJEi2XcklUyAMkGPXP2RcFwGknYvcWlJDB6Kx91WPaotimqs1q8LU0jWAbL4kl65+NGtzTvw8jGSOo12ee1bsiZHPpAUxXMA5/wB/z0X45HPIRNAEc6nG2SAst/WUoVAhWUwChpjyvT+wI4u9lKth4VOxNBZ46XyM/IKByP86LyCARHyTFmK7+SDJTinfizzGt/4MsJMxUF5jtbNkIUGIkKhCS+DQgR0sg1fY2WerpScs3zmjLGekQRAlfTR9gTjzQ6k17ngErtKqlCtZU5FdyyjlHNlQGkTDbbxUgr5FbP0o5+OZpGB1+qpDcK+blcKAtG1LHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/dWYS4QQSfft6qXW9Gr+ckEXISvyGZ+jSGC818TRdKc=;
 b=DDgJDOwq2OSePBcXfq1sF9/fIDmOh1dIEfBZTpWklr2oe9sgOJsr+Ae/1ozO4yrHjQKOtG8Iky1m4QhOi64XoXLVKbAW6HH0yTb6Yz8LtgkcfZL/Ih8M7uY+MvHEsrHC4AkqXrvgTzW7ijoRVwVA8/yKax6FPtGiAh5hIs2JaRE=
Received: from SJ0PR11MB4896.namprd11.prod.outlook.com (2603:10b6:a03:2dd::20)
 by BYAPR11MB3110.namprd11.prod.outlook.com (2603:10b6:a03:8a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Fri, 12 Nov
 2021 06:19:55 +0000
Received: from SJ0PR11MB4896.namprd11.prod.outlook.com
 ([fe80::2c3d:dccb:aa85:53c5]) by SJ0PR11MB4896.namprd11.prod.outlook.com
 ([fe80::2c3d:dccb:aa85:53c5%2]) with mapi id 15.20.4690.016; Fri, 12 Nov 2021
 06:19:55 +0000
From: "Mittal, Anuj" <anuj.mittal@intel.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [1.52][PATCH 0/6] Pull request
Thread-Topic: [bitbake-devel] [1.52][PATCH 0/6] Pull request
Thread-Index: AQHX14zLQkDGYQmEh0qN8xGNfPNkyKv/a4MA
Date: Fri, 12 Nov 2021 06:19:55 +0000
Message-ID: <bffc2ff318784c6188d3b89eb0d8c2c03fac444a.camel@intel.com>
References: <16B6B7EFBE2DEB3F.4835@lists.openembedded.org>
In-Reply-To: <16B6B7EFBE2DEB3F.4835@lists.openembedded.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.40.4 (3.40.4-2.fc34) 
authentication-results: lists.openembedded.org; dkim=none (message not signed)
 header.d=none;lists.openembedded.org; dmarc=none action=none
 header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eb6487c3-c9b4-4126-9048-08d9a5a471c3
x-ms-traffictypediagnostic: BYAPR11MB3110:
x-microsoft-antispam-prvs: 
 <BYAPR11MB3110E2AACEB916FEACDE0952F8959@BYAPR11MB3110.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1186;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 oKqcJKqeha3WIEGkC9WbXRBFVnEv9ARPEf3HmvoBEpxhoSrltftY+KSm1f4Vl/IpG8aAFvCbZuUz/GcxOttG6qPdYpKt2nhSxIE3fPNfriBhcQTeg8fygtomf2umTO6rrr2mIaJ4hjpZQmKGmdIJ3vpcTDMnh32OxQxA9XyaDyWM42m6wCFxmDPuBWHa1L+0zkwUiSO1VouqTL2E6/POlAxRid4CYrboBqPKoA5EhSNeElhw6SznuZZ1A7bGYAhmHR7i0HDjIRJ1QkoRCz7G3hbXQ0qHViNgXytSr+N/PfqoYpx8DeHBz1H5idi5p92lfvtsZGZfwWg0sxXSF9xwi/c1kKhw015vfZlaxfqula95poAYF/hCVepjfTx2y2DNH/jSFr0dMHIxjszf4ksjapUiJY57zoKzMM3oQAVLxuUFD4KLwCHz0SWb10LFfs520ZlgXaIjRbAbZOgOJdYDDQrcW0YxJEqa5VJcr9+kJUpKnCH4RzOpIhNu/gPtNf8K+E4ZbiS3eWyuI7hf2b2OayNDS1nwj9fJMJrrvbVHJYrV+4WzpPaedWzSZCDOvoloiOH7YqzvHb947CkHwHkzMaQTp7x3T7SLqNXPWPSr29PtKMjr47c69AomhLRK6la3dqURQO4vm9+7HEUtDPEHLZOMZQGRajFPmg8MioIW0/xuoVee+VaXKbiD6JlL7fYZRLHjyVoWRsFqEi/069TsiaVuer6qu8XKySXep7ux0nbRndBbj4ZR+mMhR32ktrp9HQV1TTF9CWz7WhDS40nkxMXoCia46lWfQ1lBvuUnvhBKgfkGo2/oEYSTsvKaic+owrU2Uw3Ot5E+JJyOZmWX6A==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4896.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(508600001)(83380400001)(2616005)(6512007)(966005)(91956017)(66476007)(5660300002)(86362001)(186003)(82960400001)(6486002)(4001150100001)(64756008)(8936002)(38070700005)(316002)(6506007)(76116006)(71200400001)(122000001)(38100700002)(8676002)(66946007)(36756003)(66556008)(6916009)(26005)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ZERZSEhNYlB3RVhBTjJGNllZSTFwb1MrOTljWkk4SVhEUTd5VEJPQ0svN0xQ?=
 =?utf-8?B?RlFQNWJjRnpqU3E5ZnpGeW40K0I3ZXVYNjh0Zis3aDNQc2J5bmJNRFo4aWgr?=
 =?utf-8?B?OHA0SFd2RGJLZlhXRkdPR3RFNGF0Y0l6UlhDWFZHWXFqRXhaTjBIWGlDVlNG?=
 =?utf-8?B?MTI2TmdPMUlBajRUcEJ4S2xZaWVZaC92Zzk0dVRBdmY1YS92d1J4TkdHbmpH?=
 =?utf-8?B?ckRzYUVScGdQc2VMMTh3MS9lcXk5bTNFUCtMRCszUWYvVkxNY0tNUXhIeGNE?=
 =?utf-8?B?YnAxS3JBeWlxR0RqRmpKRnZnZTJlMUc0QmlZdXFTT2hLRjJXSEhBN3EzN3p5?=
 =?utf-8?B?d3U3UFBkMTlVN3hwdkVUdWFZZC9IWU5NM3FzMXRiSUw0dWJyZXUzQjlhZi91?=
 =?utf-8?B?R1REZzkxOXBvNGVMSnNXdkdYZjloM242Rk0xTlM0UUJuY3A1SXZPaVAwUzlS?=
 =?utf-8?B?aUd4UXloM0FtcUp4TWZ2bTVpYXR6VmdhS2wrTk9lbUJ4L3VwVlc5d29yZzlV?=
 =?utf-8?B?clo0V2JlS0tSQkdiejZ3VXE4QmxiWjFoVmVHUnBnTmRCdWZQTUhDaTl1MDVE?=
 =?utf-8?B?RmlLa2dZN2thUFhSVWNoQytXNStlcitSQ0VlanZEelhQcVRMMURuenVJMGRk?=
 =?utf-8?B?RWtES2F6Z0tEdzhEVEFpYjMvQURjS2xmWGY4bG1hYU9Lc0o3MlhOTk9OcFgv?=
 =?utf-8?B?RjkrcTF0Mk1QVEVpaEYvcjBMenNTak85NERPVG9vRzZSMWFsM1VFZzVsd01X?=
 =?utf-8?B?V0d1Vzd0eWxYQ2lQZW9kWGd4MjBSMTFGdVk0YXlnaXA5NTREcndTOFlmbVhN?=
 =?utf-8?B?VVZXekpCNGExR1hJTnNkSk9ReXdqODZVUEN4V2tXRjNtWEZBT1VSRGJPeTlJ?=
 =?utf-8?B?WGljOVNXT3pmLzAzLzFmVTh3Y3ZHV1lnQVZCRDZ3Tnk1eXJ5Wmd2RVJqbkhV?=
 =?utf-8?B?Tkw5RmxxdU5xTWxsV3U3cFFsaFhIaGF2T1lLM25sUE9TWHVMOVkvYjBvcnpp?=
 =?utf-8?B?dCtEVi9rZG96RzY0QXU3bnFUMXkzQlFPK1FWOGpRWXIwTUNsRVZJd240Mmp5?=
 =?utf-8?B?K0o2WEpVNDRjUG5mQ3dEN1pPd0xUTGhkOG5GZVRGMEYweU01WW1vRDN5K0NE?=
 =?utf-8?B?eVUyUmpkZWFjNC9yY0J1SmRGTUtUQ0JZRlRUSThQT3dwbkFRWGpRVll0TXBk?=
 =?utf-8?B?RS90YmRWUXhSRnFINm9jWVBOTEptdTE4bVY1RWRRUXQ3OFdmZVovRERubElL?=
 =?utf-8?B?R3BKenZ5b01JeHliUGNQUDJXNTByYk5sdzhHc1UvL2ZpSVVRV214aHpFUzVL?=
 =?utf-8?B?eTIva2xIcGg3Mm1pMmVGdkJQMU5Gc1JRbnd6UkFVbE1ldjY1eEZLcnY1MDlt?=
 =?utf-8?B?b3d5WGtRbkM5bi9pQ2hsZDdWM2NkVldyWDlENXRSOGo5VitOL0w1K3BNQVpY?=
 =?utf-8?B?NUFIbTJNem02WG03bkIrVlNSdm5CYVZIRXF6SVMvbkRFeFhxcTEzenlzTUlH?=
 =?utf-8?B?YkNDNFJYaDhNSkN3K3BCRG0xYlIxSzlvaHlNREhHVnY2L2NmTjJrNDFicTIv?=
 =?utf-8?B?NTJMNmF5TnVsdWxqRW9vT0dFR3FMUmJJcUQwYmZ3ZEF3Vjg4ekhCQ3Q1SDU1?=
 =?utf-8?B?VlRaV0Y4dG9Nd3hVc0MrRFZRRGkvNUlOZjNwSzE3TzAyY2w1aUJyR3BIaGZ2?=
 =?utf-8?B?WnpKT0ZrOXhsUUMyMzVjaGZrcHNxTC9CSG1ETG1Ub2VtNlh0a1lSVmROUFIy?=
 =?utf-8?B?UlFsTEJYYWpnSEZ5UzJhcXRsbndTZ1k1NmIreXpjNlRlTTZ1WWFlbDZIeU9m?=
 =?utf-8?B?REhwK0Y3MmNQTnA2L1AwZzFUTTlSRU1maHFqeFkxOUpmcFo1djIrWTRiTzcv?=
 =?utf-8?B?WnpybUlRVzFjWjZPalpnMzZDcURGaFJHQjI2cjMxMmRxNWtjbG1TZGJTc1Vn?=
 =?utf-8?B?KzFMQUpscEFjUzUrRVR3SnBQVUdJR2NFVkFGNHk3dzUrT0ZBUzJBdllKU0sx?=
 =?utf-8?B?TEVGeDROZ29PYlBHZ0k2a3ZuazlxUzEwZ1AvMHc1eUNGTDJ6VlBtSE9CMEF6?=
 =?utf-8?B?R0x3dEtSN3ZFNEpVVTUvdnp5eUZXRW1LSi9NNHNNdk5VTXpjbzluRDdhQjZ2?=
 =?utf-8?B?Q1N6eWtCbzd1bHQvUXU0MStQbTNkQ1UyVklaYzQ2RWVlWjhpaEY4T29SYytY?=
 =?utf-8?Q?IeqgY0jewd8QYnnGXP+XuU/PupgdErOB92J/a5zv+nCL?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <686A0919AE222546A563AF3C26EF0701@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4896.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 eb6487c3-c9b4-4126-9048-08d9a5a471c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2021 06:19:55.0710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 WcHU9KWfLOjCJNEnRZfiRylR0vFkR179ISwFTTMMm295PvqPdQn4aKCCt8tua7txpX+oS/Ncqo/dLzh9pLT/3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3110
X-OriginatorOrg: intel.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 12 Nov 2021 06:19:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13030

T24gRnJpLCAyMDIxLTExLTEyIGF0IDE0OjE1ICswODAwLCBBbnVqIE1pdHRhbCB3cm90ZToNCj4g
UGxlYXNlIG1lcmdlIHRoZXNlIGNoYW5nZXMuDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBBbnVqDQo+
IA0KPiBUaGUgZm9sbG93aW5nIGNoYW5nZXMgc2luY2UgY29tbWl0DQo+IDFhYzczNjM4YzE1MDRj
ZjJhYTdmMTMyNTczOTZhYWQ2MTdmMjVlOGY6DQo+IA0KPiDCoCBSZXZlcnQgInBhcnNlL2FzdDog
U2hvdyBlcnJvcnMgZm9yIGFwcGVuZC9wcmVwZW5kL3JlbW92ZSBvcGVyYXRvcnMNCj4gY29tYmlu
ZWQgd2l0aCArPS8uPSIgKDIwMjEtMTEtMDUgMDk6MTY6NDEgKzAwMDApDQoNCkkganVzdCByZWFs
aXplZCB0aGF0IHRoZXJlIHdhcyBhbm90aGVyIGNoYW5nZSBtZXJnZWQgYWZ0ZXIgdGhpcyBvbmUu
DQoNClNvIEkganVzdCByZWJhc2VkIG15IGJyYW5jaC4NCg0KVGhhbmtzLA0KDQpBbnVqDQoNCj4g
DQo+IGFyZSBhdmFpbGFibGUgaW4gdGhlIEdpdCByZXBvc2l0b3J5IGF0Og0KPiANCj4gwqAgZ2l0
Oi8vcHVzaC5vcGVuZW1iZWRkZWQub3JnL2JpdGJha2UtY29udHJpYiBzdGFibGUvMS41Mi1uZXh0
DQo+IA0KPiBKb3NlIFF1YXJlc21hICgxKToNCj4gwqAgY29va2VyOiBjaGVjayBpZiB1cHN0cmVh
bSBoYXNoIGVxdWl2YWxlbmNlIHNlcnZlciBpcyBhdmFpbGFibGUNCj4gDQo+IFJpY2hhcmQgUHVy
ZGllICg1KToNCj4gwqAgdGVzdHMvZmV0Y2g6IFVwZGF0ZSBnaXRodWIgdXJscw0KPiDCoCBmZXRj
aDogSGFuZGxlIG1pcnJvciB1c2VyL3Bhc3N3b3JkIHJlcGxhY2VtZW50cyBjb3JyZWN0bHkNCj4g
wqAgdGVzdHMvZmV0Y2g6IFVwZGF0ZSBwY3JlLm9yZyBhZGRyZXNzIGFmdGVyIGdpdGh1YiBjaGFu
Z2VzDQo+IMKgIHJ1bnF1ZXVlOiBGaXggcnVuYWxsIG9wdGlvbiB0YXNrIGRlbGV0aW9uIG9yZGVy
aW5nIGlzc3VlDQo+IMKgIHJ1bnF1ZXVlOiBGaXggcnVuYWxsIG9wdGlvbiBoYW5kbGluZw0KPiAN
Cj4gwqBsaWIvYmIvY29va2VyLnB5wqDCoMKgwqDCoMKgwqDCoMKgIHwgMTIgKysrKysrKysrKyst
DQo+IMKgbGliL2JiL2ZldGNoMi9fX2luaXRfXy5weSB8wqAgNCArKysrDQo+IMKgbGliL2JiL3J1
bnF1ZXVlLnB5wqDCoMKgwqDCoMKgwqAgfCAzNCArKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0t
LS0tLS0tDQo+IMKgbGliL2JiL3Rlc3RzL2ZldGNoLnB5wqDCoMKgwqAgfCAzMiArKysrKysrKysr
KysrKysrKystLS0tLS0tLS0tLS0tLQ0KPiDCoDQgZmlsZXMgY2hhbmdlZCwgNDkgaW5zZXJ0aW9u
cygrKSwgMzMgZGVsZXRpb25zKC0pDQo+IA0KPiANCj4gLT0tPS09LT0tPS09LT0tPS09LT0tPS0N
Cj4gTGlua3M6IFlvdSByZWNlaXZlIGFsbCBtZXNzYWdlcyBzZW50IHRvIHRoaXMgZ3JvdXAuDQo+
IFZpZXcvUmVwbHkgT25saW5lICgjMTMwMjkpOg0KPiBodHRwczovL2xpc3RzLm9wZW5lbWJlZGRl
ZC5vcmcvZy9iaXRiYWtlLWRldmVsL21lc3NhZ2UvMTMwMjkNCj4gTXV0ZSBUaGlzIFRvcGljOiBo
dHRwczovL2xpc3RzLm9wZW5lbWJlZGRlZC5vcmcvbXQvODcwMDA5NjAvMzYxNjcwMg0KPiBHcm91
cCBPd25lcjogYml0YmFrZS1kZXZlbCtvd25lckBsaXN0cy5vcGVuZW1iZWRkZWQub3JnDQo+IFVu
c3Vic2NyaWJlOg0KPiBodHRwczovL2xpc3RzLm9wZW5lbWJlZGRlZC5vcmcvZy9iaXRiYWtlLWRl
dmVsL3Vuc3ViwqBbYW51ai5taXR0YWxAaW50ZWwuY29tDQo+IF0NCj4gLT0tPS09LT0tPS09LT0t
PS09LT0tPS0NCj4gDQoNCg==

