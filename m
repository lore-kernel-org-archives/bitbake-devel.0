Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TCW4O-0005sQ-0H; Fri, 14 Sep 2012 15:36:32 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q8EDNqgK011691;
	Fri, 14 Sep 2012 14:23:52 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 10921-08; Fri, 14 Sep 2012 14:23:48 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q8EDNeZf011670
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 14 Sep 2012 14:23:42 +0100
Message-ID: <1347629023.13596.12.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Otavio Salvador <otavio@ossystems.com.br>
Date: Fri, 14 Sep 2012 14:23:43 +0100
In-Reply-To: <CAP9ODKpZp1bhNg-EoHUYhU1YCU3=dRULpT8K_QCPZ9VLS8+xZg@mail.gmail.com>
References: <cover.1346905978.git.raj.khem@gmail.com>
	<5c54fcdb91d19909f8658b6a6e8d6e6cac934cf2.1346905978.git.raj.khem@gmail.com>
	<504FF70B.7060701@mlbassoc.com> <1347458928.11710.21.camel@ted>
	<CAMKF1so6qUDFMw_aOZTdC4W_Dh=rDiiC1O7pvjaUQS2xkG8xWg@mail.gmail.com>
	<20120913121935.GC18675@giant>
	<CAP9ODKp8sKpVMi9MwdFxwZTq2-VMiRGzDzD=bBrFu8r4hZ0xMA@mail.gmail.com>
	<CABcZANkbpR66G2-4WnBjdcjUGd4Khbje-kvpd2geUaVMMxE=4A@mail.gmail.com>
	<1347623908.13596.2.camel@ted>
	<CAP9ODKpZp1bhNg-EoHUYhU1YCU3=dRULpT8K_QCPZ9VLS8+xZg@mail.gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
X-MIME-Autoconverted: from 8bit to quoted-printable by tim.rpsys.net id
	q8EDNqgK011691
Cc: Chris Larson <clarson@kergoth.com>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>,
	openembedded-core@lists.openembedded.org
Subject: Re: [OE-core] [PATCH 1/4] gcc: Switch SRC_URI to use svn
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
X-List-Received-Date: Fri, 14 Sep 2012 13:36:32 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-09-14 at 09:36 -0300, Otavio Salvador wrote:
> On Fri, Sep 14, 2012 at 8:58 AM, Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
> > On Thu, 2012-09-13 at 07:22 -0700, Chris Larson wrote:
> >> On Thu, Sep 13, 2012 at 6:06 AM, Otavio Salvador
> >> <otavio@ossystems.com.br> wrote:
> >> > On Thu, Sep 13, 2012 at 9:19 AM, Bj=C3=B6rn Stenberg <bjst@enea.co=
m> wrote:
> >> >> Khem Raj wrote:
> >> >>> I agree but then 1.7 GB is noticeably huge too and it will only =
become
> >> >>> larger in future so I don't think fetching from git will be a go=
od solution
> >> >>> for gcc ever.
> >> >>
> >> >> Can we use shallow clones? A quick test of gcc-4.7 gave me a 308 =
MB tar.gz when cloned with --depth 1.
> >> >
> >> > I did not check if the fetcher has this support  but it would be a
> >> > nice solution.
> >>
> >> Shallow clones won't be able to support SRCREV properly, as you can
> >> only clone shallowly from HEAD, not from an arbitrary point in
> >> history, AFAIK.
> >
> > Right, shallow clones are a can of worms from a variety of angles.
> >
> > My current thinking is a ;allowsinglerev=3D1 parameter to the git fet=
cher
> > which:
> >
> > a) Generates tarballs of single git revisions if tarball generation i=
s
> > turned on
> > b) Searches for single revision tarballs before trying the main check=
out
> > approach.
> >
> > This would mean that WORKDIR may or may not have a .git directory for
> > any SRC_URI marked with this. I think we should all be able to live w=
ith
> > that and it shouldn't break too much?
>=20
> We'll end with multiple tarballs, aren't we?

Yes. I'm not seeing that as a big problem for most of the usecases where
we'd use this feature. You could skip shipping the big tarball of the
whole repo at distribution time.

Cheers,

Richard





