Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Rsyhr-000557-10 for bitbake-devel@lists.openembedded.org;
	Thu, 02 Feb 2012 16:36:15 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q12FSEL7008137;
	Thu, 2 Feb 2012 15:28:14 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 06622-10; Thu,  2 Feb 2012 15:28:06 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q12FS3Bs008116
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 2 Feb 2012 15:28:05 GMT
Message-ID: <1328196487.13744.193.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Shane Wang <shane.wang@intel.com>
Date: Thu, 02 Feb 2012 15:28:07 +0000
In-Reply-To: <213886d7dc877c93686c896fe4584011bb4ce2ec.1328162622.git.shane.wang@intel.com>
References: <cover.1328162622.git.shane.wang@intel.com>
	<213886d7dc877c93686c896fe4584011bb4ce2ec.1328162622.git.shane.wang@intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] [V2] bitbake: add description cache into cache_extra
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
X-List-Received-Date: Thu, 02 Feb 2012 15:36:15 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2012-02-02 at 14:05 +0800, Shane Wang wrote:
> Enable bitbake to cache description into the extra cache file and Hob2
> will get its value for core-image-foo.
> 
> Signed-off-by: Shane Wang <shane.wang@intel.com>
> ---
>  bitbake/lib/bb/cache.py       |    9 ---------
>  bitbake/lib/bb/cache_extra.py |    3 +++
>  bitbake/lib/bb/cooker.py      |    2 ++
>  3 files changed, 5 insertions(+), 9 deletions(-)

I've merged this patch thanks.

In future please work on better commit messages since this one doesn't
mention the removal of the duplicate cache entries. When I took the
patch I've tweaked the commit message in this case.

Cheers,

Richard



