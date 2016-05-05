Return-Path: <dl9pf@gmx.de>
X-Greylist: delayed 316 seconds by postgrey-1.34 at layers.openembedded.org;
	Thu, 05 May 2016 17:34:46 UTC
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by mail.openembedded.org (Postfix) with ESMTP id BC51373181;
	Thu,  5 May 2016 17:34:46 +0000 (UTC)
Received: from elrond.localnet ([95.90.4.156]) by mail.gmx.com (mrgmx003) with
	ESMTPSA (Nemesis) id 0LiDrv-1bSFz90ZXf-00nOWH;
	Thu, 05 May 2016 19:29:12 +0200
From: Jan-Simon =?ISO-8859-1?Q?M=F6ller?= <dl9pf@gmx.de>
To: openembedded-architecture@lists.openembedded.org
Date: Thu, 05 May 2016 19:29:08 +0200
Message-ID: <9084039.ulb8Qqh204@elrond>
User-Agent: KMail/4.14.10 (Linux/4.1.20-11-default; KDE/4.14.18; x86_64; ; )
In-Reply-To: <fce22d23-e66c-c692-f7d5-f1154081246a@windriver.com>
References: <1462352176.18407.11.camel@linuxfoundation.org>
	<cb3d3b05-4d43-dbdb-e905-c407ce6219ec@balister.org>
	<fce22d23-e66c-c692-f7d5-f1154081246a@windriver.com>
MIME-Version: 1.0
X-Provags-ID: V03:K0:veHKzOC3AQs+pyQ4+T0P5pPP8n0TPa6ehmFU0hCymAbtN3sIGUq
	PzeEl+qbBCcJqhyb/MNzXFDcsjS7F6/D0u5mw+dadgwHo0z5HdxP8SOwI6+VgrtY3nf01+g
	5pnBVM51sqXQozpiMGIeuQNB5Pyk30vu6b74Wg2enWDJ9ArlPeGw2plU6VadnpWolyDCo7t
	LISMzva+PTtpf2JtJx5Og==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CS1ai3A+Zf0=:x768VnRnqrxFA6xFq+c8m8
	R1RFes6vKSGYjiHn7r87EUIP7ZC4OkXjnAfxmyPemeQkv7/4EAZUFuy5qAbc4TuByoEyZWseD
	1MKMPYcOS/CHpKUA1JyZBYl8xQ31S8qcrv0P7cZ3ffO5aOO/uijqt6vRR6qb5GpoRI8FQ341h
	v1Y9Et5+k9ScjeTBGiKWy3hIP8FPtPOrxYZGz5qGNUT6vuVtYBfbMwk2xsop3wo+QPFIy853a
	T5fi1Z1uhXNMZbYSvK568TCNZ2l73ZPwFsnZYByJX6XxPlwd9xRAHI+EzoazrbtkjOrV6cDVF
	/EfA+i9SSkp77Tzibmy7NS+CzJBgY38ForKZHfePlIiKkLrBJNx+EuTz2BP+vuUeOsXPrzhHF
	AhZzW0/lquJauiFb+o1towbYOA0gnUO8wkUryJUEXfvzvqlJh1d50a+GR+QBqDVmz1c86BraS
	Hn8HfqcvMp63d2QSw6RTXH0RAsjiBAY9osnu9/3leoLOXRDcSSnhe39BfeHLpv04K1kGgAbCM
	NTU8QeaSwjk58crl9OaADsqCKe/fqXYKbJK2fIzZO1HgGLh43cq7s1ljiyh6yka9ICWhJZfvK
	kPQEKShvtrOxu2pGUqwpcYm5UizyQwB6uq/zCUQi2CLwH2FKHbAdokxlXHh+VHTS3la0bk9yk
	C49/WIS8svZkBNg0DxScWHJwHbaNLFb1m7sKiv2RLDFGafgyNcoHCesK9Hlm98o+CFkjzPvRH
	Wi43eFhgmJyC0b+Yv6jXtWOIyjstiDA+RlUz8fnPIa/8Cd/4mC0QHcUH6asZkAplDkriDeOR0
	90AaiyJ
Cc: Philip Balister <philip@balister.org>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [Openembedded-architecture] Python 3 for Bitbake
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
X-List-Received-Date: Thu, 05 May 2016 17:34:50 -0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Am Donnerstag, 5. Mai 2016, 10:13:21 schrieb Mark Hatle:
> >> Question, do we need any type of identifier in layers to say they'=
re
> >> "python3" compatible or not?
> >=20
> > Layers that are python2 will need krogoth branches. I'd expect mast=
er
> > branches to follow oe-core/master and jump to python3.
>=20
> I don't disagree, but my experience has been that branching is late o=
r never
> in a lot of layers.
>=20
> This might be a place where we need to plan to go through the layer i=
ndex
> and at least see if the layer parses -- and flag things that no longe=
r
> parse?  (I don't even know if this is something reasonable to attempt=
.)
>=20
> My fear is just we've already got a lot of "broken" (without defining=
 that)
> layers in the index, and I think it will be worse once the python3 ch=
ange
> happens.  I'd really like to make sure we don't confuse people with v=
arious
> errors.
>=20

As it is a hard cut anyway, call it YP 3.0 (!) and start with an empty=20=

layerindex for 3.0 and only add layers that parse or are maintained.
Legacy is 1.x/2.x and will be a separate page.


--
Jan-Simon M=F6ller
dl9pf@gmx.de

