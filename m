Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1S37zO-0001CR-Ns for bitbake-devel@lists.openembedded.org;
	Thu, 01 Mar 2012 16:32:18 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q21FNlOU017972;
	Thu, 1 Mar 2012 15:23:47 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 17710-03; Thu,  1 Mar 2012 15:23:43 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q21FNck3017965
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 1 Mar 2012 15:23:39 GMT
Message-ID: <1330615422.31767.13.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Shane Wang <shane.wang@intel.com>
Date: Thu, 01 Mar 2012 15:23:42 +0000
In-Reply-To: <93713faf8701668260d1822f9be8c8e6deaafc03.1330523904.git.shane.wang@intel.com>
References: <cover.1330523904.git.shane.wang@intel.com>
	<93713faf8701668260d1822f9be8c8e6deaafc03.1330523904.git.shane.wang@intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 32/32] Hob: Disable the handling of "NoProvider" event
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
X-List-Received-Date: Thu, 01 Mar 2012 15:32:18 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2012-02-29 at 22:15 +0800, Shane Wang wrote:
> From: Dongxiao Xu <dongxiao.xu@intel.com>
> 
> Currently for non-x86 architecture, there are un-resolved dependency
> issue when generate universe dependency tree. Therefore disable the
> handling of "NoProvider" event in Hob to enable the build for non-x86
> architectures. After we resolved the dependency for universe, we still
> need to handle this event in Hob.
> 
> Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
> ---
>  bitbake/lib/bb/ui/crumbs/hobeventhandler.py |   37 ++++++++++++++------------
>  1 files changed, 20 insertions(+), 17 deletions(-)

Shouldn't you be using world and not universe for this?

I suspect world shouldn't show the NoProvider issues?

Cheers,

Richard



