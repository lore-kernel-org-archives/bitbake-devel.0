Return-Path: <kergoth@gmail.com>
Received: from mail-oi0-f52.google.com (mail-oi0-f52.google.com
	[209.85.218.52])
	by mail.openembedded.org (Postfix) with ESMTP id DBB7E6FF78
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 17 Sep 2016 05:13:08 +0000 (UTC)
Received: by mail-oi0-f52.google.com with SMTP id a62so1130561oib.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Sep 2016 22:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=Ei6JugQ2oc4ZaLbWRx/Okls/xDLoiCo7/A5KornZgF8=;
	b=UDVQDEUnLSaFnx3+3XHE3xXyWTrqtXAYG2r8N/ygPW2qNZPZXYNgJseS+CJHYevxMf
	ER5BJx89JoFhjtJShaNPraWBx0vuqfaoq1qm+om8vbsHSIUj51mnA4e+XsRuH3W4ic+W
	qL5bRJMDpuVzVrUF7LcChIQ7bITPu3Vpo9O4HepWU+G6yZ+SJ0GQbjESid1Rsxntpqt5
	Z0cD9+DzlvqEX9+gz0x7lYNgOt9sj6InW/pndv2JcTOwMGdMqZX5s9nq2fwHADmMsGY2
	dr/qtasyECU6vFDbej7rZEaayG1oAlB6d4CszEN1V03bEGkBZm2QzPZL9khdDhIhCxQM
	pZ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
	:date:message-id:subject:to:cc;
	bh=Ei6JugQ2oc4ZaLbWRx/Okls/xDLoiCo7/A5KornZgF8=;
	b=QZV4akJYMIuWHbLwUfQW+fE3zW2XDmXN3uVl2IDDRIoxwWyRazzMxlzuOrICS58N2A
	XLm5hN5EPVQxx51wBhbXb2J4QRu8GnXUkaFImv51ZdDT+IOrQtxsSGDl/cPb7SV4JzqY
	ZSRc6Ekm3XsDOayxGe5UQGeKtlldw3PTUR62aFEKJCfV8RLcGWuSsIsiVlXZ8UMt0URQ
	Hr4Wtqy0FyyDSBTlSJm9/gXQliDHRdWfb41Rm/fXisINPz9TWiT8FKcXmSN4yh2K+PPZ
	dLCXoPW2FiWc5fu8aGMKbWekYc7K3kbxSxPYIfqFrEE+Iz3xCkbGL7nWwCFoaSnwELnp
	nVcg==
X-Gm-Message-State: AE9vXwMD8eA1dzKovAYZeqMskSlrw3D/JTiGFhRZWQW684GVJBpo2MH4hGY8s2uSNYhSwolBnCV6udZsEMyR6g==
X-Received: by 10.202.197.148 with SMTP id v142mr17356207oif.110.1474089188992;
	Fri, 16 Sep 2016 22:13:08 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.157.13.194 with HTTP; Fri, 16 Sep 2016 22:12:48 -0700 (PDT)
In-Reply-To: <1474056312-13817-2-git-send-email-kergoth@gmail.com>
References: <1474056312-13817-1-git-send-email-kergoth@gmail.com>
	<1474056312-13817-2-git-send-email-kergoth@gmail.com>
From: Christopher Larson <chris_larson@mentor.com>
Date: Fri, 16 Sep 2016 22:12:48 -0700
X-Google-Sender-Auth: _yD2xHVn7Id6EUZFMqyZQvffmHU
Message-ID: <CABcZANk1MRmzGW0RyhNH8BxYwXhRVr0nKSXaVnVxkDoT1Roy_Q@mail.gmail.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: Re: [PATCHv2 2/2] bb.build: in _exec_task, catch errors from TaskStarted
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Sat, 17 Sep 2016 05:13:09 -0000
Content-Type: multipart/alternative; boundary=001a1134fd2e7a3409053cad22cc

--001a1134fd2e7a3409053cad22cc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 16, 2016 at 1:05 PM, Christopher Larson <kergoth@gmail.com>
wrote:

> +        try:
> +            event.fire(TaskStarted(task, logfn, flags, localdata),
> localdata)
> +        except BaseException:
> +            return 1
>

Thinking about it, this isn=E2=80=99t ideal either, as it will obscure case=
s where
a traceback is most appropriate. Will need to duplicate the handling of
BBHandledException and possibly SystemExit, I expect, instead.
--=20
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a1134fd2e7a3409053cad22cc
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Fri, Sep 16, 2016 at 1:05 PM, Christopher Larson <span dir=3D"ltr">&lt;<=
a href=3D"mailto:kergoth@gmail.com" target=3D"_blank">kergoth@gmail.com</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div id=3D":3p6" class=
=3D"a3s aXjCH m157349a67de96fb2">+=C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 event.fire(TaskStarted(task, log=
fn, flags, localdata), localdata)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 except BaseException:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1</div></blockquote></div=
><br>Thinking about it, this isn=E2=80=99t ideal either, as it will obscure=
 cases where a traceback is most appropriate. Will need to duplicate the ha=
ndling of BBHandledException and possibly SystemExit, I expect, instead.<br=
>-- <br><div class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><=
div dir=3D"ltr">Christopher Larson<br>kergoth at gmail dot com<br>Founder -=
 BitBake, OpenEmbedded, OpenZaurus<br>Maintainer - Tslib<br>Senior Software=
 Engineer, Mentor Graphics</div></div>
</div></div>

--001a1134fd2e7a3409053cad22cc--
