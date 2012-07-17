Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Sr4dg-0008Fr-R4 for bitbake-devel@lists.openembedded.org;
	Tue, 17 Jul 2012 12:04:21 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q6H9r2qS010252;
	Tue, 17 Jul 2012 10:53:02 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 08793-05; Tue, 17 Jul 2012 10:52:58 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q6H9qr8c010246
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 17 Jul 2012 10:52:54 +0100
Message-ID: <1342518777.10484.2.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Kang Kai <kai.kang@windriver.com>
Date: Tue, 17 Jul 2012 10:52:57 +0100
In-Reply-To: <97edd3e3b004e658241e3b3fc759837686deff74.1342495796.git.kai.kang@windriver.com>
References: <cover.1342495796.git.kai.kang@windriver.com>
	<97edd3e3b004e658241e3b3fc759837686deff74.1342495796.git.kai.kang@windriver.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org, Zhenfeng.Zhao@windriver.com
Subject: Re: [PATCH 1/1] hob2: add elf to hcc supported image types
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
X-List-Received-Date: Tue, 17 Jul 2012 10:04:21 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2012-07-17 at 14:58 +0800, Kang Kai wrote:
> [Yocto #2709]
> 
> OE Core Commit c9b01af84b64edba056f959c349895e0698324e6 add elf image
> type. This will cause hob build image failed.
> Add elf to hcc supoorted image types to fix this issue.
> 
> Signed-off-by: Kang Kai <kai.kang@windriver.com>
> ---
>  bitbake/lib/bb/ui/crumbs/hobwidget.py |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/bitbake/lib/bb/ui/crumbs/hobwidget.py b/bitbake/lib/bb/ui/crumbs/hobwidget.py
> index dba278c..d10c56b 100644
> --- a/bitbake/lib/bb/ui/crumbs/hobwidget.py
> +++ b/bitbake/lib/bb/ui/crumbs/hobwidget.py
> @@ -89,6 +89,7 @@ class hcc:
>          "cpio.xz"       : ["cpio.xz"],
>          "vmdk"          : ["vmdk"],
>          "cpio.lzma"     : ["cpio.lzma"],
> +        "elf"           : ["elf"],
>      }
>  
>  class HobViewTable (gtk.VBox):

Why do we have a hardcoded list here and why do new image types cause
builds to fail?

We need to rewrite this code so this does not happen and the user at
least gets a sensible error message. Hardcoded lists are bad...

I've merged the patch but I'd like to see a bug opened about this.

Cheers,

Richard



