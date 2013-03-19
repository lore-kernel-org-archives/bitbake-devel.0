Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <mark.hatle@windriver.com>) id 1UI2sY-0007Vi-MU
	for bitbake-devel@lists.openembedded.org;
	Tue, 19 Mar 2013 21:11:30 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id r2JJsarx004320
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Mar 2013 12:54:36 -0700 (PDT)
Received: from Marks-MacBook-Pro.local (172.25.36.234) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.2.342.3; Tue, 19 Mar 2013 12:54:36 -0700
Message-ID: <5148C277.70800@windriver.com>
Date: Tue, 19 Mar 2013 14:54:31 -0500
From: Mark Hatle <mark.hatle@windriver.com>
Organization: Wind River Systems
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8;
	rv:17.0) Gecko/20130307 Thunderbird/17.0.4
MIME-Version: 1.0
To: <bitbake-devel@lists.openembedded.org>
References: <1363724931-31720-1-git-send-email-mark.hatle@windriver.com>
In-Reply-To: <1363724931-31720-1-git-send-email-mark.hatle@windriver.com>
Subject: Re: [PATCH] data.py: Add a warning when expandKeys overwrites an existing key
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
X-List-Received-Date: Tue, 19 Mar 2013 20:11:30 -0000
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

On 3/19/13 3:28 PM, Mark Hatle wrote:
> When two variables are defined as:
>
> ${var} = "bar"
> foo = "foobar"
>
> The value of 'foo' when ${var} == foo becomes indeterminate.  We
> want to warn a user when this situation has been encountered so they
> can take corrective actions.
>
> In the above example usually foo == bar, unless multilibs are enabled.
> Then ml-foo = "ml-foobar".

This patch highlights the places where a problem may exist.  When used with the 
current oe-core, it highlights a number of problems with the multilib 
configuration code.  (See patch sent to oe-core.)

I'd like to see this incorporated, but at this point it's definitely an RFC.

> Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
> ---
>   lib/bb/data.py | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/lib/bb/data.py b/lib/bb/data.py
> index 7047f48..110666c 100644
> --- a/lib/bb/data.py
> +++ b/lib/bb/data.py
> @@ -158,6 +158,11 @@ def expandKeys(alterdata, readdata = None):
>
>       for key in todolist:
>           ekey = todolist[key]
> +        if ekey in keys(alterdata):
> +            val = alterdata.getVar(key, 0)
> +            newval = alterdata.getVar(ekey, 0)
> +            if val is not None and newval is not None:
> +                bb.warn("Variable key %s (%s) replaces original key %s (%s)." % (key, val, ekey, newval))
>           alterdata.renameVar(key, ekey)
>
>   def inheritFromOS(d, savedenv, permitted):
>



