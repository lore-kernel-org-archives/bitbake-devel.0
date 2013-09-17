Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 5E6B560F86
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 17 Sep 2013 09:42:26 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8H9ubVw013497 for <bitbake-devel@lists.openembedded.org>;
	Tue, 17 Sep 2013 10:56:37 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 6vS9zfmp2wcw for <bitbake-devel@lists.openembedded.org>;
	Tue, 17 Sep 2013 10:56:37 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8H9uW0u013493
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT) for <bitbake-devel@lists.openembedded.org>;
	Tue, 17 Sep 2013 10:56:33 +0100
Message-ID: <1379410932.32201.97.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 17 Sep 2013 10:42:12 +0100
In-Reply-To: <1379368413-9808-16-git-send-email-richard.purdie@linuxfoundation.org>
References: <1379368413-9808-1-git-send-email-richard.purdie@linuxfoundation.org>
	<1379368413-9808-16-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Subject: Re: [PATCH 16/16] bitbake: bb: Drop deprecated functions
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
X-List-Received-Date: Tue, 17 Sep 2013 09:42:27 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2013-09-16 at 22:53 +0100, Richard Purdie wrote:
> These functions in the main bb module have long been deprecated
> and moved to other modules. Finally remove the compatibility links.
> 
> (Bitbake rev: ccd181c3ed4852e2b9169cf19aaf18aeacddcc18)
> 
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/__init__.py | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/lib/bb/__init__.py b/lib/bb/__init__.py
> index 018b744..8a23a0f 100644
> --- a/lib/bb/__init__.py
> +++ b/lib/bb/__init__.py
> @@ -140,6 +140,3 @@ def deprecate_import(current, modulename, fromlist, renames = None):
>  
>          setattr(sys.modules[current], newname, newobj)
>  
> -deprecate_import(__name__, "bb.fetch", ("MalformedUrl", "encodeurl", "decodeurl"))
> -deprecate_import(__name__, "bb.utils", ("mkdirhier", "movefile", "copyfile", "which"))
> -deprecate_import(__name__, "bb.utils", ["vercmp_string"], ["vercmp"])

I should be clear with this one that now isn't the ideal time to merge
this and that isn't my intention. 

It is a reminder to people that this API *will* go away soon in the 1.6
cycle though.

Cheers,

Richard



