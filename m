Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1THGRa-0000oq-Qs for bitbake-devel@lists.openembedded.org;
	Thu, 27 Sep 2012 17:56:07 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q8RFhCiE000325;
	Thu, 27 Sep 2012 16:43:12 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 32240-07; Thu, 27 Sep 2012 16:43:07 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q8RFh2Iu000319
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 27 Sep 2012 16:43:03 +0100
Message-ID: <1348760583.11186.3.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Robert Yang <liezhi.yang@windriver.com>
Date: Thu, 27 Sep 2012 16:43:03 +0100
In-Reply-To: <a396909f81ca30ac584002d0fe1b672afdefc46e.1348646054.git.liezhi.yang@windriver.com>
References: <cover.1348646054.git.liezhi.yang@windriver.com>
	<a396909f81ca30ac584002d0fe1b672afdefc46e.1348646054.git.liezhi.yang@windriver.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org, Zhenfeng.Zhao@windriver.com
Subject: Re: [PATCH 1/1] fetch2: add "-d" option to cpio
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
X-List-Received-Date: Thu, 27 Sep 2012 15:56:07 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2012-09-26 at 17:07 +0800, Robert Yang wrote:
> Add "-d" option to cpio since it is useful:
>   -d
>   --make-directories
>   Create leading directories where needed.
> 
> [YOCTO #3137]
> 
> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
> ---
>  bitbake/lib/bb/fetch2/__init__.py |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

Merged to master, thanks.

Richard



