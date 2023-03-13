Return-Path: <troth@openavr.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DDEC61DA4
	for <webhook@archiver.kernel.org>; Mon, 13 Mar 2023 13:35:25 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web10.19489.1678714522493811787
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 13 Mar 2023 06:35:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@openavr-org.20210112.gappssmtp.com header.s=20210112 header.b=gYwX+06Z;
 spf=none, err=permanent DNS error (domain: openavr.org, ip: 209.85.221.43, mailfrom: troth@openavr.org)
Received: by mail-wr1-f43.google.com with SMTP id l1so11317867wry.12
        for <bitbake-devel@lists.openembedded.org>; Mon, 13 Mar 2023 06:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openavr-org.20210112.gappssmtp.com; s=20210112; t=1678714521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N4Wk2pNTTaxdms/qCdLXML6PQfT1B7WJt/IioqgoYAk=;
        b=gYwX+06Z7LpgRkBCGxNeVyDwxibQS54DO72+52NVe4XxfyXQVw1vFXBdbItVdopij7
         br+pmIabapLo2v+PeRL3YoMNAQxc8IkITBrTcU0tZAc8UYySEKtMEnD/ex0NOTC1dxSY
         7yytIwk+up4XgXnGttKesGapxqdh8vF8OMQaObAYESJ/eYlBRPKhDotnRwvxmYyJADIN
         yQCqGKqfDHyyTQcqqxfNxTLM9t9D6qeRLV2ppCYziabfUGmHiQ724xKK2kN1iYnWNgE3
         kq3XI8vQvrAw9jA9txQYDYAEcux25/nlBu5qEV4QxLcHOxdJFRWBbLLTHIN4IQOfUCut
         cC8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678714521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N4Wk2pNTTaxdms/qCdLXML6PQfT1B7WJt/IioqgoYAk=;
        b=A5Ulro6oFDUiADSCl03yoRxFcJ4V/p5UZHQvDcmmABsdVW4ZgkAQQ7H/7zbSvWXOTB
         +A74udyu2CsXUafwzhAiwpVEKDOMrwK5P1lpKQTbybLk3kcUgDogBxG0/wJtOY5esbM0
         ZwzqjsoyGTxM8lAge2mlC2aXMOoScQ1LCHgP7ODB+xIR/2dtdVvAKEql6BvibVNygLzF
         4VJG2rW3VSrBzLlTArRWKQy/fTdDODcDZnaR9xMfGEhzv50x15l0ucYDY3vyZ4qj7UvH
         1h7S0bcg/eaEKDSpqO+yztBE2+NCWhkS+HszGBkqQD9b1+ZuimZhP6XY8pJ76ZwbrCzU
         t6WQ==
X-Gm-Message-State: AO0yUKWkGsqYITwYUeh9sap351DiV7Ylli4/4XYMqHxhqD7dXgKofdE0
	N/eBXI3MBHAq52LMbLrfGtVSPgirWsGx2ktKBsgMMQ==
X-Google-Smtp-Source: AK7set8yyMUX88FU2Ze12mbsrcCqs0zgIS8V0blYKy5rRxXechk8CCbyi6WIALAXfMZEs7NvF1B/orgbbG7aaPnq8z8=
X-Received: by 2002:a5d:50ca:0:b0:2cf:e6d0:6377 with SMTP id
 f10-20020a5d50ca000000b002cfe6d06377mr191297wrt.6.1678714520707; Mon, 13 Mar
 2023 06:35:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAOj-5WB8oaXJ=rrXDNRYzhB92CgRrsutveMnWXhEpcEJKb60KA@mail.gmail.com>
In-Reply-To: <CAOj-5WB8oaXJ=rrXDNRYzhB92CgRrsutveMnWXhEpcEJKb60KA@mail.gmail.com>
From: "Theodore A. Roth" <troth@openavr.org>
Date: Mon, 13 Mar 2023 07:35:09 -0600
Message-ID: <CAFMvBt0jkfvDACAmWS6NNcUAv+DM=BMGHZS+MBnn0fYPohAJ5A@mail.gmail.com>
Subject: Re: [bitbake-devel] discussion: git fetcher now needs either file://
 or -s
To: Sam Liddicott <sam@liddicott.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 13 Mar 2023 13:35:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14551

On Tue, Feb 28, 2023 at 6:36=E2=80=AFAM Sam Liddicott <sam@liddicott.com> w=
rote:
>
> These recent security changes to git prevent git.py cloning of local
> repos that contain symlinks in the .git directories (e.g. a repo-tool
> manifest checkout)
>
> * https://github.com/git/git/commit/36596fd2dfa473cf1069d23776e62cc156e7b=
5c6
>    clone: better handle symlinked files at .git/objects/
> * https://github.com/git/git/commit/6f054f9fb3a501c35b55c65e547a244f14c38=
d56
>    builtin/clone.c: disallow --local clones with symlinks
> * https://github.com/git/git/commit/bffc762f87ae8d18c6001bf0044a760042457=
54c
>    dir-iterator: prevent top-level symlinks without FOLLOW_SYMLINKS
>
> To prevent some local clones from failing, the bitbake git fetcher
> could use the -s like this:
>
> -            clone_cmd =3D "LANG=3DC %s clone --bare --mirror \"%s\" %s
> --progress" % (ud.basecmd, repourl, ud.clonedir)
> +            clone_cmd =3D "LANG=3DC %s clone -s --bare --mirror \"%s\" %=
s
> --progress" % (ud.basecmd, repourl, ud.clonedir)
>
> Instead of "-s", others may prefer to restore the url prefix file://
> which also works,
>
> -            if repourl.startswith("file://"):
> -                repourl =3D repourl[7:]
>
> I don't know which bests represents the original intention behind
> removing file://, but "-s" gives a quicker clone of what for me is a
> symlinked source repo anyway, and for the lifetime of a build I'm not
> expecting the local original source repo to vanish in a way that will
> affect the build.
>
> Sam

My organisation is also experiencing this issue with recipes that
contain SRC_URI values
pointing to `file://` source that was checked out using the
google-repo tool (which happens
to create symlinks to `.git` living outside of the SRC_URI referenced
git repository).

Our work around for this, is to have each developer impacted by this
append `--no-local`
to the `clone_cmd` as such:

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index 5bb8393133..17c4b8ca18 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -373,6 +373,8 @@ class Git(FetchMethod):
             clone_cmd =3D "LANG=3DC %s clone --bare --mirror %s %s
--progress" % (ud.basecmd, shlex.quote(repourl), ud.clonedir)
             if ud.proto.lower() !=3D 'file':
                 bb.fetch2.check_network_access(d, clone_cmd, ud.url)
+            else:
+                clone_cmd +=3D " --no-local"
             progresshandler =3D GitProgressHandler(d)
             runfetchcmd(clone_cmd, d, log=3Dprogresshandler)

Digging into the git history for this functionality, it appears to
have been introduced way back in 2012 to speed up cloning from local
source repos (e.g. things like the kernel source). The work arounds
provided above, would probably have a negative impact on that
particular user case though.

Would really love to see a fix for this included in bitbake upstream
so we don't have to manually patch.

Ted Roth

