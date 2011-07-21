Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Qk0YR-0003k9-Rp for bitbake-devel@lists.openembedded.org;
	Thu, 21 Jul 2011 23:13:12 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p6LL943M007329;
	Thu, 21 Jul 2011 22:09:04 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 07272-01; Thu, 21 Jul 2011 22:09:00 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p6LL8vpR007323
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 21 Jul 2011 22:08:58 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Lock <josh@linux.intel.com>
In-Reply-To: <cover.1311273097.git.josh@linux.intel.com>
References: <cover.1311273097.git.josh@linux.intel.com>
Date: Thu, 21 Jul 2011 22:08:55 +0100
Message-ID: <1311282535.2344.85.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/6] Hob fixes
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
X-List-Received-Date: Thu, 21 Jul 2011 21:13:12 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2011-07-21 at 11:34 -0700, Joshua Lock wrote:
> This includes several fixes which are low impact for the core BitBake
> functionality (only touch files in lib/ui/crumbs and the hob entry point) but
> which improve the usefulness of the GUI whilst the reparseFiles/stashed copy
> of the environment issue is being worked through.
> 
> The following changes since commit 09a9146262d58dfe4a2ea4270026b90ae33f6c91:
> 
>   parse/ConfHandler: Fix multiline variable corruption (2011-07-21 11:08:19 +0100)
> 
> are available in the git repository at:
>   git://github.com/incandescant/bitbake hob
>   https://github.com/incandescant/bitbake/tree/hob
> 
> Joshua Lock (6):
>   ui/crumbs/hobprefs: add missing import
>   ui/crumbs/tasklistmodel: fix saving recipes
>   ui/hob: add more guidance to the stop dialog
>   ui/crumbs/configurator: write new lines after new entries
>   ui/hob: don't crash if PARALLEL_MAKE doesn't include a space
>   ui/crumbs/tasklistmodel: ignore tasks and images when marking
>     dependencies

Merged to master, thanks.

Richard



