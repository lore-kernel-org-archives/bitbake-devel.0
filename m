Received: from mx4.leapfrog.com ([63.114.26.254])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dlazzari@leapfrog.com>) id 1SKyyy-0002Aj-8i
	for bitbake-devel@lists.openembedded.org;
	Thu, 19 Apr 2012 23:33:40 +0200
Received: from mx4.leapfrog.com (localhost [127.0.0.1])
	by localhost.leapfrog.com (Postfix) with ESMTP
	id A9A085EA9; Thu, 19 Apr 2012 14:23:54 -0700 (PDT)
Received: from NAEXCHHT01.na.leapfrog.com (unknown [10.15.6.13])
	by mx4.leapfrog.com (Postfix) with ESMTP
	id 94ED65E99; Thu, 19 Apr 2012 14:23:54 -0700 (PDT)
Received: from NAEMCASHT02.na.leapfrog.com (10.12.2.36) by
	NAEXCHHT01.na.leapfrog.com (10.15.6.13) with Microsoft SMTP Server
	(TLS) id 8.2.254.0; Thu, 19 Apr 2012 14:24:09 -0700
Received: from NAEMMAIL01.na.leapfrog.com ([fe80::252e:28a6:3d8f:6991]) by
	NAEMCASHT02.na.leapfrog.com ([::1]) with mapi id 14.01.0355.002;
	Thu, 19 Apr 2012 14:24:08 -0700
From: Daniel Lazzari <dlazzari@leapfrog.com>
To: 'Chris Larson' <kergoth@gmail.com>
Thread-Topic: [bitbake-devel] python function used in variable expansion
	called multiple times per recipe
Thread-Index: Ac0dqUJmIcsujxmfQlyaUhmEaDraqQASVj+AAA3ZuJD//5rzAP//C9LQ
Date: Thu, 19 Apr 2012 21:24:08 +0000
Message-ID: <E7A9054A5ACABE48B0E540E46E862B0F0427CB32@NAEMMAIL01.na.leapfrog.com>
References: <E7A9054A5ACABE48B0E540E46E862B0F0427C336@NAEMMAIL01.na.leapfrog.com>
	<671D7BD596E04EE1961D6EA1C734C816@gmail.com>
	<E7A9054A5ACABE48B0E540E46E862B0F0427C5FA@NAEMMAIL01.na.leapfrog.com>
	<CABcZANn_xWLbxJRPK68Eu9iLjp6jjxkefPhe61UAcxzu91ZHwA@mail.gmail.com>
In-Reply-To: <CABcZANn_xWLbxJRPK68Eu9iLjp6jjxkefPhe61UAcxzu91ZHwA@mail.gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.100.2.5]
MIME-Version: 1.0
Cc: "'bitbake-devel@lists.openembedded.org'
	\(bitbake-devel@lists.openembedded.org\)"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: python function used in variable expansion called multiple times per recipe
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 19 Apr 2012 21:33:41 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

