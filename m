Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
 by mx.groups.io with SMTP id smtpd.web10.9028.1590660070629299840
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 28 May 2020 03:01:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=kUzzJHZJ;
 spf=pass (domain: gmail.com, ip: 209.85.208.175, mailfrom: maurofrqueiros@gmail.com)
Received: by mail-lj1-f175.google.com with SMTP id v16so32654713ljc.8
        for <bitbake-devel@lists.openembedded.org>; Thu, 28 May 2020 03:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=+mp7DJUdNT5BjklEoA95LDqOj4JvJYxTPE6U+KOdJVI=;
        b=kUzzJHZJWNsAeS3sOX1ey2m8YsXOJxlT+PTHQGUpM4903+dI3rqo78r8jhddcx5a0/
         g99urps843Wh3t8A2Bhqj3ZuHV4Q6AuC7LCHVbpPU0179mJ1GnKEkX7M8k491DLc+Z0C
         QAZkEPKhSGSxw8l1NhHLWbNRJVb2id78x5F2PtJKbHc+syTUPF93Pq6k66eaEy5gALym
         NGJA6mfLDhfgP/Y/SdmF/ytbQkIXPB7D3/udNbTN3SioWAXHnh+B+Ali7X2llIVd7J2u
         bR2zILLs1zdcBf6QcI+KDdhihCm28r6FtsKZVc5HI3ObmPUbWWrpM1/DCoBfOaRgrm0R
         K5Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=+mp7DJUdNT5BjklEoA95LDqOj4JvJYxTPE6U+KOdJVI=;
        b=H29FPGtxv84zHG2JVh4MkNFdvbAdM0AdWRgRZU9b56ArrCvmPp9qfIZ5+oT7Vh+6pI
         Ry4Ac2RFMsFj5FxuZPilW8O1Yaq7OEGV7YL5bG6r3waB5/6m8rwO6DsDndN5qEuhlavy
         fb2X8PbRU+lZEa9qM8g3GeO09g9P5/CV+i9kCQfS2052RN+ijn+FZZHS5bbuSeLPmIhW
         yaJSf6phZAAJfd3yFB0BOPFp+Tr+xwZvlPmqnBrndRK3lcJJahOXLzWhCCZvR+mj/jVg
         QYm2FIfFs3R1nQozknzeH+LFqvrkGXNNsuJhq0o8yjOYlWZ2jZzCjrDPtiMAFzcL7oF7
         V44Q==
X-Gm-Message-State: AOAM532LnEZPH0Jl05QGmZ/b42nUk7vqXiqO2JPfOejZ76l0/sjATd+i
	yN0HZhFpOtMhuk+OcSE7/zaTqggSrDgSAsf9y4EWOgu+
X-Google-Smtp-Source: ABdhPJwGCiOwSxb1OxfnkkiBvy8iwy9Dbxa8URc8GUBvE5jR4lxCPm50EH2X1WC455ZgcLsrMSgikC/FEPj7BIuLTSc=
X-Received: by 2002:a2e:9dcd:: with SMTP id x13mr1156895ljj.187.1590660068560;
 Thu, 28 May 2020 03:01:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAOev9BfgUF4yCYYVwtLm1jQCKjwdTJPc5XHtPtrKq-vFzkdP_A@mail.gmail.com>
 <CAAnfSTs8CpqDMVv20EqQrSyFhY=n_J3Jkxd+1AG+tkenAhSvBA@mail.gmail.com> <CAOev9BdT0_MgD6paFnOmy7Wk7_G-us0_3niNonW+=qE8pCvayQ@mail.gmail.com>
In-Reply-To: <CAOev9BdT0_MgD6paFnOmy7Wk7_G-us0_3niNonW+=qE8pCvayQ@mail.gmail.com>
From: maurofrqueiros@gmail.com
Date: Thu, 28 May 2020 11:00:56 +0100
Message-ID: <CAOev9BeAAL_euq5iE-_GvyzWpd2+xqOcVf8-zERdd9eUtBfyOw@mail.gmail.com>
Subject: [bitbake-devel] git-lfs validation
To: bitbake-devel@lists.openembedded.org
X-Groupsio-MsgNum: 11325
Content-Type: multipart/mixed; boundary="00000000000058beee05a6b2684a"

