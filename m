Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1QfE17-0003Sj-Nn for bitbake-devel@lists.openembedded.org;
	Fri, 08 Jul 2011 18:35:03 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p68GV7HI021884;
	Fri, 8 Jul 2011 17:31:07 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 21561-06; Fri,  8 Jul 2011 17:31:03 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p68GUxTA021878
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 8 Jul 2011 17:30:59 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Lock <josh@linux.intel.com>
In-Reply-To: <cover.1310078501.git.josh@linux.intel.com>
References: <cover.1310078501.git.josh@linux.intel.com>
Date: Fri, 08 Jul 2011 17:30:19 +0100
Message-ID: <1310142619.20015.905.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/3] Behavioural bug fixes for Hob
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
X-List-Received-Date: Fri, 08 Jul 2011 16:35:03 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2011-07-07 at 15:43 -0700, Joshua Lock wrote:
> This is the first of no doubt many patch series to fix bugs in the hob ui now
> that people have started trying to use it.
> 
> The following changes since commit c7a9ef70ba91d47d53074e8d78cbc52f396144a7:
> 
>   bitbake/process.py: Ensure queued UI events are queued right before we add our own handler (2011-07-07 10:57:05 +0100)
> 
> are available in the git repository at:
>   git://github.com/incandescant/bitbake hob
>   https://github.com/incandescant/bitbake/tree/hob
> 
> Joshua Lock (3):
>   ui/crumbs/tasklistmodel: fix reset method
>   lib/bb/hob: fix changing base image
>   lib/bb/ui/hob: don't error when dismissing save as dialog

Merged to master, thanks.

Richard



