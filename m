Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
 by mx.groups.io with SMTP id smtpd.web11.16205.1593526294814317726
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 30 Jun 2020 07:11:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=GFClYitu;
 spf=softfail (domain: sakoman.com, ip: 209.85.218.67, mailfrom: steve@sakoman.com)
Received: by mail-ej1-f67.google.com with SMTP id dr13so20815077ejc.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 30 Jun 2020 07:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=daWWgj/TK/EVm7A2nDRS5SHSciD5xe/vSNyCbVOpgiM=;
        b=GFClYituOlmrLxQT5HVhNJzFb9EAf6H9OyLnYDVe6/0Zpw6J8ADFI/peZns3bdzsYT
         wrC0OJM23YIxOoANj51TzVeQ9Yqduom0ZFRT9bJ/cxYXCskAHo160bWD55MnhyeomNW2
         s166xNE3kni6il1EcpVDkjouOWC2hFvVCiKC80NrWvDEimmu+LxxbSV6vYnIh9fCbX6X
         1elLdoLnxiWqwEQvt/FCESJwgBrBnPCRX4wViydtsCurAumxtuVDNIuxER+Fkwpy3igJ
         F9LkTMuN4wu3QCRj+s3t2fhQRkxK39AdvJu4L16W5S9Bx/dvF0TVsOz0ODl5ZtshSoUk
         4fYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=daWWgj/TK/EVm7A2nDRS5SHSciD5xe/vSNyCbVOpgiM=;
        b=Uufv28P/t1WWYYXs8AB8PnBQwXzLkRLBe+m13pp7rAxvvIz89VVLtNjAQyrtn+isv0
         cJx1eGwreA5G4sDjKK0NPONXo+c2hIPO+XoFz5c94kOgDd1A3VQj6apyBILUe18tcMoQ
         yvq5fhVXrUOHY2dWPNCNZpHEaUSxQ7JxOEtoMQ584G0jLZ7vYuCwT/Pw23zGfWVszfxG
         HlMWU2a7ZRRmsbSFtSmrsyivbLAzaWPrYqwkN/Jw6myxEi9KLEXUn635rdKQwzWw7dvN
         6+lF+ggVGfVSyjb6ebVcEJ0pkfXxvJtWI8/5ee7D0zGLcNvVpSrlqjcyf/n2nXcxypAY
         GQsA==
X-Gm-Message-State: AOAM533KEyug8NtXNO0YTkZPkEbpQJ0yvrMXnndfSs3ke90vJ0oIm/Xm
	12iQ6rf56/dyIPrh7rTqiYr892Rdolc8qqCChlZIeg==
X-Google-Smtp-Source: ABdhPJyb4ImADZGGck+kHesNSj6Ui9qvSibH0HIiBa+/aWOVcZ4UgqTWHbnXT8rqF5Q/JqWPZ1xh5xJ+I257RQnWy3E=
X-Received: by 2002:a17:906:af6d:: with SMTP id os13mr17964797ejb.57.1593526293291;
 Tue, 30 Jun 2020 07:11:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593486375.git.steve@sakoman.com> <7ee38d7f6eae1c938842ddcc3aae49e462569df3.1593486375.git.steve@sakoman.com>
 <CAM9ZRVsxxWeC5wGH0dZTTR0GPNbgP+--0nMFQ+j0_Uh-5nxCMw@mail.gmail.com>
In-Reply-To: <CAM9ZRVsxxWeC5wGH0dZTTR0GPNbgP+--0nMFQ+j0_Uh-5nxCMw@mail.gmail.com>
From: "Steve Sakoman" <steve@sakoman.com>
Date: Tue, 30 Jun 2020 04:11:21 -1000
Message-ID: <CAOSpxdZBznqGSrBrdJQMf+OAynRmy64+_2KadBd5f43RkBkvMw@mail.gmail.com>
Subject: Re: [bitbake-devel] [bitbake][dunfell][1.46][PATCH 1/6] taskdata: Improve handling of regex in ASSUME_PROVIDED
To: Paul Barker <pbarker@konsulko.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"

On Tue, Jun 30, 2020 at 3:27 AM Paul Barker <pbarker@konsulko.com> wrote:
>
> On Tue, 30 Jun 2020 at 04:08, Steve Sakoman <steve@sakoman.com> wrote:
> >
> > From: Richard Purdie <richard.purdie@linuxfoundation.org>
> >
> > ASSUME_PROVIDED can take regexs however the current way of handling
> > this in code is suboptimal. It means that you can add something like:
> >
> > DEPENDS += "texinfo-nativejunk-that-does-not-exist"
> >
> > and if texinfo-native is in ASSUME_PROVIDED, no error will occur.
> >
> > Update the code to only treat something as a regex if a start or end
> > anchor character is present (which wouldn't be valid in a recipe name).
> >
> > [YOCTO #13893]
> >
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > (cherry picked from commit 3d72e23109990970fbb1086923277af752168b4a)
> > Signed-off-by: Steve Sakoman <steve@sakoman.com>
> > ---
> >  lib/bb/taskdata.py | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/lib/bb/taskdata.py b/lib/bb/taskdata.py
> > index d13a1249..ffbaf362 100644
> > --- a/lib/bb/taskdata.py
> > +++ b/lib/bb/taskdata.py
> > @@ -21,8 +21,13 @@ def re_match_strings(target, strings):
> >      Whether or not the string 'target' matches
> >      any one string of the strings which can be regular expression string
> >      """
> > -    return any(name == target or re.match(name, target)
> > -               for name in strings)
> > +    for name in strings:
> > +        if name.startswith("^") or name.endswith("$"):
> > +            if re.match(name, target):
> > +                return True
> > +        elif name == target:
> > +            return True
> > +    return False
> >
> >  class TaskEntry:
> >      def __init__(self):
> > --
> > 2.17.1
>
> I'm not sure we should be changing how ASSUME_PROVIDED is parsed on a
> stable branch. If we do backport this we should at least issue a
> warning where the behaviour changes (i.e. if re.match(name, target) is
> true but name != target and name doesn't start with ^ or end with $).

I went back and forth on taking this patch since it is kind of a bug
fix. I decided to add it to the review list and see if anyone had
comments.

I'm inclined now to drop it since the bug condition is rare and it is
a behaviour change.

So I'll be removing it from the final pull request.

Thanks for reviewing the patch set, it is much appreciated.

Steve
