Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1QoFPO-00025m-OF for bitbake-devel@lists.openembedded.org;
	Tue, 02 Aug 2011 15:53:22 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p72Dn1ML015789;
	Tue, 2 Aug 2011 14:49:01 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 14687-10; Tue,  2 Aug 2011 14:48:57 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p72DmuE0015783
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 2 Aug 2011 14:48:57 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Lock <josh@linux.intel.com>
In-Reply-To: <cover.1312216779.git.josh@linux.intel.com>
References: <cover.1312216779.git.josh@linux.intel.com>
Date: Tue, 02 Aug 2011 14:48:40 +0100
Message-ID: <1312292920.2344.598.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/8] hob - handle errors more gracefully
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
X-List-Received-Date: Tue, 02 Aug 2011 13:53:22 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2011-08-01 at 11:30 -0700, Joshua Lock wrote:
> This series predominantly focuses on better error handling and keeping the
> user informed.
> 
> The following changes since commit c9dd2592434338bdddb3cc6f42e760c86fa9e6bb:
> 
>   hob: fix save/restore of toolchain preferences (2011-07-28 10:58:07 -0700)
> 
> are available in the git repository at:
>   git://github.com/incandescant/bitbake hob
>   https://github.com/incandescant/bitbake/tree/hob
> 
> Joshua Lock (8):
>   ui/crumbs/hobeventhandler: remove unused code
>   hob: unset busy cursor on exit
>   ui/crumbs/hobeventhandler: emit a signal when there's a fatal-error
>   ui/hob: show error and exit if we receive the fatal-error signal
>   ui/crumbs/hobeventhandler: emit a signal when a command fails
>   ui/crumbs/configurator: tweak addLayerConf return values
>   ui/crumbs/layereditor: if layer adding fails show an explanatory
>     dialog
>   hob: remove temporary directory on program shutdown
> 
>  lib/bb/ui/crumbs/configurator.py    |    7 ++-
>  lib/bb/ui/crumbs/hobeventhandler.py |   72 ++++++++++++++++++++++------------
>  lib/bb/ui/crumbs/layereditor.py     |   20 +++++++++-
>  lib/bb/ui/hob.py                    |   36 +++++++++++++----
>  4 files changed, 97 insertions(+), 38 deletions(-)

Merged to master, thanks.

Richard



