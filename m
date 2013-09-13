Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 00D3560EE1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Sep 2013 12:47:29 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8DD1DSN024644; Fri, 13 Sep 2013 14:01:13 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id sOgFHsKnmstf; Fri, 13 Sep 2013 14:01:13 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8DD191t024637
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Fri, 13 Sep 2013 14:01:10 +0100
Message-ID: <1379076430.3484.266.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alex DAMIAN <alexandru.damian@intel.com>
Date: Fri, 13 Sep 2013 13:47:10 +0100
In-Reply-To: <1378828081-22646-1-git-send-email-alexandru.damian@intel.com>
References: <1378828081-22646-1-git-send-email-alexandru.damian@intel.com>
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] bitbake: cooker: clear up state on stateShutdown command
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 13 Sep 2013 12:47:30 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2013-09-10 at 16:48 +0100, Alex DAMIAN wrote:
> From: Alexandru DAMIAN <alexandru.damian@intel.com>
> 
> On resident bitbake server, a stateShutdown command (first
> Ctrl-C in client) will leave the server in an unusable state.
> 
> This patch forces the server to reload data and begin
> processing commands again, coping correctly with Ctrl-C commands.
> 
> Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
> 
> diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
> index c3721aa..42eec2c 100644
> --- a/bitbake/lib/bb/cooker.py
> +++ b/bitbake/lib/bb/cooker.py
> @@ -1101,6 +1101,7 @@ class BBCooker:
>                  rq.finish_runqueue(True)
>              elif self.state == state.shutdown:
>                  rq.finish_runqueue(False)
> +                self.state = state.initial
>              failures = 0
>              try:
>                  retval = rq.execute_runqueue()
> @@ -1191,7 +1192,7 @@ class BBCooker:
>          if self.state == state.running:
>              return
>  
> -        if self.state in (state.shutdown, state.stop):
> +        if self.state == state.stop:
>              self.parser.shutdown(clean=False, force = True)
>              sys.exit(1)

This doesn't seem very intuitive. As I read the code above, "shutdown"
means it sits and does nothing, "stop" means it exits? Surely these
should be the other way around?

Cheers,

Richard





