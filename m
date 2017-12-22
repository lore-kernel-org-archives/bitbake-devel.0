Return-Path: <david.reyna@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id E7A45787C8
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Dec 2017 06:32:15 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id vBM6WF27027851
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=OK);
	Thu, 21 Dec 2017 22:32:15 -0800
Received: from ALA-MBC.corp.ad.wrs.com ([169.254.1.62]) by
	ALA-HCB.corp.ad.wrs.com ([147.11.189.41]) with mapi id 14.03.0361.001;
	Thu, 21 Dec 2017 22:32:14 -0800
From: "Reyna, David" <david.reyna@windriver.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH V2 2/6] toaster: update Toaster for
	Django 1.11
Thread-Index: AQHTeBIHfa26CTMfUEeh0qf7cCgvTaNO66Fg
Date: Fri, 22 Dec 2017 06:32:14 +0000
Message-ID: <5E53D14CE4667A45B9A06760DE5D13D0D8B60071@ALA-MBC.corp.ad.wrs.com>
References: <cover.1512030424.git.David.Reyna@windriver.com>
	<e0d2ed2f79a7c475fccd2f4f788e8feccd2156bc.1512030424.git.David.Reyna@windriver.com>
	<1513609686.16507.44.camel@linuxfoundation.org>
In-Reply-To: <1513609686.16507.44.camel@linuxfoundation.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [147.11.117.207]
MIME-Version: 1.0
Cc: "YEOH, EE PENG" <ee.peng.yeoh@intel.com>
Subject: Re: [PATCH V2 2/6] toaster: update Toaster for Django 1.11
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 22 Dec 2017 06:32:16 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgUmljaGFyZCwNCg0KPiBTb21laG93IHRoZXJlIGlzIGEgIlYyIiBpbiB0aGUgcGF0Y2ggdGhh
dCBjYXVzZWQgaXQgdG8gZmFpbCB0byBhcHBseS4NCg0KT3VjaC4gDQoNCk5vdCBvbmx5IHRoYXQs
IHNvbWVob3cgdGhhdCBzYW1lICJWMiIgZ2xpdGNoIHJ1aW5lZCBteSAiUEFUQ0ggVjIgMi82IiBm
aWxlLCB3aGljaCBicmVha3MgVG9hc3RlciBvbiBzdGFydHVwIGZvciBtYXN0ZXIuIEkgd2lsbCBz
ZW5kIGEgZml4LXVwIHBhdGNoLg0KDQpUaG9zZSBlcnJvcnMgYXJlIG5vdCBpbiB0aGUgcGFyYWxs
ZWwgcGF0Y2ggc2V0IHRoYXQgd2FzIGZvciAicm9ja28iLCBzbyBhdCBsZWFzdCB0aGF0IHdhcyBu
b3QgcnVpbmVkLg0KDQotIERhdmlkDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9t
OiBSaWNoYXJkIFB1cmRpZSBbbWFpbHRvOnJpY2hhcmQucHVyZGllQGxpbnV4Zm91bmRhdGlvbi5v
cmddIA0KU2VudDogTW9uZGF5LCBEZWNlbWJlciAxOCwgMjAxNyA3OjA4IEFNDQpUbzogUmV5bmEs
IERhdmlkOyBiaXRiYWtlLWRldmVsQGxpc3RzLm9wZW5lbWJlZGRlZC5vcmcNClN1YmplY3Q6IFJl
OiBbYml0YmFrZS1kZXZlbF0gW1BBVENIIFYyIDIvNl0gdG9hc3RlcjogdXBkYXRlIFRvYXN0ZXIg
Zm9yIERqYW5nbyAxLjExDQoNCk9uIFRodSwgMjAxNy0xMS0zMCBhdCAwMDo1NSAtMDgwMCwgRGF2
aWQgUmV5bmEgd3JvdGU6DQo+IC0tLSBhL2xpYi90b2FzdGVyL3RvYXN0ZXJndWkvdmlld3MucHkN
Cj4gKysrIGIvbGliL3RvYXN0ZXIvdG9hc3Rlcmd1aS92aWV3cy5weQ0KPiBAQCAtMjc3LDcgKzI3
Nyw3IEBAIGRlZiBfdmFsaWRhdGVfaW5wdXQoZmllbGRfaW5wdXQsIG1vZGVsKToNCj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gTm9uZSwgaW52YWxpZCArIHN0cihmaWVsZF9pbnB1
dF9saXN0KQ0KPiDCoA0KPiDCoMKgwqDCoMKgwqDCoMKgwqBWMiAjIENoZWNrIHdlIGFyZSBsb29r
aW5nIGZvciBhIHZhbGlkIGZpZWxkDQo+IC3CoMKgwqDCoMKgwqDCoMKgdmFsaWRfZmllbGRzID0g
bW9kZWwuX21ldGEuZ2V0X2FsbF9maWVsZF9uYW1lcygpDQo+ICvCoMKgwqDCoMKgwqDCoMKgdmFs
aWRfZmllbGRzID0gW2YubmFtZSBmb3IgZiBpbiBtb2RlbC5fbWV0YS5nZXRfZmllbGRzKCldDQo+
IMKgwqDCoMKgwqDCoMKgwqDCoGZvciBmaWVsZCBpbiBmaWVsZF9pbnB1dF9saXN0WzBdLnNwbGl0
KEFORF9WQUxVRV9TRVBBUkFUT1IpOg0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIFRy
dWUgaW4gW2ZpZWxkLnN0YXJ0c3dpdGgoeCkgZm9yIHggaW4gdmFsaWRfZmllbGRzXToNCj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGJyZWFrDQoNClNvcnJ5IGFib3V0IHRoZSBk
ZWxheSB3aXRoIHRoZXNlLiBTb21laG93IHRoZXJlIGlzIGEgIlYyIiBpbiB0aGUgcGF0Y2ggdGhh
dCBjYXVzZWQgaXQgdG8gZmFpbCB0byBhcHBseS4gSSd2ZSBmaXhlZCB0aGF0IHVwIG1hbnVhbGx5
IGFuZCBhcHBsaWVkIGl0Lg0KDQpDaGVlcnMsDQoNClJpY2hhcmQNCg==

