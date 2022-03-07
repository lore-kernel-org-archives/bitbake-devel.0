Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A17C8C433EF
	for <webhook@archiver.kernel.org>; Mon,  7 Mar 2022 16:00:13 +0000 (UTC)
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 by mx.groups.io with SMTP id smtpd.web11.27927.1646668808819887639
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 07 Mar 2022 08:00:12 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@axis.com
 header.s=axis-central1 header.b=Wsgkhw63;
 spf=pass (domain: axis.com, ip: 195.60.68.18,
 mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1646668809;
  x=1678204809;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=DPJG0YbCNYOGlCID6LDxVNGu+KThKlvF2hxm02s3BtA=;
  b=Wsgkhw63PFFjpIpTyykktSf3w0fOfI34c+iiM9mBfPpgDaqXj/BGhQEg
   wZhyP5n1hKXLGf0L9tNjRswdwlzajJ8dk6PiLTG65smQaj48QbhQUWOi5
   kRaS0hxgcxpDMw318NWVLKa5uDN4DUprQ+6mxZj3dIICvpkihG/PQ9tck
   DXmE2YozG/fxHdAxDVcsbQ7JPxscSZiRqVuYAQWhWcNAWJA4YkIXxhFPg
   wDzHScAQrlZbZckI+p+DJaauyEk6iFs+w/d6lLvi0Ut0anjsKEwrwAEiK
   Iw5hCTksE9ebrGvv+2CItSwO8+9HX5QDiek7nxUQVN+0WWuL1+mPrK4fT
   A==;
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH 2/3] knotty.py: Give the setscene tasks
 their own progress bar
Thread-Topic: [bitbake-devel] [PATCH 2/3] knotty.py: Give the setscene tasks
 their own progress bar
Thread-Index: AQHYMjq6p2dwpJ1r4kOfApjHnmDV86y0EUIw
Date: Mon, 7 Mar 2022 16:00:05 +0000
Message-ID: <af45542e292645da9c79cbc5f2d05793@axis.com>
References: <20220307133620.12404-1-pkj@axis.com>
	 <20220307133620.12404-2-pkj@axis.com>
 <6ce6730badc71ed1d136bf14044a23c038efaf17.camel@linuxfoundation.org>
