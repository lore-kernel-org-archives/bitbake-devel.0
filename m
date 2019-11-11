Return-Path: <prvs=211bdf3dd=Mikko.Rapeli@bmw.de>
X-Greylist: delayed 427 seconds by postgrey-1.34 at layers.openembedded.org;
	Mon, 11 Nov 2019 08:05:27 UTC
Received: from esa2.bmw.c3s2.iphmx.com (esa2.bmw.c3s2.iphmx.com
	[68.232.133.169])
	by mail.openembedded.org (Postfix) with ESMTP id 92BDD7F957
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 11 Nov 2019 08:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
	t=1573459529; x=1604995529;
	h=from:to:cc:subject:date:message-id:references:
	in-reply-to:content-id:content-transfer-encoding: mime-version;
	bh=ZwC5wnEPMeS8kppszluFW3p5TfwJF/YfvaqIupPLJbM=;
	b=ClVfjUQZgRvMG1+UVX8gtXEGDoVFNWwm0RMAVadiM1JFBOdC0IyoNw+8
	AOy4I6lC+usj8ckIxthhQBsG5HQi8AA9Hi9K1HujvXaojXHaFULCVYWEK
	1/a/QEHTk5enYlnOeC+jDnl+X4mLsbnQwRDTKNApED+kQFsz+2mUHuPcC g=;
IronPort-SDR: 8qGZXDHm8zYOwdHOFDU2RekW6PufY3XpnaNfQxME3EZkJ9JQ4wMEtWiPbOnp+012nQkmnBF9vE
	0f8HIAkSM5RlWiOxuFfYdE5qxhg8Z3BxI0YlpkUVlqpdtTGFeNl8Lir5RXIYEm84tNAW+GIhtr
	nN5AESGrJPcy8HICMChHSGkSaQJnbmqhTF5GzMEXcQsnhSaY3Q4SdIUU6dIyn3N4DEo076d2n/
	GMVOLkQt9cvSPK/lG7HJKJx66ZFtJzb+xpLMOgzhEHtCVMmRoafKL7nsWJ3911ZH0+phK+IvfA
	Mgw=
Received: from esagw6.bmwgroup.com (HELO esagw6.muc) ([160.46.252.49]) by
	esa2.bmw.c3s2.iphmx.com with ESMTP/TLS; 11 Nov 2019 08:58:21 +0100
Received: from esabb1.muc ([160.50.100.31])  by esagw6.muc with ESMTP/TLS;
	11 Nov 2019 08:58:20 +0100
Received: from smucm10k.bmwgroup.net (HELO smucm10k.europe.bmw.corp)
	([160.48.96.47])
	by esabb1.muc with ESMTP/TLS; 11 Nov 2019 08:58:20 +0100
Received: from smucm10k.europe.bmw.corp (160.48.96.47) by
	smucm10k.europe.bmw.corp
	(160.48.96.47) with Microsoft SMTP Server (TLS;
	Mon, 11 Nov 2019 08:58:20 +0100
Received: from smucm10k.europe.bmw.corp ([160.48.96.47]) by
	smucm10k.europe.bmw.corp ([160.48.96.47]) with mapi id 15.00.1473.005;
	Mon, 11 Nov 2019 08:58:20 +0100
From: <Mikko.Rapeli@bmw.de>
To: <martin.jansa@gmail.com>
Thread-Topic: [bitbake-devel] Patch idea - fetcher for gerrit patches
Thread-Index: AQHVlj4ShXeRFcEfx0eQVA8E6932i6eBTNeAgARBegA=
Date: Mon, 11 Nov 2019 07:58:20 +0000
Message-ID: <20191111075820.GX2398@hiutale>
References: <6f692d96-9b78-b317-d033-09d1f140da62@linux.intel.com>
	<CA+chaQcOse_xmbyi0q=WXB1JQxV6AgGJtvrFZ_Wtmi-N2z0g6A@mail.gmail.com>
In-Reply-To: <CA+chaQcOse_xmbyi0q=WXB1JQxV6AgGJtvrFZ_Wtmi-N2z0g6A@mail.gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: Patch idea - fetcher for gerrit patches
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
X-List-Received-Date: Mon, 11 Nov 2019 08:05:28 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-2"
Content-ID: <7CC1EEE76EF77847A3AF3401332820E1@bmwmail.corp>
Content-Transfer-Encoding: quoted-printable

Hi,

Interesting idea.

We use gerrit but don't neeed to expose gerrit details to bitbake fetcher.

Instead, we use gerrit changes to fetch meta layer changes using a separate=
 checkout
script. It handles gerrit topics, e.g. same topic name is used to bundle ch=
anges
from multiple meta layer git trees. This enables large transitions and upda=
tes as single
topic.

In our case it's a grave bug to use SRC_URIs in bitbake recipes without ref=
erring
to proper branch and commit id. There have been cases where a commit-id fro=
m an open
gerrit review got integrated which is bad, bad. I can only imagine that tes=
ting
could be easier if bitbake recipes were to support gerrit directly, e.g. to=
 trigger
a bitbake test build for an open gerrit review change. But there are other =
ways
to script that without exposing gerrit details to bitbake.

So I'm not sure if this gerrit fetcher is easier. At least I would like to =
disable it,
or add a custom QA check which forbids its use in release build recipes.

Cheers,

-Mikko=

