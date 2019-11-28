Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
	[209.85.128.68])
	by mail.openembedded.org (Postfix) with ESMTP id B3CD17CBDD
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 28 Nov 2019 17:51:52 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id j18so7951759wmk.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 28 Nov 2019 09:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=1Jw2Czs13NS2Kl1c61Qs23UkjLskIR5jSvhf/sSWRVg=;
	b=Oa2ybNnKBfQ8NtqHj09ZVlgZMbRvCpIp43Q1RUw7KalJZtxACVIjXWdcDuMqT+IYhJ
	OY8xxwG+7d+0eWJzumEtTCtiLw30+ZLDMlROwqSyduqRAwrgQ7Fq9a233UEQu3fjXHib
	SSzfQpEf7JX231/36+8jrMfjP8jpSpzdovR6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=1Jw2Czs13NS2Kl1c61Qs23UkjLskIR5jSvhf/sSWRVg=;
	b=fkc2YU4xFEznHRm0w18EEnVLDvCOgt4P7bCNquBvC6JA7FImluOmXajCB+2Jei9aTo
	CrPJkGAjhiPYUIWRUsYZJtqskpogTyiDAKMISNWw2ueQAnNTd1kewDmhzNa3MlPE0QSL
	dqW1k8+h4Z5YqFsEWTIdK4gvHGRQJn2Z6WlOTeTrTkfRYdAPgpU5S+KtF7skR4aRBK+/
	Yb3aWFjxahxEIwr61rF8+T9HC9ix3Eu3stez+p8DuA6wDI3ZrJeo42oMD3zf1Yiea/GV
	VcYjkMf3tCOIk3keFICBmUoyqvKoFgPOzNwjNi8FnFBZBNo0okhcX8NBTw6pit+mvNfu
	jr9w==
X-Gm-Message-State: APjAAAWWic0RWbDkSn54tCtNGKIyy3cAU1kdHGuM2WIrbAB/GMdeJ03O
	50HyrpQ3oeycWhhEPfSFMF10tn93gzM=
X-Google-Smtp-Source: APXvYqyIxieGwYbzmzr7J+gSKT3+Zd+4Vt+qJOdy6u6p3sj/R+oIUqeHSvEG+zvAsQ1WsgW2Y6RRHA==
X-Received: by 2002:a1c:6086:: with SMTP id
	u128mr10071851wmb.131.1574963513375; 
	Thu, 28 Nov 2019 09:51:53 -0800 (PST)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	a15sm25984164wrx.81.2019.11.28.09.51.52
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Thu, 28 Nov 2019 09:51:52 -0800 (PST)
Message-ID: <140ccb87e6820c4daea903644f43b178a8541a26.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: kai.kang@windriver.com, bitbake-devel@lists.openembedded.org
Date: Thu, 28 Nov 2019 17:51:51 +0000
In-Reply-To: <20191128092718.13336-1-kai.kang@windriver.com>
References: <20191128092718.13336-1-kai.kang@windriver.com>
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Subject: Re: [PATCH] runqueue: add mc to pending hash index
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
X-List-Received-Date: Thu, 28 Nov 2019 17:51:53 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2019-11-28 at 17:27 +0800, kai.kang@windriver.com wrote:
> From: Kai Kang <kai.kang@windriver.com>
> 
> When build multiconfig target by following steps in section "Enabling
> Multiple Configuration Build Dependencies" in yocto dev-manual which
> adds dependency between multiconfig targets:
> 
> do_image[mcdepends] = "mc:x86:arm:core-image-minimal:do_rootfs"
> 
> it shows a lot of warnings, such as:
> 
> > WARNING: Deferring
> >   mc:x86:virtual:native:/path/to/meta/recipes-
> > support/nss/nss_3.45.bb:do_populate_sysroot
> >   after
> >   mc:arm:virtual:native:/path/to/meta/recipes-
> > support/nss/nss_3.45.bb:do_populate_sysroot
> 
> In function pending_hash_index it only checks PN, taskname and hash.
> But
> they are same for multiconfig native and allarch packages. Add
> multiconfig
> to pending hash index too to make the index unique.
> 
> Ref:
> https://www.yoctoproject.org/docs/latest/dev-manual/dev-manual.html#dev-enabling-multiple-configuration-build-dependencies
> 
> Signed-off-by: Kai Kang <kai.kang@windriver.com>

This patch completes defeats the point of this code, disabling it. Its
the wrong thing to do, we want this code to be active.

The bug is that this should not be a warning, probably just a note.

We need it to be a note so that we can tell the mechanism is in action
from build output logs.

Cheers,

Richard

> ---
>  bitbake/lib/bb/runqueue.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
> index 485d9341f5..059eb9e283 100644
> --- a/bitbake/lib/bb/runqueue.py
> +++ b/bitbake/lib/bb/runqueue.py
> @@ -69,12 +69,12 @@ def build_tid(mc, fn, taskname):
>      return fn + ":" + taskname
>  
>  # Index used to pair up potentially matching multiconfig tasks
> -# We match on PN, taskname and hash being equal
> +# We match on mc, PN, taskname and hash being equal
>  def pending_hash_index(tid, rqdata):
>      (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
>      pn = rqdata.dataCaches[mc].pkg_fn[taskfn]
>      h = rqdata.runtaskentries[tid].unihash
> -    return pn + ":" + "taskname" + h
> +    return mc + ":" + pn + ":" + "taskname" + h
>  
>  class RunQueueStats:
>      """
> -- 
> 2.17.1
> 


