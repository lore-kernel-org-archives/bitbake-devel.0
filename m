Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.116])
 by mx.groups.io with SMTP id smtpd.web10.35434.1601905332657112962
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 05 Oct 2020 06:42:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@klsmartin.com header.s=selector1 header.b=0bd3bl/H;
 spf=pass (domain: klsmartin.com, ip: 40.107.20.116, mailfrom: leif.middelschulte@klsmartin.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dUrGusjkFeHdD2E9/Gs5c1eXlD++wR/2e60HGu/OBEMB98P4Rx32ArojWFX53vhgfTm/7oD1JVxkkK6GKycN1UOaQQT6oSEnhTeyvAxDVuyMOcDkwK9QoQZDvdsCIcb5N6EdMvuSXGNZXT22bZg8ZuY6hE3oG38FhbAPdBatnU86WSU1wkltgkdnawGBvsVM1LUnaTKoWOS1wtZlG4fLTuEHHxjn2oMXxtxWCJLg5G9x4eeZgD+n7AUzOleT4nfcWvuY8bllPmBBfTmSMIF7OmzYDYAlT8S9f0XFE3o6cI48+yJyaCKKwBPS8dLk6MwE8DUId6+ZJQx3ytFiA5N09A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pcqChY0Z0+D5goO3lcY+g3ZykY/QMC5CNy60Z7JDNBw=;
 b=Gxjmj0eFBGLUmqA21holypHFqWRjxX8xG/Sb96wJv8WiWJgv9IdmccDt0s/FQYC0S7sJHeVZ8mmkArwrfHnqbDej6EivsY4iUhxae5sdjike7imHpeYawJzdxunOI1FK01lfdZaEzF43bPsHF2ka9pSENPPstcG8TymdCSM7FEgq8v7ZB8zXqiS1dAkV4dikuI9eafki6Ru/Bduch2S6+d2y6bThT7W8KU2qlT+WuWVdrbnEugKtOYaPapuuhTaoM0hh/6lwnOajAyBroIkzynJKAJxMYAZg3vpGrNz/323Pg1g/6GDpUHiVXiUu+rZ7MKAv7M+bm/Xoukb2OH75ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 212.211.189.60) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=klsmartin.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=klsmartin.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=klsmartin.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pcqChY0Z0+D5goO3lcY+g3ZykY/QMC5CNy60Z7JDNBw=;
 b=0bd3bl/HQadudlWhTxebtmiDADgA90/bYECO1rjXLQ3QH7b2xzunVhvLQ8w9bqG+E0j/CgDF0Z9bG0ew4rXy0tN2m2vhuW2c5TwHqUTxclla8+UTRgV4nfRIf5USnbzYa9TyjdywlNRHKwFyq3nfYTo1PhvIWiEvKgX9Pzso85vkobpjPLq+eTxv+GGAYdJkdzIsSynjlm81ige0FzZfTjdnZUZ+S0EhnWF8GQlMvfE1C/1CJ+qZk9pFFH2RjsD1PNRSfQBj29zJirIOgDNVcSfW0f+aYuO8sDYQHLsxpp+xi3+F54FkjT/qPywmJ3sjjiZqbOtiknZ1VcSw+VRJJQ==
Received: from AM6PR0502CA0048.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::25) by AM4PR0202MB2772.eurprd02.prod.outlook.com
 (2603:10a6:200:95::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35; Mon, 5 Oct
 2020 13:42:09 +0000
Received: from HE1EUR01FT004.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:56:cafe::8b) by AM6PR0502CA0048.outlook.office365.com
 (2603:10a6:20b:56::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32 via Frontend
 Transport; Mon, 5 Oct 2020 13:42:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 212.211.189.60)
 smtp.mailfrom=klsmartin.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=klsmartin.com;
