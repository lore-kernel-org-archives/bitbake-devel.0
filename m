Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E91C30653
	for <webhook@archiver.kernel.org>; Thu,  4 Jul 2024 15:27:07 +0000 (UTC)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
 by mx.groups.io with SMTP id smtpd.web10.12954.1720106817605481040
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Jul 2024 08:26:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=RAur4Y/F;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.208.173, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ee8911b451so8571241fa.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 04 Jul 2024 08:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720106816; x=1720711616; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eHBEF6jJjEkW4uHI0DX2ju3VsdoJPm1/3qr2Ar0ZIPs=;
        b=RAur4Y/FSID0eeXm92dKucDjIiFwVkS8fietloLp0m2aFEBB+EKO5+7SIrl9EIhSve
         xaOOTSl1OHBk2+8dBUBKx1Uvuc9DAK21JU6eEmLX7gdC+Tto+/H3fVjQoSjvA/6OLwmI
         Pwulzwd0dZfXCgsCvg41UeQq31ySFQBwwUbrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720106816; x=1720711616;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eHBEF6jJjEkW4uHI0DX2ju3VsdoJPm1/3qr2Ar0ZIPs=;
        b=ca+1lCD7Xb74gUO9ONTfyFSISGCsCVSv5Ge17UObv+MbSaTXvz7FPr2i87MCFYd6pv
         tz7tFIGkWnUqTzkTHXvsQ+5Tzzg3dNxEzhRqDsphv5HZg1ge9xjcLIPfYMj3sa3THT7S
         wY9xU7uVyU/lQ9J1jXdwx73CTVXZybB3oquduTD7tFOxKyzEJDofqn0bWgD+oXog5kVN
         7YJRZzpqJINS4O0ZADQYnH70iWgqNMXEA6orAObWVyH4kHexD4iMq72BSI37/SaVlsp/
         D6Est8T01V+lxMuAL5e6E46e9n6Ouy1fDad0DxSmbBDlKNINq25nzxfnyZ+RRS9G66cN
         JsWw==
X-Gm-Message-State: AOJu0YzAagKJYOfLWrCLkFDE7F9NjsLPidsA1EHLFbTzlBiezK9D1h8U
	x/o7ewzxILJXIRDnTHcY2iz1u4xyHL7ySXB67LVwmI94BD/c9Vml9l4zOP/q5T0=
X-Google-Smtp-Source: AGHT+IG7t9EZ/xZXu2aWnm3c/JPJmMNIQyxFvxIiqKQye/xDZuB46BwE4pfVrlwi2D+O5zPDJig0gw==
X-Received: by 2002:a05:651c:2226:b0:2ee:86c1:f74a with SMTP id 38308e7fff4ca-2ee8ee00b5amr17284361fa.35.1720106815733;
        Thu, 04 Jul 2024 08:26:55 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:be20:56c3:ce73:d7de? ([2001:8b0:aba:5f3c:be20:56c3:ce73:d7de])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a21cc59sm28300995e9.25.2024.07.04.08.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 08:26:55 -0700 (PDT)
Message-ID: <c20dab609d4943dc3aa9e678a25117523346cc18.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] fix wrong http response for sstate
 cache checkstatus
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: alex.kanavin@gmail.com, yang-mark.zhang@nokia-sbell.com
Cc: "bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Date: Thu, 04 Jul 2024 16:26:54 +0100
In-Reply-To: <CANNYZj__8rYA09zo713LdmdbVYazsaajj74a--aAdvP-ZdoX3g@mail.gmail.com>
References: <a69fcf65d7994a728b5e2e1791f32a38@nokia-sbell.com>
	 <CANNYZj__8rYA09zo713LdmdbVYazsaajj74a--aAdvP-ZdoX3g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0-1build2 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 04 Jul 2024 15:27:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16388

On Thu, 2024-07-04 at 12:17 +0200, Alexander Kanavin via
lists.openembedded.org wrote:
> Note that reviewing patches sent as attachments is very difficult, as
> we can't comment on what is specifically in the patch. Can you make
> an
> account on gmail perhaps and use that to send them? 'git send-email'
> will ensure the patch credentials will be the same, it's only for the
> patch transport.

The issue in this one looks quite serious so we've extracted the patch
and queued for testing. In general we can't always commit to doing that
though.

Cheers,

Richard

