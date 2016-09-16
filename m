Return-Path: <kergoth@gmail.com>
Received: from mail-oi0-f65.google.com (mail-oi0-f65.google.com
	[209.85.218.65])
	by mail.openembedded.org (Postfix) with ESMTP id 9FE5260107
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Sep 2016 20:02:24 +0000 (UTC)
Received: by mail-oi0-f65.google.com with SMTP id w11so7645007oia.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Sep 2016 13:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=N7C67KhpSbKTNs3azBFKJzFQc5xGZ27l6f6q75xyfwk=;
	b=JvM7ASOCcSxrkf0CCwDfqt1ln8T9N5xhnxoqPSR0FnjpOwxvFfXaXlVtZhTw5A7e42
	rKug5TOUzrExCAYH3mSDCpJf6oi2rrKvDXcFixnfANr40rqzX+uzK1n+6Riw0FgSTkeW
	39bCUcMaVxvbpEEFTvOzrneoDsliKx3L7isoRwY+WMeYqBHnY5Btag/JCze/h8KnDP9B
	FrFXWJQiMUAl1Yduno5ly8iZuUsmvKUU7gVwAY+QHikaWIf+jD02wQTT1KbR7PFtYY6F
	lurRd0rHhSJ4YTPJM1nBbRf3MHtCpz7kBrXcdiJOV063fpVkyPOV3Z8zyyFjQavnJ12o
	dM0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
	:date:message-id:subject:to:cc;
	bh=N7C67KhpSbKTNs3azBFKJzFQc5xGZ27l6f6q75xyfwk=;
	b=NkahTGOryZiDBEsdVpiQQ8GhZxLDS0AtfTOjncLX3Vcju5lF2DdV6bjGuwSnayTjIz
	7kEZiyfAfyEGITbpbSDmfh9jDWYJ8j5MHKRtV0X0ERhIOwUy37OR2ohWt6u7yQZa73Hu
	3yJDvdeDJICpthT2H3OnDQ8IbVmeH/QXBeKPZDFTCPvOVq2KPmOMgYs/mQDtrnhty8ue
	sB/UZWd+hlwjwyGywx0Thgmrox2EMfga/erSXgGKjo9R88un3bmvoXIBdNvvmZsm/yyJ
	A1CKRnOpedrVKPgOV+TavurCmz6QI/azQQfh9F3R+MVTXg04eAV57sz9NZj/0yCZgxaG
	QfOg==
X-Gm-Message-State: AE9vXwPqZNQU2KrTyxzr9FsiB046rK2Xixi97an39JrS7gtEyoGlV5Bygy+KJfLa78mlWf3VEAchI8De3k7b1A==
X-Received: by 10.202.212.199 with SMTP id l190mr15274179oig.57.1474056145030; 
	Fri, 16 Sep 2016 13:02:25 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.157.13.194 with HTTP; Fri, 16 Sep 2016 13:02:04 -0700 (PDT)
In-Reply-To: <CABcZANkH_ONvZXW2b930nKTTbRqvLpyszHL=B6W4E2zEJws40g@mail.gmail.com>
References: <1473974147-29966-1-git-send-email-kergoth@gmail.com>
	<1473974147-29966-2-git-send-email-kergoth@gmail.com>
	<CABcZANkH_ONvZXW2b930nKTTbRqvLpyszHL=B6W4E2zEJws40g@mail.gmail.com>
From: Christopher Larson <chris_larson@mentor.com>
Date: Fri, 16 Sep 2016 13:02:04 -0700
X-Google-Sender-Auth: fkuHDYdgVk_lkBcDkChfSX_h92I
Message-ID: <CABcZANkOMa=UmUBXeWirhRVaP-Wq3j3dBLOr+pBS7aq1Nrww5Q@mail.gmail.com>
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
X-List-Received-Date: Fri, 16 Sep 2016 20:02:24 -0000
Content-Type: multipart/alternative; boundary=001a113de59ae7526c053ca57058

--001a113de59ae7526c053ca57058
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 16, 2016 at 9:34 AM, Christopher Larson <chris_larson@mentor.co=
m
> wrote:

