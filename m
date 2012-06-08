Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Scx6o-0003mM-2L for bitbake-devel@lists.openembedded.org;
	Fri, 08 Jun 2012 13:12:02 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q58B1VK1014653;
	Fri, 8 Jun 2012 12:01:31 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 13899-08; Fri,  8 Jun 2012 12:01:26 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q58B1Oxg014647
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 8 Jun 2012 12:01:25 +0100
Message-ID: <1339153287.30460.3.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Liming An <limingx.l.an@intel.com>
Date: Fri, 08 Jun 2012 12:01:27 +0100
In-Reply-To: <cover.1338546445.git.limingx.l.an@intel.com>
References: <cover.1338546445.git.limingx.l.an@intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/3] Hob: bug fixes
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
X-List-Received-Date: Fri, 08 Jun 2012 11:12:02 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2012-06-01 at 18:36 +0800, Liming An wrote:
> The following changes since commit de4cdfd6bc1280ac7ac0559b87734d26294ef773:
> 
>   documentation/kernel-manual/kernel-how-to.xml: Updated to kernel 3.4 (2012-05-31 21:16:55 +0100)
> 
> are available in the git repository at:
>   git://git.pokylinux.org/poky-contrib limx/hob-bug-fixes-continue
>   http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=limx/hob-bug-fixes-continue
> 
> Liming An (3):
>   Hob: clear the repeated function get_kernel_file_name
>   Hob: fix entry of recipe page can't be edited in case after clicked
>     clear button
>   Hob: fixed a definition not match issue when click choose directflb
>     in package page

Merged to master, thanks.

Richard