Received-SPF: Pass (protection.outlook.com: domain of klsmartin.com designates
 212.211.189.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=212.211.189.60; helo=mail.klsmartin.com;
Received: from mail.klsmartin.com (212.211.189.60) by
 HE1EUR01FT004.mail.protection.outlook.com (10.152.1.233) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3433.34 via Frontend Transport; Mon, 5 Oct 2020 13:42:09 +0000
Received: from SKLSExchange02.KLS.zentral (172.20.10.200) by
 SKLSExchange02.KLS.zentral (172.20.10.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 5 Oct 2020 15:42:08 +0200
Received: from ELARA.TUT.KLS.zentral (172.20.10.63) by
 SKLSExchange02.KLS.zentral (172.20.10.200) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.1.1913.5
 via Frontend Transport; Mon, 5 Oct 2020 15:42:08 +0200
Received: from SUMMAIL01.UMK.KLS.zentral (172.25.1.63) by
 ELARA.TUT.KLS.zentral (172.20.10.63) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 5 Oct 2020 15:42:08 +0200
Received: from SUMMBX01.UMK.KLS.zentral ([172.25.1.64]) by
 SUMMAIL01.UMK.KLS.zentral ([172.25.1.63]) with mapi id 14.03.0439.000; Mon, 5
 Oct 2020 15:42:07 +0200
From: "Leif Middelschulte" <leif.middelschulte@klsmartin.com>
To: "enrico.scholz@sigma-chemnitz.de" <enrico.scholz@sigma-chemnitz.de>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH v2 1/2] fetch2: fix handling of `\` in file:// SRC_URI
Thread-Topic: [bitbake-devel] [PATCH v2 1/2] fetch2: fix handling of `\` in
 file:// SRC_URI
Thread-Index: AQHWmxumecFo47c7YkO40MgpiuFlYKmI4uIA
Date: Mon, 5 Oct 2020 13:42:06 +0000
Message-ID: <3c1dfb2c2535dcb98bd82a6c1405a1d378b79270.camel@klsmartin.com>
References: <ed36fb9b7d921afaeee3f83e84d2a521e028dc09.camel@linuxfoundation.org>
	 <20200923161832.235619-1-leif.middelschulte@klsmartin.com>
	 <lyd01wby2e.fsf@ensc-virt.intern.sigma-chemnitz.de>
In-Reply-To: <lyd01wby2e.fsf@ensc-virt.intern.sigma-chemnitz.de>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.70.144]
x-kse-serverinfo: SUMMAIL01.UMK.KLS.zentral, 9
x-kse-attachmentfiltering-interceptor-info: protection disabled
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 05.10.2020 09:21:00
MIME-Version: 1.0
Return-Path: Leif.Middelschulte@klsmartin.com
X-CI-MailPolicy-Key: 183304ce745f36a9851e95013599c90f;c8800ece-093a-4b24-8bec-819fb7c16370;ELARA
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47cdfa67-73ed-451b-74f5-08d8693474fa
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2772:
X-Microsoft-Antispam-PRVS: 
	<AM4PR0202MB27729DB9BCCE7807DAC86360990C0@AM4PR0202MB2772.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	z50et8PKSWreZIbpY8UnHowDS/ztt+/nKNCZ2oc4jvt9aDYfzlkVtVM1MWQ84yBCkELK7gJTvJZPD9Te8oAO/Kx0gC6oFn2t2ekV3evudw90Y+Q8ieWrjsw1fffpttWefN59aCsm751R5rinywpQ2njrp5KGE4b7+M/HaNsAnG9b1FScIETahz5+oIEanosfx5R0aZYpPSA6SYhGWlBplH0e5GypV2c/2lT6yjmJTq7hf9IJDfq0SSP7WiAT4tmj6Ytu9EOm6KWn1Ma2coCRQrfiKnz7ictoCPxjW4Pv2K19XP+ADTAyl0DCxoiRtv8Gun3CMPu/i+boGBBIwHqCXznVNJokaj3ur1AXKuXoRGpUGCnAQtfEVAaxWSExlJhuUhS3i5DX9NEO9S7E5DAi2uFtnip+RsRhTuF49516GG5rNDWauGlkhvBY5ntCKDQfQnJFojznG5zcqk9ZZdp6zBBlyr1TebqKklByeQtoiacHSSj7iMUGCHGj12JwgRTB
X-Forefront-Antispam-Report: 
	CIP:212.211.189.60;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.klsmartin.com;PTR:asav10-372.outside.spxs.net;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(39850400004)(346002)(46966005)(83380400001)(478600001)(186003)(8936002)(36756003)(26005)(6916009)(81166007)(83080400001)(966005)(8676002)(86362001)(356005)(2906002)(4326008)(70206006)(70586007)(316002)(336012)(36906005)(82310400003)(33310700002)(5660300002)(2616005)(47076004)(82740400003);DIR:OUT;SFP:1102;
X-OriginatorOrg: klsmartin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2020 13:42:09.3772
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47cdfa67-73ed-451b-74f5-08d8693474fa
X-MS-Exchange-CrossTenant-Id: 9d29fdbf-9c75-430e-86f5-ebe1ff5a5223
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9d29fdbf-9c75-430e-86f5-ebe1ff5a5223;Ip=[212.211.189.60];Helo=[mail.klsmartin.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT004.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2772
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-ID: <D7C1B08FF3510849BC1CB582909308AE@KLS.zentral>
Content-Transfer-Encoding: base64

QW0gTW9udGFnLCBkZW4gMDUuMTAuMjAyMCwgMTU6MjkgKzAyMDAgc2NocmllYiBFbnJpY28gU2No
b2x6Og0KPiBDQVVUSU9OOiBUaGlzIG1lc3NhZ2Ugd2FzIHNlbnQgZnJvbSBvdXRzaWRlIG9mIEtM
UyBNYXJ0aW4uIFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1
bmxlc3MgeW91IHJlY29nbml6ZSB0aGUgc291cmNlIG9mIHRoaXMgZW1haWwgYW5kIGtub3cgdGhl
IGNvbnRlbnQgaXMgc2FmZS4NCj4gDQo+ICJMZWlmIE1pZGRlbHNjaHVsdGUiIDwNCj4gbGVpZi5t
aWRkZWxzY2h1bHRlQGtsc21hcnRpbi5jb20NCj4gPiB3cml0ZXM6DQo+IA0KPiA+IC0gICAgICAg
ICAgICAgICAgY21kID0gJ2NwIC1mcFBSSCAlcyAlcycgJSAoZmlsZSwgZGVzdGRpcikNCj4gPiAr
ICAgICAgICAgICAgICAgICMgZG8gbm90IHJlbHkgb24gU2hlbGwncyBnbG9iIGV4cGFuc2lvbi4N
Cj4gPiArICAgICAgICAgICAgICAgIGZpbGUgPSAnICcuam9pbigiJ3t9JyIuZm9ybWF0KGZpbGVf
cGF0aCkgZm9yIGZpbGVfcGF0aCBpbiBnbG9iLmdsb2IoZmlsZSkpDQo+ID4gKyAgICAgICAgICAg
ICAgICBjbWQgPSAnY3AgLWZwUFJIICVzICIlcyInICUgKGZpbGUsIGRlc3RkaXIpDQo+IA0KPiBX
aHkgc2luZ2xlIHF1b3RlcyBpbiAiZmlsZSIgYnV0IGRvdWJsZSBxdW90ZXMgaW4gdGhlIGNtZD8N
CllvdSBhcmUgY29ycmVjdC4gSXQgc2hvdWxkIGJlIGRvdWJsZSBxdW90ZXMgdG9vLCB0byBhbGxv
dyB2YXJpYWJsZSBleHBhbnNpb24gYnkgdGhlIHNoZWxsLg0KVGhlIGxhdGVzdCBwYXRjaHNldCBy
ZXZpc2lvbiB1c2VzIGRvdWJsZSBxdW90ZXMgZm9yIHRoZSBzb3VyY2UgdG9vLg0KPiANCj4gDQo+
IFdvdWxkIGl0IG1ha2Ugc2Vuc2UgdG8gaW1wbGVtZW50IHRoaXMgY29ycmVjdGx5IGZyb20gdGhl
IGJlZ2lubmluZy4gIEUuZy4NCj4gDQo+IC0gYXZvaWQgbWFudWFsIHF1b3RpbmcgYnV0IHVzZSAi
cGlwZXMucXVvdGUoKSINCkkgYXNzdW1lIHRoaXMgd291bGQgYmUgc2hsZXgucXVvdGVzPw0KPiAN
Cj4gLSBkbyBub3QgdXNlIGEgc2hlbGwgY29tbWFuZCBzdHJpbmcgYnV0IGFuIGFycmF5IHdoaWNo
IGlzIGdpdmVuIGRpcmVjdGx5DQo+ICAgdG8gZXhlY3ZlKCk/DQpBRkFJSSBpdCdzIGRlc2lyZWQg
dG8gYmUgYWJsZSB0byByZXVzZSBvdGhlciBlbnZpcm9ubWVudCB2YXJpYWJsZXMgaW4gYFNSQ19V
Uklgcy4NCldoYXQncyBtb3JlIGlzIHRoYXQgb25jZSBodHRwczovL2J1Z3MucHl0aG9uLm9yZy9p
c3N1ZTM4ODkzIGlzIGZpeGVkLCBvbmUgbWlnaHQgd2FudCB0byB1c2UgcHl0aG9uDQpuYXRpdmUg
Y29weSBvcGVyYXRpb25zIGFueXdheS4NCj4gDQo+IEVsc2UsIG5leHQgcGF0Y2hzZXQgd2lsbCBk
ZWFsIHdpdGggc2luZ2xlL2RvdWJsZSBxdW90ZXMuLi4NCg0KR2xvYmJpbmcgc3VwcG9ydCB3YXMg
cmVtb3ZlZC4gVGhpcyBwYXRjaHNldCByZXZpc2lvbiBiZWNhbWUga2luZCBvZiBvYnNvbGV0ZS4N
Cj4gDQo+IA0KPiANCj4gRW5yaWNvDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLA0KDQpMZWlm
DQo=
