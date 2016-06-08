Return-Path: <benjamin.esquivel@linux.intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id B0ED6612E5
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  8 Jun 2016 16:56:31 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga104.fm.intel.com with ESMTP; 08 Jun 2016 09:56:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.26,440,1459839600"; d="scan'208";a="715990857"
Received: from besquive-mobl2.zpn.intel.com ([10.219.128.114])
	by FMSMGA003.fm.intel.com with ESMTP; 08 Jun 2016 09:56:31 -0700
Message-ID: <1465405026.19191.9.camel@linux.intel.com>
From: Benjamin Esquivel <benjamin.esquivel@linux.intel.com>
Reply-To: benjamin.esquivel@linux.intel.com
To: mariano.lopez@linux.intel.com, bitbake-devel@lists.openembedded.org
In-Reply-To: <1465302459-38277-1-git-send-email-mariano.lopez@linux.intel.com>
References: <1465302459-38277-1-git-send-email-mariano.lopez@linux.intel.com>
Organization: Intel Corporation
Date: Wed, 08 Jun 2016 11:57:06 -0500
Mime-Version: 1.0
X-Mailer: Evolution 3.18.5.2 (3.18.5.2-1.fc23) 
Subject: Re: [PATCH] lib/bb/main.py: Fix use of BBPOSTCONF and BBPRECONF
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
X-List-Received-Date: Wed, 08 Jun 2016 16:56:31 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Looking good!

On Tue, 2016-06-07 at 12:27 +0000, mariano.lopez@linux.intel.com wrote:
> From: Mariano Lopez <mariano.lopez@linux.intel.com>
> 
> The functionality of BBPOSTCONF and BBPRECONF was added in
> commit 21b314d4d1e5b8fbeb4cc57006f0a110f0b3aa8f but there
> was a typo in the variable name that raises an exception
> in bitbake.
> 
> [YOCTO #9235]
> 
> Signed-off-by: Mariano Lopez <mariano.lopez@linux.intel.com>
> ---
>  bitbake/lib/bb/main.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/bitbake/lib/bb/main.py b/bitbake/lib/bb/main.py
> index b296ef8..283f29b 100755
> --- a/bitbake/lib/bb/main.py
> +++ b/bitbake/lib/bb/main.py
> @@ -281,10 +281,10 @@ class
> BitBakeConfigParameters(cookerdata.ConfigParameters):
>  
>          # use configuration files from environment variables
>          if "BBPRECONF" in os.environ:
> -            option.prefile.append(os.environ["BBPRECONF"])
> +            options.prefile.append(os.environ["BBPRECONF"])
>  
>          if "BBPOSTCONF" in os.environ:
> -            option.postfile.append(os.environ["BBPOSTCONF"])
> +            options.postfile.append(os.environ["BBPOSTCONF"])
>  
>          # fill in proper log name if not supplied
>          if options.writeeventlog is not None and
> len(options.writeeventlog) == 0:
> -- 
> 2.6.6
> 

