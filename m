Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Qoekk-0002eT-BB for bitbake-devel@lists.openembedded.org;
	Wed, 03 Aug 2011 18:57:06 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p73GqhP4027714;
	Wed, 3 Aug 2011 17:52:43 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 27440-06; Wed,  3 Aug 2011 17:52:39 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p73Gqad9027708
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 3 Aug 2011 17:52:36 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Lock <josh@linux.intel.com>
In-Reply-To: <cover.1312334047.git.josh@linux.intel.com>
References: <cover.1312334047.git.josh@linux.intel.com>
Date: Wed, 03 Aug 2011 17:52:17 +0100
Message-ID: <1312390337.2344.704.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/6] hob bug fixes
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
X-List-Received-Date: Wed, 03 Aug 2011 16:57:06 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2011-08-02 at 18:17 -0700, Joshua Lock wrote:
> This includes fixes for some usability quirks in hob. The shared runningbuild
> component has had its behaviour modified and most of this series deals with
> adding machinery to optionally enable the old behaviour and then doing so for
> the hob.
> 
> The following changes since commit 1009ca570a750a00b0e60afcc30ead070c7b310a:
> 
>   hob: remove temporary directory on program shutdown (2011-07-30 12:21:18 -0700)
> 
> are available in the git repository at:
>   git://github.com/incandescant/bitbake hob
>   https://github.com/incandescant/bitbake/tree/hob
> 
> Joshua Lock (6):
>   bb/ui/hob: save changes to bblayers.conf when using Add Layer menu
>     item
>   bb/ui/crumbs/runningbuild: optionally create list entries
>     sequentially
>   bb/ui/hob: show build messages are displayed in the order they're
>     received
>   ui/crumbs/runningbuild: add optional readonly mode, default off
>   bb/ui/hob: disable editing in the build messages tree view
>   bb/ui/crumbs/runningbuild: emit signal when command fails with exit
>     signal
> 
>  lib/bb/ui/crumbs/runningbuild.py |   48 +++++++++++++++++++++++--------------
>  lib/bb/ui/hob.py                 |    5 ++-
>  2 files changed, 33 insertions(+), 20 deletions(-)

Merged to master, thanks.

Richard




