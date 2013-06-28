Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id C27B26023E
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Jun 2013 16:56:49 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r5SH3lmG010508; Fri, 28 Jun 2013 18:03:48 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id M_LlyBRA2jxq; Fri, 28 Jun 2013 18:03:47 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r5SH3gwN010500
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Fri, 28 Jun 2013 18:03:44 +0100
Message-ID: <1372438595.9930.274.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joe MacDonald <joe.macdonald@windriver.com>
Date: Fri, 28 Jun 2013 17:56:35 +0100
In-Reply-To: <1372431907-10142-2-git-send-email-joe.macdonald@windriver.com>
References: <1372431907-10142-1-git-send-email-joe.macdonald@windriver.com>
	<1372431907-10142-2-git-send-email-joe.macdonald@windriver.com>
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake][oe-core][RFC PATCH 1/2] fetch2: Add an extra check for sstate_mirrors
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 28 Jun 2013 16:56:50 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2013-06-28 at 11:05 -0400, Joe MacDonald wrote:
> BB_NO_NETWORK disables any fetching, however if we're using an external
> sstate cache, we may want to be able to fetch those objects even if we are
> not fetching the upstream sources.
> 
> Signed-off-by: Joe MacDonald <joe.macdonald@windriver.com>
> ---
>  bitbake/lib/bb/fetch2/__init__.py |   18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)


Bitbake's fetch module knows nothing about sstate right now and I don't
see any reason to teach it about it. Why can't you just change
BB_NO_NETWORK in sstate.bbclass before we call into the fetcher?

Cheers,

Richard

> diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
> index 6211cd7..edd290b3 100644
> --- a/bitbake/lib/bb/fetch2/__init__.py
> +++ b/bitbake/lib/bb/fetch2/__init__.py
> @@ -714,10 +714,13 @@ def check_network_access(d, info = "", url = None):
>      """
>      log remote network access, and error if BB_NO_NETWORK is set
>      """
> -    if d.getVar("BB_NO_NETWORK", True) == "1":
> -        raise NetworkAccess(url, info)
> +    if d.getVar("SSTATE_MIRROR_ALLOW_NETWORK", True) == "1" and d.getVar("LOCAL_SSTATE_CACHE", True) == True:
> +        logger.debug(1, "Fetcher accessed the network for sstate cache data with the command %s" % info)
>      else:
> -        logger.debug(1, "Fetcher accessed the network with the command %s" % info)
> +        if d.getVar("BB_NO_NETWORK", True) == "1":
> +            raise NetworkAccess(url, info)
> +        else:
> +            logger.debug(1, "Fetcher accessed the network with the command %s" % info)
>  
>  def build_mirroruris(origud, mirrors, ld):
>      uris = []
> @@ -1301,7 +1304,7 @@ class FetchMethod(object):
>          return "%s-%s" % (key, d.getVar("PN", True) or "")
>  
>  class Fetch(object):
> -    def __init__(self, urls, d, cache = True, localonly = False):
> +    def __init__(self, urls, d, cache = True, localonly = False, sstate_cache = False):
>          if localonly and cache:
>              raise Exception("bb.fetch2.Fetch.__init__: cannot set cache and localonly at same time")
>  
> @@ -1310,6 +1313,8 @@ class Fetch(object):
>          self.urls = urls
>          self.d = d
>          self.ud = {}
> +        self.sstate_cache = sstate_cache
> +        d.setVar("LOCAL_SSTATE_CACHE", sstate_cache)
>  
>          fn = d.getVar('FILE', True)
>          if cache and fn and fn in urldata_cache:
> @@ -1354,7 +1359,10 @@ class Fetch(object):
>          if len(urls) == 0:
>              urls = self.urls
>  
> -        network = self.d.getVar("BB_NO_NETWORK", True)
> +        if self.sstate_cache == True and self.d.getVar("SSTATE_MIRROR_ALLOW_NETWORK", True) == True:
> +            network = True
> +        else:
> +            network = self.d.getVar("BB_NO_NETWORK", True)
>          premirroronly = (self.d.getVar("BB_FETCH_PREMIRRORONLY", True) == "1")
>  
>          for u in urls:



