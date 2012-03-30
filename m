Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SDejE-0007b5-I9 for bitbake-devel@lists.openembedded.org;
	Fri, 30 Mar 2012 18:31:08 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q2UGM2Fv014800;
	Fri, 30 Mar 2012 17:22:02 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 14492-04; Fri, 30 Mar 2012 17:21:58 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q2UGLtLi014794
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 30 Mar 2012 17:21:56 +0100
Message-ID: <1333124515.18082.97.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Lock <josh@linux.intel.com>
Date: Fri, 30 Mar 2012 17:21:55 +0100
In-Reply-To: <cover.1333060005.git.josh@linux.intel.com>
References: <cover.1333060005.git.josh@linux.intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/3] A few more Hob tweaks
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
X-List-Received-Date: Fri, 30 Mar 2012 16:31:08 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2012-03-29 at 15:28 -0700, Joshua Lock wrote:
> Here are a few more tweaks for Hob based on design team feedback.
> 
> Please review for inclusion.
> 
> Thanks,
> Joshua
> 
> The following changes since commit 8fed4fdf4bbbc9ef036ff96755c0bfe15c3a9dd0:
> 
>   knotty: Add back getTasks() call to ensure we don't repeat messges (2012-03-29 21:38:25 +0100)
> 
> are available in the git repository at:
>   git://github.com/incandescant/bitbake josh/hob
>   https://github.com/incandescant/bitbake/tree/josh/hob
> 
> Joshua Lock (3):
>   Hob: tweak font sizes and layout
>   lib/bb/ui/crumbs/hobpages: change title from HOB to Hob
>   lib/bb/ui/crumbs/hoblistmodel: fix sorting of RecipeListModel

Merged to master, thanks.

Richard



