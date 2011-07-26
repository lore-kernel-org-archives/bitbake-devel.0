Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QlYGM-0002pv-LX
	for bitbake-devel@lists.openembedded.org;
	Tue, 26 Jul 2011 05:24:54 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 25 Jul 2011 20:20:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,266,1309762800"; d="scan'208";a="31414634"
Received: from unknown (HELO [10.255.14.158]) ([10.255.14.158])
	by azsmga001.ch.intel.com with ESMTP; 25 Jul 2011 20:20:40 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 25 Jul 2011 20:20:35 -0700
In-Reply-To: <1311617994.2344.194.camel@rex>
References: <1311617994.2344.194.camel@rex>
X-Mailer: Evolution 3.0.2 (3.0.2-3.fc15) 
Message-ID: <1311650440.2260.12.camel@scimitar>
Mime-Version: 1.0
Subject: Re: [PATCH] bitbake/utils: 'Fix' bb.utils.contains() behaviour
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
X-List-Received-Date: Tue, 26 Jul 2011 03:24:55 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2011-07-25 at 19:19 +0100, Richard Purdie wrote:
> Currently bb.utils.contains(X, "A", true, false) will return true for substring matches,
> e.g. if X = "ABC". This is not what most users expect from the function.
> 
> In the common OE use of this function there is the case of "touchscreen" and "screen" being
> used as independent variables. Whilst it could be argued there isn't a problem in that
> specific case (touchscreens are usually on screens), there is no substring usage of this
> function is OE-Core so this patch changes the behaviour to match only full strings.
> 
> It also fixes a bug where duplicate entries would confuse multiple matches, e.g.
> contains(X, ["A", "B"], ...) would match X = "A A" which is clearly wrong.
> 
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

Signed-off-by: Joshua Lock <josh@linux.intel.com>

> ---
> diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
> index 075ca88..4eac285 100644
> --- a/lib/bb/utils.py
> +++ b/lib/bb/utils.py
> @@ -861,12 +861,11 @@ def contains(variable, checkvalues, truevalue, falsevalue, d):
>      val = d.getVar(variable, True)
>      if not val:
>          return falsevalue
> -    matches = 0
> -    if type(checkvalues).__name__ == "str":
> -        checkvalues = [checkvalues]
> -    for value in checkvalues:
> -        if val.find(value) != -1:
> -            matches = matches + 1
> -    if matches == len(checkvalues):
> +    val = set(val.split())
> +    if isinstance(checkvalues, basestring):
> +        checkvalues = set(checkvalues.split())
> +    else:
> +        checkvalues = set(checkvalues)
> +    if checkvalues.issubset(val): 
>          return truevalue
>      return falsevalue
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



