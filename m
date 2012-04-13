Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SIe8t-0006Dq-Nt for bitbake-devel@lists.openembedded.org;
	Fri, 13 Apr 2012 12:54:15 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q3DAipac001482;
	Fri, 13 Apr 2012 11:44:51 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 00827-04; Fri, 13 Apr 2012 11:44:47 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q3DAiZjg001472
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 13 Apr 2012 11:44:39 +0100
Message-ID: <1334313873.7309.67.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Dongxiao Xu <dongxiao.xu@intel.com>
Date: Fri, 13 Apr 2012 11:44:33 +0100
In-Reply-To: <d64dca4f0fcdcea2641e4751bbd300b7d2aa49e1.1334245432.git.dongxiao.xu@intel.com>
References: <cover.1334245432.git.dongxiao.xu@intel.com>
	<d64dca4f0fcdcea2641e4751bbd300b7d2aa49e1.1334245432.git.dongxiao.xu@intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 3/3] Hob: A minor fix on tooltip
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
X-List-Received-Date: Fri, 13 Apr 2012 10:54:16 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2012-04-12 at 23:46 +0800, Dongxiao Xu wrote:
> Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
> ---
>  lib/bb/ui/crumbs/hig.py |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/lib/bb/ui/crumbs/hig.py b/lib/bb/ui/crumbs/hig.py
> index 5cc8a59..b0cfcaf 100644
> --- a/lib/bb/ui/crumbs/hig.py
> +++ b/lib/bb/ui/crumbs/hig.py
> @@ -392,7 +392,7 @@ class AdvancedSettingDialog (CrumbsDialog):
>          j = 1
>          for image_type in self.image_types:
>              self.image_types_checkbuttons[image_type] = gtk.CheckButton(image_type)
> -            self.image_types_checkbuttons[image_type].set_tooltip_text("Build an %s image" % image_type)
> +            self.image_types_checkbuttons[image_type].set_tooltip_text("Build a(n) %s image" % image_type)
>              table.attach(self.image_types_checkbuttons[image_type], j, j + 4, i, i + 1)
>              if image_type in self.configuration.image_fstypes.split():
>                  self.image_types_checkbuttons[image_type].set_active(True)

This change looks rather ugly to me. Whilst we're getting into a
minefield of localisation issues, I'd suggest doing:

article = ""
if image_type.startswith(["a", "e", "i", "o", "h"]):
    article = "n"
self.image_types_checkbuttons[image_type].set_tooltip_text("Build a%s %s image" % (article, image_type))

Whilst this isn't perfect, it should cover our common image types well
enough.

Cheers,

Richard




