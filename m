Return-Path: <roro.cui@broadcom.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D81BC4706C
	for <webhook@archiver.kernel.org>; Fri, 12 Jan 2024 17:37:15 +0000 (UTC)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
 by mx.groups.io with SMTP id smtpd.web10.13983.1705081028014445300
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 12 Jan 2024 09:37:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@broadcom.com header.s=google header.b=CBGn9hqP;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: broadcom.com, ip: 209.85.167.52, mailfrom: roro.cui@broadcom.com)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50eabd1c701so8151484e87.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 12 Jan 2024 09:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1705081026; x=1705685826; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TuNTbIKU6WpY/oI7f8uDRgL3polhUsj+eh3Q53ofVDw=;
        b=CBGn9hqPD508+wt/VxUNQW6Ttz/Rij/QxQvF8I3QXmCNKKzMyuKVBqspmAQXcrN9Xe
         opdWG20sABkfu6AUj6TVAWMXMSZuMN7flk8VLdgIGz81D5KTLrf9S4/HN4591Q31HX3O
         zg2a2xTaHdcLOQbKicsXMO1cETvSbBVE5+Itc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705081026; x=1705685826;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TuNTbIKU6WpY/oI7f8uDRgL3polhUsj+eh3Q53ofVDw=;
        b=ll/gHXYDsePxcMKPIkqAxI79pYmWTR5faAOn7nX5BeB2ChBWwaJC4jwt6XY8Yt2NwZ
         e3+tfiR5E5raQxac5/Tu/b9sD2RbgW1la06LHHX8mRk3LSBikcHKShuYHiW7vR+3VySR
         ZeS/nbO6EVn0DSMfpT5JduBp/2FYeoRvc6ZkZBsAHYr9iIEq/NHPBv/2J4ptnqDi+X8n
         /6+SDD4Hc/X8DSOXGNU4Gcn2WHCT8FaM1JuBN+6Gwv80WIa4wN5PiHrBpoYfv+fVCuN+
         ev4UkO2nQkEGg+lMg8c59c1XZ/U8B3DjpgYyZvUtnOsRK5ZtJAOuxMKrHWsNUDoRwB2D
         0A4A==
X-Gm-Message-State: AOJu0Ywik2tya/OvOgDM5Xc8rJO1+d3mUQyrhykGafTSscGuaN1qdRqS
	8q/4Mv3H/C80YLylUI12RPQzFFxMI/N3KU7+L1kE1zFrAEM3Q6IPtl4/1qFF2R+jXVmdQsWpMOe
	y+T46AeKyLHVvk9rQj+2Hd6GGrlG0/Nn1vckXH8/DCQPu4iVmAFA0ozfzTiOfjA==
X-Google-Smtp-Source: AGHT+IG8CA19gjp+9sSC18hy79IurlohWsB1SXbDmaMkNvQ8rF4yHaMfZ515ickS+Gy4suzL41PzlhEqg3qUsjVj7Qg=
X-Received: by 2002:a05:6512:60a:b0:50e:6878:a715 with SMTP id
 b10-20020a056512060a00b0050e6878a715mr780207lfe.48.1705081026056; Fri, 12 Jan
 2024 09:37:06 -0800 (PST)
MIME-Version: 1.0
References: <CAHBa6FM=C=yZYEVY8yp_j8rXkZ2Fq=n-4b78N2uiFS7=6rgpOw@mail.gmail.com>
 <ff0dc8f8d2d4fd86e8d9483004ee02191aa94d64.camel@linuxfoundation.org> <17A9A9BBB897E15F.31870@lists.openembedded.org>
In-Reply-To: <17A9A9BBB897E15F.31870@lists.openembedded.org>
From: Roro Cui <roro.cui@broadcom.com>
Date: Fri, 12 Jan 2024 12:36:54 -0500
Message-ID: <CAHBa6FPyPG9oHroszumiFT-TahsmPWV8a6NNJ4e8Di48608O4g@mail.gmail.com>
Subject: Re: [bitbake-devel] Got "ValueError: filedescriptor out of range in
 select" on bitbake v1.46.0
