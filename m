Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1S0x6Y-0003To-C6 for bitbake-devel@lists.openembedded.org;
	Fri, 24 Feb 2012 16:30:42 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q1OFMH6W007801;
	Fri, 24 Feb 2012 15:22:17 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 06978-07; Fri, 24 Feb 2012 15:22:13 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q1OFMBrY007794
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 24 Feb 2012 15:22:12 GMT
Message-ID: <1330096932.32006.49.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Dongxiao Xu <dongxiao.xu@intel.com>
Date: Fri, 24 Feb 2012 15:22:12 +0000
In-Reply-To: <d5e286c87af1c74f7ea968917d67a6f46898ccff.1330046167.git.dongxiao.xu@intel.com>
References: <cover.1330046167.git.dongxiao.xu@intel.com>
	<d5e286c87af1c74f7ea968917d67a6f46898ccff.1330046167.git.dongxiao.xu@intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] runqueue: fire sceneQueueTaskStarted event when a setscene queue starts
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
X-List-Received-Date: Fri, 24 Feb 2012 15:30:42 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2012-02-24 at 09:31 +0800, Dongxiao Xu wrote:
> The current code prints a log when a setscene task starts, therefore
> the progressbar in hob will not receive it. Use a sceneQueueTaskStarted
> event instead.
> 
> Besides, change the sceneQueueTaskFailed event to inherit runQueueEvent
> directly to avoid confusion to event receiver.
> 
> Signed-off-by: Shane Wang <shane.wang@intel.com>
> Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
> ---
>  lib/bb/runqueue.py |   16 ++++++++++++++--
>  1 files changed, 14 insertions(+), 2 deletions(-)

Merged to master, thanks.

Richard



