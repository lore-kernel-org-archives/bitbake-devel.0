Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web12.1539.1588140506163619611
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 28 Apr 2020 23:08:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=MpdDLEGD;
 spf=pass (domain: gmail.com, ip: 209.85.128.54, mailfrom: andrey.z@gmail.com)
Received: by mail-wm1-f54.google.com with SMTP id x25so609380wmc.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 28 Apr 2020 23:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tBfvQgYa4DDch8U0S4kjj4Zj18QaqfjEvJLEK+qrzx4=;
        b=MpdDLEGD9QaVEh9+qbJvRRHQ1KKf5gl8BFTrwPKf8ADT8xBsJE2ZGN4+KFy09rM0tt
         ziLsfW59RRFDsim5tgPZYktWGm7wcwTvdcOpEgYuBWeZCiLwS6WTVAedXwqH9WjvTZBO
         kwW7N9J5AonOb7RsCtpVYHvjV91AU7tkLxbPNHoW3YZ1R3kT9MMonOFK9mQm332uv9ZT
         OKMxnEIyv+0FRnCFJCd0EmfRegxaBhzqXl9IHZK7j8kkCZWqdYqVIzJWsGB9YIsFfrZR
         O31hduZOf8zShFZhv2nW8eeqG8SiyDEXmLtQFw5l4qfWt8S273VPfcGWtiNZfXXtwN3O
         jSQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tBfvQgYa4DDch8U0S4kjj4Zj18QaqfjEvJLEK+qrzx4=;
        b=Vs/7b9LeOH9RIixK3bXS02cP2X+KFgUlggslshB8gFhNDeiTPjExshoN4qutfrWX0T
         TfYCHtz0aDWEyjpKzMH4SyoBpJ2jSLX+S3xnD4EsE6BOGl57vc3uEFNnUzD2ZhHgoPcO
         5LPGR37WzW2enh2EEobZVgr13ldTpCfCK4qyL2pMYYARiDtd/08Q39ssb7s2whtmwXJy
         0Ucjizz2icuBjvGE1/8HjqryXLHN4BMv1ptmDH6+UAVmydw43TOSePTgcWH2TCH89mVC
         XgBYFwJOB/LRd+njaAiE2VxwLss8omF7RT8rkyejE1Mq2YjomnvicN/bGRYbgk1vxPDX
         0Idw==
X-Gm-Message-State: AGi0PuYhVx1lmsoRVUocHaODub5AemUxk9vIp68nPqyunWQFHqHPJpkL
	aQjr2WXlWF5WGilDiz24C6Ek09gclJaprZQR80A=
X-Google-Smtp-Source: APiQypLqYsnnq4iksD7xmdyU4N/p/mneVlQE7+vHGKQRgje/nl3vYwt0cigM7HD3iib8UHxtmeodZmipbh1ZlSPUlR0=
X-Received: by 2002:a1c:59c3:: with SMTP id n186mr1254480wmb.24.1588140504513;
 Tue, 28 Apr 2020 23:08:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAHtQpK54tCZf3PHY657cjARhj_j2X6SM834yybiCyk2EPO2Srg@mail.gmail.com>
 <SN1PR12MB24804AF999291543ACA14B9C8BAC0@SN1PR12MB2480.namprd12.prod.outlook.com>
In-Reply-To: <SN1PR12MB24804AF999291543ACA14B9C8BAC0@SN1PR12MB2480.namprd12.prod.outlook.com>
From: "Andrey Zhizhikin" <andrey.z@gmail.com>
Date: Wed, 29 Apr 2020 08:08:13 +0200
Message-ID: <CAHtQpK44OMPm45otKBMZR1CTxb0uaw8GQE5+YRwSgFvcay8AmQ@mail.gmail.com>
Subject: Re: ui/teamcity plugin is broken on master
To: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
Cc: "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"

Hi Chris,

On Wed, Apr 29, 2020 at 12:07 AM chris.laplante@agilent.com
<chris.laplante@agilent.com> wrote:
>
> Hi Andrey,
>
> > It looks like those filters (BBLogFilterStdOut and BBLogFilterStdErr) were
> > dropped with the commit 143685de1b9b0386a4dc8d404bdf342b45b7c030
> > in upstream, so the plugin should have a great deal of rework now...
> >
> > I was able to bring it back to life by removing following lines from
> > [bitbake/lib/bb/ui/teamcity.py]:
> > -    bb.msg.addDefaultlogFilter(console, bb.msg.BBLogFilterStdOut,
> > forcelevel)
> > -    bb.msg.addDefaultlogFilter(errconsole, bb.msg.BBLogFilterStdErr)
> >
> > But that modification is considered a hack and I would not even dare to send
> > a patch for this.
> >
> > I was wondering if anyone already had the same issue and is there a plan to
> > update the teamcity UI plugin to use new log filter mechanisms (like knotty
> > currently does)?
>
> I will try to get around to fixing it on master soon (but no guarantees). We are still on zeus at work - that's why it slipped my mind.

Thanks for the update!

I recently switch from zeus and this was how I had it discovered. I
would switch the UI plugin back to knotty for my Team City and wait
for fix on the master.

>
> Thanks,
> Chris

-- 
Regards,
Andrey.
