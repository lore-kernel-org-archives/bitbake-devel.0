Return-Path: <akuster808@gmail.com>
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com
	[209.85.214.193])
	by mail.openembedded.org (Postfix) with ESMTP id 9966C6C0B0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 13 Nov 2018 23:11:16 +0000 (UTC)
Received: by mail-pl1-f193.google.com with SMTP id x21-v6so4049754pln.9
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 13 Nov 2018 15:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:references:from:openpgp:autocrypt:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=1yDxQ1SQ9G5QjA570SXy+2cljv9135x9rLb6x4RfVsA=;
	b=TtPPXs2TtPkpDfWf+5YDmIQJsQTODHo6lUS6VinMkL7PmYgaE+LsKHIqadJ8OBiBkn
	Wo3w+MXf39nRvR44MrmuqxDvJu0AumRmj0pHSPPdUOj7Er16OiCVxi3425gJS5jf33HO
	3XSHzotObhUvkf4ezjiBEUCzIuWzgWSyeT+wlhWPSNHdPgmJuGiNlKdDXB7W2TvlQJjU
	lFYC6LbGSj2G4pmiI25XnmB4UxYIbuZMJDMJmIOwUS5VpCPgveslhUCvpBVptAEtd6jU
	YmVcz+muUzWmt8X+96FooleSOeTmFUM4FoWPxS68XCIhZCsjQbPStPhJ5wvi5vD4JXFT
	udkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
	:message-id:date:user-agent:mime-version:in-reply-to
	:content-transfer-encoding:content-language;
	bh=1yDxQ1SQ9G5QjA570SXy+2cljv9135x9rLb6x4RfVsA=;
	b=t1wjjWVklHewPuMKCwQ06Zdi4o/hNFzlkNbWryUY8EKD/6slCQxTUV6AMgMLVsbCi3
	DfPjOzXfjEtZCU7oSV6cp8N5Xshvy0iIAMQmdxwn/c9qDd30i97v0+ArTYk35ze4xVdx
	7v0g5J1WigiFGrC+XhLVX037zzd3CCGtiVf1MxEYSU0gDnFZtdikGHWD24wvyNU+Q/KB
	n0C4lDBzcSG5OINCS+wDNwrkFMf3Y8AWoc6/+GL2shsF7j4i84p+80G69XlLDxiJFKvw
	a29gUVHHmRTn1Yq5ew67RUrdsx3UUNy1y37Z9rcErPsOQJuAXqPfiCIZFz7La0qg9kZk
	BINw==
X-Gm-Message-State: AGRZ1gJSUiPFtm5eaJ45DFJT9kH257GQ7Erk9vUkb4FXN2ymC5DqC+JB
	PmuJUVX4GOL7XVTWyLuRIAy4Gsbg
X-Google-Smtp-Source: AJdET5dHvM5MXqehiPaWV3lBcuakUSKw+k5IShgpkBDhsREW+sLVuGrZeAdb3vrZlC0gixR2FfvEkQ==
X-Received: by 2002:a17:902:343:: with SMTP id
	61-v6mr6755852pld.327.1542150677356; 
	Tue, 13 Nov 2018 15:11:17 -0800 (PST)
Received: from ?IPv6:2601:202:4180:c33:75ee:9e74:d500:909d?
	([2601:202:4180:c33:75ee:9e74:d500:909d])
	by smtp.gmail.com with ESMTPSA id
	d65-v6sm31495876pfc.144.2018.11.13.15.11.16
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 13 Nov 2018 15:11:16 -0800 (PST)
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	bitbake-devel@lists.openembedded.org
References: <20181113225942.17780-1-richard.purdie@linuxfoundation.org>
From: akuster808 <akuster808@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=akuster808@gmail.com; prefer-encrypt=mutual; keydata=
	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
	8CS2NxU=
Message-ID: <2a132f70-529e-cb9b-d028-de4707fe2c95@gmail.com>
Date: Tue, 13 Nov 2018 15:11:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181113225942.17780-1-richard.purdie@linuxfoundation.org>
Subject: Re: [PATCH 1/2] utils: Avoid warnings about deprecated imp module
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
X-List-Received-Date: Tue, 13 Nov 2018 23:11:16 -0000
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US


On 11/13/18 2:59 PM, Richard Purdie wrote:
> The imp module is deprecated, port the code over to use importlib.
>
> bitbake/lib/bb/utils.py:30: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
>   import imp

so host side? Thud and Sumo backport?

- armin

>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/utils.py | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/lib/bb/utils.py b/lib/bb/utils.py
> index 73b6cb423b..1cadbc5bcd 100644
> --- a/lib/bb/utils.py
> +++ b/lib/bb/utils.py
> @@ -27,7 +27,7 @@ import bb
>  import bb.msg
>  import multiprocessing
>  import fcntl
> -import imp
> +import importlib
>  import itertools
>  import subprocess
>  import glob
> @@ -43,7 +43,7 @@ from contextlib import contextmanager
>  from ctypes import cdll
>  
>  logger = logging.getLogger("BitBake.Util")
> -python_extensions = [e for e, _, _ in imp.get_suffixes()]
> +python_extensions = importlib.machinery.all_suffixes()
>  
>  
>  def clean_context():
> @@ -1544,12 +1544,9 @@ def export_proxies(d):
>  def load_plugins(logger, plugins, pluginpath):
>      def load_plugin(name):
>          logger.debug(1, 'Loading plugin %s' % name)
> -        fp, pathname, description = imp.find_module(name, [pluginpath])
> -        try:
> -            return imp.load_module(name, fp, pathname, description)
> -        finally:
> -            if fp:
> -                fp.close()
> +        spec = importlib.machinery.PathFinder.find_spec(name, path=[pluginpath] )
> +        if spec:
> +            return spec.loader.load_module()
>  
>      logger.debug(1, 'Loading plugins from %s...' % pluginpath)
>  

