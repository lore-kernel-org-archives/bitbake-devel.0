Return-Path: <alex.r.damian@gmail.com>
Received: from mail-ea0-f195.google.com (mail-ea0-f195.google.com
	[209.85.215.195])
	by mail.openembedded.org (Postfix) with ESMTP id 1DBB56A5B1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Jun 2013 11:14:15 +0000 (UTC)
Received: by mail-ea0-f195.google.com with SMTP id m14so2467919eaj.10
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Jun 2013 04:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=message-id:date:from:user-agent:mime-version:to:subject:references
	:in-reply-to:content-type:content-transfer-encoding;
	bh=edLEOrlrHacIY+3GTUZFyoXgmOIGV82tiTVTuDunUYI=;
	b=BWjT0WBtWVmGZhNjIKYgH7Hr09gSRHeDjoNIKQrWFZcruKE8K7tY5IEdErCtTXaerz
	8qXhr5gsNviV4vKKEyhULryyqhIMxAMrjnNcyAN7yXke/EL7bXijsVHtYeQqzwcyAqsV
	HLv9oLTp2rgUJ7VP2AvjSG+JxYEVQLFDBb3Fu+Rky67wXJka4RrGAOlwyF2bmTyTxOFV
	MHulxKGpaYsqXzrAeSSfUr9AkISnVX5o36afd/4/3o1LcuhSUSvjrGKXBYVa8jbFZENh
	N+qZC6ca7qs9uwHgnVAHMSNABC1DFh+WPleN40MA4mBgTaojzt/i+vofercNxBOeTAdY
	Otkw==
X-Received: by 10.14.3.73 with SMTP id 49mr10653829eeg.72.1370862856266;
	Mon, 10 Jun 2013 04:14:16 -0700 (PDT)
Received: from [192.198.151.37] (irdmzpr02-ext.ir.intel.com. [192.198.151.37])
	by mx.google.com with ESMTPSA id
	z52sm22442516eea.1.2013.06.10.04.14.14
	for <bitbake-devel@lists.openembedded.org>
	(version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Mon, 10 Jun 2013 04:14:15 -0700 (PDT)
Message-ID: <51B5B509.5090706@gmail.com>
Date: Mon, 10 Jun 2013 12:14:17 +0100
From: Alex Damian <alex.r.damian@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:17.0) Gecko/20130510 Thunderbird/17.0.6
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <1370625286.6864.57.camel@ted>
In-Reply-To: <1370625286.6864.57.camel@ted>
Subject: Re: [PATCH] bitbake: Bump minimum python version to 2.7.3
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 10 Jun 2013 11:14:16 -0000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 06/07/2013 06:14 PM, Richard Purdie wrote:
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
> diff --git a/bitbake/lib/bb/__init__.py b/bitbake/lib/bb/__init__.py
> index 3110c85..64491ff 100644
> --- a/bitbake/lib/bb/__init__.py
> +++ b/bitbake/lib/bb/__init__.py
> @@ -24,8 +24,8 @@
>   __version__ = "1.19.1"
>   
>   import sys
> -if sys.version_info < (2, 6, 0):
> -    raise RuntimeError("Sorry, python 2.6.0 or later is required for this version of bitbake")
> +if sys.version_info < (2, 7, 3):
> +    raise RuntimeError("Sorry, python 2.7.3 or later is required for this version of bitbake")

When this gets in, a bunch of messy code from xmlrpc will have to 
finally get its final rest.

Alex
>   
>   
>   class BBHandledException(Exception):
>
>
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel


