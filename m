Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 by mx.groups.io with SMTP id smtpd.web11.801.1631892439735760240
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 17 Sep 2021 08:27:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=AIJhJLdj;
 spf=pass (domain: axis.com, ip: 195.60.68.18, mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1631892440;
  x=1663428440;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/ZiKpxQk0Kqfb9cDc0qYLUxD0sX1WufEJfqtWtbZ+5Y=;
  b=AIJhJLdjEUdzrjW/BQRUReb3Tqw4QIJ4SowGHkp7cmnzcBkWRgV+Nzob
   rLncNRCtUcg7q/zGJkjfbIryDMDcgMpyz2+7P4W3j6HkpOnpFNY7ET1xp
   X48r6uwjFOsbGpQTwcBQ5wkNZKh4rZHrG7Z2YPThzHA1mUDTqQIvdBvqb
   SVrv2226bISZn6FoG8VnlOo2YD16ZnCKdnngEkkvRIZbI/2IleUmj92wt
   y6IxiAIyy+uzjS5GbW/n2SKdAxU62Y3yH15NpHlWZxoCg6LBvMpzTcYQY
   F7d91EcwHOuyndoQ1wv2dglQoSZWN/Sgv9W5XfqqFDM7TUq7hbPF81+uo
   A==;
From: "Peter Kjellerstedt" <peter.kjellerstedt@axis.com>
To: Andrea Adami <andrea.adami@gmail.com>
CC: Khem Raj <raj.khem@gmail.com>, Mayank Agarwal
	<mayank77fromindia@gmail.com>, bitbake-devel
	<bitbake-devel@lists.openembedded.org>, openembedded-architecture
	<openembedded-architecture@lists.openembedded.org>
Subject: Re: [Openembedded-architecture] Disable bbappend file from another meta layer
Thread-Topic: [Openembedded-architecture] Disable bbappend file from another
 meta layer
Thread-Index: AQHXqzpAU1VxF1uZP0CKzSI/MQgL3quoWMVA
Date: Fri, 17 Sep 2021 15:27:16 +0000
Message-ID: <20463f261de64e5db33f5360421acd82@axis.com>
References: <CAKjpqyJZGQh0BruPiny5X=hv3iqsfzj+FJwmdzXdWm-ThzgQhA@mail.gmail.com>
 <CAMKF1soE_CY13wubo7mqyTUKpVqXipqOCsoXhEjeiw-AqDAcsg@mail.gmail.com>
 <16A56782DEC68495.13685@lists.openembedded.org>
 <CAAQYJAv-mi9veLTXqqaMFMZxqWKAaH07bxciXDGMCxkOTMjYoQ@mail.gmail.com>
In-Reply-To: <CAAQYJAv-mi9veLTXqqaMFMZxqWKAaH07bxciXDGMCxkOTMjYoQ@mail.gmail.com>
Accept-Language: en-US, sv-SE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.0.5.60]
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBvcGVuZW1iZWRkZWQtYXJjaGl0
ZWN0dXJlQGxpc3RzLm9wZW5lbWJlZGRlZC5vcmcgPG9wZW5lbWJlZGRlZC0NCj4gYXJjaGl0ZWN0
dXJlQGxpc3RzLm9wZW5lbWJlZGRlZC5vcmc+IE9uIEJlaGFsZiBPZiBBbmRyZWEgQWRhbWkNCj4g
U2VudDogZGVuIDE2IHNlcHRlbWJlciAyMDIxIDIyOjM0DQo+IFRvOiBBbmRyZWEgQWRhbWkgPGFu
ZHJlYS5hZGFtaUBnbWFpbC5jb20+DQo+IENjOiBLaGVtIFJhaiA8cmFqLmtoZW1AZ21haWwuY29t
PjsgTWF5YW5rIEFnYXJ3YWwNCj4gPG1heWFuazc3ZnJvbWluZGlhQGdtYWlsLmNvbT47IGJpdGJh
a2UtZGV2ZWwgPGJpdGJha2UtDQo+IGRldmVsQGxpc3RzLm9wZW5lbWJlZGRlZC5vcmc+OyBvcGVu
ZW1iZWRkZWQtYXJjaGl0ZWN0dXJlIDxvcGVuZW1iZWRkZWQtDQo+IGFyY2hpdGVjdHVyZUBsaXN0
cy5vcGVuZW1iZWRkZWQub3JnPg0KPiBTdWJqZWN0OiBSZTogW09wZW5lbWJlZGRlZC1hcmNoaXRl
Y3R1cmVdIERpc2FibGUgYmJhcHBlbmQgZmlsZSBmcm9tDQo+IGFub3RoZXIgbWV0YSBsYXllcg0K
PiANCj4gT24gVGh1LCBTZXAgMTYsIDIwMjEgYXQgMTA6MzAgUE0gQW5kcmVhIEFkYW1pIHZpYQ0K
PiBsaXN0cy5vcGVuZW1iZWRkZWQub3JnIDxhbmRyZWEuYWRhbWk9Z21haWwuY29tQGxpc3RzLm9w
ZW5lbWJlZGRlZC5vcmc+DQo+IHdyb3RlOg0KPiA+DQo+ID4gT24gVGh1LCBTZXAgMTYsIDIwMjEg
YXQgNzoyOCBQTSBLaGVtIFJhaiA8cmFqLmtoZW1AZ21haWwuY29tPiB3cm90ZToNCj4gPiA+DQo+
ID4gPiBPbiBUaHUsIFNlcCAxNiwgMjAyMSBhdCA5OjQ1IEFNIE1heWFuayBBZ2Fyd2FsDQo+ID4g
PiA8bWF5YW5rNzdmcm9taW5kaWFAZ21haWwuY29tPiB3cm90ZToNCj4gPiA+ID4NCj4gPiA+ID4g
RGVhciBFeHBlcnRzLA0KPiA+ID4gPg0KPiA+ID4gPiBJcyB0aGVyZSBhbnkgd2F5IHdlIGNhbiBk
aXNhYmxlIGJiYXBwZW5kIGZpbGUgZnJvbSBhbm90aGVyIG1ldGEtDQo+IGxheWVyIGluIHRoZSBj
dXJyZW50DQo+ID4gPiA+IG1ldGEtbGF5ZXIgb3IgcmVjaXBlIGZpbGUuSXQgd2lsbCBiZSBvZiBn
cmVhdCBoZWxwLklmIHdlIGNhbiB1c2UNCj4gUE5CTEFDS0xJU1Qgb3IgQkJNQVNLDQo+ID4gPiA+
IHRvIGRpc2FibGUgYmJhcHBlbmQgZmlsZS4NCj4gPiA+ID4NCj4gPiA+DQo+ID4gPiBiYmFwcGVu
ZHMgY2FuIG5vdCBiZSB1bmRvbmUgc2FkbHksIG1heWJlIHlvdSBjYW4gdHJ5IHNvbWUgQkJNQVNL
aW5nIGl0DQo+ID4gPiBpZiBpdHMgaW4gdW5pcXVlIGxvY2F0aW9uIHBlcmhhcHMuDQo+ID4gPg0K
PiA+DQo+ID4gU2VlIGhlcmUgb25lIGV4YW1wbGU6DQo+ID4gaHR0cHM6Ly9naXRodWIuY29tL3Z1
LXBsdXMvbWV0YS12dXBsdXMvYmxvYi9tYXN0ZXIvY29uZi9sYXllci5jb25mI0w0DQo+ID4gdnMg
b25lIGFsbG93aW5nIHRoZW0NCj4gPiBodHRwczovL2dpdC5vcGVuZW1iZWRkZWQub3JnL21ldGEt
aGFuZGhlbGQvdHJlZS9jb25mL2xheWVyLmNvbmYjbjgNCj4gPiBjaGVlcnMNCj4gPiBBLkEuDQo+
ID4NCj4gDQo+IGJ1dCBtYXliZSBJIG1pc3JlYWQgJ2luIGFub3RoZXIgbWV0YS1sYXllcicgb3V0
IG9mIHlvdXIgY29udHJvbC4gc29ycnkuLi4NCj4gQS5BLg0KPiA+ID4gPiBSZWdhcmRzDQo+ID4g
PiA+IE1heWFuaw0KDQpJdCBpcyBwZXJmZWN0bHkgZmluZSB0byBhZGQsIGUuZy46DQoNCkJCTUFT
SyArPSAiL21ldGEtZm9vL3JlY2lwZXMtZm9vL2Zvby9mb29fMS4yLjMuYmJhcHBlbmQiDQoNCnRv
LCBlLmcuLCBtZXRhLWJhci9jb25mL2xheWVyLmNvbmYgdG8gZGlzYWJsZSB0aGUgdXNlIG9mIA0K
Zm9vXzEuMi4zLmJiYXBwZW5kIGZyb20gdGhlIG1ldGEtZm9vIGxheWVyIHdoZW4gdGhlIG1ldGEt
YmFyIGxheWVyIGlzIA0KdXNlZC4NCg0KLy9QZXRlcg0KDQo=
