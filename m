Return-Path: <WXbet@proton.me>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C4BEC5DF97
	for <webhook@archiver.kernel.org>; Wed, 26 Aug 2026 15:16:00 +0000 (UTC)
Subject: Re: [PATCH] knotty: show elapsed time on the task progress bar
To: bitbake-devel@lists.openembedded.org
From: "WXbet" <WXbet@proton.me>
X-Originating-Location: Falkenstein, Saxony, DE (49.12.78.234)
X-Originating-Platform: Windows Edge 151
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Wed, 26 Aug 2026 08:15:56 -0700
References: <CANNYZj9uDoKqqx_WV2CZ0-Q99AdRWzVUXD4idpcrZMf2Zpw28Q@mail.gmail.com> <20260819093321.3451-1-wxbet.oe@gmail.com> <DB5PR02MB1021395256F54ECB1AC5FF3CBEFAE2@DB5PR02MB10213.eurprd02.prod.outlook.com>
In-Reply-To: <DB5PR02MB1021395256F54ECB1AC5FF3CBEFAE2@DB5PR02MB10213.eurprd02.prod.outlook.com>
Message-ID: <2789044.1787757356219607465@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="rLtsf1AvrCFnz7nufPB2"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 26 Aug 2026 15:16:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20059

--rLtsf1AvrCFnz7nufPB2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 04:41 PM, Peter Kjellerstedt wrote:

>=20
> On the other hand, the progress bars that are shown during the initial
> phase before the build tasks starts all use Progressbar's own Timer
> widget. I think it makes more sense to just use progressbar.Timer()
> rather than BBTimer().

The formatting is deliberate. The running-task lines right below the bar pr=
int their time through TerminalFilter.elapsed() , e.g. 16m34s. With progres=
sbar.Timer the bar reads 0:16:34 , so the same screen would show two differ=
ent time formats. The parsing-phase bars are gone by the time the task bar =
appears, so they never compete with it.

Timer.format_time is a staticmethod and Timer defines __slots__ , so it can=
not be replaced per instance, hence the small subclass.

If you prefer consistency with progressbar's own format, this one-liner doe=
s it instead and I am happy to send it as v2:

-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 widgets =3D [' ', =
progressbar.Percentage(), ' ', progressbar.Bar()]
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0widgets =3D [' ', =
progressbar.Percentage(), ' ', progressbar.Bar(), ' ', progressbar.Timer(fo=
rmat=3D'Elapsed: %s')]

--rLtsf1AvrCFnz7nufPB2
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>On Wed, Aug 26, 2026 at 04:41 PM, Peter Kjellerstedt wrote:</div>
<div>
<blockquote>On the other hand, the progress bars that are shown during the =
initial <br />phase before the build tasks starts all use Progressbar's own=
 Timer <br />widget. I think it makes more sense to just use progressbar.Ti=
mer() <br />rather than BBTimer().</blockquote>
<p dir=3D"ltr">The formatting is deliberate. The running-task lines right b=
elow the bar print their time through <code>TerminalFilter.elapsed()</code>=
, e.g. <code>16m34s</code>. With <code>progressbar.Timer</code> the bar rea=
ds <code>0:16:34</code>, so the same screen would show two different time f=
ormats. The parsing-phase bars are gone by the time the task bar appears, s=
o they never compete with it.</p>
<p dir=3D"ltr"><code>Timer.format_time</code> is a staticmethod and <code>T=
imer</code> defines <code>__slots__</code>, so it cannot be replaced per in=
stance, hence the small subclass.</p>
<p dir=3D"ltr">If you prefer consistency with progressbar's own format, thi=
s one-liner does it instead and I am happy to send it as v2:</p>
<p dir=3D"ltr"><code>-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; widgets =3D [' ', progressbar.Percentage(), ' ', progressbar.Bar()]<br /=
>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;widgets =3D [' ',=
 progressbar.Percentage(), ' ', progressbar.Bar(), ' ', progressbar.Timer(f=
ormat=3D'Elapsed: %s')]</code></p>
</div>

--rLtsf1AvrCFnz7nufPB2--

