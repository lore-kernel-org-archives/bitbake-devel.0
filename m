Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SHHtn-0004J8-8W
	for bitbake-devel@lists.openembedded.org;
	Mon, 09 Apr 2012 18:57:03 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 09 Apr 2012 09:47:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="126927839"
Received: from unknown (HELO [10.7.198.71]) ([10.7.198.71])
	by orsmga001.jf.intel.com with ESMTP; 09 Apr 2012 09:47:45 -0700
Message-ID: <4F8312B1.5050906@linux.intel.com>
Date: Mon, 09 Apr 2012 09:47:45 -0700
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:11.0) Gecko/20120329 Thunderbird/11.0.1
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <cover.1333980504.git.shane.wang@intel.com>
	<0858ca0732e2d6a66b84e97150a750714ae806c9.1333980504.git.shane.wang@intel.com>
In-Reply-To: <0858ca0732e2d6a66b84e97150a750714ae806c9.1333980504.git.shane.wang@intel.com>
Subject: Re: [PATCH 01/21] Hob: fix version check - Hob can run on pygtk 2.21.0
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
X-List-Received-Date: Mon, 09 Apr 2012 16:57:03 -0000
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09/04/12 07:13, Shane Wang wrote:
> Signed-off-by: Shane Wang<shane.wang@intel.com>
> ---
>   bitbake/lib/bb/ui/hob.py |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/bitbake/lib/bb/ui/hob.py b/bitbake/lib/bb/ui/hob.py
> index 1321ebb..61df300 100755
> --- a/bitbake/lib/bb/ui/hob.py
> +++ b/bitbake/lib/bb/ui/hob.py
> @@ -29,7 +29,7 @@ try:
>       import pygtk
>       pygtk.require('2.0') # to be certain we don't have gtk+ 1.x !?!
>       ver = gtk.pygtk_version
> -    if ver<  (2, 22, 0):
> +    if ver<  (2, 21, 0):

I've already sent a patch to lower this requirement.

>           sys.exit("%s (you have pygtk %s.%s.%s)." % (requirements, ver[0], ver[1], ver[2]))
>   except ImportError as exc:
>       sys.exit("%s (%s)." % (requirements, str(exc)))


Joshua
-- 
Joshua '贾詡' Lock
         Yocto Project "Johannes factotum"
         Intel Open Source Technology Centre


