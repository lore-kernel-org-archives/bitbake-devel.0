Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SW0Qr-0006x0-RY for bitbake-devel@lists.openembedded.org;
	Sun, 20 May 2012 09:20:02 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4K79sxi006181;
	Sun, 20 May 2012 08:09:54 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 03035-08; Sun, 20 May 2012 08:09:49 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4K79ib2006175
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 20 May 2012 08:09:45 +0100
Message-ID: <1337497783.28145.15.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Liming An <limingx.l.an@intel.com>
Date: Sun, 20 May 2012 08:09:43 +0100
In-Reply-To: <cover.1336999687.git.limingx.l.an@intel.com>
References: <cover.1336999687.git.limingx.l.an@intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/3] Hob: bug-fixes
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
X-List-Received-Date: Sun, 20 May 2012 07:20:02 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2012-05-14 at 20:51 +0800, Liming An wrote:
> The following changes since commit 12b4543ac9f54c0db0ee4a7ee546a71946a051f8:
> 
>   classes/rootfs_*: fix splitting package dependency strings (2012-05-13 20:09:56 +0100)
> 
> are available in the git repository at:
>   git://git.pokylinux.org/poky-contrib limx/hob-bug-fixes-continue
>   http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=limx/hob-bug-fixes-continue
> 
> Liming An (3):
>   Hob: apply a line length to consistantly across 'base image'
>     descriptions
>   Hob: add '--select a machine--' and '--select a base image--' to GUI
>   Hob:add function about clicked a row to load image file for 'my
>     images' page

I took patches 1 and 3, I did not take the second item above. Please
resend with the change Dongxiao suggested.

Cheers,

Richard



