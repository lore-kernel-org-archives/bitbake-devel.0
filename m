Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SIeIm-0006gN-26 for bitbake-devel@lists.openembedded.org;
	Fri, 13 Apr 2012 13:04:28 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q3DAt4ZM001601;
	Fri, 13 Apr 2012 11:55:04 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 00827-05; Fri, 13 Apr 2012 11:54:58 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q3DAslTD001587
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 13 Apr 2012 11:54:52 +0100
Message-ID: <1334314486.7309.68.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Dongxiao Xu <dongxiao.xu@intel.com>
Date: Fri, 13 Apr 2012 11:54:46 +0100
In-Reply-To: <7cacaa562688f1b5bd78f7dc12b1c1d1a70196e2.1334245432.git.dongxiao.xu@intel.com>
References: <cover.1334245432.git.dongxiao.xu@intel.com>
	<7cacaa562688f1b5bd78f7dc12b1c1d1a70196e2.1334245432.git.dongxiao.xu@intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/3] command.py: Add a hook for config parsing
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
X-List-Received-Date: Fri, 13 Apr 2012 11:04:28 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2012-04-12 at 23:46 +0800, Dongxiao Xu wrote:
> To make the UI settings take effect, we need to hook at the end of each
> config file parsing and set UI specific values.
> 
> Signed-off-by: Richar Purdie <richard.purdie@linuxfoundation.org>
> Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
> ---
>  lib/bb/command.py                    |    7 +++++++
>  lib/bb/parse/parse_py/ConfHandler.py |    5 +++++
>  2 files changed, 12 insertions(+), 0 deletions(-)
> 
> diff --git a/lib/bb/command.py b/lib/bb/command.py
> index 73aaca0..fd8912a 100644
> --- a/lib/bb/command.py
> +++ b/lib/bb/command.py
> @@ -179,6 +179,13 @@ class CommandsSync:
>          """
>          return bb.utils.cpu_count()
>  
> +    def setConfFilter(self, command, params):
> +        """
> +        Set the configuration file parsing filter
> +        """
> +        filterfunc = params[0]
> +        bb.parse.parse_py.ConfHandler.confFilters.append(filterfunc)
> +
>  class CommandsAsync:
>      """
>      A class of asynchronous commands
> diff --git a/lib/bb/parse/parse_py/ConfHandler.py b/lib/bb/parse/parse_py/ConfHandler.py
> index fa811f3..f108c24 100644
> --- a/lib/bb/parse/parse_py/ConfHandler.py
> +++ b/lib/bb/parse/parse_py/ConfHandler.py
> @@ -71,6 +71,8 @@ def include(oldfn, fn, lineno, data, error_out):
>              raise ParseError("Could not %(error_out)s file %(fn)s" % vars(), oldfn, lineno)
>          logger.debug(2, "CONF file '%s' not found", fn)
>  
> +confFilters = []
> +
>  def handle(fn, data, include):
>      init(data)
>  
> @@ -107,6 +109,9 @@ def handle(fn, data, include):
>      if oldfile:
>          data.setVar('FILE', oldfile)
>  
> +    for f in confFilters:
> +        f(fn, data)
> +
>      return data
>  
>  def feeder(lineno, s, fn, statements):


I've merged this but I added in a comment block about why we need to do
this since its not immediately clear why we need to do something quite
this nasty.

Cheers,

Richard




