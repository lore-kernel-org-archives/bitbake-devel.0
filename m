Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
 by mx.groups.io with SMTP id smtpd.web09.9187.1612537930502731624
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Feb 2021 07:12:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=huoMZorG;
 spf=pass (domain: gmail.com, ip: 209.85.166.180, mailfrom: tomasz.dziendzielski@gmail.com)
Received: by mail-il1-f180.google.com with SMTP id y15so6066550ilj.11
        for <bitbake-devel@lists.openembedded.org>; Fri, 05 Feb 2021 07:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8GZb+r2BB81fy+8gr0YZbjpzRWR0HRhwi10SA6FA4i4=;
        b=huoMZorGeeqHVptaop1LJuc8TdG5yOLYIpRsaXOGLbgYhqX9fIo2OwoOAdMmlqXJMy
         ibtRrC5VJm/C6zt7V8f5Wmld71ETxeWGE5KIxjTWIF2Y7xZw1bxW4eLzh2ZGE5TSU+WQ
         JQJ9ucOf/VRE0VLx2lCN/NDbDF2ajOF0puzo+D2cK5XIoSPB4W+h/Wvu0V4GiURthit1
         4ly0OOWJv+N7L6yACMSfVQ1TKGZLq/Nw6CDbH0RG1m+p2L7Wp3AwpTdDC2MJJkz3atjX
         Rct8I2Fm9NW23NBekSZkShI2PqHufYsCbIeWx/PRNoEwUSdcAJVKscqVPHQTViGqIIgR
         V/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8GZb+r2BB81fy+8gr0YZbjpzRWR0HRhwi10SA6FA4i4=;
        b=Vyw+ojraAKnrWdp4gbqFpp3EX+L/bX0eyyIBtIKXy/EuaNdThlAi5r21LlkN0vPaxx
         sonptvS+Zvp4wzd7oJdRHFZ1PBBx7K1cd8rwOGil8cNOG6PYk9g+1cfILZ1dy7Xfxs1q
         C/zO31OR8qQWD0oZHy7deZjstvvsn34sgYtK1/mHpf4pb3T6aQttt9H+xhOtQH2vtyTO
         lS9liNoGOemfkzzIWLtiPOK+qR/dA8PSuW8YUZ9W0RDwgyLoi2Uq/y8eDtg21Cpt9QSR
         sGn8jcuHUxJWxq68ojdlFRN+fBoEFdGKnU2NIsee1T8U3EuD581G/r0Bf2E06KQ4S2tk
         TD2Q==
X-Gm-Message-State: AOAM533C47YLvr3Qe+1/z0Sr1Kk9XEjvjlAoDTuDS4DzGoGDddT5GhBk
	l46ZLwEe73+wSWhZQBeQMhFc7K+ug+v76/1xzhA=
X-Google-Smtp-Source: ABdhPJyb6+B+8rPPt8FQhm0CLx9BxvVdkn+OtnBuL0AlMBdtiUMkxuGCOLf/W0IP10PhxovzvVo75ggOyrqK5oW5ZM4=
X-Received: by 2002:a05:6e02:12c7:: with SMTP id i7mr73056ilm.66.1612537927991;
 Fri, 05 Feb 2021 07:12:07 -0800 (PST)
MIME-Version: 1.0
References: <20210204221422.16042-1-tomasz.dziendzielski@gmail.com>
 <1e3bfe4059efd60bf6ee4b31c1b81355f6657586.camel@linuxfoundation.org>
 <CAJkqNs2S2_JVZRpDgj_62zGmyqrLUyybDNy3z5wutn7RH_pWvA@mail.gmail.com> <f07ad5d24c64acc060ae71e91973b869da27824d.camel@linuxfoundation.org>
In-Reply-To: <f07ad5d24c64acc060ae71e91973b869da27824d.camel@linuxfoundation.org>
From: "Tomasz Dziendzielski" <tomasz.dziendzielski@gmail.com>
Date: Fri, 5 Feb 2021 16:13:29 +0100
Message-ID: <CAJkqNs368ngV4pqUemfq6vmo2atjVTzh7S_=ki-7J2koNFOxcw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] event: Prevent bitbake from executing event handler for wrong multiconfig target
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="0000000000006290d305ba983ead"

--0000000000006290d305ba983ead
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>No, that is definitely going to just mask the problem.
>
>These tests are designed to detect problems which will cause us "pain"
>later. The hashes are designed to be stable to whether something is
>built as a multiconfig or not shouldn't change its hashes. The tests
>are warning us that this is happening so we need to fix that.

Thanks, I think I already found the solution. I need to add the mc prefix
before it is written to __BBHANDLERS variable and now I don't see any
metadata hashes changing on test. I will submit a patch after oe-selftest
for multiconfig finishes with success.

@@ -259,6 +259,9 @@ class BBHandlerNode(AstNode):
     def eval(self, data):
         bbhands =3D data.getVar('__BBHANDLERS', False) or []
         for h in self.hs:
+            if data.getVar('BB_CURRENT_MC', False):
+                h =3D data.getVar('BB_CURRENT_MC', False) + h
+             bbhands.append(h)
             data.setVarFlag(h, "handler", 1)
         data.setVar('__BBHANDLERS', bbhands)

