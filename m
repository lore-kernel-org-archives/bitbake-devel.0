Received: from NAM04-MW2-obe.outbound.protection.outlook.com (NAM04-MW2-obe.outbound.protection.outlook.com [40.107.101.44])
 by mx.groups.io with SMTP id smtpd.web12.16730.1629905181502550815
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 25 Aug 2021 08:26:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=pEPWaIGN;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.101.44, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MGydD19jJbNxcWSmPXjtkGVpFg4/trS804dhd9OItkY1LC53HK4hnUC40E3w/GWifNmF4qCsrma+USktN6lgVcNdBY3ybxo0bSMop11UOwOZd1RcL6+1WboX8At/Ix7maFOEhaKGgJc6K8CzEsHmT+yQXsUxWT4csgdh+SemYII0Q5lfVEPaDSIYYaZoKbwNc2i+KN5d5H/1LMxbKXXKu/04fpbpEOa3M/ijxSodONTAqiEH/VJH89TPQw3bLzpheKIrdD2rp8ZDiLrdUElHRDprWlS2lHTITVXexLHXnRtZ+isEww7NOsfnyQiGJWu221UEN/t5DOL53QXAGzl3zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ciXM/g9P3xD56hD4EGHH+BYcsDfkx3muhbJMAWoyxCI=;
 b=DMnILkHbENWIzhWtRagRM/Ghi2SAWZo6c2iEoOPp4vz3c5kAGzV4qUllhMg8jq5VX4ivaNuK9NGE1zb2WtahZ+Je+xWgGSzlcif0PPeOlCSoBCksZfRiv/4SD7SrxSwuZ4ztzaX2bHgqdcheJQ2IVdYrSSSLPk+WmJ2hRozxlhc0OgeAhWuk/4eEbJp0mvtGRTmYS4LR2UAmaZQ7ks7GrRQxO05bbtMnNipATtrau/BwIWpIhfdiz0n7V6dMqj0GhpL5bK4HaYrhZ0tOK8BKNy0QZv285EZiH9w3kvn4fPYQpuXSEPsfZdnHN9mVo/dG2DCDZ57+0ZEnjcZ4twpsig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ciXM/g9P3xD56hD4EGHH+BYcsDfkx3muhbJMAWoyxCI=;
 b=pEPWaIGNN/UmerCPWylWbisaQdwsXekwPtjBZGfo3Z8As6gkh3VPNIQk0cIYAq20bMEymEJNZ21unTXmcdJTv+8IwKMuMcTyvAQhJuU8Dx+eelNJmIal/DXh0RN9j83VgE3m7MGiGPNFj28/kaXbHRIvhMUVyRjJf1rXgi9Nydx85W0CjVUcuVNsGn/FtTp6SveWh0xWuVhDqOCxn3ZWWHakBq8Dh4oYHfN8pCa/WXP4EjDEZRRJMtHas5SKgqiuAbtdy7Z+TotXzMVptLoO+xX1a5Dky5HJPnGT4JEU65xwXLtJiS0880LUk+7qDob0dvnVl9j3bv2lQZM5ivDJ/g==
Received: from DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) by
 DM4PR12MB5390.namprd12.prod.outlook.com (2603:10b6:5:39a::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.17; Wed, 25 Aug 2021 15:26:20 +0000
Received: from DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::d02f:e1ca:887e:6000]) by DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::d02f:e1ca:887e:6000%9]) with mapi id 15.20.4436.027; Wed, 25 Aug 2021
 15:26:20 +0000
From: "Chris Laplante" <chris.laplante@agilent.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] Trouble capturing layer revision as variable in recipe
Thread-Topic: [bitbake-devel] Trouble capturing layer revision as variable in
 recipe
Thread-Index: AdeUY4xdzX9x5/pnTMWcL9zDPNkTqwAG7R0AAAi4qMA=
Date: Wed, 25 Aug 2021 15:26:20 +0000
Message-ID: 
 <DM8PR12MB5430AEE26B2BD0933BA452D98BC69@DM8PR12MB5430.namprd12.prod.outlook.com>
