Return-Path: <armccurdy@gmail.com>
Received: from mail-wr0-f195.google.com (mail-wr0-f195.google.com
	[209.85.128.195])
	by mail.openembedded.org (Postfix) with ESMTP id 17AAD760AC
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Mar 2017 23:00:24 +0000 (UTC)
Received: by mail-wr0-f195.google.com with SMTP id y90so719689wrb.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Mar 2017 16:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=MocdYLi1Ep5gw9MPn7rE7RNXHXc+1Gt5o+QVT3+/E6M=;
	b=X0FN9KhLaChS1CmPtHi7fDb5w+cqO6w1GT2mMK6Nw60tv8hemW4IO5hIrWTlmMr98V
	N6E+2sNBovVxVP1jaGllR002O2hyKDcLjsycFLbsaaejSYHYHjboDcAayORI1qEKHEbx
	Hvqq/GurdeU8BojlNmcHSqU8LrRSULOB/shjuiXP3tjI8qpCBDaRVCs/GQgNLgD0y6Zo
	wfC0kaIxXr19MTXXpaRrU2VyMyExBbdh+mLSj4aSKhlkyhCaPCM9yH41eMG3hw+az4zi
	htLKMQrsOPppfFiA233wTTwWmHnHlwjci81tenYAgM9COKecktqqrhA+NiJJRcOK43YR
	hqog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=MocdYLi1Ep5gw9MPn7rE7RNXHXc+1Gt5o+QVT3+/E6M=;
	b=t/QoIwEfuj8shoFC2MdBaLDk4hueXMIyp9Qn08Lwbj5nwkTFYeq2Yaa5fUXelSF1yC
	VO5yHoyyR+LQC0qqQb2B4KBNvSdLKl/MSvg89MZRC1fpvHJojSRtdLADDILCu8fmRVFp
	RJVBSiGkBIbsekkWXaIeQ8Vd/KdXUASxL6A4kVhmw9cStNnMZWoLF55+Dyy6EZJX89ZU
	I5lAVnQJcUKFBkz/8fl3rBjI2WZYIpIu6iDnz55UAqikGDSXvSedl80dn3dGMX7QUgeE
	DU0iwOTG1Z8gexQ948iHn1Fp4yiBmhJrcuC+S86zmrLMX8RR97uXQDwZtkl7GfEklxYk
	CYYQ==
X-Gm-Message-State: AFeK/H0LEb3iJa6iJQlM0vWzQQHLLbV6DAYZLUF/KegxJjWyzRovHWbhCz1VuicBUptMZyr8OjvYRwQhTNbZ/A==
X-Received: by 10.223.152.239 with SMTP id w102mr34703189wrb.72.1490137225488; 
	Tue, 21 Mar 2017 16:00:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.179.24 with HTTP; Tue, 21 Mar 2017 16:00:24 -0700 (PDT)
In-Reply-To: <1489779847-31506-1-git-send-email-juro.bystricky@intel.com>
References: <1489779847-31506-1-git-send-email-juro.bystricky@intel.com>
From: Andre McCurdy <armccurdy@gmail.com>
Date: Tue, 21 Mar 2017 16:00:24 -0700
Message-ID: <CAJ86T=XD3W42QGiSZibBQen--xo13TO3W65bzQCeu7=yBnb02A@mail.gmail.com>
To: Juro Bystricky <juro.bystricky@intel.com>
Cc: richard.purdie@intel.com,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] data.py: sort exported variables
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
X-List-Received-Date: Tue, 21 Mar 2017 23:00:25 -0000
Content-Type: text/plain; charset=UTF-8

On Fri, Mar 17, 2017 at 12:44 PM, Juro Bystricky
<juro.bystricky@intel.com> wrote:
> Various run.do_xxx files export dozens of variables.
> Presently they are in random order. Among other things,
> this makes it difficult to compare two files for relevant changes.
> This patch ensures they are enumerated/printed in a sorted
> (alphabetical) order.

+1

My version from last year (which also separated out variables being unset):

  http://lists.openembedded.org/pipermail/bitbake-devel/2016-January/006970.html

was never merged, so hopefully this one fares better.

> Signed-off-by: Juro Bystricky <juro.bystricky@intel.com>
> ---
>  bitbake/lib/bb/data.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/bitbake/lib/bb/data.py b/bitbake/lib/bb/data.py
> index 0f05b60..d145f1b 100644
> --- a/bitbake/lib/bb/data.py
> +++ b/bitbake/lib/bb/data.py
> @@ -220,7 +220,7 @@ def emit_func(func, o=sys.__stdout__, d = init()):
>      """Emits all items in the data store in a format such that it can be sourced by a shell."""
>
>      keys = (key for key in d.keys() if not key.startswith("__") and not d.getVarFlag(key, "func", False))
> -    for key in keys:
> +    for key in sorted(keys):
>          emit_var(key, o, d, False)
>
>      o.write('\n')
> --
> 2.7.4
>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel

