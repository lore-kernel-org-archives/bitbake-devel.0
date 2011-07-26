Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1QlnAZ-0004TJ-3K for bitbake-devel@lists.openembedded.org;
	Tue, 26 Jul 2011 21:19:55 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p6QJFe9t024186;
	Tue, 26 Jul 2011 20:15:40 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 23068-09; Tue, 26 Jul 2011 20:15:36 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p6QJFZoN024180
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 26 Jul 2011 20:15:36 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Lock <josh@linux.intel.com>
In-Reply-To: <cover.1311705833.git.josh@linux.intel.com>
References: <cover.1311705833.git.josh@linux.intel.com>
Date: Tue, 26 Jul 2011 20:15:26 +0100
Message-ID: <1311707726.2344.301.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 00/10] Latest round of hob UI improvements
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
X-List-Received-Date: Tue, 26 Jul 2011 19:19:55 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2011-07-26 at 11:46 -0700, Joshua Lock wrote:
> Highlights are using buildTargets rather than buildFiles to build the custom
> image and enabling building an image without a 'Base image' set.
> Plus a slew of more minor fixes.
> 
> The following changes since commit d11f9dd33cdcc97a4a937e8bf7e97558d813cadd:
> 
>   cooker: only append files once (2011-07-26 13:45:31 +0100)
> 
> are available in the git repository at:
>   git://github.com/incandescant/bitbake hob
>   https://github.com/incandescant/bitbake/tree/hob
> 
> Jessica Zhang (1):
>   ui/crumbs/tasklistmodel: fix loading a saved recipe
> 
> Joshua Lock (9):
>   ui/hob: replace the ugly static command map
>   ui/crumbs/hobeventhandler: reparse files before running other
>     commands
>   ui/hob: switch from buildFile to buildTargets for custom image builds
>   ui/hob: don't offer to show built output if build fails
>   ui/hob: change wording in build complete dialog
>   ui/hob: Force the 'Base image combo' to be drawn correctly
>   ui/hob: enable building an image with minimal contents
>   ui/crumbs/tasklistmodel: handle items added in by base image being
>     removed
>   ui/crumbs/tasklistmodel: don't iterate whole model in
>     find_alt_dependency()

Merged to master, thanks.

Richard



