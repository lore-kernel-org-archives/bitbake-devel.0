Return-Path: <raj.khem@gmail.com>
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com
	[209.85.222.174])
	by mail.openembedded.org (Postfix) with ESMTP id 1DBE979620
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Sep 2018 17:14:48 +0000 (UTC)
Received: by mail-qk1-f174.google.com with SMTP id z78-v6so3438187qka.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Sep 2018 10:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=EuglIs5brqO8ioQtmjc7NBR5bizan8IvZTwUzLWTjNg=;
	b=f95alhaYTufLOLDrilmHZvS5CL1AJnW6RDjG3d6tehAL7uqJ9bUV6Cu2ylBh7ML/GF
	QAidRH5PF3rC3hvwy47GmUlsMr/C7BPcZhJNW53PB39xe7xTGb6GWNI/prrcLrnQ5q0R
	wQsY2hpONyAYrTikj6Q+ds0t2Vs0qDcJ2iH8rpdCdmAI9cDyXQzMGAlN/7qpt0HhlBep
	bOgWZdfltPOeDarwOXPPBUsdaIY7Sbu/Raer+GiNiT9eZBeA2ehI+Zga72GSVD8wFEJo
	V5w2T/sohrmukVxE0Q6O2A1QD4aVkWTGfPQzVCEgc+4quR2NbT90nUx9qTGdLEj2fr7o
	2nig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=EuglIs5brqO8ioQtmjc7NBR5bizan8IvZTwUzLWTjNg=;
	b=VJ0h5bC8VExb3NNSSXYVKTVH1JgwHnxg1QbF7iE9vhwfx1HqVqVftCmgEx7J7uSf53
	QqmbujpJDet5X5N4T192zpld7Fr/5Fz/2YGpMS9MfVXBfmc6kWr1+0qv262c0LFpCRB3
	4q8I0M3DdZNExhyHZxVv39Kg4nB9UieibeMlVphW6f78bBAN9G7zqYAx+CngI5TJZrtu
	CjXoON6onMf2FnoQtGwNOJY5LCczpoJ0tJJhsvri4RaVUjFXm1RbAaaNkTeQKre4p0Se
	PY8FmXX5+Gxb2CiusniGvpGh0WLKYDVgulzDuj6wsq4pbF5zwuA4RkqIbnyZ0LHyje7f
	Nakw==
X-Gm-Message-State: APzg51B7CK8P4TPjG8r/hD3Qc249eLkS12pvudaXvfv5jStR7h98x1AS
	vaI+yWrJLouJQhwhhU8JvDJI2/QJEaC25roglJI=
X-Google-Smtp-Source: ANB0VdaHt7nU1tSA3d/eegXxV8Q9Q7g+Byt2EyBiS5nXLI+yvLOy8OMDyjdMrt7SGZTBD9PgqiQMvLm7sYA0JVs0Pys=
X-Received: by 2002:a37:9904:: with SMTP id
	b4-v6mr25027138qke.102.1537377289686; 
	Wed, 19 Sep 2018 10:14:49 -0700 (PDT)
MIME-Version: 1.0
References: <63dcdf42-1ccc-1016-e540-807115c57f2d@windriver.com>
In-Reply-To: <63dcdf42-1ccc-1016-e540-807115c57f2d@windriver.com>
From: Khem Raj <raj.khem@gmail.com>
Date: Wed, 19 Sep 2018 10:14:38 -0700
Message-ID: <CAMKF1sr4AOonV5sTrJ3Cwm_8DTEZziJ7s9X+BkY--ReBWpa2AQ@mail.gmail.com>
To: Mark Hatle <mark.hatle@windriver.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: Issues w/ gitsm fetcher and BB_NO_NETWORK
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
X-List-Received-Date: Wed, 19 Sep 2018 17:14:49 -0000
Content-Type: multipart/alternative; boundary="0000000000003ce2ed05763c8be3"

--0000000000003ce2ed05763c8be3
Content-Type: text/plain; charset="UTF-8"

Sub module paths are hard coded in .gitmodule  file and I think some how
that has to be modified or overridden

