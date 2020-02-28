Return-Path: <prvs=320079d08=Mikko.Rapeli@bmw.de>
X-Greylist: delayed 427 seconds by postgrey-1.34 at layers.openembedded.org;
	Fri, 28 Feb 2020 14:16:27 UTC
Received: from esa4.bmw.c3s2.iphmx.com (esa4.bmw.c3s2.iphmx.com
	[68.232.139.62])
	by mail.openembedded.org (Postfix) with ESMTP id ADA89611EC
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Feb 2020 14:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
	t=1582899389; x=1614435389;
	h=from:to:cc:subject:date:message-id:references:
	in-reply-to:content-id:content-transfer-encoding: mime-version;
	bh=4IZjiI02+V/tCrXi+O626hek3M/k+MP6NeTl5qtH+/0=;
	b=cbo2vwz5eLQ5cSkQDhHrrjSM9Ltqq6zv6kZNNY5tOSzopAnJ+QS5bsaC
	IsmD50cixIYJeAEFDvhiwri8G+Zw6IngpgBJNrl5KpetWYBRR6s16ZZ2l
	725zDKyCxBmrSMWZBeh7pnus7PiofohmmFYGYfj4yuNp3widZatXuRrbu w=;
Received: from esagw2.bmwgroup.com (HELO esagw2.muc) ([160.46.252.38]) by
	esa4.bmw.c3s2.iphmx.com with ESMTP/TLS; 28 Feb 2020 15:09:20 +0100
Received: from esabb1.muc ([160.50.100.31])  by esagw2.muc with ESMTP/TLS;
	28 Feb 2020 15:09:20 +0100
Received: from smucm10m.bmwgroup.net (HELO smucm10m.europe.bmw.corp)
	([160.48.96.49])
	by esabb1.muc with ESMTP/TLS; 28 Feb 2020 15:09:19 +0100
Received: from smucm10k.europe.bmw.corp (160.48.96.47) by
	smucm10m.europe.bmw.corp
	(160.48.96.49) with Microsoft SMTP Server (TLS;
	Fri, 28 Feb 2020 15:09:19 +0100
Received: from smucm10k.europe.bmw.corp ([160.48.96.47]) by
	smucm10k.europe.bmw.corp ([160.48.96.47]) with mapi id 15.00.1473.005;
	Fri, 28 Feb 2020 15:09:19 +0100
From: <Mikko.Rapeli@bmw.de>
To: <rpjday@crashcourse.ca>
Thread-Topic: [bitbake-devel] can i get a list of only bbappend'ed recipes
	that were *used* in a build?
Thread-Index: AQHV7ju+Rd6y+nPBOkW1vHgjoUlXwKgwlBqA
Date: Fri, 28 Feb 2020 14:09:19 +0000
Message-ID: <20200228140919.GO104502@korppu>
References: <20200228083336.Horde.2i5ag6ZVWX3JF5j5y3bF1q2@crashcourse.ca>
In-Reply-To: <20200228083336.Horde.2i5ag6ZVWX3JF5j5y3bF1q2@crashcourse.ca>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: can i get a list of only bbappend'ed recipes that were *used* in a build?
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
X-List-Received-Date: Fri, 28 Feb 2020 14:16:28 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F92EB0B04AA6094BAD4E5A871022FE00@bmwmail.corp>
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 28, 2020 at 08:33:36AM -0500, rpjday@crashcourse.ca wrote:
> looked around and i don't see an immediately obvious way to do this ...
> is there a way to generate a list of *only* those recipes that were
> used in the current build that had associated .bbappend files?
>
> "bitbake-layers show-appends" will show all recipes with .bbappend
> files, including those that are not included and processed for the
> current build/image. here's the rationale, in case i'm missing
> something.

I'm doing "find meta* -name \*recipe\*bb\*" and reviewing every one of them=
.
More visibility to this including parsing order would be nice to store in
e.g. buildhistory.

> been handed an existing vendor layer, with *tons* of bbappend'ed
> recipes, some basic, some from meta-openembedded and many from
> the vendor's proprietary layer. my go-to strategy is to always try
> to build a core-image-minimal to establish a working baseline and,
> when that works, it would be nice to know which of the recipes
> that contributed to that core-image-minimal build were modified
> in any way via a .bbappend file, then work my way out.
>
> does that make sense? is there a way to do this, other than wander
> down to tmp/work/... and try to figure out which recipes were
> modified from the original? am i overlooking something simple?

I start off by reviewing every single file in vendor and BSP SW layers
before I add them to builds. Sadly this does not catch bad things
which get integrated later in updates.

Resulting distro config in my projects is full of BBMASK paths to the vario=
us
layers which are intrusive with their bbappends.

Maybe recording all bbappends and their relative paths in the project and
parsing order to buildhistory would help.

I would also like to limit layers from adding bbappends to certain recipes
but I don't see ways for this currently without external scripts.

Maybe this helps,

-Mikko=

