Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
 by mx.groups.io with SMTP id smtpd.web12.3919.1585825392960274854
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 02 Apr 2020 04:03:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=hJQ14a7j;
 spf=pass (domain: konsulko.com, ip: 209.85.167.169, mailfrom: paul.barker@konsulko.com)
Received: by mail-oi1-f169.google.com with SMTP id d63so2397750oig.6
        for <bitbake-devel@lists.openembedded.org>; Thu, 02 Apr 2020 04:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MrbzbISFCA3ze5jCMnbTycaMVRclbQs4v547IIQXUDw=;
        b=hJQ14a7jGbRSQsy2sORZwIGrO0WzFZhZ19l264zKUrez5hJmXhMwSsxrOsQJdd5c3D
         bQXfyTxrk3K6j8iILbj4rD8yamMkoLxj5YvpZnqM84YdGiH6uUyAsWZx4Cn3Xty6UbiU
         JwWdi0bjWojHovJPbF4mbKk5Rft8T9l7px7fc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MrbzbISFCA3ze5jCMnbTycaMVRclbQs4v547IIQXUDw=;
        b=R3Yx/lkSyIZ07tuhpqrBiktn9Sifz/8WHSZ2XclEpA4lm6EiTW9ZbNKAXRf4LL4NZ9
         Uhh8A/y5xVGghmBH8+6NgeAxgsWl21BsN+c+hPaAaTvrLscp1flzCuVbpYF258eiFaN/
         FyGr1xffBqVyR8pwACd5Ot3iu3rh7B8mkcQd2QVqlj123M67zT+ODVTggR5A7C5bz7yi
         Gl8vUdiXhye+65Lcc3++ivJ9JANvQRo9mqirLnjNPKTZBNDpSD4Aspn4j6GFKD47c9cf
         QovgGO2oMlTG6mrP8PjQuw9Z6lrjzbpIipbRe05nkaevsBYyKzjE8d91aA8tDATiRvaM
         CUDw==
X-Gm-Message-State: AGi0PuZVT0GlJU5guMLlJP4oVMPIcpSZFor1zxAkfsLu0EnOJnQKy8Bo
	PhH53vF9fjR6PDWmu9K/rP1CNTqiNGqM7h3L5Vq32A==
X-Google-Smtp-Source: APiQypJ9pdWILoEzjOM0972Pskl6hLmWEEPPXnmf+A3fBXTgUYewwIYC152+zlyVMI2kyDx9ZO3CdSrHC3nE9rp47ts=
X-Received: by 2002:aca:a94a:: with SMTP id s71mr1656412oie.152.1585825392275;
 Thu, 02 Apr 2020 04:03:12 -0700 (PDT)
MIME-Version: 1.0
References: <a8d54563-8041-73dd-e494-b2d087b20d7a@gmx.at>
In-Reply-To: <a8d54563-8041-73dd-e494-b2d087b20d7a@gmx.at>
From: "Paul Barker" <pbarker@konsulko.com>
Date: Thu, 2 Apr 2020 12:03:02 +0100
Message-ID: <CAM9ZRVvsyz7k_CumZzpD8me5PFqFioZzSr1kAXCXGRjRV1D0HQ@mail.gmail.com>
Subject: Re: [bitbake-devel] Gitsm does not use credentials when cloning the submodules
To: bernd.bauer@gmx.at
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 Apr 2020 at 20:17, Bernd Bauer <bernd.bauer@gmx.at> wrote:
>
> Hi!
>
> I think I have found a bug in the bitbucket git sumbodule fetcher.
>
> In my example I try to clone a repository with submodules using gitsm.
> The git server here needs authentication. Also for the submodules.
> These credentials are encoded in the URL of the submodule.
> See example below.
> The main repo can still be cloned because the credentials are stored
> in the recipe itself.
> But for the submodules, the password is not used.
>
> My patch uses the password if one is available.
>
> I have found the bug in poky warrior branch that I'm currently using.
> In the fido branch gitsm works with username and password.
> (I know... fido is quite old, but I'm also using this version.)
>
> Example .gitmodules
> ---------------------------------------------------------
> [submodule "sub1"]
>         path = sub1
>         url = https://user:password@test.org/url/to/sub1
> ---------------------------------------------------------
>

This looks good at first glance but needs some further review once
it's sent in the correct format. Please read
https://www.openembedded.org/wiki/Commit_Patch_Message_Guidelines and
https://www.openembedded.org/wiki/How_to_submit_a_patch_to_OpenEmbedded
and re-submit the patch.

Thanks,
Paul
