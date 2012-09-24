Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TG6ov-0000A3-Gz for bitbake-devel@lists.openembedded.org;
	Mon, 24 Sep 2012 13:27:26 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q8OBEVRZ028119;
	Mon, 24 Sep 2012 12:14:31 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 27712-05; Mon, 24 Sep 2012 12:14:26 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q8OBEMpA028113
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 24 Sep 2012 12:14:23 +0100
Message-ID: <1348485263.8662.5.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Date: Mon, 24 Sep 2012 12:14:23 +0100
In-Reply-To: <cover.1348238757.git.paul.eggleton@linux.intel.com>
References: <cover.1348238757.git.paul.eggleton@linux.intel.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH v2 0/4] More Hob fixes
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
X-List-Received-Date: Mon, 24 Sep 2012 11:27:26 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2012-09-21 at 15:47 +0100, Paul Eggleton wrote:
> The following changes (against Poky, but apply cleanly with -p2 against
> bitbake master) are available in the git repository at:
> 
>   git://git.yoctoproject.org/poky-contrib paule/hob-fixes-2
>   http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/hob-fixes-2
> 
> Paul Eggleton (4):
>   hob: don't show error dialog for errors during building
>   hob: allow configuring default machine using HOB_MACHINE
>   hob: remove confirmation dialog on close
>   hob: fix Gtk-WARNINGs due to invalid markup on Back button

Merged to master, thanks.

Richard



