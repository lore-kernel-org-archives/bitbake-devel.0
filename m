Received: from mail-yb1-f194.google.com (mail-yb1-f194.google.com [209.85.219.194])
 by mx.groups.io with SMTP id smtpd.web11.3266.1607549236348529964
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 09 Dec 2020 13:27:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=zt5jD0OP;
 spf=pass (domain: linaro.org, ip: 209.85.219.194, mailfrom: nicolas.dechesne@linaro.org)
Received: by mail-yb1-f194.google.com with SMTP id g15so2690879ybq.6
        for <bitbake-devel@lists.openembedded.org>; Wed, 09 Dec 2020 13:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ucHsxGFtkChtyrqyqyKi74NBeSqVsG5KRlFPpIuRMpk=;
        b=zt5jD0OPuRRvd2XfFngwETF3GG9JnIBbRdBWbxkSAPft5VnrZX/IJ9hCOzRdDziFHT
         GVcYXqvaRw7ccfrDry7MeAXAwYY1PFRP1yw5JQ8bXSJFxqAzzC7jGpgGBK1udYhyEvPW
         +vZ+74pYSb9AeJEM42nKuZ831Tm1Q/lnL8m7ie5JjCa81Hf+y5ZrwlstE7cZRVGqmyo7
         W+2aOJ3xLF4AB1GKRjzSeB6Mnku2poJKu8w8y/pQKyZqF/B2/tnUk1DGBVNASPONHF92
         nCGfF0XWq+tiiRsVe/Bll2R/+1Q7DLuSD28xmmy9TUpzjd1GVhHA+3z7ZdZhl6XyqnVv
         y6Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ucHsxGFtkChtyrqyqyKi74NBeSqVsG5KRlFPpIuRMpk=;
        b=DxtnnmFPnFxOzCbd2YWV9XrZhQUg5Jmak+AzZ48TrdCe/CXDmjbo4PrsOx4ok4e2/b
         AP+r+VP3uqFI35fOLjGyQ9VnqKe4nN6Iz4HjDAZR60/5cT1hKYvaaY/WB5AnzeYaOBfK
         6A1Na4DUN+vty8+SGKd7NTUtaWgww/FT8bgkfYaFxQi44WDKw1pVSragvwwEwcEHIdJ+
         zNWQ8hzwm/7R4plnHtL5izzzrNv6NfBnsBDl3nJrcu6mlxBTbTg3AeasfOq9YbA1hEE2
         XOXybGI/wP+xXX0MWVX7sCBcc09Rtcny2N3IKI348m/psxd9BF7QCQKopKzOGQNbkT5x
         pqXQ==
X-Gm-Message-State: AOAM5320MKSQ14Zu00IbOK41W8oWT6caVy2BjttoH+/fKzKilNOjlnZf
	JmbxZaMPND/ZkcWhVP8QWauhwEKl4I+q6sHs3QLLHw==
X-Google-Smtp-Source: ABdhPJyaARR4JikBzHgXeu35i4kfnAOf3MgcFyMpOxuGLAQFaYzbWQ4KHyBo2Xkn4Dwd2P3nO25frFYKgsE2AbOAbcQ=
X-Received: by 2002:a25:318b:: with SMTP id x133mr6550445ybx.201.1607549235468;
 Wed, 09 Dec 2020 13:27:15 -0800 (PST)
MIME-Version: 1.0
References: <20201202195810.20800-1-JPEWhacker@gmail.com> <CAP71Wjx9bCo++6ppp925_vd9fDZZ+N9DgJKuMcE_oK9Oi6LLmQ@mail.gmail.com>
 <CAJdd5GbYyutt9yF-Cyg9NoZP52vaOErtLSqm4G0Pwj529THJQw@mail.gmail.com>
