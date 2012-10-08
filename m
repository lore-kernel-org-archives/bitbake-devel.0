Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TLA8b-0004iz-8q for bitbake-devel@lists.openembedded.org;
	Mon, 08 Oct 2012 12:00:37 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q989lT6Y017819;
	Mon, 8 Oct 2012 10:47:29 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 17236-03; Mon,  8 Oct 2012 10:47:25 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q989lL7m017813
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 8 Oct 2012 10:47:22 +0100
Message-ID: <1349689645.15658.108.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Cristiana Voicu <cristiana.voicu@intel.com>
Date: Mon, 08 Oct 2012 10:47:25 +0100
In-Reply-To: <1349686879-25765-1-git-send-email-cristiana.voicu@intel.com>
References: <1349686879-25765-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] hob/imageconfigurationpage: a 'hob-image' appears listed in the base image combo box
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
X-List-Received-Date: Mon, 08 Oct 2012 10:00:37 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2012-10-08 at 12:01 +0300, Cristiana Voicu wrote:
> -remove this image from image combo box
> 
> [YOCTO #3230]
> Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
> ---
>  bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
> index e1c7a67..32e5c45 100644
> --- a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
> +++ b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
> @@ -368,6 +368,7 @@ class ImageConfigurationPage (HobPage):
>          if self.builder.parameters.image_black_pattern:
>              for i in self.builder.parameters.image_black_pattern.split():
>                  black_pattern.append(re.compile(i))
> +        black_pattern.append("hob-image")
>  
>          it = image_model.get_iter_first()
>          self._image_combo_disconnect_signal()
> @@ -386,13 +387,13 @@ class ImageConfigurationPage (HobPage):
>              if black_pattern:
>                  allow = True
>                  for pattern in black_pattern:
> -                    if pattern.search(image_name):
> +                    if image_name in pattern:
>                          allow = False
>                          break
>              elif white_pattern:
>                  allow = False
>                  for pattern in white_pattern:
> -                    if pattern.search(image_name):
> +                    if image_name in pattern:
>                          allow = True
>                          break
>              else:

>>> import re
>>> foo=re.compile("bar.*")
>>> if "bar1" in foo:
...     print "ok"
... 
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: argument of type '_sre.SRE_Pattern' is not iterable

which is effectively what you're doing above. You probably want
something like:

+        black_pattern.append(re.compile("hob-image"))

and leave the .search() calls in?

Cheers,

Richard





