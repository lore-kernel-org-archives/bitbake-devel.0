Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 7CB1B759F4;
	Fri, 19 Jun 2015 02:25:12 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.15.1/8.15.1) with ESMTPS id t5J2PCDL026177
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Thu, 18 Jun 2015 19:25:12 -0700 (PDT)
Received: from [128.224.162.200] (128.224.162.200) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.3.224.2;
	Thu, 18 Jun 2015 19:25:12 -0700
Message-ID: <55837D86.3060005@windriver.com>
Date: Fri, 19 Jun 2015 10:25:10 +0800
From: Robert Yang <liezhi.yang@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux i686;
	rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To: Richard Purdie <richard.purdie@linuxfoundation.org>, bitbake-devel
	<bitbake-devel@lists.openembedded.org>
References: <1434637048.14710.99.camel@linuxfoundation.org>
In-Reply-To: <1434637048.14710.99.camel@linuxfoundation.org>
Cc: openembedded-core <openembedded-core@lists.openembedded.org>
Subject: Re: [RFC PATCH] data_smart: Drop expand parameter default
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
X-List-Received-Date: Fri, 19 Jun 2015 02:25:16 -0000
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit



On 06/18/2015 10:17 PM, Richard Purdie wrote:
> Rather than just d.getVar(X), force the use of the more explict d.getVar(X, False)
> since at some point in the future, having the default of expansion would
> be nice. This is the first step towards that.

Did you mean that in the future:

d.getVar("PN") equals d.getVar("PN", True) ?

That would be great since expand=True uses more frequently
than False.

// Robert

>
> Layers can update to this calling convention with a command along the lines of:
>
> sed -e 's:\(getVar([^,()]*\)\s*):\1, False):g' -i `grep -ril getVar *`
>
> Patches for OE-Core and Bitbake are on the mailing lists. Its an open question
> whether we want to do this, on what timescale and whether we do the same
> with getVarFLag at the same time?
>
> Paul confirmed that other layers don't have too many of these unexpanded
> getVar calls.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>
> diff --git a/bitbake/lib/bb/data_smart.py b/bitbake/lib/bb/data_smart.py
> index 9384ffd..1316671 100644
> --- a/bitbake/lib/bb/data_smart.py
> +++ b/bitbake/lib/bb/data_smart.py
> @@ -516,7 +516,7 @@ class DataSmart(MutableMapping):
>                   if len(shortvar) == 0:
>                       override = None
>
> -    def getVar(self, var, expand=False, noweakdefault=False, parsing=False):
> +    def getVar(self, var, expand, noweakdefault=False, parsing=False):
>           return self.getVarFlag(var, "_content", expand, noweakdefault, parsing)
>
>       def _clearOverrides(self, key):
>
>

