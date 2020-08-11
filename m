Received: from NAM02-DM3-obe.outbound.protection.outlook.com (NAM02-DM3-obe.outbound.protection.outlook.com [40.107.95.68])
 by mx.groups.io with SMTP id smtpd.web12.17019.1597158339125910334
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 11 Aug 2020 08:05:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=pd1x6btF;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.95.68, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A2nwz3aAFEleEatB9aaS6dvRoMCi0KeK0wrtiK3G4RpQaqaLSw47lvPfo03OH+Pl2UrfZqW8gaXaGRtlp+rsnkg/C1ttfTuK6hyf67lWL/l+AEPVSFOEydJXA8m7d0QVOQmzJY0JchIE0d6kmQ9j+lN4v2cYIZCulkw5YEjTmPCeW8FxXy3ZsklSbORWZCj/sXhproABbeD3VkTO/Kv35Y48kVkFQo5Kfi+GjXqfshy/UhARJJaFscM3x42SILFXRV3FKbzXYAtsFHMFP+ZLYVFlunVXZWKBqKL9/LApsYFumlUeKmINHcuHrLjDoAiEN2gNEOVLwhqKHurG9PFoxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fuvf0q93oCRVrio6YQwu6M8mCbkGriX2NT0NqbtiwiY=;
 b=gis1WSnjjGrhuZjPB976hd/5f6zmGenxvBeGa+I1E0K8oAGwyDZD99q9g91CvOQ5rRB4j8UYBEaKpQsQCSzlDLHUVoh/m2+qF2quzCaKUnWflnR0uTwGcd5K3W6rN8HFZR+1JSLFM49dnwiuxqCApDIvbZsA7TwX9/nCQmXpWifk7aKOjY0JH5rZvmFG3P+6jgFwcsPSr3gY8a43YSIOGJSlWlapcAVQyT5La/uM86sg58nLT6HTk9aSBJBXSNRyc6O4ayGaXI4n2gPBrxmElM52YwX6gKdsVfYp8d66eYMm3OOdX/rOhres/zzoClnhzwnHFAmT/d0yD/FUvSBLNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fuvf0q93oCRVrio6YQwu6M8mCbkGriX2NT0NqbtiwiY=;
 b=pd1x6btFITfJTr5Sz3MViy6+AuqzUnwXvfT1tj1fP3XGADtCFKLLLQIyMr3TgYeyYyPs9F9LqkqDsrV98js1YOttZwjN1jtP/PAnJ7kdImL58Snyhp0n92BlkCFREIUrGllcWSmIb22FXJT/VqguQvwhF9qV3SQBIXcanNoR6lWlZWKXC/vJ5d1BuYoa9hla3HyKr3yFP4PiDWTTFxmQPXPMBxecGKbJPlgmCAUxjnIT0VTcRaHk8un9NQ7tdFdXCgUSu80XXMfB3esErLT19CARX+/yoTIKQGlWGv4h1xE5j8scI9JlVA7wtbt3BwhtYwWK/7270XKnnS4v5i6JtA==
Received: from SN1PR12MB2480.namprd12.prod.outlook.com (2603:10b6:802:22::21)
 by SN6PR12MB2846.namprd12.prod.outlook.com (2603:10b6:805:70::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Tue, 11 Aug
 2020 15:05:38 +0000
Received: from SN1PR12MB2480.namprd12.prod.outlook.com
 ([fe80::4c4f:2633:b1bc:c164]) by SN1PR12MB2480.namprd12.prod.outlook.com
 ([fe80::4c4f:2633:b1bc:c164%6]) with mapi id 15.20.3261.025; Tue, 11 Aug 2020
 15:05:37 +0000
From: "Chris Laplante" <chris.laplante@agilent.com>
To: "chris.laplante@agilent.com" <chris.laplante@agilent.com>, Richard Purdie
	<richard.purdie@linuxfoundation.org>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH v3 0/4] [RFC] Shell func backtracing
Thread-Topic: [bitbake-devel] [PATCH v3 0/4] [RFC] Shell func backtracing
Thread-Index: AQHWbzcYkH7KvFFdHkuPXVuGFDgKxKkx5xUAgAEZZfCAAAKMgA==
Date: Tue, 11 Aug 2020 15:05:37 +0000
Message-ID: 
 <SN1PR12MB2480FE912CC46A49637AD5DD8B450@SN1PR12MB2480.namprd12.prod.outlook.com>
