Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1T4AfR-0008Nl-Mv for bitbake-devel@lists.openembedded.org;
	Wed, 22 Aug 2012 15:08:18 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q7MCu70u003185;
	Wed, 22 Aug 2012 13:56:07 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 02380-08; Wed, 22 Aug 2012 13:56:03 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q7MCtwcu003179
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 22 Aug 2012 13:55:59 +0100
Message-ID: <1345640158.3907.112.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Date: Wed, 22 Aug 2012 13:55:58 +0100
In-Reply-To: <cover.1345568965.git.paul.eggleton@linux.intel.com>
References: <cover.1345568965.git.paul.eggleton@linux.intel.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/3] bitbake-layers fixes
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
X-List-Received-Date: Wed, 22 Aug 2012 13:08:18 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2012-08-21 at 18:11 +0100, Paul Eggleton wrote:
> The following changes (against Poky, but apply cleanly with -p2 against
> bitbake master) are available in the git repository at: 
> 
>   git://git.yoctoproject.org/poky-contrib paule/bblayers-fixes
>   http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bblayers-fixes
> 
> Paul Eggleton (3):
>   bitbake/cooker: minor refactor of parseConfiguration()
>   bitbake-layers: avoid full parse for show-layers subcommand
>   bitbake-layers: use parsable title for show-appends

Thanks, merged to master.

Cheers,

Richard



