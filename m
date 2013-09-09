Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 7EC816BE32
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Sep 2013 15:33:06 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r89FkZM5013027; Mon, 9 Sep 2013 16:46:36 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id FNSKKAX-FUa3; Mon,  9 Sep 2013 16:46:35 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r89FkVhG013019
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Mon, 9 Sep 2013 16:46:33 +0100
Message-ID: <1378740773.3484.126.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Robert Yang <liezhi.yang@windriver.com>
Date: Mon, 09 Sep 2013 16:32:53 +0100
In-Reply-To: <27659d52912f96cb30a1a2d44638b262b50c1acc.1378121138.git.liezhi.yang@windriver.com>
References: <cover.1378121137.git.liezhi.yang@windriver.com>
	<27659d52912f96cb30a1a2d44638b262b50c1acc.1378121138.git.liezhi.yang@windriver.com>
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 2/2] taskdata.py: set PREFERRED_VERSION when it is in the item
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
X-List-Received-Date: Mon, 09 Sep 2013 15:33:07 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2013-09-02 at 09:41 -0400, Robert Yang wrote:
> There is an error if we:
> 
> $ bitbake make (the make-3.82 will be built)
> // Edit make.inc
> $ bitbake make-3.81
> [snip]
>  *** 0004:    mfile = open(manifest)
>      0005:    entries = mfile.readlines()
>      0006:    mfile.close()
>      0007:
>      0008:    for entry in entries:
> Exception: IOError: [Errno 2] No such file or directory: xxx
> [snip]
> 
> Set the PREFERRED_VERSION if we find the version info in the item would fix the
> problem, I think that we need iterate in all the packages since it seems that
> we can't know wether the item is just a PN or PN-PV unless we compare them,
> what can I think is check len(all_p) == 1, but this doesn't work when the same
> recipe is multiple layers.
> 
> [YOCTO #5067]
> 
> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
> ---
>  bitbake/lib/bb/taskdata.py |   15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/bitbake/lib/bb/taskdata.py b/bitbake/lib/bb/taskdata.py
> index 58fe199..38a3191 100644
> --- a/bitbake/lib/bb/taskdata.py
> +++ b/bitbake/lib/bb/taskdata.py
> @@ -430,6 +430,21 @@ class TaskData:
>  
>          all_p = dataCache.providers[item]
>  
> +        # Check whether item has the one of following formats and set the
> +        # PREFERRED_VERSION if it does:
> +        # - <pn>-<pv>
> +        # - <pn>-<pv>-<pr> (when no PE)
> +        # - <pn>-<pe>_<pv>-<pr> (when PE)
> +        for fn in all_p:
> +            pn = dataCache.pkg_fn[fn]
> +            pe = dataCache.pkg_pepvpr[fn][0]
> +            pv = dataCache.pkg_pepvpr[fn][1]
> +            pr = dataCache.pkg_pepvpr[fn][2]
> +            if not pe and (item == "%s-%s" % (pn, pv) or item == "%s-%s-%s" % (pn, pv, pr)):
> +                cfgData.setVar("PREFERRED_VERSION_" + pn, pv)
> +            elif pe and item == "%s-%s_%s-%s" % (pn, pe, pv, pr):
> +                cfgData.setVar("PREFERRED_VERSION_" + pn, pv)
> +
>          eligible, foundUnique = bb.providers.filterProviders(all_p, item, cfgData, dataCache)
>          eligible = [p for p in eligible if not self.getfn_id(p) in self.failed_fnids]
>  


This is a neat solution and I'm torn over it. On the one hand it does
address the problem. On the other hand:

a) Its implementation specific knowledge since bitbake.conf in OE-Core
is responsible for the extra PROVIDES
b) It would confuse things if some recipe does DEPENDS = "make-3.81"
c) The performance of this code isn't going to be good

b) can be fixed by adding a bb.warn(), c) might be either not much of an
issue or could be fixed, a) is a real problem though.

I've put a counter proposal on the OE-Core mailing list suggesting we
simplify PROVIDES in bitbake.conf. Depending on the feedback, we can
either take that patch or this one with a bb.warn() added. Need some
user feedback...

Cheers,

Richard


