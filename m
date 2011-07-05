Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Qe5l2-0005dq-IB for bitbake-devel@lists.openembedded.org;
	Tue, 05 Jul 2011 15:33:44 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p65DTsoe031605;
	Tue, 5 Jul 2011 14:29:54 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 31191-08; Tue,  5 Jul 2011 14:29:50 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p65DTmXC031599
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 5 Jul 2011 14:29:48 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1309872199.git.paul.eggleton@linux.intel.com>
References: <cover.1309872199.git.paul.eggleton@linux.intel.com>
Date: Tue, 05 Jul 2011 14:29:16 +0100
Message-ID: <1309872556.20015.707.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/2] Fix bitbake-layers errors
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
X-List-Received-Date: Tue, 05 Jul 2011 13:33:44 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2011-07-05 at 14:25 +0100, Paul Eggleton wrote:
> These patches fix two issues with bitbake-layers caused by interaction
> between several recent bitbake patches.
> 
> The changes are available (against Poky, but apply cleanly against bitbake
> master with -p2) at:
>   git://git.pokylinux.org/poky-contrib paule/bitbake-layers-fix
>   http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=paule/bitbake-layers-fix
> 
> Paul Eggleton (2):
>   bitbake-layers: fix sorting by package name for cooker change
>   bitbake-layers: fix error on startup caused by recent cooker change

Merged to master, thanks.

Richard



