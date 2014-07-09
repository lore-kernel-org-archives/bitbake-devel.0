Return-Path: <kvserr@gmail.com>
Received: from mail-ie0-f181.google.com (mail-ie0-f181.google.com
	[209.85.223.181])
	by mail.openembedded.org (Postfix) with ESMTP id E09886AC7B
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Jul 2014 10:43:41 +0000 (UTC)
Received: by mail-ie0-f181.google.com with SMTP id rp18so633451iec.40
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 09 Jul 2014 03:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-type;
	bh=nidEonw5+zNFLV+JVYge9/7kgNvfjDqZ0IhYAGIMMGk=;
	b=viw1O8gx54PmDVSb5ok9LKE2fM9I5J4DeeHQE+56FMhx0DxewCJ5R4nM9nNYtXTJit
	I6epKrvypPhr4IQudEx43O6NerzD+rZ8gdbgVU1ZXZyZ9Kj29uIqcW50Cw2iD4HRCQ1W
	S4rbcoyFGFvJUZAI32mWJNPDSiz+4+j5ycjRfL2J79qvmPHvC1u3G1YVJMazq/sxZEBq
	7irGp4T1TZM78wkzuaYeSdXFraMFuSXn11tDyly3O4C13MYyV2q4HAJEYjKXliKxIdH1
	J1XTtnSK14d7iW/EGB5xrJ1CEPwWE+mFAQjqxSSIx/IGGKkLmHT36m3OEPXchuD+x5kS
	q7Yg==
X-Received: by 10.42.37.13 with SMTP id w13mr38924892icd.13.1404902622758;
	Wed, 09 Jul 2014 03:43:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.50.38.240 with HTTP; Wed, 9 Jul 2014 03:43:22 -0700 (PDT)
In-Reply-To: <CABcZANmdpjjGExdJktZUz0owXynDmqhmLVWZnZMqq0GqWx6YRQ@mail.gmail.com>
References: <1404832184-16471-1-git-send-email-vitaliy.kharin@lge.com>
	<CABcZANmdpjjGExdJktZUz0owXynDmqhmLVWZnZMqq0GqWx6YRQ@mail.gmail.com>
From: Vitaliy Kharin <kvserr@gmail.com>
Date: Wed, 9 Jul 2014 14:43:22 +0400
Message-ID: <CAMCLREqp5Yy5zNx9TPbvUjnQ4qo2o5cG6z3RQmaEsqecU+r5LA@mail.gmail.com>
To: Christopher Larson <clarson@kergoth.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] bb.utils.which is intend to locate regular file only as it is written in comment
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
X-List-Received-Date: Wed, 09 Jul 2014 10:43:47 -0000
Content-Type: multipart/alternative; boundary=90e6ba6e8e1ec60bee04fdc06124

--90e6ba6e8e1ec60bee04fdc06124
Content-Type: text/plain; charset=UTF-8

Actually it would return true if path will be a symlink. I checked it.
Also please look at
https://docs.python.org/2/library/os.path.html#os.path.isfile
"...This follows symbolic links, so both islink()
<https://docs.python.org/2/library/os.path.html#os.path.islink> and isfile()
<https://docs.python.org/2/library/os.path.html#os.path.isfile> can be true
for the same path."


2014-07-08 22:54 GMT+04:00 Christopher Larson <clarson@kergoth.com>:

>
> On Tue, Jul 8, 2014 at 8:09 AM, Vitaliy Kharin <kvserr@gmail.com> wrote:
>
>> Signed-off-by: Vitaliy Kharin <vitaliy.kharin@lge.com>
>> ---
>>  bitbake/lib/bb/utils.py | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
>> index 0be45e1..c48b237 100644
>> --- a/bitbake/lib/bb/utils.py
>> +++ b/bitbake/lib/bb/utils.py
>> @@ -809,7 +809,7 @@ def which(path, item, direction = 0, history = False):
>>      for p in paths:
>>          next = os.path.join(p, item)
>>          hist.append(next)
>> -        if os.path.exists(next):
>> +        if os.path.isfile(next):
>>              if not os.path.isabs(next):
>>                  next = os.path.abspath(next)
>>              if history:
>>
>
> This seems questionable to me. With this, it wouldn't find symlinks, no?
> --
> Christopher Larson
> clarson at kergoth dot com
> Founder - BitBake, OpenEmbedded, OpenZaurus
> Maintainer - Tslib
> Senior Software Engineer, Mentor Graphics
>



-- 
-----------------------
Best regards,
Vitaliy Kharin

