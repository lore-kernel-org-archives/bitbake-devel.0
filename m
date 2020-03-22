Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 by mx.groups.io with SMTP id smtpd.web11.21336.1584837538586019049
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 21 Mar 2020 17:38:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=k0yYcAR1;
 spf=pass (domain: axis.com, ip: 195.60.68.18, mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=3478; q=dns/txt; s=axis-central1;
  t=1584837539; x=1616373539;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2/f94wBGaTZ87qEopGd1V931zszBC/lKIH0y2CopQ08=;
  b=k0yYcAR1446XJ0QRxFRSP+v3+mTSWfqZcPEnLostwGfTZfunL9GDKa7j
   ljd3osCAoFtL1eXsshRpjk0hEAQrEf4MFUaKBomGYsF7E2pBXAlUpTqj3
   NeBZ5WVQNv3taCGBKFAzgApzw4untAS3n3X5SpAfZf/l6vCaLE+Tcy262
   2Pj/5VC35OuVGPdgFyCu3x/0kindDlf05lLclOPDyEA0qxy60yTGPqsZJ
   whjYKpoFll3jvTQMtfXtRsMh3XhoozpPLvytj5AXUuqLlWCeBE1yJaZYc
   o0K0VSCe5U4+Acp7BTU3SsfcNawBuBJ2zbWbamawyNxJnRXETSlGO5BoI
   g==;
IronPort-SDR: EX9PHPysSPP4/8EQU+ogF/Dilzupva1SlrWmb8XCAjOGZ5D65CYKdJ3AI8Myx8iabxG+CW/xny
 aln2uBrg6Bc6vY9yNt2CWw3QwGB+QfkVlUWaqByC/vwCIEQwraCNw6tsOzlfnVyyUFEcNewXE7
 2/kNOoVuxp7EMvM2fiww5KLOyZTvcZ2GmDAT2DoNxv9HuYR4r7M8vYLftQJEUJ4lDkkhWjwN2j
 o+XEgqeGaG7MBDDsjmB5gT8UNWBdP2lFNQvQFuj9kkfIVepARzpbmsZW1a2oK6IGEiR34ioAS4
 OYs=
X-IronPort-AV: E=Sophos;i="5.72,290,1580770800"; 
   d="scan'208";a="6599310"
From: "Peter Kjellerstedt" <peter.kjellerstedt@axis.com>
To: Khem Raj <raj.khem@gmail.com>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [master][zeus][PATCH 3/3] fetch2: Allow ${AUTOREV} to be used when BB_SRCREV_POLICY is "cache"
Thread-Topic: [bitbake-devel] [master][zeus][PATCH 3/3] fetch2: Allow
 ${AUTOREV} to be used when BB_SRCREV_POLICY is "cache"
Thread-Index: AQHV/8nldQqzjdEoWEmBLHb/bMWci6hTs3rA///1dQCAABaKoA==
Date: Sun, 22 Mar 2020 00:38:51 +0000
Message-ID: <2f891d304ee448538457d2b94c32bba3@XBOX03.axis.com>
References: <20200215032955.3958-3-pkj@axis.com>
 <5532.1584827063458682607@lists.openembedded.org>
 <1cdd50184c1f4af488baee9ee691b495@XBOX03.axis.com>
 <CAMKF1srOQVRW8n9bzr9GXiA3NBOX=cE5EV-W9S_dq+JFRqNjMQ@mail.gmail.com>
In-Reply-To: <CAMKF1srOQVRW8n9bzr9GXiA3NBOX=cE5EV-W9S_dq+JFRqNjMQ@mail.gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.0.5.60]
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLaGVtIFJhaiA8cmFqLmtoZW1A
Z21haWwuY29tPg0KPiBTZW50OiBkZW4gMjIgbWFycyAyMDIwIDAwOjU5DQo+IFRvOiBQZXRlciBL
amVsbGVyc3RlZHQgPHBldGVyLmtqZWxsZXJzdGVkdEBheGlzLmNvbT4NCj4gQ2M6IGJpdGJha2Ut
ZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9yZw0KPiBTdWJqZWN0OiBSZTogW2JpdGJha2UtZGV2
ZWxdIFttYXN0ZXJdW3pldXNdW1BBVENIIDMvM10gZmV0Y2gyOiBBbGxvdw0KPiAke0FVVE9SRVZ9
IHRvIGJlIHVzZWQgd2hlbiBCQl9TUkNSRVZfUE9MSUNZIGlzICJjYWNoZSINCj4gDQo+IE9uIFNh
dCwgTWFyIDIxLCAyMDIwIGF0IDQ6NTAgUE0gUGV0ZXIgS2plbGxlcnN0ZWR0DQo+IDxwZXRlci5r
amVsbGVyc3RlZHRAYXhpcy5jb20+IHdyb3RlOg0KPiA+DQo+ID4gUmF0aGVyIHRoYW4gYmxpbmRs
eSByZXZlcnRpbmcsIGNhbuKAmXQgd2UgdXBkYXRlIHRoZSBkb2N1bWVudGF0aW9uDQo+ID4gaW5z
dGVhZD8gSWYgeW91IHVzZSAke0FVVE9SRVZ9IHlvdSBvYnZpb3VzbHkgZG8gaXQgYmVjYXVzZSB5
b3UgYWx3YXlzIHdhbnQNCj4gPiB0aGUgbGF0ZXN0IHJldmlzaW9uLg0KPiAgDQo+IEF1dG9yZXYg
KyBjbGVhciBzcmNyZXYgcG9saWN5IGlmIHlvdSB3YW50IHRoYXQNCg0KV2VsbCwgb2J2aW91c2x5
ICR7QVVUT1JFVn0gd29ya3Mgd2l0aCBCQl9TUkNSRVZfUE9MSUNZID0gImNsZWFyIi4gQnV0IA0K
QkJfU1JDUkVWX1BPTElDWSBpcyBhIGRpc3RybyBjb25maWd1cmF0aW9uIGFuZCBpdCBpcyBub3Qg
cG9zc2libGUgdG8gb3ZlcnJpZGUgDQppdCBwZXIgcmVjaXBlLiBXaGljaCBtZWFucyB0aGF0IGlm
IGl0IGlzIHNldCB0byAiY2FjaGUiLCBpdCBpcyBub3QgcG9zc2libGUgDQp0byB1c2UgJHtBVVRP
UkVWfS4gVGhpcyBpcyBub3QgZG9jdW1lbnRlZCwgYW5kIHRvIHRoZSBkZXZlbG9wZXJzIGl0IHdp
bGwgbG9vayANCmFzIGlmIGl0IGlzIHdvcmtpbmcsIHNpbmNlIGl0IGZldGNoZXMgdGhlIHZlcnkg
Zmlyc3QgdGltZSB0aGUgcmVjaXBlIGlzIGJ1aWx0Lg0KQnV0IHRoZXJlIHdpbGwgYmUgbm8gdXBk
YXRlcywgc28gaXQgaXMgYXMgdXNlZnVsIGFzIHNldHRpbmcgU1JDUkVWID0gIm1hc3RlciIgDQoo
d2hpY2ggc29tZSBvZiBvdXIgZGV2ZWxvcGVycyBhbHNvIGhhdmUgdHJpZWQgYmVmb3JlIGJlaW5n
IGVkdWNhdGVkIHRvIGhvdyANCkJpdEJha2Ugd29ya3MpLi4uDQoNCj4gPiBCZWZvcmUgdGhpcyBj
aGFuZ2UsIHVzaW5nICR7QVVUT1JFVn0gaW4gY29tYmluYXRpb24gd2l0aA0KPiA+IEJCX1NSQ1JF
Vl9QT0xJQ1kgPSAiY2FjaGUiIGRpZG7igJl0IHdvcmssIHdoaWNoIGFsc28gd2FzbuKAmXQgZG9j
dW1lbnRlZC4NCj4gDQo+IEl0IGNvdWxkIGJlIGludGVycHJldGVkIGFsc28gdGhhdCBjYWNoZSBh
bHNvIGNhY2hlcyBBVVRPUkVWcw0KPiB0aGlzIHdpbGwgYnJlYWsgZG93bnN0cmVhbSBwcm9qZWN0
cy4gSXRzIGVxdWl2YWxlbnQgb2YgQUJJIGNoYW5nZSwNCj4gdGhhdCBwZXJoYXBzIHdpbGwgZG8g
bW9yZSBoYXJtIHRoZW4gd2hhdCBpdCBmaXhlcy4NCg0KSSBmYWlsIHRvIHNlZSBob3cgaXQgd2ls
bCBicmVhayBzdHVmZiBhcyBpdCB3YXMgbm90IHBvc3NpYmxlIHRvIHVzZSAke0FVVE9SRVZ9IA0K
YmVmb3JlIGluIGEgbWVhbmluZ2Z1bCB3YXkgdG9nZXRoZXIgd2l0aCBCQl9TUkNSRVZfUE9MSUNZ
ID0gImNhY2hlIi4NCg0KPiA+IC8vUGV0ZXINCg0KLy9QZXRlcg0KDQo+ID4gRnJvbTogYml0YmFr
ZS1kZXZlbEBsaXN0cy5vcGVuZW1iZWRkZWQub3JnIDxiaXRiYWtlLQ0KPiBkZXZlbEBsaXN0cy5v
cGVuZW1iZWRkZWQub3JnPiBPbiBCZWhhbGYgT2YgS2hlbSBSYWoNCj4gPiBTZW50OiBkZW4gMjEg
bWFycyAyMDIwIDIyOjQ0DQo+ID4gVG86IGJpdGJha2UtZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVk
Lm9yZw0KPiA+IFN1YmplY3Q6IFJlOiBbYml0YmFrZS1kZXZlbF0gW21hc3Rlcl1bemV1c11bUEFU
Q0ggMy8zXSBmZXRjaDI6IEFsbG93DQo+ICR7QVVUT1JFVn0gdG8gYmUgdXNlZCB3aGVuIEJCX1NS
Q1JFVl9QT0xJQ1kgaXMgImNhY2hlIg0KPiA+DQo+ID4NCj4gPg0KPiA+IHJlbW92aW5nDQo+ID4N
Cj4gPiBpZiBkLmdldFZhcignQkJfU1JDUkVWX1BPTElDWScpICE9ICJjYWNoZSI6DQo+ID4NCj4g
PiBXaWxsIGNhdXNlIGF1dG9yZXZzIHRvIGJlIGV4Y2x1ZGVkIGZyb20gcG9saWN5IGFuZCBpdHMg
bm90IGRvY3VtZW50ZWQNCj4gPg0KPiA+IGh0dHBzOi8vd3d3LnlvY3RvcHJvamVjdC5vcmcvZG9j
cy8yLjEvYml0YmFrZS11c2VyLW1hbnVhbC9iaXRiYWtlLXVzZXItDQo+IG1hbnVhbC5odG1sI3Zh
ci1CQl9TUkNSRVZfUE9MSUNZDQo+ID4NCj4gPiBkaWQgbm90IHN0YXRlIHRoYXQgQVVUT1JFVnMg
cGx1cyBCQl9TUkNSRVZfUE9MSUNZIGJlaGF2aW9yLCB0aGlzIHBhdGNoDQo+IGlzIHJlZ3Jlc3Np
bmcgdGhlIGNhc2UNCj4gPiB3aGVyZSB3ZSByZWx5IG9uIHRoaXMgYmVoYXZpb3IgdG8gdXNlIGV4
dGVybmFsc3JjIG9uIEFVVE9SRVZlZCByZWNpcGVzLg0K