--00000000000058beee05a6b2684a
Content-Type: multipart/alternative; boundary="00000000000058beec05a6b26848"

--00000000000058beec05a6b26848
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

---------- Forwarded message ---------
De: Mauro Queir=C3=B3s <maurofrqueiros@gmail.com>
Date: quinta, 28/05/2020 =C3=A0(s) 10:57
Subject: Re: [bitbake-devel] git-lfs validation
To: Ross Burton <ross@burtonini.com>
Cc: <bitbake-devel@lists.openembedded.org>


Hi,

Sorry for the long delay, but only now I managed to get back to this issue.

Actually, I found out another issue. When "lfs=3D0" is set, the LFS-tracked
files are still downloaded. The flag only allows ignoring errors if Git-LFS
is not installed.

I think that something like the patch attached should work to skip LFS
smudging if "lfs=3D0" is set. This way, only the pointers are downloaded,
which I think was the intent of creating this flag.

Regards!

Ross Burton <ross@burtonini.com> escreveu no dia segunda, 10/02/2020 =C3=A0=
(s)
15:57:

> Please do send a patch, or ideally two separate patches.
>
> Ross
>
> On Mon, 10 Feb 2020 at 14:14, Mauro Queir=C3=B3s <maurofrqueiros@gmail.co=
m>
> wrote:
> >
> > Hi,
> >
> >
> >
> > I noticed two things related to git-lfs on
> poky/bitbake/lib/bb/fetch2/git.py, which I think may me improved:
> >
> >
> >
> > First, git.py seems to always check the master branch when looking for
> lfs objects (_contains_lfs function), even when the branch is specified i=
n
> SRC_URI;
> >
> >
> >
> > Second, the warning message "Repository %s has LFS content but it is no=
t
> being fetched" is printed even when git-lfs is available and "lfs=3D1" is=
 set.
> >
> >
> >
> > I could also provide a patch if you think these two issues make sense.
> >
> > --
> > _______________________________________________
> > bitbake-devel mailing list
> > bitbake-devel@lists.openembedded.org
> > http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>

--00000000000058beec05a6b26848
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">---------- Forwarded message ---------<br>De: <b class=3D"g=
mail_sendername" dir=3D"auto">Mauro Queir=C3=B3s</b> <span dir=3D"auto">&lt=
;<a href=3D"mailto:maurofrqueiros@gmail.com">maurofrqueiros@gmail.com</a>&g=
t;</span><br>Date: quinta, 28/05/2020 =C3=A0(s) 10:57<br>Subject: Re: [bitb=
ake-devel] git-lfs validation<br>To: Ross Burton &lt;<a href=3D"mailto:ross=
@burtonini.com">ross@burtonini.com</a>&gt;<br>Cc:  &lt;<a href=3D"mailto:bi=
tbake-devel@lists.openembedded.org">bitbake-devel@lists.openembedded.org</a=
>&gt;<br></div><br><br><div dir=3D"ltr"><div>Hi, <br></div><div><br></div><=
div>Sorry for the long delay, but only now I managed to get back to this is=
sue.</div><div><br></div><div>Actually, I found out another issue. When &qu=
ot;lfs=3D0&quot; is set, the LFS-tracked files are still downloaded. The fl=
ag only allows ignoring errors if Git-LFS is not installed.</div><div><br><=
/div><div>I think that something like the patch attached should work to ski=
p LFS smudging if &quot;lfs=3D0&quot; is set. This way, only the pointers a=
re downloaded, which I think was the intent of creating this flag.<br></div=
><div><br></div><div>Regards!<br></div></div><br><div class=3D"gmail_quote"=
><div dir=3D"ltr" class=3D"gmail_attr">Ross Burton &lt;<a href=3D"mailto:ro=
ss@burtonini.com" target=3D"_blank">ross@burtonini.com</a>&gt; escreveu no =
dia segunda, 10/02/2020 =C3=A0(s) 15:57:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">Please do send a patch, or ideally two separate pa=
tches.<br>
<br>
Ross<br>
<br>
On Mon, 10 Feb 2020 at 14:14, Mauro Queir=C3=B3s &lt;<a href=3D"mailto:maur=
ofrqueiros@gmail.com" target=3D"_blank">maurofrqueiros@gmail.com</a>&gt; wr=
ote:<br>
&gt;<br>
&gt; Hi,<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; I noticed two things related to git-lfs on poky/bitbake/lib/bb/fetch2/=
git.py, which I think may me improved:<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; First, git.py seems to always check the master branch when looking for=
 lfs objects (_contains_lfs function), even when the branch is specified in=
 SRC_URI;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Second, the warning message &quot;Repository %s has LFS content but it=
 is not being fetched&quot; is printed even when git-lfs is available and &=
