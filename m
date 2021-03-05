Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web08.907.1614987280424948770
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Mar 2021 15:34:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=CpillUoo;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f47.google.com with SMTP id w7so2655151wmb.5
        for <bitbake-devel@lists.openembedded.org>; Fri, 05 Mar 2021 15:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=P1CL5kC2ED9gqufrnh3HhflPmqtt2cYLsdR2fOoPsMs=;
        b=CpillUoofUiYOTxF7vLXh/syCCnHMbVKYiWR35wLu/nmhEYildiYPdoU3VfgTfI5Xp
         GD0dyIZlrTAJBiEat4HXLPsE3m8WLJcrGco772ys5I/nmxO9NPDKU/qg6UiFvwz0fMxl
         VIeayXz8maCHh4+KLQWyCQVwUSNhvjFggAMSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=P1CL5kC2ED9gqufrnh3HhflPmqtt2cYLsdR2fOoPsMs=;
        b=TkF76RbSCYjJuKT0GpzrvJyXZwu1/4MpdW0isbhi9Qv0BSd69wrvsjIxBTRi3HdbTO
         11Psv5TFqW83sB5g1vOw8YqKsIv6oSSG/Ngr8aVctlraonlUg1K2Z8qomL2an/EAhGGw
         D1BXq3TL6Wl/t3Z1bRgt48MH6NAhoyGUjUJs3tmfblywHAlDk6/p3iMZrBAY08FrZqQo
         CwDKObXV9fb3utltwUnNSi1ajDHkELuP86GAC6UpS895NBEGYD+P0aIW42UKQll26jQr
         LVU2JU3jXwumd5Khu7vdCkWiGYL6nieU9nDzMbOXAsAJXCy6I7Dctk2o5YkjRKl3ibGz
         Owcw==
X-Gm-Message-State: AOAM5310ZShCRJC7HhO5e4csOJnrVPd6UxGdcv0AUyqbNF5o+mOF8aCS
	+SSMf7WqRLWjbWeDPl5lNtw5lA==
X-Google-Smtp-Source: ABdhPJzYfkg7ER/VBA4qbBUZIuPMaAiAdn1MFcK0ym7li3VjQEmYzLV/VOA4eYvoUQyhx8JW4YbbCg==
X-Received: by 2002:a7b:cb58:: with SMTP id v24mr11050846wmj.182.1614987278813;
        Fri, 05 Mar 2021 15:34:38 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:8791:d573:be1c:dfe9? ([2001:8b0:aba:5f3c:8791:d573:be1c:dfe9])
        by smtp.gmail.com with ESMTPSA id v9sm6398804wrn.86.2021.03.05.15.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 15:34:38 -0800 (PST)
Message-ID: <95744fe191eaa2b26a115b3292fda4ae50e1bdc4.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v4] runqueue: Print pseudo.log if fakeroot task failed
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, Jan Brzezanski
 <jan.brzezanski@gmail.com>, Paulo Neves <ptsneves@gmail.com>, Mikolaj
 Lasota <mikolaj.lasota@protonmail.com>, Wiktor Baura <wbaura@gmail.com>,
 Kamil Kwiek <kamil.kwiek@gmail.com>
Date: Fri, 05 Mar 2021 23:34:37 +0000
In-Reply-To: <CAJkqNs1pR+Rr9TV10V5rSDiO=dVQWKfPwYgHy-SteZuv1WjvDw@mail.gmail.com>
References: <20210305114424.10665-1-tomasz.dziendzielski@gmail.com>
	 <7133548d7c805c051099c599553027689c2351ce.camel@linuxfoundation.org>
	 <CAJkqNs1pR+Rr9TV10V5rSDiO=dVQWKfPwYgHy-SteZuv1WjvDw@mail.gmail.com>
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Fri, 2021-03-05 at 20:01 +0100, Tomasz Dziendzielski wrote:
> > On Fri, 2021-03-05 at 12:44 +0100, Tomasz Dziendzielski wrote:
> > > Currently if pseudo fails we can only see the path to pseudo.log. If we
> > > have no access to server and can only rely on bitbake log then debugging
> > > becomes impossible. This printing needs to be added in runqueue level,
> > > not inside task execution, because in some cases task fails with pseudo
> > > abort really early and we don't even see any log.
> > > 
> > > In this change I'm adding pseudo log printing in every fakeroot task
> > > failure that logged `mismatch`, `error` or `fatal` to logfile, because
> > > we have no other way to communicate with pseudo if it failed or not.
> > > Only lines from last pseudo server execution will be printed.
> > 
> > I don't think this is going to work as it has the same issue as with taskfn.
> > 
> > There are only two bitbake-worker processes started and these fork off
> > individual processes. The fakeroot enrvionment is adjusted in those
> > workers as the tasks are started and pseudo will reread from the
> > environment. The log analysis code will need to update to the current
> > process' environment too...
> 
> It's not the same issue. In this case we loop over each tasks in queue:
> 
>         while found and len(self.queue):
> ...
>             while index != -1 and self.queue.startswith(b"<exitcode>"):
>                 try:
>                     task, status = pickle.loads(self.queue[10:index])
> ...
>                 (_, _, _, taskfn) = split_tid_mcfn(task)
>                 fakerootlog = None
>                 if self.fakerootlogs and taskfn and taskfn in self.fakerootlogs:
>                     fakerootlog = self.fakerootlogs[taskfn]
>                 self.rqexec.runqueue_process_waitpid(task, status, fakerootlog=fakerootlog)
> 
> so every time we get a new task, new taskfn and then new (correct) pseudo 
> log path specific for each task.
> To verify this I triggered more than one pseudo abort in one build and 
> I got correct pseudo logs printed for each failed fakeroot task. For 
> comparison, with the previous patch I'm getting the same (wrong) pseudo 
> log printed multiple times.

You're right, I did misread the patch earlier, sorry. I'll queue it for 
testing, thanks.

Cheers,

Richard

