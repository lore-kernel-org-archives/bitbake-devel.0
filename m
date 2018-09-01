Return-Path: <abdelhakim.ais@outlook.com>
X-Greylist: delayed 28746 seconds by postgrey-1.34 at layers.openembedded.org;
	Sat, 01 Sep 2018 19:55:11 UTC
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
	(mail-oln040092066065.outbound.protection.outlook.com [40.92.66.65])
	by mail.openembedded.org (Postfix) with ESMTP id 79DC360291
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  1 Sep 2018 19:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=xLh0fQfGogQPEDA0B4ypOIpNrYP4a+fgfG2iB6XVYHg=;
	b=mC904v0rbF/n1TEhUmIiaJgdRvxup52efPL56Jg1LgfqP5xZkxdta5xKbyqFLAohUKXkL3TTHLq4XlJvJnO2A0/XGey8xAG7rgRz5m+g+Cu4iWAC/cC4931KaYqQkhvsPNraX4p13LFYRNaPPb4O4mI8UWbf6iTlNEILt+lYSaBY3jiHzVMBvJNNN3NjtiICESDCajldFeKEpmmUwBVbplUGVPbrKM2PRGosqXPVOK1s7QJayvm6dJ2m8w7+0I/VaaiD9Y7LmSvegZbSp7FIu7CPtdilTR3qQL6JZg05E29Xs8iVYUT7C+L+ZN954VY36THgHVt5riyrxiCqcqzg7Q==
Received: from VE1EUR01FT005.eop-EUR01.prod.protection.outlook.com
	(10.152.2.59) by VE1EUR01HT115.eop-EUR01.prod.protection.outlook.com
	(10.152.3.44) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.20.1101.10;
	Sat, 1 Sep 2018 11:23:12 +0000
Received: from DB6PR0701MB2646.eurprd07.prod.outlook.com (10.152.2.51) by
	VE1EUR01FT005.mail.protection.outlook.com (10.152.2.142) with Microsoft
	SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
	15.20.1101.10 via Frontend Transport; Sat, 1 Sep 2018 11:23:12 +0000
Received: from DB6PR0701MB2646.eurprd07.prod.outlook.com
	([fe80::958:f335:38d9:fab0]) by
	DB6PR0701MB2646.eurprd07.prod.outlook.com
	([fe80::958:f335:38d9:fab0%9]) with mapi id 15.20.1122.009;
	Sat, 1 Sep 2018 11:23:11 +0000
From: abdelhakim ais <abdelhakim.ais@outlook.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: recipe for pandoraFMS agent
Thread-Index: AQHUQeYqL9hldq3b7EOv39YtlMILfg==
Date: Sat, 1 Sep 2018 11:23:11 +0000
Message-ID: <DB6PR0701MB264656F995EF801C39E66BE5810E0@DB6PR0701MB2646.eurprd07.prod.outlook.com>
Accept-Language: fr-FR, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0102CA0046.eurprd01.prod.exchangelabs.com
	(2603:10a6:7:7d::23) To DB6PR0701MB2646.eurprd07.prod.outlook.com
	(2603:10a6:4:22::22)
