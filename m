Return-Path: <akuster808@gmail.com>
Received: from mail-pg0-f65.google.com (mail-pg0-f65.google.com [74.125.83.65])
	by mail.openembedded.org (Postfix) with ESMTP id 0CBDC6AC37
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  3 Apr 2017 14:08:40 +0000 (UTC)
Received: by mail-pg0-f65.google.com with SMTP id 79so30226964pgf.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 03 Apr 2017 07:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:references:from:message-id:date:user-agent:mime-version
	:in-reply-to:content-transfer-encoding;
	bh=1kXD+l02OWfdokGLWxlMQiB3B9G3WVLS92xeqzs0n7c=;
	b=MvmCpTnP7jd05th7NMjBS38viqcnF9HE7u2Q4s7J2ZDkT/OFs4idsAPr/Qg3KXEeKV
	IMXN5LTlLo2wkmY2D6Kz4R7xSBrAQKj+zb4WG4Jc8UcKw+RDndY97l0DDiWa7e2l8Wqx
	wtFyAKVkGiSH/BbVlp5EjUo3U/BQPO5h2lignUAvKTFCHLS4KQYeRkrngnOrW9nAYD6+
	yKTw7QxfdxsEcS8kHEmdiamOHYOatJayT1GMEymq9DQsRMI/IzOHx/KQkWwME7yKtJql
	W79Uy6sPO13a9F5zUHJmQ9jykA35m8x+h2ZcIh8uJq/BBaC7uaXcxkEr6PXOgCZolz9b
	kZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding;
	bh=1kXD+l02OWfdokGLWxlMQiB3B9G3WVLS92xeqzs0n7c=;
	b=RE9xgQzbkW8d8U5Jptx1Co/0f5w0U+DzjtYSzrGySePCYBlKVSvgW6XOOl2DFPbS3i
	2cdMFy1CnXccbJyKU4FMnptYDGTrPQ7tsL/mpKx8/lZrXrtNUnA0F/JlgszLXmVeXYdZ
	WwfSo5k0BZwlCvqWwVktTaMYaUvYtndSumoNRk2pvVRTuhP3M9ke+uVNG5LZ7dNuwjN6
	gstvLyA6ihp6SczDR6SAOTRONpRKS18zt8cbJGrxw9/D7CUd/9Kh3pK1STOCWk3Hyn/1
	4+Vggalej4GEIIQU2hxbKUEejZyrFPZPOMm2898DJO/Lp7Dzd7c435+DXaRpsIwoRFqd
	4IjQ==
X-Gm-Message-State: AFeK/H0TAEjp7bkmBaK7P8LrkCPbHMqiBrE9B8UQbvwFuxgimYuO/ZGV632eYMq4e0kC1A==
X-Received: by 10.84.132.97 with SMTP id 88mr22541105ple.61.1491228521976;
	Mon, 03 Apr 2017 07:08:41 -0700 (PDT)
Received: from ?IPv6:2601:202:4001:9ea0:e3df:bf0a:9f90:498e?
	([2601:202:4001:9ea0:e3df:bf0a:9f90:498e])
	by smtp.gmail.com with ESMTPSA id
	a77sm26383889pfj.1.2017.04.03.07.08.41
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Apr 2017 07:08:41 -0700 (PDT)
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
	bitbake-devel@lists.openembedded.org
References: <20170403125935.27692-1-pkj@axis.com>
From: akuster808 <akuster808@gmail.com>
Message-ID: <8bc0a119-a330-203d-c571-e1a06ceb45ab@gmail.com>
Date: Mon, 3 Apr 2017 07:08:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
	Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170403125935.27692-1-pkj@axis.com>
Subject: Re: [morty][PATCH] fetch2: Do not fail to create symbolic links if they already exist
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
X-List-Received-Date: Mon, 03 Apr 2017 14:08:41 -0000
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit



On 04/03/2017 05:59 AM, Peter Kjellerstedt wrote:
> From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
>
> When the fetcher retrieves file:// URLs, there is no lock file being
> used. This means that in case two separate tasks (typically from two
> concurrent invocations of bitbake) want to download the same file://
> URL at the same time, there is a very small chance that they also end
> up wanting to create a symbolic link to the file at the same time.
> This would previously lead to one of the tasks failing as the other
> task would have created the link.
>
> Signed-off-by: Peter Kjellerstedt <pkj@axis.com>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

thanks, I am the process of stagging changes.
-armin
> ---
>
> This is a backport of 58a03531c8183b165bb7dcad86d8559c92bc150d on
> master.
>
>   bitbake/lib/bb/fetch2/__init__.py | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
> index cd7362c44a..f36f01a707 100644
> --- a/bitbake/lib/bb/fetch2/__init__.py
> +++ b/bitbake/lib/bb/fetch2/__init__.py
> @@ -967,7 +967,14 @@ def try_mirror_url(fetch, origud, ud, ld, check = False):
>                   open(ud.donestamp, 'w').close()
>               dest = os.path.join(dldir, os.path.basename(ud.localpath))
>               if not os.path.exists(dest):
> -                os.symlink(ud.localpath, dest)
> +                # In case this is executing without any file locks held (as is
> +                # the case for file:// URLs), two tasks may end up here at the
> +                # same time, in which case we do not want the second task to
> +                # fail when the link has already been created by the first task.
> +                try:
> +                    os.symlink(ud.localpath, dest)
> +                except FileExistsError:
> +                    pass
>               if not verify_donestamp(origud, ld) or origud.method.need_update(origud, ld):
>                   origud.method.download(origud, ld)
>                   if hasattr(origud.method,"build_mirror_data"):
> @@ -979,7 +986,11 @@ def try_mirror_url(fetch, origud, ud, ld, check = False):
>                   # Broken symbolic link
>                   os.unlink(origud.localpath)
>   
> -            os.symlink(ud.localpath, origud.localpath)
> +            # As per above, in case two tasks end up here simultaneously.
> +            try:
> +                os.symlink(ud.localpath, origud.localpath)
> +            except FileExistsError:
> +                pass
>           update_stamp(origud, ld)
>           return ud.localpath
>   


