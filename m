Return-Path: <avery.brian@gmail.com>
Received: from mail-it0-f66.google.com (mail-it0-f66.google.com
	[209.85.214.66])
	by mail.openembedded.org (Postfix) with ESMTP id D209A601A4
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  9 Jul 2016 17:10:42 +0000 (UTC)
Received: by mail-it0-f66.google.com with SMTP id u186so6875896ita.1
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 09 Jul 2016 10:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=u7fU7EfKdCqLxUm9LqND4bwkpTm2Gdm49zw3tpyxDBI=;
	b=WwKsrW16SxtG4QUJ3P2sccfDNIr20xUDmwTk1GUUWtGLVO3G5nDlGbH6WMduN4u+2N
	oLvCvXM0Nx/lSkyirJ++BK4HE/BN7dB5doIeAB+Iy1Ldx3BE1+m6dnql23z9tFItCmHG
	Wo5fET71nbnBPX5VFIAezFEQZTLTTTRZNUo0O3FDWipyfizlVRbvT5960TDgjNMQpwEv
	axFIXiTmsnJYtntLgl/5Nx8sC9TnJC1XaVvLisG0Odq/QHZRkhd9kNOdI3dfT7XeCBmt
	+f/VP0CCrivCY+OJz8ZjY5hZqT2WyNrdM5a/zBvplr0u4K0WCnYDvjk8CzGaxVzyQp9a
	v/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=u7fU7EfKdCqLxUm9LqND4bwkpTm2Gdm49zw3tpyxDBI=;
	b=Qagq0wzmAeio6qie7jm95Yku+EhDKzqST4tyEXWWONBTLYdwohK3YC0SCWHJwS1u6q
	Ch1vZXP5t6WVT0a61egkTVPeIBYF5JHA8Dy/Q/Ymp37ZRlvuDZSBl61IuwhkO50pJMUC
	xPkkdcZ/gAzpsKsOyLcLJECLnvc3YRmCJDMszREKd8t3YUAbfLCOfnXxgdl2neUwSQK7
	Hli6KI5CBilG5Q+1i2liUdcTGT3/aXOfc7wgxDwIlm+BzIqw/v45cnB3jAViS0jjX1kl
	hCOIQ4k1wrkSrD2Ow9UXc0O/5F0vIsCTAajp2lrYMRiaoRxlDg3lrq+1tFn/9chqKNpm
	m5ew==
X-Gm-Message-State: ALyK8tJUDTgoCPtnpkRFApG/tMRl17DdVKIGnXjPck8vx2zTQ8/jLVlifC8X9oJeQSQHcXOF67MxlumJc+Qt4g==
X-Received: by 10.36.19.138 with SMTP id 132mr8909643itz.76.1468084243213;
	Sat, 09 Jul 2016 10:10:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.18.35 with HTTP; Sat, 9 Jul 2016 10:10:42 -0700 (PDT)
In-Reply-To: <CABcZANnHUGwrvoRdYmmpA_=Z5gfkT3Rbyxc9gnR8U71Ekj7gGg@mail.gmail.com>
References: <cover.1468024992.git.brian.avery@intel.com>
	<fb5a436289d7cfd1c86e0308b996e1db36ae63bb.1468024992.git.brian.avery@intel.com>
	<CABcZANnHUGwrvoRdYmmpA_=Z5gfkT3Rbyxc9gnR8U71Ekj7gGg@mail.gmail.com>
From: Brian Avery <avery.brian@gmail.com>
Date: Sat, 9 Jul 2016 10:10:42 -0700
Message-ID: <CAKV_0ejAMmB280o9FuHUs8iz5Hwhb=HFY-TKutKuheNCMZ=AzQ@mail.gmail.com>
To: Christopher Larson <clarson@kergoth.com>
Cc: brian avery <brian.avery@intel.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, "Bartosh,
	Eduard" <eduard.bartosh@intel.com>
Subject: Re: [PATCH 1/7] runqueue: improve exception logging
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
X-List-Received-Date: Sat, 09 Jul 2016 17:10:43 -0000
Content-Type: multipart/alternative; boundary=001a11446074d14b14053736ff2e

--001a11446074d14b14053736ff2e
Content-Type: text/plain; charset=UTF-8

If you mean something like:

        logger.exception("Ed's message is this err = '%s'"
%(err),exc_info=err)

or

        logger.exception("Ed's message is this err = '%s'"
%(err),exc_info=err,stack_info=True) (if we want to see the exception stack
search)


Then, i'd agree your way is better/clearer.

-b

an intel employee

On Fri, Jul 8, 2016 at 9:03 PM, Christopher Larson <clarson@kergoth.com>
wrote:

