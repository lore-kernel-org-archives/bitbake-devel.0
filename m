Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
 by mx.groups.io with SMTP id smtpd.web09.10548.1612879900798979532
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Feb 2021 06:11:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=TjmVdwPf;
 spf=pass (domain: gmail.com, ip: 209.85.219.182, mailfrom: sakoman@gmail.com)
Received: by mail-yb1-f182.google.com with SMTP id k4so18296418ybp.6;
        Tue, 09 Feb 2021 06:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ObcJyBBJMKqlx81OijHxPFs3fphrH2Hcw/sEE6/WxaA=;
        b=TjmVdwPfXy8q164cVE0meuRrnRo1XiB8b1b+BXXbmsuTcxswFDdhySpuBXaNHnclT+
         1uHxwtY3wwl6w+Qy60O2RjAC0Gjhv2sNXtQwF7CMB6QSPSRjU8n+octyVUb+BeDKI94r
         IvxXGtsEYOuy0Chce/IxF/mFhFX8L+Z1aIEFXJm2zu3vT5wfcthD8yExX82qpsG2Hliz
         f0qXTfuvrDC4b6YR2wJNxA9MJKnjwyUF5qzKawfbUfgQ8fs3v1gHXqQZdWTYrVJ1eg3S
         CRUoSaNRF0a2gkrznRXCLmJN2+zkGB4U3Fjvfj7hO0ayseb+e0aVCEZK+qHZ4bRv5CiY
         T35Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ObcJyBBJMKqlx81OijHxPFs3fphrH2Hcw/sEE6/WxaA=;
        b=PwozWUbwLX6kSBwccj1m47/maMS/1SxMD4LYK7BrsNyJusApHrOoEnZBV9ybqs5Z5H
         Vi0XSzKY08FjFRe4AMKiUKXfnAFhuoFf0CsBKzMCXuZPfaisoFN6fgwgHsdZfdSnncun
         UuE1ZI7ch0UGukQZ8utJJDn+olM14FWzEbwCyV+Wu4D5lIsvXvTWTE4iKw968TU8M5ev
         mSiDXrjThKdi2jmbBz8jcPMsjJatkJyexjufqYrfk3fMZvqwbfmS7JfXbRy9D0fm4VL5
         Z/r6uuQetvmr5V0lr7FuD+ZRatAmNh/UOgGeCsc18Uq73y/yK501pzuU00jqKAoogLJz
         pF7g==
X-Gm-Message-State: AOAM532pmO1HQX6dZIzggQu/wwKevYnJ/PtJbmZReKb/842tGVY2uMv6
	IfnlxYcHFU25EyVebRKMrAuDNBsMWTKxLS2Kr9Y=
X-Google-Smtp-Source: ABdhPJwlelkpPrT2D0xOCiyHyi3YnSL5OYNWPbSF6CiMVczj2vKJVUE/y5IzKrSD+Y4AAB9QFDrEoe0xvyg8bz00Pdc=
X-Received: by 2002:a25:5557:: with SMTP id j84mr33333955ybb.472.1612879899944;
 Tue, 09 Feb 2021 06:11:39 -0800 (PST)
MIME-Version: 1.0
References: <17b543581ffb421b812323891405dcfb@XBOX03.axis.com>
 <CA+chaQc0anOg2E=o1ouEca-QJDGqKxDoXm6aPVXzsc8TELW3zA@mail.gmail.com>
 <d9185d19-1f09-a1b6-2926-f54309190b24@gmail.com> <16614BA6A53B3779.25597@lists.openembedded.org>
 <CA+chaQdbZwyBTbyctEh_y8x_p=txiwqy8gjmkwDrh6rqX_ztng@mail.gmail.com> <f190d3e175a9413994caf1c73a9f9125@XBOX03.axis.com>
In-Reply-To: <f190d3e175a9413994caf1c73a9f9125@XBOX03.axis.com>
From: "Steve Sakoman" <sakoman@gmail.com>
Date: Tue, 9 Feb 2021 04:11:26 -1000
Message-ID: <CAGDS+n=fBJad4LPWfpA3A-S3_aHfNKXbZQTpsaw56MtQ3miTRQ@mail.gmail.com>
Subject: Re: [oe] [bitbake-devel] Backport changes for _PYTHON_SYSCONFIGDATA_NAME to Gatesgarth and Dunfell
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Cc: Martin Jansa <martin.jansa@gmail.com>, akuster808 <akuster808@gmail.com>, 
	"Mittal, Anuj" <anuj.mittal@intel.com>, 
	"OE Core (openembedded-core@lists.openembedded.org)" <openembedded-core@lists.openembedded.org>, 
	"OE Development (openembedded-devel@lists.openembedded.org)" <openembedded-devel@lists.openembedded.org>, 
	"BitBake Development (bitbake-devel@lists.openembedded.org)" <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 8, 2021 at 1:45 PM Peter Kjellerstedt
