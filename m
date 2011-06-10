Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1QV0tg-0008Sf-S8 for bitbake-devel@lists.openembedded.org;
	Fri, 10 Jun 2011 14:33:11 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p5ACTjSb026763;
	Fri, 10 Jun 2011 13:29:45 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 26168-09; Fri, 10 Jun 2011 13:29:42 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p5ACTaFf026757
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 10 Jun 2011 13:29:40 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Dexuan Cui <dexuan.cui@intel.com>
In-Reply-To: <6439f6f95ef1157063276692bcf2adfebb7597eb.1307693771.git.dexuan.cui@intel.com>
References: <cover.1307693771.git.dexuan.cui@intel.com>
	<6439f6f95ef1157063276692bcf2adfebb7597eb.1307693771.git.dexuan.cui@intel.com>
Date: Fri, 10 Jun 2011 13:29:24 +0100
Message-ID: <1307708964.15712.210.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] bitbake-layers: stop the warning "not been run using the bitbake wrapper..."
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
X-List-Received-Date: Fri, 10 Jun 2011 12:33:11 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2011-06-10 at 16:18 +0800, Dexuan Cui wrote:
> Signed-off-by: Dexuan Cui <dexuan.cui@intel.com>
> ---
>  bitbake/bin/bitbake-layers |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/bitbake/bin/bitbake-layers b/bitbake/bin/bitbake-layers
> index 6b5ad5a..aa6d031 100755
> --- a/bitbake/bin/bitbake-layers
> +++ b/bitbake/bin/bitbake-layers
> @@ -29,6 +29,10 @@ def main(args):
>      logging.basicConfig(format='%(levelname)s: %(message)s')
>      bb.utils.clean_environment()
>  
> +    # set PSEUDO_BUILD after clean_environment() , or else, the setting will
> +    # be filtered out.
> +    os.environ["PSEUDO_BUILD"] = "0"
> +
>      cmds = Commands()
>      if args:
>          cmds.onecmd(' '.join(args))

We can't add implementation specific information to bitbake I'm afraid
so we'll need to find a different way to handle this...

Cheers,

Richard



