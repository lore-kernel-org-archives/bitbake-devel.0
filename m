Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 2C32E7017D
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  1 Jun 2017 02:52:13 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id v512qE0D023422
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=OK);
	Wed, 31 May 2017 19:52:14 -0700
Received: from [128.224.162.160] (128.224.162.160) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.3.294.0;
	Wed, 31 May 2017 19:52:13 -0700
To: <bitbake-devel@lists.openembedded.org>
References: <20170527102148.15448-1-liezhi.yang@windriver.com>
From: Robert Yang <liezhi.yang@windriver.com>
Message-ID: <6220507b-08b6-5631-e7c2-140448b928b9@windriver.com>
Date: Thu, 1 Jun 2017 10:52:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
	Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20170527102148.15448-1-liezhi.yang@windriver.com>
Cc: paul.eggleton@linux.intel.com
Subject: Re: [PATCH] bb/tinfoil.py: import bb.msg
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
X-List-Received-Date: Thu, 01 Jun 2017 02:52:14 -0000
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit



On 05/27/2017 06:21 PM, Robert Yang wrote:
> It uses bb.msg without import it, so there might be errors like:
> AttributeError: 'module' object has no attribute 'logger_create'
>
> We can't reproduce the problem everytime, I think that it depends on the order.

Sorry, please drop this patch, I just figured out the reason.

The logger_create() was added to bb.msg two months ago, so if I import an
older bb.msg, and then switch bitbake to a new branch and use tinfoil.py,
the error will happen (my code error in layerindex caused this).

// Robert

>
> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
> ---
>  lib/bb/tinfoil.py | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
> index 928333a..a0d8a16 100644
> --- a/lib/bb/tinfoil.py
> +++ b/lib/bb/tinfoil.py
> @@ -33,6 +33,7 @@ import bb.remotedata
>  from bb.cookerdata import CookerConfiguration, ConfigParameters
>  from bb.main import setup_bitbake, BitBakeConfigParameters, BBMainException
>  import bb.fetch2
> +import bb.msg
>
>
>  # We need this in order to shut down the connection to the bitbake server,
>

