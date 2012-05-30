Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SZlpb-0005Gl-AW for bitbake-devel@lists.openembedded.org;
	Wed, 30 May 2012 18:33:07 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4UGMloc023362;
	Wed, 30 May 2012 17:22:47 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 23236-03; Wed, 30 May 2012 17:22:43 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4UGMeL8023355
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 30 May 2012 17:22:41 +0100
Message-ID: <1338394960.20169.157.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Date: Wed, 30 May 2012 17:22:40 +0100
In-Reply-To: <cover.1338394341.git.paul.eggleton@linux.intel.com>
References: <cover.1338394341.git.paul.eggleton@linux.intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/5] Checksum / error reporting improvements
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
X-List-Received-Date: Wed, 30 May 2012 16:33:07 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2012-05-30 at 17:17 +0100, Paul Eggleton wrote:
> Some checksum improvements and a few error reporting fixes that I made
> in the process. Note that the varflags change won't do anything without
> the list of exclusions; an appropriate list has been set in a patch
> which will shortly be set to the OE-Core list.
> 
> 
> The following changes (against Poky, but which apply cleanly with -p2
> against BitBake master) are available in the git repository at:
> 
>   git://git.yoctoproject.org/poky-contrib paule/bb-checksum-fixes-2
>   http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bb-checksum-fixes-2
> 
> Paul Eggleton (5):
>   lib/bb/data_smart.py: don't report variable in ExpansionError if not
>     set
>   cooker: fix UnboundLocalError when exception occurs during parsing
>   cooker: report recipe being parsed when ExpansionError occurs
>   lib/bb/fetch2: ignore remote URIs when doing file checksums
>   bitbake: include varflags in checksums

Merged to master, thanks.

Richard



