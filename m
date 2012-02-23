Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1S0hhH-0006XG-Sd for bitbake-devel@lists.openembedded.org;
	Fri, 24 Feb 2012 00:03:36 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q1NMtDX6030199;
	Thu, 23 Feb 2012 22:55:13 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 26190-10; Thu, 23 Feb 2012 22:55:09 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q1NMt5LY030188
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 23 Feb 2012 22:55:06 GMT
Message-ID: <1330037705.22167.8.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Dongxiao Xu <dongxiao.xu@intel.com>
Date: Thu, 23 Feb 2012 22:55:05 +0000
In-Reply-To: <cover.1330003017.git.dongxiao.xu@intel.com>
References: <cover.1330003017.git.dongxiao.xu@intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/9][PULL] Hob2: bitbake related changes
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
X-List-Received-Date: Thu, 23 Feb 2012 23:03:36 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2012-02-23 at 21:47 +0800, Dongxiao Xu wrote:
> Hi Richard,
> 
> This is the hob2 related bitbake changes. Please help to review and pull.
> 
> Compared with previous version:
>  - cache.py: remove the DATE field and value in calculating self.configuration's hash value,
>    which causes the cache invalid after one day.
> 
> Thanks,
> Dongxiao
> 
> The following changes since commit 95a599067650902727ecb4a39d6dd003c5cfedf3:
> 
>   bitbake/ui/knotty: fix incorrect exit code (2012-02-22 21:30:18 +0000)
> 
> are available in the git repository at:
>   git://git.pokylinux.org/poky-contrib dxu4/hob2-bitbake-changes
>   http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=dxu4/hob2-bitbake-changes
> 
> Dongxiao Xu (7):
>   cache: Use configuration's hash value to validate cache
>   command.py: add resolve option for generateTargetsTree API
>   event.py: Add new events RequestPackageInfo and PackageInfo
>   bitbake: add -B option to bind with interface
>   bitbake: Add client socket info for BitBakeServerConnection
>   command.py: Add a new API triggerEvent()
>   runqueue: fire sceneQueueTaskStarted event when a setscene queue
>     starts
> 
> Shane Wang (2):
>   bitbake: change for adding progress bar in Hob2.
>   command.py: add new API to get the cpu count on the server

The series had things split into good logical chunks which really helped
making review easier, thanks! Most of these changes have been on the
list before so I've merged these with the exception of the
sceneQueueTaskStarted which might need a small change.

Cheers,

Richard



