Return-Path: <michael.g.wood@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 2DB9C760B0
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  4 Aug 2016 10:04:08 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by orsmga101.jf.intel.com with ESMTP; 04 Aug 2016 03:04:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,470,1464678000"; d="scan'208";a="150467198"
Received: from jmiler-mobl.ger.corp.intel.com (HELO [10.252.8.71])
	([10.252.8.71])
	by fmsmga004.fm.intel.com with ESMTP; 04 Aug 2016 03:04:09 -0700
To: "Liam R. Howlett" <Liam.Howlett@windriver.com>,
	bitbake-devel@lists.openembedded.org
References: <1470254270-5368-1-git-send-email-Liam.Howlett@WindRiver.com>
	<1470254270-5368-3-git-send-email-Liam.Howlett@WindRiver.com>
From: Michael Wood <michael.g.wood@intel.com>
Message-ID: <83fbdbc7-f386-d991-d45e-303722fe0b23@intel.com>
Date: Thu, 4 Aug 2016 11:04:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
	Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <1470254270-5368-3-git-send-email-Liam.Howlett@WindRiver.com>
Subject: Re: [PATCH 2/2] bin/toaster: set shwordsplit if using zsh.
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
X-List-Received-Date: Thu, 04 Aug 2016 10:04:11 -0000
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable

On 03/08/16 20:57, Liam R. Howlett wrote:
> Since this script is meant to be sourced, shwordsplit has to be
> explicitly set to ensure the variable MANAGE is set correctly and
> functions independent of the users shwordsplit setting.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@WindRiver.com>
> ---
>   bin/toaster | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/bin/toaster b/bin/toaster
> index 66157d0..038e93b 100755
> --- a/bin/toaster
> +++ b/bin/toaster
> @@ -130,6 +130,7 @@ if [ -n "$BASH_SOURCE" ] ; then
>       TOASTER=3D${BASH_SOURCE}
>   elif [ -n "$ZSH_NAME" ] ; then
>       TOASTER=3D${(%):-%x}
> +    set -o shwordsplit
>   else
>       TOASTER=3D$0
>   fi

Thanks for these patches. Both look fine to me.

If you have patches for Toaster in the future we usually review them on =

the toaster mailing list first and then the reviewer sends them to =

bitbake-devel.

For more info please see =

https://wiki.yoctoproject.org/wiki/Contribute_to_Toaster

Michael


---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