Best regards,
Tomasz Dziendzielski

pt., 5 lut 2021 o 15:42 Richard Purdie <richard.purdie@linuxfoundation.org>
napisa=C5=82(a):

> On Fri, 2021-02-05 at 15:26 +0100, Tomasz Dziendzielski wrote:
> > I can already see the bitbake test failed, after adding "if d" it
> > passed. Sorry that I forgot to run tests before submitting a patch.
> > Another thing, I ran locally oe-selftest -r multiconfig and build
> > fails with "When reparsing %s, the basehash value changed from %s to
> > %s. The metadata is not deterministic and this needs to be fixed".
> > During the build it appeared only if I made changes to the code
> > during the build. Here it's most probably caused because of events'
> > handlers renaming.
>
> That is going to be a problem, we need to make sure the hashes are
> deterministic.
>
> > Do you think there is some way to handle this issue or I should just
> > add:
> >          ignore_mismatch =3D ((d.getVar("BB_HASH_IGNORE_MISMATCH") or
> > '') =3D=3D '1')
> > +        if d.getVar("__BBMULTICONFIG", False):
> > +            ignore_mismatch =3D True
> > to bitbake/lib/bb/siggen.py?
>
> No, that is definitely going to just mask the problem.
>
> These tests are designed to detect problems which will cause us "pain"
> later. The hashes are designed to be stable to whether something is
> built as a multiconfig or not shouldn't change its hashes. The tests
> are warning us that is happening so we need to fix that.
>
> Cheers,
>
> Richard
>
>

--0000000000006290d305ba983ead
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>&gt;<span class=3D"gmail-im"></span>No, that is defin=
itely going to just mask the problem.<br>
&gt;<br>
&gt;These tests are designed to detect problems which will cause us &quot;p=
ain&quot;<br>
&gt;later. The hashes are designed to be stable to whether something is<br>
&gt;built as a multiconfig or not shouldn&#39;t change its hashes. The test=
s<br>
&gt;are warning us that this is happening so we need to fix that.</div><div=
><br></div><div>Thanks, I think I already found the solution. I need to add=
 the mc prefix before it is written to __BBHANDLERS variable and now I don&=
#39;t see any metadata hashes changing on test. I will submit a patch after=
 oe-selftest for multiconfig finishes with success.<br></div><div><br></div=
><div>@@ -259,6 +259,9 @@ class BBHandlerNode(AstNode):</div>=C2=A0 =C2=A0 =
=C2=A0def eval(self, data):<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bbhands =
=3D data.getVar(&#39;__BBHANDLERS&#39;, False) or []<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0for h in self.hs:<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0if data.getVar(&#39;BB_CURRENT_MC&#39;, False):<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0h =3D data.getVar(&#39;BB_CURRENT_=
MC&#39;, False) + h<br><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=
=A0 bbhands.append(h)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=
=A0 data.setVarFlag(h, &quot;handler&quot;, 1)<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0data.setVar(&#39;__BBHANDLERS&#39;, bbhands)<br></div><div><br></=
div><div>Best regards,</div><div>Tomasz Dziendzielski<br></div></div><br><d=
iv class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">pt., 5 lut 2=
021 o 15:42=C2=A0Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxf=
oundation.org">richard.purdie@linuxfoundation.org</a>&gt; napisa=C5=82(a):<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Fri, 2021-02-=
05 at 15:26 +0100, Tomasz Dziendzielski wrote:<br>
&gt; I can already see the bitbake test failed, after adding &quot;if d&quo=
t; it<br>
&gt; passed. Sorry that I forgot to run tests before submitting a patch.<br=
>
&gt; Another thing, I ran locally oe-selftest -r multiconfig and build<br>
&gt; fails with &quot;When reparsing %s, the basehash value changed from %s=
 to<br>
&gt; %s. The metadata is not deterministic and this needs to be fixed&quot;=
.<br>
&gt; During the build it appeared only if I made changes to the code<br>
&gt; during the build. Here it&#39;s most probably caused because of events=
&#39;<br>
&gt; handlers renaming.<br>
<br>
That is going to be a problem, we need to make sure the hashes are<br>
deterministic.<br>
<br>
&gt; Do you think there is some way to handle this issue or I should just<b=
r>
&gt; add:<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 ignore_mismatch =3D ((d.getVar(&quot=
;BB_HASH_IGNORE_MISMATCH&quot;) or<br>
&gt; &#39;&#39;) =3D=3D &#39;1&#39;)<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0if d.getVar(&quot;__BBMULTICONFIG&quot;, =
False):<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ignore_mismatch =3D True<br=
>
&gt; to bitbake/lib/bb/siggen.py?<br>
<br>
No, that is definitely going to just mask the problem.<br>
<br>
These tests are designed to detect problems which will cause us &quot;pain&=
quot;<br>
later. The hashes are designed to be stable to whether something is<br>
built as a multiconfig or not shouldn&#39;t change its hashes. The tests<br=
>
are warning us that is happening so we need to fix that.<br>
<br>
Cheers,<br>
<br>
Richard<br>
<br>
</blockquote></div>

--0000000000006290d305ba983ead--
