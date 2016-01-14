Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 92FB1731CA
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Jan 2016 15:26:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u0EFQ47K031675; Thu, 14 Jan 2016 15:26:04 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id T1eVIhALLcNV; Thu, 14 Jan 2016 15:26:04 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u0EFPxVn031670
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 14 Jan 2016 15:26:00 GMT
Message-ID: <1452785159.28375.135.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>, Andre McCurdy
	<armccurdy@gmail.com>
Date: Thu, 14 Jan 2016 15:25:59 +0000
In-Reply-To: <90f0d7cacc2743e58535b16f6fe316bd@XBOX02.axis.com>
References: <1452172732.7598.114.camel@linuxfoundation.org>
	<CAJ86T=Xb6HHZm0BaqtGeCUknP1_dTy6t1L7LtZru9F+=j-BmSg@mail.gmail.com>
	<1452723582.28375.118.camel@linuxfoundation.org>
	<90f0d7cacc2743e58535b16f6fe316bd@XBOX02.axis.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] fetch/git: Change to use clearer ssh url syntax for broken servers
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
X-List-Received-Date: Thu, 14 Jan 2016 15:26:09 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2016-01-14 at 14:47 +0000, Peter Kjellerstedt wrote:
> > -----Original Message-----
> > From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-
> > devel-bounces@lists.openembedded.org] On Behalf Of Richard Purdie
> > Sent: den 13 januari 2016 23:20
> > To: Andre McCurdy
> > Cc: bitbake-devel
> > Subject: Re: [bitbake-devel] [PATCH] fetch/git: Change to use
> > clearer
> > ssh url syntax for broken servers
> > 
> > On Wed, 2016-01-13 at 13:37 -0800, Andre McCurdy wrote:
> > > On Thu, Jan 7, 2016 at 5:18 AM, Richard Purdie
> > > <richard.purdie@linuxfoundation.org> wrote:
> > > > Some servers, e.g. bitbucket.org can't cope with ssh:// as part
> > > > of
> > > > the git url syntax. git itself is happy enough with this but
> > > > you
> > > > get server side errors when using it.
> > > > 
> > > > This changes the git fetcher to use the more common ssh url
> > > > format
> > > > which also means we need a : before the path.
> > > 
> > > This seems to break SRC_URIs using ssh to access self hosted git
> > > servers setup following the process described here:
> > > 
> > >   https://git-scm.com/book/en/v2/Git-on-the-Server-Setting-Up-the
> > > -Ser
> > > ver
> > > 
> > > An example of such a SRC_URI, which now fails to work:
> > > 
> > >   SRC_URI = "git
> > > ://git@mylocalserver.com:/opt/git/myrepo.git;protocol=ssh"
> > 
> > Does:
> > 
> > SRC_URI = "git
> > ://git@mylocalserver.com/opt/git/myrepo.git;protocol=ssh"
> > 
> > work though?
> 
> The above may work, but this does not any more:
> 
> SRC_URI = "git
> ://git@mylocalserver.com:12345/opt/git/myrepo.git;protocol=ssh"
> 
> I.e., when the Git server requires a port, like our Gerrit server
> does...
> Please revert the commit and solve the actual problem with
> bitbucket.org 
> some other way.

I'm not sure there is one other than special casing bitbucket urls in
the fetcher.

With Andre's case, we clearly don't support cut and paste of urls into
SRC_URI so I'm less concerned about that but the above is more of an
issue.

The url parsing in the fetcher should really be aware of port numbers
and I suspect if we do that, we can fix the above. I'm not going to
instantly revert the other change over this.

I'd also state that if you expect particular syntaxes to work, I'd
strongly encourage they're in the selftests for the fetcher. The self
tests didn't show any regressions...

Cheers,

Richard


