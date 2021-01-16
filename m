Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
 by mx.groups.io with SMTP id smtpd.web09.7317.1610819076202394309
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 16 Jan 2021 09:44:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=QNLnpIWv;
 spf=pass (domain: gmail.com, ip: 209.85.218.53, mailfrom: martin.jansa@gmail.com)
Received: by mail-ej1-f53.google.com with SMTP id l9so12151232ejx.3;
        Sat, 16 Jan 2021 09:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8iU+ufHHyPSENGTa9HZFTXWeJirjmXY7vfAwSLg1uh8=;
        b=QNLnpIWvsfx5wE9Db0h2OCTTGEjqZUcJP1Ob2Xc5LAj/smDeKk6Iyzo6j3Trs7mwas
         vgp/amdkPt3Q2TZGehqVob19Ic3xgghibYaVMdUEQF+/FXdCgUMobEmVEMYZhJNUTUfJ
         /sO7/j54cnIeisWJpcx/SAmlIk6vK6y67qHCiS8L6HtcDrNPM6gbcyDL4rCBtxhIz1fO
         ev8+DMnpaKhFWRGooxh9JB0pLJAFWi6KJC1cAUB7BhpTpsXL+a8zg2xVYrd3CKi5310g
         UvVzdD0AAnJTRpcW2rMmDTvOH+agR95qpe07wzx+GMxaO1llpowlkC35NiyJJgbmAY53
         /Hcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8iU+ufHHyPSENGTa9HZFTXWeJirjmXY7vfAwSLg1uh8=;
        b=phK1LloczMs/V6xRwUgx6fyqkEp1tM1AsOylGE/THvlfLvfW2kTaOVIUo8Xl6hN6Sq
         S24/NAskMU1w329m3UxBtG0/NIgMFf82jI0KrRq1u6Jw8P5/TvAWFj3agzV9m+rIy+Wa
         CKNAhm8XH+3xQGibXT5KKSWiiYrWSYFjPapHXLjADnE28gEfuD/L549U22X9YO4pKVmj
         XnnAovPcUAkyhgZNSdwRkU2Oz/J4FUNRaXGMm7kC/bqbd34LfBfk4Sxp3NnsC+mzuoX8
         q7sS9EXkRhcS9nOqZblEIMPcxSrqO6HjUQISEQugjNngU4kCrGm1rqKrBmkUSlnzih/+
         p2wg==
X-Gm-Message-State: AOAM531aYuEYXahgZg9GNTqX/sX86WAyCfAzvACdVNd9PKJbNJOPdEpK
	MY36uwap5QlDgkcdvXKJtN3eP+HOt3FyZGdKZEE=
X-Google-Smtp-Source: ABdhPJw1LI5YFET8O702Oy2yJnOJoY9TnMdtffSHr9GaRkTPWDOqXtXKyPHSwCubm4unnHGAOTG65qomTjn7V/79rzY=
X-Received: by 2002:a17:906:94d2:: with SMTP id d18mr12513976ejy.94.1610819074603;
 Sat, 16 Jan 2021 09:44:34 -0800 (PST)
MIME-Version: 1.0
References: <17b543581ffb421b812323891405dcfb@XBOX03.axis.com>
In-Reply-To: <17b543581ffb421b812323891405dcfb@XBOX03.axis.com>
From: "Martin Jansa" <Martin.Jansa@gmail.com>
Date: Sat, 16 Jan 2021 18:44:23 +0100
Message-ID: <CA+chaQc0anOg2E=o1ouEca-QJDGqKxDoXm6aPVXzsc8TELW3zA@mail.gmail.com>
Subject: Re: [bitbake-devel] Backport changes for _PYTHON_SYSCONFIGDATA_NAME to Gatesgarth and Dunfell
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Cc: Steve Sakoman <steve@sakoman.com>, "Mittal, Anuj" <anuj.mittal@intel.com>, 
	Armin Kuster <akuster808@gmail.com>, 
	"OE Core (openembedded-core@lists.openembedded.org)" <openembedded-core@lists.openembedded.org>, 
	"OE Development (openembedded-devel@lists.openembedded.org)" <openembedded-devel@lists.openembedded.org>, 
	"BitBake Development (bitbake-devel@lists.openembedded.org)" <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="000000000000bd3c6d05b9080acb"

--000000000000bd3c6d05b9080acb
Content-Type: text/plain; charset="UTF-8"

Aren't the missing spaces in appends fixes also needed for meta-oe recipes?

I think at least top 5 commits from:
https://git.openembedded.org/meta-openembedded/log/?qt=grep&q=space.*append
were also follow-up from these changes in oe-core.

On Thu, Jan 14, 2021 at 6:50 PM Peter Kjellerstedt <
peter.kjellerstedt@axis.com> wrote:

> [ Cross-posting since these changes affect all of bitbake,
> openembedded-core
>   and meta-openembedded and need to be made (at least somewhat) in sync. ]
>
> Can the solution for _PYTHON_SYSCONFIGDATA_NAME please be backported to
> Gatesgarth and Dunfell? We are seeing problems for developers who have
> updated the python3 version on their hosts when they try to do devtool
> modify on recipes that inherit python3native. The following relevant
> changes should cherry-pick cleanly to the respective repositories for
> both gatesgarth and dunfell:
>
> openembedded-core:
> 5a118d4e python3: split python target configuration into own class
> dadf001c python3-pycairo: use python3targetconfig
> 9c8f6660 distutils3-base.bbclass: use python3targetconfig
> d3a81dd0 meta: drop _PYTHON_SYSCONFIGDATA_NAME hacks
> 38ecb83c gpgme: use python3targetconfig
> c99bb790 python3targetconfig.bbclass: Make py3 dep and tasks only for
> target recipes
>
> bitbake:
> 47b64cfa lib/bb/fetch2/__init__.py: drop _PYTHON_SYSCONFIGDATA_NAME
> unsetting
>
> meta-openembedded:
> a06cdf5a gedit: Inherit python3targetconfig
> 59f817bb openipmi: Inherit python3targetconfig
> be7d2286 libplist: Inherit python3targetconfig
> c499aaee postgresql: Inherit python3targetconfig
>
> I guess there may be some controversy regarding whether these changes
> should
> be backported to the stable branches since they modify what python3native
> does and may require existing recipes to be modified to inherit the new
> python3targetconfig class. However, I believe that having devtool modify
> fail on random recipes without an easy solution for the user is much worse
> than having to update a recipe or two once due to a build failure after
> upgrading to a new version of OE-Core (in my book that is pretty normal
> and
> something I always have to do anyway when we update OE-Core). And based on
> the number of recipes in openembedded-core and meta-openembedded that
> needed
> to be updated (2+4), I do not expect there to be many other recipes in the
> first place that actually need to be updated.
>
> //Peter
>
>
> 
>
>

--000000000000bd3c6d05b9080acb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Aren&#39;t the missing spaces in appends fixes also needed=
 for meta-oe recipes?<div><br></div><div>I think at least top 5 commits fro=
m:</div><div><a href=3D"https://git.openembedded.org/meta-openembedded/log/=
?qt=3Dgrep&amp;q=3Dspace.*append">https://git.openembedded.org/meta-openemb=
edded/log/?qt=3Dgrep&amp;q=3Dspace.*append</a><br></div><div>were also foll=
ow-up from these changes in oe-core.</div></div><br><div class=3D"gmail_quo=
te"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jan 14, 2021 at 6:50 PM P=
eter Kjellerstedt &lt;<a href=3D"mailto:peter.kjellerstedt@axis.com">peter.=
kjellerstedt@axis.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">[ Cross-posting since these changes affect all of bitb=
ake, openembedded-core <br>
=C2=A0 and meta-openembedded and need to be made (at least somewhat) in sy=
nc. ]<br>
<br>
Can the solution for _PYTHON_SYSCONFIGDATA_NAME please be backported to <b=
r>
Gatesgarth and Dunfell? We are seeing problems for developers who have <br=
>
updated the python3 version on their hosts when they try to do devtool <br=
>
modify on recipes that inherit python3native. The following relevant <br>
changes should cherry-pick cleanly to the respective repositories for <br>
both gatesgarth and dunfell:<br>
<br>
openembedded-core:<br>
5a118d4e python3: split python target configuration into own class<br>
dadf001c python3-pycairo: use python3targetconfig<br>
9c8f6660 distutils3-base.bbclass: use python3targetconfig<br>
d3a81dd0 meta: drop _PYTHON_SYSCONFIGDATA_NAME hacks<br>
38ecb83c gpgme: use python3targetconfig<br>
c99bb790 python3targetconfig.bbclass: Make py3 dep and tasks only for targ=
et recipes<br>
<br>
bitbake:<br>
47b64cfa lib/bb/fetch2/__init__.py: drop _PYTHON_SYSCONFIGDATA_NAME unsett=
ing<br>
<br>
meta-openembedded:<br>
a06cdf5a gedit: Inherit python3targetconfig<br>
59f817bb openipmi: Inherit python3targetconfig<br>
be7d2286 libplist: Inherit python3targetconfig<br>
c499aaee postgresql: Inherit python3targetconfig<br>
<br>
I guess there may be some controversy regarding whether these changes shou=
ld <br>
be backported to the stable branches since they modify what python3native =
<br>
does and may require existing recipes to be modified to inherit the new <b=
r>
python3targetconfig class. However, I believe that having devtool modify <=
br>
fail on random recipes without an easy solution for the user is much worse=
 <br>
than having to update a recipe or two once due to a build failure after <b=
r>
upgrading to a new version of OE-Core (in my book that is pretty normal an=
d <br>
something I always have to do anyway when we update OE-Core). And based on=
 <br>
the number of recipes in openembedded-core and meta-openembedded that need=
ed <br>
to be updated (2+4), I do not expect there to be many other recipes in the=
 <br>
first place that actually need to be updated.<br>
<br>
//Peter<br>
<br>
<br>
<br>
<br>
</blockquote></div>

--000000000000bd3c6d05b9080acb--
