Return-Path: <henning.schroeder@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 21CB275D4A
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  4 Aug 2016 11:44:06 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga101.fm.intel.com with ESMTP; 04 Aug 2016 04:44:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,470,1464678000"; d="scan'208";a="744099418"
Received: from irsmsx104.ger.corp.intel.com ([163.33.3.159])
	by FMSMGA003.fm.intel.com with ESMTP; 04 Aug 2016 04:44:06 -0700
Received: from irsmsx109.ger.corp.intel.com ([169.254.13.24]) by
	IRSMSX104.ger.corp.intel.com ([169.254.5.203]) with mapi id
	14.03.0248.002; Thu, 4 Aug 2016 12:44:04 +0100
From: "Schroeder, Henning" <henning.schroeder@intel.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>, ??? <zzs213@126.com>, 
	"Yang, Liezhi (Wind River)" <liezhi.yang@windriver.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] howto build specific version package
Thread-Index: AQHR7MsKtjci1hj3wkq4wqBVBALkLqA1sakAgAEArgCAAJk/gIABYVfA
Date: Thu, 4 Aug 2016 11:44:04 +0000
Message-ID: <093B67FB09E7C1439E8DF68949D5ACF32A619126@IRSMSX109.ger.corp.intel.com>
References: <360daea.d273.1564bad5108.Coremail.zzs213@126.com>
	<57A0B48A.6000606@windriver.com>
	<06719fa1-4361-f8d1-c4ef-c10534c3f1f3@126.com>
	<1470237801.9142.134.camel@linuxfoundation.org>