quot;lfs=3D1&quot; is set.<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; I could also provide a patch if you think these two issues make sense.=
<br>
&gt;<br>
&gt; --<br>
&gt; _______________________________________________<br>
&gt; bitbake-devel mailing list<br>
&gt; <a href=3D"mailto:bitbake-devel@lists.openembedded.org" target=3D"_bla=
nk">bitbake-devel@lists.openembedded.org</a><br>
&gt; <a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-deve=
l" rel=3D"noreferrer" target=3D"_blank">http://lists.openembedded.org/mailm=
an/listinfo/bitbake-devel</a><br>
</blockquote></div>
</div></div>

--00000000000058beec05a6b26848--

--00000000000058beee05a6b2684a
Content-Type: application/x-patch; 
	name="0001-git.py-skip-smudging-if-lfs-0-is-set.patch"
Content-Disposition: attachment; 
	filename="0001-git.py-skip-smudging-if-lfs-0-is-set.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kaqls7mb0>
X-Attachment-Id: f_kaqls7mb0

RnJvbSA4ODVlZjJhNDU3NGZmNzRiOWE4YjE1M2MyNDM0YmE1Y2E4ZjUwZWI1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNYXVybyBRdWVpcm9zIDxNYXVyby5RdWVpcm9zQGN0dy5ibXdn
cm91cC5jb20+CkRhdGU6IEZyaSwgMjIgTWF5IDIwMjAgMTY6NDc6MzIgKzAxMDAKU3ViamVjdDog
W1BBVENIXSBnaXQucHk6IHNraXAgc211ZGdpbmcgaWYgbGZzPTAgaXMgc2V0CgpJc3N1ZTogTUdV
MjJTV0lOVC0zOTYKQ2hhbmdlLUlkOiBJMmNiZWY5YTNhYzFlNDE2ZDRjOWY5OWI4YjA0ZjViMGZh
MTBmN2VmZAotLS0KIGJpdGJha2UvbGliL2JiL2ZldGNoMi9naXQucHkgfCAzICsrKwogMSBmaWxl
IGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2JpdGJha2UvbGliL2JiL2Zl
dGNoMi9naXQucHkgYi9iaXRiYWtlL2xpYi9iYi9mZXRjaDIvZ2l0LnB5CmluZGV4IDliYTljZGNj
YzcuLjI1ZGI3ZWU1N2EgMTAwNjQ0Ci0tLSBhL2JpdGJha2UvbGliL2JiL2ZldGNoMi9naXQucHkK
KysrIGIvYml0YmFrZS9saWIvYmIvZmV0Y2gyL2dpdC5weQpAQCAtNDc1LDYgKzQ3NSw5IEBAIGNs
YXNzIEdpdChGZXRjaE1ldGhvZCk6CiAKICAgICAgICAgbmVlZF9sZnMgPSB1ZC5wYXJtLmdldCgi
bGZzIiwgIjEiKSA9PSAiMSIKIAorICAgICAgICBpZiBub3QgbmVlZF9sZnM6CisgICAgICAgICAg
ICB1ZC5iYXNlY21kID0gIkdJVF9MRlNfU0tJUF9TTVVER0U9MSAiICsgdWQuYmFzZWNtZAorCiAg
ICAgICAgIHNvdXJjZV9mb3VuZCA9IEZhbHNlCiAgICAgICAgIHNvdXJjZV9lcnJvciA9IFtdCiAK
LS0gCjIuMTcuMQoK

--00000000000058beee05a6b2684a--
