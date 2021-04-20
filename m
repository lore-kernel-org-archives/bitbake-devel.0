Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
 by mx.groups.io with SMTP id smtpd.web12.12525.1618932558820887994
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 20 Apr 2021 08:29:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=Z/aSCxKI;
 spf=pass (domain: gmail.com, ip: 209.85.218.42, mailfrom: kergoth@gmail.com)
Received: by mail-ej1-f42.google.com with SMTP id w3so58951345ejc.4
        for <bitbake-devel@lists.openembedded.org>; Tue, 20 Apr 2021 08:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vPtBFKtLmEon719mXiK6RnpAF5uoOX6NdKalgNYDUeI=;
        b=Z/aSCxKI/PrGpKmcPOzKwrvYhGdNMOOqeWgA2bkgbNn7pwohYPOBZ5R9Q05/ByH52P
         zELTZsp/I/ckNX15Fjm4huX2NeuZBhSsaNGDLRL3xXwwIb1GF1NNcaN7tBpr+vuW1Zsq
         QQq3VgURWJxyjfSsYAwuBaPhYbfJflwhNYFZdE121/cWET8vMPH/rav3vey2d3wFdIpI
         IeCozgoae3+31aK5CNY8+Mo2eisI1fo2mSKB50vvC8Lrd95QOS36Ir/dXn1ODrf3ujs7
         AR2STxIANOTn4gt6e3YU7BmWRNEkctesPOoQsQTp3gJoJORcX0OmOS9nAg+W9quADHfg
         yKCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vPtBFKtLmEon719mXiK6RnpAF5uoOX6NdKalgNYDUeI=;
        b=Sbtmq5PnTRsxkGNqHsQ0P0l6irAXU3GhuLmgFhLQeCIBQnC1P/xByozBYe1rPguUFe
         u/CJSLNYyGDrTe4GBWhjcXwFaEvU1L9HF6a6697t8WaDTOn5EUorV9T3Z0T5IvUrchAU
         T8M/wbtOki67Jc6LLNlUcx+PvysvzVB1dzk+EM8hknlBeKeL7FyTOtNBhFVpMxkvm8KR
         Mm+epuSuNbVbyjM3+2afBD2pyEOvYDvrJBFvmFykBAx79a9pXosYpe8sGM/8MGeg9aX9
         r/oZyfkQH8zqlO7X0zRSf/40xlDOmBok1TtVCzIj5mgvCRItJeW9x2L3vttG5Cr7GKXw
         uAAg==
X-Gm-Message-State: AOAM530/lkCGOqL8XNOuXnQViLDPrPVTxmJNMTf/BR1UkuTSyl2yTj+3
	mO50WYLR4bJMiyR3D1XcWZnftq5Zl39BsqIg0dg=
X-Google-Smtp-Source: ABdhPJyOh4tYK3DmhjA9SlT2w0tiKVSvcjjebjG/VNfqRAh/Ip7nHCqzlYMlp3yAn1w0EPbqSeVMD2tWJAdj7RuMvdQ=
X-Received: by 2002:a17:906:b6c3:: with SMTP id ec3mr16630823ejb.155.1618932557167;
 Tue, 20 Apr 2021 08:29:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210416171126.1373752-1-richard.purdie@linuxfoundation.org>
 <20210416171126.1373752-2-richard.purdie@linuxfoundation.org>
 <7360338.lvqk35OSZv@linc> <CAAnfSTtmem2RPej+YDJcUt3pyKHmU+VAjCvmRwo-ug7fmyzqOA@mail.gmail.com>
In-Reply-To: <CAAnfSTtmem2RPej+YDJcUt3pyKHmU+VAjCvmRwo-ug7fmyzqOA@mail.gmail.com>
From: "Christopher Larson" <kergoth@gmail.com>
Date: Tue, 20 Apr 2021 08:29:05 -0700
Message-ID: <CABcZAN=ZW34fcATREw6LzQvr2WZoU+hkhGUt9HN+=KceyYh5xA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 2/2] bin/bitbake-getvar: Add a new command to query a variable value (with history)
To: Ross Burton <ross@burtonini.com>
Cc: Paul Eggleton <bluelightning@bluelightning.org>, 
	Richard Purdie <richard.purdie@linuxfoundation.org>, bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000fc402505c0691b02"

--000000000000fc402505c0691b02
Content-Type: text/plain; charset="UTF-8"

-v or -V can often be version as well..

On Tue, Apr 20, 2021 at 8:13 AM Ross Burton <ross@burtonini.com> wrote:

> On Mon, 19 Apr 2021 at 22:36, Paul Eggleton
> <bluelightning@bluelightning.org> wrote:
> > This is great, I have wanted to see this for quite a while! About the
> only
> > feedback would be to add a short option for  --value, though I wonder if
> -v is
> > the best option to choose or not given that it's typically short for
> "verbose"
> > with most tools.
>
> -V would be an alternative but I don't think this is a great problem.
>
> Ross
>
> 
>
>

-- 
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Senior Software Engineer, Mentor Graphics

--000000000000fc402505c0691b02
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">-v or -V can often be version as well..</div><br><div clas=
s=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Apr 20, 202=
1 at 8:13 AM Ross Burton &lt;<a href=3D"mailto:ross@burtonini.com">ross@bur=
tonini.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid=
;border-left-color:rgb(204,204,204);padding-left:1ex">On Mon, 19 Apr 2021 a=
t 22:36, Paul Eggleton<br>
&lt;<a href=3D"mailto:bluelightning@bluelightning.org" target=3D"_blank">b=
luelightning@bluelightning.org</a>&gt; wrote:<br>
&gt; This is great, I have wanted to see this for quite a while! About the=
 only<br>
&gt; feedback would be to add a short option for=C2=A0 --value, though I w=
onder if -v is<br>
&gt; the best option to choose or not given that it&#39;s typically short =
for &quot;verbose&quot;<br>
&gt; with most tools.<br>
<br>
-V would be an alternative but I don&#39;t think this is a great problem.<=
br>
<br>
Ross<br>
<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr=
" class=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr">Christop=
her Larson<br>kergoth at gmail dot com<br>Founder - BitBake, OpenEmbedded, =
OpenZaurus<br>Senior Software Engineer, Mentor Graphics</div></div></div></=
div>

--000000000000fc402505c0691b02--
