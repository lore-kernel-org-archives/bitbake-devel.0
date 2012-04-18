Received: from mail-pz0-f51.google.com ([209.85.210.51])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1SKe6n-0005wl-Hf
	for bitbake-devel@lists.openembedded.org;
	Thu, 19 Apr 2012 01:16:21 +0200
Received: by dadz8 with SMTP id z8so10291289dad.10
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Apr 2012 16:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=date:from:to:cc:message-id:in-reply-to:references:subject:x-mailer
	:mime-version:content-type;
	bh=Zuz3JXh1jy/V/fKJ6OMQHC2A9GLnmRprUZGzVrNy0cE=;
	b=romCe2qtsaEYuoYbqp6QtIwK0dq0c86Eg05sSoVl/+uEv4mW1jmjDd+qZCw5CAfTao
	E80MIbpt/NIA37+zd225D3pKhv/3zp9pGuNm4RNgMSAhDjvJZO0iec29jsrzlPpZEDiR
	t8oC59Ab4n1y/cyNeWEhBc1tPAz7LST0cpm33tHtW2kTPMTYJ5dPcW7wa6tWvP6kQipz
	rqymbxsHzoqVWnxMWmmW5wIW+/BFDwvsG/S3UjRAlXcTdamwuob683jM4yICJTuDVMuL
	4ymnAmXKk8hW2c8lHtxglCN8LDar/6Bvhv36snx1wdMc1BCUMYR+iefk+2sP4/7RhV3t
	vaAg==
Received: by 10.68.235.106 with SMTP id ul10mr9769600pbc.144.1334790412802;
	Wed, 18 Apr 2012 16:06:52 -0700 (PDT)
Received: from frey.local (ip68-110-79-242.ph.ph.cox.net. [68.110.79.242])
	by mx.google.com with ESMTPS id l1sm408531pbe.54.2012.04.18.16.06.51
	(version=TLSv1/SSLv3 cipher=OTHER);
	Wed, 18 Apr 2012 16:06:51 -0700 (PDT)
Date: Wed, 18 Apr 2012 16:06:49 -0700
From: Christopher Larson <kergoth@gmail.com>
To: Daniel Lazzari <dlazzari@leapfrog.com>
Message-ID: <671D7BD596E04EE1961D6EA1C734C816@gmail.com>
In-Reply-To: <E7A9054A5ACABE48B0E540E46E862B0F0427C336@NAEMMAIL01.na.leapfrog.com>
References: <E7A9054A5ACABE48B0E540E46E862B0F0427C336@NAEMMAIL01.na.leapfrog.com>
X-Mailer: sparrow 1.5 (build 1043.1)
MIME-Version: 1.0
Cc: "=?utf-8?Q?'bitbake-devel=40lists.openembedded.org'_\(bitbake-devel=40lists.openembedded.org\)?="
	<bitbake-devel@lists.openembedded.org>
Subject: Re: python function used in variable expansion called multiple times per recipe
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
X-List-Received-Date: Wed, 18 Apr 2012 23:16:22 -0000
Content-Type: multipart/alternative; boundary="4f8f4909_74b0dc51_8fe"

--4f8f4909_74b0dc51_8fe
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

${@} contents are evaluated when the variable is expanded. Variables are expanded when they're used, much in the way they are in makefiles. Use := to force immediate expansion, or don't use ${@} (alternatives, anonymous python function or event handler).

-- 
Christopher Larson


On Wednesday, April 18, 2012 at 2:21 PM, Daniel Lazzari wrote:

> Hi everyone,
> 
> I've been wrestling with this problem for over a day now so I figured it's time to call in the cavalry.
> I have a class in our layer that needs to fill in a variable (EXTERNPV) with information about svn externals in a project. This process can be very time consuming and resource intensive so I would prefer that it only happen once per run. Unfortunately, it seems to run 5 times for each recipe that inherits the class. You can easily duplicate the behavior I see with the following:
> 
> def testFunc(bb, d):
> print( bb.data.getVar("PN", d, True) )
> return "e1"
> 
> EXTERNPV = "${@testFunc(bb, d)}"
> 
> Am I doing something wrong? Is there some assignment operator I can use to ensure this only has to be done once? Or maybe a variable flag?
> 
> As always, I very much appreciate the help.
> 
> Dan Lazzari Jr.
> Firmware Engineer
> dlazzari@leapfrog.com (mailto:dlazzari@leapfrog.com)
> 
> 
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org (mailto:bitbake-devel@lists.openembedded.org)
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel
> 
> 



--4f8f4909_74b0dc51_8fe
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


                <div style=3D=22font-family: Helvetica; font-size: 13px; =
=22>=24=7B=40=7D contents are evaluated when the variable is expanded. Va=
riables are expanded when they're used, much in the way they are in makef=
iles. Use :=3D to force immediate expansion, or don't use =24=7B=40=7D (a=
lternatives, anonymous python function or event handler).<br></div>
                <div><div><br></div><div>--&nbsp;</div><div>Christopher L=
arson</div><div><br></div></div>
                =20
                <p style=3D=22color: =23A0A0A8;=22>On Wednesday, April 18=
, 2012 at 2:21 PM, Daniel Lazzari wrote:</p>
                <blockquote type=3D=22cite=22 style=3D=22border-left-styl=
e:solid;border-width:1px;margin-left:0px;padding-left:10px;=22>
                    <span><div><div><div>Hi everyone,</div><div><br></div=
><div>I've been wrestling with this problem for over a day now so I figur=
ed it's time to call in the cavalry.</div><div>I have a class in our laye=
r that needs to fill in a variable (EXTERNPV) with information about svn =
externals in a project. This process can be very time consuming and resou=
rce intensive so I would prefer that it only happen once per run. Unfortu=
nately, it seems to run 5 times for each recipe that inherits the class. =
You can easily duplicate the behavior  I see with the following:</div><di=
v><br></div><div>def test=46unc(bb, d):</div><div>	print( bb.data.getVar(=
=22PN=22, d, True) )</div><div>	return =22e1=22</div><div><br></div><div>=
EXTERNPV =3D =22=24=7B=40test=46unc(bb, d)=7D=22</div><div><br></div><div=
>Am I doing something wrong=3F Is there some assignment operator I can us=
e to ensure this only has to be done once=3F Or maybe a variable flag=3F<=
/div><div><br></div><div>As always, I very much appreciate the help.</div=
><div><br></div><div>Dan Lazzari Jr.</div><div>=46irmware Engineer</div><=
div><a href=3D=22mailto:dlazzari=40leapfrog.com=22>dlazzari=40leapfrog.co=
m</a></div><div><br></div><div><br></div><div>=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F</div><div>bitbake-devel mailing l=
ist</div><div><a href=3D=22mailto:bitbake-devel=40lists.openembedded.org=22=
>bitbake-devel=40lists.openembedded.org</a></div><div><a href=3D=22http:/=
/lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel=22>http://lis=
ts.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel</a></div></div></=
div></span>
                =20
                =20
                =20
                =20
                </blockquote>
                =20
                <div>
                    <br>
                </div>
            

--4f8f4909_74b0dc51_8fe--
