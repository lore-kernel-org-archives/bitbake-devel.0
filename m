Return-Path: <martin.jansa@gmail.com>
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
	[209.85.128.50])
	by mail.openembedded.org (Postfix) with ESMTP id DC4C27D253
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Apr 2019 07:36:24 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id o25so9895051wmf.5
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Apr 2019 00:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=ewiapo1lCwSnBOQq39fwOgWA/sZ/grBX/QTWaSFqPKw=;
	b=WNTSevFmEj4CWGM9LH8QMu/rEaUnoX31rMh9/h3+8R9SnR0dO8/Kex2IQ4hx96wSO+
	SwvLbvSmmeDBIj54VnnjSFp9ytV5OxmDCx2Mjjw0W2TOV8G4Zy+wv0ixxXQp2u4xpkNz
	D4lZa1dl0xNtElfBM9OP/Ztv0vk56c1c6q870ndN5xoiWlUayrxJaC8HJ7NjS9/5THVi
	/iagRslkFm67DPM7oDAAuzifeuQdH6LlOLTn2tG0a7FI02Rfg6jeKlpSlsDTyL+Kl+02
	VgNMGq7exV4vngVBIVf0YfO5LUfiBhVBiKGXzFBk5MJwJgr9F0xDmiJqVw8P/pCfo4eX
	qLGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=ewiapo1lCwSnBOQq39fwOgWA/sZ/grBX/QTWaSFqPKw=;
	b=K7vRezP46Y66hRTTq+AhOKjQJCTOVgECcx6doi1Sns3Rch2viB3nVWmqmwOsPrTtg1
	Bf8zNo988sU2ldDFrXwx2FcEbxdC3b1+FLH6wDiW/vCldcVcaIPZup3bgfs9OlTiOy2x
	UHgQF1q0R7aQr82HsIY3JzwBZuWXiyyf3jxAWgmqy5A3bl6dVxJBG4RLmfiL0NkffFhP
	F1Txw4Y0/thviK2Yd3PN4KCg6ExGvsswpaXJM7n3PYXWToODfu9zUMD4kT7uBI7DpX8I
	SG+CsQFdOgu7mSlaKF24zPX/vAjfqmVab8vugRSANhTTr82LmrDDZyHOzCQFTcKkxqPp
	gjZw==
X-Gm-Message-State: APjAAAUe9FFQS+Q2K2S3xlZHd0WZnjvYFEcHubCF1qOLPjLCMtwiE7Ls
	iCnvmlfhN9fhfP33OQY45UH1wYpefsSLdAgvTj4=
X-Google-Smtp-Source: APXvYqxyG6oznu5QjRGUKMVjQWb18YVwu9fXHJ5Cq+WorAz4a2IZfNzerFRkLT215Jx2JdzdwHWpnYAfhridNyFFw5g=
X-Received: by 2002:a7b:c3c9:: with SMTP id t9mr9324472wmj.131.1555054585531; 
	Fri, 12 Apr 2019 00:36:25 -0700 (PDT)
MIME-Version: 1.0
References: <1555031998-3975-1-git-send-email-akuster808@gmail.com>
	<CABcZAN=v6z1wYty0EbjVAtAKeR_EQgzRuZcYYXLBOWxh4m=-qw@mail.gmail.com>
	<79d20dc2-8f36-3c27-05e5-3517b2eb8e26@mvista.com>
In-Reply-To: <79d20dc2-8f36-3c27-05e5-3517b2eb8e26@mvista.com>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Fri, 12 Apr 2019 09:36:14 +0200
Message-ID: <CA+chaQc3w=8kPabdEt1Jz-O=5GfuUL0XZ6Y=Eyx27kFTxHwZYw@mail.gmail.com>
To: akuster <akuster@mvista.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Armin Kuster <akuster808@gmail.com>
Subject: Re: [PATCH]] bitbake: update masters version to some farout version
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
X-List-Received-Date: Fri, 12 Apr 2019 07:36:25 -0000
Content-Type: multipart/alternative; boundary="0000000000002d4f8b0586505c45"

--0000000000002d4f8b0586505c45
Content-Type: text/plain; charset="UTF-8"

> but so how is it Master is 1.40

It isn't, master is currently identical with 1.42 branch, so both are 1.42.

Setting it farout, will cause issues once new incompatible change is
introduced in the metadata and the sanity check needs to be updated to
require even more farout version.