On Wed, Sep 19, 2018 at 9:25 AM Mark Hatle <mark.hatle@windriver.com> wrote:

> I've been struggling for the past few days with gitsm, and have finally
> thrown
> in the towel.
>
> What is happening is that I am trying to use the 'ostree' recipe (not
> really
> important), but that uses the gitsm fetcher against:
>
> gitsm://github.com/ostreedev/ostree.git;branch=master
>
> On a fetch the system correctly pulls down the 'ostree.git' from a local
> mirror
> I have setup.  However, it then moves to the step of configuring the
> submodules
> and fetching them, and goes out to the network and ALWAYS pulls them from
> the
> network.
>
> My mirror is setup using:
>
> PREMIRRORS_append = " \
>      gitsm://.*/.* gitsm://${LAYERDIR}/git/MIRRORNAME;protocol=file \n \
> "
>
> (my mirrors are simply local cloned bare repositories)
>
> If I modify my /etc/hosts files to point github/gitlab to 127.0.0.1, I can
> easily trigger the faults:
>
> ERROR: ostree-2018.7+gitAUTOINC+4148918655-r0 do_unpack: Fetcher failure:
> Fetch
> command export PSEUDO_DISABLED=1; ... git -c core.fsyncobjectfiles=0
> submodule
> update --init --recursive || (git -c core.fsyncobjectfiles=0 submodule sync
> --recursive && git -c core.fsyncobjectfiles=0 submodule update --init
> --recursive) failed with exit code 1, output:
> Submodule 'bsdiff' (https://github.com/mendsley/bsdiff) registered for
> path 'bsdiff'
> Submodule 'libglnx' (https://gitlab.gnome.org/GNOME/libglnx.git)
> registered for
> path 'libglnx'
> Cloning into 'bsdiff'...
> Synchronizing submodule url for 'bsdiff'
> Synchronizing submodule url for 'libglnx'
> Cloning into 'bsdiff'...
>
> fatal: unable to access 'https://github.com/mendsley/bsdiff/': Failed
> connect to
> github.com:443; Connection refused
> Clone of 'https://github.com/mendsley/bsdiff' into submodule path
> 'bsdiff' failed
> fatal: unable to access 'https://github.com/mendsley/bsdiff/': Failed
> connect to
> github.com:443; Connection refused
> Clone of 'https://github.com/mendsley/bsdiff' into submodule path
> 'bsdiff' failed
>
>
> I've tried a number of things, but so far I'm just not understanding how to
> proceed.  I assume at some point the references to the modules really need
> to
> refer to an alternative location and be fetched in, but I'm not sure that
> any of
> the existing interfaces would allow that.
>
> Any suggestions how to proceed?
>
> --Mark
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>

--0000000000003ce2ed05763c8be3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><div dir=3D"auto">Sub module paths are hard coded in .gitmodule =C2=A0=
file and I think some how that has to be modified or overridden=C2=A0</div>=
</div><div><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Wed, Sep 19, =
2018 at 9:25 AM Mark Hatle &lt;<a href=3D"mailto:mark.hatle@windriver.com">=
mark.hatle@windriver.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:=
1ex">I&#39;ve been struggling for the past few days with gitsm, and have fi=
nally thrown<br>
in the towel.<br>
<br>
What is happening is that I am trying to use the &#39;ostree&#39; recipe (n=
ot really<br>
important), but that uses the gitsm fetcher against:<br>
<br>
gitsm://<a href=3D"http://github.com/ostreedev/ostree.git;branch=3Dmaster" =
rel=3D"noreferrer" target=3D"_blank">github.com/ostreedev/ostree.git;branch=
=3Dmaster</a><br>
<br>
On a fetch the system correctly pulls down the &#39;ostree.git&#39; from a =
local mirror<br>
I have setup.=C2=A0 However, it then moves to the step of configuring the s=
ubmodules<br>
and fetching them, and goes out to the network and ALWAYS pulls them from t=
he<br>
network.<br>
<br>
My mirror is setup using:<br>
<br>
PREMIRRORS_append =3D &quot; \<br>
=C2=A0 =C2=A0 =C2=A0gitsm://.*/.* gitsm://${LAYERDIR}/git/MIRRORNAME;protoc=
ol=3Dfile \n \<br>
&quot;<br>
<br>
(my mirrors are simply local cloned bare repositories)<br>
<br>
If I modify my /etc/hosts files to point github/gitlab to 127.0.0.1, I can<=
br>
easily trigger the faults:<br>
<br>
ERROR: ostree-2018.7+gitAUTOINC+4148918655-r0 do_unpack: Fetcher failure: F=
etch<br>
command export PSEUDO_DISABLED=3D1; ... git -c core.fsyncobjectfiles=3D0 su=
bmodule<br>
update --init --recursive || (git -c core.fsyncobjectfiles=3D0 submodule sy=
nc<br>
--recursive &amp;&amp; git -c core.fsyncobjectfiles=3D0 submodule update --=
init<br>
--recursive) failed with exit code 1, output:<br>
Submodule &#39;bsdiff&#39; (<a href=3D"https://github.com/mendsley/bsdiff" =
rel=3D"noreferrer" target=3D"_blank">https://github.com/mendsley/bsdiff</a>=
) registered for path &#39;bsdiff&#39;<br>
Submodule &#39;libglnx&#39; (<a href=3D"https://gitlab.gnome.org/GNOME/libg=
lnx.git" rel=3D"noreferrer" target=3D"_blank">https://gitlab.gnome.org/GNOM=
E/libglnx.git</a>) registered for<br>
path &#39;libglnx&#39;<br>
Cloning into &#39;bsdiff&#39;...<br>
Synchronizing submodule url for &#39;bsdiff&#39;<br>
Synchronizing submodule url for &#39;libglnx&#39;<br>
Cloning into &#39;bsdiff&#39;...<br>
<br>
fatal: unable to access &#39;<a href=3D"https://github.com/mendsley/bsdiff/=
" rel=3D"noreferrer" target=3D"_blank">https://github.com/mendsley/bsdiff/<=
/a>&#39;: Failed connect to<br>
<a href=3D"http://github.com:443" rel=3D"noreferrer" target=3D"_blank">gith=
ub.com:443</a>; Connection refused<br>
Clone of &#39;<a href=3D"https://github.com/mendsley/bsdiff" rel=3D"norefer=
rer" target=3D"_blank">https://github.com/mendsley/bsdiff</a>&#39; into sub=
module path &#39;bsdiff&#39; failed<br>
fatal: unable to access &#39;<a href=3D"https://github.com/mendsley/bsdiff/=
" rel=3D"noreferrer" target=3D"_blank">https://github.com/mendsley/bsdiff/<=
/a>&#39;: Failed connect to<br>
<a href=3D"http://github.com:443" rel=3D"noreferrer" target=3D"_blank">gith=
ub.com:443</a>; Connection refused<br>
Clone of &#39;<a href=3D"https://github.com/mendsley/bsdiff" rel=3D"norefer=
rer" target=3D"_blank">https://github.com/mendsley/bsdiff</a>&#39; into sub=
module path &#39;bsdiff&#39; failed<br>
<br>
<br>
I&#39;ve tried a number of things, but so far I&#39;m just not understandin=
g how to<br>
proceed.=C2=A0 I assume at some point the references to the modules really =
need to<br>
refer to an alternative location and be fetched in, but I&#39;m not sure th=
at any of<br>
the existing interfaces would allow that.<br>
<br>
Any suggestions how to proceed?<br>
<br>
--Mark<br>
-- <br>
_______________________________________________<br>
bitbake-devel mailing list<br>
<a href=3D"mailto:bitbake-devel@lists.openembedded.org" target=3D"_blank">b=
itbake-devel@lists.openembedded.org</a><br>
<a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-devel" re=
l=3D"noreferrer" target=3D"_blank">http://lists.openembedded.org/mailman/li=
stinfo/bitbake-devel</a><br>
</blockquote></div></div>

--0000000000003ce2ed05763c8be3--
