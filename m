Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 87E586B7B7
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Mar 2014 16:51:17 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s2RGoR8g007794; Thu, 27 Mar 2014 16:51:06 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 3b61TPEQa1Vr; Thu, 27 Mar 2014 16:51:05 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s2RGow9F007895
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 27 Mar 2014 16:51:00 GMT
Message-ID: <1395939052.24890.141.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alex DAMIAN <alexandru.damian@intel.com>
Date: Thu, 27 Mar 2014 16:50:52 +0000
In-Reply-To: <1395925753-31968-1-git-send-email-alexandru.damian@intel.com>
References: <1395925753-31968-1-git-send-email-alexandru.damian@intel.com>
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org, toaster@yoctoproject.org
Subject: Re: [Toaster] [PATCH 1/1] bitbake: toaster: fix timezone detection
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
X-List-Received-Date: Thu, 27 Mar 2014 16:51:21 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2014-03-27 at 13:09 +0000, Alex DAMIAN wrote:
> From: Alexandru DAMIAN <alexandru.damian@intel.com>
> 
> This patch replaces faulty timezone detection with a version
> that simply reads the TZ environment variable if it is set.
> 
> If the TZ is not set, we do a reverse match search among known
> timezone definitions and take the first match.
> 
> 	[YOCTO #5499]
> 
> Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
> ---
>  bitbake/lib/toaster/toastermain/settings.py | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/bitbake/lib/toaster/toastermain/settings.py b/bitbake/lib/toaster/toastermain/settings.py
> index 51fa3cc..98d2ac3 100644
> --- a/bitbake/lib/toaster/toastermain/settings.py
> +++ b/bitbake/lib/toaster/toastermain/settings.py
> @@ -51,8 +51,16 @@ ALLOWED_HOSTS = []
>  # In a Windows environment this must be set to your system time zone.
>  
>  # Always use local computer's time zone
> -import time
> -TIME_ZONE = time.tzname[0]
> +import os, subprocess
> +
> +# the TZ variable overrides any default timezone setting
> +if 'TZ' in os.environ:
> +    TIME_ZONE = os.environ['TZ']
> +else:
> +    # need to read the /etc/localtime file which is the libc standard
> +    # and do a reverse-mapping to /usr/share/zoneinfo/; since the timezone may match any number of identical timezone definitions,
> +    # we just select the first that matches
> +    TIME_ZONE = subprocess.Popen("find /usr/share/zoneinfo/  -type f -exec diff -s {} /etc/localtime \; | grep identical | head -1 | awk '{print $2;}' | sed 's/\/usr\/share\/zoneinfo\///'", shell=True, stdout = subprocess.PIPE).communicate()[0].strip()

Forking off a shell pipeline for this is rather ugly, particularly every
time the program starts :/

Cheers,

Richard
 