On Fri, Apr 12, 2019 at 8:04 AM akuster <akuster@mvista.com> wrote:

>
>
> On 4/12/19 8:23 AM, Christopher Larson wrote:
>
> My concern here is a user of an old clone of bitbake master won't trigger
> the oe-core bitbake version checks, it could just silently behave badly, or
> explode instead :)
>
> ok. but so how is it Master is 1.40 and Warrior is 1.42 isn't causing a
> version trigger?
>
> Is the version in the __init__.py needed ?  Warriors does not match and I
> have not seen any version check issues.
>
> as always, thanks for the feedback,
> Dazed and confused
>
>
> On Thu, Apr 11, 2019 at 6:20 PM Armin Kuster <akuster808@gmail.com> wrote:
>
>> This is to avoid having master being updated when we branch
>> for a new release.
>>
>> Also, master should not be at the same version as the last
>> stable release.
>>
>> Signed-off-by: Armin Kuster <akuster808@gmail.com>
>> ---
>>  bin/bitbake        | 2 +-
>>  lib/bb/__init__.py | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/bin/bitbake b/bin/bitbake
>> index 57dec2a..952c47e 100755
>> --- a/bin/bitbake
>> +++ b/bin/bitbake
>> @@ -38,7 +38,7 @@ from bb.main import bitbake_main,
>> BitBakeConfigParameters, BBMainException
>>  if sys.getfilesystemencoding() != "utf-8":
>>      sys.exit("Please use a locale setting which supports UTF-8 (such as
>> LANG=en_US.UTF-8).\nPython can't change the filesystem locale after loading
>> so we need a UTF-8 when Python starts or things won't work.")
>>
>> -__version__ = "1.40.0"
>> +__version__ = "1.99.0"
>>
>>  if __name__ == "__main__":
>>      if __version__ != bb.__version__:
>> diff --git a/lib/bb/__init__.py b/lib/bb/__init__.py
>> index 4bc47c8..a86197a 100644
>> --- a/lib/bb/__init__.py
>> +++ b/lib/bb/__init__.py
>> @@ -21,7 +21,7 @@
>>  # with this program; if not, write to the Free Software Foundation, Inc.,
>>  # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>>
>> -__version__ = "1.40.0"
>> +__version__ = "1.99.0"
>>
>>  import sys
>>  if sys.version_info < (3, 4, 0):
>> --
>> 2.7.4
>>
>> --
>> _______________________________________________
>> bitbake-devel mailing list
>> bitbake-devel@lists.openembedded.org
>> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>>
>
>
> --
> Christopher Larson
> kergoth at gmail dot com
> Founder - BitBake, OpenEmbedded, OpenZaurus
> Senior Software Engineer, Mentor Graphics
>
>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>

--0000000000002d4f8b0586505c45
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">&gt; but so how is it Master is 1.40<div><br></div><div>It=
 isn&#39;t, master is currently identical with 1.42 branch, so both are 1.4=
2.</div><div><br></div><div>Setting it farout, will cause issues once new i=
ncompatible change is introduced in the metadata and the sanity check needs=
 to be updated to require even more farout version.</div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Apr 12, 20=
19 at 8:04 AM akuster &lt;<a href=3D"mailto:akuster@mvista.com">akuster@mvi=
sta.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">
 =20
   =20
 =20
  <div bgcolor=3D"#FFFFFF">
    <br>
    <br>
    <div class=3D"gmail-m_3620003381146642744moz-cite-prefix">On 4/12/19 8:=
23 AM, Christopher Larson
      wrote:<br>
    </div>
    <blockquote type=3D"cite">
     =20
      <div dir=3D"ltr">My concern here is a user of an old clone of
        bitbake master won&#39;t trigger the oe-core bitbake version checks=
,
        it could just silently behave badly, or explode instead :)</div>
    </blockquote>
    ok. but so how is it Master is 1.40 and Warrior is 1.42 isn&#39;t
    causing a version trigger? <br>
    <br>
    Is the version in the __init__.py needed ?=C2=A0 Warriors does not matc=
h
    and I have not seen any version check issues.<br>
    <br>
    as always, thanks for the feedback, <br>
    Dazed and confused<br>
    <br>
    <blockquote type=3D"cite"><br>
      <div class=3D"gmail_quote">
        <div dir=3D"ltr" class=3D"gmail_attr">On Thu, Apr 11, 2019 at 6:20
          PM Armin Kuster &lt;<a href=3D"mailto:akuster808@gmail.com" targe=
