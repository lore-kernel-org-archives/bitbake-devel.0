Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1QUmgq-00057M-Kd for bitbake-devel@lists.openembedded.org;
	Thu, 09 Jun 2011 23:22:56 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p59LJZHc018260;
	Thu, 9 Jun 2011 22:19:35 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 17870-06; Thu,  9 Jun 2011 22:19:31 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p59LJS0Z018254
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 9 Jun 2011 22:19:28 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Scott Garman <scott.a.garman@intel.com>
In-Reply-To: <1307643186-28341-1-git-send-email-scott.a.garman@intel.com>
References: <1307643186-28341-1-git-send-email-scott.a.garman@intel.com>
Date: Thu, 09 Jun 2011 22:19:18 +0100
Message-ID: <1307654358.15712.186.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] cache.py: fix bitbake -s command
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
X-List-Received-Date: Thu, 09 Jun 2011 21:22:56 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2011-06-09 at 11:13 -0700, Scott Garman wrote:
> This uses the correct index of self.pn when setting up cachedata's
> pkg_pn, fixing the output of bitbake -s.
> 
> This fixes bug [YOCTO #1149].
> 
> Signed-off-by: Scott Garman <scott.a.garman@intel.com>
> ---
>  lib/bb/cache.py |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Merged to master, good catch thanks!

Richard



