Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1QlK7C-0005Td-7P for bitbake-devel@lists.openembedded.org;
	Mon, 25 Jul 2011 14:18:30 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p6PBovAL017509;
	Mon, 25 Jul 2011 12:50:57 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 16301-07; Mon, 25 Jul 2011 12:50:53 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p6PBonor017503
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 25 Jul 2011 12:50:50 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Lock <josh@linux.intel.com>
In-Reply-To: <cover.1311355172.git.josh@linux.intel.com>
References: <cover.1311355172.git.josh@linux.intel.com>
Date: Mon, 25 Jul 2011 12:50:43 +0100
Message-ID: <1311594643.2344.178.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/1] Store a data object containing the initial environment v2
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
X-List-Received-Date: Mon, 25 Jul 2011 12:18:30 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2011-07-22 at 10:20 -0700, Joshua Lock wrote:
> Take a copy of the environment in the bitbake entry point and pass it to the
> cooker for saving in a data store.
> 
> Tested with bitbake and bitbake-layers.
> 
> Sanity prevails thanks to diligent code review.
> 
> The following changes since commit abc67ed6921c98ed581f101ec1acc589fd9ce7e9:
> 
>   bitbake/utils: Add contains helper function from lib.oe.utils (2011-07-22 12:11:01 +0100)
> 
> are available in the git repository at:
>   git://github.com/incandescant/bitbake initialenv
>   https://github.com/incandescant/bitbake/tree/initialenv
> 
> Joshua Lock (1):
>   bitbake|cooker: save a copy of the environment when BitBake is
>     started

Merged to master, thanks.

Richard



