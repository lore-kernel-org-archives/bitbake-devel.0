Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C76DC88E6A
	for <webhook@archiver.kernel.org>; Mon, 14 Sep 2026 09:24:11 +0000 (UTC)
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16271.1789377847873001228
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 14 Sep 2026 02:24:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=auXuukRn;
 spf=pass (domain: linuxfoundation.org, ip: 74.125.228.140, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f9c60d5so113724266b.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 14 Sep 2026 02:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1789377846; x=1789982646; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oIZoITIUKzF7TYgifpb4ph8K9T85QienzY1JqzGRqWU=;
        b=auXuukRngrUO9JxQQSjT1eYDrQZ7eyhkLfyo5YJpGuhkbGMS0atOgXTOIzrRCvJCwg
         Z+xy1v1moQOSKtaNUlw3rtB5Q5uwMyf3+O6H9OdKoNv/zF7pX58Lbe3IrD+ihkQG3vTW
         RnzjK1t/FuL+RxPp85KdjizPH3khyWjM3iRos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789377846; x=1789982646;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oIZoITIUKzF7TYgifpb4ph8K9T85QienzY1JqzGRqWU=;
        b=qCxXg/YuiOBLXCk4MEgOj504K52tw9OO78/H2yttkDkOVlfuSXK8ORlXmW6rWfqEZN
         0bZEnEv4Kw0XMwWouBD2QAqKw4BTjg7/iaoVwrJXmXGXfWw4HipM9xdDqQkWvhzL8jMZ
         LS7osTwvx5WLRIVuCyYuOljw8iJ+dHm/Fo0AbjnnMMQI9dGRuoeAH/00nXxqfwgn1ROG
         qjoz4Op9d73/XDEu9GxxxnK7LiEEQ+J1k6z2w9adDO6QBrGNUPZauH88qhoqRWsC97JT
         6W8m9IJcmSZsofr6xCM8wK2iPxG66vHGL8n2MblTQknUm8TXoVRwRIDhmxqiucatcNxh
         nO/g==
X-Forwarded-Encrypted: i=1; AKwUvBx48RKwFqTkR8ttU9CoBSdJEngUBsEXx1sDRndisSELqrcatdmZ9alCDOEw22wTrCtp90TkEBlv5QXbAArA@lists.openembedded.org
X-Gm-Message-State: AFuF++mLeKQuErCRsOburzg1t342rxSuOy3GZJ4mKWnqFmQ/OvNGtab5
	kZLCaT6KaAxL7CkfYuAGVFuTl3TFQn+8Fr2K6B+JrUaXfODlpu1fw9U4olzlqA6jXlY=
X-Gm-Gg: AYBFou1F8U3envoqfzeRRIZoU9GUOfyJcGz5BV/u2RgI2QPFvZf83VsSWZvR/vVWZQd
	nBqWP/0I6zanYVheA+lDphcA1d7+IRZf7/eCF3vIuf4GBo943qx94+DqX8jnZFrRizWo2ir6fjd
	0m6Ka/TRkzMfaWN8B2BkQkhV8q49gzliN5vkRg8dKZ3bsYRqhJUl6bdO0GwmxF90NH4jJ19zOmN
	wALCKcgh4nIL4Q6kxfdTVbuTE1gHTSc+YVpu1uzOYcqjg99exmnk0IjcL0VI6uCUSW/ZqqgvAXB
	nSm71vLhLzlmUefzcAI5wZIIRxKWiB6v7SGc38PKlOZJfmHiGgdU4td8xADlg2QhiVe5hxR69KO
	Km4aW7TOrnCWGAEh7Gh3ZyFPGzxf3EciR1bni7NqzncTzS3lm7Xr2vHesYNb6NQXz+EuS485ygO
	hxyRce3Kzk5VvzDhzsRHcDNDP7XcQ96wLnArNsrwiIuBl0lrQsolrZ9VNEL7YtQVU7ZZ75w/G0y
	bGb2plinZLL1FWmsrZUXWBjSeCC/SkgSGmT8n7ZZ7iLHYb6HZ4nDumR+n4v0ZflG++mZyonIy4=
X-Received: by 2002:a17:906:f5a9:b0:c25:f7db:4bea with SMTP id a640c23a62f3a-c29b93b8cf4mr101421966b.16.1789377845799;
        Mon, 14 Sep 2026 02:24:05 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:e738:2a19:1746:7e8c? ([2001:8b0:aba:5f3c:e738:2a19:1746:7e8c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2966067117sm396235766b.33.2026.09.14.02.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 02:24:05 -0700 (PDT)
Message-ID: <1166440fd2b4a63232ad5959369f7602a43de82f.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] fetch: Add log_errors parameter to
 Fetch.download()
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: zhangqiang.zq307@gmail.com, bitbake-devel@lists.openembedded.org
Date: Mon, 14 Sep 2026 10:24:04 +0100
In-Reply-To: <20260914051148.1445323-1-zhangqiang.zq307@gmail.com>
References: <20260914051148.1445323-1-zhangqiang.zq307@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 14 Sep 2026 09:24:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20192

On Mon, 2026-09-14 at 13:11 +0800, zhangqiang.zq307 via lists.openembedded.=
org wrote:
> From: =E5=BC=A0=E5=BC=BA <zhangqiang.zq307@gmail.com>
>=20
> Fetching an sstate object from a mirror can fail transiently and is
> recoverable when the caller falls back to running the real task.
> The unconditional logger.error() in download() makes bitbake exit
> non-zero even though every task ends up succeeding, as bitbake counts
> any ERROR message towards its exit code.
>=20
> Add a log_errors parameter so such callers can request the first
> fetch failure to be logged at WARNING instead of ERROR. The default
> (True) keeps the current behaviour for all existing callers.
>=20
> Signed-off-by: =E5=BC=A0=E5=BC=BA <zhangqiang.zq307@gmail.com>
> ---
> =C2=A0lib/bb/fetch/__init__.py | 10 ++++++++--
> =C2=A01 file changed, 8 insertions(+), 2 deletions(-)

There have been a few attempts at changes like this over the years and
we've not taken them. If the mirror says something is available, then
for some reason it isn't that is an error and should be reported as
such, it really needs fixing.

Cheers,

Richard