>
> On Fri, Jul 8, 2016 at 5:52 PM, brian avery <avery.brian@gmail.com> wrote:
>
>> From: Ed Bartosh <ed.bartosh@linux.intel.com>
>>
>> Runqueue errors direct the user to view the "failure below",
>> but no additional error message is available.
>>
>> Log the stacktrace so that the user can see what went wrong.
>>
>> Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
>> Signed-off-by: brian avery <brian.avery@intel.com>
>> ---
>>  lib/bb/runqueue.py | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
>> index 57be15a..04f2f4c 100644
>> --- a/lib/bb/runqueue.py
>> +++ b/lib/bb/runqueue.py
>> @@ -1219,8 +1219,10 @@ class RunQueue:
>>                  pass
>>              self.state = runQueueComplete
>>              raise
>> -        except:
>> -            logger.error("An uncaught exception occured in runqueue,
>> please see the failure below:")
>> +        except Exception as err:
>> +            import traceback
>> +            logger.error("An uncaught exception occured in runqueue:
>> '%s'" % err)
>> +            logger.error(traceback.format_exc())
>>
>
> Is there a reason we aren't just passing the exception in and letting the
> logging format it and pass it through to the UI for formatting? See
> logger.exception() and the exc_info= keyword argument for error().
> --
> Christopher Larson
> clarson at kergoth dot com
> Founder - BitBake, OpenEmbedded, OpenZaurus
> Maintainer - Tslib
> Senior Software Engineer, Mentor Graphics
>

--001a11446074d14b14053736ff2e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">If you mean something like:<div>







<p class=3D""><span class=3D"">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0logger.exce=
ption(</span><span class=3D"">&quot;Ed&#39;s message is this err =3D &#39;%=
s&#39;&quot;</span><span class=3D"">%(err),exc_info=3Derr</span><span class=
=3D"">)</span></p><p class=3D""><span class=3D"">or</span></p><p class=3D""=
><span class=3D"">







</span></p><p class=3D""><span class=3D"">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0=
logger.exception(</span><span class=3D"">&quot;Ed&#39;s message is this err=
 =3D &#39;%s&#39;&quot;</span><span class=3D"">%(err),exc_info=3Derr,stack_=
info=3D</span><span class=3D"">True</span><span class=3D"">) (if we want to=
 see the exception stack search)</span></p><p class=3D""><span class=3D""><=
br></span></p><p class=3D""><span class=3D"">Then, i&#39;d agree your way i=
s better/clearer.</span></p><p class=3D"">-b<br></p><p class=3D"">an intel =
employee</p></div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_=
quote">On Fri, Jul 8, 2016 at 9:03 PM, Christopher Larson <span dir=3D"ltr"=
>&lt;<a href=3D"mailto:clarson@kergoth.com" target=3D"_blank">clarson@kergo=
th.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"=
ltr"><div class=3D"gmail_extra"><span class=3D""><br><div class=3D"gmail_qu=
ote">On Fri, Jul 8, 2016 at 5:52 PM, brian avery <span dir=3D"ltr">&lt;<a h=
ref=3D"mailto:avery.brian@gmail.com" target=3D"_blank">avery.brian@gmail.co=
m</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div>From: Ed Bar=
tosh &lt;<a href=3D"mailto:ed.bartosh@linux.intel.com" target=3D"_blank">ed=
.bartosh@linux.intel.com</a>&gt;<br>
<br>
Runqueue errors direct the user to view the &quot;failure below&quot;,<br>
but no additional error message is available.<br>
<br>
Log the stacktrace so that the user can see what went wrong.<br>
<br>
Signed-off-by: Ed Bartosh &lt;<a href=3D"mailto:ed.bartosh@linux.intel.com"=
 target=3D"_blank">ed.bartosh@linux.intel.com</a>&gt;<br>
Signed-off-by: brian avery &lt;<a href=3D"mailto:brian.avery@intel.com" tar=
get=3D"_blank">brian.avery@intel.com</a>&gt;<br>
---<br>
=C2=A0lib/<span>bb</span>/runqueue.py | 6 ++++--<br>
=C2=A01 file changed, 4 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/lib/<span>bb</span>/runqueue.py b/lib/<span>bb</span>/runqueue=
.py<br>
index 57be15a..04f2f4c 100644<br>
--- a/lib/<span>bb</span>/runqueue.py<br>
+++ b/lib/<span>bb</span>/runqueue.py<br>
@@ -1219,8 +1219,10 @@ <span>class</span> RunQueue:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pass<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.state =3D runQueueComp=
lete<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 except:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 logger.error(&quot;An uncaught e=
xception occured in runqueue, please see the failure below:&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 except Exception as err:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 import traceback<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 logger.error(&quot;An uncaught e=
xception occured in runqueue: &#39;%s&#39;&quot; % err)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 logger.error(traceback.format_ex=
c())</div></blockquote></div><br></span>Is there a reason we aren&#39;t jus=
t passing the exception in and letting the logging format it and pass it th=
rough to the UI for formatting? See logger.exception() and the exc_info=3D =
keyword argument for error().<span class=3D"HOEnZb"><font color=3D"#888888"=
><br>-- <br><div data-smartmail=3D"gmail_signature">Christopher Larson<br>c=
larson at kergoth dot com<br>Founder - BitBake, OpenEmbedded, OpenZaurus<br=
>Maintainer - Tslib<br>Senior Software Engineer, Mentor Graphics</div>
</font></span></div></div>
</blockquote></div><br></div>

--001a11446074d14b14053736ff2e--