To: roro.cui@broadcom.com
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	bitbake-devel@lists.openembedded.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000e636bb060ec31cff"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 12 Jan 2024 17:37:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15792

--000000000000e636bb060ec31cff
Content-Type: multipart/alternative; boundary="000000000000df73a4060ec31c53"

--000000000000df73a4060ec31c53
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

hi, Richard

Setting BB_NUMBER_PARSE_THREADS to 256 fixes my issue.
I am going to tune that value to see which max number triggers this kind of
problem.

Thank you very much for your help.
Roro


On Fri, Jan 12, 2024 at 12:29=E2=80=AFPM Roro Cui via lists.openembedded.or=
g
<roro.cui=3Dbroadcom.com@lists.openembedded.org> wrote:

> hi, Richard
>
> Thank you for your reply.
> I tried BB_NUMBER_THREADS before,  that does not work, since this issue
> happens during 'parsing recipes' stage.
> But I guess BB_NUMBER_PARSE_THREADS will work, let me try it.
> Will update you soon.
> roro
>
> On Fri, Jan 12, 2024 at 12:23=E2=80=AFPM Richard Purdie <
> richard.purdie@linuxfoundation.org> wrote:
>
>> On Fri, 2024-01-12 at 11:40 -0500, Roro Cui via lists.openembedded.org
>> wrote:
>> > hi, Dear Sir or Madam
>> >
>> > I hit this issue when building the target in yocto dunfell on our new
>> server(512 cpu cores)
>> > The cooker daemon process quits abnormally. Here is the output
>> >
>> > Command Completed
>> > Running command ['getVariable', 'BBINCLUDELOGS']
>> > Command Completed
>> > Running command ['getVariable', 'BBINCLUDELOGS_LINES']
>> > Command Completed
>> > Running command ['getSetVariable', 'BB_CONSOLELOG']
>> > Command Completed
>> > Running command ['getSetVariable', 'BB_LOGCONFIG']
>> > Command Completed
>> > Running command ['getUIHandlerNum']
>> > Command Completed
>> > Running command ['setEventMask', 1, 20, {'BitBake.RunQueue.HashEquiv':
>> 19, 'BitBake.SigGen.HashEquiv': 19}, ['bb.runqueue.runQueueExitWait',
>> 'bb.event.LogExecTTY', 'logging.LogRecord', 'bb.build.TaskFailed',
>> 'bb.build.TaskBase', 'bb.event.ParseStarted', 'bb.event.ParseProgress',
>> 'bb.event.ParseCompleted', 'bb.event.CacheLoadStarted',
>> 'bb.event.CacheLoadProgress', 'bb.event.CacheLoadCompleted',
>> 'bb.command.CommandFailed', 'bb.command.CommandExit',
>> 'bb.command.CommandCompleted', 'bb.cooker.CookerExit',
>> 'bb.event.MultipleProviders', 'bb.event.NoProvider',
>> 'bb.runqueue.sceneQueueTaskStarted', 'bb.runqueue.runQueueTaskStarted',
>> 'bb.runqueue.runQueueTaskFailed', 'bb.runqueue.sceneQueueTaskFailed',
>> 'bb.event.BuildBase', 'bb.build.TaskStarted', 'bb.build.TaskSucceeded',
>> 'bb.build.TaskFailedSilent', 'bb.build.TaskProgress',
>> 'bb.event.ProcessStarted', 'bb.event.ProcessProgress',
>> 'bb.event.ProcessFinished']]
>> > Command Completed
>> > Running command ['setConfig', 'cmd', 'fetch']
>> > Command Completed
>> > Running command ['buildTargets', ['quilt-native'], 'fetch']
>> > Command Completed
>> > Process ProcessServer-1:
>> > Traceback (most recent call last):
>> >   File "/usr/lib/python3.8/multiprocessing/process.py", line 315, in
>> _bootstrap
>> >     self.run()
>> >   File
>> "/local/home1/rorocui/yocto/gr_ml_20240105/openembedded-core/bitbake/lib=
/bb/server/process.py",
>> line 115, in run
>> >     ret =3D self.main()
>> >   File
>> "/local/home1/rorocui/yocto/gr_ml_20240105/openembedded-core/bitbake/lib=
/bb/server/process.py",
>> line 232, in main
>> >     ready =3D self.idle_commands(.1, fds)
>> >   File
>> "/local/home1/rorocui/yocto/gr_ml_20240105/openembedded-core/bitbake/lib=
/bb/server/process.py",
>> line 334, in idle_commands
>> >     return select.select(fds,[],[],nextsleep)[0]
>> > ValueError: filedescriptor out of range in select()
>> > Var <PATH[:=3D]>:1: SyntaxWarning: "is not" with a literal. Did you me=
an
>> "!=3D"?
>> >
>> > Is this a known issue?
>>
>> It isn't an issue we've been tracking, no. It sounds like your 512 core
>> machine has probably run more tasks that bitbake can manage correctly.
>> Try lower values of BB_NUMBER_THREADS and BB_NUMBER_PARSE_THREADS?
>>
>> You could also open a bug in bugzilla. There are probably ways to
>> improve the code to avoid select() calls but those will be invasive.
>>
>> Cheers,
>>
>> Richard
>>
>
>
> --
>
> Regards
>
> Roro Cui
>
> Principal Software Engineer, Software Engineering |  STB & CM
>
>  *Broadcom*
>
>
>
> *office:* 678.475.2897(X72897) |  *fax:* 678.475.2888
>
> 4385 River Green Parkway  |  Duluth, GA 30096
>
> roro.cui@broadcom.com <danny.zhang@broadcom.com>   |   broadcom.com
>
>
>
>
> This electronic communication and the information and any files
> transmitted with it, or attached to it, are confidential and are intended
> solely for the use of the individual or entity to whom it is addressed an=
d
> may contain information that is confidential, legally privileged, protect=
ed
> by privacy laws, or otherwise restricted from disclosure to anyone else. =
If
> you are not the intended recipient or the person responsible for deliveri=
ng
> the e-mail to the intended recipient, you are hereby notified that any us=
e,
> copying, distributing, dissemination, forwarding, printing, or copying of
> this e-mail is strictly prohibited. If you received this e-mail in error,
> please return the e-mail to the sender, delete it from your computer, and
> destroy any printed copy of it.
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15791):
> https://lists.openembedded.org/g/bitbake-devel/message/15791
> Mute This Topic: https://lists.openembedded.org/mt/103686457/8130911
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> roro.cui@broadcom.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--=20

