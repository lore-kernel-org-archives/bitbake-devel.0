Return-Path: <kergoth@gmail.com>
Received: from mail-oi0-f68.google.com (mail-oi0-f68.google.com
	[209.85.218.68])
	by mail.openembedded.org (Postfix) with ESMTP id B30E37326D
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Sep 2016 20:04:49 +0000 (UTC)
Received: by mail-oi0-f68.google.com with SMTP id v62so3973259oig.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Sep 2016 13:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=VSYW61LFFHUOY5jRf8FvnYDBQflCylupp3paEl7bY4c=;
	b=GD3to3tvXrEfhNjvimMj4m/1Pn5ARD7F2JvWWGbbfjr9rcA1OwGZsDjOGfrFR8kaXx
	WIkmouzBvE7lpsKD00B5vjJOwgfmsATttPR3m04ckrCMHdvGuqRVxT8+ontSQUZaRL9o
	b3FaeITSX2SR5/ODGyQu0oPG3uiIpJMf8lqZ1M51sSwV93KLkWHc+lzI5XlCAN1rO3BC
	YcRpzbudPA9v3yDQKozQqjWVbHEkJNw7dnghPxkryneQePhQFqVvxM6PXRprhtU7ZHn+
	2nTURLza1dH+YlybRPffFHKyJNue/5Hg/3QK0esaKsJtOhZz8Xq2h+fnuy7cSVvnmFT8
	ocPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
	:date:message-id:subject:to:cc;
	bh=VSYW61LFFHUOY5jRf8FvnYDBQflCylupp3paEl7bY4c=;
	b=D6jEadvVG2Yn7yAs7+QCg6wtLkJpNnS8Qg3rRKt42gMZzMHOeCP/cSa/K3f8fUPaaR
	AIPiP/vYvQL7xPYhRhSXVA6p9/1LDrU0UBPuMaQTppWwJJlQ1GcwZk5uqPn7EMlQhAsS
	Sa4zfLw9WAYuqoak2nENmFV5MD9gALwo6qAhwkpzzcJuuRNQOHp2ihKE9n7i+D4Lwq5h
	Qp7AqQAyxTezJoNcnmlJ4s421TFcmnv4spIoS5RH9WPmlIzGj/TuJr7ADahido+RDz/V
	iqNmwpz9wKljIL0na+XmY8uv9uZAANACFfJWJR0Z6YNYyUJOtw9uoPOIX4AHKfSeiyOd
	0BbA==
X-Gm-Message-State: AE9vXwNaDeKO73RKyIphIP1Sc5ESSLHB9oYgZ/C+9W/p/wNVrhS2Rqavipdu6T1mF3ZevaLKgd9QmPlUOiWXdA==
X-Received: by 10.202.212.199 with SMTP id l190mr15284624oig.57.1474056290168; 
	Fri, 16 Sep 2016 13:04:50 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.157.13.194 with HTTP; Fri, 16 Sep 2016 13:04:29 -0700 (PDT)
In-Reply-To: <CABcZANkOMa=UmUBXeWirhRVaP-Wq3j3dBLOr+pBS7aq1Nrww5Q@mail.gmail.com>
References: <1473974147-29966-1-git-send-email-kergoth@gmail.com>
	<1473974147-29966-2-git-send-email-kergoth@gmail.com>
	<CABcZANkH_ONvZXW2b930nKTTbRqvLpyszHL=B6W4E2zEJws40g@mail.gmail.com>
	<CABcZANkOMa=UmUBXeWirhRVaP-Wq3j3dBLOr+pBS7aq1Nrww5Q@mail.gmail.com>
From: Christopher Larson <chris_larson@mentor.com>
Date: Fri, 16 Sep 2016 13:04:29 -0700
X-Google-Sender-Auth: w-VZXZE-QIwYBb6JjFsAyhleG8Q
Message-ID: <CABcZAN=fDFeKrMVX_yEBeFakrgkkR3b6wr0m2drHMmB7mcPQ+Q@mail.gmail.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: Re: [PATCH 2/2] bb.build: in _exec_task, catch BBHandledException
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
X-List-Received-Date: Fri, 16 Sep 2016 20:04:49 -0000
Content-Type: multipart/alternative; boundary=001a113de59a8df99e053ca57922

--001a113de59a8df99e053ca57922
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 16, 2016 at 1:02 PM, Christopher Larson <chris_larson@mentor.co=
m
> wrote:

>
> On Fri, Sep 16, 2016 at 9:34 AM, Christopher Larson <
> chris_larson@mentor.com> wrote:
>
>> On Thu, Sep 15, 2016 at 2:15 PM, Christopher Larson <kergoth@gmail.com>
>> wrote:
>>
>>> From: Christopher Larson <chris_larson@mentor.com>
>>>
>>> We don't want a traceback for this exception, we need to catch it, fire
>>> TaskFailed, and return failure.
>>>
>>> Signed-off-by: Christopher Larson <chris_larson@mentor.com>
>>> ---
>>>  lib/bb/build.py | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/lib/bb/build.py b/lib/bb/build.py
>>> index 28401b3..8581e72 100644
>>> --- a/lib/bb/build.py
>>> +++ b/lib/bb/build.py
>>> @@ -575,6 +575,9 @@ def _exec_task(fn, task, d, quieterr):
>>>              logger.error(str(exc))
>>>              event.fire(TaskFailed(task, logfn, localdata, errprinted),
>>> localdata)
>>>          return 1
>>> +    except bb.BBHandledException:
>>> +        event.fire(TaskFailed(task, logfn, localdata, True), localdata=
)
>>> +        return 1
>>>
>>
>> Don=E2=80=99t merge this, v2 is forthcoming. Apparently firing the TaskF=
ailed is
>> problematic if it was the TaskStarted event handler which failed, as the=
 UI
