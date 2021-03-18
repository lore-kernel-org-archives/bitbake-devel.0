Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web10.2362.1616106198786626156
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Mar 2021 15:23:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=RU1PEekP;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f43.google.com with SMTP id v4so7133560wrp.13
        for <bitbake-devel@lists.openembedded.org>; Thu, 18 Mar 2021 15:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=wkq1EPTQ2Ta4BMXPxF7DJJUZ8JZYaalF+qld+R1Dc+o=;
        b=RU1PEekPL7oe18InyAlpXY2mtxL01OFVti22YlTv3L4G28R+po5aYRAVInS23NR5i7
         plXNdfGtU8CdGE8L7OJiI3gRcq/pS9L0b+EuAZmE9WBEms/g6GgVAYy+7DM51UO76qAm
         C8rOGmGnBi62tWDq3jCP8OY/F6dQAJHRmZzN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=wkq1EPTQ2Ta4BMXPxF7DJJUZ8JZYaalF+qld+R1Dc+o=;
        b=fpzBOnjMbOAL7K5zn7fVeeezCVl8EfGiQ99pq0pXmOJOrcLyMmdUTgS+vEnmbPoE28
         7hj8q5d9Cz3j+ieepPtOvM/+0o6TWxIQOICcJEOEQFyM29s/atdd5tPlY3yCNdmGD0YM
         IyXmje1ODyMzqB9sLViLQQFXlleEbSDN95W9wVvgakHXIZDnaAU1B6Le+/88jj7uRAbU
         OX3BGIvNjQzUcCtgdoIfhs8kgc9uHlLWBKCNE2ThbTyDiJCehmmd+Bw/+aqoudF1GM86
         CDTWTG98nCIvtWNQ6kzfEhbhQIoqYD2wnFaTueB2v6e4rwInI6qLQEpL9eIVaj5Zl6Hy
         CJRQ==
X-Gm-Message-State: AOAM5322cLhyFdcuxN/mWg0sws+rs5O2I7VVQz5kNuujGkmfq0OtsEYV
	B/07UaYQGfWhpBlUWrXbEsIMmg==
X-Google-Smtp-Source: ABdhPJzsXGUkH36yint79XPXvDzSoeO6yTyIU+eY73kweP1RHZ1RKzhHmhDjxBH41d8kaiMWwpjUAw==
X-Received: by 2002:a5d:6ccb:: with SMTP id c11mr1424854wrc.122.1616106197005;
        Thu, 18 Mar 2021 15:23:17 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:5808:8e52:d330:3893? ([2001:8b0:aba:5f3c:5808:8e52:d330:3893])
        by smtp.gmail.com with ESMTPSA id t8sm4746186wrr.10.2021.03.18.15.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 15:23:16 -0700 (PDT)
Message-ID: <336663df14ccfcaddd49f5ae3345ffef5a44d658.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] fetch2/git: make sure clonedir is empty when trying next fullmirror
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Denys Dmytriyenko <denis@denix.org>, bitbake-devel@lists.openembedded.org
Date: Thu, 18 Mar 2021 22:23:16 +0000
In-Reply-To: <1616099999-47367-1-git-send-email-denis@denix.org>
References: <1616099999-47367-1-git-send-email-denis@denix.org>
User-Agent: Evolution 3.39.2-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Thu, 2021-03-18 at 16:39 -0400, Denys Dmytriyenko wrote:
> When first mirror returns an outdated fullmirror tarball, its clonedir stays
> behind for successive mirror tries. Even when latest tarball gets fetched
> next, it doesn't get unpacked, as clonedir already exists. Cleanup old
> clonedir and unpack the new fullmirror tarball, when the old clonedir is
> no good and requires update.
> 
> Signed-off-by: Denys Dmytriyenko <denis@denix.org>
> ---
>  lib/bb/fetch2/git.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> index e3ba80a..cb62dcc 100644
> --- a/lib/bb/fetch2/git.py
> +++ b/lib/bb/fetch2/git.py
> @@ -337,7 +337,8 @@ class Git(FetchMethod):
>          if ud.shallow and os.path.exists(ud.fullshallow) and self.need_update(ud, d):
>              ud.localpath = ud.fullshallow
>              return
> -        elif os.path.exists(ud.fullmirror) and not os.path.exists(ud.clonedir):
> +        elif os.path.exists(ud.fullmirror) and (not os.path.exists(ud.clonedir) or self.clonedir_need_update(ud, d)):
> +            bb.utils.remove(ud.clonedir, recurse=True)
>              bb.utils.mkdirhier(ud.clonedir)
>              runfetchcmd("tar -xzf %s" % ud.fullmirror, d, workdir=ud.clonedir)

I talked a little with Denys about this. I'm worried that if you specify 
SRCREV incorrectly it will start blowing away clone directories and
for large ones like linux-yocto, the failure mode is *really* annoying 
and has the potential for data loss (you shouldn't be putting important data
here, but...).

I agree that we do need a test case. We can put artefacts on yp.org urls
if needed.

I also wonder if we can't check the new mirror tarball is any better before
we blow away the existing directory.

This isn't at all straightforward and I suspect we've been here before.

Cheers,

Richard



