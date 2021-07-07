Received: from kernel.crashing.org (kernel.crashing.org [76.164.61.194])
 by mx.groups.io with SMTP id smtpd.web09.22881.1625672657996390347
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 07 Jul 2021 08:44:18 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=permerror, err=syntax error for token:  (domain: kernel.crashing.org, ip: 76.164.61.194, mailfrom: mark.hatle@kernel.crashing.org)
Received: from Marks-MacBook-Pro-16.local ([76.164.61.198])
	(authenticated bits=0)
	by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 167FiEY5019194
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
	Wed, 7 Jul 2021 10:44:15 -0500
Subject: Re: [bitbake-devel] [PATCH] bb/utils: add layer_path() function
To: Ross Burton <ross@burtonini.com>, bitbake-devel@lists.openembedded.org
References: <20210707122021.2924476-1-ross.burton@arm.com>
From: "Mark Hatle" <mark.hatle@kernel.crashing.org>
Message-ID: <823c8e6f-d161-c7d9-21d1-054fc9bcca48@kernel.crashing.org>
Date: Wed, 7 Jul 2021 10:44:12 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210707122021.2924476-1-ross.burton@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit



On 7/7/21 7:20 AM, Ross Burton wrote:
> Add layer_path() which will return the path to a layer. Useful to
> programatically find other layers at build time, or from tinfoil.
> 
> Signed-off-by: Ross Burton <ross.burton@arm.com>
> ---
>  bitbake/lib/bb/utils.py | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
> index 6ba1d2a3766..951fa3cb0e4 100644
> --- a/bitbake/lib/bb/utils.py
> +++ b/bitbake/lib/bb/utils.py
> @@ -1537,6 +1537,16 @@ def get_file_layer(filename, d, collection_res={}):
>  
>      return result
>  
> +def layer_path(layername, d):
> +    """
> +    Return the path to the specified layer, or None if the layer isn't present.
> +    """
> +    bbpath = d.getVar("BBPATH").split(":")
> +    pattern = d.getVar('BBFILE_PATTERN_' + layername)
> +    for path in reversed(sorted(bbpath)):
> +        if re.match(pattern, path + "/"):
> +            return path
> +    return None
>  
>  # Constant taken from http://linux.die.net/include/linux/prctl.h
>  PR_SET_PDEATHSIG = 1
> 

Would it be easier to capture the layer path while processing the layers, since
at that point there is a LAYERDIR available?

Something like BB_LAYERDIR_<collection>, then we can use that directly in any
users.  This could replace the few layers people have that manually set their
own layer paths?

I'm not sure where the processing for the layer.conf happens, but that would
seem like the place to put it and that would also avoid having to guess based on
the BBFILE_PATTERN and BBPATH.

I've definitely seen layers where BBPATH does NOT include a specific layer's
path.  They are extremely rare, but I've seen it before.

--Mark

> 
> 
> 
