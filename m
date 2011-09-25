Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1R7qgq-0001lZ-NZ for bitbake-devel@lists.openembedded.org;
	Sun, 25 Sep 2011 17:32:24 +0200
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.2/8.14.2/Debian-2build1) with ESMTP id
	p8PFXHo2014771; Sun, 25 Sep 2011 16:33:18 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 8u0MehK7TIMs; Sun, 25 Sep 2011 16:33:12 +0100 (BST)
Received: from [192.168.1.40] (tim [93.97.173.237]) (authenticated bits=0)
	by dan.rpsys.net (8.14.2/8.14.2/Debian-2build1) with ESMTP id
	p8PFX7Ba014752
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 25 Sep 2011 16:33:08 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Lock <josh@linux.intel.com>
Date: Sun, 25 Sep 2011 16:26:43 +0100
In-Reply-To: <cover.1316809959.git.josh@linux.intel.com>
References: <cover.1316809959.git.josh@linux.intel.com>
X-Mailer: Evolution 3.1.91- 
Message-ID: <1316964411.8185.20.camel@ted>
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/3] Hob bug fixes
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
X-List-Received-Date: Sun, 25 Sep 2011 15:32:24 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2011-09-23 at 13:34 -0700, Joshua Lock wrote:
> This series includes a few fixes found whilst debugging and fixing
> Yocto bug #1521
> http://bugzilla.yoctoproject.org/show_bug.cgi?id=1521
> 
> Richard, please consider these for Yocto 1.1
> 
> Regards,
> Joshua
> 
> The following changes since commit 623e9c7f7a9cf12b8c81c26cc608990682a601dd:
> 
>   Fix mercurial fetcher in fetch2 (2011-09-21 14:07:14 +0100)
> 
> are available in the git repository at:
>   git://github.com/incandescant/bitbake hob
>   https://github.com/incandescant/bitbake/tree/hob
> 
> Joshua Lock (3):
>   ui/crumbs/hobeventhandler: move remaining getVariable calls to init
>   ui/crumbs/hobeventhandler: fix variable name typo
>   hob: fix building with current selections after reparse

Merged to master, thanks.

Richard



