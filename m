Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <mark.hatle@windriver.com>) id 1THhCU-0002Nl-BU
	for bitbake-devel@lists.openembedded.org;
	Fri, 28 Sep 2012 22:30:18 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id q8SKHDk9029750
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Sep 2012 13:17:13 -0700 (PDT)
Received: from msp-dhcp5.wrs.com (172.25.34.5) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.309.2;
	Fri, 28 Sep 2012 13:17:12 -0700
Message-ID: <506605C8.8050804@windriver.com>
Date: Fri, 28 Sep 2012 15:17:12 -0500
From: Mark Hatle <mark.hatle@windriver.com>
Organization: Wind River Systems
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8;
	rv:15.0) Gecko/20120907 Thunderbird/15.0.1
MIME-Version: 1.0
To: <bitbake-devel@lists.openembedded.org>
References: <1348853270-29676-1-git-send-email-mark.hatle@windriver.com>
In-Reply-To: <1348853270-29676-1-git-send-email-mark.hatle@windriver.com>
Subject: Re: [PATCH 1/2] utils.py: Check for duplication dependency entries
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
X-List-Received-Date: Fri, 28 Sep 2012 20:30:19 -0000
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

BTW I found a case in OE where duplicates were being unintentionally added by 
the package.bbclass.  I'll have a patch for this sometime in the new few hours.

--Mark

On 9/28/12 12:27 PM, Mark Hatle wrote:
> explode_dep_versions is not able to have duplicate entries.  Previously
> duplicate entries ended up with the last item being the one returned to
> the caller.
>
> Instead we now throw a ValueType exception.  This will ensure the caller
> always gets the full set of declared dependencies.
>
> Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
> ---
>   lib/bb/utils.py |    2 ++
>   1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/lib/bb/utils.py b/lib/bb/utils.py
> index 82dab6b..fa5d2ab 100644
> --- a/lib/bb/utils.py
> +++ b/lib/bb/utils.py
> @@ -159,6 +159,8 @@ def explode_dep_versions(s):
>               lastver = lastver + " " + (i[:-1] or "")
>               r[lastdep] = lastver
>           elif not inversion:
> +            if i in r:
> +                raise ValueError("Error, item %s appeared in dependency string '%s' multiple times.  explode_dep_versions cannot cope with this." % (i, s))
>               r[i] = None
>               lastdep = i
>               lastver = ""
>



