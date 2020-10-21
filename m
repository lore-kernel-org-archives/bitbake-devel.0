Received: from linuxplesk15.openhost.net.nz (linuxplesk15.openhost.net.nz [119.47.118.83])
 by mx.groups.io with SMTP id smtpd.web10.6113.1603249522123348077
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 20 Oct 2020 20:05:22 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=none, err=permanent DNS error (domain: bluelightning.org, ip: 119.47.118.83, mailfrom: bluelightning@bluelightning.org)
Received: from linc.localnet (unknown [151.210.228.105])
	by linuxplesk15.openhost.net.nz (Postfix) with ESMTPSA id C3316A42BE;
	Wed, 21 Oct 2020 16:05:17 +1300 (NZDT)
Authentication-Results: linuxplesk15.openhost.net.nz;
        spf=pass (sender IP is 151.210.228.105) smtp.mailfrom=bluelightning@bluelightning.org smtp.helo=linc.localnet
Received-SPF: pass (linuxplesk15.openhost.net.nz: connection is authenticated)
From: "Paul Eggleton" <bluelightning@bluelightning.org>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH 2/2] tinfoil: When sending commands we need to process events
Date: Wed, 21 Oct 2020 16:05:17 +1300
Message-ID: <2890515.CbtlEUcBR6@linc>
In-Reply-To: <20201009165124.3293429-2-richard.purdie@linuxfoundation.org>
References: <20201009165124.3293429-1-richard.purdie@linuxfoundation.org> <20201009165124.3293429-2-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Richard

On Saturday, 10 October 2020 05:51:24 NZDT Richard Purdie wrote:
> The server may be displaying useful information for the user through log
> messages so we should display anything that has been sent. Its either this
> or expecting every UI to implement this code around every command call
> which isn't good API.
> 
> [YOCTO #14054]
> 
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/tinfoil.py | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
> index 2fb1bb7d27..763c329810 100644
> --- a/lib/bb/tinfoil.py
> +++ b/lib/bb/tinfoil.py
> @@ -461,7 +461,16 @@ class Tinfoil:
>          commandline = [command]
>          if params:
>              commandline.extend(params)
> -        result = self.server_connection.connection.runCommand(commandline)
> +        try:
> +            result =
> self.server_connection.connection.runCommand(commandline) +        finally:
> +            while True:
> +                event = self.wait_event()
> +                if not event:
> +                    break
> +                if isinstance(event, logging.LogRecord):
> +                    if event.taskpid == 0 or event.levelno > logging.INFO:
> +                        self.logger.handle(event)
>          if result[1]:
>              raise TinfoilCommandFailed(result[1])
>          return result[0]

Won't this eat events that aren't LogRecords? I understand the intention, and 
am happy for this to be the default behaviour, but we have several callers of 
run_command() which are expecting to receive events by themselves using 
wait_event(). Should we perhaps add a parameter to disable this and specify 
that in those callers? I'm happy to cook up that patch if so.

Cheers
Paul



