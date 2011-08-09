Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QqpBX-0000kS-1H
	for bitbake-devel@lists.openembedded.org;
	Tue, 09 Aug 2011 18:29:43 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 09 Aug 2011 09:25:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,344,1309762800"; d="scan'208";a="36727906"
Received: from unknown (HELO [10.255.13.204]) ([10.255.13.204])
	by azsmga001.ch.intel.com with ESMTP; 09 Aug 2011 09:25:12 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 09 Aug 2011 09:25:07 -0700
In-Reply-To: <1312897353.14274.294.camel@rex>
References: <1312897353.14274.294.camel@rex>
X-Mailer: Evolution 3.0.2 (3.0.2-3.fc15) 
Message-ID: <1312907112.2265.1.camel@scimitar>
Mime-Version: 1.0
Subject: Re: [PATCH] bitbake/ui/knotty: Ensure previous failures aren't masked by a final successful command
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
X-List-Received-Date: Tue, 09 Aug 2011 16:29:43 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2011-08-09 at 14:42 +0100, Richard Purdie wrote:
> When running bitbake in -k mode, the last command might succeed but we
> still need to preserve any previous failure codes.
> 
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

Signed-off-by: Joshua Lock <josh@linux.intel.com>

> ---
> diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
> index 63b8dc6..7a2681d 100644
> --- a/bitbake/lib/bb/ui/knotty.py
> +++ b/bitbake/lib/bb/ui/knotty.py
> @@ -188,7 +188,8 @@ def main(server, eventHandler):
>                  logger.error("Command execution failed: %s", event.error)
>                  break
>              if isinstance(event, bb.command.CommandExit):
> -                return_value = event.exitcode
> +                if not return_value:
> +                    return_value = event.exitcode
>                  continue
>              if isinstance(event, bb.cooker.CookerExit):
>                  break
> 
> 
> 
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel

-- 
Joshua Lock
        Yocto Project "Johannes factotum"
        Intel Open Source Technology Centre