<peter.kjellerstedt@axis.com> wrote:
>
> As agreed upon on the Yocto Project Technical Team Meeting a week ago, I=
 have created branches for both Gatesgarth and Dunfell in openembedded-core=
-contrib and meta-openembedded-contrib with the required patches. The branc=
hes are called pkj/_PYTHON_SYSCONFIGDATA_NAME-gatesgarth and pkj/_PYTHON_SY=
SCONFIGDATA_NAME-dunfell (ok, horrible names, but they should be easy to sp=
ot). There is one additional patch for bitbake, but I forgot to ask for acc=
ess to bitbake-contrib, so you will have to cherry-pick it from commit 47b6=
4cfa (it is not strictly necessary as it is just clean up made possible aft=
er the changes in OE-Core).
>
>
>
> @jansa, @akuster: I have included the two extra patches in meta-openembe=
dded that Martin mentioned, which were lacking from my original mail. There=
 were other patches mentioned, which fixed missing spaces related to the us=
e of _append. However, as they were not necessary (they changed other varia=
bles than DEPENDS for target), I did not include them.
>
>
>
> I have not done any excessive testing of these branches. I have verified=
 that I can run `devtool modify libxml2`, which I could not do before, and =
I have run `bitbake core-image-minimal`.

Thanks Peter!  I'll start testing with dunfell this morning.

Steve

> From: Martin Jansa <martin.jansa@gmail.com>
> Sent: den 7 februari 2021 12:15
> To: Martin Jansa <Martin.Jansa@gmail.com>
> Cc: akuster808 <akuster808@gmail.com>; Peter Kjellerstedt <peter.kjeller=
stedt@axis.com>; Steve Sakoman <steve@sakoman.com>; Mittal, Anuj <anuj.mitt=
al@intel.com>; OE Core (openembedded-core@lists.openembedded.org) <openembe=
dded-core@lists.openembedded.org>; OE Development (openembedded-devel@lists=
.openembedded.org) <openembedded-devel@lists.openembedded.org>; BitBake Dev=
elopment (bitbake-devel@lists.openembedded.org) <bitbake-devel@lists.openem=
bedded.org>
> Subject: Re: [oe] [bitbake-devel] Backport changes for _PYTHON_SYSCONFIG=
DATA_NAME to Gatesgarth and Dunfell
>
>
>
> On Sun, Feb 7, 2021 at 12:15 AM Martin Jansa via lists.openembedded.org =
<Martin.Jansa=3Dgmail.com@lists.openembedded.org> wrote:
>
> On Sat, Jan 16, 2021 at 6:52 PM akuster808 <akuster808@gmail.com> wrote:
>
>
>
> On 1/16/21 9:44 AM, Martin Jansa wrote:
> > Aren't the missing spaces in appends fixes also needed for meta-oe
> > recipes?
>
>
> >
> > I think at least top 5 commits from:
> > https://git.openembedded.org/meta-openembedded/log/?qt=3Dgrep&q=3Dspac=
e.*append
> > were also follow-up from these changes in oe-core.
> >
> Do you mean something beyond the meta-openembedded commits mentioned
> near the bottom of the email?
>
>
>
> Yes I mean these 5 commits at least.
>
>
>
> 50bbf80abf python3-pykwalify: Do not unset _PYTHON_SYSCONFIGDATA_NAME
>
> 6b3e3bdaf8 python-grpcio-tools: Add missing space for append
>
>
>
> The first one is just an additional cleanup, but without the 2nd one and=
 with the cherry-picks from the first e-mail applied you would get:
>
> ERROR: Nothing PROVIDES 'python3python3-grpcio' (but meta-oe/meta-python=
/recipes-devtools/python/python3-grpcio-tools_1.14.1.bb DEPENDS on or other=
wise requires it). Close matches:
>   python-grpcio
>   python3-grpcio
>
>
>
> my world build is still running..
>
>
>
>
>
> with c99bb790 DEPENDS variable doesn't end with a space, so the missing =
leading space in these appends (which was fine until now because of trailin=
g space from DEPENDS set in bbclass) is now causing wrong dependency (shoul=
d be easily reproducible with the patches backported, just by parsing the r=
ecipes).
>
>
>
> I need clarity so I can open an issue in gitlab for tracking purposes as
> I am sure I will forget this
>
>
>
> we're using gitlab?
>
>
>
>=20
>
