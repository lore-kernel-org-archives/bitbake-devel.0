Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web09.2429.1616106756571594450
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Mar 2021 15:32:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=cu8yE7CP;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f46.google.com with SMTP id z2so7164550wrl.5
        for <bitbake-devel@lists.openembedded.org>; Thu, 18 Mar 2021 15:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=HbX+0fwrhUTB63QiIU1q7SnWW7rK+eW7n4S0URUM3bE=;
        b=cu8yE7CPY6hnLzAY4nd0bcKWPpDOFj3wTg+aTFc4LAICf5R5iT8stG69GPQbkbo3kM
         IKh7bf9F79+Rx6lCmDfLyNWdAORRUF+dWnwWsMZBrKvvhT28R8pnayuo34C1AGvBWq3z
         rbpcs0MY13yE1cZBElv7qF/1gH6yLlTD0XRTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=HbX+0fwrhUTB63QiIU1q7SnWW7rK+eW7n4S0URUM3bE=;
        b=sd8sSrn2pjenh5ux1ztqJ+XJEStL4tlYaRjmmUNimTSdqLoX74nd6X/f6OH9BA4vmd
         PMCWN3CGTh+2xHo8QNQT5XwaS2rugDXqJLb7doC0Cv48TQ9CSIQJKMG+3FUrEtudZ1Aj
         TwhTelXWiZmaYDH7gYn+w6jw00wcxoUqXyN636k0ExpHYrSb3Zsiy+75FYkj35za1kY7
         XDNeRGyjxBD7AvVJYqXsB3kqjVUMsbf6PwzsRGR5HNzaCuy1ShruXWHbADdkjraitEKV
         wsjoSkaJwQSHBV2RIiNbS5Rl/Hh8t2siS3JI9E26R1XXe6QkllplAOl4YkrnoQbbK27M
         4U/g==
X-Gm-Message-State: AOAM5321zSQ09ze+QKVoUhCHklCaCgG196E4UDz13di2n90QfuJkR5Kg
	336RvJR3SMhnhofq/WycBDdB83vr+Yxq9A==
X-Google-Smtp-Source: ABdhPJzNGjLlNlZuBadqwrngYveBmb7OOL0E8q0EjFwZh1jgjpbWf0BtTM9itpYFZ/mRsnu4V75Dvw==
X-Received: by 2002:a5d:58ce:: with SMTP id o14mr1461545wrf.4.1616106755178;
        Thu, 18 Mar 2021 15:32:35 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:5808:8e52:d330:3893? ([2001:8b0:aba:5f3c:5808:8e52:d330:3893])
        by smtp.gmail.com with ESMTPSA id i4sm3368026wmq.12.2021.03.18.15.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 15:32:34 -0700 (PDT)
Message-ID: <19e8629424d911ac9aa6f53f4825834e694c6ddd.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] fetch2/git: make sure clonedir is empty when trying next fullmirror
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Christopher Larson <kergoth@gmail.com>
Cc: Denys Dmytriyenko <denis@denix.org>, bitbake-devel@lists.openembedded.org
Date: Thu, 18 Mar 2021 22:32:34 +0000
In-Reply-To: <CABcZANnicqNdbiV-mkDsChRp=sT2_PA_Y+YS5CEoxU3adAdpig@mail.gmail.com>
References: <1616099999-47367-1-git-send-email-denis@denix.org>
	 <336663df14ccfcaddd49f5ae3345ffef5a44d658.camel@linuxfoundation.org>
	 <CABcZANnicqNdbiV-mkDsChRp=sT2_PA_Y+YS5CEoxU3adAdpig@mail.gmail.com>
User-Agent: Evolution 3.39.2-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Thu, 2021-03-18 at 15:28 -0700, Christopher Larson wrote:
> 
> 
> On Thu, Mar 18, 2021 at 3:23 PM Richard Purdie <richard.purdie@linuxfoundation.org> wrote:
> > On Thu, 2021-03-18 at 16:39 -0400, Denys Dmytriyenko wrote:
> > > When first mirror returns an outdated fullmirror tarball, its clonedir stays
> > > behind for successive mirror tries. Even when latest tarball gets fetched
> > > next, it doesn't get unpacked, as clonedir already exists. Cleanup old
> > > clonedir and unpack the new fullmirror tarball, when the old clonedir is
> > > no good and requires update.
> > > 
> > > Signed-off-by: Denys Dmytriyenko <denis@denix.org>
> > > ---
> > >  lib/bb/fetch2/git.py | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> > > index e3ba80a..cb62dcc 100644
> > > --- a/lib/bb/fetch2/git.py
> > > +++ b/lib/bb/fetch2/git.py
> > > @@ -337,7 +337,8 @@ class Git(FetchMethod):
> > >          if ud.shallow and os.path.exists(ud.fullshallow) and self.need_update(ud, d):
> > >              ud.localpath = ud.fullshallow
> > >              return
> > > -        elif os.path.exists(ud.fullmirror) and not os.path.exists(ud.clonedir):
> > > +        elif os.path.exists(ud.fullmirror) and (not os.path.exists(ud.clonedir) or
> > self.clonedir_need_update(ud, d)):
> > > +            bb.utils.remove(ud.clonedir, recurse=True)
> > >              bb.utils.mkdirhier(ud.clonedir)
> > >              runfetchcmd("tar -xzf %s" % ud.fullmirror, d, workdir=ud.clonedir)
> > 
> > I talked a little with Denys about this. I'm worried that if you specify 
> > SRCREV incorrectly it will start blowing away clone directories and
> > for large ones like linux-yocto, the failure mode is *really* annoying 
> > and has the potential for data loss (you shouldn't be putting important data
> > here, but...).
> > 
> > I agree that we do need a test case. We can put artefacts on yp.org urls
> > if needed.
> > 
> > I also wonder if we can't check the new mirror tarball is any better before
> > we blow away the existing directory.
> > 
> 
> 
> I'm assuming this is for the case where the clonedir can't be updated
> directly, ie premirrorsonly?

Effectively. If I understand Denys' case, the upstream is down, the first mirror
tarball it out of date and the second mirror tarball found is not.

> That's a good idea, unpack the new one to a temporary location, see if 
> that one is good enough first. It makes me wonder if there's a way to 
> use git bundles or something that can be interacted with more directly. 
> I'm assuming this is for the case where the clonedir can't be directly 
> updated, i.e. premirrorsonly?

Right, yes. For whatever reason the original source is unavailable and we 
have multiple conflicting mirror data sources we can't immediately inspect.

Cheers,

Richard

