Received: from mail-la0-f48.google.com ([209.85.215.48])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1TtJ63-0007nt-Kb
	for bitbake-devel@lists.openembedded.org;
	Thu, 10 Jan 2013 15:27:08 +0100
Received: by mail-la0-f48.google.com with SMTP id ej20so619178lab.21
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Jan 2013 06:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type;
	bh=z+6RbauO2Jl4a8uTi16zhywL4N+hivGrJfy9q21Eo5E=;
	b=eptI4XBIgzACu2jxHJsZ7Pw5QWxHoVYKIDQG8gkbO3lzw5rgtn6suqNcQza9xvVfm5
	jxM4wCBlMFy6gu8xGw5yBCu5ozXXBH4qRDza2Kd13YhCF3AodezxWKZwYDNNZLq6Uc0E
	1kTSABiF9V+uEPrgMu/hNTQBbx4qa6Q4D2K0329L9iUiOfCwBRqk6M9rpYGi54TmL4cE
	7VCtI0zTJjevAHFZPlN83Y23M1PdalIeFrY/Edd1zYoDeIjKYxBkGyWw5OWzP+EqH4+k
	vXxEeQM8r/Fc0k3W7ZnSY463/uVLKpngSIGqUNOlI2sp8I3wegXZAadd3eUPRtLD61rw
	ARAQ==
Received: by 10.152.134.167 with SMTP id pl7mr21024050lab.36.1357827114208;
	Thu, 10 Jan 2013 06:11:54 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.112.34.10 with HTTP; Thu, 10 Jan 2013 06:11:32 -0800 (PST)
In-Reply-To: <CABcZANkgffV7FwXX4NVyBA2mm1YOg+1en9x_oidsey+AkqdGBg@mail.gmail.com>
References: <1357807596-31587-1-git-send-email-martiert@gmail.com>
	<CABcZANkgffV7FwXX4NVyBA2mm1YOg+1en9x_oidsey+AkqdGBg@mail.gmail.com>
From: Chris Larson <clarson@kergoth.com>
Date: Thu, 10 Jan 2013 07:11:32 -0700
X-Google-Sender-Auth: oO9eMkv-kR5k36Uba-oOKvDwLYQ
Message-ID: <CABcZAN=_k4LrYhi8_t35pQ3mkToJKCLO9FxKGoFQ9fB+8+M5Vg@mail.gmail.com>
To: Martin Ertsaas <martiert@gmail.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] utils.py: Use shutil.rmtree if the path we wish to remove is a directory.
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 10 Jan 2013 14:27:09 -0000
Content-Type: multipart/alternative; boundary=f46d043bd988cf0e2f04d2efc2d2

--f46d043bd988cf0e2f04d2efc2d2
Content-Type: text/plain; charset=UTF-8

On Thu, Jan 10, 2013 at 7:10 AM, Chris Larson <clarson@kergoth.com> wrote:

> On Thu, Jan 10, 2013 at 1:46 AM, Martin Ertsaas <martiert@gmail.com>wrote:
>
>> On mac, os.unlink does not remove directories, and we therefor have
>> to explicitly use shutil.rmtree if the path is a directory.
>> ---
>>  lib/bb/utils.py |    5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/lib/bb/utils.py b/lib/bb/utils.py
>> index cef0fdd..8b6d3f5 100644
>> --- a/lib/bb/utils.py
>> +++ b/lib/bb/utils.py
>> @@ -561,7 +561,10 @@ def remove(path, recurse=False):
>>      import os, errno, shutil, glob
>>      for name in glob.glob(path):
>>          try:
>> -            os.unlink(name)
>> +            if os.path.isdir(name):
>> +                shutil.rmtree(name)
>> +            else:
>> +                os.unlink(name)
>>          except OSError as exc:
>>              if recurse and exc.errno == errno.EISDIR:
>>                  shutil.rmtree(name)
>>
>
>
> Look 2 lines down, where it checks to see if the os.unlink failed due to
> it being a directory and runs shutil.rmtree if that's the case.


I'm guessing you're trying to use it without passing recurse=True.
-- 
Christopher Larson

--f46d043bd988cf0e2f04d2efc2d2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Thu, Jan 10, 2013 at 7:10 AM, Chris Larson <span dir=3D"ltr">&lt;<a href=
=3D"mailto:clarson@kergoth.com" target=3D"_blank">clarson@kergoth.com</a>&g=
t;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im"><div class=3D"gmail_quote"=
>On Thu, Jan 10, 2013 at 1:46 AM, Martin Ertsaas <span dir=3D"ltr">&lt;<a h=
ref=3D"mailto:martiert@gmail.com" target=3D"_blank">martiert@gmail.com</a>&=
gt;</span> wrote:<br>


<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div>On mac, os.unlink does not remove direc=
tories, and we therefor have<br>
to explicitly use shutil.rmtree if the path is a directory.<br>
---<br>
=C2=A0lib/bb/utils.py | =C2=A0 =C2=A05 ++++-<br>
=C2=A01 file changed, 4 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/lib/bb/utils.py b/lib/bb/utils.py<br>
index cef0fdd..8b6d3f5 100644<br>
--- a/lib/bb/utils.py<br>
+++ b/lib/bb/utils.py<br>
@@ -561,7 +561,10 @@ def remove(path, recurse=3DFalse):<br>
=C2=A0 =C2=A0 =C2=A0import os, errno, shutil, glob<br>
=C2=A0 =C2=A0 =C2=A0for name in glob.glob(path):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0os.unlink(name)<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if os.path.isdir(name):<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0shutil.rmtree(name=
)<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0os.unlink(name)<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except OSError as exc:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if recurse and exc.errno =
=3D=3D errno.EISDIR:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0shutil.rmtree=
(name)</div></blockquote></div><br><br></div>Look 2 lines down, where it ch=
ecks to see if the os.unlink failed due to it being a directory and runs sh=
util.rmtree if that&#39;s the case.</blockquote>

</div><br>I&#39;m guessing you&#39;re trying to use it without passing recu=
rse=3DTrue.<br>-- <br>Christopher Larson</div></div>

--f46d043bd988cf0e2f04d2efc2d2--