Regards

Roro Cui

Principal Software Engineer, Software Engineering |  STB & CM

 *Broadcom*



*office:* 678.475.2897(X72897) |  *fax:* 678.475.2888

4385 River Green Parkway  |  Duluth, GA 30096

roro.cui@broadcom.com <danny.zhang@broadcom.com>   |   broadcom.com

--=20
This electronic communication and the information and any files transmitted=
=20
with it, or attached to it, are confidential and are intended solely for=20
the use of the individual or entity to whom it is addressed and may contain=
=20
information that is confidential, legally privileged, protected by privacy=
=20
laws, or otherwise restricted from disclosure to anyone else. If you are=20
not the intended recipient or the person responsible for delivering the=20
e-mail to the intended recipient, you are hereby notified that any use,=20
copying, distributing, dissemination, forwarding, printing, or copying of=
=20
this e-mail is strictly prohibited. If you received this e-mail in error,=
=20
please return the e-mail to the sender, delete it from your computer, and=
=20
destroy any printed copy of it.

--000000000000df73a4060ec31c53
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">hi, Richard<div><br></div><div>Setting=C2=A0<span style=3D=
"color:rgb(80,0,80)">BB_NUMBER_PARSE_THREADS to 256 fixes my issue.</span><=
/div><div><font color=3D"#500050">I am going to tune that value to see whic=
h max number triggers this kind of problem.</font></div><div><font color=3D=
"#500050"><br></font></div><div><font color=3D"#500050">Thank you very much=
 for your help.</font></div><div><font color=3D"#500050">Roro<br></font><di=
