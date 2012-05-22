Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SWpXF-0000iR-Q2 for bitbake-devel@lists.openembedded.org;
	Tue, 22 May 2012 15:54:01 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4MDhnYH001864;
	Tue, 22 May 2012 14:43:49 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 31894-10; Tue, 22 May 2012 14:43:45 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4MDheGc001853
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 22 May 2012 14:43:41 +0100
Message-ID: <1337694219.8248.6.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Chris Larson <clarson@kergoth.com>
Date: Tue, 22 May 2012 14:43:39 +0100
In-Reply-To: <CABcZANkcJQsc2Up1umRX1ek3m+waB-Pq3cFYOCQb3A+4Uh0RNw@mail.gmail.com>
References: <cover.1337612802.git.peter.seebach@windriver.com>
	<CABcZANkcJQsc2Up1umRX1ek3m+waB-Pq3cFYOCQb3A+4Uh0RNw@mail.gmail.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: v2 [PATCH 0/2] data_smart.py: Track inclusions and assignments
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
X-List-Received-Date: Tue, 22 May 2012 13:54:02 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2012-05-21 at 12:54 -0700, Chris Larson wrote:
> On Mon, May 21, 2012 at 8:10 AM, Peter Seebach
> <peter.seebach@windriver.com> wrote:
> > This revised patch now uses Python's traceback facility to assign
> > meaningful locations (file and function, rather than line) to operations
> > which weren't specified, and correspondingly does not specify file and
> > line when the file name would have been the python code making the
> > assignment; this makes the patch smaller and the output more meaningful.
> >
> > As before, this is a patch to add tracking showing when and how variables
> > got their values, and which configuration files were included from which
> > other configuration files.
> >
> > The following changes since commit 39adb5741d9eee0879d3181be505400dffc60804:
> >  Andrei Gherzan (1):
> >        bb/fetch2/__init__.py: Don't try to compute checksums for directories
> 
> While these still aren't the prettiest, I think they're a lot cleaner
> than they were, and given the obvious value, I think we should
> consider merging them. Richard, thoughts?

I agree, I'd prefer we could find a neater way to do this but our
current structure doesn't lend itself to this and this is not looking
too bad.

My main concerns would be related to performance and since this defaults
to disabled, it shouldn't be too bad. It also does answer an important
question we do keep getting asked, namely, "how did variable X get set
or Y" or "which files did Bitbake actually look at". These changes allow
us to give people a way to answer those questions.

So I want to take a closer look through the patches but I'm leaning
toward merging them. If we find ways to make things neater, great but
this is probably as good a start as we can hope for.

Cheers,

Richard



