Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id AE44160E03
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Dec 2013 21:22:05 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	rBJLLr4S011277; Thu, 19 Dec 2013 21:21:54 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id XlbzWQW8yqf9; Thu, 19 Dec 2013 21:21:53 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	rBJLLnJV011265
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 19 Dec 2013 21:21:50 GMT
Message-ID: <1387488104.6402.75.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alex DAMIAN <alexandru.damian@intel.com>
Date: Thu, 19 Dec 2013 21:21:44 +0000
In-Reply-To: <1387394811-24196-1-git-send-email-alexandru.damian@intel.com>
References: <1387394811-24196-1-git-send-email-alexandru.damian@intel.com>
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] toaster: add buildstats to toaster config file
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
X-List-Received-Date: Thu, 19 Dec 2013 21:22:07 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2013-12-18 at 19:26 +0000, Alex DAMIAN wrote:
> From: Alexandru DAMIAN <alexandru.damian@intel.com>
> 
> Toaster needs buildstats to be enabled in order to
> be able to collect task running stats. This patch
> adds buildstats to the running configuration in toaster mode.
> 
> Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
> ---
>  bin/toaster | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/bin/toaster b/bin/toaster
> index 38e71ac..d6c3175 100755
> --- a/bin/toaster
> +++ b/bin/toaster
> @@ -61,10 +61,13 @@ function webserverStartAll()
>  }
>  
>  # Helper functions to add a special configuration file
> +function initConfiguration()
> +{
> +        echo "#Created by toaster start script" > ${BUILDDIR}/conf/$1
> +}
>  
>  function addtoConfiguration()
>  {
> -        echo "#Created by toaster start script" > ${BUILDDIR}/conf/$2
>          echo $1 >> ${BUILDDIR}/conf/$2
>  }
>  
> @@ -167,7 +170,9 @@ fi
>  case $CMD in
>      start )
>          start_success=1
> +        initConfiguration toaster.conf
>          addtoConfiguration "INHERIT+=\"toaster buildhistory\"" toaster.conf
> +        addtoConfiguration "USER_CLASSES+=\"buildstats\"" toaster.conf
>          if ! webserverStartAll; then
>              echo "Failed ${CMD}."
>              return 4

Why not just add this to the INHERIT? I'm trying to figure out if
USER_CLASSES is special in some way and when we should use one and when
we should use the other...

Cheers,

Richard



