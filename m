Return-Path: <eric.meyers15310@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79456C282C1
	for <webhook@archiver.kernel.org>; Thu, 27 Feb 2025 17:20:31 +0000 (UTC)
Received: from mail-ua1-f68.google.com (mail-ua1-f68.google.com [209.85.222.68])
 by mx.groups.io with SMTP id smtpd.web10.16553.1740676821676612284
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Feb 2025 09:20:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=VBF+4eus;
 spf=pass (domain: gmail.com, ip: 209.85.222.68, mailfrom: eric.meyers15310@gmail.com)
Received: by mail-ua1-f68.google.com with SMTP id a1e0cc1a2514c-8692998b124so953781241.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 27 Feb 2025 09:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740676820; x=1741281620; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KcXBV3DpBQchCD0owggZN5teESrggtv3w4yPHHCxpW0=;
        b=VBF+4eusttPliYgQteaH90uClfGSrBCTbPtAdwtxPb7thne6qaFqBT8q7cORhtGkMk
         ityH8i4l8X6A3e1PKvGCdux2Y34uYwW8c17seQvUK0WsF6W83+l8IdwZuN7oHyE1C4y/
         deykNauRRh5gNHBrfihlZkJA5NvXErfEhBHfyKqYX3CjIap8D3nFWiYLhiyZ8EYK08/p
         MXe27d72KtMyBgPccnPdfHw5uj0H6RuouBVeSKFRHNTTk5XonoqyRWHKc1I1YUXxOpex
         yb11xC/C8cSvHn83SkpMyyPLRzoKFe/FOVXmErPp0ur/QKLof9qVJoBkaghu3AwuCtOt
         wD4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740676820; x=1741281620;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KcXBV3DpBQchCD0owggZN5teESrggtv3w4yPHHCxpW0=;
        b=Lmday7zB2hMuNgIojOSS7UyUEx51LgGMJ8TBxw6D5BKaKKzeuzzlz/LB96y67DQjJy
         00zbxIkWyXSjpLAJzB+yJmE4JymPEHDYn0KlKQzf/vydnf7bxFT3ZduI5ZJRORiLW+96
         G4+8tgx6pr1D4llhSatuXdYdY/Kb+lqc2NLbBAzdq4F+6iotdCVXhK10EgkmHNYFCRDn
         IZ611EA1aBDxU7iukkMH6iBiVquk66m/AsW3TX4lxcT9xMdOt0bARx/pdegx1FbU8kXg
         yCDG/5TzfYh4oX5V0AWW9cD3Y9SbCZ+EZvC3ncq1kJGSmVp09/QDeJdl+do8Z0Q5hzju
         krOg==
X-Forwarded-Encrypted: i=1; AJvYcCX0UNeQ4skMhHU89qiSLvaBw1GNn045yPmQSPRX6tDflS6AIiowwfFMfHoiJpqaQ9gsakjBc7mrZc/r28dQ@lists.openembedded.org
X-Gm-Message-State: AOJu0YwYUqU9SD68XsZ2WxCvTfE/KKNEhkCpaiygYb96Tk/YX5c2CWKl
	4FQ718BFcKBQbAgqZttIkekDxLuogajysiOjLPdZxHmntUJrAJ6z0kFqMA0wsnenRHoxwEdrzjk
	vNlXnKZjbG3jqsU0a+KzIZgbd61Q=
X-Gm-Gg: ASbGncvlDmG7PVBbXIgmWB2UGXSeaOYt+QDhwDnLq8R/Wy+fgn/NusaZlXWEtChqsQH
	zYPKx2ax/44PU5Eplc6LPKCDUsYO6gGYFAd5XKoLtOz1WLh04pBnyS/0ooT8yXp4tNX0nm3kk8f
	t4ZdypqA==
X-Google-Smtp-Source: AGHT+IHq1ycQO2XrFZkHJnyO3uDzmDEw2Azp3YKYLRr2qJAglRyhkJ3zxjhsqtjWi0qWRC/GpdTu+ZO/zF48D5Z+TW0=
X-Received: by 2002:a05:6102:5246:b0:4bb:623:e1f7 with SMTP id
 ada2fe7eead31-4c044dad1bcmr188925137.16.1740676820682; Thu, 27 Feb 2025
 09:20:20 -0800 (PST)
MIME-Version: 1.0
References: <20250226124720.6462-1-eric.meyers@arthrex.com>
 <20250226124720.6462-2-eric.meyers@arthrex.com> <CAB=6tBS6MwA_rwuttiwcfmr+QfWuvtt7FGihTVAFO0qQ2vMmZA@mail.gmail.com>
 <CAB=6tBQr2=oEhk3VB0r9qe0s5tYPyyhDPkGYMOYut6n=ExE7vQ@mail.gmail.com>
