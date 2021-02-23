Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
 by mx.groups.io with SMTP id smtpd.web08.15.1614101416369945403
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 23 Feb 2021 09:30:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=dwJ/HprA;
 spf=pass (domain: gmail.com, ip: 209.85.208.52, mailfrom: kergoth@gmail.com)
Received: by mail-ed1-f52.google.com with SMTP id d2so26733198edq.10
        for <bitbake-devel@lists.openembedded.org>; Tue, 23 Feb 2021 09:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M+2ed8H8DPTGAAgcurUsSrvJct2F5ELAgyIBMj4I5j4=;
        b=dwJ/HprAKWZwJ1VpDL5WYyBrJuqzfL8nSC5CjXSfI8f74+9+u59ektQjcJAu21LBPT
         kUWQEdkqf4SMdXZiNwkNv50Cbxn9ZxOquYYn/FVHRXcrrd/KRSnkI2BXmIs4CfwQ6nSC
         FcKt/wTBUgvyUkDDpF+u+RfBu+OHLchcCnkg9WNmj4qnCT4M4qC5Y+KMaD+CMjTl1If/
         VwB4b+QS/0vwiPn095HBurdeAriLv9z9xTbfNLNaIPDG5m784k24wNLrtjhgyTFzo5uk
         uOv1EXPPdSoi6VPAQyKv0rpmwsWZf7A/bb+Ql4X7JRckra4WKULJSkKaHzxfMaCO1u7w
         LW+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M+2ed8H8DPTGAAgcurUsSrvJct2F5ELAgyIBMj4I5j4=;
        b=Z3OA5V1neRkmM1+01eqxeT6MPTabWRyzzw0hz97riSJCxlzsgUh85+toweLAcZliTr
         yrWv3E+0AyF2INKnKP94IZ6VfHj5cTC2FhWy6f0sEBYr6UCzZzrdo3+8o8SSwIIv/rJu
         iZHFNoMmnS/Nn2Yl+FfsV6c4f5N1VD7cYL24PBL67zyA42BEDFrChw7yrEP7l0sErZgu
         l3p06pP1ucZBrKz91XOfAbPxWGzIyourEZ92nsDvVmwyJUSGKoD+kavK8XF/hnXB7bNS
         CjG9Rw9RKg4V0ZCZyUoaS/21SEVLMZGb2qtiQY079UQ1mRRl+jwCTW83kfm2iTFB/LAF
         /CBg==
X-Gm-Message-State: AOAM532GKkFoJ2MXomiRlmWx082gpi9jY50tIbZs6aYfA2GSIKVga/C3
	2lIm0lcKcMBNr7Spt7jeOaLoXKkO2SgDVFNPvFM=
X-Google-Smtp-Source: ABdhPJznVjyCux3yNWW0yzNNKg32KxphCmqpCjSKm2eoELrbLcCDEPOXNG+z89pmqeREoN7zqexAmhLlwTJCc6bcZIw=
X-Received: by 2002:aa7:de8f:: with SMTP id j15mr29704517edv.268.1614101414787;
 Tue, 23 Feb 2021 09:30:14 -0800 (PST)
MIME-Version: 1.0
References: <CAC9ffDEuZL-k8199bUyN+8frjw6bg-g=vrumxxtvt+RVParQ8Q@mail.gmail.com>
In-Reply-To: <CAC9ffDEuZL-k8199bUyN+8frjw6bg-g=vrumxxtvt+RVParQ8Q@mail.gmail.com>
From: "Christopher Larson" <kergoth@gmail.com>
Date: Tue, 23 Feb 2021 10:30:03 -0700
Message-ID: <CABcZANmg95WWFgS9Ddjsh-sWzbOEaBhtcJ3QzezFZhndJvN5uQ@mail.gmail.com>
Subject: Re: [bitbake-devel] HTTP basic auth handling in wget.py and redirects
To: Christian Betz <christian.betz@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="00000000000075bfa105bc044557"

--00000000000075bfa105bc044557
Content-Type: text/plain; charset="UTF-8"

I would suggest a url parameter to control whether the auth is passed to
the redirects, then it's isolated to a single uri without needing a new url
scheme.

On Tue, Feb 23, 2021 at 10:25 AM Christian Betz <christian.betz@gmail.com>
wrote:

