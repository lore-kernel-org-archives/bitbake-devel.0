Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Soak8-00038Y-Tm for bitbake-devel@lists.openembedded.org;
	Tue, 10 Jul 2012 15:44:45 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q6ADXYI2017236;
	Tue, 10 Jul 2012 14:33:34 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 16817-03; Tue, 10 Jul 2012 14:33:30 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q6ADXRWf017230
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 10 Jul 2012 14:33:28 +0100
Message-ID: <1341927208.24837.9.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Andrei Gherzan <andrei@gherzan.ro>
Date: Tue, 10 Jul 2012 14:33:28 +0100
In-Reply-To: <cover.1341918809.git.andrei@gherzan.ro>
References: <cover.1341918809.git.andrei@gherzan.ro>
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
X-List-Received-Date: Tue, 10 Jul 2012 13:44:45 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2012-07-10 at 14:15 +0300, Andrei Gherzan wrote:
> Andrei Gherzan (5):
>   fetch2/bzr.py: Use "protocol" parameter and warn user if recipe is
>     using "proto"
>   fetch2/git.py: Use "protocol" parameter and warn user if recipe is
>     using "proto"
>   fetch2/hg.py: Use "protocol" parameter and warn user if recipe is
>     using "proto"
>   fetch2/osc.py: Use "protocol" parameter and warn user if recipe is
>     using "proto"
>   fetch2/svn.py: Use "protocol" parameter and warn user if recipe is
>     using "proto"
> 
>  bitbake/lib/bb/fetch2/bzr.py |    7 ++++++-
>  bitbake/lib/bb/fetch2/git.py |    4 ++++
>  bitbake/lib/bb/fetch2/hg.py  |    7 ++++++-
>  bitbake/lib/bb/fetch2/osc.py |    7 ++++++-
>  bitbake/lib/bb/fetch2/svn.py |    7 ++++++-
>  5 files changed, 28 insertions(+), 4 deletions(-)

How about putting this check into __init__.py and then just setting the
protocol parameter instead if its used? We can then change the backends
just to use procotol right now.

Cheers,

Richard