In-Reply-To: <CAB=6tBQr2=oEhk3VB0r9qe0s5tYPyyhDPkGYMOYut6n=ExE7vQ@mail.gmail.com>
From: Eric Meyers <eric.meyers15310@gmail.com>
Date: Thu, 27 Feb 2025 11:20:15 -0600
X-Gm-Features: AQ5f1JpyGNpSihPAA6cjghHfFqx9toN9N_DFuj2Rh6aIRa_ukRUxv5xOjnMURUY
Message-ID: <CA+cKJ+EDUoNFZCHmSuW0R1WrEzWUsnMMHi52Q3VaF+=YgQtt8g@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] fetch2/npm: Adding npmrc support for private
 registry authentication
To: Chuck Wolber <chuckwolber@gmail.com>
Cc: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>, 
	bitbake-devel@lists.openembedded.org, Eric Meyers <eric.meyers@arthrex.com>, 
	Geoff Parker <geoffrey.parker@arthrex.com>, Alexander Kanavin <alex.kanavin@gmail.com>
Content-Type: multipart/alternative; boundary="00000000000090d137062f22e7c2"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Feb 2025 17:20:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17350

--00000000000090d137062f22e7c2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 10:49=E2=80=AFPM Chuck Wolber <chuckwolber@gmail.co=
m> wrote:

>
> On Wed, Feb 26, 2025 at 11:14=E2=80=AFAM Chuck Wolber <chuckwolber@gmail.=
com>
> wrote:
>
>>
>> Thank you for the patch! I see a few nits.
>>
>> Recommendations further down in this message somewhat obviate this first
>> one, but I am including it anyway for completeness. I think you should
>> combine the two if statements. There does not seem to be any point in
>> printing the bb.warn if there is no ${HOME}/.nmprc file.
>>
>> I like the use of the BB_USE_ prefix, because it vests the policy
>> decision to
>> allow outside influence with bitbake, where it belongs. However I
>> recommend
>> shortening it a bit to BB_USE_HOME_NPMRC. The addition of _FILE seems a
>> little
>> redundant, and it narrows the future options a bit more than necessary.
>>
>> And, given that you are adding a new variable, I think you should includ=
e
>> a
>> patch to add that variable to the bitbake manual.
>>
>> Rather than clutter things up in the run() method, you can simplify your
>> change greatly by creating a separate instance method (e.g.
>> __home_npmrc(..))
>> in the NpmEnvironment class which only returns a file path, or None. It
>> is in
>> that method that you would check for the ${HOME}/.npmrc file, the
>> BB_HOME_NPMRC
>> flag, and do the bb.warn. Then you would return the string that is the
>> file
>> path to the user's .npmrc. No need for any file copy, or renaming.
>>
>> Then in NpmEnvironment __init__ you would do something like this:
>>
>> self.user_config =3D self.home_npmrc(self, d)
>> if self.user_config is None:
>>     self.user_config =3D tempfile.NamedTemporaryFile(mode=3D"w", bufferi=
ng=3D1)
>> for key, value in configs:
>>     self.user_config.write("%s=3D%s\n" % (key, value))
>>
>
>
> Apologies for not proof-reading my code. That example code is obviously n=
ot
> what you would want to do. Hopefully the actual meaning bled through
> somehow.
>
> I meant something closer to this:
>
> self.user_config =3D tempfile.NamedTemporaryFile(mode=3D"w", buffering=3D=
1)
> hn =3D self.home_npmrc(self, d)
> if hn is not None:
>    with open(hn, 'r') as hnf:
>       self.user_config.write(hnf.read())
> for key, value in configs:
>    self.user_config.write("%s=3D%s\n" % (key, value))
>
>
> ..Ch:W..
>

Chuck,

Thanks a ton for the feedback - much appreciated. I will take some time to
digest this, do the rework, and eventually submit a v4 patch. Probably
sometime early next week.

Thanks!,
-Eric

