Received: from NAM10-MW2-obe.outbound.protection.outlook.com (NAM10-MW2-obe.outbound.protection.outlook.com [40.107.94.64])
 by mx.groups.io with SMTP id smtpd.web09.28930.1620634774523403449
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 10 May 2021 01:19:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriversystems.onmicrosoft.com header.s=selector2-windriversystems-onmicrosoft-com header.b=H/Mqw6x0;
 spf=pass (domain: windriver.com, ip: 40.107.94.64, mailfrom: qiang.zhang@windriver.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MZdQZ3VPUwLS1h5YaxUzc0LeINzfn2BAifXojF31BuSdYRnNPQ+9EyNuj5+bv4KMgTSaSfsuGtrI5rBAvpKe8SLrOUjcfsbUUy4Sbp1XgvedKFlTJ0D34LY/uT2ffGejNOMkWNRuKUyqy6baclosmEagsH9Wlf+ybE6eIC2o3bYlBsbGtNW7uZaCA9/8nXLjCI2ifEdz8L3Or3j3BbWkrYFsuYyS1Bz8WcuvxieGtKdHScLtf9lLC/167L2JFCql0upqBjuoJ2uRWT5UUqrZiQMGqaiKCSbLw29GTDFrTRYXUqfB//vVDfc1qaeLJ9x1Yp0uBcweagOBuHxl7395ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wpgit73CosPk4lIJ8re6Hi2NRROeNa0lic4enKJW9Xg=;
 b=LtYTj4lJGHqCSAwxJzy35SMvYjvCvvJGnMgG9V/tDxpK6pulwBn3uHHh9y7Q+5UA/OMHcS/xJ21hPorJqYAQWYCMola8AZGH53SswKBbSqAvTSSk8XdU3iqXwLwQQKWx+CwgUozzGD9ob/nE1Qev6283Qn6r2F7AU5Rg4Yby6b+U+5J3jQtKnxSLEfyTbjY56suwDwORnbscfgq50dc1MXUJSEsH9Rh5M7jKcHsNj7uAfL0hmwpXT7Sz4CpQC61HqGrPdQsjZBKbIAC8kuutdPlihr8R+O2re0isj7+SlsrcUGEtpSQdjgsvPsHpbqsIn74RDbenmIjO8gYtkUTFcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wpgit73CosPk4lIJ8re6Hi2NRROeNa0lic4enKJW9Xg=;
 b=H/Mqw6x0PlBouXbWmNHQq+NMi7DJSNsWj1xkH9QG0t3VPHuTMe15oSpTIejOWXOyKeCPd1n0k9+6E7KqI0rzd87J0Ijt+W9JXCbsSvb29RKDJnqaqZ0nTAYmLLlopcjJeu+9/lUJ2ZnpYqjnVhBrJZ+bVWKYDWometHIX/kohBY=
Received: from DM6PR11MB4202.namprd11.prod.outlook.com (2603:10b6:5:1df::16)
 by DM5PR11MB1244.namprd11.prod.outlook.com (2603:10b6:3:13::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.27; Mon, 10 May 2021 08:19:32 +0000
Received: from DM6PR11MB4202.namprd11.prod.outlook.com
 ([fe80::60c5:cd78:8edd:d274]) by DM6PR11MB4202.namprd11.prod.outlook.com
 ([fe80::60c5:cd78:8edd:d274%5]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 08:19:32 +0000
From: "Zhang, Qiang" <qiang.zhang@windriver.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: =?UTF-8?B?5Zue5aSNOiBIZWxwIG9uIEhhbmRsZSBCQVNIX0ZVTkMgc2hlbGxzaG9jayBpbXBsaWNhdGlvbg==?=
Thread-Topic: Help on  Handle BASH_FUNC shellshock implication
Thread-Index: AQHXRWcGL94lvWbeakaKdeob07d486rcVi8AgAAIDcI=
Date: Mon, 10 May 2021 08:19:32 +0000
Message-ID: 
 <DM6PR11MB4202CBE82602C7AAD457F3BEFF549@DM6PR11MB4202.namprd11.prod.outlook.com>
References: 
 <DM6PR11MB42025DE7A846AF975F14E0DEFF549@DM6PR11MB4202.namprd11.prod.outlook.com>,<af9bfa8a948cf4be116cd031a3f20f0c4998bb09.camel@linuxfoundation.org>
In-Reply-To: 
 <af9bfa8a948cf4be116cd031a3f20f0c4998bb09.camel@linuxfoundation.org>
Accept-Language: zh-CN, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=windriver.com;
x-originating-ip: [60.247.85.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c3905889-71c6-47bc-4fb5-08d9138c570b
x-ms-traffictypediagnostic: DM5PR11MB1244:
x-microsoft-antispam-prvs: 
 <DM5PR11MB12444FE5D7D99C073AD50E06FF549@DM5PR11MB1244.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1284;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 6AyGRLBNu3UTTCKYIOSfcXhSJA4VIRWp7TJ+w1FZDMUHoJACpOS5YH7s3tq779dstO12zkVvsauvkpNG/KSKGW0rU2zj6PaUMMP1gwjuSGV1ROb/MN+dJrOyNqAPBYZxThcFjbIZkIUmgZTUcwIQl49LTrZ6+T2F3v31lrG9xKWQ337tQlfVKFmepyOH5BY1/bFYo1bUYmjeWuImkDJ5vIXPZGIi749HaE//xbnClZF03i6rG1y8WUg48XzYZFnvG2GL1kvAJVbpfsUAT6n7c4hWninj9rI5Xy1x4NzZ+Z9emt7EVJQ0Jkh2PdlRNeuH6FbZlkno1/w5epLW3JbCs019HBbRYlbQ3IsRXb5lY0Xs8XiJzdelYWZ4oNS17rYLa9z2j7c6V9v3mux28GRNfwT09BYGFyMYN7t0/MNhZlYb6zyrZNH9PgA/U/qLYrYBj9ChsJS5ZYWqRv9ccIwvjfxAJfPiZkYDAEUp4HDPgYKbyRHB/NhPKv1D+aGyu2HoptNV6voX4PWTFfgvxct9GrIz2VxrbTtxiKFMIs7SsMTCGS183pdCG2X8gkQlG+Rcbo1hdNRk1zVSxgpQRs2MMRmy/sjOFCWp1IXGgIW9UgUary1c3uYXjnbPnIAfZb+rgVcBtB0ZwUUP2DENiRTxq+d3enleb2S5oQyFJVSUpmc=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4202.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(346002)(366004)(39840400004)(66446008)(66556008)(6506007)(64756008)(6916009)(71200400001)(33656002)(66946007)(8936002)(7696005)(91956017)(76116006)(55016002)(66476007)(316002)(966005)(38100700002)(224303003)(5660300002)(4326008)(186003)(2906002)(86362001)(52536014)(122000001)(26005)(478600001)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 =?gb2312?B?RExhTW1Xa1JkVzByMFV5cWlqK2VsOWFsdDQ2SGZUeDhrbjM5K0g5TDVSYXRY?=
 =?gb2312?B?OXBmZUtTUnZZNEZROE8zSnlyWWU2N1RORlNUbWN2dHpyZk1NYXBIVWhrWE5Y?=
 =?gb2312?B?VTdlYnVJa2g0dkpaU2gxbEtQOEcxYnJRREJJYUZiNlBzQ0ZLNDhGSTlwaTdp?=
 =?gb2312?B?d2YxeTZXaExrNEV2VHM4Zm1ldDljUFdUNlhscllsdjZ0cmwzNDZ2YXpqUVVX?=
 =?gb2312?B?eVA3RzdYUEo1VVo4THdnVzlFdmFabUNVMWdpd2VsejRpZWVzSjM4TFd5SXE5?=
 =?gb2312?B?NWtrRFRLNldnaGdlMGdaVWdyTE1mcVNSa2g1NC9Kb0pMa2JTajN5UVJadnpt?=
 =?gb2312?B?dkxGUGpqTUJFNnpFRi9uT0h4MlpSNldYY3RId2hNZ1pIYitrTkhTWStaT2lJ?=
 =?gb2312?B?bDZwN0NkSlF1TjlTNW5ySTFGQ0tMaURqbUtkRWU3SktXcWZpTjg1NVJ1YU1S?=
 =?gb2312?B?eUt4VHBaL3ovQmYzUVVWUG82T1U2bVpsa1E5eFlkUi9WeThEUkt3NWgyTk9E?=
 =?gb2312?B?M29yTzZiMFNhbEVGUU9uK3FqNkRBUFFVL0JJbU4zOXRtaWF0KzFoT3dmTWc3?=
 =?gb2312?B?WXlqS1kvekQrakFKL21IblgyR1VkeGdWSHFSUmwxUXUxZTZnQnA3ZWUybDNz?=
 =?gb2312?B?ako0aFpGRGZkTG0ybjc2VGpPbjh6TGhES3NpL0dVeEgzekpCZCtVU091SE5l?=
 =?gb2312?B?Z2E2bUhsTUdja29HWnEyRmg4L0xvK2dFZU1LVWg1UXB2UzNROW5IRHdEOVVM?=
 =?gb2312?B?d3A1ZFNUTSthOW1JYVB1RzNWNHB2OEV6alpYTW1KVFhrUGQ4UGdraHJPdjZD?=
 =?gb2312?B?RUxuTDhNSmE5SXhSbzZRdUpBTzJZY1hKRG9UQlIxK3A2U0lyREFhRmIzZzJh?=
 =?gb2312?B?S0I0Tmh1NmVvYzZLUXRRWm1XSVRkUjN3RXpJdkZVNHBGdjJMV1J4UUtrcTFY?=
 =?gb2312?B?REhTaWlNRWRKc1B2UUJRelhtQjNMVGtBbS9aNk1hRjJNQVliK2RLNjd3Zmxu?=
 =?gb2312?B?TnFGUDFqajdQV0FhVHprTVJEb21qSEluR3NVV3ltU1RjWGxUN3hNZ3ROVnFl?=
 =?gb2312?B?MTNEMzhIMmNYeVhKVm00K01INS9jVHEyaWMxeEZqYVNFeklsYVBIWHNYV3Rk?=
 =?gb2312?B?ZmtIYmhublkvdkNqNmV2Q1g0U2JBOENHTjAwQzlZbE11M1ZVVEI1VDlEb3gy?=
 =?gb2312?B?Q1BrNXlsejNiSnUyTTZMQlFEMmo1NWxEY3F4NjVRZDVoVUt5WVFTNzAraEFR?=
 =?gb2312?B?R1VENFNXVnlmc25iYThSTlBvT1Baa0ljSHFaMC8xL3JmVlRhT3c2bGpTV0lu?=
 =?gb2312?B?cmUzc3pFVWRTSVlXbjNJUzk1WkJBMFdQRGxGQis2NWUxWFp3L1B5UHFha1VP?=
 =?gb2312?B?MzJoZlNJQzNrTXdrcW5OdXVJNHdXdUR6WDZUcENaVnBKSUZHWmZhUTNkVThY?=
 =?gb2312?B?Z1ZjbXhRQTNCdkxjc0pVWUJpTVZQTTFrdGVBTUZKWFF2Q3hyK3JsUWRDRTJP?=
 =?gb2312?B?QjFqeE5GaU56UG5KdlRMVVkvWXZTT0s4RWRiQjhVWFI0Y2hnM3phVGxSdkYv?=
 =?gb2312?B?V0lXaXJPMVVJbk52bWlGRm9ONm95TWFuNU5yM3ZOYnl6R0F1T2l6VEJKQ1Zr?=
 =?gb2312?B?b0wybXZzaVVKYVhzQkkwTGJKanhnVGRBaHNiZFFlSHdyR3VOdWU4WDVXK2Vh?=
 =?gb2312?B?Y3RBdTM5UGUyT3V5TkFSN2hSZTdkelFhekFHaldqK0dmeGZDMFRJNFJiR0hO?=
 =?gb2312?Q?2IqJWUmY4cdUE3xYD8=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4202.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3905889-71c6-47bc-4fb5-08d9138c570b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2021 08:19:32.4964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OkXBqFKWRiwzmcZo9aKzx8A6y5KrRMKVfxoItiba95UVDWF+3zLv/RW4arsCZLhIctoEB4Ey9L75EIPlLTDuSGWkurCLYoM1ui4CcaWZ8ko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1244
Content-Language: zh-CN
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCreivP7IyzogUmljaGFy
ZCBQdXJkaWUgPHJpY2hhcmQucHVyZGllQGxpbnV4Zm91bmRhdGlvbi5vcmc+Creiy83KsbzkOiAy
MDIxxOo11MIxMMjVIDE1OjQ1CsrVvP7IyzogWmhhbmcsIFFpYW5nCrOty806IGJpdGJha2UtZGV2
ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9yZwrW98ziOiBSZTogSGVscCBvbiAgSGFuZGxlIEJBU0hf
RlVOQyBzaGVsbHNob2NrIGltcGxpY2F0aW9uCgpbUGxlYXNlIG5vdGU6IFRoaXMgZS1tYWlsIGlz
IGZyb20gYW4gRVhURVJOQUwgZS1tYWlsIGFkZHJlc3NdCgpPbiBNb24sIDIwMjEtMDUtMTAgYXQg
MDY6NDUgKzAwMDAsIFpoYW5nLCBRaWFuZyB3cm90ZToKPiBFeGN1c2UgbWUsIEkgaGF2ZSBzb21l
IHF1ZXN0aW9ucyB0byBhc2sKPiAgSSd2ZSBhZGRlZCB0aGlzIG1vZGlmaWNhdGlvbiA6Cj4gaHR0
cDovL2dpdC55b2N0b3Byb2plY3Qub3JnL2NnaXQuY2dpL3Bva3kvY29tbWl0Lz9pZD1lYjJlYTZm
ZDJkMmRjNjI2ZWFkMTNkZTFlYzMzNGQ0MjIwNjUxNjEyCj4KPiBJbiBVYnVudHUgMTguMDQKPiBi
dXQgICBJIGVudGVyIHRoZSBmb2xsb3dpbmcgY29tbWFuZCAsIGl0IHdpbGwgc3RpbGwgZmFpbDoK
Pgo+IGZvb2JhcigpIHsgZWNobyAiZm9vYmFyIjsgfQo+Cj4gZXhwb3J0IC1mIGZvb2Jhcgo+Cj4g
Yml0YmFrZSAtYyBtZW51Y29uZmlnIGxpbnV4LXlvY3RvCj4KPiB0aGUgZXJyb3Igb2NjdXIsIG5v
dCBsYXVuY2ggbWVudWNvbmZpZwo+Cj4gMDogbGludXgteW9jdG8tNS40LngrZ2l0QVVUT0lOQytk
Njc2YmY1ZmY3XzFiMTA4NTRhMTAtcjAgZG9fbWVudWNvbmZpZyAtIDBzIChwaWQgNjM5OCkKPiBU
cnlpbmcgdG8gcnVuOiB0bXV4IGF0dCAtdCBkZXZzaGVsbC02Mzk4Cj4gY2FuJ3QgZmluZCBzZXNz
aW9uIGRldnNoZWxsLTYzOTgKPiBUcnlpbmcgdG8gcnVuOiB0bXV4IGF0dCAtdCBkZXZzaGVsbC02
Mzk4Cj4gY2FuJ3QgZmluZCBzZXNzaW9uIGRldnNoZWxsLTYzOTgKCj5JJ20gbm90IHNlZWluZyB0
aGUgY29ubmVjdGlvbiBiZXR3ZWVuIHRoZSBleHBvcnQgPmNvbW1hbmQgYW5kIG1lbnVjb25maWcg
bm90Cj5zdGFydGluZy4gQXJlIHlvdSBzYXlpbmcgdGhhdCBiYXNoIGZ1bmN0aW9uIGV4cG9ydHMg
YXJlID5icmVha2luZyBtZW51Y29uZmlnPwoKWWVzLCB0aGUgdGhhdCBiYXNoIGZ1bmN0aW9uIGV4
cG9ydHMgYWZmZWN0IG1lbnVjb25maWcsCgpUaGFua3MKUWlhbmcKPgo+SSdtIG5vdCBzdXJlIHdo
YXQgeW91J3JlIGFza2luZy4uLgo+Cj5DaGVlcnMsCj4KPlJpY2hhcmQKCg==
