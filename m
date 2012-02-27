Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1S23By-00056k-9R for bitbake-devel@lists.openembedded.org;
	Mon, 27 Feb 2012 17:12:50 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q1RG4LQa030028;
	Mon, 27 Feb 2012 16:04:21 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 29570-04; Mon, 27 Feb 2012 16:04:16 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q1RG4FWg030022
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 27 Feb 2012 16:04:16 GMT
Message-ID: <1330358657.4593.24.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Date: Mon, 27 Feb 2012 16:04:17 +0000
In-Reply-To: <f3c3d4bb21940b9f96a604145c76cfaef7b25943.1330351817.git.paul.eggleton@linux.intel.com>
References: <cover.1330351817.git.paul.eggleton@linux.intel.com>
	<f3c3d4bb21940b9f96a604145c76cfaef7b25943.1330351817.git.paul.eggleton@linux.intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] bitbake: implement BB_VERBOSE_LOGS
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
X-List-Received-Date: Mon, 27 Feb 2012 16:12:50 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2012-02-27 at 14:11 +0000, Paul Eggleton wrote:
> Enable configuring whether "set +x" is added to all shell tasks rather
> than forcing it; this is enabled by setting BB_VERBOSE_LOGS to 1.
> 
> Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
> ---
>  bitbake/lib/bb/build.py  |    3 ++-
>  bitbake/lib/bb/cooker.py |    4 ++++
>  bitbake/lib/bb/msg.py    |    3 +++
>  3 files changed, 9 insertions(+), 1 deletions(-)
> 
> diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
> index e85d7c4..37686f8 100644
> --- a/bitbake/lib/bb/build.py
> +++ b/bitbake/lib/bb/build.py
> @@ -221,9 +221,10 @@ def exec_func_shell(function, d, runfile, cwd=None):
>  
>      with open(runfile, 'w') as script:
>          script.write('#!/bin/sh -e\n')
> +        if bb.msg.loggerVerboseLogs:
> +            script.write("set -x\n")
>          data.emit_func(function, script, d)
>  
> -        script.write("set -x\n")
>          if cwd:
>              script.write("cd %s\n" % cwd)

Looks good to me but could I suggest one small tweak - position the set
-x after data.emit_func()?

The reason being that having lines of output for each line in the run.*
file is generally painful and it makes more sense to start tracing only
when we start executing the function we care about.

Cheers,

Richard



