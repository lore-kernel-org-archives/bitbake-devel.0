Return-Path: <prvs=633f497cc=Mikko.Rapeli@bmw.de>
X-Greylist: delayed 591 seconds by postgrey-1.34 at layers.openembedded.org;
	Thu, 12 Apr 2018 10:26:04 UTC
Received: from esa1.bmw.c3s2.iphmx.com (esa1.bmw.c3s2.iphmx.com
	[68.232.133.201])
	by mail.openembedded.org (Postfix) with ESMTP id 5FC97746C7
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Apr 2018 10:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
	t=1523528768; x=1555064768;
	h=from:to:cc:subject:date:message-id:references:
	in-reply-to:content-id:content-transfer-encoding: mime-version;
	bh=Qi6y+BtivfLrVPqZ8uK8SWpSBWaQZYkT16K+F+d7UFY=;
	b=MBcZHa4aDaPabAS1YULS4a0gQQDTiVsSnfTBzF6G+ONZ0v62eWPwWitU
	upJmYOYrl9XzrxYHUy2SMXeUxF31utQH/oQ1TvSFmjyD6V/3kiiYKXDTP
	n3cTjSek/sme3fOd0G8N09q9xOJV2IeGSsDCic/TnIL6LFoT7Ur0OAwHJ 4=;
Received: from esagw2.bmwgroup.com (HELO esagw2.muc) ([160.46.252.38]) by
	esa1.bmw.c3s2.iphmx.com with ESMTP/TLS; 12 Apr 2018 12:16:14 +0200
Received: from esabb6.muc ([160.50.100.50])  by esagw2.muc with ESMTP/TLS;
	12 Apr 2018 12:16:13 +0200
Received: from smucm10j.bmwgroup.net (HELO smucm10j.europe.bmw.corp)
	([160.48.96.46])
	by esabb6.muc with ESMTP/TLS; 12 Apr 2018 12:16:13 +0200
Received: from smucm10k.europe.bmw.corp (160.48.96.47) by
	smucm10j.europe.bmw.corp
	(160.48.96.46) with Microsoft SMTP Server (TLS;
	Thu, 12 Apr 2018 12:16:13 +0200
Received: from smucm10k.europe.bmw.corp ([160.48.96.47]) by
	smucm10k.europe.bmw.corp ([160.48.96.47]) with mapi id 15.00.1347.000;
	Thu, 12 Apr 2018 12:16:13 +0200
From: <Mikko.Rapeli@bmw.de>
To: <jdebski@enigma.com.pl>
Thread-Topic: [bitbake-devel] [PATCH] fetch2/git.py: Added handling of the
	user's password in url
Thread-Index: AQHT0kdIZiIda1X5FUSkbv9u2CUdKw==
Date: Thu, 12 Apr 2018 10:16:13 +0000
Message-ID: <20180412101612.GJ7593@hiutale>
References: <1523526293-14340-1-git-send-email-jdebski@enigma.com.pl>
In-Reply-To: <1523526293-14340-1-git-send-email-jdebski@enigma.com.pl>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [192.168.221.36]
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] fetch2/git.py: Added handling of the user's password in url
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
X-List-Received-Date: Thu, 12 Apr 2018 10:26:05 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <CD0899994E99F946A98E11BD95F3831A@bmwmail.corp>
Content-Transfer-Encoding: base64

T24gVGh1LCBBcHIgMTIsIDIwMTggYXQgMTE6NDQ6NTNBTSArMDIwMCwgSmFrdWIgRMSZYnNraSB3
cm90ZToNCj4gRmV0Y2hpbmcgc291cmNlIGNvZGUgZnJvbSBwcml2YXRlIHJlcG9zaXRvcnkgKHVz
aW5nIGh0dHBzIG9yIGh0dHApIGZhaWxzDQo+IGJlY2F1c2UgcGFzc3dvcmQgcGFzc2VkIGluIHVy
bCAoZ2l0Oi8vdXNlcjpwYXNzQGRvbWFpbikgaXMgaWdub3JlZC4NCg0KTWF5YmUgdGhpcyBpcyBi
eSBkZXNpZ24gdG8gcHJldmVudCBjcmVkZW50aWFscyBsZWFraW5nIGludG8gYml0YmFrZQ0KcmVj
aXBlcy4NCg0KQWx0ZXJuYXRpdmUgaXMgdG8gc2V0IHRoZSB1c2VybmFtZXMsIHBhc3N3b3JkcyBl
dGMgaW4gZS5nLiB+Ly5uZXRyYw0KYW5kIH4vLnNzaC9jb25maWcgZmlsZXMgd2hpY2ggaGF2ZSB0
aGUgc2FtZSBlZmZlY3QuDQoNCi1NaWtrbw==