--00000000000090d137062f22e7c2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr">On Wed, Feb 26, 2025 at =
10:49=E2=80=AFPM Chuck Wolber &lt;<a href=3D"mailto:chuckwolber@gmail.com">=
chuckwolber@gmail.com</a>&gt; wrote:</div><div class=3D"gmail_quote gmail_q=
uote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=
=3D"ltr"><div dir=3D"ltr"><div style=3D"font-family:monospace"><br></div></=
div><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed=
, Feb 26, 2025 at 11:14=E2=80=AFAM Chuck Wolber &lt;<a href=3D"mailto:chuck=
wolber@gmail.com" target=3D"_blank">chuckwolber@gmail.com</a>&gt; wrote:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><=
div dir=3D"ltr"><div style=3D"font-family:monospace"><br></div></div><div><=
div style=3D"font-family:monospace">Thank you for the patch! I see a few ni=
ts.<br><br>Recommendations further down in this message somewhat obviate th=
is first</div><div style=3D"font-family:monospace">one, but I am including =
it anyway for completeness. I think you should</div><div style=3D"font-fami=
ly:monospace">combine the two if statements. There does not seem to be any =
point in</div><div style=3D"font-family:monospace">printing the bb.warn if =
there is no ${HOME}/.nmprc file.</div><br></div><div><div style=3D"font-fam=
ily:monospace">I like the use of the BB_USE_ prefix, because it vests the p=
olicy decision to</div><div style=3D"font-family:monospace">allow outside i=
nfluence with bitbake, where it belongs. However I recommend</div><div styl=
e=3D"font-family:monospace">shortening it a bit to BB_USE_HOME_NPMRC. The a=
ddition of _FILE seems a little<br>redundant, and it narrows the future opt=
ions a bit more than necessary.<br><br></div><div style=3D"font-family:mono=
space">And, given that you are adding a new variable, I think you should in=
clude a</div><div style=3D"font-family:monospace">patch to add that variabl=
e to the bitbake manual.</div><div style=3D"font-family:monospace"><br></di=
v><div style=3D"font-family:monospace">Rather than clutter things up in the=
 run() method, you can simplify your</div><div style=3D"font-family:monospa=
ce">change greatly by creating a separate instance method (e.g. __home_npmr=
c(..))</div><div style=3D"font-family:monospace">in the NpmEnvironment clas=
s which only returns a file path, or None. It is in</div><div style=3D"font=
-family:monospace">that method that you would check for the ${HOME}/.npmrc =
file, the BB_HOME_NPMRC</div><div style=3D"font-family:monospace">flag, and=
 do the bb.warn. Then you would return the string that is the file</div><di=
v style=3D"font-family:monospace">path to the user&#39;s .npmrc. No need fo=
r any file copy, or renaming.</div><div style=3D"font-family:monospace"><br=
></div><div style=3D"font-family:monospace">Then in NpmEnvironment __init__=
 you would do something like this:</div><div style=3D"font-family:monospace=
"><br>self.user_config =3D self.home_npmrc(self, d)<br>if self.user_config =
is None:<br>=C2=A0=C2=A0=C2=A0 self.user_config =3D tempfile.NamedTemporary=
File(mode=3D&quot;w&quot;, buffering=3D1)<br></div><div style=3D"font-famil=
y:monospace">for key, value in configs:<br>=C2=A0=C2=A0=C2=A0 self.user_con=
fig.write(&quot;%s=3D%s\n&quot; % (key, value))</div></div></div></blockquo=
te><div><br></div><div><div style=3D"font-family:monospace"><br></div><div =
style=3D"font-family:monospace">Apologies for not proof-reading my code. Th=
at example code is obviously not</div><div style=3D"font-family:monospace">=
what you would want to do. Hopefully the actual meaning bled through someho=
w.</div><div style=3D"font-family:monospace"><br></div><div style=3D"font-f=
amily:monospace">I meant something closer to this:<br><br></div><div style=
=3D"font-family:monospace">self.user_config =3D tempfile.NamedTemporaryFile=
(mode=3D&quot;w&quot;, buffering=3D1)</div><div style=3D"font-family:monosp=
ace">hn =3D self.home_npmrc(self, d)</div><div style=3D"font-family:monospa=
ce">if hn is not None:</div><div style=3D"font-family:monospace">=C2=A0=C2=
=A0 with open(hn, &#39;r&#39;) as hnf:</div><div style=3D"font-family:monos=
pace">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.user_config.write(hnf.read())</di=
v><div style=3D"font-family:monospace">for key, value in configs:</div><div=
 style=3D"font-family:monospace">=C2=A0=C2=A0 self.user_config.write(&quot;=
%s=3D%s\n&quot; % (key, value))</div></div><div><br></div><div><br><div sty=
le=3D"font-family:monospace">..Ch:W..</div></div></div></div></blockquote><=
div><br></div>Chuck,<div><br></div><div>Thanks a ton for the feedback - muc=
h appreciated. I will take some time to digest this, do the rework, and eve=
ntually submit a v4 patch. Probably sometime early next week.=C2=A0</div><d=
iv><br></div><div>Thanks!,</div><div>-Eric=C2=A0</div></div></div></div>

--00000000000090d137062f22e7c2--

