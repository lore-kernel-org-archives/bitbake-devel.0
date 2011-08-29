Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Qy1N4-0000NR-Fc for bitbake-devel@lists.openembedded.org;
	Mon, 29 Aug 2011 14:55:22 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p7TCoSja002981;
	Mon, 29 Aug 2011 13:50:28 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 17826-08; Mon, 29 Aug 2011 13:50:24 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p7TCoMxJ002975
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 29 Aug 2011 13:50:23 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Lock <josh@linux.intel.com>
In-Reply-To: <cover.1314409608.git.josh@linux.intel.com>
References: <cover.1314409608.git.josh@linux.intel.com>
Date: Mon, 29 Aug 2011 13:50:14 +0100
Message-ID: <1314622214.5939.284.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/2] Small UI patches
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
X-List-Received-Date: Mon, 29 Aug 2011 12:55:22 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2011-08-26 at 18:48 -0700, Joshua Lock wrote:
> Most interesting is the second patch to add a Copy item to the right-click
> menu for logs in RunningBuildTreeView.
> 
> This means users of hob and goggle can copy/paste the log contents right from
> the GUI as well as submitting the log contents to pastebin.
> 
> The following changes since commit 0423587db09f6f28cf9d801f5657a84157f42dbe:
> 
>   hob: disable some menu entries whilst build is in progress (2011-08-24 19:32:42 -0700)
> 
> are available in the git repository at:
>   git://github.com/incandescant/bitbake hob
>   https://github.com/incandescant/bitbake/tree/hob
> 
> Joshua Lock (2):
>   ui/crumbs/tasklistmodel: don't add same item to binb column more than
>     once
>   ui/crumbs/runningbuild: add a 'Copy' item to the messages right-click
>     menu

Merged to master, thanks.

Richard