> On Thu, Sep 15, 2016 at 2:15 PM, Christopher Larson <kergoth@gmail.com>
> wrote:
>
>> From: Christopher Larson <chris_larson@mentor.com>
>>
>> We don't want a traceback for this exception, we need to catch it, fire
>> TaskFailed, and return failure.
>>
>> Signed-off-by: Christopher Larson <chris_larson@mentor.com>
>> ---
>>  lib/bb/build.py | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/lib/bb/build.py b/lib/bb/build.py
>> index 28401b3..8581e72 100644
>> --- a/lib/bb/build.py
>> +++ b/lib/bb/build.py
>> @@ -575,6 +575,9 @@ def _exec_task(fn, task, d, quieterr):
>>              logger.error(str(exc))
>>              event.fire(TaskFailed(task, logfn, localdata, errprinted),
>> localdata)
>>          return 1
>> +    except bb.BBHandledException:
>> +        event.fire(TaskFailed(task, logfn, localdata, True), localdata)
>> +        return 1
>>
>
> Don=E2=80=99t merge this, v2 is forthcoming. Apparently firing the TaskFa=
iled is
> problematic if it was the TaskStarted event handler which failed, as the =
UI
> won=E2=80=99t have the pid of the task, resulting in this:
>
> Traceback (most recent call last):
>   File "/scratch/dogwood/pdk-licensing/poky/bitbake/lib/bb/ui/knotty.py",
> line 426, in main
>     helper.eventHandler(event)
>   File "/scratch/dogwood/pdk-licensing/poky/bitbake/lib/bb/ui/uihelper.py=
",
> line 48, in eventHandler
>     del self.running_tasks[event.pid]
>

This is superceded by 'bb.build: in _exec_task, catch errors from
TaskStarted=E2=80=99. Please review/apply that rather than this. Thanks.
--=20
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a113de59ae7526c053ca57058
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Fri, Sep 16, 2016 at 9:34 AM, Christopher Larson <span dir=3D"ltr">&lt;<=
a href=3D"mailto:chris_larson@mentor.com" target=3D"_blank">chris_larson@me=
ntor.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(20=
4,204,204);border-left-style:solid;padding-left:1ex"><div class=3D"gmail_ex=
tra"><span class=3D"gmail-"><div class=3D"gmail_quote">On Thu, Sep 15, 2016=
 at 2:15 PM, Christopher Larson <span dir=3D"ltr">&lt;<a href=3D"mailto:ker=
goth@gmail.com" target=3D"_blank">kergoth@gmail.com</a>&gt;</span> wrote:<b=
r><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid=
;padding-left:1ex"><div>From: Christopher Larson &lt;<a href=3D"mailto:chri=
s_larson@mentor.com" target=3D"_blank">chris_larson@mentor.com</a>&gt;<br>
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
">=C2=A0 File &quot;/scratch/dogwood/pdk-<wbr>licensing/poky/bitbake/lib/bb=
/<wbr>ui/knotty.py&quot;, line 426, in main</div><div class=3D"gmail_extra"=
>=C2=A0 =C2=A0 helper.eventHandler(event)</div><div class=3D"gmail_extra">=
=C2=A0 File &quot;/scratch/dogwood/pdk-<wbr>licensing/poky/bitbake/lib/bb/<=
wbr>ui/uihelper.py&quot;, line 48, in eventHandler</div><div class=3D"gmail=
_extra">=C2=A0 =C2=A0 del self.running_tasks[event.pid]</div></div></blockq=
uote></div><br>This is superceded by &#39;bb.build: in _exec_task, catch er=
rors from TaskStarted=E2=80=99. Please review/apply that rather than this. =
Thanks.<br>-- <br><div class=3D"gmail_signature"><div dir=3D"ltr">Christoph=
er Larson<br>kergoth at gmail dot com<br>Founder - BitBake, OpenEmbedded, O=
penZaurus<br>Maintainer - Tslib<br>Senior Software Engineer, Mentor Graphic=
s</div></div>
</div></div>

--001a113de59ae7526c053ca57058--