>> won=E2=80=99t have the pid of the task, resulting in this:
>>
>> Traceback (most recent call last):
>>   File "/scratch/dogwood/pdk-licensing/poky/bitbake/lib/bb/ui/knotty.py"=
,
>> line 426, in main
>>     helper.eventHandler(event)
>>   File "/scratch/dogwood/pdk-licensing/poky/bitbake/lib/bb/ui/uihelper.p=
y",
>> line 48, in eventHandler
>>     del self.running_tasks[event.pid]
>>
>
> This is superceded by 'bb.build: in _exec_task, catch errors from
> TaskStarted=E2=80=99. Please review/apply that rather than this. Thanks.


Sigh, was on the wrong patch. We want this one, it=E2=80=99s not superceded=
. Ignore
all this, a v2 series is forthcoming.
--=20
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a113de59a8df99e053ca57922
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Fri, Sep 16, 2016 at 1:02 PM, Christopher Larson <span dir=3D"ltr">&lt;<=
a href=3D"mailto:chris_larson@mentor.com" target=3D"_blank">chris_larson@me=
ntor.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div><di=
v><br><div class=3D"gmail_quote">On Fri, Sep 16, 2016 at 9:34 AM, Christoph=
er Larson <span dir=3D"ltr">&lt;<a href=3D"mailto:chris_larson@mentor.com" =
target=3D"_blank">chris_larson@mentor.com</a>&gt;</span> wrote:<br><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-wid=
th:1px;border-left-color:rgb(204,204,204);border-left-style:solid;padding-l=
eft:1ex"><div class=3D"gmail_extra"><span><div class=3D"gmail_quote">On Thu=
, Sep 15, 2016 at 2:15 PM, Christopher Larson <span dir=3D"ltr">&lt;<a href=
=3D"mailto:kergoth@gmail.com" target=3D"_blank">kergoth@gmail.com</a>&gt;</=
span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-le=
ft-style:solid;padding-left:1ex"><div>From: Christopher Larson &lt;<a href=
=3D"mailto:chris_larson@mentor.com" target=3D"_blank">chris_larson@mentor.c=
om</a>&gt;<br>
<br>
We don&#39;t want a traceback for this exception, we need to catch it, fire=
<br>
TaskFailed, and return failure.<br>
<br>
Signed-off-by: Christopher Larson &lt;<a href=3D"mailto:chris_larson@mentor=
.com" target=3D"_blank">chris_larson@mentor.com</a>&gt;<br>
---<br>
=C2=A0lib/bb/build.py | 3 +++<br>
=C2=A01 file changed, 3 insertions(+)<br>
<br>
diff --git a/lib/bb/build.py b/lib/bb/build.py<br>
index 28401b3..8581e72 100644<br>
--- a/lib/bb/build.py<br>
+++ b/lib/bb/build.py<br>
@@ -575,6 +575,9 @@ def _exec_task(fn, task, d, quieterr):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0logger.error(str(exc))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0event.fire(TaskFailed(task,=
 logfn, localdata, errprinted), localdata)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 1<br>
+=C2=A0 =C2=A0 except bb.BBHandledException:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 event.fire(TaskFailed(task, logfn, localdata, =
True), localdata)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1</div></blockquote></div><br></span>Do=
n=E2=80=99t merge this, v2 is forthcoming. Apparently firing the TaskFailed=
 is problematic if it was the TaskStarted event handler which failed, as th=
e UI won=E2=80=99t have the pid of the task, resulting in this:</div><div c=
lass=3D"gmail_extra"><br></div><div class=3D"gmail_extra"><div class=3D"gma=
il_extra">Traceback (most recent call last):</div><div class=3D"gmail_extra=
">=C2=A0 File &quot;/scratch/dogwood/pdk-licensin<wbr>g/poky/bitbake/lib/bb=
/ui/knott<wbr>y.py&quot;, line 426, in main</div><div class=3D"gmail_extra"=
>=C2=A0 =C2=A0 helper.eventHandler(event)</div><div class=3D"gmail_extra">=
=C2=A0 File &quot;/scratch/dogwood/pdk-licensin<wbr>g/poky/bitbake/lib/bb/u=
i/uihel<wbr>per.py&quot;, line 48, in eventHandler</div><div class=3D"gmail=
_extra">=C2=A0 =C2=A0 del self.running_tasks[event.pid]</div></div></blockq=
uote></div><br></div></div>This is superceded by &#39;bb.build: in _exec_ta=
sk, catch errors from TaskStarted=E2=80=99. Please review/apply that rather=
 than this. Thanks.</blockquote></div><br>Sigh, was on the wrong patch. We =
want this one, it=E2=80=99s not superceded. Ignore all this, a v2 series is=
 forthcoming.<br>-- <br><div data-smartmail=3D"gmail_signature"><div dir=3D=
"ltr">Christopher Larson<br>kergoth at gmail dot com<br>Founder - BitBake, =
OpenEmbedded, OpenZaurus<br>Maintainer - Tslib<br>Senior Software Engineer,=
 Mentor Graphics</div></div>
</div></div>

--001a113de59a8df99e053ca57922--
