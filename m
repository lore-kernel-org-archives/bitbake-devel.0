Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TdeA9-0003Zi-2d for bitbake-devel@lists.openembedded.org;
	Wed, 28 Nov 2012 10:42:38 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qAS9SJLu011767;
	Wed, 28 Nov 2012 09:28:19 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 11107-04; Wed, 28 Nov 2012 09:28:14 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qAS9S8ux011761
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 28 Nov 2012 09:28:09 GMT
Message-ID: <1354094887.21863.166.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Cristiana Voicu <cristiana.voicu@intel.com>
Date: Wed, 28 Nov 2012 09:28:07 +0000
In-Reply-To: <1354027291-9341-1-git-send-email-cristiana.voicu@intel.com>
References: <1354027291-9341-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] hob: when BBLAYERS_NON_REMOVABLE is not set hob shows an error
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
X-List-Received-Date: Wed, 28 Nov 2012 09:42:38 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2012-11-27 at 16:41 +0200, Cristiana Voicu wrote:
> Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
> ---
>  bitbake/lib/bb/ui/crumbs/hobeventhandler.py |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
> index ae1cefc..8a2ac5f 100644
> --- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
> +++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
> @@ -435,7 +435,7 @@ class HobHandler(gobject.GObject):
>          params["core_base"] = self.runCommand(["getVariable", "COREBASE"]) or ""
>          hob_layer = params["core_base"] + "/meta-hob"
>          params["layer"] = self.runCommand(["getVariable", "BBLAYERS"]) or ""
> -        params["layers_non_removable"] = self.runCommand(["getVariable", "BBLAYERS_NON_REMOVABLE"])
> +        params["layers_non_removable"] = self.runCommand(["getVariable", "BBLAYERS_NON_REMOVABLE"]) or ""
>          if hob_layer not in params["layer"].split():
>              params["layer"] += (" " + hob_layer)
>          if hob_layer not in params["layers_non_removable"].split():

Merged to master, thanks.

Richard



