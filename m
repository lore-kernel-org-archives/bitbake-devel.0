Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SWpTx-0000dm-2Q for bitbake-devel@lists.openembedded.org;
	Tue, 22 May 2012 15:50:37 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4MDeOkW001804;
	Tue, 22 May 2012 14:40:24 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 31894-09; Tue, 22 May 2012 14:40:19 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4MDeF3T001797
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 22 May 2012 14:40:15 +0100
Message-ID: <1337694014.8248.3.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Shane Wang <shane.wang@intel.com>
Date: Tue, 22 May 2012 14:40:14 +0100
In-Reply-To: <cover.1337686256.git.shane.wang@intel.com>
References: <cover.1337686256.git.shane.wang@intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/1] Reimplment proxy settings for Hob
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
X-List-Received-Date: Tue, 22 May 2012 13:50:37 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2012-05-22 at 19:33 +0800, Shane Wang wrote:
> This patch is to reimplement the proxy tab in the advanced settings dialog
> according to the new design by the design team to make it more like Gnome style.
> Please review and check in. Thanks.
> 
> The following changes since commit 2219caa312822cf756b88b07dd70a014404e9cb0:
> 
>   tune-mips64.inc: Add new tune file for mips64 big-endian (2012-05-21 09:59:04 +0100)
> 
> are available in the git repository at:
>   git://git.pokylinux.org/poky-contrib shane/newproxy
>   http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=shane/newproxy
> 
> Shane Wang (1):
>   Hob: reimplement the proxy page

Merged to master, thanks.

Richard



