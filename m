Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1QwPps-0004F3-Sn for bitbake-devel@lists.openembedded.org;
	Thu, 25 Aug 2011 04:38:29 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p7P2XeRQ026243;
	Thu, 25 Aug 2011 03:33:40 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 25638-07; Thu, 25 Aug 2011 03:33:36 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p7P2XVTh026237
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 25 Aug 2011 03:33:34 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Lock <josh@linux.intel.com>
In-Reply-To: <cover.1314217450.git.josh@linux.intel.com>
References: <cover.1314217450.git.josh@linux.intel.com>
Date: Wed, 24 Aug 2011 19:33:30 -0700
Message-ID: <1314239610.5939.175.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/3] Fix some bugs and usability issues in hob
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
X-List-Received-Date: Thu, 25 Aug 2011 02:38:29 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2011-08-24 at 13:25 -0700, Joshua Lock wrote:
> Jessica Zhang identified some issues in hob which are addressed by this
> series.
> 
> The following changes since commit 692c2fcead5c82249359ad54d2c7941d087a2eb3:
> 
>   usermanual: The git fetcher defaults to the git protocol (or file) (2011-08-23 09:59:50 -0700)
> 
> are available in the git repository at:
>   git://github.com/incandescant/bitbake hob
>   https://github.com/incandescant/bitbake/tree/hob
> 
> Joshua Lock (3):
>   hob: don't set PARALLEL_MAKE and BB_NUMBER_THREADS based on cpu count
>   bb/ui/crumbs/tasklistmodel: fix find_reverse_depends method
>   hob: disable some menu entries whilst build is in progress

Merged to master, thanks.

Richard



