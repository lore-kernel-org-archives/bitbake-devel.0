Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
 by mx.groups.io with SMTP id smtpd.web10.8267.1610822365539148549
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 16 Jan 2021 10:39:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=brRUKjc2;
 spf=pass (domain: gmail.com, ip: 209.85.221.181, mailfrom: alex.kanavin@gmail.com)
Received: by mail-vk1-f181.google.com with SMTP id v3so3031655vkb.1;
        Sat, 16 Jan 2021 10:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BABn3IcU8d8MAlGC5aou48CKdnzyiXxjRLKUOJgrFqk=;
        b=brRUKjc23fhg0vnRniXXeQtrjvMsXRu/+N2ACtz8CIYs3f7K5a09vqBTYMy+TwXlu6
         oJUeLfbdZ8Tn/Jt91cOoUshnadXEC4g106C5kI8RQKmMv2zNA9vmlgV9WySVWrsmpMeS
         FyEejLfynXpZDFbrzsyj/UXc51B0PTtNA+Rt/vSTP8m7IXyM/xXwdQ9Kh0r4UOon9r3x
         qaX8pFSTMW0aksdmQyYNGZ/QO4m4NmZKrENY+3cfw4BbffnnlHuQCvnspIce3OwTPTe/
         BLiHcZoK9CLYMwROxqVyNVLFy0yh+S86DAGbVLbM2F7Y9Yh0emo/EH3SRXD8GTkeqizR
         nKeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BABn3IcU8d8MAlGC5aou48CKdnzyiXxjRLKUOJgrFqk=;
        b=YKk8qOkJuovVcfK6rs3WkN4Rh6zhA1Xl61Ab3/Onyv3xTsROvUnP1FoEzf9oywvH4K
         jvWMM9tmgo7r7ofZjbZoe30i1SDHl0wQgrLUxG1q7OA56NsNXE5IODLurTeT25Y34pAh
         pYGqad1bsYvbDpdGLz+4IIay2XlsycUUX4dqHDfW6nLh621t+2jjuZV4/8c1DYcwLoIl
         N068A1JEUJL4NsC/IdWmQ4T0d1LzuDtBfHYfq0UKAqm0yjMl317t4o4FQvZ5s4vWQXcA
         owH1MCJvKP9ooO5p7uKPBICHFbJzbpOVr//rJvRGPpIqzInWOIOy861/IGsJY57RR09u
         qoXw==
X-Gm-Message-State: AOAM532v7KoUNgZ/LBPbqTZa48gAd+0AayvKAs5f80b348rJVAhvKgOW
	rFS6AojqPBnFa0wfn28wiVYodMWO7MrPkUg6WAo=
X-Google-Smtp-Source: ABdhPJynMpRW/zWoryLKCyY7p90bg3vGJFN1VJvpZ6C1hYxcO/01zgJ0F6ME6C/jqbHbd8OzeGRuGi5zJQMcAuCZ3Gw=
X-Received: by 2002:a1f:9c42:: with SMTP id f63mr14765392vke.10.1610822364609;
 Sat, 16 Jan 2021 10:39:24 -0800 (PST)
MIME-Version: 1.0
References: <17b543581ffb421b812323891405dcfb@XBOX03.axis.com>
In-Reply-To: <17b543581ffb421b812323891405dcfb@XBOX03.axis.com>
From: "Alexander Kanavin" <alex.kanavin@gmail.com>
Date: Sat, 16 Jan 2021 19:39:13 +0100
Message-ID: <CANNYZj8pP+ikBs4WrfbA3CktvGvR7iwM9FPmbg4M9aB9b6zFpw@mail.gmail.com>
Subject: Re: [bitbake-devel] Backport changes for _PYTHON_SYSCONFIGDATA_NAME to Gatesgarth and Dunfell
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Cc: Steve Sakoman <steve@sakoman.com>, "Mittal, Anuj" <anuj.mittal@intel.com>, 
	Armin Kuster <akuster808@gmail.com>, 
	"OE Core (openembedded-core@lists.openembedded.org)" <openembedded-core@lists.openembedded.org>, 
	"OE Development (openembedded-devel@lists.openembedded.org)" <openembedded-devel@lists.openembedded.org>, 
	"BitBake Development (bitbake-devel@lists.openembedded.org)" <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="000000000000d6c33a05b908ce28"

--000000000000d6c33a05b908ce28
Content-Type: text/plain; charset="UTF-8"

I fully support this.

Alex

On Thu, 14 Jan 2021 at 18:50, Peter Kjellerstedt <
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

--000000000000d6c33a05b908ce28
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I fully support this.</div><div><br></div><div>Alex<b=
r></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmai=
l_attr">On Thu, 14 Jan 2021 at 18:50, Peter Kjellerstedt &lt;<a href=3D"mai=
lto:peter.kjellerstedt@axis.com">peter.kjellerstedt@axis.com</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">[ Cross-posting=
 since these changes affect all of bitbake, openembedded-core <br>
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

--000000000000d6c33a05b908ce28--
