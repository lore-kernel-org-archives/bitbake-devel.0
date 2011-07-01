Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Qcg8l-0000WA-KH for bitbake-devel@lists.openembedded.org;
	Fri, 01 Jul 2011 18:00:24 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p61FucA8012490;
	Fri, 1 Jul 2011 16:56:38 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 12248-06; Fri,  1 Jul 2011 16:56:34 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p61FuXVX012484
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 1 Jul 2011 16:56:34 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Lock <josh@linux.intel.com>
In-Reply-To: <dadace9c070cb585eff83df44147afbfa0c83628.1309499227.git.josh@linux.intel.com>
References: <cover.1309499227.git.josh@linux.intel.com>
	<dadace9c070cb585eff83df44147afbfa0c83628.1309499227.git.josh@linux.intel.com>
Date: Fri, 01 Jul 2011 16:56:11 +0100
Message-ID: <1309535771.20015.526.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 01/10] ui/hob: Fixed the "build again" hang.
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
X-List-Received-Date: Fri, 01 Jul 2011 16:00:24 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2011-06-30 at 23:02 -0700, Joshua Lock wrote:
> From: Lianhao Lu <lianhao.lu@intel.com>
> 
> Using gobject.threads_init() instead of gtk.gdk.threads_init(). These
> two modes are conflict to each other. Using gobject.threads_init()
> allows only the main thread to touch GUI(gtk) part.
> 
> Signed-off-by: Lianhao Lu <lianhao.lu@intel.com>
> Signed-off-by: Joshua Lock <josh@linux.intel.com>
> ---
>  lib/bb/ui/hob.py |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)

Merged to master, thanks.

Richard



