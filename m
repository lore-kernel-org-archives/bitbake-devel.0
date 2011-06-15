Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1QWn63-0000wM-Pm for bitbake-devel@lists.openembedded.org;
	Wed, 15 Jun 2011 12:13:16 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p5FA9mNA025297;
	Wed, 15 Jun 2011 11:09:48 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 25229-02; Wed, 15 Jun 2011 11:09:44 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p5FA9dhx025291
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 15 Jun 2011 11:09:40 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Scott Garman <scott.a.garman@intel.com>
In-Reply-To: <1308095098-8929-1-git-send-email-scott.a.garman@intel.com>
References: <1308095098-8929-1-git-send-email-scott.a.garman@intel.com>
Date: Wed, 15 Jun 2011 11:09:37 +0100
Message-ID: <1308132577.15712.388.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] make exception handling syntax consistent
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
X-List-Received-Date: Wed, 15 Jun 2011 10:13:16 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2011-06-14 at 16:44 -0700, Scott Garman wrote:
> Update exception handling syntax to use the modern style:
> except ExcType as localvar
> 
> Signed-off-by: Scott Garman <scott.a.garman@intel.com>
> ---
>  bin/bitbake               |    2 +-
>  lib/bb/cooker.py          |   10 +++++-----
>  lib/bb/data.py            |    2 +-
>  lib/bb/fetch2/__init__.py |    4 ++--
>  lib/bb/process.py         |    2 +-
>  lib/bb/pysh/builtin.py    |   10 +++++-----
>  lib/bb/pysh/interp.py     |   14 +++++++-------
>  lib/bb/runqueue.py        |    2 +-
>  lib/bb/server/process.py  |    4 ++--
>  lib/prserv/serv.py        |    6 +++---
>  10 files changed, 28 insertions(+), 28 deletions(-)

Applied, thanks Scott.

Cheers,

Richard



