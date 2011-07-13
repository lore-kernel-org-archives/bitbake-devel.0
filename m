Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1QgxgW-0004UN-DO for bitbake-devel@lists.openembedded.org;
	Wed, 13 Jul 2011 13:32:56 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p6DBSvvt028742;
	Wed, 13 Jul 2011 12:28:57 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 28092-08; Wed, 13 Jul 2011 12:28:53 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p6DBSmUj028736
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 13 Jul 2011 12:28:48 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Lock <josh@linux.intel.com>
In-Reply-To: <cover.1310507186.git.josh@linux.intel.com>
References: <cover.1310507186.git.josh@linux.intel.com>
Date: Wed, 13 Jul 2011 12:28:47 +0100
Message-ID: <1310556527.20015.1109.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/3] Bug fixes for the hob GUI
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
X-List-Received-Date: Wed, 13 Jul 2011 11:32:56 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2011-07-12 at 14:48 -0700, Joshua Lock wrote:
> The attached series contains three patches which fix Yocto bugs #1218 and
> #1219. More detail in the commit headers.
> 
> The following changes since commit 521909d1350a415d19516aa1710041e30950c7cc:
> 
>   bitbake cooker/ui: handle cmd line parsing result by individual UI. (2011-07-08 17:38:06 +0100)
> 
> are available in the git repository at:
>   git://github.com/incandescant/bitbake hob
>   https://github.com/incandescant/bitbake/tree/hob
> 
> Joshua Lock (3):
>   ui/crumbs/tasklistmodel: update brought in by column when possible
>   ui/crumbs/tasklistmodel: fix automatic removal of orphaned items

These have merged to master, thanks.

>   cooker: only return *Found events if something was actually found

and this one will be fine with a tweak :)

Cheers,

Richard



