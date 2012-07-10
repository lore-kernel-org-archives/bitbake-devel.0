Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SodAV-0005RZ-4N for bitbake-devel@lists.openembedded.org;
	Tue, 10 Jul 2012 18:20:07 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q6AG8tit018856;
	Tue, 10 Jul 2012 17:08:55 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 18303-06; Tue, 10 Jul 2012 17:08:51 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q6AG8mlN018849
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 10 Jul 2012 17:08:48 +0100
Message-ID: <1341936529.1294.5.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Andrei Gherzan <andrei@gherzan.ro>
Date: Tue, 10 Jul 2012 17:08:49 +0100
In-Reply-To: <CAK18fxH6HH=HtbFA_xbdgFoUfeeTLtfFJhbY8snUSfBgqetXzQ@mail.gmail.com>
References: <cover.1341918809.git.andrei@gherzan.ro>
	<1341927208.24837.9.camel@ted>
	<CAK18fxH6HH=HtbFA_xbdgFoUfeeTLtfFJhbY8snUSfBgqetXzQ@mail.gmail.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/5] Modify fetchers to warn user if "param" is used
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
X-List-Received-Date: Tue, 10 Jul 2012 16:20:07 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2012-07-10 at 18:04 +0300, Andrei Gherzan wrote:
> On Tue, Jul 10, 2012 at 4:33 PM, Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
>         On Tue, 2012-07-10 at 14:15 +0300, Andrei Gherzan wrote:
>         > Andrei Gherzan (5):
>         >   fetch2/bzr.py: Use "protocol" parameter and warn user if
>         recipe is
>         >     using "proto"
>         >   fetch2/git.py: Use "protocol" parameter and warn user if
>         recipe is
>         >     using "proto"
>         >   fetch2/hg.py: Use "protocol" parameter and warn user if
>         recipe is
>         >     using "proto"
>         >   fetch2/osc.py: Use "protocol" parameter and warn user if
>         recipe is
>         >     using "proto"
>         >   fetch2/svn.py: Use "protocol" parameter and warn user if
>         recipe is
>         >     using "proto"
>         >
>         >  bitbake/lib/bb/fetch2/bzr.py |    7 ++++++-
>         >  bitbake/lib/bb/fetch2/git.py |    4 ++++
>         >  bitbake/lib/bb/fetch2/hg.py  |    7 ++++++-
>         >  bitbake/lib/bb/fetch2/osc.py |    7 ++++++-
>         >  bitbake/lib/bb/fetch2/svn.py |    7 ++++++-
>         >  5 files changed, 28 insertions(+), 4 deletions(-)
>         
>         How about putting this check into __init__.py and then just
>         setting the
>         protocol parameter instead if its used? We can then change the
>         backends
>         just to use procotol right now.
>         
>  
> I can add the warning in init but how would i define the local proto
> value to the one defined with parameter "proto"? 

In FetchData::__init__(), add 

        proto = self.parm.get("proto", None)
        if proto and "protocol" not in self.param:
            self.parm["protocol"] = proto

before urldata_init?

Cheers,

Richard



