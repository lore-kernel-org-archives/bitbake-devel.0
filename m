Return-Path: <sam@liddicott.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BE3C74A5B
	for <webhook@archiver.kernel.org>; Sun, 26 Mar 2023 14:19:03 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.web11.10937.1679840337104880731
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 26 Mar 2023 07:18:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@liddicott-com.20210112.gappssmtp.com header.s=20210112 header.b=IQ8fEozO;
 spf=none, err=SPF record not found (domain: liddicott.com, ip: 209.85.214.172, mailfrom: sam@liddicott.com)
Received: by mail-pl1-f172.google.com with SMTP id o11so6101924ple.1
        for <bitbake-devel@lists.openembedded.org>; Sun, 26 Mar 2023 07:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=liddicott-com.20210112.gappssmtp.com; s=20210112; t=1679840336;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QEkJ8C8ooop3XVnjFZo50WSmFHIXKIKMIHCnb22mcto=;
        b=IQ8fEozOdYlWytkxJ3Ue49dD3NrUbNwobxIYeQGURn+JtLfqH7OW4I5cLlnXftxvMv
         g0yt/hpz+f+Rtqzl6g+A3RklfiSzKDOrRtWRo9Ez5uKxU+DkQh1m9vG/gYoGDhmqCKiO
         2cz7bgP79c4qIsIh8JXLQRzXrevGguerVRrZwNXsAR56H39XiVVFCJ1nYV2y5r5yPSjf
         gtafUPw7ty3WYrpk23dxMHh5Fko5W4uZk9y1vqcYbc6nsmUUoob5TWXMKRNZ7/w0PJTj
         ilPqHJIJK0qiyzVY5Xsfy1GpPitRL2u424CA3ozzXuhaU3qhkvkfiKJ/JUzyKBE33Wep
         a7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679840336;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QEkJ8C8ooop3XVnjFZo50WSmFHIXKIKMIHCnb22mcto=;
        b=QF1hXFb01BZjNDxrt9DGMkvHmWHx9EniOXG70ST9OgYyNDGvAquWa5vtPo0IFE98a/
         3pmniE6G6lTO5UjpkvVuWFTzD1zyw+gFAUokcmf01HVLNXiEtRwLXIPr4FIQRgwJUi1C
         J8YtyD9tRdNePX1bRbEAYROrchtsohZJ6PfztZoWfE9yXoyNiwQmtmp+WtEQ6mDaEgqO
         7QCmh5hWs6hVtsbCIaDGp9F6UTAuU2eqz/NFDZzQP9v36Ptb7ZCLBnS1pI/U2cohNOiJ
         FnMZ4jFgmhurQHJ5RpK82HvX0g/wHpUMx5fO4LmAgEvyRkSd1iX1/XxROOlugvoFTrYZ
         zOnQ==
X-Gm-Message-State: AAQBX9cIGemYweDizUAjHdLRnmH1R8cI7AzW8bD1u0KNRhTCzSP+u3qr
	mBtDpzsv5Ke4zLp0mZmmTnRYPeLBxefg9WB2Nh0/Rw==
X-Google-Smtp-Source: AKy350YGlbZQWu7XMiY/CNLu0DX3sbyIIcP6XMykTGM9CbduiAyabzeMS5fyf32dY++prcDSi6hQz9AmgH4Og2uaZsw=
X-Received: by 2002:a17:90a:8b09:b0:23f:1caa:233a with SMTP id
 y9-20020a17090a8b0900b0023f1caa233amr5958709pjn.1.1679840335680; Sun, 26 Mar
 2023 07:18:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1679641659.git.liezhi.yang@windriver.com>
 <e763d75fb33b69bbfbf3350b2592b4eea7d3878d.1679641659.git.liezhi.yang@windriver.com>
 <CAFMvBt3DoQmj371=wjzTefmvKdXUFwZGjSXggGnFYgqcK=Ftaw@mail.gmail.com>
