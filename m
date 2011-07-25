Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1QlJX8-0004em-7X for bitbake-devel@lists.openembedded.org;
	Mon, 25 Jul 2011 13:41:14 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p6PBb0tn017331;
	Mon, 25 Jul 2011 12:37:00 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 16301-04; Mon, 25 Jul 2011 12:36:56 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p6PBaquw017325
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 25 Jul 2011 12:36:53 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Lock <josh@linux.intel.com>
In-Reply-To: <cover.1311396520.git.josh@linux.intel.com>
References: <cover.1311396520.git.josh@linux.intel.com>
Date: Mon, 25 Jul 2011 12:36:46 +0100
Message-ID: <1311593806.2344.171.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/8] Hob GUI tweaks and bugfixes
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
X-List-Received-Date: Mon, 25 Jul 2011 11:41:14 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2011-07-22 at 21:54 -0700, Joshua Lock wrote:
> This series contains largely cosmetic and purely GUI related changes to
> address some bugs filed against Hob and a few other GUI tweaks.
> 
> The following changes since commit abc67ed6921c98ed581f101ec1acc589fd9ce7e9:
> 
>   bitbake/utils: Add contains helper function from lib.oe.utils (2011-07-22 12:11:01 +0100)
> 
> are available in the git repository at:
>   git://github.com/incandescant/bitbake hob
>   https://github.com/incandescant/bitbake/tree/hob
> 
> Joshua Lock (8):
>   hob: refer to tasks as Package Collections
>   ui/crumbs/tasklistmodel: don't show native and cross recipes
>   ui/hob: clear the search entry when resetting
>   ui/hob: if the user clicks Stop a second time only offer 'Force Stop'
>   hob: only add new layer's to the UI
>   ui/crumbs/hobprefs: set higher arbitrary limit on threads &
>     parallelism
>   ui/crumbs/hobprefs: tweak the package format tooltip
>   hob: rework image output type setting

Merged to master, thanks.

Richard



