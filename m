Return-Path: <alexandru.damian@intel.com>
Received: from mail-oa0-f43.google.com (mail-oa0-f43.google.com
	[209.85.219.43])
	by mail.openembedded.org (Postfix) with ESMTP id EB5D460D27
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  6 Jan 2014 17:19:12 +0000 (UTC)
Received: by mail-oa0-f43.google.com with SMTP id m1so1412614oag.16
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 06 Jan 2014 09:19:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type;
	bh=L+0RYupv1hRpROxvokbcrGpBhk6lkYxX3ZRPvbfJA+4=;
	b=fMk2ru/WvbhFgVCFrL1aelrcEBrk7RWsyXXYS5oYoE16dOaz7haKST/DWQqF2by39l
	STeZkb/WyppBBH5BVfyaydOvOiuaTHavHcQVYmSg6Nl5KgHI77Kj0lxixl2ae9Nb/iIs
	/GeTRQb/yYJjBkoH4/f+NhuRlVGcfPTyTfQw3BY2Giw1AmDu8kzk23GaHL2J4pJqAQQa
	Ycxd1uSFuXV0WsubR2jnir1hQahfkXWNT0SGfV9kX337ebvMnWgWtsraDzp2y+hBs9n/
	wF0x5jXHlFJTT1ykQilsuSZ8zyFJAgMNXjy0GAeSWs3EBvtkfGlIZtuCJnBtOlAxLP8C
	jXQQ==
X-Gm-Message-State: ALoCoQl4DN0s8H+M4HJPGq1SAKvF12cAhqImFjmtueAqNzz+6ASAD9PtUNP/4kmJyajJ4CXwey4F
X-Received: by 10.60.124.138 with SMTP id mi10mr2077382oeb.57.1389028753707;
	Mon, 06 Jan 2014 09:19:13 -0800 (PST)
MIME-Version: 1.0
Received: by 10.76.86.193 with HTTP; Mon, 6 Jan 2014 09:18:53 -0800 (PST)
In-Reply-To: <52C6CC5B.1040800@windriver.com>
References: <CAJ2CSBtesiTjc-0m6jSVwuTX0QZto=YgXNH0UzoZFc6qPK=M0g@mail.gmail.com>
	<52C6C6F9.70007@windriver.com> <52C6CC5B.1040800@windriver.com>
From: "Damian, Alexandru" <alexandru.damian@intel.com>
Date: Mon, 6 Jan 2014 17:18:53 +0000
Message-ID: <CAJ2CSBsc580BuPp1fbvNs98nMDcfqMu3ZUBWOUCgV4unjLKxcw@mail.gmail.com>
To: Jason Wessel <jason.wessel@windriver.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: about oe-init-build-env: Allow startup with and without memres
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
X-List-Received-Date: Mon, 06 Jan 2014 17:19:13 -0000
Content-Type: multipart/alternative; boundary=047d7b5d5fba7322b504ef5075cc

--047d7b5d5fba7322b504ef5075cc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Thanks for replying.

I think that we're talking about different problems. What is see is:

- source oe-init-build-env and then launch toaster (source toaster start)
in a terminal; this will start a server and set BBSERVER in that terminal
- open a second terminal and source oe-init-build-env;  this will kill the
started server and leave the toaster in an inconsistent state

I'm wondering why we shutdown any bitbake server if the BBSERVER variable
is not set (last 8 lines of oe-init-build-env) ? I'm not sure I get the
reasoning behind this.
Is the idea to source oe-init-build-env after manually setting BBSERVER
variable in the second terminal ?

Alex


On Fri, Jan 3, 2014 at 2:42 PM, Jason Wessel <jason.wessel@windriver.com>wr=
ote:

