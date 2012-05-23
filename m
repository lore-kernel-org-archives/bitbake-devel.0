Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SX8vB-0004nI-QF for bitbake-devel@lists.openembedded.org;
	Wed, 23 May 2012 12:36:02 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4NAPpEE011234;
	Wed, 23 May 2012 11:25:51 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 10563-06; Wed, 23 May 2012 11:25:47 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4NAPg08011228
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 23 May 2012 11:25:43 +0100
Message-ID: <1337768741.8248.54.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Liming An <limingx.l.an@intel.com>
Date: Wed, 23 May 2012 11:25:41 +0100
In-Reply-To: <cover.1337610738.git.limingx.l.an@intel.com>
References: <cover.1337610738.git.limingx.l.an@intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/5] Hob: bug-fixes
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
X-List-Received-Date: Wed, 23 May 2012 10:36:02 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2012-05-21 at 22:41 +0800, Liming An wrote:
> The following changes since commit 2219caa312822cf756b88b07dd70a014404e9cb0:
> 
>   tune-mips64.inc: Add new tune file for mips64 big-endian (2012-05-21 09:59:04 +0100)
> 
> are available in the git repository at:
>   git://git.pokylinux.org/poky-contrib limx/hob-bug-fixes-continue
>   http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=limx/hob-bug-fixes-continue
> 
> Liming An (5):
>   Hob: add '--select a machine--' and '--select a base image--' to GUI
>   Hob: change the build failure scenario as ui design
>   Hob: fixed the issue about bug 'running image' workflow and related
>     view
>   Hob: fixed the line width of base image description view
>   Hob: fixed the issue about the 'run image' page should have the
>     primary bug

Merged to master, thanks.

I'm assuming the question from Shane will be addressed in a follow up
patch.

Cheers,

Richard