t=3D"_blank">akuster808@gmail.com</a>&gt; wrote:<br>
        </div>
        <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">This
          is to avoid having master being updated when we branch<br>
          for a new release.<br>
          <br>
          Also, master should not be at the same version as the last<br>
          stable release.<br>
          <br>
          Signed-off-by: Armin Kuster &lt;<a href=3D"mailto:akuster808@gmai=
l.com" target=3D"_blank">akuster808@gmail.com</a>&gt;<br>
          ---<br>
          =C2=A0bin/bitbake=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 +-<br>
          =C2=A0lib/bb/__init__.py | 2 +-<br>
          =C2=A02 files changed, 2 insertions(+), 2 deletions(-)<br>
          <br>
          diff --git a/bin/bitbake b/bin/bitbake<br>
          index 57dec2a..952c47e 100755<br>
          --- a/bin/bitbake<br>
          +++ b/bin/bitbake<br>
          @@ -38,7 +38,7 @@ from bb.main import bitbake_main,
          BitBakeConfigParameters, BBMainException<br>
          =C2=A0if sys.getfilesystemencoding() !=3D &quot;utf-8&quot;:<br>
          =C2=A0 =C2=A0 =C2=A0sys.exit(&quot;Please use a locale setting wh=
ich supports
          UTF-8 (such as LANG=3Den_US.UTF-8).\nPython can&#39;t change the
          filesystem locale after loading so we need a UTF-8 when Python
          starts or things won&#39;t work.&quot;)<br>
          <br>
          -__version__ =3D &quot;1.40.0&quot;<br>
          +__version__ =3D &quot;1.99.0&quot;<br>
          <br>
          =C2=A0if __name__ =3D=3D &quot;__main__&quot;:<br>
          =C2=A0 =C2=A0 =C2=A0if __version__ !=3D bb.__version__:<br>
          diff --git a/lib/bb/__init__.py b/lib/bb/__init__.py<br>
          index 4bc47c8..a86197a 100644<br>
          --- a/lib/bb/__init__.py<br>
          +++ b/lib/bb/__init__.py<br>
          @@ -21,7 +21,7 @@<br>
          =C2=A0# with this program; if not, write to the Free Software
          Foundation, Inc.,<br>
          =C2=A0# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 US=
A.<br>
          <br>
          -__version__ =3D &quot;1.40.0&quot;<br>
          +__version__ =3D &quot;1.99.0&quot;<br>
          <br>
          =C2=A0import sys<br>
          =C2=A0if sys.version_info &lt; (3, 4, 0):<br>
          -- <br>
          2.7.4<br>
          <br>
          -- <br>
          _______________________________________________<br>
          bitbake-devel mailing list<br>
          <a href=3D"mailto:bitbake-devel@lists.openembedded.org" target=3D=
"_blank">bitbake-devel@lists.openembedded.org</a><br>
          <a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake=
-devel" rel=3D"noreferrer" target=3D"_blank">http://lists.openembedded.org/=
mailman/listinfo/bitbake-devel</a><br>
        </blockquote>
      </div>
      <br clear=3D"all">
      <div><br>
      </div>
      -- <br>
      <div dir=3D"ltr" class=3D"gmail-m_3620003381146642744gmail_signature"=
>
        <div dir=3D"ltr">
          <div>
            <div dir=3D"ltr">Christopher Larson<br>
              kergoth at gmail dot com<br>
              Founder - BitBake, OpenEmbedded, OpenZaurus<br>
              Senior Software Engineer, Mentor Graphics</div>
          </div>
        </div>
      </div>
      <br>
      <fieldset class=3D"gmail-m_3620003381146642744mimeAttachmentHeader"><=
/fieldset>
    </blockquote>
    <br>
  </div>

-- <br>
_______________________________________________<br>
bitbake-devel mailing list<br>
<a href=3D"mailto:bitbake-devel@lists.openembedded.org" target=3D"_blank">b=
itbake-devel@lists.openembedded.org</a><br>
<a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-devel" re=
l=3D"noreferrer" target=3D"_blank">http://lists.openembedded.org/mailman/li=
stinfo/bitbake-devel</a><br>
</blockquote></div>

--0000000000002d4f8b0586505c45--
