Return-Path: <tomasz.meresinski@comarch.pl>
Received: from odzwierny1.comarch.com (odzwierny1.comarch.com [217.74.69.9])
	by mail.openembedded.org (Postfix) with ESMTP id 0320C78E7F
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 Oct 2018 18:20:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	authenticated as tomasz.meresinski@comarch.com
	by odzwierny1.comarch.com with esmtpsa (TLSv1:AES128-SHA:128)(ComArch
	ESMTP) id 1gHC9M-000D5x-Lh; Mon, 29 Oct 2018 19:20:28 +0100
To: Christopher Larson <kergoth@gmail.com>
References: <20181029163933.26646-1-tomasz.meresinski@comarch.pl>
	<20181029163933.26646-3-tomasz.meresinski@comarch.pl>
	<CABcZANk7p-Fefxi8y2P2GHa22Y=RifxA4VnWAAyGxN2vPP8pJA@mail.gmail.com>
From: =?UTF-8?Q?Tomasz_Meresi=c5=84ski?= <tomasz.meresinski@comarch.pl>
Message-ID: <8b7241f0-fdb7-4df7-a2f7-974477edd925@comarch.pl>
Date: Mon, 29 Oct 2018 19:20:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CABcZANk7p-Fefxi8y2P2GHa22Y=RifxA4VnWAAyGxN2vPP8pJA@mail.gmail.com>
X-CA-Antivirus: Scanned by ComArch Antivirus on odzwierny1.comarch.com
X-CA-Is-Spam: No
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 2/3] runqueue: Fix base class for sceneQueueComplete
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
X-List-Received-Date: Mon, 29 Oct 2018 18:20:29 -0000
X-Groupsio-MsgNum: 9716
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
	micalg=sha-256; boundary="------------ms070202060709020703000703"

--------------ms070202060709020703000703
Content-Type: multipart/alternative;
 boundary="------------406776C8CC19ECEF833C9CB6"
Content-Language: en-US

--------------406776C8CC19ECEF833C9CB6
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

All runQueueEvents are for specific task - its __init__ function has=20
task parameter and it reads more parameters from it (taskname, taskfile=20
and taskhash).
sceneQueueComplete event is fired when all tasks are complete, so for me =

it isn't a runQueueEvent, so it isn't sceneQueueEvent too.
Passing None as task is not an option, because runQueueEvent.__init__=20
will fail.

On 29.10.2018 19:05, Christopher Larson wrote:
> This looks wrong. Fix the __init__ instead.
>
> On Mon, Oct 29, 2018 at 10:22 AM Tomasz Meresi=C5=84ski=20
> <tomasz.meresinski@comarch.pl <mailto:tomasz.meresinski@comarch.pl>>=20
> wrote:
>
>     __init__ method initialized bb.event.Event not sceneQueueEvent.
>     Change base class to bb.event.Event.
>
>     Signed-off-by: Tomasz Meresi=C5=84ski <tomasz.meresinski@comarch.co=
m
>     <mailto:tomasz.meresinski@comarch.com>>
>     ---
>     =C2=A0lib/bb/runqueue.py | 2 +-
>     =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>
>     diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
>     index 9ce06c40..e138a5c2 100644
>     --- a/lib/bb/runqueue.py
>     +++ b/lib/bb/runqueue.py
>     @@ -2615,7 +2615,7 @@ class sceneQueueTaskFailed(sceneQueueEvent):
>     =C2=A0 =C2=A0 =C2=A0def __str__(self):
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return "Setscene task (%s) failed=
 with exit code '%s' -
>     real task will be run instead" % (self.taskstring, self.exitcode)
>
>     -class sceneQueueComplete(sceneQueueEvent):
>     +class sceneQueueComplete(bb.event.Event):
>     =C2=A0 =C2=A0 =C2=A0"""
>     =C2=A0 =C2=A0 =C2=A0Event when all the sceneQueue tasks are complet=
e
>     =C2=A0 =C2=A0 =C2=A0"""
>     --=20
>     2.17.1
>
>     --=20
>     _______________________________________________
>     bitbake-devel mailing list
>     bitbake-devel@lists.openembedded.org
>     <mailto:bitbake-devel@lists.openembedded.org>
>     http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>
>
>
> --=20
> Christopher Larson
> kergoth at gmail dot com
> Founder - BitBake, OpenEmbedded, OpenZaurus
> Senior Software Engineer, Mentor Graphics


