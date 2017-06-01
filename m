Return-Path: <prvs=31872cab3=Mikko.Rapeli@bmw.de>
X-Greylist: delayed 648 seconds by postgrey-1.34 at layers.openembedded.org;
	Thu, 01 Jun 2017 16:07:42 UTC
Received: from esa7.bmw.c3s2.iphmx.com (esa7.bmw.c3s2.iphmx.com
	[68.232.133.109])
	by mail.openembedded.org (Postfix) with ESMTP id 5EF9A77E13;
	Thu,  1 Jun 2017 16:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
	t=1496333265; x=1527869265;
	h=from:to:cc:subject:date:message-id:in-reply-to:
	content-id:content-transfer-encoding:mime-version;
	bh=FdGVAmM2Ip4mCdN67ig66GkKRGQHerFL7J4XAV4RPkA=;
	b=Z0y+GChE9U+9fvw8iGsWlpDMan4fgAofj+TGw7irBL2jCKnR8sc5jAH0
	mJyMhbsom6+so+Q7CPdRPm6hDeg4PgtvgPRHJz5/D8A7vzjCbipDAyUj+
	MBfHFMt+orwGNNvpO7LGu3aLV6c5z2hutOC609QsjZo/GQD8DG59Qh/fF 8=;
Received: from esagw2.bmwgroup.com (HELO esagw2.muc) ([160.46.252.38]) by
	esa7.bmw.c3s2.iphmx.com with ESMTP/TLS; 01 Jun 2017 17:56:55 +0200
Received: from esabb4.muc ([160.50.100.33])  by esagw2.muc with ESMTP/TLS;
	01 Jun 2017 17:56:55 +0200
Received: from smucm10l.bmwgroup.net (HELO smucm10l.europe.bmw.corp)
	([160.48.96.48])
	by esabb4.muc with ESMTP/TLS; 01 Jun 2017 17:56:55 +0200
Received: from smucm10k.europe.bmw.corp (160.48.96.47) by
	smucm10l.europe.bmw.corp
	(160.48.96.48) with Microsoft SMTP Server (TLS;
	Thu, 1 Jun 2017 17:56:54 +0200
Received: from smucm10k.europe.bmw.corp ([160.48.96.47]) by
	smucm10k.europe.bmw.corp ([160.48.96.47]) with mapi id 15.00.1263.000;
	Thu, 1 Jun 2017 17:56:54 +0200
From: <Mikko.Rapeli@bmw.de>
To: <bitbake-devel@lists.openembedded.org>, <poky@yoctoproject.org>
Thread-Topic: [PATCH 1/3 v2] bitbake: Fix return value checks from
	subprocess.call()'s
Thread-Index: AQHS2u+wph96K9fdEUKsm2aUv77QVA==
Date: Thu, 1 Jun 2017 15:56:54 +0000
Message-ID: <20170601155654.hmrqbm7zmru2667w@hiutale>
In-Reply-To: <1496332394-6615-1-git-send-email-mikko.rapeli@bmw.de>
	<1496332293-23469-1-git-send-email-mikko.rapeli@bmw.de>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [192.168.44.101]
MIME-Version: 1.0
Cc: openembedded-core@lists.openembedded.org
Subject: Re: [PATCH 1/3 v2] bitbake: Fix return value checks from subprocess.call()'s
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
X-List-Received-Date: Thu, 01 Jun 2017 16:07:44 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E44E5004C8731A4D822FC1B6FA374938@bmwmail.corp>
Content-Transfer-Encoding: quoted-printable

Hmm, do I need to rebase the patches from yocto to upstream
bitbake and meta-poky git trees?

-Mikko=

