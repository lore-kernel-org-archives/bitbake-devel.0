Return-Path: <prvs=795b04f21=Mikko.Rapeli@bmw.de>
Received: from esa1.bmw.c3s2.iphmx.com (esa1.bmw.c3s2.iphmx.com
	[68.232.133.201])
	by mail.openembedded.org (Postfix) with ESMTP id 60528798D8
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 21 Sep 2018 15:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
	t=1537542592; x=1569078592;
	h=from:to:cc:subject:date:message-id:references:
	in-reply-to:content-id:content-transfer-encoding: mime-version;
	bh=MwmS9qL8NDNiSvQqVylQ96tl0/b6D0yVnBvpRXuzd2M=;
	b=ZKq9gBE4eDSs+zsy0oMJ4+3bRH9gny0AT39fDcG3prgEGTEklJOUP7HV
	Y5F/ivtCyuurRe476V/7NNjF9LHeb/OUEXQ39SwauL7LP9xE5I0buoPu1
	wIyv6gnxRXtz1+FBYFdGJ5M6see/JKTd4oxBDnFNovog2mtvjYjROt8YD I=;
Received: from esagw1.bmwgroup.com (HELO esagw1.muc) ([160.46.252.34]) by
	esa1.bmw.c3s2.iphmx.com with ESMTP/TLS; 21 Sep 2018 17:09:51 +0200
Received: from esabb1.muc ([160.50.100.31])  by esagw1.muc with ESMTP/TLS;
	21 Sep 2018 17:09:50 +0200
Received: from smucm10j.bmwgroup.net (HELO smucm10j.europe.bmw.corp)
	([160.48.96.46])
	by esabb1.muc with ESMTP/TLS; 21 Sep 2018 17:09:50 +0200
Received: from smucm10k.europe.bmw.corp (160.48.96.47) by
	smucm10j.europe.bmw.corp
	(160.48.96.46) with Microsoft SMTP Server (TLS;
	Fri, 21 Sep 2018 17:09:50 +0200
Received: from smucm10k.europe.bmw.corp ([160.48.96.47]) by
	smucm10k.europe.bmw.corp ([160.48.96.47]) with mapi id 15.00.1367.000;
	Fri, 21 Sep 2018 17:09:50 +0200
From: <Mikko.Rapeli@bmw.de>
To: <mark.hatle@windriver.com>
Thread-Topic: [bitbake-devel] [PATCH] Fix gitsm networking and mirroring
Thread-Index: AQHUUUDB8lJjVlJRBUW02oKX8oNt7KT6LgsAgAB13ACAAAMxAIAADd4AgAABSIA=
Date: Fri, 21 Sep 2018 15:09:50 +0000
Message-ID: <20180921150949.GZ9430@hiutale>
References: <20180921001815.18248-1-mark.hatle@windriver.com>
	<20180921070220.GR9430@hiutale>
	<d4b42aa4-2b09-4272-c0da-790cefb1a98d@windriver.com>
	<20180921141536.GY9430@hiutale>
	<70880d62-9114-26fd-ab35-3a32cf8706cb@windriver.com>
In-Reply-To: <70880d62-9114-26fd-ab35-3a32cf8706cb@windriver.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [192.168.221.39]
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] Fix gitsm networking and mirroring
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
X-List-Received-Date: Fri, 21 Sep 2018 15:09:50 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EDDE35F18AFFD5408ED7B9049A690F91@bmwmail.corp>
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 21, 2018 at 10:05:14AM -0500, Mark Hatle wrote:
> I looked through my code.  There is an iteration step that happens in the
> unpack.  If the module being asked for (in a given revision) is not prese=
nt it
> will raise an exception.  This should prevent the 'wrong things' at least=
.

Thanks! Looking forward to this patch in sumo branch too...

-Mikko=

