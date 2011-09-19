Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1R5c5E-0001QI-OS for bitbake-devel@lists.openembedded.org;
	Mon, 19 Sep 2011 13:32:20 +0200
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.2/8.14.2/Debian-2build1) with ESMTP id
	p8JBXEd7013245; Mon, 19 Sep 2011 12:33:14 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id gyflp8vcdRp1; Mon, 19 Sep 2011 12:33:14 +0100 (BST)
Received: from [192.168.250.158] ([116.246.20.131]) (authenticated bits=0)
	by dan.rpsys.net (8.14.2/8.14.2/Debian-2build1) with ESMTP id
	p8JBX6O1013229
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 19 Sep 2011 12:33:10 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Martin Jansa <martin.jansa@gmail.com>
Date: Mon, 19 Sep 2011 12:26:53 +0100
In-Reply-To: <20110919073802.GA19168@jama.jama.net>
References: <cover.1316158579.git.Martin.Jansa@gmail.com>
	<20110919073802.GA19168@jama.jama.net>
X-Mailer: Evolution 3.1.91- 
Message-ID: <1316431619.14488.3.camel@ted>
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/3] Small fixes for fetch2
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
X-List-Received-Date: Mon, 19 Sep 2011 11:32:21 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2011-09-19 at 09:38 +0200, Martin Jansa wrote:
> On Fri, Sep 16, 2011 at 09:37:24AM +0200, Martin Jansa wrote:
> > The following changes since commit 2d5c71ae78b13e935548fe6ff5174b1c09b3077d:
> > 
> >   fetch2: export LD_LIBRARY_PATH (2011-09-16 09:27:12 +0200)
> > 
> > are available in the git repository at:
> >   git://gitorious.org/shr/bitbake jansa/pull
> > 
> > Martin Jansa (3):
> >   fetch2/git: fix typo logggin/logger
> >   fetch2/git: be more carefull in _contains_ref when checking git log
> >     output
> >   fetch2: export LD_LIBRARY_PATH
> > 
> >  lib/bb/fetch2/__init__.py |    2 +-
> >  lib/bb/fetch2/git.py      |    7 +++++--
> >  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> Hi,
> 
> Is there any reason why this wasn't merged and this 
> http://git.openembedded.org/cgit.cgi/bitbake/commit/?id=38a598731b49c8a0ba0ede570adc33eb1e848235
> was merged instead?

I wasn't seeing emails to bitbake-devel due to some mail filtering
issues after the LinuxFoundation email redirection changes. Those are
fixed now and I've fixed my broken commit.

Cheers,

Richard



