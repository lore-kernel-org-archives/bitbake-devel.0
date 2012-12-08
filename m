Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Th8WR-0005eq-0H for bitbake-devel@lists.openembedded.org;
	Sat, 08 Dec 2012 01:44:03 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qB80TZtb009850
	for <bitbake-devel@lists.openembedded.org>; Sat, 8 Dec 2012 00:29:35 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 08513-08 for <bitbake-devel@lists.openembedded.org>;
	Sat,  8 Dec 2012 00:29:31 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qB80TS9E009844
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>; Sat, 8 Dec 2012 00:29:29 GMT
Message-ID: <1354926558.12928.48.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sat, 08 Dec 2012 00:29:18 +0000
In-Reply-To: <1354885851.12928.25.camel@ted>
References: <1354885851.12928.25.camel@ted>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: Re: [PATCH] BBHandler: Ensure parser state engine is correctly reset for new parsing
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
X-List-Received-Date: Sat, 08 Dec 2012 00:44:03 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2012-12-07 at 13:10 +0000, Richard Purdie wrote:
> The classes variable in particular could be in an odd state if parsing of a
> previous recipe had abruptly ended.
> 
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
> diff --git a/bitbake/lib/bb/parse/parse_py/BBHandler.py b/bitbake/lib/bb/parse/parse_py/BBHandler.py
> index 2e0647b..c4e579d 100644
> --- a/bitbake/lib/bb/parse/parse_py/BBHandler.py
> +++ b/bitbake/lib/bb/parse/parse_py/BBHandler.py
> @@ -107,14 +107,15 @@ def get_statements(filename, absolute_filename, base_name):
>          return statements
>  
>  def handle(fn, d, include):
> -    global __func_start_regexp__, __inherit_regexp__, __export_func_regexp__, __addtask_regexp__, __addhandler_regexp__, __infunc__, __body__, __residue__
> +    global __func_start_regexp__, __inherit_regexp__, __export_func_regexp__, __addtask_regexp__, __addhandler_regexp__, __infunc__, __body__, __residue__, __inpython__, classes
>      __body__ = []
>      __infunc__ = ""
>      __classname__ = ""
>      __residue__ = []
> -
> +    __inpython__ = False
>  
>      if include == 0:
> +        classes = [ None, ]
>          logger.debug(2, "BB %s: handle(data)", fn)
>      else:
>          logger.debug(2, "BB %s: handle(data, include)", fn)

This patch doesn't work. To cut a long story short, "classes" is getting
cached inside the ast statement cache and shouldn't be. This is likely
the source of the problems.

Trying to fix that leads to a voyage of discovery of other breakage :(

Its likely going to end up with the EXPORT_FUNCTION implementation
needing rewriting, or at least how/where its getting its class lists
from.

Cheers,

Richard






