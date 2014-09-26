Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 08D8460167
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 26 Sep 2014 12:10:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	s8QCALnA007766; Fri, 26 Sep 2014 13:10:21 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id j70OCYtB4IsY; Fri, 26 Sep 2014 13:10:21 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	s8QCAF8l007763
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 26 Sep 2014 13:10:16 +0100
Message-ID: <1411733418.4189.116.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alejandro Hernandez <alejandro.hernandez@linux.intel.com>
Date: Fri, 26 Sep 2014 13:10:18 +0100
In-Reply-To: <1411686885-8169-1-git-send-email-alejandro.hernandez@linux.intel.com>
References: <1411686885-8169-1-git-send-email-alejandro.hernandez@linux.intel.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] fetcher: fix BB_STRICT_CHECKSUM datatype check
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
X-List-Received-Date: Fri, 26 Sep 2014 12:10:28 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2014-09-25 at 18:14 -0500, Alejandro Hernandez wrote:
> [YOCTO #6762]
> 
> Signed-off-by: Alejandro Hernandez <alejandro.hernandez@linux.intel.com>
> ---
>  lib/bb/fetch2/__init__.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index df2f2b0..e182a9d 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -544,7 +544,7 @@ def verify_checksum(ud, d):
>      if ud.method.recommends_checksum(ud):
>          # If strict checking enabled and neither sum defined, raise error
>          strict = d.getVar("BB_STRICT_CHECKSUM", True) or None
> -        if strict and not (ud.md5_expected or ud.sha256_expected):
> +        if (strict == 1) and not (ud.md5_expected or ud.sha256_expected):
>              logger.error('No checksum specified for %s, please add at least one to the recipe:\n'
>                               'SRC_URI[%s] = "%s"\nSRC_URI[%s] = "%s"' %
>                               (ud.localpath, ud.md5_name, md5data,

This gets slightly tricky since the value can be a string or an integer
or "None". This needs to work if strict = "1" as well as strict = 1 for
example.

I'm thinking we should perhaps import the boolean function from
meta/lib/oe/types.py in OE-Core into a new types module in bitbake, as
well as perhaps allowing the function to accept integers of 0 (False)
and other than 0 (True) and accepting "None" as False.

We could then use this function here to get a "good" value for the
field. There are a number of other places we should really start using a
standardised function too...

From the bigger picture perspective, we've long since wanted to have
better typed variables, there is a bit more planning needed for that
however this would be a good step towards it IMO.

Cheers,

Richard


