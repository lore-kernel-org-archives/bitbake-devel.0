Received: from NAM12-MW2-obe.outbound.protection.outlook.com (NAM12-MW2-obe.outbound.protection.outlook.com [40.107.244.85])
 by mx.groups.io with SMTP id smtpd.web11.27760.1605719231888493905
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 18 Nov 2020 09:07:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=h7RJtUK8;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.244.85, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zr9lmGDLKJGlX1H+hH9xR1Xy4GxcIqecnNEWGwAoU0MjFAcCu1oZ96hTU2u30wTVJfah7qyYgSG0GKWqgZ2OHO6scw9n+CgUwYHZ9ADxJvt/cpBVGRylzQ5H66st1Ss/ysCFkayBKrpVS8nHaKZQN8X2VmP2c/HgzezjMMWuq/pyWcfzbtLovNgzdAFY7VeRynlN2DbHUk9oSWCdcskcC6krkc8m9aGldegv3JonkeecCClyZe0MfZkiVwgp6igelVH3NhuzwJyA02ijeU09lQa0a9I3qdOfayQV4uZVTgXforAD91D5YI/HRHccRLyq9cmcd4JlxpoZeTSWl9mweg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzm1fv1HuvO0/PocePBlv2QgfI2TJlhPhUBSYiE9y+c=;
 b=FvF5qwn6vrGqqs4UN6ZotjN/ceCkN/UZfXD3G/k5oqoc50kBJ5ay7LNpn7xVXkeXCBq6/ChdMVfzg9qJC64kNf4EMfmlqlOjVkT9kypBfqwu18qUkNf1A2x/so/WY3dTajbB9NFzu5LlUtf02xdZaXQNQh1hir71b14qCD5YVyaH4OmW5YtB/1XWMIJbJ77KdTwSIWJa+rZPACsrgBvPu8UcV7ABFUXwhztR1lLLEvIYcxDMVDi2x1gy8MpIPJeUquV8UexhZdkBHhu508lc6g0kerJfq8mNNfAGL8sWracEU2cQwF245OuQUOG0Pn5S0azbYEFJb3mRr7XyTbR9qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzm1fv1HuvO0/PocePBlv2QgfI2TJlhPhUBSYiE9y+c=;
 b=h7RJtUK8Vs/qA8ko8Ir0KfgXA74wcoq0IOE2rkI+3zjJzcvLIClej/ekk4gejmpMm7V42Jsaf2IuzLcRlfMPu45ITz7pcs73kFo8EPe5TJbw8PinjJZ4rKhqYTOFEDc0IfEhzoUESFBR4VwWuhQa7/isgedb9GCNHDeOYUSzSOJH+EL0NQNOjf88PX+9oUrevWV86kQBtp2jVF42X6EEZk/gHp9dcpWZ0t90BpBX96TtQ71/xHvYKmPtojHMLH9CavBRF2ws8NcbByWDyEIpe74JSaAfg/ioCk/D+XiL3E/+lB5FK4oYQRj50tZskriNHR0rMgX1yRKtzYuleVvZig==
Received: from SN1PR12MB2480.namprd12.prod.outlook.com (2603:10b6:802:22::21)
 by SA0PR12MB4381.namprd12.prod.outlook.com (2603:10b6:806:70::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Wed, 18 Nov
 2020 17:07:10 +0000
Received: from SN1PR12MB2480.namprd12.prod.outlook.com
 ([fe80::5dc7:be80:e39f:5be1]) by SN1PR12MB2480.namprd12.prod.outlook.com
 ([fe80::5dc7:be80:e39f:5be1%3]) with mapi id 15.20.3589.022; Wed, 18 Nov 2020
 17:07:09 +0000
From: "Chris Laplante" <chris.laplante@agilent.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH v3 00/10] optparse => argparse
Thread-Topic: [bitbake-devel] [PATCH v3 00/10] optparse => argparse
Thread-Index: AQHWthw4kN7CZJaZ2EupBAhsiadueqnB540AgAw8oTCAAAPkAIAAAXzw
Date: Wed, 18 Nov 2020 17:07:09 +0000
Message-ID: 
 <SN1PR12MB24809AE9781F70F9F4ADBCCD8BE10@SN1PR12MB2480.namprd12.prod.outlook.com>