> hi everyone,
>
> handling of user/pass (HTTP basic auth) in wget.py currently works like
> this, by adding params to the wget CLI:
>
>  fetchcmd += " --user=%s --password=%s --auth-no-challenge" % (ud.user,
> ud.pswd)
>
> my SRC_URI is something like "
> https://someuser:somepassword@bitbucket.org/...".
>
> in this case we are authing against the bitbucket API using the
> username/password. the initial request to bitbucket.org works fine.
>
> however the actual download was failing due a redirect being followed to
> what looks like a temporary, AWS-signed URL. AWS *rejects* the basic auth
> and refuses the download.
>
> i discovered that when using the --user and --pass params, wget will use
> basic auth for the initial request AND all subsequent requests.
>
> the good news is that wget is smart enough to pick up the
> someuser/somepassword from the URI alone, and this does NOT cause redirects
> to use basic auth!
>
> (note: afaict this is undocumented behavior in wget.)
>
> the "auth-no-challenge" seems to still be required, though. ultimately I
> changed wget.py as follows:
>
>  fetchcmd += " --auth-no-challenge"
>
> i have patched our own wget.py for the time being. from a security point
> of view, this also seems like the correct thing to do (it seems curl does
> NOT include auth headers when following redirects, unless you ask for it).
>
> however, this change would probably NOT work for anyone that *does* need
> basic auth on the redirected request!
>
> is the "correct" fix to add an additional fetcher option like
> 'authredirects'? would y'all take a patch for this feature?
>
> christian
>
> p.s. *in my opinion*, the --no-check-certificate in wget.py should be
> turned off when using HTTP basic auth, since sensitive information may be
> sent to an attacker-controlled host (in other cases i guess it is OK since
> bitbake will verify checksums). i could try to make a patch for this too if
> anyone agrees.
>
>
>
> 
>
>

-- 
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Senior Software Engineer, Mentor Graphics

--00000000000075bfa105bc044557
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I would suggest a url parameter to control whether the aut=
h is passed to the redirects, then it&#39;s isolated to a single uri withou=
t needing a new url scheme.</div><br><div class=3D"gmail_quote"><div dir=3D=
"ltr" class=3D"gmail_attr">On Tue, Feb 23, 2021 at 10:25 AM Christian Betz =
&lt;<a href=3D"mailto:christian.betz@gmail.com">christian.betz@gmail.com</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><di=
v dir=3D"ltr"><table><tbody><tr><td><span>        <span>hi everyone,<br><br=
>handling of user/pass (HTTP basic auth) in wget.py currently works like th=
is, by adding params to the wget CLI:<br><br>=C2=A0fetchcmd +=3D &quot; --u=
ser=3D%s --password=3D%s --auth-no-challenge&quot; % (ud.user, ud.pswd)</sp=
an></span>

    </td>
</tr>




    <tr>
    </tr></tbody></table>
        <table><tbody><tr><td>

      <span>        <span></span></span><br>my SRC_URI is something like &=
quot;<a href=3D"https://someuser:somepassword@bitbucket.org/.." target=3D"_=
blank">https://someuser:somepassword@bitbucket.org/..</a>.&quot;. <br><br>i=
n this case we are authing against the bitbucket API using the username/pas=
sword. the initial request to <a href=3D"http://bitbucket.org" target=3D"_b=
lank">bitbucket.org</a> works fine.</td></tr></tbody></table><div><br></div=
><div>however the actual download was failing due a redirect being followed=
 to what looks like a temporary, AWS-signed URL. AWS *rejects* the basic au=
th and refuses the download.<br></div><div><br></div><div>i discovered that=
 when using the --user and --pass params, wget will use basic auth for the =
initial request AND all subsequent requests. <br></div><div><br></div><div>=
the good news is that wget is smart enough to pick up the someuser/somepass=
word from the URI alone, and this does NOT cause redirects to use basic aut=
h!<br></div><div><br></div><div>(note: afaict this is undocumented behavior=
 in wget.)</div><div><br></div><div>the &quot;auth-no-challenge&quot; seems=
 to still be required, though. ultimately I changed wget.py as follows:</di=
v><div><br></div><div><span><span>=C2=A0fetchcmd</span> <span>+=3D</span> <=
span>&quot; --auth-no-challenge&quot;</span></span></div><div><br></div><di=
v>i have patched our own wget.py for the time being. from a security point =
of view, this also seems like the correct thing to do (it seems curl does N=
OT include auth headers when following redirects, unless you ask for it). <=
br></div><div><br></div><div>however, this change would probably NOT work f=
or anyone that *does* need basic auth on the redirected request!<br></div><=
div><br></div><div>is the &quot;correct&quot; fix to add an additional fetc=
her option like &#39;authredirects&#39;? would y&#39;all take a patch for t=
his feature?<br></div><div><br></div><div>christian<br></div><div><br></div=
><div>p.s. *in my opinion*, the --no-check-certificate in wget.py should be=
 turned off when using HTTP basic auth, since sensitive information may be =
sent to an attacker-controlled host (in other cases i guess it is OK since =
bitbake will verify checksums). i could try to make a patch for this too if=
 anyone agrees.<br></div><div><br></div><br></div>
<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr=
" class=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr">Christop=
her Larson<br>kergoth at gmail dot com<br>Founder - BitBake, OpenEmbedded, =
OpenZaurus<br>Senior Software Engineer, Mentor Graphics</div></div></div></=
div>

--00000000000075bfa105bc044557--
