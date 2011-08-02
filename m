Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1QoFEo-0001hy-Va for bitbake-devel@lists.openembedded.org;
	Tue, 02 Aug 2011 15:42:27 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p72Dc5J8015698;
	Tue, 2 Aug 2011 14:38:05 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 14687-08; Tue,  2 Aug 2011 14:38:01 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p72DbudE015692
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 2 Aug 2011 14:37:56 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Lock <josh@linux.intel.com>
In-Reply-To: <a727b7256bcab11fb35c712a5920c1b8ed6f9425.1312240827.git.josh@linux.intel.com>
References: <cover.1312240827.git.josh@linux.intel.com>
	<a727b7256bcab11fb35c712a5920c1b8ed6f9425.1312240827.git.josh@linux.intel.com>
Date: Tue, 02 Aug 2011 14:37:39 +0100
Message-ID: <1312292259.2344.593.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [RFC PATCH 1/1] cooker: store a list of parsed configuration files
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
X-List-Received-Date: Tue, 02 Aug 2011 13:42:27 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2011-08-01 at 16:22 -0700, Joshua Lock wrote:
> Signed-off-by: Joshua Lock <josh@linux.intel.com>
> ---
>  lib/bb/cooker.py                     |    3 +++
>  lib/bb/parse/parse_py/ConfHandler.py |    3 +++
>  2 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
> index 025dfe4..c7142e1 100644
> --- a/lib/bb/cooker.py
> +++ b/lib/bb/cooker.py
> @@ -772,6 +772,9 @@ class BBCooker:
>          for p in postfiles:
>              data = _parse(p, data)
>  
> +        self.configuration.parsed_configuration = (bb.data.getVar('PARSED_CONF', data) or '').split(':')
> +        bb.data.delVar('PARSED_CONF', data)
> +
>          # Handle any INHERITs and inherit the base class
>          bbclasses  = ["base"] + (data.getVar('INHERIT', True) or "").split()
>          for bbclass in bbclasses:
> diff --git a/lib/bb/parse/parse_py/ConfHandler.py b/lib/bb/parse/parse_py/ConfHandler.py
> index 102c0e9..22686b7 100644
> --- a/lib/bb/parse/parse_py/ConfHandler.py
> +++ b/lib/bb/parse/parse_py/ConfHandler.py
> @@ -103,6 +103,9 @@ def handle(fn, data, include):
>  
>      # DONE WITH PARSING... time to evaluate
>      bb.data.setVar('FILE', fn, data)
> +    conf_files = bb.data.getVar('PARSED_CONF', data) or ''
> +    bb.data.setVar('PARSED_CONF', "%s:%s" % (conf_files, abs_fn), data)
> +
>      statements.eval(data)
>      if oldfile:
>          bb.data.setVar('FILE', oldfile, data)

Hmm, this isn't particularly nice :/

At the very least call the variable __BB<something> to indicate its
internal.

Did you find and have a look at the internal __depends and
__base_depends variables?

Cheers,

Richard