References: <20201108221059.16854-1-chris.laplante@agilent.com>
	 <79ada9503eb003e81ec3f90836837cccc787f836.camel@linuxfoundation.org>
	 <SN1PR12MB248066D339FDC42D95EB16218BE10@SN1PR12MB2480.namprd12.prod.outlook.com>
 <710819fcc1b29838ea7d2f2b332fdd44495219c7.camel@linuxfoundation.org>
In-Reply-To: 
 <710819fcc1b29838ea7d2f2b332fdd44495219c7.camel@linuxfoundation.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=agilent.com;
x-originating-ip: [76.99.179.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c8c8a92-caf7-4d87-f6bc-08d88be462b9
x-ms-traffictypediagnostic: SA0PR12MB4381:
x-microsoft-antispam-prvs: 
 <SA0PR12MB4381492749E6E8858CC552D08BE10@SA0PR12MB4381.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 crdWK2zb/WTrY+K56CDJRGAMX6l2m2sxfgqbIwBX3p0clqts6mJiflQd89gpVL3YTmDRiEWsvrUnElN8As3DuWA3GjSVn5qQoigMvKz9gBk8MSJDB3oD/QnGhk/Tmoz6C4zPidGDEnxya83Mb6gPAjf1DnnngczMyXXWCTTohgSXe6WYYiaxjGO5lQ7pUwI7xtr/jWjZMZLb9sCV4euOc38Q79TyoHP42VH21+J0VD2pN+JxzthylhJFm5SmW0uPOOdl6nOi/egEu/vNdIHBzxa1AFzUT47V+icrN+kXZzs0Ua5IeNQNx7BnSWg2BqUNxWM51ERhbqf1tyXIFgVqvK9M2t6SUzHIVRzqeYqfg79GxL+66nTOcRyTPIlgumBg
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2480.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(396003)(366004)(39860400002)(29502001)(316002)(8936002)(6916009)(33656002)(83380400001)(7696005)(4326008)(52536014)(5660300002)(76116006)(66946007)(66476007)(6506007)(66446008)(66556008)(64756008)(8676002)(26005)(86362001)(2906002)(9686003)(55016002)(71200400001)(478600001)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 qZOEb3FEP9IOzN/W6rZ/WfQ21OnD9I9hb0MmOzCC/gQXELvI529CQ29hcPUKQfTD0PmkrH4MlKwTUxZ0aah6nmFQWB0VL7IzOqg32uqTx/2YQ2RYFywGF9Eo2ZF7+IhR+jh7ht34N1iHaOfeDvVE+Rh2oOtZ1KFoy3QL/MDBMLGMUGIfZaVkXs+XEkw44Q1RGnTK/PjBVrpK7P26MIDYJix9lKkTACRDE1qplhx2jufbLlvASyEMGl4pq4RqVrp5GybopSn3O6WPf6SDktVufFWVUtdsvAhxm1Rw5q0GfppPn1yiRpu2evIs6fBwwYzfnHz1UjX7PeqEWRBRAaYvX+2IQ9DhiPNTmNM1WaIisUGIeUc1+mXIbMlFkTC1p7LO+iT4TjsmZSPT9Z2Vjn+ECRnlGnQ2m58mp84RB+PGsAmHg4TNm4Aa+hZVlLGXp+d1gZvwLNEORejO4F6X/6calcxH6VOZRswB3EqzX/km/dJPkQ3XRMCAwrQ223E4Io2AFZd3UOeE9ebYoPBoI9HCM9/bD0duCTHOzlNo3+HygHfsImB5w+TRB85eLXYshMt/QAX+dUQLfyhDLuYQkHiZ8syhaejythkxg/TRxVSUS/T/OedjoTA4EHP01RNxEEKB8dKqInGI/qZgFySzKegQqE6fjACP5GRcN2ukjppa8f2nHMuIfalOxcVmgvHTAkoISpN9RFN2MKzr7I1fVAoTj7nQdudhqP3QxdVwyKk305QdykXFOpdEEZvkfOAoezPM+m+Q0S2XTueB866yAKaWtNQ6Xj0P77+5cl7CFIxo20/FzMtV4d1RrkMTatODeYv2dqY/8wG8mfK3z4D2LVxOqj78uBUUqF+ROFYIpXBc38hLh5UYB35RFapycdeSJdcqGgPhhik5N4AyaTWzBAF8MA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2480.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c8c8a92-caf7-4d87-f6bc-08d88be462b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2020 17:07:09.7184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sf4Blo9n6rfOqVaDhMWerBG2lj4DwFGooQ4CSf2L7EcdRMwPqmXJ70XcDSw78rbRLsb4u8yFGCRxGdKIsn315RkMboflU2ZIonC8UaDtBd0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4381
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

PiA+IENhbiB5b3UgcGxlYXNlIHRlbGwgbWUgc3BlY2lmaWNhbGx5IGhvdyB0aGUgcGF0Y2hlcyBJ
J20gc2VuZGluZyBhcmUNCj4gPiBnZXR0aW5nIG1hbmdsZWQ/IEknbSBoYXZpbmcgdHJvdWJsZSBm
aW5kaW5nIGluZm9ybWF0aW9uIG9ubGluZSBhYm91dA0KPiA+IGhvdyBJIG1heSBmaXggdGhpcy4N
Cj4gPg0KPiA+IEkgYWxzbyBjYW4ndCBmaW5kIGFuIGF1dG9tYXRlZCB3YXkgb2YgYWRkaW5nICdG
cm9tOiAnIGxpbmVzIHRvIHRoZQ0KPiA+IGVtYWlscyBwcm9kdWNlZCBieSBnaXQgc2VuZC1lbWFp
bC4NCj4gDQo+IGdyb3Vwcy5pbyAod2hlcmUgdGhlIGxpc3QgaXMgaG9zdGVkKSBpcyByZXdyaXRp
bmcgeW91ciBlbWFpbCBhZGRyZXNzIHNpbmNlIHlvdXINCj4gZG9tYWluIGRvZXMgbm90IGFsbG93
IGl0IHRvIHNlbmQgb3V0IG1lc3NhZ2VzICdwcmV0ZW5kaW5nJw0KPiB0byBiZSA8c29tZXRoaW5n
PkBhZ2lsZW50LmNvbS4gVGhpcyBpcyBhIGdlbmVyYWwgcHJvYmxlbSBtYWlsaW5nIGxpc3RzIGhh
dmUNCj4gd2l0aCBpbmNyZWFzZWQgc3BhbSBwcm90ZWN0aW9ucyB0aGF0IGFyZSBub3cgaW4gcGxh
Y2UuIFRoZSByZXdyaXR0ZW4gdmVyc2lvbg0KPiBpcyAiQ2hyaXMgTGFwbGFudGUgdmlhIGxpc3Rz
Lm9wZW5lbWJlZGRlZC5vcmcNCj4gPGNocmlzLmxhcGxhbnRlPWFnaWxlbnQuY29tQGxpc3RzLm9w
ZW5lbWJlZGRlZC5vcmc+IiB3aGljaCB3b3JrcyBhcyB3ZQ0KPiBhbGxvdyBncm91cHMuaW8gdG8g
c2VudCBmcm9tIGxpc3RzLm9wZW5lbWJlZGRlZC5vcmcuDQo+IA0KPiBJZiB5b3UgY2FuIGluZmx1
ZW5jZSB0aGUgRE5TL1NQRiBmb3IgYWdpbGVudC5jb20sIHlvdSBjYW4gcHJvYmFibHkgaW1wcm92
ZQ0KPiB0aGluZ3Mgb3RoZXJ3aXNlIHdlJ3JlIGludG8gd29ya2Fyb3VuZCB0ZXJyaXRvcnkgb24g
b25lIGVuZCBvciB0aGUgb3RoZXIuDQo+IA0KPiBJIGNhbiBoYW5kbGUgaXQgd29yc3QgY2FzZSwg
SSBwcm9iYWJseSBqdXN0IG5lZWQgdG8gaW5jcmVhc2UgdGhlIGF1dG9tYXRpb24gb2YNCj4gbXkg
cGF0Y2ggaGFuZGxpbmcgYW5kIHNvbWUgYnJ1dGUgZm9yY2Ugc2VkIGhhY2tlcnkuLi4NCg0KVW5m
b3J0dW5hdGVseSBJIGRvdWJ0IEkgY2FuIGRvIGFueXRoaW5nIGFib3V0IHRoZSBETlMvU1BGOigN
Cg0KSSdkIHJhdGhlciBhdm9pZCB5b3UgbmVlZGluZyB0byBtYWtlIGNoYW5nZXMgdG8geW91ciBz
Y3JpcHRpbmcganVzdCB0byBkZWFsIHdpdGggbXkgcGF0Y2hlcywgc28gSSdsbCBtYWtlIHN1cmUg
dG8gc2V0IHRoZSAnRnJvbTogJyBoZWFkZXIuIEknbSBnb2luZyB0byBzdWJtaXQgYSBwYXRjaCBz
b29uIGFzIGEga2luZCBvZiB0ZXN0IHRvIHNlZSBpZiBpdCB3b3JrcyAodGhvdWdoIGl0IGlzIGFu
IGFjdHVhbCBwYXRjaCBmb3IgYW4gaXNzdWUgSSBmb3VuZCwgc2VwYXJhdGUgZnJvbSBhbGwgdGhl
IGFyZ3BhcnNlIHN0dWZmKS4NCg0KTi5CLjogSSByZWFsbHkgd2lzaCBnaXQgaGFkIGEgaG9vayB0
aGF0IHJ1bnMgYXQgJ3NlbmQtZW1haWwnIHRpbWUuIEFzIEkgdW5kZXJzdGFuZCBpdCwgdGhhdCB3
b3VsZCBiZSB0aGUgY29ycmVjdCBwbGFjZSB0byBhdXRvbWF0aWNhbGx5IHByZWZpeCB0aGUgbWVz
c2FnZSBib2R5IHdpdGggdGhlICdGcm9tOiAnIGhlYWRlci4gSSB0cmllZCB1c2luZyAncHJlcGFy
ZS1jb21taXQtbXNnJyB0byBwcmVmaXggdGhlIGVudGlyZSBjb21taXQgbWVzc2FnZSB3aXRoICdG
cm9tOiAnIGJ1dCB0aGF0IGRpcnRpZXMgdGhlIGxvZyBhbmQgYnJlYWtzICdnaXQgbG9nIC0tb25l
bGluZScuIE1heWJlIEknbSBtaXNzaW5nIHNvbWV0aGluZyBidXQgSSBqdXN0IGRvbid0IHNlZSBh
IHdheSB0byBkbyB0aGlzIGF1dG9tYXRpY2FsbHkgd2l0aG91dCB3cml0aW5nIGEgd3JhcHBlciBz
Y3JpcHQgYXJvdW5kIHNlbmQtZW1haWwsIHdoaWNoIEknbGwgcHJvYmFibHkgZW5kIHVwIGRvaW5n
Lg0KDQpUaGFua3MsDQpDaHJpcw0K
