Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1QyVTh-0001yk-Ua for bitbake-devel@lists.openembedded.org;
	Tue, 30 Aug 2011 23:04:14 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p7UKxKJw000533;
	Tue, 30 Aug 2011 21:59:20 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 20955-07; Tue, 30 Aug 2011 21:59:16 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p7UKxBUD000517
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 30 Aug 2011 21:59:11 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Lock <josh@linux.intel.com>
In-Reply-To: <cover.1314727299.git.josh@linux.intel.com>
References: <cover.1314727299.git.josh@linux.intel.com>
Date: Tue, 30 Aug 2011 21:58:58 +0100
Message-ID: <1314737938.5939.419.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/6] Bug fixes and optimisations for hob
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
X-List-Received-Date: Tue, 30 Aug 2011 21:04:14 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2011-08-30 at 11:08 -0700, Joshua Lock wrote:
> This series includes two bug fixes and a brace of patches to speed up some
> operations on the gtk.ListStore that became apparent as I was reviewing the
> code for the bug fixes.
> 
> Regards,
> Joshua
> 
> The following changes since commit 6555a77c199f41bf35460138764e03e30c56d29f:
> 
>   data_smart.py: make use of expand cache in getVar() (2011-08-29 14:13:25 +0100)
> 
> are available in the git repository at:
>   git://github.com/incandescant/bitbake hob
>   https://github.com/incandescant/bitbake/tree/hob
> 
> Joshua Lock (6):
>   ui/crumbs/tasklistmodel: don't add same item to binb column more than
>     once
>   ui/crumbs/tasklistmodel: prevent packages depending on each other
>   ui/crumbs/tasklistmodel: optimise find_path_for_item()
>   ui/crumbs/tasklistmodel: remove unnecessary check
>   ui/crumbs/tasklistmodel: loop optimisation in include_item()
>   ui/crumbs/tasklistmodel: don't add empty entries to COL_BINB

Merged to master, thanks.

Richard 



