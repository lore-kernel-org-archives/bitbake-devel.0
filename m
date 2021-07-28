Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
 by mx.groups.io with SMTP id smtpd.web12.6260.1627484673645238127
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 28 Jul 2021 08:04:34 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bootlin.com, ip: 217.70.178.232, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by relay12.mail.gandi.net (Postfix) with ESMTPSA id 12578200008;
	Wed, 28 Jul 2021 15:04:30 +0000 (UTC)
Cc: docs@lists.yoctoproject.org
Subject: Re: [bitbake-devel] [PATCH] doc: bitbake-user-manual: update bitbake option help
To: bitbake-devel@lists.openembedded.org
References: <1693DEF4612E3029.18576@lists.openembedded.org>
From: "Michael Opdenacker" <michael.opdenacker@bootlin.com>
Organization: Bootlin
Message-ID: <6395f36d-e688-9556-565e-95333e525ef0@bootlin.com>
Date: Wed, 28 Jul 2021 17:04:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1693DEF4612E3029.18576@lists.openembedded.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US


On 7/21/21 7:36 PM, Michael Opdenacker wrote:
> Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
> ---
>  doc/bitbake-user-manual/bitbake-user-manual-intro.rst | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
> index b3cea61f..7c29c8c0 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
> @@ -417,8 +417,8 @@ Following is the usage and syntax for BitBake::
>       -l DEBUG_DOMAINS, --log-domains=DEBUG_DOMAINS
>                             Show debug logging for the specified logging domains
>       -P, --profile         Profile the command and save reports.
> -     -u UI, --ui=UI        The user interface to use (knotty, ncurses or taskexp
> -                           - default knotty).
> +     -u UI, --ui=UI        The user interface to use (knotty, ncurses, taskexp or
> +                           teamcity - default knotty).
>       --token=XMLRPCTOKEN   Specify the connection token to be used when
>                             connecting to a remote server.
>       --revisions-changed   Set the exit code depending on whether upstream
> @@ -433,6 +433,9 @@ Following is the usage and syntax for BitBake::
>                             Environment variable BB_SERVER_TIMEOUT.
>       --no-setscene         Do not run any setscene tasks. sstate will be ignored
>                             and everything needed, built.
> +     --skip-setscene       Skip setscene tasks if they would be executed. Tasks
> +                           previously restored from sstate will be kept, unlike
> +                           --no-setscene
>       --setscene-only       Only run setscene tasks, don't run any real tasks.
>       --remote-server=REMOTE_SERVER
>                             Connect to the specified server.


Ping ;-)
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

