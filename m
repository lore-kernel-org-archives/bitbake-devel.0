Received: from mailout4.zoneedit.com (mailout4.zoneedit.com [64.68.198.64])
 by mx.groups.io with SMTP id smtpd.web12.44.1586192277959442169
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 06 Apr 2020 09:57:58 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=none, err=permanent DNS error (domain: denix.org, ip: 64.68.198.64, mailfrom: denis@denix.org)
Received: from localhost (localhost [127.0.0.1])
	by mailout4.zoneedit.com (Postfix) with ESMTP id 40C9040BA3;
	Mon,  6 Apr 2020 16:57:57 +0000 (UTC)
Received: from mailout4.zoneedit.com ([127.0.0.1])
	by localhost (zmo14-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MpVjUUehH1Yf; Mon,  6 Apr 2020 16:57:57 +0000 (UTC)
Received: from mail.denix.org (pool-100-15-86-127.washdc.fios.verizon.net [100.15.86.127])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mailout4.zoneedit.com (Postfix) with ESMTPSA id DBE8440A3A;
	Mon,  6 Apr 2020 16:57:53 +0000 (UTC)
Received: by mail.denix.org (Postfix, from userid 1000)
	id 4684317126C; Mon,  6 Apr 2020 12:57:53 -0400 (EDT)
Date: Mon, 6 Apr 2020 12:57:53 -0400
From: "Denys Dmytriyenko" <denis@denix.org>
To: Andre McCurdy <armccurdy@gmail.com>
Cc: Khem Raj <raj.khem@gmail.com>, bernd.bauer@gmx.at,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH] Gitsm does not use credentials when cloning submodules
Message-ID: <20200406165753.GX1578@denix.org>
References: <20200402195104.2405-1-bernd.bauer@gmx.at>
 <fb960c2f15390746d24fd95368478c518748c957.camel@linuxfoundation.org>
 <55c322d4-aa7a-4a6e-6fbe-70ab9eecee83@gmx.at>
 <d5b377f1-413b-6e50-87f3-c77e37ca9c35@gmail.com>
 <CAJ86T=XbybfQkxtKbc8SbEU2d638Hz30A2641ymFUmxQf9P_Jw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJ86T=XbybfQkxtKbc8SbEU2d638Hz30A2641ymFUmxQf9P_Jw@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Apr 05, 2020 at 02:51:02PM -0700, Andre McCurdy wrote:
> On Fri, Apr 3, 2020 at 10:21 AM Khem Raj <raj.khem@gmail.com> wrote:
> > On 4/3/20 12:29 AM, Bernd Bauer wrote:
> > > Am 02.04.20 um 23:08 schrieb Richard Purdie:
> > >> On Thu, 2020-04-02 at 21:51 +0200, Bernd Bauer wrote:
> > >>> If the git server needs authentication the credentials are
> > >>> encoded in the URL of the repositories.
> > >>> The credentials from the main repository are deposited in the
> > >>> recipe so main repository can still be cloned.
> > >>>
> > >>> But the URLs from the submodules are listed in the .gitmodules
> > >>> file.
> > >>> The submodule url is encoded with an username and a password
> > >>> or a bitbucket URL token. See example.
> > >>>
> > >>> The password is not stored in the ud.user but in the ud.pswd
> > >>> variable. So in this case the url is made up by ud.user and
> > >>> ud.pswd.
> > >>>
> > >>> Example:
> > >>> [submodule "sub1"]
> > >>>          path = sub1
> > >>>          url = https://user:password@test.org/url/to/sub1
> > >>>
> > >>> Signed-off-by: Bernd Bauer <bernd.bauer@gmx.at>
> > >>> ---
> > >>>   bitbake/lib/bb/fetch2/git.py | 4 +++-
> > >>>   1 file changed, 3 insertions(+), 1 deletion(-)
> > >>
> > >> We have had requests for this before and we've said "no" since
> > >> encouraging people to put passwords in urls is bad and it leads to
> > >> people making accidental exposures. Its basically too risky.
> > >>
> > >> For git submodules the line becomes blurred.
> > >>
> > >> I'm open to the opinions of others but in this form the patch applies
> > >> to git and gitsm and that in itself makes it more risky.
> > >>
> > >> I do understand why people want this, equally it really isn't a great
> > >> idea in general :/.
> > >>
> > >> Cheers,
> > >>
> > >> Richard
> > >
> > > Hi!
> > >
> > > Of course it is not a good idea to write the credentials directly
> > > in the recipe or in the .gitmodules.
> > > Unfortunately I have no other choice than to encode the username
> > > and password in the URL. This GIT server only allows HTTPS with
> > > authentication. No SSH keys, no anonymous checkout.
> >
> > perhaps you should talk to your infosec about this.
> > this is unusual setup, using key based authentication is far better than
> > username/password mechanism.
> 
> Unfortunately there are some projects which haven't got that message.
> Are you familiar with the RDK?

LOL


> > > But without my patch the result would be the same.
> > > I would have the URL with username and password in the
> > > recipe and also in the submodules.
> > > The only difference would be that I would have to define a
> > > task in the recipe to check out the submodules.
> > > So my recipe is getting complexer.
> > >
> > > do_configure_prepend() {
> > >    cd ${WORKDIR}/git
> > >    git submodules update --init --recursive
> > > }
> > >
> > >  From my point of view, my patch would be more like
> > > fixing a bug than an extension.
> >
> > >
> > > Just my two cents...
> > >
> > > Greets Bernd
> > >
> > >
> > >
> > >
> > 

> 