--------------406776C8CC19ECEF833C9CB6
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF=
-8">
  </head>
  <body text=3D"#000000" bgcolor=3D"#FFFFFF">
    All runQueueEvents are for specific task - its __init__ function has
    task parameter and it reads more parameters from it (taskname,
    taskfile and taskhash).<br>
    sceneQueueComplete event is fired when all tasks are complete, so
    for me it isn't a runQueueEvent, so it isn't sceneQueueEvent too.<br>=

    Passing None as task is not an option, because
    runQueueEvent.__init__ will fail.<br>
    <div class=3D"moz-signature">
      <div style=3D"padding:0px 0px; margin:0 0 0px 0;
        font-family:Arial,sans-serif; color:#26437e; font-size:12px;
        text-align:left; line-height:18px;">
        <br>
      </div>
    </div>
    <div class=3D"moz-cite-prefix">On 29.10.2018 19:05, Christopher Larso=
n
      wrote:<br>
    </div>
    <blockquote type=3D"cite"
cite=3D"mid:CABcZANk7p-Fefxi8y2P2GHa22Y=3DRifxA4VnWAAyGxN2vPP8pJA@mail.gm=
ail.com">
      <meta http-equiv=3D"content-type" content=3D"text/html; charset=3DU=
TF-8">
      <div dir=3D"ltr">This looks wrong. Fix the __init__ instead.</div>
      <br>
      <div class=3D"gmail_quote">
        <div dir=3D"ltr">On Mon, Oct 29, 2018 at 10:22 AM Tomasz
          Meresi=C5=84ski &lt;<a href=3D"mailto:tomasz.meresinski@comarch=
=2Epl"
            moz-do-not-send=3D"true">tomasz.meresinski@comarch.pl</a>&gt;=

          wrote:<br>
        </div>
        <blockquote class=3D"gmail_quote" style=3D"margin:0 0 0
          .8ex;border-left:1px #ccc solid;padding-left:1ex">__init__
          method initialized bb.event.Event not sceneQueueEvent.<br>
          Change base class to bb.event.Event.<br>
          <br>
          Signed-off-by: Tomasz Meresi=C5=84ski &lt;<a
            href=3D"mailto:tomasz.meresinski@comarch.com" target=3D"_blan=
k"
            moz-do-not-send=3D"true">tomasz.meresinski@comarch.com</a>&gt=
;<br>
          ---<br>
          =C2=A0lib/bb/runqueue.py | 2 +-<br>
          =C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
          <br>
          diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py<br>
          index 9ce06c40..e138a5c2 100644<br>
          --- a/lib/bb/runqueue.py<br>
          +++ b/lib/bb/runqueue.py<br>
          @@ -2615,7 +2615,7 @@ class
          sceneQueueTaskFailed(sceneQueueEvent):<br>
          =C2=A0 =C2=A0 =C2=A0def __str__(self):<br>
          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return "Setscene task (%s) fa=
iled with exit code '%s'
          - real task will be run instead" % (self.taskstring,
          self.exitcode)<br>
          <br>
          -class sceneQueueComplete(sceneQueueEvent):<br>
          +class sceneQueueComplete(bb.event.Event):<br>
          =C2=A0 =C2=A0 =C2=A0"""<br>
          =C2=A0 =C2=A0 =C2=A0Event when all the sceneQueue tasks are com=
plete<br>
          =C2=A0 =C2=A0 =C2=A0"""<br>
          -- <br>
          2.17.1<br>
          <br>
          -- <br>
          _______________________________________________<br>
          bitbake-devel mailing list<br>
          <a href=3D"mailto:bitbake-devel@lists.openembedded.org"
            target=3D"_blank" moz-do-not-send=3D"true">bitbake-devel@list=
s.openembedded.org</a><br>
          <a
            href=3D"http://lists.openembedded.org/mailman/listinfo/bitbak=
e-devel"
            rel=3D"noreferrer" target=3D"_blank" moz-do-not-send=3D"true"=
>http://lists.openembedded.org/mailman/listinfo/bitbake-devel</a><br>
        </blockquote>
      </div>
      <br clear=3D"all">
      <div><br>
      </div>
      -- <br>
      <div dir=3D"ltr" class=3D"gmail_signature"
        data-smartmail=3D"gmail_signature">
        <div dir=3D"ltr">
          <div>
            <div dir=3D"ltr">Christopher Larson<br>
              kergoth at gmail dot com<br>
              Founder - BitBake, OpenEmbedded, OpenZaurus<br>
              Senior Software Engineer, Mentor Graphics</div>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------406776C8CC19ECEF833C9CB6--

--------------ms070202060709020703000703
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
AAAA

--------------ms070202060709020703000703--