x-incomingtopheadermarker: OriginalChecksum:5C38F0F06AA1B1342048B3619388E8C1C3A8C23B408372F4CEB9D01440C77826;
	UpperCasedChecksum:15FCB3704CF486C93828C48CEF04EB7E38BDFB0D84CCDEF25682042F18BCF027;
	SizeAsReceived:7310; Count:47
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [2Q3+wWTCshS77y7WVgpkZaZ5UVTCncmo]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VE1EUR01HT115;
	6:bw3x4JURy8R6IJV7lKRo57BBQAoHiA9X4c6lbLwmhHfcQhmP711vba05mqs3OMoXQXZ/lDNsFIgSt+xXoK/UXmqtbaW8IyjYpvoNAndrmwgrWEevAZgOMKLMwSPR94RxDv0samL870ElWrIsKQ/XSfmvUaVbE0cKgVPoMth4CCpBMQ4sB8DLkfwBBjMrPTVqngIEoM7UlKktkoiW5A23Qes7I55UpeqQjUWP/4cE3AYAcPlmhsGtjQmt9dnPNK9zsXz4qD1nsws/cWQyzIXfFfyAt7JRNaXVATFqEoIZ5IBw1vGpUNSdTBSD6GwSrsfvu2feEwvrBVhEY8mIMf7z5EHSL8YY9jqqZ7qLu2QDuAfzd8KviCfGE9+/ZsLACttZ2LBAb1C+54dmMH2EEzMApbduS4HHupBNC9X8OE5X9U97ylOVLp0vzjJtevhTOV1fw6QSxwrLIyHamBnkOIZLew==;
	5:MgIXKKPvxyiroeZHSvgdnSsdGUGp7Z9KYCDlEaBfZV7nbK0ZaFjzw9bVR502Ugw5ouADu5cOODCzv7XMHJ2Z2j2TVgNmtZVx72Rumh4/G2m8BqFgeab9SN/nfyN/xr4Hfk+Nzh5I1OHII42vwSbH0jAklsciW9uiRAQnvcaoOBg=;
	7:W0L3cIJMJ7MOcw22u5eCDpaqspzy84YE5KDIZKc5V8hyyXulR1zlyBNAqNDE9EUCMtXf/g2g0MwFtb5zKJ/En/oD4t9NMLgm6bSGfrS+tXOJstudFGT+KpNDp8wq+u+g1WCJxay/tmAjuqCGYdfy+nHn8US7y1nJqWGjq87K0vQPF4gWJpIzKtvngwfmCYncEvn4Qj/4tHJNx82eG1XW2jZacaXfEDwuseRhqrISr5nU8gv8zy+SY2omGrp4la8Y
x-incomingheadercount: 47
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031324274)(2017031323274)(2017031322404)(1603101475)(1601125500)(1701031045);
	SRVR:VE1EUR01HT115; 
x-ms-traffictypediagnostic: VE1EUR01HT115:
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0; RULEID:(4566010)(82015058);
	SRVR:VE1EUR01HT115; BCL:0; PCL:0; RULEID:; SRVR:VE1EUR01HT115; 
x-forefront-prvs: 0782EC617F
x-forefront-antispam-report: SFV:NSPM;
	SFS:(7070007)(199004)(189003)(53754006)(25786009)(81156014)(33656002)(102836004)(2351001)(68736007)(20460500001)(6436002)(55016002)(6346003)(5640700003)(8936002)(82202002)(7696005)(99286004)(3480700004)(386003)(5250100002)(87572001)(97736004)(26005)(86152003)(106356001)(6916009)(86362001)(2900100001)(486006)(5660300001)(56003)(2501003)(476003)(105586002)(256004)(14454004)(305945005)(426003)(104016004)(8676002)(74316002);
	DIR:OUT; SFP:1901; SCL:1; SRVR:VE1EUR01HT115;
	H:DB6PR0701MB2646.eurprd07.prod.outlook.com; FPR:; SPF:None;
	PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: outlook.com does not designate
	permitted sender hosts)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=abdelhakim.ais@outlook.com; 
x-microsoft-antispam-message-info: 0/NpXQqhuzV6iu7r34zg1/F1JDA3ThsHIvwhVbMONlUc5X6YyzNyefj0w3F1kft/WpwCbv9kZ6NdQw8Xn75LbU9hexBZReA8n2EoAvz3UZvGnkjRgfxufQvt9C7T1HQ2vd+lNSeKbYufauIx0TtdDUxwmSFmMRnY5uvrrc33shV6zfAjtqEYK1X+xZIfNFBDSy+AEuPM26C/6UtYoU9v0utcQtLDTaZM8zkm8Fj/ti8=
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: d4d70346-2c10-4f39-8c00-e767963926d9
X-MS-Exchange-CrossTenant-Network-Message-Id: e09942dd-8acb-4d27-1cba-08d60ffd4cfa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: d4d70346-2c10-4f39-8c00-e767963926d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2018 11:23:11.6637 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1EUR01HT115
Subject: recipe for pandoraFMS agent
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
X-List-Received-Date: Sat, 01 Sep 2018 19:55:12 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <50F087D8C5576842A2576A98248C4B6F@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64

