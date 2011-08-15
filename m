Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Qssee-0007Aw-U5 for bitbake-devel@lists.openembedded.org;
	Mon, 15 Aug 2011 10:36:17 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p7F8VdFB015110;
	Mon, 15 Aug 2011 09:31:39 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 15017-01; Mon, 15 Aug 2011 09:31:35 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p7F8VY0u015093
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 15 Aug 2011 09:31:34 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1313165343.git.paul.eggleton@linux.intel.com>
References: <cover.1313165343.git.paul.eggleton@linux.intel.com>
Date: Mon, 15 Aug 2011 09:31:31 +0100
Message-ID: <1313397091.14274.542.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/4] bitbake-layers minor improvements
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
X-List-Received-Date: Mon, 15 Aug 2011 08:36:17 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2011-08-12 at 17:13 +0100, Paul Eggleton wrote:
> Several improvements to the help and show_layers function in
> bitbake-layers.
> 
> The changes are available (against Poky, but apply cleanly against bitbake
> master with -p2) at:
>   git://git.pokylinux.org/poky-contrib paule/bitbake-layers-3
>   http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=paule/bitbake-layers-3
> 
> Paul Eggleton (4):
>   bitbake-layers: improve default command help
>   bitbake-layers: show help with no command specified
>   bitbake-layers: use logger.plain instead of info
>   bitbake-layers: extend show_layers

Merged to master, thanks (with the log change issue handled).

Cheers,

Richard



