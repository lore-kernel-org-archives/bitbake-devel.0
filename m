Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SA0Q0-0003KJ-R9 for bitbake-devel@lists.openembedded.org;
	Tue, 20 Mar 2012 15:52:13 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q2KEe8uP011084;
	Tue, 20 Mar 2012 14:40:08 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 09853-09; Tue, 20 Mar 2012 14:40:04 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q2KEdx4h011069
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 20 Mar 2012 14:40:01 GMT
Message-ID: <1332254401.9740.93.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Dongxiao Xu <dongxiao.xu@intel.com>
Date: Tue, 20 Mar 2012 14:40:01 +0000
In-Reply-To: <cover.1331887394.git.dongxiao.xu@intel.com>
References: <cover.1331887394.git.dongxiao.xu@intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/3][PULL] Hob: Bug fix
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
X-List-Received-Date: Tue, 20 Mar 2012 14:52:14 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2012-03-16 at 16:48 +0800, Dongxiao Xu wrote:
> Hi Richard,
> 
> This pull request fixes some bugs related with new Hob, please help to review and pull.
> 
> Thanks,
> Dongxiao
> 
> The following changes since commit a17473d51f54a9dfb4eeaa5ad516c4851d5ac142:
> 
>   bitbake/fetch: Fix uri_replace (2012-03-15 22:51:20 +0000)
> 
> are available in the git repository at:
>   git://git.pokylinux.org/poky-contrib dxu4/hob-bugfix-bitbake
>   http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=dxu4/hob-bugfix-bitbake
> 
> Dongxiao Xu (3):
>   Hob: reset the selection if switch to a new base image
>   Hob: Fix advanced setting reparse mechanism
>   Hob: save CONF_VERSION and LCONF_VERSION into template

Merged to master, thanks.

Richard