In-Reply-To: 
 <6ce6730badc71ed1d136bf14044a23c038efaf17.camel@linuxfoundation.org>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.0.5.60]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 07 Mar 2022 16:00:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13433

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSaWNoYXJkIFB1cmRpZSA8cmlj
aGFyZC5wdXJkaWVAbGludXhmb3VuZGF0aW9uLm9yZz4NCj4gU2VudDogZGVuIDcgbWFycyAyMDIy
IDE2OjQ4DQo+IFRvOiBQZXRlciBLamVsbGVyc3RlZHQgPHBldGVyLmtqZWxsZXJzdGVkdEBheGlz
LmNvbT47IGJpdGJha2UtDQo+IGRldmVsQGxpc3RzLm9wZW5lbWJlZGRlZC5vcmcNCj4gU3ViamVj
dDogUmU6IFtiaXRiYWtlLWRldmVsXSBbUEFUQ0ggMi8zXSBrbm90dHkucHk6IEdpdmUgdGhlIHNl
dHNjZW5lDQo+IHRhc2tzIHRoZWlyIG93biBwcm9ncmVzcyBiYXINCj4gDQo+IE9uIE1vbiwgMjAy
Mi0wMy0wNyBhdCAxNDozNiArMDEwMCwgUGV0ZXIgS2plbGxlcnN0ZWR0IHdyb3RlOg0KPiA+IEZy
b206IFBldGVyIEtqZWxsZXJzdGVkdCA8cGV0ZXIua2plbGxlcnN0ZWR0QGF4aXMuY29tPg0KPiA+
DQo+ID4gSW4gY29tbWl0IDgwNTVlYzM2IChrbm90dHk6IEltcHJvdmUgc2V0c2NlbmUgdGFzayBk
aXNwbGF5KSB0aGUgc2V0c2NlbmUNCj4gPiB0YXNrcyBnb3QgdGhlaXIgb3duIGxpbmUgaW4gdGhl
IHRhc2sgb3V0cHV0LiBIb3dldmVyLCB0aGUgcHJvZ3Jlc3MgYmFyDQo+ID4gY29kZSBkb2VzIG5v
dCBoYW5kbGUgbmV3bGluZXMgaW4gaXRzIHdpZGdldHMsIHNvIHRoZSBsZW5ndGggb2YgdGhlDQo+
ID4gc2V0c2NlbmUgbGluZSB3YXMgaW5jbHVkZWQgd2hlbiBjYWxjdWxhdGluZyBob3cgbXVjaCBz
cGFjZSBpcyBhdmFpbGFibGUNCj4gPiBmb3IgdGhlIHByb2dyZXNzIGJhciBvZiB0aGUgcnVubmlu
ZyB0YXNrcywgbWFraW5nIGl0IG11Y2ggdG9vIHNob3J0Lg0KPiA+DQo+ID4gSW5zdGVhZCBvZiB0
cnlpbmcgdG8gdGVhY2ggdGhlIHByb2dyZXNzIGJhciBjb2RlIHRvIGhhbmRsZSBuZXdsaW5lcywN
Cj4gPiBnaXZlIHRoZSBzZXRzY2VuZSB0YXNrcyB0aGVpciBvd24gcHJvZ3Jlc3MgYmFyLg0KPiA+
DQo+ID4gU2lnbmVkLW9mZi1ieTogUGV0ZXIgS2plbGxlcnN0ZWR0IDxwZXRlci5ramVsbGVyc3Rl
ZHRAYXhpcy5jb20+DQo+ID4gLS0tDQo+ID4gIGJpdGJha2UvbGliL2JiL3VpL2tub3R0eS5weSB8
IDM0ICsrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5n
ZWQsIDIyIGluc2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQ0KPiANCj4gSSdkIG11Y2ggcHJl
ZmVyIG5vdCB0byBhZGQgeWV0IGFub3RoZXIgY29uZnVzaW5nIHByb2dyZXNzIGJhciBhcyBpdCB3
aWxsDQo+IGp1c3QgY29uZnVzZSB1c2VycyBtb3JlLiBUaGUgcmVhbCBwcm9ncmVzcyB0byB3YXRj
aCBpcyB0aGUgcmVhbCB0YXNrcyANCj4gb25lIGFuZCB0aGF0IHdpbGwgaW5jcmVhc2UgYXMgc2V0
c2NlbmUgdGFza3MgYXJlIGNvdmVyZWQuDQoNCkhtbSwgbXkgZmlyc3Qgc29sdXRpb24gd2FzIHdp
dGhvdXQgdGhlIHByb2dyZXNzIGJhci4gSG93ZXZlciwgd2hlbiANCkkgcmVhbGl6ZWQgdGhhdCBh
IHByb2dyZXNzIGJhciBjb3VsZCBiZSB1c2VkIGluc3RlYWQsIEkgdGhvdWdodCBpdCANCm1hZGUg
c2Vuc2UuDQoNCkNvbnNpZGVyIHRoZSBjYXNlIHdoZXJlIHlvdSBhcmUgbWFraW5nIGEgYnVpbGQg
d2hpY2ggaGFzIGFsbW9zdCANCmV2ZXJ5dGhpbmcgaW4gdGhlIHNzdGF0ZSBjYWNoZSwgdGhlbiB0
aGUgY3VycmVudCBvdXRwdXQgaXMgbGVzcyANCm9wdGltYWwuIEkuZS4sIHRoZSBmaXJzdCBsaW5l
IHdpbGwgc2hvdyBhIGNvdW50ZXIgaW5jcmVhc2luZywgYnV0IA0Kbm8gcHJvZ3Jlc3MgYmFyLCB3
aGlsZSB0aGUgc2Vjb25kIGxpbmUgc2hvd3MgYSBwcm9ncmVzcyBiYXIgdGhhdCANCmJhc2ljYWxs
eSBnb2VzIGZyb20gMCUgdG8gMTAwJSBpbiBvbmUgc3RlcCBvbmNlIGFsbCB0aGUgc2V0c2NlbmUg
DQp0YXNrcyBhcmUgZG9uZS4NCg0KPiBBZGRpbmcgdGhpcyBkcmF3cyB0aGUgdXNlcidzIGF0dGVu
dGlvbiBhd2F5IGZyb20gd2hlcmUgdGhleSBwcm9iYWJseSB3YW50DQo+IHRvIGJlIGxvb2tpbmcu
IElmIHlvdSBrbm93IG90aGVyd2lzZSwgeW91IGRvbid0IG5lZWQgdGhlIHByb2dyZXNzIGJhciBJ
TU8uDQoNCk5lZWQgaXMgYSBzdHJvbmcgd29yZCB3aGVuIGl0IGNvbWVzIHRvIHRoZSBwcm9ncmVz
cyBiYXJzLiBQZXJzb25hbGx5IA0KSSBsaWtlIHRvIHdhdGNoIHRoZW0gbW92ZSBhbG9uZy4gOikg
SSBmaW5kIGl0IGVhc2llciB0byBnZXQgYSB2aWV3IA0Kb2YgdGhlIGN1cnJlbnQgcHJvZ3Jlc3Mg
YnkgbG9va2luZyBhdCB0aGUgYmFycyByYXRoZXIgdGhhbiB0aGUgDQpjb3JyZXNwb25kaW5nIG51
bWJlcnMuDQoNCj4gQ2hlZXJzLA0KPiANCj4gUmljaGFyZA0KDQovL1BldGVyDQoNCg==