References: <20200810165524.37417-1-chris.laplante@agilent.com>
 <7175d431218ff97c0c28fdaf40c89685feeb2f9f.camel@linuxfoundation.org>
 <162A3E91186A4B45.9300@lists.openembedded.org>
In-Reply-To: <162A3E91186A4B45.9300@lists.openembedded.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: agilent.com; dkim=none (message not signed)
 header.d=none;agilent.com; dmarc=none action=none header.from=agilent.com;
x-originating-ip: [76.99.179.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 46fba4c9-88c6-4d78-af66-08d83e080191
x-ms-traffictypediagnostic: SN6PR12MB2846:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <SN6PR12MB2846ECA78495CC9FFD93E1F08B450@SN6PR12MB2846.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 HsGJuMBf4xLaOSkHht9ipnagY9ZVyCQQEIier+DpquofUijwSGmt/hcn4O/w6cHlrpCUn9LHyrHbqPaEyfu2734fggL3ruumwSFTKUYdueqFRrSnspEL15idh0Hjl2zjG8EmkpS5hazSpp0nU5BFIX8j2no3tuFfHW+ZD+IC0J9EHZRE5OaSMV5f33FWSwod1t1KXbZ/QOIEmIGRaRxSdPFCgyXoYtdnJFpQjwvK+tyLGTU8I/bXkwmdqJ5qtx4s49NvcVRvFGF7rfh7JMNkWURWeSVP4fFx8hlTNj8V+lxRfRoUyRPVTzvIpJ8CpQRb93g4A/zLtu/ZWJ9sl1hahIptUn/ANT2ZTqJLJze8J/36lZdF8fsVBGf0ES7OECjl0A2gD673fBlCBKbbmijXI3uWvQD5VXKex6oxL119Gfy6rRN3Mq0B2w5B0pX5FiSpbRCNLRTChTVdMSLU/HXO5w==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2480.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(29502001)(86362001)(52536014)(8676002)(83380400001)(5660300002)(8936002)(33656002)(110136005)(9686003)(2906002)(55016002)(186003)(6506007)(66446008)(76116006)(498600001)(26005)(66946007)(7696005)(66476007)(966005)(66556008)(71200400001)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 e+v2T3cDHoHEQnHSvffl3+1UztG+TbAzvYVRdVVxZqnyGbxY+ncG8dXb9jIdTGxEts2V/Whk+csiZA4KWQ155aa0dSTUNzSsvbADttuCB9WFVJdY5H/nH86FcNfZYUxGllUpL6k+bZ3y8TY8f33L93pTTWH46+mKnb9zzQeoN3zmVFPJEtXcIptqQ74Vx49TuvAOydSYhXvBpJg169etJF40D0iKo2tHLau5VqtZu3s5jd5eLXI8lF1df3k3Q464rELMjzuP5pIMnrXpYJaM42JyEeN+8nNfoQvVDlQSNjr7jtKkmtjzG+Rh6kxRhTbcw0V+pxdka5aADMFvyHv8+og7p14oOgxwz8/Vq8WlunxSNfohU2EK46D7g1Uq4FdVfzQjrdCHqn6msfd0daeJ3OySkYDlWRSon1bUcYiWThMer6CE51sd5ti75SmLidDfog6B8lJuF+JsTtAcjTHWGfNumBAI1oVXRHH4j7LWCNytvUtpmVmsdrwC7TtekuDPbIs1d4ik02Ny3jUP++lNF4Sad4+KzOEtD8JFUFsrzrg61A9sBmSOfYgiYa9wERvjBg7Dh5X6GuKoAkTY4Gidnyq9GVm2HPAdwzDboUgzzG0NvMlZ0T8Hh+G5lBxvOmZVDBj2Pe597ygXCmAk7XU/jg==
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2480.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46fba4c9-88c6-4d78-af66-08d83e080191
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2020 15:05:37.8801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1HKQeg/pimAWWF1Xg4+9uHeAUOs1iAtCKrQScNpk+mlYbyBpOznpHILwrEXG8c1064b1iGb2vWJ2pEZh2PJgKgR+/fhhm6oVGvfTirRcf3k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2846
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

PiA+IEkgc3VzcGVjdCBidXQgaGF2ZSBub3QgcHJvdmVuIHRoYXQgdGhpcyBzZXJpZXMgcmVzdWx0
ZWQgaW4gdGhlIGZhaWx1cmVzIGluIHRoaXMNCj4gPiBidWlsZDoNCj4gPg0KPiA+IGh0dHBzOi8v
YXV0b2J1aWxkZXIueW9jdG9wcm9qZWN0Lm9yZy90eXBob29uLyMvYnVpbGRlcnMvODMvYnVpbGRz
LzEyNDcNCj4gDQo+IEkgdGhpbmsgeW91J3JlIHJpZ2h0LiBMb29rcyBsaWtlIHRoZSBFUlIgdHJh
cCBpcyBmaXJpbmcgZXZlbiBmb3IgY29tbWFuZHMgdGhhdA0KPiB3ZSBleHBlY3QgbWlnaHQgZmFp
bC4gRS5nLg0KPiANCj4gc3RlcDJiOiBXQVJOSU5HOiAvaG9tZS9wb2t5YnVpbGQveW9jdG8td29y
a2VyL2J1aWxkLQ0KPiBhcHBsaWFuY2UvYnVpbGQvYnVpbGQvdG1wL3dvcmsvcWVtdXg4Nl82NC1w
b2t5LWxpbnV4L2xpbnV4LQ0KPiB5b2N0by81LjQuNTQrZ2l0QVVUT0lOQys5Njg4M2IzOGMxXzlm
YzJmYjJlNzMtDQo+IHIwL3RlbXAvcnVuLmRvX2tlcm5lbF9jaGVja291dC4zMjgyMDU1OjE5MSBl
eGl0IDEgZnJvbSAnZ2l0IHNob3ctcmVmIC0tDQo+IHF1aWV0IC0tdmVyaWZ5IC0tICJyZWZzL2hl
YWRzLyRiIicNCj4gc3RlcDJiOiBXQVJOSU5HOiBCYWNrdHJhY2UgKEJCIGdlbmVyYXRlZCBzY3Jp
cHQpOg0KPiBzdGVwMmI6IFdBUk5JTkc6IC9ob21lL3Bva3lidWlsZC95b2N0by13b3JrZXIvYnVp
bGQtDQo+IGFwcGxpYW5jZS9idWlsZC9idWlsZC90bXAvd29yay9jb3JlMi02NC1wb2t5LWxpbnV4
L2xpYmVycm9yLXBlcmwvMC4xNzAyOS0NCj4gcjAvdGVtcC9ydW4uZG9faW5zdGFsbC42MTQwODY6
MTU3IGV4aXQgMiBmcm9tICdzZWQgLWkgLWUgJ3N8L3Vzci9iaW4vcGVybC0NCj4gbmF0aXZlLiov
cGVybHwvdXNyL2Jpbi9lbnYgbmF0aXZlcGVybHwnICRQRVJMU0NSSVBUJw0KPiBzdGVwMmI6IFdB
Uk5JTkc6IEJhY2t0cmFjZSAoQkIgZ2VuZXJhdGVkIHNjcmlwdCk6DQo+IA0KPiANCj4gSSBndWVz
cyBJJ2xsIGhhdmUgdG8gZ2V0IHJpZCBvZiB0aGUgRVJSIHRyYXAgYW5kIGp1c3QgcmVseSBvbiB0
aGUgRVhJVCB0cmFwLiBCdXQNCj4gdGhhdCBtZWFucyB3ZSB3b24ndCBhY3R1YWxseSBnZXQgdGhl
IGxpbmUgbnVtYmVyIG9uIHdoaWNoIHRoZSBhY3R1YWwNCj4gY29tbWFuZCBmYWlscywgc2luY2Ug
dGhhdCBpcyByZXNldCBmb3IgRVhJVCB0cmFwcyA6KC4NCg0KDQpPbiBzZWNvbmQgdGhvdWdodCwg
dGhlcmUgbWlnaHQgYmUgYSB3YXkgdG8gY2FwdHVyZSB0aGUgYmFja3RyYWNlIGluIHRoZSBFUlIg
dHJhY2UgYnV0IG5vdCBwcmludCBpdCB1bnRpbCB3ZSBjb21lIHRvIHRoZSBFWElUIHRyYXAuIFdp
bGwgaGF2ZSB0byBwbGF5IGFyb3VuZCB3aXRoIGl0Lg0KDQpDaHJpcyANCg==