References: 
 <DM8PR12MB5430C5689FA1BE41556758938BFF9@DM8PR12MB5430.namprd12.prod.outlook.com>
 <eb65ff99d5863afa3425269ff7e3b0d532c5fa0e.camel@linuxfoundation.org>
In-Reply-To: 
 <eb65ff99d5863afa3425269ff7e3b0d532c5fa0e.camel@linuxfoundation.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=agilent.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a9dc6a3b-d91c-4d6b-cef8-08d967dcb094
x-ms-traffictypediagnostic: DM4PR12MB5390:
x-microsoft-antispam-prvs: 
 <DM4PR12MB53904B0E6837C7BE66905E6E8BC69@DM4PR12MB5390.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 NkoanmZS3/wmMIsFCiqcOSfPjX6MUp5gODlOOFZ3jNndfMFrr4yqCXg2q9e7IbTip9YazmwaqXwGXYGWfDKWoO/TK6K7YbacNo9Na2LXjXh64S35qjwYbIW9MUtxds8Zpej1XVbUx1Hguj8vnKtca1KQRCMOO80td8F+dkJwIme+DouBP1myfCLpIfGlvKUoW9mXVFfc1pgCwftHLCZil/v+Jn9D5XgxEfRlT5HXefF1kO0sRTXMRX+RAyi+Fl4Oj7IKGE0Nim1ag0cBi3R2QV0l+iMmNHtu3WNCtgXNNG7VVcFjtdAQZV4ZUteI/C1r9jhEgRJfExk7FVeoyIaUKei0q63Q9z2rMmgZZTAPC0v8JmeZQbIg3jyZ09bQJZ/MR5iVWUTcQMRb6/HKzN4TlPz/Z7haxYKKNecIEeb/TaKBWaOttju9c3TjCXOxRc6vFV4yCUGAIfh+W9bEFXvaiuCeE1TqvL/7dXvdLjwAExEfnpHxacNhzLQLQITa10KzRdJ2WWrDCDc9FKem36eua4MXuTeIL6UNeBzlkpqKbay4y85nQgTu0XpyD6+ZmqcqgdIg06OYSaggUt4MHX3ziat81PRAjeu9TL2ocQ7D94RwqCr+dpsUELpPzq9OI90knVHdRllw1A+2WXMnA4+LgJmMc6ww+9gyibV9QQInFLDPBmIFngg6+L4WHnSPmplgxo9nh4yOurgLsXoRdJiwu6FsdcC1vPSXh9Pso9TLsnJTCAkyATqzZ0l/5D4wo11N
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(29502001)(8676002)(122000001)(33656002)(38100700002)(86362001)(478600001)(9686003)(55016002)(186003)(26005)(7696005)(8936002)(66556008)(66476007)(71200400001)(316002)(52536014)(5660300002)(76116006)(66446008)(38070700005)(64756008)(110136005)(6506007)(66946007)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Z3VqTW5qN25QYWFCRDFLQWN3MVUxSUlSOEY3Ynh2enpVbHhRdmVSMnpzemVk?=
 =?utf-8?B?WHE0WGxTVFBpRVhPRjdMY0s4aHZrelZSTWtFbFhqb0I4YUkzSXg2aTQvMmlS?=
 =?utf-8?B?TkZuUFZ0Qm9EWnl4ckY3dnM0RWNXL3A0V2poc0JRMk1oSVhlTS9yUGdCTk41?=
 =?utf-8?B?RDVqK0c4MDN1bVpkOHd0bk9BR0VMUXpBR1Y5enVrbHdlZmFHcnFZRVdzSEQx?=
 =?utf-8?B?aXB0SFJLY0FvU21yRVp1QlFGb0lYQW1ENTEvQ1ZLOXJFNTVuUUtiVVcyMDZm?=
 =?utf-8?B?NXFPb0hvVHk2eDR6ZE43ME8vRit4UHVMMEVIbmc0S1ArT1J3dEdIdHIzYWMy?=
 =?utf-8?B?eWxZRzBMajgxeGNqdFNNbGl3dzZMbEpnTmdSQmozajE1V3BKdXJWN0t4NERs?=
 =?utf-8?B?L0h5L0pQUGRabUFiZzJmN2Jjcmw0bmpJMmNmM0ozLy93eC8vYjdmSDhvTjlh?=
 =?utf-8?B?cXR3OVZ5SWJSWVl4N2NvRWZhQzBHUHdEVUF5UHRvcWhTU0NDdVR4ODFKS3J0?=
 =?utf-8?B?NUFSS3Y0TEp1NWFPaGMyVVBaOE5seEVUK2IvNkZKd0VQbEErZm1wUlB2bkpG?=
 =?utf-8?B?dzZ0MUQvSlllWWtxQU1EUHhkWTBzN2o4T2lWTldYTmU4bkI2VWE0VTJwVFBi?=
 =?utf-8?B?dG8wWG1TOFZqaG1NYlh6U1AveDJ1Tnh5ZUZVZDJwSTc3aFROU3R6TmdxTzlU?=
 =?utf-8?B?dWtLU2VrL0Nzc05Da0dzZk1HZm5HUHNjd1RwWmxldk1sOVNWelpQcHdTNDVU?=
 =?utf-8?B?UXpBNCtTZ0l4NFI0M0RCQnYvUys2M1pnVWd1ZGlpWC81alJqZnEwbWZUVjBY?=
 =?utf-8?B?OGdHcDgwd2hGTGJ0cm00UFNlZ0NqRlRQVHVhYThZRmNBTTJXck1wVjhJZUZP?=
 =?utf-8?B?WUs0aHEyWHR1ckpxTHI3YnJ5cXFPc3NhMUpXNkp6dHFIbjJWRHJTbW5wSFlV?=
 =?utf-8?B?bVA0b3JDakJxQnFURjdMakQyMVhjckZ4L3ZvU044T0dhekM4eGVuSm1RbzVW?=
 =?utf-8?B?WjNkN285dmdiV3dHa2Y2d3I4ZTlsc0dQaVJTc3A3ZDBIM2FoTzgyNFdYZEZO?=
 =?utf-8?B?bFlIY2RPVFlnbzRNQ1NSWmJLYmFLbWxRMzJGNUc3RVdYTmlkcENUaGtScEhk?=
 =?utf-8?B?Vkx6NmZabGVPM3I5cVZIa3NwL0VUTVhWT3NIeDhSU0k0UTlKZEtYUGM4QmJ3?=
 =?utf-8?B?RURaRUFTNWIwbExFcW8wb3hRWnBLYnZPRk1EZzlsa044VUJZQTNCTGVjZzAw?=
 =?utf-8?B?Ujl5WGI0NkIydjl3UFIvRCtORUxiVUdmWjVrQ0hwTG01cXBKOEhXUDc5bFZj?=
 =?utf-8?B?ajJXbDlMc0hSRXkxUy95UEJ3Q0h2VlN1cSswaGhoK3daUi9RNDg0UVJ2emlO?=
 =?utf-8?B?Q0hCYTdxdzJPeTFEalVvUlhkYkdFRzk4cnFHcFpTSXByVDRWT29xdERKeFdy?=
 =?utf-8?B?U1VSVUpPWWZHZStsc1FrdVVRNkJlRCtIalNsOVh1WkZOTDN6NDB1M3F3SHlE?=
 =?utf-8?B?Q1JUc0pNYys1U0FIOHFyOTJpOTAxWVZ0Z29Cd01LbExBYStTWEdRWDlGNmtw?=
 =?utf-8?B?blkvQ09RbzgxZ2hwV25QVzkzOVREZDIvUndYRGhOTWluT1phRUllaTFVVE1G?=
 =?utf-8?B?R09lQ0xrcU9XTTFoUnNsM2dhVTdWaGZQYTd5eDI2VXZvcVZHc1hrZFZtTHJL?=
 =?utf-8?B?Y3JhZmdXdFhhNVhjWjBvRnlhZ0h3dDB4Y2pYcHlyYlJMaXZBRE9sWE91ZjVO?=
 =?utf-8?Q?0R49faYJ1j488OkhQfAeFtRCOvLR9Vf5Kh2JwqT?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9dc6a3b-d91c-4d6b-cef8-08d967dcb094
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2021 15:26:20.1648
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T5mWNu4WqWx+rCUUsBy+kjhYsJw6bmhyeQeQgruZ1M6CnBV+Mf/wwLuugj6BYAYZplRUefnXP5WnNyPcv+x3vq7szRCf0Y3dEKbvXzRxj0g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5390
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