v><br></div></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" cla=
ss=3D"gmail_attr">On Fri, Jan 12, 2024 at 12:29=E2=80=AFPM Roro Cui via <a =
href=3D"http://lists.openembedded.org">lists.openembedded.org</a> &lt;roro.=
cui=3D<a href=3D"mailto:broadcom.com@lists.openembedded.org">broadcom.com@l=
ists.openembedded.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex"><div dir=3D"ltr">hi, Richard<div><br></div><div>Thank =
you for your reply.=C2=A0</div><div>I tried BB_NUMBER_THREADS before,=C2=A0=
 that does not work, since=C2=A0this issue happens during &#39;parsing reci=
pes&#39; stage.</div><div>But I guess BB_NUMBER_PARSE_THREADS will work, le=
t me try it.</div><div>Will update you soon.</div><div>roro</div></div><br>=
<div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Ja=
n 12, 2024 at 12:23=E2=80=AFPM Richard Purdie &lt;<a href=3D"mailto:richard=
.purdie@linuxfoundation.org" target=3D"_blank">richard.purdie@linuxfoundati=
on.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">On Fri, 2024-01-12 at 11:40 -0500, Roro Cui via <a href=3D"http://lis=
ts.openembedded.org" rel=3D"noreferrer" target=3D"_blank">lists.openembedde=
d.org</a> wrote:<br>
&gt; hi, Dear Sir or Madam<br>
&gt; <br>
&gt; I hit this issue when building the target in yocto dunfell on our new =
server(512 cpu cores)<br>
&gt; The cooker daemon=C2=A0process quits abnormally. Here is the output<br=
>
&gt; <br>
&gt; Command Completed<br>
&gt; Running command [&#39;getVariable&#39;, &#39;BBINCLUDELOGS&#39;]<br>
&gt; Command Completed<br>
&gt; Running command [&#39;getVariable&#39;, &#39;BBINCLUDELOGS_LINES&#39;]=
<br>
&gt; Command Completed<br>
&gt; Running command [&#39;getSetVariable&#39;, &#39;BB_CONSOLELOG&#39;]<br=
>
&gt; Command Completed<br>
&gt; Running command [&#39;getSetVariable&#39;, &#39;BB_LOGCONFIG&#39;]<br>
&gt; Command Completed<br>
&gt; Running command [&#39;getUIHandlerNum&#39;]<br>
&gt; Command Completed<br>
&gt; Running command [&#39;setEventMask&#39;, 1, 20, {&#39;BitBake.RunQueue=
.HashEquiv&#39;: 19, &#39;BitBake.SigGen.HashEquiv&#39;: 19}, [&#39;bb.runq=
ueue.runQueueExitWait&#39;, &#39;bb.event.LogExecTTY&#39;, &#39;logging.Log=
Record&#39;, &#39;bb.build.TaskFailed&#39;, &#39;bb.build.TaskBase&#39;, &#=
39;bb.event.ParseStarted&#39;, &#39;bb.event.ParseProgress&#39;, &#39;bb.ev=
ent.ParseCompleted&#39;, &#39;bb.event.CacheLoadStarted&#39;, &#39;bb.event=
.CacheLoadProgress&#39;, &#39;bb.event.CacheLoadCompleted&#39;, &#39;bb.com=
mand.CommandFailed&#39;, &#39;bb.command.CommandExit&#39;, &#39;bb.command.=
CommandCompleted&#39;, &#39;bb.cooker.CookerExit&#39;, &#39;bb.event.Multip=
leProviders&#39;, &#39;bb.event.NoProvider&#39;, &#39;bb.runqueue.sceneQueu=
eTaskStarted&#39;, &#39;bb.runqueue.runQueueTaskStarted&#39;, &#39;bb.runqu=
eue.runQueueTaskFailed&#39;, &#39;bb.runqueue.sceneQueueTaskFailed&#39;, &#=
39;bb.event.BuildBase&#39;, &#39;bb.build.TaskStarted&#39;, &#39;bb.build.T=
askSucceeded&#39;, &#39;bb.build.TaskFailedSilent&#39;, &#39;bb.build.TaskP=
rogress&#39;, &#39;bb.event.ProcessStarted&#39;, &#39;bb.event.ProcessProgr=
ess&#39;, &#39;bb.event.ProcessFinished&#39;]]<br>
&gt; Command Completed<br>
&gt; Running command [&#39;setConfig&#39;, &#39;cmd&#39;, &#39;fetch&#39;]<=
br>
&gt; Command Completed<br>
&gt; Running command [&#39;buildTargets&#39;, [&#39;quilt-native&#39;], &#3=
9;fetch&#39;]<br>
&gt; Command Completed<br>
&gt; Process ProcessServer-1:<br>
&gt; Traceback (most recent call last):<br>
&gt; =C2=A0 File &quot;/usr/lib/python3.8/multiprocessing/process.py&quot;,=
 line 315, in _bootstrap<br>
&gt; =C2=A0 =C2=A0 self.run()<br>
&gt; =C2=A0 File &quot;/local/home1/rorocui/yocto/gr_ml_20240105/openembedd=
ed-core/bitbake/lib/bb/server/process.py&quot;, line 115, in run<br>
&gt; =C2=A0 =C2=A0 ret =3D self.main()<br>
&gt; =C2=A0 File &quot;/local/home1/rorocui/yocto/gr_ml_20240105/openembedd=
ed-core/bitbake/lib/bb/server/process.py&quot;, line 232, in main<br>
&gt; =C2=A0 =C2=A0 ready =3D self.idle_commands(.1, fds)<br>
&gt; =C2=A0 File &quot;/local/home1/rorocui/yocto/gr_ml_20240105/openembedd=
ed-core/bitbake/lib/bb/server/process.py&quot;, line 334, in idle_commands<=
br>
&gt; =C2=A0 =C2=A0 return select.select(fds,[],[],nextsleep)[0]<br>
&gt; ValueError: filedescriptor out of range in select()<br>
&gt; Var &lt;PATH[:=3D]&gt;:1: SyntaxWarning: &quot;is not&quot; with a lit=
eral. Did you mean &quot;!=3D&quot;?<br>
&gt; <br>
&gt; Is this a known issue?=C2=A0<br>
<br>
It isn&#39;t an issue we&#39;ve been tracking, no. It sounds like your 512 =
core<br>
machine has probably run more tasks that bitbake can manage correctly.<br>
Try lower values of BB_NUMBER_THREADS and BB_NUMBER_PARSE_THREADS?<br>
<br>
You could also open a bug in bugzilla. There are probably ways to<br>
improve the code to avoid select() calls but those will be invasive.<br>
<br>
Cheers,<br>
<br>
Richard<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><div><div dir=3D"ltr"><div dir=3D"ltr"><p><a name=3D"m_-9160=
988132575224215_SignatureSanitizer_SafeHtmlFilter_UNIQUE_ID_SafeHtmlFilter_=
UNIQUE_ID_SafeHtmlFilter__MailAutoSig">Regards</a></p>

<p>Roro Cui</p>

<p>Principal<span style=3D"font-size:12.8px">=C2=A0Software Engineer</span>=
<span style=3D"color:rgb(102,102,102);font-family:Arial,sans-serif;font-siz=
e:10pt;line-height:12pt">, Software
Engineering |=C2=A0 STB &amp; CM</span><br></p><p style=3D"line-height:12pt=
"></p>

<p style=3D"line-height:12pt"><b><span style=3D"font-size:10pt;font-family:=
Arial,&quot;sans-serif&quot;;color:rgb(102,102,102)">=C2=A0</span></b><b st=
yle=3D"line-height:12pt;font-size:12.8px"><span style=3D"font-size:10pt;fon=
t-family:Arial,&quot;sans-serif&quot;;color:rgb(102,102,102)">Broadcom</spa=
n></b></p><p style=3D"line-height:12pt"></p>

<p style=3D"line-height:12pt"><b><span style=3D"font-size:10pt;font-family:=
Arial,&quot;sans-serif&quot;;color:rgb(102,102,102)">=C2=A0</span></b></p>

<p style=3D"line-height:12pt"><b><span style=3D"font-size:10pt;font-family:=
Arial,&quot;sans-serif&quot;;color:rgb(102,102,102)">office:</span></b><spa=
n style=3D"font-size:10pt;font-family:Arial,&quot;sans-serif&quot;;color:rg=
b(102,102,102)"> 678.475.2897(X72897) |=C2=A0=C2=A0<b>fax:</b>
678.475.2888</span></p>

<p style=3D"line-height:12pt"><span style=3D"font-size:10pt;font-family:Ari=
al,&quot;sans-serif&quot;;color:rgb(102,102,102)">4385 River Green Parkway=
=C2=A0
|=C2=A0 Duluth, GA 30096</span></p>

<p style=3D"line-height:12pt"><span style=3D"font-size:10pt;font-family:Ari=
al,&quot;sans-serif&quot;;color:rgb(102,102,102)">roro.cui<a href=3D"mailto=
:danny.zhang@broadcom.com" target=3D"_blank">@broadcom.com</a>=C2=A0=C2=A0
|=C2=A0=C2=A0 <a href=3D"http://broadcom.com" target=3D"_blank">broadcom.co=
m</a></span></p>

<p><br><br></p></div></div></div></div></div>

<br>
<span style=3D"background-color:rgb(255,255,255)"><font size=3D"2">This ele=
ctronic communication and the information and any files transmitted with it=
, or attached to it, are confidential and are intended solely for the use o=
f the individual or entity to whom it is addressed and may contain informat=
ion that is confidential, legally privileged, protected by privacy laws, or=
 otherwise restricted from disclosure to anyone else. If you are not the in=
tended recipient or the person responsible for delivering the e-mail to the=
 intended recipient, you are hereby notified that any use, copying, distrib=
uting, dissemination, forwarding, printing, or copying of this e-mail is st=
rictly prohibited. If you received this e-mail in error, please return the =
e-mail to the sender, delete it from your computer, and destroy any printed=
 copy of it.</font></span>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#15791): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/15791" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/15791</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/103686457/813=
0911" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/m=
t/103686457/8130911</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:roro.cui@broadcom.com" target=3D"_=
blank">roro.cui@broadcom.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><div><div dir=3D"ltr"><div dir=3D"ltr"><p><a name=3D"Signatu=
reSanitizer_SafeHtmlFilter_UNIQUE_ID_SafeHtmlFilter_UNIQUE_ID_SafeHtmlFilte=
r__MailAutoSig">Regards</a></p>

<p>Roro Cui</p>

<p>Principal<span style=3D"font-size:12.8px">=C2=A0Software Engineer</span>=
<span style=3D"color:rgb(102,102,102);font-family:Arial,sans-serif;font-siz=
e:10pt;line-height:12pt">, Software
Engineering |=C2=A0 STB &amp; CM</span><br></p><p style=3D"line-height:12pt=
"></p>

<p style=3D"line-height:12pt"><b><span style=3D"font-size:10pt;font-family:=
Arial,&quot;sans-serif&quot;;color:rgb(102,102,102)">=C2=A0</span></b><b st=
yle=3D"line-height:12pt;font-size:12.8px"><span style=3D"font-size:10pt;fon=
t-family:Arial,&quot;sans-serif&quot;;color:rgb(102,102,102)">Broadcom</spa=
n></b></p><p style=3D"line-height:12pt"></p>

<p style=3D"line-height:12pt"><b><span style=3D"font-size:10pt;font-family:=
Arial,&quot;sans-serif&quot;;color:rgb(102,102,102)">=C2=A0</span></b></p>

<p style=3D"line-height:12pt"><b><span style=3D"font-size:10pt;font-family:=
Arial,&quot;sans-serif&quot;;color:rgb(102,102,102)">office:</span></b><spa=
n style=3D"font-size:10pt;font-family:Arial,&quot;sans-serif&quot;;color:rg=
b(102,102,102)"> 678.475.2897(X72897) |=C2=A0=C2=A0<b>fax:</b>
678.475.2888</span></p>

<p style=3D"line-height:12pt"><span style=3D"font-size:10pt;font-family:Ari=
al,&quot;sans-serif&quot;;color:rgb(102,102,102)">4385 River Green Parkway=
=C2=A0
|=C2=A0 Duluth, GA 30096</span></p>

<p style=3D"line-height:12pt"><span style=3D"font-size:10pt;font-family:Ari=
al,&quot;sans-serif&quot;;color:rgb(102,102,102)">roro.cui<a href=3D"mailto=
:danny.zhang@broadcom.com" target=3D"_blank">@broadcom.com</a>=C2=A0=C2=A0
|=C2=A0=C2=A0 <a href=3D"http://broadcom.com" target=3D"_blank">broadcom.co=
m</a></span></p>

<p><br><br></p></div></div></div></div></div>

<br>
<span style=3D"background-color:rgb(255,255,255)"><font size=3D"2">This ele=
ctronic communication and the information and any files transmitted with it=
, or attached to it, are confidential and are intended solely for the use o=
f the individual or entity to whom it is addressed and may contain informat=
ion that is confidential, legally privileged, protected by privacy laws, or=
 otherwise restricted from disclosure to anyone else. If you are not the in=
tended recipient or the person responsible for delivering the e-mail to the=
 intended recipient, you are hereby notified that any use, copying, distrib=
uting, dissemination, forwarding, printing, or copying of this e-mail is st=
rictly prohibited. If you received this e-mail in error, please return the =
e-mail to the sender, delete it from your computer, and destroy any printed=
 copy of it.</font></span>
--000000000000df73a4060ec31c53--

--000000000000e636bb060ec31cff
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
6g8M+5FzwNOK8qABWIyvERn++IHszr6VRP1DOYIrKwcTXIdySMKVC8b2+/X/vrd4aEjjylm4L1YI
ic+Ru0PW1DGoP4SOz/cI6JgqCb5g3k0zAgMBAAGjggHWMIIB0jAOBgNVHQ8BAf8EBAMCBaAwgaMG
CCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29t
L2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQwQQYIKwYBBQUHMAGGNWh0dHA6
Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwME0GA1UdIARG
MEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNv
bS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8oDqGOGh0dHA6Ly9jcmwuZ2xv
YmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3JsMCAGA1UdEQQZMBeBFXJv
cm8uY3VpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9Hm
WBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUmt4+vg6vfWGlo4s+xhg/uIUXh6QwDQYJKoZIhvcN
AQELBQADggEBAAi6Tce8RlyLWDyiQb8zI5Bz7VN/nzRzHaERhpEegBGo+APfi3eBlHM3txsQBfGS
BPi3so4niNcrPbsXOrDkd15IHO6kETWkosJR8LFGLgbPeYQliEoFMznplpq8Qmf7MNq4+VFfQ1E5
kDsy3X7Prqaqaetff5GjI2Ttnvv0mWlxwLFOz/HzBSzWp9YneFG45IKXp4yRSQDjb9USiCSnXNdq
86IUPvItGIdoyuLF1vVoa4XXlPaY7b+L2R7ZL8o1qiSbdK0JdZtjAKbAMeVMt8G0MWLWjl32KJ/f
fo+2QPus07NLVJ7qItYjlECi8rdFCLKMPwBsJSWHgElBqRp8bNAxggJtMIICaQIBATBrMFsxCzAJ
BgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWdu
IEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwDfS7SIPcFCWuFyE0wDQYJYIZIAWUDBAIB
BQCggdQwLwYJKoZIhvcNAQkEMSIEIIavsIz+DIxC9kTkMLjGIMeIbGf1GiyGzDcXxNd8d62KMBgG
CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDExMjE3MzcwNlowaQYJ
KoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggq
hkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0B
AQEFAASCAQC7vedOv7tdZlnUp4Ra6+rKm5V42wxzNxqXkLHuXkqpMESi69RLX1Fmn0eQXf1OjXGU
FfAKrYj2KnCghAuMkEXv5Cm06Fl6/h/npKKL+C3jEbeqpM7woUXV431kdMUrAo61azt+6VN8yXTV
vLGtU0qD4GVbAuVDbJMPPeQWVD06LDHIhEGbroleKUrKSG+Yxxd4raHUPcclrZJAFg//Kx93Z3hs
8+79h2xIdfQ6BHKq9WlniPDrBFBjPGzyRyG1fMkuf3KrHLkPWdViEt7vVEUpxBX8eu4me8dIB7M0
2ovQfR5bw+n8+nhmWF/iX0B/GLTh6wyTwhUat54A2uevMU3H
--000000000000e636bb060ec31cff--

