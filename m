Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SWpTa-0000cZ-Hn for bitbake-devel@lists.openembedded.org;
	Tue, 22 May 2012 15:50:14 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4MDe3XT001788;
	Tue, 22 May 2012 14:40:03 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 00826-04; Tue, 22 May 2012 14:39:59 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4MDds5u001775
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 22 May 2012 14:39:55 +0100
Message-ID: <1337693993.8248.2.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Dongxiao Xu <dongxiao.xu@intel.com>
Date: Tue, 22 May 2012 14:39:53 +0100
In-Reply-To: <846c8fdef02624aae892fe6662b66bc4047aaad8.1337655950.git.dongxiao.xu@intel.com>
References: <cover.1337655950.git.dongxiao.xu@intel.com>
	<846c8fdef02624aae892fe6662b66bc4047aaad8.1337655950.git.dongxiao.xu@intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/2] Hob: Add filter for images listed in image combo
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
X-List-Received-Date: Tue, 22 May 2012 13:50:14 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2012-05-22 at 11:08 +0800, Dongxiao Xu wrote:
> Define BBUI_IMAGE_WHITE_PATTERN variable to indicate which image is
> allowed to be displayed in image combobox.
> 
> Define BBUI_IMAGE_BLACK_PATTERN variable to indicate which image is NOT
> allowed to be displayed in image combobox.
> 
> This fixes [YOCTO #1581]
> 
> Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
> ---
>  lib/bb/ui/crumbs/builder.py                |    4 +++
>  lib/bb/ui/crumbs/hobeventhandler.py        |    2 +
>  lib/bb/ui/crumbs/imageconfigurationpage.py |   37 +++++++++++++++++++++++++---
>  3 files changed, 39 insertions(+), 4 deletions(-)

Merged to master, thanks.

Richard