>  On 01/03/2014 08:19 AM, Jason Wessel wrote:
>
> On 01/03/2014 07:09 AM, Damian, Alexandru wrote:
>
> Hi Jason,
>
>  I noticed that this patch *oe-init-build-env: Allow startup with and
> without memres* will kill any existing bitbake server when
> oe-init-build-env is started. I think this always happens since I see no
> way to source oe-init-build-env when BBSERVER is set.
>
>  I'm trying to figure out a better solution, since simply stopping the
> server will leave toaster in an inconsistent state, if the server was
> started through toaster.
>
>  Can you please tell me what behaviour are you trying to get out of the
> system ? Let's try to find something that will also work for Toaster.
>
>
>
> It seems to me there must be a corner case, which should be easy enough t=
o
> fix.  If the BBSERVER is set, it should simply attach to the existing
> instance, assuming the instance is reachable.  There is some code that wa=
s
> added to validate the bitbake server instance is healthy or it will get
> shutdown.
>
> Do you have a step by step set of instructions to duplicate the behavior
> you are inquiring about or a bugzilla case I can take a peek at?
>
>
>
> I took a look at the code, you asked about and I believe the fix is quite
> simple.
>
>
> 2013-10-04 14:14 Richard Purdie     5cc4d31    =E2=94=82    if [ -n "$BBS=
ERVER" ];
> then
> 2013-10-04 14:14 Richard Purdie     5cc4d31    =E2=94=82       unset BBSE=
RVER
> 2013-10-04 14:14 Richard Purdie     5cc4d31    =E2=94=82    fi
>
>
> I had not noticed this environment variable change.  When all the logic
> for dealing with BBSERVER was moved into the bitbake startup sequence it =
is
> no longer needed.  In fact, a bit further down in the in same file there =
is
> a check to deal with not killing anything when BBSERVER is set, but if it
> was already purged by the prior code there in lies the problem.
>
> See the attached patch.
>
> Cheers,
> Jason.
>
>
>


--=20
Alex Damian
Yocto Project
SSG / OTC

--047d7b5d5fba7322b504ef5075cc
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Thanks for replying.</div><div><br></div>I think that=
 we&#39;re talking about different problems. What is see is:<div><br></div>=
<div>- source oe-init-build-env and then launch toaster (source toaster sta=
rt) in a terminal; this will start a server and set BBSERVER in that termin=
al</div>

<div>- open a second terminal and source oe-init-build-env; =C2=A0this will=
 kill the started server and leave the toaster in an inconsistent state</di=
v><div><br></div><div>I&#39;m wondering why we shutdown any bitbake server =
if the BBSERVER variable is not set (last 8 lines of oe-init-build-env) ? I=
&#39;m not sure I get the reasoning behind this.</div>

<div>Is the idea to source oe-init-build-env after manually setting BBSERVE=
R variable in the second terminal ?</div><div><br></div><div>Alex</div></di=
v><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On Fri, Jan=
 3, 2014 at 2:42 PM, Jason Wessel <span dir=3D"ltr">&lt;<a href=3D"mailto:j=
ason.wessel@windriver.com" target=3D"_blank">jason.wessel@windriver.com</a>=
&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
 =20
   =20
 =20
  <div bgcolor=3D"#FFFFFF" text=3D"#000000"><div><div class=3D"h5">
    <div>On 01/03/2014 08:19 AM, Jason Wessel
      wrote:<br>
    </div>
    <blockquote type=3D"cite">
     =20
      <div>On 01/03/2014 07:09 AM, Damian,
        Alexandru wrote:<br>
      </div>
      <blockquote type=3D"cite">
        <div dir=3D"ltr">Hi Jason,
          <div><br>
          </div>
          <div>I noticed that this patch *oe-init-build-env: Allow
            startup with and without memres* will kill any existing
            bitbake server when oe-init-build-env is started. I think
            this always happens since I see no way to source
            oe-init-build-env when BBSERVER is set.</div>
          <div><br>
          </div>
          <div>I&#39;m trying to figure out a better solution, since simply
            stopping the server will leave toaster in an inconsistent
            state, if the server was started through toaster.</div>
          <div><br>
          </div>
          <div>Can you please tell me what behaviour are you trying to
            get out of the system ? Let&#39;s try to find something that
            will also work for Toaster.</div>
        </div>
      </blockquote>
      <br>
      <br>
      It seems to me there must be a corner case, which should be easy
      enough to fix.=C2=A0 If the BBSERVER is set, it should simply attach =
to
      the existing instance, assuming the instance is reachable.=C2=A0 Ther=
e
      is some code that was added to validate the bitbake server
      instance is healthy or it will get shutdown.<br>
      <br>
      Do you have a step by step set of instructions to duplicate the
      behavior you are inquiring about or a bugzilla case I can take a
      peek at?<br>
    </blockquote>
    <br>
    <br></div></div>
    I took a look at the code, you asked about and I believe the fix is
    quite simple.<br>
    <br>
    <br>
    2013-10-04 14:14 Richard Purdie=C2=A0=C2=A0=C2=A0=C2=A0 5cc4d31=C2=A0=
=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0=C2=A0 if [ -n
    &quot;$BBSERVER&quot; ]; then<br>
    2013-10-04 14:14 Richard Purdie=C2=A0=C2=A0=C2=A0=C2=A0 5cc4d31=C2=A0=
=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unset
    BBSERVER<br>
    2013-10-04 14:14 Richard Purdie=C2=A0=C2=A0=C2=A0=C2=A0 5cc4d31=C2=A0=
=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0=C2=A0 fi<br>
    <br>
    <br>
    I had not noticed this environment variable change.=C2=A0 When all the
    logic for dealing with BBSERVER was moved into the bitbake startup
    sequence it is no longer needed.=C2=A0 In fact, a bit further down in t=
he
    in same file there is a check to deal with not killing anything when
    BBSERVER is set, but if it was already purged by the prior code
    there in lies the problem.<br>
    <br>
    See the attached patch.<br>
    <br>
    Cheers,<br>
    Jason.<br>
    <br>
    <br>
  </div>

</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div dir=3D"=
ltr">Alex Damian<div>Yocto Project<br></div><div>SSG / OTC=C2=A0</div></div=
>
</div>

--047d7b5d5fba7322b504ef5075cc--
