Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
 by mx.groups.io with SMTP id smtpd.web10.2901.1607548266266362585
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 09 Dec 2020 13:11:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=T2cBFOPw;
 spf=pass (domain: gmail.com, ip: 209.85.221.67, mailfrom: jpewhacker@gmail.com)
Received: by mail-wr1-f67.google.com with SMTP id x6so3249940wro.11
        for <bitbake-devel@lists.openembedded.org>; Wed, 09 Dec 2020 13:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=porrgcpiIj97PhUt5TgxEjWzsjWNXf/PcIe5y3N7tAI=;
        b=T2cBFOPwmN9fjodBkgKSOq+7+nRvhZN4MDYfXbZFM0UTAM1mIzBDEYIazY0ryT46Um
         GuPNV973fbiwBOHbvsKvjUr0OmMgVWA5etTzoQAlu3gip1mXbwnS3Utp0CUTVEEkybIZ
         r1dDx8QaykRcsTwtCd73JKML4L/aAEX7V4fGCMCNIxgClnkmDqdZ3zfzsKFOIXE7l+k/
         GVAX4FAX1R5vfrBRwKuxTTXngXfz29lMIifqCb5VdCKRN/2/vs4HnX2BFdCwcSe05K6e
         ZinQdLu8kjfrGDz5yVwCD1wc+YW9yGlvdNc4t3Du5vGNGg7Or058W6TbhZ3BJhCalLTb
         Fx4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=porrgcpiIj97PhUt5TgxEjWzsjWNXf/PcIe5y3N7tAI=;
        b=N/pYB/tTMrsbSYNcO3TZog6Emt5S/AgvRWr6oOkPGV3LgmihK9o5zAsjqzQSvUJ5xy
         iKBPhlag8lxbhBxUgo+KtsRoruugg7Qw13Ws29ZgOtiwwg1/ziXpLxZYwahTUp1ocqNV
         8I3IhbKy4rCavCQzcH/BiBM2zWFO2mLP7kd891WqSms2H5Iu+ZRxYJ013t/08xb4tloL
         lGX4QdMEbraA2loREaR0SRuNyIxoCwI6MBSvOgW00la+2HxTvHiR6oJFvgZjsxQOdk0N
         bkAdluGZOa2OmuNf6bRq01vHbHvdIrRI8zsnFEEKYIkPFAdoyfwtl1zikACJ1yTzrrJ9
         a1OA==
X-Gm-Message-State: AOAM533luotsFewBd5XLxhIZLIlHcEQ2DkvK6lZEIIH2NEbYMyk33xFw
	c+RhgHhi3dpbVJuMEum19HDEux9LDwdq7m6lWhk=
X-Google-Smtp-Source: ABdhPJxwR1KYgafdLGaOeH9tG4HXDWWnzFj3Zv0MUb8WNLw4ysq1fbpfmgjhGVLfZYcZTRlKmIAmaQrv93v02RAHQRU=
X-Received: by 2002:adf:c986:: with SMTP id f6mr4897467wrh.361.1607548264614;
 Wed, 09 Dec 2020 13:11:04 -0800 (PST)
MIME-Version: 1.0
References: <20201202195810.20800-1-JPEWhacker@gmail.com> <CAP71Wjx9bCo++6ppp925_vd9fDZZ+N9DgJKuMcE_oK9Oi6LLmQ@mail.gmail.com>
In-Reply-To: <CAP71Wjx9bCo++6ppp925_vd9fDZZ+N9DgJKuMcE_oK9Oi6LLmQ@mail.gmail.com>
From: "Joshua Watt" <JPEWhacker@gmail.com>
Date: Wed, 9 Dec 2020 15:10:53 -0600
Message-ID: <CAJdd5GbYyutt9yF-Cyg9NoZP52vaOErtLSqm4G0Pwj529THJQw@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH] hashserv: client: Fix AF_UNIX path length limits
To: Nicolas Dechesne <nicolas.dechesne@linaro.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>, Anuj Mittal <anuj.mittal@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, Dec 9, 2020 at 3:04 PM Nicolas Dechesne
<nicolas.dechesne@linaro.org> wrote:
>
> hi Joshua,
>
>
> On Wed, Dec 2, 2020 at 8:58 PM Joshua Watt <JPEWhacker@gmail.com> wrote:
> >
> > Restores a fix for unix domain socket path length limits when using the
> > synchronous hash equivalence client that was accidentally removed when
> > the async client was added.
> >
> > Unfortunately, it's much more difficult to fix the same problem when
> > using the async client directly due to the interaction of chdir() and
> > async code, but this will at least restore the old behavior in the
> > synchronous case.
> >
> > Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
>
> the meta-qcom CI started failing.. and I have the feeling this is
> because of this change. I am now seeing many errors, and this:
> 00:02:31.320 OSError: AF_UNIX path too long
>
> Here is the link to the full Jenkins log:
> https://ci.linaro.org/job/lt-qcom-openembedded-meta-qcom-master-premerge/136/MACHINE=dragonboard-410c,TCLIBC=glibc,label=docker-buster-amd64/console
>
> This is a test build we do for each Github PR. This build is using
> this commit from Poky/master:
> 982688103619 (build-appliance-image: Update to master head revision)
>
> We tested another PR 2 days ago, and it went fine:
> https://ci.linaro.org/job/lt-qcom-openembedded-meta-qcom-master-premerge/134/MACHINE=dragonboard-410c,TCLIBC=glibc,label=docker-buster-amd64/consoleFull
> This build was based on this commit:
> 982688103619 (build-appliance-image: Update to master head revision)
>
> Looking at the error log, and this commit, it looks related to me..
> though I am not sure I understand the details ;)

Argh, this is because I was silly and the fix is outright wrong. Sorry
about that, I'll fix it quick (and maybe add a test this time!)

>
> > ---
> >  bitbake/lib/hashserv/client.py | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> >
> > diff --git a/bitbake/lib/hashserv/client.py b/bitbake/lib/hashserv/client.py
> > index ae5875d1b3..7bbf0865d5 100644
> > --- a/bitbake/lib/hashserv/client.py
> > +++ b/bitbake/lib/hashserv/client.py
> > @@ -40,7 +40,7 @@ class AsyncClient(object):
> >
> >          self._connect_sock = connect_sock
> >
> > -    async def _connect(self):
> > +    async def connect(self):
> >          if self.reader is None or self.writer is None:
> >              (self.reader, self.writer) = await self._connect_sock()
> >
> > @@ -62,7 +62,7 @@ class AsyncClient(object):
> >          count = 0
> >          while True:
> >              try:
> > -                await self._connect()
> > +                await self.connect()
> >                  return await proc()
> >              except (
> >                  OSError,
> > @@ -190,7 +190,6 @@ class Client(object):
> >
> >          for call in (
> >              "connect_tcp",
> > -            "connect_unix",
> >              "close",
> >              "get_unihash",
> >              "report_unihash",
> > @@ -209,6 +208,16 @@ class Client(object):
> >
> >          return wrapper
> >
> > +    def connect_unix(self, path):
> > +        # AF_UNIX has path length issues so chdir here to workaround
> > +        cwd = os.getcwd()
> > +        try:
> > +            os.chdir(os.path.dirname(path))
> > +            self.loop.run_until_complete(self.client.connect_unix(path))
> > +            self.loop.run_until_complete(self.client.connect())
> > +        finally:
> > +            os.chdir(cwd)
> > +
> >      @property
> >      def max_chunk(self):
> >          return self.client.max_chunk
> > --
> > 2.29.2
> >
> >
> > 
> >
