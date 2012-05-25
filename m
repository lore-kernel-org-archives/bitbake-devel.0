Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SXrec-0000zI-4O for bitbake-devel@lists.openembedded.org;
	Fri, 25 May 2012 12:21:54 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4PABeGa032599;
	Fri, 25 May 2012 11:11:40 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 31927-05; Fri, 25 May 2012 11:11:36 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4PABV92032593
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 25 May 2012 11:11:33 +0100
Message-ID: <1337940691.20169.20.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Liming An <limingx.l.an@intel.com>
Date: Fri, 25 May 2012 11:11:31 +0100
In-Reply-To: <cover.1337857307.git.limingx.l.an@intel.com>
References: <cover.1337857307.git.limingx.l.an@intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/1] Hob: bug-fixes
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
X-List-Received-Date: Fri, 25 May 2012 10:21:54 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2012-05-24 at 19:07 +0800, Liming An wrote:
> The following changes since commit 6558abda67956e4fab1304b0cdf03c65f18fabd5:
> 
>   qemu: disable vnc-jpeg compression (2012-05-24 08:53:57 +0100)
> 
> are available in the git repository at:
>   git://git.pokylinux.org/poky-contrib limx/hob-bug-fixes-continue
>   http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=limx/hob-bug-fixes-continue
> 
> Liming An (1):
>   Hob:fixed the issue of primary button is not an 'orange hob button'
> 
>  bitbake/lib/bb/ui/crumbs/imagedetailspage.py |   27 +++++++++++++++----------
>  meta/conf/machine/include/qemu.inc           |    2 +-
>  2 files changed, 17 insertions(+), 12 deletions(-)

Merged to master, thanks.

Richard




