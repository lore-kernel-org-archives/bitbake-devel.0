Return-Path: <ross.burton@intel.com>
Received: from mail-io0-f178.google.com (mail-io0-f178.google.com
	[209.85.223.178])
	by mail.openembedded.org (Postfix) with ESMTP id A7CAF770C5
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  9 Aug 2016 10:39:11 +0000 (UTC)
Received: by mail-io0-f178.google.com with SMTP id 38so7612359iol.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 09 Aug 2016 03:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=SCJgTearqmP/TIoEP/CQSufinG0x+NQ5FKmvb9Vet3o=;
	b=pelzFPcjXUqMTi0IINCtJmRHWMh4glPcrwpd0bw0rPb2mJNhjHHK/evYsjr8qVRa9h
	CWt3jkDzqtKmjc+eiVKx9UZiDlo00ubSWtLFz3Zaly+ZygyzdBKBg0P5c0bogWyM022S
	nOTaAtPMV/9yX9v6YuaqK3FPjGPZY3Up0yTyoJt3M+hQ7zEnIGxJqHmyyCmYvy2G8bzf
	UGZmVlO5HMvGG+ZeulcIS7nWhJ8B10b/oeZxMbe/F+p3/xdYsJVFDLKa7Ktrx/wJ6BXJ
	vq3UP5EJcuc4fvozYrWvqH/RcUwGIvi2gM772CUK2gLN7t+MABLO9pMBuUqzmn8uPE9m
	h7vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=SCJgTearqmP/TIoEP/CQSufinG0x+NQ5FKmvb9Vet3o=;
	b=N+emobtn+E+hp6Iu4PbX+ol7GgYyuenHks+HBmsXNtt9fk5YzFVP+idwpSJnh+0sQl
	WlkrPe/4CDmaN1+q5YpK+HyV9br45c0O12C91+3egJAtOvWnzOpDimNX1Cbrz8FjbdJ3
	OIQVBRVuIQPNzmuqe/xrGy9g/eHhp3h2IzCH+M8qCroRpXVcXIIC+TRP06WrmA6Nfn/g
	Fr61ssIA9xV9WUBqUAdyFrJWAbO+ueTmXFIA9Fn/mHIH6Esefqb+Pxeh2imo1woylUFT
	hAQj5iMgAMfEAPdCJ5CH8g3z5/W8ZrzXV4UHU6OnM53rl3LFUaAXKlSrgQltsOjVuIbH
	DEaQ==
X-Gm-Message-State: AEkoouuyo0MBCgj3tHY1lM47Wdq8Bj6FB2DwK/oVkizTYsbxDwBGBFxBZXLa+uZinei6zV6fTDMyaoZ8zc3NFkCc
X-Received: by 10.107.135.142 with SMTP id r14mr109274903ioi.133.1470739151903;
	Tue, 09 Aug 2016 03:39:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.18.17 with HTTP; Tue, 9 Aug 2016 03:38:51 -0700 (PDT)
In-Reply-To: <dec52a2f-ef2f-f9c1-9ca2-e8b99cea7694@126.com>
References: <dec52a2f-ef2f-f9c1-9ca2-e8b99cea7694@126.com>
From: "Burton, Ross" <ross.burton@intel.com>
Date: Tue, 9 Aug 2016 11:38:51 +0100
Message-ID: <CAJTo0LZNQNqiTLWHcegQUXfDAMp+4eahe1jmpJgsWWDhjxfPjw@mail.gmail.com>
To: =?UTF-8?B?5byg5b+g5bGx?= <zzs213@126.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: howto rerun a task whenever it's content chang
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
X-List-Received-Date: Tue, 09 Aug 2016 10:39:12 -0000
Content-Type: multipart/alternative; boundary=001a113eccbcb4f5010539a12423

--001a113eccbcb4f5010539a12423
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Can you share the task, and what release of bitbake you are using?  As you
say, this should work fine.

Ross

On 9 August 2016 at 08:39, =E5=BC=A0=E5=BF=A0=E5=B1=B1 <zzs213@126.com> wro=
te:

> I have a task in test.bb. say do_task1
>
> run 'bitbake test -c task1'. then generate stamp file for it.
>
> Now I found a bug and edit do_task1. but run 'bitbake test -c task1'
> again, Bitbake said
>
>         'Attempted 1 tasks of which 1 didn't need to be rerun and all
> succeeded'
>
> I remove the stamp file, then the task rerun ok.
>
> It's so strange! The meta data changed, Why the task refuse to rerun?
>
> It should rerun automaticaly.
>
> Any one told me howto let the task auto rerun whenenver it's content
> changed!
>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>

--001a113eccbcb4f5010539a12423
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Can you share the task, and what release of bitbake you ar=
e using?=C2=A0 As you say, this should work fine.<div><br></div><div>Ross</=
div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On 9 Au=
gust 2016 at 08:39, =E5=BC=A0=E5=BF=A0=E5=B1=B1 <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:zzs213@126.com" target=3D"_blank">zzs213@126.com</a>&gt;</span=
> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">I have a task in <a href=3D"http=
://test.bb" rel=3D"noreferrer" target=3D"_blank">test.bb</a>. say do_task1<=
br>
<br>
run &#39;bitbake test -c task1&#39;. then generate stamp file for it.<br>
<br>
Now I found a bug and edit do_task1. but run &#39;bitbake test -c task1&#39=
; again, Bitbake said<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;Attempted 1 tasks of which 1 didn&#39;t ne=
ed to be rerun and all succeeded&#39;<br>
<br>
I remove the stamp file, then the task rerun ok.<br>
<br>
It&#39;s so strange! The meta data changed, Why the task refuse to rerun?<b=
r>
<br>
It should rerun automaticaly.<br>
<br>
Any one told me howto let the task auto rerun whenenver it&#39;s content ch=
anged!<span class=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
-- <br>
______________________________<wbr>_________________<br>
bitbake-devel mailing list<br>
<a href=3D"mailto:bitbake-devel@lists.openembedded.org" target=3D"_blank">b=
itbake-devel@lists.openembedd<wbr>ed.org</a><br>
<a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-devel" re=
l=3D"noreferrer" target=3D"_blank">http://lists.openembedded.org/<wbr>mailm=
an/listinfo/bitbake-devel</a><br>
</font></span></blockquote></div><br></div>

--001a113eccbcb4f5010539a12423--
