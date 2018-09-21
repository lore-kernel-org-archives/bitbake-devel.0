Return-Path: <prvs=795b04f21=Mikko.Rapeli@bmw.de>
X-Greylist: delayed 592 seconds by postgrey-1.34 at layers.openembedded.org;
	Fri, 21 Sep 2018 14:25:29 UTC
Received: from esa4.bmw.c3s2.iphmx.com (esa4.bmw.c3s2.iphmx.com
	[68.232.139.62])
	by mail.openembedded.org (Postfix) with ESMTP id 7908E7605E
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 21 Sep 2018 14:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
	t=1537539933; x=1569075933;
	h=from:to:cc:subject:date:message-id:references:
	in-reply-to:content-id:content-transfer-encoding: mime-version;
	bh=5S6YccdZjiX/k3kqxG2egYBVkFj+abi8e4UE76KLijo=;
	b=SN8AYlRPy0rHdTQVrRreRX9e8rA2Za1NHGQ3O/Hgv1GDYOaTT1wZxZPL
	kF/VYvbbHn7+GeX1+uO0WLpSw9qQ4BWNamNnEbzq2mWpaayHh6uToa2dx
	6gvHoCrpGXQl+IhwMzDBzsGeylivIruBD60xxfp7SaJOXFcdbp3Hva/Ga k=;
Received: from esagw3.bmwgroup.com (HELO esagw3.muc) ([160.46.252.35]) by
	esa4.bmw.c3s2.iphmx.com with ESMTP/TLS; 21 Sep 2018 16:15:38 +0200
Received: from esabb1.muc ([160.50.100.31])  by esagw3.muc with ESMTP/TLS;
	21 Sep 2018 16:15:37 +0200
Received: from smucm10m.bmwgroup.net (HELO smucm10m.europe.bmw.corp)
	([160.48.96.49])
	by esabb1.muc with ESMTP/TLS; 21 Sep 2018 16:15:37 +0200
Received: from smucm10k.europe.bmw.corp (160.48.96.47) by
	smucm10m.europe.bmw.corp
	(160.48.96.49) with Microsoft SMTP Server (TLS;
	Fri, 21 Sep 2018 16:15:37 +0200
Received: from smucm10k.europe.bmw.corp ([160.48.96.47]) by
	smucm10k.europe.bmw.corp ([160.48.96.47]) with mapi id 15.00.1367.000;
	Fri, 21 Sep 2018 16:15:37 +0200
From: <Mikko.Rapeli@bmw.de>
To: <mark.hatle@windriver.com>
Thread-Topic: [bitbake-devel] [PATCH] Fix gitsm networking and mirroring
Thread-Index: AQHUUUDB8lJjVlJRBUW02oKX8oNt7KT6LgsAgAB13ACAAAMxAA==
Date: Fri, 21 Sep 2018 14:15:37 +0000
Message-ID: <20180921141536.GY9430@hiutale>
References: <20180921001815.18248-1-mark.hatle@windriver.com>
	<20180921070220.GR9430@hiutale>
	<d4b42aa4-2b09-4272-c0da-790cefb1a98d@windriver.com>
In-Reply-To: <d4b42aa4-2b09-4272-c0da-790cefb1a98d@windriver.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [192.168.221.44]
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
X-List-Received-Date: Fri, 21 Sep 2018 14:25:31 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D2392FCAE782CE46933392C50F1214AB@bmwmail.corp>
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 21, 2018 at 09:04:10AM -0500, Mark Hatle wrote:
> On 9/21/18 2:02 AM, Mikko.Rapeli@bmw.de wrote:
> > Looks good from what I understand of the patch, but I have a question a=
bout
> > git/gitsm fetchers:
> >=20
> > Is it possible that two recipes end up modifying the same file e.g. via
> > hard links when they use git submodules and share one of the repositori=
es?
>=20
> The symlinks (not hard links in this case) are between the components fro=
m the
> submodule and whatever the fetcher returned.
>=20
> The only modified element(s) are the references to the submodules within =
the
> bare repositories.
>=20
> Assuming all users use the same bare repositories, it's my
> understanding/expectation that the code in the 'downloads' will be the sa=
me.
> The only difference will then be in working dir.
>=20
> > I'm seeing very odd build failures on sumo and it looks like
> > recipes are either mixing up files in their sysroots or seeing each oth=
ers
> > patches on top of the shared git submodule tree. These happen when buil=
ding
> > the whole system and rebuilding affected recipes alone makes the proble=
m
> > go away.
>=20
> Before or after my patch?  The gitsm changes here should ONLY affect the
> repository and any submodules affected.  The code affects the fetch and u=
npack
> behaviors of the system.  So no patches would be applied to the tree.. (w=
ell
> they are not supposed to be!)

Before, on sumo and I was wondering if your patch could fix it.

But with help from #yocto I've now debugged this into openssl do_configure
and am testing a patch. With luck my problem had nothing to do with git
submodules.

> The previous (current) gitsm fetcher makes it's submodules present using =
either
> copies or git submodule updates.  In the case of a copy, it might be poss=
ible
> for one workdir to have a symlink back to the download or other shared lo=
cation.
>  (I never encountered this, so this is purely speculation.)
>=20
> If you can get me a gitsm reproducer for the problems you were seeing, I =
can run
> them through this code and see if I can make it work.
>=20
> (As an aside, I think git submodules are one of the worst things ever.  I=
 really
> hate them...)
>
> > With svn fetcher we see the same, but that's one of the problems we kne=
w about
> > from past. svn fetcher does not lock the download cached tree correctly
> > and if multiple recipes use the same repo, one of them can see the repo
> > in an inconsistent state and fail with various errors. Our workaround
> > is to switch to http/s fetcher instead.
>=20
> With my patch set, I'm not doing an explicit locking.  The download proce=
ss
> itself, should be locked by the existing fetch2 system, and git fetcher. =
 The
> module setup/symlinking process might be slightly different.
>=20
> One place there COULD be an issue is if two different recipes refer to th=
e same
> gitsm 'source', but different srcrev, and the different srcrev point to
> different submodules.  I don't know if this is really a concern in practi=
ce though.

Given my luck, we will hit this sooner or later. I think with svn fetcher w=
e
have already seen cases like this. In the best case build fails and in the
worst case wrong things end up in the build...

-Mikko=