PiA+IEhvd2V2ZXIgdGhlcmUgYXJlIHR3byBwcm9ibGVtczoNCj4gPiAgICAxLiBNYWtpbmcgYW4g
ZW1wdHkgY29tbWl0IHRvIG1ldGEtb3VyLWxheWVyIGRvZXNu4oCZdCBjYXVzZSB0aGUNCj4gPiBy
ZWNpcGUgdG8gYmUgcmUtcnVuLiBXaGF04oCZcyB3ZWlyZCBpcyB0aGF0IHdoZW4gSSB1c2Ug4oCY
Yml0YmFrZSB1LWJvb3QNCj4gPiDigJNl4oCZLCBJIGNhbiBzZWUgdGhhdCB0aGUgdmFsdWUgb2Yg
IE9VUl9MQVlFUl9DT01NSVQgaXMgaW5kZWVkIGNoYW5naW5nLg0KPiA+IEFuZCB3aXRoIGJpdGJh
a2UtZHVtcHNpZyAgSSBjYW4gc2VlIHRoYXQgT1VSX0xBWUVSX0NPTU1JVCBpcyBpbiB0aGUNCj4g
dGFzayBkZXBzIGZvciBkb19kZXBsb3kuDQo+ID4gICAgMi4gSWYgSSBidWlsZCDigJh1LWJvb3Ti
gJksIHRoZW4gbWFrZSBhbiBlbXB0eSBjb21taXQgdG8NCj4gPiBtZXRhLW91ci1sYXllciwgYW5k
IHRoZW4gcnVuIOKAnGJpdGJha2Utd2hhdGNoYW5nZWQgdS1ib2904oCdLCBJIGdldCBhDQo+ID4g
4oCcVGhlIG1ldGFkYXRhIGlzIG5vdCBkZXRlcm1pbmlzdGljICBhbmQgdGhpcyBuZWVkcyB0byBi
ZSBmaXhlZC7igJ0gZXJyb3IuDQo+ID4NCj4gPiBBbSBJIG1pc3VuZGVyc3RhbmRpbmcgdGhlIHB1
cnBvc2Ugb2YgdmFyZGVwdmFsdWU/IEkgdGhvdWdodCBpdCBjb3VsZA0KPiA+IGJlIHVzZWQgdG8g
aGVyZSB0byBoZWxwIGJpdGJha2Ug4oCYc2Vl4oCZIHRocm91Z2ggdmFsdWVzIHRoYXQgb3RoZXJ3
aXNlIGNoYW5nZQ0KPiB1bmV4cGVjdGVkbHkuDQo+IA0KPiBJIHN1c3BlY3QgeW91IG5lZWQgdG8g
aGF2ZSBiaXRiYWtlIGFsd2F5cyByZXBhcnNlIHRoZSByZWNpcGUgdG9vLiBNYXliZQ0KPiBCQl9E
T05UX0NBQ0hFID0gIjEiID8NCg0KVGhhbmtzIGZvciB0aGUgc3VnZ2VzdGlvbi4gSSBndWVzcyB0
aGlzIGlzIGJlY2F1c2UgdW5sZXNzIEJpdEJha2Ugc2VlcyB0aGF0IHRoZSByZWNpcGUgZmlsZShz
KSBjaGFuZ2VkIChvciB0aGV5IHVzZSBTUkNSRVYgPSBBVVRPUkVWKSwgaXQgd29uJ3QgcmVwYXJz
ZSBzdHVmZiBpbiBnZW5lcmFsPw0KDQpUaGFua3MsDQpDaHJpcw0KDQogDQo=
