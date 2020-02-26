Return-Path: <rpjday@crashcourse.ca>
Received: from cpanel7.indieserve.net (cpanel7.indieserve.net [199.212.143.8])
	by mail.openembedded.org (Postfix) with ESMTP id 03D1561680
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 26 Feb 2020 01:07:28 +0000 (UTC)
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com
	([174.114.57.56]:59818 helo=localhost.localdomain)
	by cpanel7.indieserve.net with esmtpsa (TLS1.2) tls
	TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1j6lAf-00AO1R-9v; Tue, 25 Feb 2020 20:07:29 -0500
Date: Tue, 25 Feb 2020 20:07:27 -0500 (EST)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To: Andre McCurdy <armccurdy@gmail.com>
In-Reply-To: <CAJ86T=VvTrTLQLUeqQh8stS1ihQR4UQwi9faRG--FKP-wcLbqA@mail.gmail.com>
Message-ID: <alpine.LFD.2.21.2002252006080.10052@localhost.localdomain>
References: <20200225162245.Horde.i6DmVIhAUjVbUGUQKtyMoua@crashcourse.ca>
	<CAJ86T=VvTrTLQLUeqQh8stS1ihQR4UQwi9faRG--FKP-wcLbqA@mail.gmail.com>
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse,
	please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel7.indieserve.net
X-AntiAbuse: Original Domain - lists.openembedded.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel7.indieserve.net: authenticated_id:
	rpjday+crashcourse.ca/only user confirmed/virtual account not
	confirmed
X-Authenticated-Sender: cpanel7.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: is there a bitbake equivalent to "touch"ing a file for gnu make?
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
X-List-Received-Date: Wed, 26 Feb 2020 01:07:29 -0000
Content-Type: multipart/mixed; boundary="8323328-2008259660-1582679249=:10052"

--8323328-2008259660-1582679249=:10052
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 25 Feb 2020, Andre McCurdy wrote:

> On Tue, Feb 25, 2020 at 1:22 PM <rpjday@crashcourse.ca> wrote:
> >
> >    colleague emails me the following puzzler … current project based on
> > wind river linux 9 (so effectively morty 2.2), so it has bitbake 1.32.
> > apparently, for a specific recipe, there are intermittent build errors
> > which she suspects are caused by a race condition in the build of that
> > recipe.
> >
> >    *but* that build error only occurs when something about the underlying
> > layers have changed; as in, someone checked *something* in somewhere
> > forcing at least something to be rebuilt, and that error does not
> > even occur on *all* rebuilds, just some of them. so the question is,
> > which underlying recipe change and rebuild could be triggering this?
> >
> >    she *suspects* it might be openssl, as their project is making
> > regular changes to openssl, and that recipe seems to be an ultimate
> > dependency for quite a number of recipes, so she's just guessing
> > that might be the cause.
> >
> >    in order to test this, she is currently running through a loop
> > wherein, in order to kick off at least some recipe rebuilds, she
> > makes some innocuous change to openssl, causing it to be rebuilt,
> > which then rebuilds all recipes that depend on it and so on.
> >
> >    yuck.
> >
> >    on the other hand, i couldn't immediately suggest anything
> > cleaner. my thought was to (somehow) fake a rebuild of openssl
> > (perhaps by invalidating some timestamp), but that's not going
> > to work as once it's rebuilt, it's just going to look like it
> > did before, so nothing else will be rebuilt.
>
> Not sure what you mean by "fake" a rebuild. You can force a rebuild
> by e.g. manually changing something in the recipe such as PR,
> running "bitbake -c cleansstate openssl", ...

  are you sure about that? i can test this when i get home, but i
thought just cleaning the sstate would not force rebuilds of the rest
of those recipes, just that one.

rday

--8323328-2008259660-1582679249=:10052--
