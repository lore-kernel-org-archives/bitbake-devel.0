Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Scx81-0003nr-Oo for bitbake-devel@lists.openembedded.org;
	Fri, 08 Jun 2012 13:13:17 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q58B2kXs014731;
	Fri, 8 Jun 2012 12:02:46 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 14673-01; Fri,  8 Jun 2012 12:02:42 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q58B2c3H014725
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 8 Jun 2012 12:02:39 +0100
Message-ID: <1339153360.30460.4.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Shane Wang <shane.wang@intel.com>
Date: Fri, 08 Jun 2012 12:02:40 +0100
In-Reply-To: <cover.1338612620.git.shane.wang@intel.com>
References: <cover.1338612620.git.shane.wang@intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/3] Hob: some fixes
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
X-List-Received-Date: Fri, 08 Jun 2012 11:13:18 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sat, 2012-06-02 at 12:54 +0800, Shane Wang wrote:
> Here are some fixes for Hob:
>  - lower the limitation of PyGTK so Ubuntu 10.04 can still use Hob
>  - we will continue to change Hob, add versions for compatibility check
>  - some special chars can be shown as markup, replace them with escape chars
>     & -> &amp;
>     < -> &lt;
>     > -> &gt;
>     and so on
> 
> The following changes since commit de4cdfd6bc1280ac7ac0559b87734d26294ef773:
> 
>   documentation/kernel-manual/kernel-how-to.xml: Updated to kernel 3.4 (2012-05-31 21:16:55 +0100)
> 
> are available in the git repository at:
>   git://git.pokylinux.org/poky-contrib shane/newproxy
>   http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=shane/newproxy
> 
> Shane Wang (3):
>   Hob: lower the limitation for PyGTK
>   Hob: add versions for compatibility check between Hob and templates
>   Hob: Interpret some special characters for label markup

Merged to master, thanks.

Richard