SGVsbG8gZXZlcnlvbmUNCg0KYXQgdGhpcyBtb21lbnQgaSdtIHdvcmtpbmcgb24gcHJvamVjdCB0
byBjcmVhdGUgYSBjdXN0b20gc3lzdGVtIGZvciBteSANClJhc3BiZXJyeSBQSSBpIGdlbmVyYXRl
ZCBhIGNvcmUtaW1hZ2UtbWluaW1hbCB3aXRoIHN5c3RlbWQgbm93IGkgd291bGQgDQpsaWtlIHRv
IGludGVncmF0ZSBwYW5kb3JhRk1TIGFnZW50IHRvIG1vbml0b3IgdGhlIHJlc3NvdXJjZXMgb2Yg
dGhlIA0KcmFzcGJlcnJ5IHBpDQoNCmkgdXNlZCBwYW5kb3JhZm1zLnRhci5neiBkb253bG9hZGVk
IGZyb20gcGFuZG9yYWZtcy5vcmcNCg0KaSB0cmllZCB0aGlzIHJlY2lwZXMgYnV0IGl0IGRvZXNu
J3Qgd29yaw0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQ0KDQpMSUNFTlNFID0gIkNMT1NFRCINCkxJQ19GSUxFU19DSEtTVU0gPSAiIg0KDQpQ
QUNLQUdFX0FSQ0ggPSAiJHtNQUNISU5FX0FSQ0h9Ig0KDQojU1JDX1VSSSA9IA0KImZpbGU6Ly9o
b21lL3VzZXJzL3N5cy13b3Jrc2FwY2UvcG9reS9tZXRhLW1vbml0b3JpbmcvcmVjaXBlcy1wYW5k
b3JhZm1zL3BhbmRvcmEvZmlsZXMvcGFuZG9yYWZtcy50YXIuZ3oiIA0KDQpTUkNfVVJJID0iZmls
ZTovL3BhbmRvcmFmbXMudGFyLmd6IFwNCiDCoMKgwqDCoMKgwqDCoMKgwqAgZmlsZTovL3BhbmRv
cmFfYWdlbnRfZGFlbW9uLnNlcnZpY2UiDQoNClMgPSAiJHtXT1JLRElSfS91bml4Ig0KDQpSREVQ
RU5EU18ke1BOfSArPSAiYmFzaCBwZXJsIg0KDQoNCg0KDQpGSUxFU18ke1BOfSArPSAiL3Vzci9z
aGFyZSBcDQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC91c3IvYmluIFwNCiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgL3Zhci9sb2cgXA0KIMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAvZXRjL3N5c3RlbWQvIFwNCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgL29wdCBcDQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC90bXAgXA0KIMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiDQoNCmZha2Vyb290IGRvX2luc3RhbGwgKCkg
ew0KIMKgwqDCoMKgwqDCoMKgICMgSW5zdGFsbCBwYW5kb3JhZm1zX2FnZW50IHRvIHJvb3Rmcw0K
IMKgwqDCoMKgwqDCoMKgIC4vcGFuZG9yYV9hZ2VudF9pbnN0YWxsZXIgLS1pbnN0YWxsICR7RH0N
CiDCoMKgwqDCoMKgwqDCoCBpbnN0YWxsIC1tIDA3NTUgJHtTfS9wYW5kb3JhX2FnZW50X2RhZW1v
bi5zZXJ2aWNlIA0KJHtEfSR7c3lzY29uZmRpcn0vc3lzdGVtZC9wYW5kb3JhLw0KfQ0KDQotLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tDQoNCmkgbmVlZCB5b3VyIGhlbHAgcGxlYXNlIGNvdWxkIHNvbWVvbmUgdGVs
bCBtZSB3aGF0IGkgZGlkIHdyb25nIHRoYW5rIHlvdQ0KDQoNCg0K