--90e6ba6e8e1ec60bee04fdc06124
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style><span style=3D"font-siz=
e:large">Actually it would return true if path will be a symlink. I checked=
 it.</span></div><div class=3D"gmail_default" style><span style=3D"font-siz=
e:large">Also please look at <a href=3D"https://docs.python.org/2/library/o=
s.path.html#os.path.isfile">https://docs.python.org/2/library/os.path.html#=
os.path.isfile</a></span></div>

<div class=3D"gmail_default" style><span style=3D"font-size:large">&quot;..=
.</span><span style=3D"color:rgb(0,0,0);font-family:sans-serif;font-size:16=
px;line-height:20.799999237060547px;text-align:justify">This follows symbol=
ic links, so both=C2=A0</span><a class=3D"" href=3D"https://docs.python.org=
/2/library/os.path.html#os.path.islink" title=3D"os.path.islink" style=3D"c=
olor:rgb(53,95,124);text-decoration:none;font-family:sans-serif;font-size:1=
6px;line-height:20.799999237060547px;text-align:justify"><tt class=3D"" sty=
le=3D"padding:0px 1px;font-size:0.95em;font-weight:bold;background-color:tr=
ansparent"><span class=3D"">islink()</span></tt></a><span style=3D"color:rg=
b(0,0,0);font-family:sans-serif;font-size:16px;line-height:20.7999992370605=
47px;text-align:justify">=C2=A0and=C2=A0</span><a class=3D"" href=3D"https:=
//docs.python.org/2/library/os.path.html#os.path.isfile" title=3D"os.path.i=
sfile" style=3D"color:rgb(53,95,124);text-decoration:none;font-family:sans-=
serif;font-size:16px;line-height:20.799999237060547px;text-align:justify"><=
tt class=3D"" style=3D"padding:0px 1px;font-size:0.95em;font-weight:bold;ba=
ckground-color:transparent"><span class=3D"">isfile()</span></tt></a><span =
style=3D"color:rgb(0,0,0);font-family:sans-serif;font-size:16px;line-height=
:20.799999237060547px;text-align:justify">=C2=A0can be true for the same pa=
th.</span><span style=3D"font-size:large">&quot;</span></div>

</div><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">2014-07=
-08 22:54 GMT+04:00 Christopher Larson <span dir=3D"ltr">&lt;<a href=3D"mai=
lto:clarson@kergoth.com" target=3D"_blank">clarson@kergoth.com</a>&gt;</spa=
n>:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div><div class=3D"h5"><div=
 class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Tue, Jul 8, 2014 a=
t 8:09 AM, Vitaliy Kharin <span dir=3D"ltr">&lt;<a href=3D"mailto:kvserr@gm=
ail.com" target=3D"_blank">kvserr@gmail.com</a>&gt;</span> wrote:<br>



<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div style=3D"overflow:hidden">Signed-off-by=
: Vitaliy Kharin &lt;<a href=3D"mailto:vitaliy.kharin@lge.com" target=3D"_b=
lank">vitaliy.kharin@lge.com</a>&gt;<br>




---<br>
=C2=A0<span>bitbake</span>/lib/bb/utils.py | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/<span>bitbake</span>/lib/bb/utils.py b/<span>bitbake</span>/li=
b/bb/utils.py<br>
index 0be45e1..c48b237 100644<br>
--- a/<span>bitbake</span>/lib/bb/utils.py<br>
+++ b/<span>bitbake</span>/lib/bb/utils.py<br>
@@ -809,7 +809,7 @@ def which(path, item, direction =3D 0, history =3D Fals=
e):<br>
=C2=A0 =C2=A0 =C2=A0for p in paths:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0next =3D os.path.join(p, item)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hist.append(next)<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0if os.path.exists(next):<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if os.path.isfile(next):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not os.path.isabs(next):=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0next =3D os.p=
ath.abspath(next)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if history:</div></blockquo=
te></div><br></div></div></div><div class=3D"gmail_extra">This seems questi=
onable to me. With this, it wouldn&#39;t find symlinks, no?<span class=3D"H=
OEnZb"><font color=3D"#888888"><br>-- <br>

Christopher Larson<br>clarson at kergoth dot com<br>

Founder - BitBake, OpenEmbedded, OpenZaurus<br>Maintainer - Tslib<br>Senior=
 Software Engineer, Mentor Graphics
</font></span></div></div>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>------------=
-----------<br>Best regards,<br>Vitaliy Kharin
</div>

--90e6ba6e8e1ec60bee04fdc06124--
