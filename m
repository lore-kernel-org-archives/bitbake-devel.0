Received: from smtpfb2-g21.free.fr ([212.27.42.10])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <eric@eukrea.com>) id 1SBsPc-000544-9B
	for bitbake-devel@lists.openembedded.org;
	Sun, 25 Mar 2012 20:43:32 +0200
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id 59081D1AFC0
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 25 Mar 2012 20:34:34 +0200 (CEST)
Received: from eb-e6520 (unknown [82.233.81.124])
	by smtp3-g21.free.fr (Postfix) with ESMTP id DAFB8A6226;
	Sun, 25 Mar 2012 20:34:28 +0200 (CEST)
Date: Sun, 25 Mar 2012 20:34:27 +0200
From: Eric =?ISO-8859-1?B?QuluYXJk?= <eric@eukrea.com>
To: bitbake-devel@lists.openembedded.org
Message-ID: <20120325203427.4e9189eb@eb-e6520>
In-Reply-To: <1332577677.1849.36.camel@dongxiao-osel>
References: <20120322122219.0df320be@eb-e6520>
	<20120323091314.5b5d00a0@eb-e6520>
	<1332503125.1849.0.camel@dongxiao-osel>
	<1332556685.1849.29.camel@dongxiao-osel>
	<20120324091905.0a64617b@eb-e6520>
	<1332577677.1849.36.camel@dongxiao-osel>
Organization: =?ISO-8859-1?B?RXVrculh?= Electromatique
X-Mailer: Claws Mail 3.8.0 (GTK+ 2.24.8; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Subject: Re: Hob : IndexError: list index out of range
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Sun, 25 Mar 2012 18:43:32 -0000
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Dongxiao,

Le Sat, 24 Mar 2012 16:27:57 +0800,
"Xu, Dongxiao" <dongxiao.xu@intel.com> a =E9crit :

> I have send out a patch in my previous pull request [Patch 8/8] to
> address this issue. You can have a try of that after it is checked into
> master.
>=20
> Thanks,
> Dongxiao
>=20
> On Sat, 2012-03-24 at 09:19 +0100, Eric B=E9nard wrote:
> > Le Sat, 24 Mar 2012 10:38:05 +0800,  =20
> > "Xu, Dongxiao" <dongxiao.xu@intel.com> a =E9crit :
> >=20
> > > I can reproduce it locally, thanks for reporting it.
> > >=20
> > reported here :
> > https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D2169
> >=20
bug 2169 & bug 2167 are solved in actual bitbake
( at 02d3451b2e0744204a1280f9effe9fd862bb4faf ) and thus can be closed

Thanks !

Eric


