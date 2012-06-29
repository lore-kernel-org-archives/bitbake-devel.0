Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SkaZG-0005Wa-Hj for bitbake-devel@lists.openembedded.org;
	Fri, 29 Jun 2012 14:44:58 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q5TCY06X002064;
	Fri, 29 Jun 2012 13:34:00 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 00996-04; Fri, 29 Jun 2012 13:33:55 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q5TCXqwb002058
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 29 Jun 2012 13:33:53 +0100
Message-ID: <1340973236.23146.154.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Liming An <limingx.l.an@intel.com>
Date: Fri, 29 Jun 2012 13:33:56 +0100
In-Reply-To: <a8d8da710f9797910a77883034caf09854c74a66.1340884340.git.limingx.l.an@intel.com>
References: <cover.1340884340.git.limingx.l.an@intel.com>
	<a8d8da710f9797910a77883034caf09854c74a66.1340884340.git.limingx.l.an@intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] Hob: change 'run image' and 'deploy' Gui and work flow for building detail page
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
X-List-Received-Date: Fri, 29 Jun 2012 12:44:58 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2012-06-28 at 19:55 +0800, Liming An wrote:
> In build detail page, the response action of clicked the 'run image'
> or 'deploy' button will accroding to below as ui design:
> 1)if there has one file in building result, it will responsed the
> 'run image'(now, we only support the qemu) or 'deploy' directly
> 2)if there has more than one file, it will popup a dialog with listed
> created files type, they are has same action attributes 'deploy'
> or 'runnable'.
> Note: because the qemu image (runnable file) can't be deployed and
> we can't generated a image that has the two attributes now, can be run
> or can be deployed,  so the code will not deal with this case.
> 
> [YOCTO #2155]
> 
> Signed-off-by: Liming An <limingx.l.an@intel.com>
> ---
>  bitbake/lib/bb/ui/crumbs/imagedetailspage.py |  212 ++++++++++++--------------
>  1 files changed, 98 insertions(+), 114 deletions(-)

Merged to master, thanks.

Richard