In-Reply-To: <CAJdd5GbYyutt9yF-Cyg9NoZP52vaOErtLSqm4G0Pwj529THJQw@mail.gmail.com>
From: "Nicolas Dechesne" <nicolas.dechesne@linaro.org>
Date: Wed, 9 Dec 2020 22:27:04 +0100
Message-ID: <CAP71WjzJDySCjhy-qA8enN=_Wx6oOwjgvw95tH=3ASPbjcdrFQ@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH] hashserv: client: Fix AF_UNIX path length limits
To: Joshua Watt <jpewhacker@gmail.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>, Anuj Mittal <anuj.mittal@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, Dec 9, 2020 at 10:11 PM Joshua Watt <jpewhacker@gmail.com> wrote:
>
> On Wed, Dec 9, 2020 at 3:04 PM Nicolas Dechesne
> <nicolas.dechesne@linaro.org> wrote:
> >
> > hi Joshua,
> >
> >
> > On Wed, Dec 2, 2020 at 8:58 PM Joshua Watt <JPEWhacker@gmail.com> wrote:
> > >
> > > Restores a fix for unix domain socket path length limits when using the
> > > synchronous hash equivalence client that was accidentally removed when
> > > the async client was added.
> > >
> > > Unfortunately, it's much more difficult to fix the same problem when
> > > using the async client directly due to the interaction of chdir() and
> > > async code, but this will at least restore the old behavior in the
> > > synchronous case.
> > >
> > > Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> >
> > the meta-qcom CI started failing.. and I have the feeling this is
> > because of this change. I am now seeing many errors, and this:
> > 00:02:31.320 OSError: AF_UNIX path too long
> >
> > Here is the link to the full Jenkins log:
> > https://ci.linaro.org/job/lt-qcom-openembedded-meta-qcom-master-premerge/136/MACHINE=dragonboard-410c,TCLIBC=glibc,label=docker-buster-amd64/console
> >
> > This is a test build we do for each Github PR. This build is using
> > this commit from Poky/master:
> > 982688103619 (build-appliance-image: Update to master head revision)
> >
> > We tested another PR 2 days ago, and it went fine:
> > https://ci.linaro.org/job/lt-qcom-openembedded-meta-qcom-master-premerge/134/MACHINE=dragonboard-410c,TCLIBC=glibc,label=docker-buster-amd64/consoleFull
> > This build was based on this commit:
> > 982688103619 (build-appliance-image: Update to master head revision)
> >
> > Looking at the error log, and this commit, it looks related to me..
> > though I am not sure I understand the details ;)
>
> Argh, this is because I was silly and the fix is outright wrong. Sorry
> about that, I'll fix it quick (and maybe add a test this time!)

ah, cool! well, the self claim about being silly ;) but it's good we
found it so quickly! I was starting to worry about something wrong in
our infrastructure!
if you need me to run a test, let me know, I can run our CI with your
patch applied..

>
> >
> > > ---
> > >  bitbake/lib/hashserv/client.py | 15 ++++++++++++---
> > >  1 file changed, 12 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/bitbake/lib/hashserv/client.py b/bitbake/lib/hashserv/client.py
> > > index ae5875d1b3..7bbf0865d5 100644
> > > --- a/bitbake/lib/hashserv/client.py
> > > +++ b/bitbake/lib/hashserv/client.py
> > > @@ -40,7 +40,7 @@ class AsyncClient(object):
> > >
> > >          self._connect_sock = connect_sock
> > >
> > > -    async def _connect(self):
> > > +    async def connect(self):
> > >          if self.reader is None or self.writer is None:
> > >              (self.reader, self.writer) = await self._connect_sock()
> > >
> > > @@ -62,7 +62,7 @@ class AsyncClient(object):
> > >          count = 0
> > >          while True:
> > >              try:
> > > -                await self._connect()
> > > +                await self.connect()
> > >                  return await proc()
> > >              except (
> > >                  OSError,
> > > @@ -190,7 +190,6 @@ class Client(object):
> > >
> > >          for call in (
> > >              "connect_tcp",
> > > -            "connect_unix",
> > >              "close",
> > >              "get_unihash",
> > >              "report_unihash",
> > > @@ -209,6 +208,16 @@ class Client(object):
> > >
> > >          return wrapper
> > >
> > > +    def connect_unix(self, path):
> > > +        # AF_UNIX has path length issues so chdir here to workaround
> > > +        cwd = os.getcwd()
> > > +        try:
> > > +            os.chdir(os.path.dirname(path))
> > > +            self.loop.run_until_complete(self.client.connect_unix(path))
> > > +            self.loop.run_until_complete(self.client.connect())
> > > +        finally:
> > > +            os.chdir(cwd)
> > > +
> > >      @property
> > >      def max_chunk(self):
> > >          return self.client.max_chunk
> > > --
> > > 2.29.2
> > >
> > >
> > > 
> > >
