Received: from mail.mlbassoc.com ([65.100.170.105] helo=mail.chez-thomas.org)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <gary@mlbassoc.com>) id 1TEeY7-0007RM-80
	for bitbake-devel@lists.openembedded.org;
	Thu, 20 Sep 2012 13:04:03 +0200
Received: by mail.chez-thomas.org (Postfix, from userid 1998)
	id D474BF81229; Thu, 20 Sep 2012 04:44:51 -0600 (MDT)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on
	hermes.chez-thomas.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.3.2
Received: from [192.168.1.114] (zeus [192.168.1.114])
	by mail.chez-thomas.org (Postfix) with ESMTP id DBEF7F81226;
	Thu, 20 Sep 2012 04:44:50 -0600 (MDT)
Message-ID: <505AF3A4.7050707@mlbassoc.com>
Date: Thu, 20 Sep 2012 04:44:52 -0600
From: Gary Thomas <gary@mlbassoc.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:15.0) Gecko/20120827 Thunderbird/15.0
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <6C2434209962DC46B88345CA85C334A20183E5A98599@Courier.syntech.org>
In-Reply-To: <6C2434209962DC46B88345CA85C334A20183E5A98599@Courier.syntech.org>
Subject: Re: cvs.py fetcher
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
X-List-Received-Date: Thu, 20 Sep 2012 11:04:03 -0000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 2012-09-18 10:27, Jate Sujjavanich wrote:
> While using a newer bitbake, I ran into some issues with a recipe that has a cvs SRC_URI. This patch fixes it, and I wanted to submit it for further review.
>
>
> The localdata variable was removed but is required later in the download
> function.
> Add an extra space so that cvscmd's parameter is separated from the
> command.
> Signed-off-by: Jate Sujjavanich <jate.sujjavanich@myfuelmaster.com>
> ----------------------------- lib/bb/fetch2/cvs.py ----------------------------
> diff --git a/lib/bb/fetch2/cvs.py b/lib/bb/fetch2/cvs.py
> index 6a948c4..5249d85 100644
> --- a/lib/bb/fetch2/cvs.py
> +++ b/lib/bb/fetch2/cvs.py
> @@ -111,8 +111,10 @@
>           if ud.tag:
>               options.append("-r %s" % ud.tag)
>
> +        localdata = data.createCopy(d)
> +
>           cvsbasecmd = d.getVar("FETCHCMD_cvs", True)
> -        cvscmd = cvsbasecmd + "'-d" + cvsroot + "' co " + " ".join(options) + " " + ud.module
> +        cvscmd = cvsbasecmd + " " + "'-d" + cvsroot + "' co " + " ".join(options) + " " + ud.module

Why not just add the space to the string that's already there, rather
than add another concatenation?  i.e.
     cvscmd = cvsbasecmd + " '-d" + cvsroot + "' co " + " ".join(options) + " " + ud.module

>           cvsupdatecmd = cvsbasecmd + "'-d" + cvsroot + "' update -d -P " + " ".join(options)
>
>           if cvs_rsh:

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------


