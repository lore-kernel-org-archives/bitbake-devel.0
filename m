Received: from [93.97.173.237] (helo=tim.rpsys.net)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Qoyh4-0002g6-KB for bitbake-devel@lists.openembedded.org;
	Thu, 04 Aug 2011 16:14:38 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p74EADXx002472;
	Thu, 4 Aug 2011 15:10:13 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 01749-07; Thu,  4 Aug 2011 15:10:09 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p74EA6No002460
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 4 Aug 2011 15:10:06 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Lock <josh@linux.intel.com>
In-Reply-To: <cover.1312420894.git.josh@linux.intel.com>
References: <cover.1312420894.git.josh@linux.intel.com>
Date: Thu, 04 Aug 2011 15:09:46 +0100
Message-ID: <1312466986.2344.745.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/6] Bug fixes for hob
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
X-List-Received-Date: Thu, 04 Aug 2011 14:14:38 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2011-08-03 at 18:23 -0700, Joshua Lock wrote:
> A fairly small series of bug fixes for the hob UI, please review.
> 
> The following changes since commit 25ec13075855f7e321a9763682a8cd4ca09203cd:
> 
>   bb/ui/crumbs/runningbuild: emit signal when command fails with exit signal (2011-08-02 18:12:46 -0700)
> 
> are available in the git repository at:
>   git://github.com/incandescant/bitbake hob
>   https://github.com/incandescant/bitbake/tree/hob
> 
> Joshua Lock (6):
>   bb/ui/hob: fix detection of whether GPLv3 is disabled
>   bb/ui/crumbs/tasklistmodel: fix regex used for loading image recipes
>   bb/ui/hob: prevent label on progress bar from changing rapidly when
>     loading
>   bb/ui/crumbs/hobeventhandler: use generic loading message once cache
>     loaded
>   bb/ui/hob: only connect to the changed signal of image_combo once
>   bb/ui/hob: be clear that the image contents are an estimate
> 

Merged to master, thanks.

Richard



