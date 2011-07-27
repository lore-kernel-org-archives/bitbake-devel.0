Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Qm6QO-0004Bj-5C for bitbake-devel@lists.openembedded.org;
	Wed, 27 Jul 2011 17:53:32 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p6RFnGhT031066;
	Wed, 27 Jul 2011 16:49:16 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 30946-03; Wed, 27 Jul 2011 16:49:12 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p6RFnBQZ031060
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 27 Jul 2011 16:49:11 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Lock <josh@linux.intel.com>
In-Reply-To: <cover.1311738866.git.josh@linux.intel.com>
References: <cover.1311738866.git.josh@linux.intel.com>
Date: Wed, 27 Jul 2011 16:49:00 +0100
Message-ID: <1311781740.2344.404.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/4] Hob bug fixes
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
X-List-Received-Date: Wed, 27 Jul 2011 15:53:32 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2011-07-26 at 20:57 -0700, Joshua Lock wrote:
> All,
> 
> Some more bug fixes for the hob UI hoping to make it in before we freeze Poky
> for Yocto 1.1M3.
> 
> Thanks,
> Joshua
> 
> The following changes since commit 2650be190afc05f9472aca8b11af99205a342838:
> 
>   ui/crumbs/tasklistmodel: fix loading a saved recipe (2011-07-26 09:42:28 -0700)
> 
> are available in the git repository at:
>   git://github.com/incandescant/bitbake hob
>   https://github.com/incandescant/bitbake/tree/hob
> 
> Jessica Zhang (1):
>   ui/crumbs/hobprefs: trigger reparse when package format changed
> 
> Joshua Lock (3):
>   ui/crumbs/tasklistmodel: work around overly aggressive package
>     removal
>   hob: fix loading customised image recipe
>   cooker: populate rdepends-pkg in generatePkgDepTreeData

Merged to master, thanks.

Richard



