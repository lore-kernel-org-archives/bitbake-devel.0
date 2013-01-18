Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TwBh7-0004jF-5Z for bitbake-devel@lists.openembedded.org;
	Fri, 18 Jan 2013 14:09:29 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id r0ICrock008985;
	Fri, 18 Jan 2013 12:53:50 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 05490-05; Fri, 18 Jan 2013 12:53:46 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id r0ICrh5I008978
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 18 Jan 2013 12:53:44 GMT
Message-ID: <1358513623.27799.24.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Jessica Zhang <jessica.zhang@intel.com>
Date: Fri, 18 Jan 2013 12:53:43 +0000
In-Reply-To: <eecefc2d16969c413dad379c8ba6605750665990.1357255745.git.jessica.zhang@intel.com>
References: <cover.1357255745.git.jessica.zhang@intel.com>
	<eecefc2d16969c413dad379c8ba6605750665990.1357255745.git.jessica.zhang@intel.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] Fix GTK+ and PyGtk version check error message to be more clear [Yocto #3637]
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
X-List-Received-Date: Fri, 18 Jan 2013 13:09:30 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2013-01-03 at 15:32 -0800, Jessica Zhang wrote:
> Signed-off-by: Jessica Zhang <jessica.zhang@intel.com>
> ---
>  bitbake/lib/bb/ui/hob.py |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I merged this but I had to reformat the summary and commit message as
they weren't in the correct form.

Cheers,

Richard

> diff --git a/bitbake/lib/bb/ui/hob.py b/bitbake/lib/bb/ui/hob.py
> index 9ec32b1..55bd84c 100755
> --- a/bitbake/lib/bb/ui/hob.py
> +++ b/bitbake/lib/bb/ui/hob.py
> @@ -22,7 +22,7 @@
>  
>  import sys
>  import os
> -requirements = "FATAL: Gtk+, PyGtk and PyGobject are required to use Hob"
> +requirements = "FATAL: Hob requires Gtk+ 2.20.0 or higher, PyGtk 2.21.0 or higher"
>  try:
>      import gobject
>      import gtk




