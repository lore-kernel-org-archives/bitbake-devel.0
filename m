Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TCUjv-0003K0-T1; Fri, 14 Sep 2012 14:11:20 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q8EBwdp1011110;
	Fri, 14 Sep 2012 12:58:39 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 10921-02; Fri, 14 Sep 2012 12:58:31 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q8EBwPr7011099
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 14 Sep 2012 12:58:27 +0100
Message-ID: <1347623908.13596.2.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Chris Larson <clarson@kergoth.com>
Date: Fri, 14 Sep 2012 12:58:28 +0100
In-Reply-To: <CABcZANkbpR66G2-4WnBjdcjUGd4Khbje-kvpd2geUaVMMxE=4A@mail.gmail.com>
References: <cover.1346905978.git.raj.khem@gmail.com>
	<5c54fcdb91d19909f8658b6a6e8d6e6cac934cf2.1346905978.git.raj.khem@gmail.com>
	<504FF70B.7060701@mlbassoc.com> <1347458928.11710.21.camel@ted>
	<CAMKF1so6qUDFMw_aOZTdC4W_Dh=rDiiC1O7pvjaUQS2xkG8xWg@mail.gmail.com>
	<20120913121935.GC18675@giant>
	<CAP9ODKp8sKpVMi9MwdFxwZTq2-VMiRGzDzD=bBrFu8r4hZ0xMA@mail.gmail.com>
	<CABcZANkbpR66G2-4WnBjdcjUGd4Khbje-kvpd2geUaVMMxE=4A@mail.gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
X-MIME-Autoconverted: from 8bit to quoted-printable by tim.rpsys.net id
	q8EBwdp1011110
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Otavio Salvador <otavio@ossystems.com.br>,
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
X-List-Received-Date: Fri, 14 Sep 2012 12:11:20 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-09-13 at 07:22 -0700, Chris Larson wrote:
> On Thu, Sep 13, 2012 at 6:06 AM, Otavio Salvador
> <otavio@ossystems.com.br> wrote:
> > On Thu, Sep 13, 2012 at 9:19 AM, Bj=C3=B6rn Stenberg <bjst@enea.com> =
wrote:
> >> Khem Raj wrote:
> >>> I agree but then 1.7 GB is noticeably huge too and it will only bec=
ome
> >>> larger in future so I don't think fetching from git will be a good =
solution
> >>> for gcc ever.
> >>
> >> Can we use shallow clones? A quick test of gcc-4.7 gave me a 308 MB =
tar.gz when cloned with --depth 1.
> >
> > I did not check if the fetcher has this support  but it would be a
> > nice solution.
>=20
> Shallow clones won't be able to support SRCREV properly, as you can
> only clone shallowly from HEAD, not from an arbitrary point in
> history, AFAIK.

Right, shallow clones are a can of worms from a variety of angles.

My current thinking is a ;allowsinglerev=3D1 parameter to the git fetcher
which:

a) Generates tarballs of single git revisions if tarball generation is
turned on
b) Searches for single revision tarballs before trying the main checkout
approach.

This would mean that WORKDIR may or may not have a .git directory for
any SRC_URI marked with this. I think we should all be able to live with
that and it shouldn't break too much?

Cheers,

Richard