In-Reply-To: <CAFMvBt3DoQmj371=wjzTefmvKdXUFwZGjSXggGnFYgqcK=Ftaw@mail.gmail.com>
From: Sam Liddicott <sam@liddicott.com>
Date: Sun, 26 Mar 2023 15:18:43 +0100
Message-ID: <CAOj-5WA_qcjPBOH7Jt7N-Hb1saPNeijHg+VA3qKL_3gs7DYD_w@mail.gmail.com>
Subject: Re: [PATCH 1/1] fetch/git: Fix local clone url to make it work with repo
To: "Theodore A. Roth" <troth@openavr.org>
Cc: Robert Yang <liezhi.yang@windriver.com>, bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="0000000000007cee4405f7ce4eb8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 26 Mar 2023 14:19:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14619

--0000000000007cee4405f7ce4eb8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for responding to this.

Does this method allow symlinking for local clones?

I have a large git repository checked out using the repo --mirror option,
which is then cloned for each target workspace.

I'd like to avoid doing large local clones for each MACHINE workspace
(there's a good dozen) but instead just symlink git objects as has been
working previously and according to the patch I submitted.

Sam

On Fri, 24 Mar 2023, 19:51 Theodore A. Roth, <troth@openavr.org> wrote:

> On Fri, Mar 24, 2023 at 1:09=E2=80=AFAM Robert Yang <liezhi.yang@windrive=
r.com>
> wrote:
> >
> > The "git clone /path/to/git/objects_symlink" couldn't work after the
> following
> > change:
> >
> >
> https://github.com/git/git/commit/6f054f9fb3a501c35b55c65e547a244f14c38d5=
6
> >
> > But repo command manages the git repo as symlinks, so check whether the
> objects
> > is an symlink to fix the problem:
> >
> > * Nothing is changed if git/objects is not a symlink
> > * Use "git clone file://" when git/objects is a symlink
> >
> > Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
>
> Tested-by: Theodore A. Roth <troth@openavr.org>
>

--0000000000007cee4405f7ce4eb8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div dir=3D"auto">Thanks for responding to this.</div><di=
v dir=3D"auto"><br></div>Does this method allow symlinking for local clones=
?<div dir=3D"auto"><br></div><div dir=3D"auto">I have a large git repositor=
y checked out using the repo --mirror option, which is then cloned for each=
 target workspace.</div><div dir=3D"auto"><br></div><div dir=3D"auto">I&#39=
;d like to avoid doing large local clones for each MACHINE workspace (there=
&#39;s a good dozen) but instead just symlink git objects as has been worki=
ng previously and according to the patch I submitted.</div><div dir=3D"auto=
"><br></div><div dir=3D"auto">Sam</div></div><br><div class=3D"gmail_quote"=
><div dir=3D"ltr" class=3D"gmail_attr">On Fri, 24 Mar 2023, 19:51 Theodore =
A. Roth, &lt;<a href=3D"mailto:troth@openavr.org">troth@openavr.org</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">On Fri, Mar 24, 2023 at 1:0=
9=E2=80=AFAM Robert Yang &lt;<a href=3D"mailto:liezhi.yang@windriver.com" t=
arget=3D"_blank" rel=3D"noreferrer">liezhi.yang@windriver.com</a>&gt; wrote=
:<br>
&gt;<br>
&gt; The &quot;git clone /path/to/git/objects_symlink&quot; couldn&#39;t wo=
rk after the following<br>
&gt; change:<br>
&gt;<br>
&gt; <a href=3D"https://github.com/git/git/commit/6f054f9fb3a501c35b55c65e5=
47a244f14c38d56" rel=3D"noreferrer noreferrer" target=3D"_blank">https://gi=
thub.com/git/git/commit/6f054f9fb3a501c35b55c65e547a244f14c38d56</a><br>
&gt;<br>
&gt; But repo command manages the git repo as symlinks, so check whether th=
e objects<br>
&gt; is an symlink to fix the problem:<br>
&gt;<br>
&gt; * Nothing is changed if git/objects is not a symlink<br>
&gt; * Use &quot;git clone file://&quot; when git/objects is a symlink<br>
&gt;<br>
&gt; Signed-off-by: Robert Yang &lt;<a href=3D"mailto:liezhi.yang@windriver=
.com" target=3D"_blank" rel=3D"noreferrer">liezhi.yang@windriver.com</a>&gt=
;<br>
<br>
Tested-by: Theodore A. Roth &lt;<a href=3D"mailto:troth@openavr.org" target=
=3D"_blank" rel=3D"noreferrer">troth@openavr.org</a>&gt;<br>
</blockquote></div>

--0000000000007cee4405f7ce4eb8--

