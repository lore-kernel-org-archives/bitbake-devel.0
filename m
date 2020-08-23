Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
 by mx.groups.io with SMTP id smtpd.web12.184201.1598224829238916850
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 23 Aug 2020 16:20:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=l9WMso2O;
 spf=softfail (domain: sakoman.com, ip: 209.85.218.43, mailfrom: steve@sakoman.com)
Received: by mail-ej1-f43.google.com with SMTP id l2so3542075eji.3
        for <bitbake-devel@lists.openembedded.org>; Sun, 23 Aug 2020 16:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mgi7xIYvVbFVgMSxRtn748ULzxaeVr2tpQxH2pXD+jQ=;
        b=l9WMso2O5jfiehyXjghwMB9RZ8SESoUVVBToYtMaRcPIaEXoH1lMSczHvzQ1iHVH0k
         xRbIkU1IYaoiKRTdDjB1gauUSCEFdkeHdhwsAiSx3Bdg+5nxWJ2wIHmh+35w38eeJwzd
         Ynp/P4bXsHphbNPXiMEUo0xyGvaV+ogYCKaJo12htHZjKzYJ9Dp1nq1v2DJz++Y731NW
         S5kqVkkXbOrgH17nWle2/h67fme2rOHMwAxD2pd17DXIoh17NIKofLz2O61tW0qK/Dpj
         QPcQUMldFrfcdyND8MQ3/nAJXR/zXdfBiHYvVzgYMWfxOFcwB/nWW3qrhzQSNKecSRGg
         PmsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mgi7xIYvVbFVgMSxRtn748ULzxaeVr2tpQxH2pXD+jQ=;
        b=TdCnUMnA9lrclg92TSj8s3njNY3/QYUvQvCd0f8RBl22az1tnkltdlTpY8yJ8b9rp2
         VzDQweSCXcyzK7E97WP1bMkgs4wmcmiZ1CWwAOGOpdgVnKBteykILFlQ7GLKJ/bdIu5d
         BGT/rtvtgDdTOH380+OFEuYSmMjtmY5n1pghv0IP+lLhUuHm9oMdmV0c2PGw2pOta5JK
         ZurxRGvdUUE5uR9xy5hvvU9CsnMLJxY/Bca6N22R/4uExKE3wzVUvtDJtDURKSuIAytW
         tgk34XQehZYBKgCgKfoiF2B6m0PmNXu6B80mDhSdaUClqwowD2+hpkftFhm3Pm84fjaT
         nazQ==
X-Gm-Message-State: AOAM531sG5sLqpdPhc5XEtAwC5wfZR2aALJaVKZqz8SoRO2zLk3sO2g6
	gx2uimLw6EzVqj6BsrwJbYCPIxiRihr6RhnC2qY2Ww==
X-Google-Smtp-Source: ABdhPJy8mE0NH/BaTVxZXRjXfjTTqBeIKyWIG0EIrMpTuJUS17cXRb4zcdsCkhOShvrEcHNFl5firPBrNYi1B82Lv2g=
X-Received: by 2002:a17:907:20ae:: with SMTP id pw14mr3039782ejb.153.1598224827605;
 Sun, 23 Aug 2020 16:20:27 -0700 (PDT)
MIME-Version: 1.0
References: <7f25ddacf4f8140bc8f0c9371ec56f9b8a78069f.camel@linuxfoundation.org>
In-Reply-To: <7f25ddacf4f8140bc8f0c9371ec56f9b8a78069f.camel@linuxfoundation.org>
From: "Steve Sakoman" <steve@sakoman.com>
Date: Sun, 23 Aug 2020 13:20:16 -1000
Message-ID: <CAOSpxdZi0kaCz7zq7+AZ35QEMuGChNsO7k=whkZTSB901LCBEQ@mail.gmail.com>
Subject: Re: [bitbake-devel] Bitbake server startup issues - need a radical rethink?
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>, Steve Sakoman <sakoman@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, Aug 23, 2020 at 2:36 AM Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
>
> The bitbake server startup code is proving problematic. It nearly works
> but there are a few issues.
>
> Basically it comes down to us trying to daemonise one python process
> from inside another one so they run independently. The python
> interpreter simply isn't up to it.
>
> Our current approach uses os.fork() twice. We have to use os._exit() on
> the end codepaths rather than sys.exit() as that would raise SystemExit
> inside the original codebase inside a second process, meaning execution
> happens there twice which is really really bad.
>
> If we use os._exit(), atexit and multiprocessing.Finalize() constructs
> don't work. This can leads to unexpected problems as we're effectively
> breaking an significant part of the python's behind the scenes
> machinery.
>
> We could go back to the setup where we os.fork() twice then launch a
> multiprocessing.Process() but it feels like we're relying on a hack.
>
> I'm also noting logging is working differently in tinfoil and knotty. I
> think this is due to the state of python's logging in the parent
> environment, pre-fork. I really don't like the fact we have an
> inconsistent base environment for the server.
>
> This is a long way of saying, I think we need to radically change the
> way bitbake's server process is started by making it a new process
> execution. That will break the mechanism we determine when the UI is
> "ready" and give us a whole new world of races to potentially worry
> about but I think its the only way we're going to get out of this
> current 'mess'.
>
> I'm particularly worried about what this means for the LTS release
> though as I'd effectively be writing these race issues off as unfixable
> there unless we take the new process setup code which would seem a
> little unwise.

As a normal dunfell user, bitbake startup issues aren't something I've
ever encountered. So for most normal users not having these race
issues fixed in dunfell probably isn't a concern.

As dunfell maintainer, the intermittent bitbake server startup issues
on the autobuilder are an annoyance, but not the end of the world.
I've been living with it and don't see any reason why I can't continue
to.

Maybe after the new process setup code has "baked" for a few months we
can revisit this.

Steve

> 