In-Reply-To: <1470237801.9142.134.camel@linuxfoundation.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [163.33.239.181]
MIME-Version: 1.0
Subject: Re: howto build specific version package
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
X-List-Received-Date: Thu, 04 Aug 2016 11:44:08 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBiaXRiYWtlLWRldmVsLWJvdW5j
ZXNAbGlzdHMub3BlbmVtYmVkZGVkLm9yZyBbbWFpbHRvOmJpdGJha2UtDQo+IGRldmVsLWJvdW5j
ZXNAbGlzdHMub3BlbmVtYmVkZGVkLm9yZ10gT24gQmVoYWxmIE9mIFJpY2hhcmQgUHVyZGllDQo+
IFNlbnQ6IFdlZG5lc2RheSwgQXVndXN0IDMsIDIwMTYgMTc6MjMNCj4gVG86IOW8oOW/oOWxsSA8
enpzMjEzQDEyNi5jb20+OyBZYW5nLCBMaWV6aGkgKFdpbmQgUml2ZXIpDQo+IDxsaWV6aGkueWFu
Z0B3aW5kcml2ZXIuY29tPjsgYml0YmFrZS1kZXZlbEBsaXN0cy5vcGVuZW1iZWRkZWQub3JnDQo+
IFN1YmplY3Q6IFJlOiBbYml0YmFrZS1kZXZlbF0gaG93dG8gYnVpbGQgc3BlY2lmaWMgdmVyc2lv
biBwYWNrYWdlDQo+IA0KPiBPbiBXZWQsIDIwMTYtMDgtMDMgYXQgMTQ6MTQgKzA4MDAsIOW8oOW/
oOWxsSB3cm90ZToNCj4gPiDlnKggMjAxNuW5tDA45pyIMDLml6UgMjI6NTYsIFJvYmVydCBZYW5n
IOWGmemBkzoNCj4gPiA+IEhpLA0KPiA+ID4NCj4gPiA+IE9uIDA4LzAyLzIwMTYgMTA6MzQgUE0s
IHp6cyB3cm90ZToNCj4gPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gSGVsbG8sIGV2ZXJ5b25lDQo+
ID4gPiA+DQo+ID4gPiA+IEkgaGF2ZSB0d28gdmVyc2lvbiAuYmIgcmVjaXBlLCBzeWEgdGVzdF8x
LjAuYmIgYW5kIHRlc3RfMi4wLmJiLg0KPiA+ID4gPiBXaGVuIGJ1aWxkIHRoZSBgdGVzdGAgcGFj
a2FnZSAgdXNpbmcgdGhlIGZsb3d3aW5nIGNtZDoNCj4gPiA+ID4gICAgICBiaXRiYWtlIHRlc3QN
Cj4gPiA+ID4gQWx3YXlzIDIuMCB3YXMgYnVpbHQuDQo+ID4gPiA+IE15IHF1ZXN0aW9uIGlzOiBo
b3cgdG8gbGV0IGJpdGJha2UgdG8gYnVpbGQgdmVyc2lvbiAxLjAgb2YgdGhlDQo+ID4gPiA+IHRl
c3QgcGFja2FnZQ0KPiA+ID4NCj4gPiA+IFlvdSBjYW46DQo+ID4gPiAxKSBQUkVGRVJSRURfVkVS
U0lPTl90ZXN0ID0gIjEuMCIgaW4gY29uZiBmaWxlIHN1Y2ggYXMgbG9jYWwuY29uZg0KPiA+ID4g
T3I6DQo+ID4gPiAyKSBTZXQgREVGQVVMVF9QUkVGRVJFTkNFID0gIi0xIiBpbiB0ZXN0XzIuMC5i
Yi4NCj4gPiA+DQo+ID4gPiAvLyBSb2JlcnQNCj4gPiA+DQo+ID4gVGhhbmtzIGZvciB5b3VyIHJl
cGxleS4NCj4gPg0KPiA+IFlvdXIgc3VnZ2VzdGVkIG1ldGhvZCBjYW4gc2VsZWN0IGFueSB2ZXJz
aW9uIHN1cmUuDQo+ID4NCj4gPiBCdXQgd2hlbmV2ZXIgSSBmaW5pc2ggIG15IHByb2plY3QuIHNv
bWUgdGltZSBsYXRlciBJIHdhbid0IHJlYnVpbHQNCj4gPiB0aGlzIHByb2plY3QuDQo+ID4gVGhl
biBJIG11c3QgZWRpdCB0aGUgc291cmNlIHRvIHNlbGVjdCBzcGVjaWZpYyB2ZXJzaW9uLiBJdCBp
cyBub3QNCj4gPiBjb252ZW5pZW50IGFuZCBidWdneS4NCj4gPiBJcyB0aGVyZSBhIHdheSB0byBz
ZWxlY3QgdmVyc2lvbiB0aGF0IG5vIG5lZWQgdG8gZWRpdCB0aGUgc291cmNlLCBlLmcuDQo+ID4g
c2VsZWN0IGl0IG9uIGNvbW1hbmQgbGluZQ0KPiANCj4gWW91IGNhbid0IHNlbGVjdCBldmVyeXRo
aW5nIGZyb20gdGhlIGNvbW1hbmRsaW5lLiBJdHMgZm9yIHRoZSByZWFzb25zIG9mDQo+IHJlcHJv
ZHVjaWJpbGl0eSB0aGF0IHdlIHN1Z2dlc3QgcGVvcGxlIHNldCB0aGluZ3MgaW4gY29uZmlndXJh
dGlvbiBmaWxlcyBsaWtlDQo+IGxvY2FsLmNvbmYuIFlvdSBjYW4gdGhlbiBwcm92aWRlIHRoZSBl
eGFjdCBjb25maWd1cmF0aW9uIHRvIHJlcHJvZHVjZSBhbnkNCj4gZ2l2ZW4gYnVpbGQgYnkgc2F2
aW5nIHRoYXQgY29uZmlndXJhdGlvbiBmaWxlLg0KPiANCj4gQ2hlZXJzLA0KPiANCj4gUmljaGFy
ZA0KDQpIaSwNCkkgZG8gc2VlIHR3byBvcHRpb25zIGZvciB5b3UuDQoxLikgQXMgZXhwbGFpbmVk
IGJ5IHRoZSBmb2xrcyBhbHJlYWR5IHlvdSBjcmVhdGUgdHdvIGJ1aWxkIGRpcmVjdG9yaWVzIHdo
aWNoIHNoYXJlIGRvd25sb2FkIGFuZCBzc3RhdGUgZm9sZGVycy4gVGhlbiB5b3UgY3JlYXRlIG9u
ZSBsb2NhbC5jb25mIHdpdGggdGhlICJQcm9kdWN0aW9uIFZlcnNpb24iIGFuZCBvbmUgd2l0aCB0
aGUgIkRldmVsb3BtZW50IFZlcnNpb24iLiBEZXBlbmRpbmcgb24gd2hpY2ggYnVpbGQgZm9sZGVy
IHlvdSB1dGlsaXplIHlvdSBnZXQgdGhlIHByb2R1Y3Qgb3IgZGV2ZWxvcG1lbnQgdmVyc2lvbi4g
DQoyLikgSWYgeW91IGluY2xpbmUgdG8gdXNlIHRoZSBjb21tYW5kIGxpbmUgdG8gc3dpdGNoLCB0
aGVyZSBpcyB0aGUgb3B0aW9uIHRvIHNwZWNpZnkgYSBjb25maWcgZmlsZSBleHBsaWNpdGVseSBy
ZWFkIGJ5IGJpdGJha2UuIElmIGNhbGxlZCB3aXRoICItUiBwcm9kdWN0LmNvbmYiIHlvdSBnZXQg
eW91ciBwcm9kdWN0IHZlcnNpb24gYW5kIG90aGVyd2lzZSB5b3Ugc3RpY2sgd2l0aCBZb2N0byBj
aG9pY2Ugb2YgdGFraW5nIG5ld2VzdCBvbmUuDQoNCkV4YW1wbGU6DQpiYXNoLTQuMyQgY2F0IC0+
IHByb2R1Y3QuY29uZg0KUFJFRkVSUkVEX1ZFUlNJT05fdGVzdD0iMS4wIg0KYmFzaC00LjMkIGJp
dGJha2UgLVIgcHJvZHVjdC5jb25mIHRlc3QNCi4uLg0KDQpPcHRpb24gT25lIGlzIHRoZSBtb3N0
IGNvbmZsaWN0IGZyZWUgdmFyaWFudCBhcyB5b3VyIGNvbmZpZ3VyYXRpb25zIGFyZSBjbGVhbmx5
IHNlcGFyYXRlZCBhbmQgeW91ciBjYWxscyB0byBiaXRiYWtlIGFyZSBpZGVudGljYWwuIEF0IHRo
ZSBjb3N0IG9mIGhhdmluZyB0aGUgYnVpbGQgZGlyZWN0b3J5IHR3byB0aW1lcyBhbmQgdHdvIGRp
ZmZlcmVudCBlbnZpcm9ubWVudHMgKFNoZWxsIGluc3RhbmNlcykuDQpPcHRpb24gVHdvIGlzIHJp
c2t5IGlmIHlvdSBkbyBub3QgdGVsbCBiaXRiYWtlIHRvIGNsZWFuIChiaXRiYWtlIC1jIGNsZWFu
YWxsIHRlc3QpIGZyb20gdGhlIGZvcm1lciBidWlsZCBhcyB5b3UgbWF5IGVuZCB1cCB3aXRoIGEg
bWl4ZWQgc3lzcm9vdC4NCg0KSG9wZSB0aGlzIGhlbHBzLg0KDQpLaW5kIFJlZ2FyZHMNCiBIZW5u
aW5nDQpJbnRlbCBEZXV0c2NobGFuZCBHbWJIClJlZ2lzdGVyZWQgQWRkcmVzczogQW0gQ2FtcGVv
biAxMC0xMiwgODU1NzkgTmV1YmliZXJnLCBHZXJtYW55ClRlbDogKzQ5IDg5IDk5IDg4NTMtMCwg
d3d3LmludGVsLmRlCk1hbmFnaW5nIERpcmVjdG9yczogQ2hyaXN0aW4gRWlzZW5zY2htaWQsIENo
cmlzdGlhbiBMYW1wcmVjaHRlcgpDaGFpcnBlcnNvbiBvZiB0aGUgU3VwZXJ2aXNvcnkgQm9hcmQ6
IE5pY29sZSBMYXUKUmVnaXN0ZXJlZCBPZmZpY2U6IE11bmljaApDb21tZXJjaWFsIFJlZ2lzdGVy
OiBBbXRzZ2VyaWNodCBNdWVuY2hlbiBIUkIgMTg2OTI4Cg==


