Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SHkC4-0000An-4X for bitbake-devel@lists.openembedded.org;
	Wed, 11 Apr 2012 01:09:49 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q3AN0RiH001535;
	Wed, 11 Apr 2012 00:00:27 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 01483-01; Wed, 11 Apr 2012 00:00:23 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q3AN0IOR001529
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 11 Apr 2012 00:00:19 +0100
Message-ID: <1334098817.10826.89.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Dongxiao Xu <dongxiao.xu@intel.com>
Date: Wed, 11 Apr 2012 00:00:17 +0100
In-Reply-To: <ccb22c39f4aeb8e310f9a6f8e0f9c55c18ac6891.1333960654.git.dongxiao.xu@intel.com>
References: <cover.1333960654.git.dongxiao.xu@intel.com>
	<ccb22c39f4aeb8e310f9a6f8e0f9c55c18ac6891.1333960654.git.dongxiao.xu@intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 2/6] data_smart: Improve the calculation of config hash
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
X-List-Received-Date: Tue, 10 Apr 2012 23:09:50 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2012-04-09 at 16:41 +0800, Dongxiao Xu wrote:
> The order of keys are not sensitive for config hash, so we need to
> identify its order while calculating the md5 value.
> 
> While for certain values, order is also not sensitive (for example,
> BBINCLUDED), we also need to identify its order while calculating md5
> value.
> 
> This could fix the problem that Martin Jansa reported in the mailing
> list:
> 
> http://lists.linuxtogo.org/pipermail/bitbake-devel/2012-March/002122.html
> 
> Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
> ---
>  lib/bb/data_smart.py |   10 +++++++---
>  1 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
> index 2c200db..cc61a03 100644
> --- a/lib/bb/data_smart.py
> +++ b/lib/bb/data_smart.py
> @@ -462,13 +462,17 @@ class DataSmart(MutableMapping):
>          self.delVar(var)
>  
>      def get_hash(self):
> -        data = ""
> +        data = {}
>          config_whitelist = set((self.getVar("BB_HASHCONFIG_WHITELIST", True) or "").split())
> +        config_sort = set((self.getVar("BB_HASHCONFIG_SORT", True) or "").split())
>          keys = set(key for key in iter(self) if not key.startswith("__"))
>          for key in keys:
>              if key in config_whitelist:
>                  continue
>              value = self.getVar(key, False) or ""
> -            data = data + key + ': ' + str(value) + '\n'
> +            if key in config_sort:
> +                value = " ".join(sorted(value.split()))
> +            data.update({key:value})
>  
> -        return hashlib.md5(data).hexdigest()
> +        data_str = str([(k, data[k]) for k in sorted(data.keys())])
> +        return hashlib.md5(data_str).hexdigest()


This and the corresponding change in bitbake.conf look rather worrying
to me. The order in BBINCLUDED is significant and if it changes we
should be reparsing.

Looking at the code, get_file_depends(d) is probably buggy due to the
use of set() which could reorder the data. We need to keep the data in
order there and this issue should then be resolved.

Lets fix the real bug.

Cheers,

Richard