Pj4gSSB0aGluayBpbW1lZGlhdGUgZXhwYW5zaW9uIGlzIHdoYXQgSeKAmWxsIG5lZWQgdG8gdXNl
LCB0aGFua3MgZm9yIHRoZSB0aXAuDQo+PiBUaGF0IGF0IGxlYXN0IGJyaW5ncyB0aGUgaW52b2Nh
dGlvbiBkb3duIHRvIG9uY2UgcGVyIHJ1bi4gVW5mb3J0dW5hdGVseSwgdGhlDQo+PiB2YXJpYWJs
ZSBkb2VzbuKAmXQgc2VlbSB0byBnZXQgZmlsbGVkIGluIHdoZW4gSSBjaGFuZ2UgdG8gaW1tZWRp
YXRlDQo+ZXhwYW5zaW9uLg0KPj4NCj4+IGRlZiB0ZXN0RnVuYyhiYiwgZCk6DQo+PiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcHJpbnQoIGJiLmRhdGEuZ2V0VmFyKCJQTiIsIGQsIFRy
dWUpICkNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gImUxIg0KPj4N
Cj4+IEVYVEVSTlBWIDo9ICIke0B0ZXN0RnVuYyhiYiwgZCl9Ig0KPj4NCj4+IE5vdyBvbmx5IHBy
aW50cyB0aGUgcGFja2FnZSBuYW1lIG9uY2UsIGJ1dCB1c2luZyDigJNlLCBJIGRvbuKAmXQgc2Vl
IHRoZQ0KPj4gdmFyaWFibGUgRVhURVJOUFYgYXQgYWxsLg0KPg0KPkRvbid0IGtub3cgd2hhdCB0
byB0ZWxsIHlvdS4gSXQgZG9lcyB3b3JrLCBzbyBpdCdzIHNvbWV0aGluZyB3cm9uZyBvbg0KPnlv
dXIgZW5kLiBFaXRoZXIgaXQncyByZXR1cm5pbmcgYW4gZW1wdHkgc3RyaW5nLCB3aGljaCB3aWxs
IHJlc3VsdCBpbg0KPi1lIG9ubHkgc2hvd2luZyB0aGUgY29tbWVudGVkIG91dCBkZWZpbml0aW9u
LCBvciBpdCdzIHJhaXNpbmcgYW4NCj5leGNlcHRpb24sIG9yIHNvbWV0aGluZyBlbHNlIGluIHlv
dXIgc2V0dXAuIEFzaWRlOiB5b3UgZG9uJ3QgbmVlZCB0bw0KPnBhc3MgJ2JiJyBpbi4gVGhhdCBu
YW1lc3BhY2UgaXMgYWx3YXlzIGFjY2Vzc2libGUsIGV2ZW4gZnJvbSBkZWYnZA0KPnB5dGhvbiBm
dW5jdGlvbnMuDQo+LS0NCj5DaHJpc3RvcGhlciBMYXJzb24NCg0KSnVzdCB0aG91Z2h0IEknZCBw
cm92aWRlIGFuIHVwZGF0ZSByZWFsIHF1aWNrIG9uIHRoaXMuIEkgZGlzY292ZXJlZCwgdG8gbXkg
ZGlzbWF5LCB0aGF0IGV2ZW4gZG9pbmcgYW4gaW1tZWRpYXRlIGV4cGFuc2lvbiBzdGlsbCByYW4g
dGhlIGNvZGUgYmVmb3JlIGV2ZXJ5IHRhc2sgZm9yIHRoYXQgcmVjaXBlLiBJIHN3aXRjaGVkIHRv
IHVzaW5nIGFuIGV2ZW50IGhhbmRsZXIsIGJ1dCB0aGUgUmVjaXBlUGFyc2VkIGV2ZW50IG9jY3Vy
cyBiZWZvcmUgZXZlcnkgdGFzayBmb3IgdGhhdCByZWNpcGUuIEV2ZW50dWFsbHkgSSBkaXNjb3Zl
cmVkIHRoYXQgdGhlIHZhcmlhYmxlIEJCX1dPUktFUkNPTlRFWFQgaXMgc2V0IGZvciBSZWNpcGVQ
YXJzZWQgZXZlbnRzIHdoZW4gdGhleSBhcmUgb2NjdXJyaW5nIGJlZm9yZSBhIHRhc2ssIGJ1dCBu
b3QgZm9yIHRoZSBpbml0aWFsIHBhcnNlLiBBbHNvLCBJIGRpc2NvdmVyZWQgdGhhdCBzZXR0aW5n
IGEgdmFyaWFibGUgaW4gdGhlIGV2ZW50IGhhbmRsZXIgd291bGQgbm90IG5lY2Vzc2FyaWx5IGtl
ZXAgaXQgc2V0IHRocm91Z2ggYnVpbGRpbmcgdGhlIHJlY2lwZS4gVGh1cyBJIGRldmlzZWQgdGhl
IGJlbG93IGNvZGUgdG8gcnVuIHRoZSB0aW1lIGludGVuc2l2ZSBjb2RlIGR1cmluZyBpbml0aWFs
IHBhcnNlIGFuZCBjYWNoZSB0aGUgdmFsdWUgaW4gYSBmaWxlIHNvIGl0IGNhbiBiZSBwaWNrZWQg
dXAgYWdhaW4gaW4gbGF0ZXIgZXZlbnRzLiBJJ20gbGVhdmluZyB0aGlzIGhlcmUgaW4gY2FzZSBp
dCBoZWxwcyBzb21lb25lIGVsc2UuDQoNCmFkZGhhbmRsZXIgc3ZuX2V4dGVybl9ldmVudGhhbmRs
ZXINCnB5dGhvbiBzdm5fZXh0ZXJuX2V2ZW50aGFuZGxlcigpIHsNCglmcm9tIGJiLmV2ZW50IGlt
cG9ydCBnZXROYW1lDQoJZnJvbSBiYiBpbXBvcnQgZGF0YQ0KCQ0KCWlmIGdldE5hbWUoZSkgPT0g
IlJlY2lwZVBhcnNlZCI6DQoJCWV4dGVybl9jYWNoZV9kaXIgPSBvcy5wYXRoLmpvaW4oIGRhdGEu
Z2V0VmFyKCdUTVBESVInLCBlLmRhdGEsIFRydWUpLA0KCQkgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICdzdGFtcHMnLA0KCQkgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRhdGEuZ2V0
VmFyKCdNVUxUSU1BQ0hfVEFSR0VUX1NZUycsIGUuZGF0YSwgVHJ1ZSkgKQ0KCQlleHRlcm5fY2Fj
aGUgPSBvcy5wYXRoLmpvaW4oIGV4dGVybl9jYWNoZV9kaXIsDQoJCSAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgZGF0YS5nZXRWYXIoJ1BOJywgZS5kYXRhLCBUcnVlKSArICcuZXh0ZXJuX2Nh
Y2hlJyApDQoJCSNJZiBCQl9XT1JLRVJDT05URVhUIGlzICIxIiwgdGhpcyBpcyBOT1QgdGhlIGlu
aXRpYWwgcmVjaXBlIHBhcnNlDQoJCWlmIGRhdGEuZ2V0VmFyKCdCQl9XT1JLRVJDT05URVhUJywg
ZS5kYXRhLCBUcnVlKSA9PSAiMSI6DQoJCQkjUHVsbCBjYWNoZWQgY29weQ0KCQkJdHJ5Og0KCQkJ
CWNhY2hlX2ZpbGUgPSBvcGVuKGV4dGVybl9jYWNoZSwgJ3InKQ0KCQkJCWV4dGVybnB2ID0gY2Fj
aGVfZmlsZS5yZWFkKCkNCgkJCQljYWNoZV9maWxlLmNsb3NlKCkNCgkJCWV4Y2VwdCBJT0Vycm9y
Og0KCQkJCSNGYWlsZWQgdG8gZ2V0IGNhY2hlZCBjb3B5LCBkbyBpdCB0aGUgaGFyZCB3YXkNCgkJ
CQlleHRlcm5wdiA9IGdldEV4dGVyblJldnMoZS5kYXRhKQ0KCQllbHNlOg0KCQkJZXh0ZXJucHYg
PSBnZXRFeHRlcm5SZXZzKGUuZGF0YSkNCgkJCXRyeToNCgkJCQlvcy5tYWtlZGlycyhleHRlcm5f
Y2FjaGVfZGlyKQ0KCQkJZXhjZXB0IE9TRXJyb3I6DQoJCQkJcGFzcw0KCQkJI0dlbmVyYXRlIHRo
ZSBjYWNoZSBmb3IgbGF0ZXIgdXNlDQoJCQljYWNoZV9maWxlID0gb3BlbihleHRlcm5fY2FjaGUs
ICd3JykNCgkJCWNhY2hlX2ZpbGUud3JpdGUoZXh0ZXJucHYpDQoJCQljYWNoZV9maWxlLmNsb3Nl
KCkNCg0KCQlkYXRhLnNldFZhcignRVhURVJOUFYnLCBleHRlcm5wdiwgZS5kYXRhKQ0KfQ0KDQo=


