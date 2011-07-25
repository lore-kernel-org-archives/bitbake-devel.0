Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1QlJjj-0004q5-7m for bitbake-devel@lists.openembedded.org;
	Mon, 25 Jul 2011 13:54:15 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p6PBo2hu017491;
	Mon, 25 Jul 2011 12:50:02 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 17416-01; Mon, 25 Jul 2011 12:49:58 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p6PBntYA017479
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 25 Jul 2011 12:49:55 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1311355686.git.paul.eggleton@linux.intel.com>
References: <cover.1311355686.git.paul.eggleton@linux.intel.com>
Date: Mon, 25 Jul 2011 12:49:49 +0100
Message-ID: <1311594589.2344.177.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/6] Misc minor fixes
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
X-List-Received-Date: Mon, 25 Jul 2011 11:54:15 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2011-07-22 at 18:30 +0100, Paul Eggleton wrote:
> Some minor usability-related fixes for bitbake and bitbake-layers.
> 
> The changes (against poky, apply against bitbake master with -p2) are
> available in the git repository at:
>   git://git.pokylinux.org/poky-contrib paule/bitbake-tweaks
>   http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=paule/bitbake-tweaks
> 
> Paul Eggleton (6):
>   bitbake: add note to -b option indicating no dependency handling
>   bitbake/cooker: show a warning when -b is specified
>   bitbake: adjust comments/messages for default server change
>   bitbake-layers: check for errors before parsing
>   bitbake-layers: add command help
>   bitbake-layers: remove unneeded do_EOF

Merged to master, thanks.

Richard



