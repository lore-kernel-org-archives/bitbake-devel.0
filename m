Return-Path: <prvs=75725d379=Mikko.Rapeli@bmw.de>
X-Greylist: delayed 592 seconds by postgrey-1.34 at layers.openembedded.org;
	Tue, 14 Aug 2018 06:41:57 UTC
Received: from esa7.bmw.c3s2.iphmx.com (esa7.bmw.c3s2.iphmx.com
	[68.232.133.109])
	by mail.openembedded.org (Postfix) with ESMTP id D1F8860290
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 14 Aug 2018 06:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
	t=1534228919; x=1565764919;
	h=from:to:cc:subject:date:message-id:references:
	in-reply-to:content-id:content-transfer-encoding: mime-version;
	bh=iz2Upa3oqJq3vet6VEMnFyT0Ugr0MxOecyrEQV0wkJQ=;
	b=onNLnr+UO2DyMzaX6hf7oh+R0YMg31hfBXVaEPbZ3qhpQWtbCJjpOYBX
	Fv0LrFnny0l5eT9SjmqR//fwNtFWk/TlXZVURVMPcj3Qloux+H2eli6RT
	f/PzEGog5UHefgeGPMoMi3ffy0iRiP5ws52i+8vFqoeCVNCxDbobGrNRq c=;
Received: from esagw6.bmwgroup.com (HELO esagw6.muc) ([160.46.252.49]) by
	esa7.bmw.c3s2.iphmx.com with ESMTP/TLS; 14 Aug 2018 08:32:04 +0200
Received: from esabb2.muc ([160.50.100.34])  by esagw6.muc with ESMTP/TLS;
	14 Aug 2018 08:32:04 +0200
Received: from smucm10k.bmwgroup.net (HELO smucm10k.europe.bmw.corp)
	([160.48.96.47])
	by esabb2.muc with ESMTP/TLS; 14 Aug 2018 08:32:04 +0200
Received: from smucm10k.europe.bmw.corp (160.48.96.47) by
	smucm10k.europe.bmw.corp
	(160.48.96.47) with Microsoft SMTP Server (TLS;
	Tue, 14 Aug 2018 08:32:04 +0200
Received: from smucm10k.europe.bmw.corp ([160.48.96.47]) by
	smucm10k.europe.bmw.corp ([160.48.96.47]) with mapi id 15.00.1367.000;
	Tue, 14 Aug 2018 08:32:04 +0200
From: <Mikko.Rapeli@bmw.de>
To: <martin.jansa@gmail.com>
Thread-Topic: [bitbake-devel] [PATCH 2/2] runqueue: Introduce load balanced
	task spawning
Thread-Index: AQHUM0uHm6/FqCIAlkiDie43J9L9c6S+T0uAgABZngA=
Date: Tue, 14 Aug 2018 06:32:04 +0000
Message-ID: <20180814063203.GJ8291@hiutale>
References: <20180813210445.32496-1-schnitzeltony@gmail.com>
	<20180813210445.32496-3-schnitzeltony@gmail.com>
	<CANNYZj-3OQ7gPEop3OcDL5bnv3x9Q=DmEFCYi4-K7B3Xqp5v0Q@mail.gmail.com>
	<20180814011119.GA1391@jama>
In-Reply-To: <20180814011119.GA1391@jama>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [192.168.221.36]
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 2/2] runqueue: Introduce load balanced task spawning
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
X-List-Received-Date: Tue, 14 Aug 2018 06:41:58 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <EC37E7E8D2AD154FAB44E0A45D1E2728@bmwmail.corp>
Content-Transfer-Encoding: base64

SnVzdCBteSAyIOKCrCBjZW50cyB0byB0aGUgZGlzY3Vzc2lvbjoNCg0Kd2UgaGFkIHRvIGxpbWl0
IG51bWJlciBvZiB0aHJlYWRzIGJlY2F1c2UgaGVhdnkgQysrIHByb2plY3RzIHdlcmUgdXNpbmcN
CmFsbCBvZiBSQU0gYW5kIGNhdXNpbmcgaGVhdnkgc3dhcHBpbmcuIFNpbmdsZSBnKysgcHJvY2Vz
c2VzIHdlcmUgZWF0aW5nDQp1cCB0byAyMCBnaWdhYnl0ZXMgb2YgcGh5c2ljYWwgcmFtLiBJdCdz
IG5vdCBqdXN0IHRoZSBDUFUgd2hpY2ggaXMgdGhlDQpsaW1pdGluZyBmYWN0b3IgdG8gcGFyYWxs
ZWwgdGFzayBleGVjdXRpb24uDQoNCi1NaWtrbw==

