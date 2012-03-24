Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SBOEW-0001MH-UE for bitbake-devel@lists.openembedded.org;
	Sat, 24 Mar 2012 11:30:05 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q2OAL5ju005125;
	Sat, 24 Mar 2012 10:21:05 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 01784-08; Sat, 24 Mar 2012 10:21:01 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q2OAKu0p005119
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 24 Mar 2012 10:20:57 GMT
Message-ID: <1332584459.9740.508.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Dongxiao Xu <dongxiao.xu@intel.com>
Date: Sat, 24 Mar 2012 10:20:59 +0000
In-Reply-To: <a8df5fb9f370eb9024df8ff73b23f9c963c18377.1332567775.git.dongxiao.xu@intel.com>
References: <cover.1332567775.git.dongxiao.xu@intel.com>
	<a8df5fb9f370eb9024df8ff73b23f9c963c18377.1332567775.git.dongxiao.xu@intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 8/8] Hob: Set empty DISTRO if "defaultsetup" is selected
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
X-List-Received-Date: Sat, 24 Mar 2012 10:30:05 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sat, 2012-03-24 at 13:47 +0800, Dongxiao Xu wrote:
> In Hob advanced setting, if "defaultsetup" is selected, we need to set
> empty to DISTRO variable in bitbake server.
> 
> Otherwise, defaultsetup.conf will be parsed twice, causing TMPDIR and
> its related variables mess up.
> 
> Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
> ---
>  lib/bb/ui/crumbs/hobeventhandler.py |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/lib/bb/ui/crumbs/hobeventhandler.py b/lib/bb/ui/crumbs/hobeventhandler.py
> index 4b8aabc..a98a0bb 100644
> --- a/lib/bb/ui/crumbs/hobeventhandler.py
> +++ b/lib/bb/ui/crumbs/hobeventhandler.py
> @@ -274,6 +274,8 @@ class HobHandler(gobject.GObject):
>          self.server.runCommand(["setVariable", "IMAGE_FSTYPES", " ".join(image_fstypes).lstrip(" ")])
>  
>      def set_distro(self, distro):
> +        if distro == "defaultsetup":
> +            distro = ""
>          self.server.runCommand(["setVariable", "DISTRO", distro])
>  
>      def set_package_format(self, format):

This worries me a little since you're doing something different to what
the usual case would be (DISTRO not set at all). Is there not a way we
can not set DISTRO at all so we ensure we're consistent?

What I'd like to avoid is a set of "hob-only" bugs caused by doing
things slightly differently.

Cheers,

Richard





