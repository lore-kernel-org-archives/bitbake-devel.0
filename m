Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1SIWdj-00084f-FK
	for bitbake-devel@lists.openembedded.org;
	Fri, 13 Apr 2012 04:53:35 +0200
Received: by pbcum15 with SMTP id um15so2734868pbc.6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Apr 2012 19:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=sender:date:from:to:cc:message-id:in-reply-to:references:subject
	:x-mailer:mime-version:content-type;
	bh=ekZH0tGr1LswNzFkrTZ+IokWgDuZKEEn95qarQcj2hw=;
	b=XoAheEww2Bn0O4239xw1t3F8x0z7t1RM+mkpwTI7c9V2bdwMvTImKL30Y1RX2ng3ER
	4dS42ExY1jGYqOncX5MXOGBskkeWNzSdk9icLVDB0iuZbT/iS/VQBQZKJ03J9KYaNJir
	SBxfNUC45W+70Q1MOtDwnqq6QY6EurTUy4OdWSo2T7rvsnXRakMDZtshIUZQ3jsrFAG2
	d5BNF1+pA8faphjACHwYWWDEDtBdehiII+tlLv9V3vics3A/x4BuOmwKNXOojjE+/7t1
	pY39fJVvMeMIL4mEhqh5Hxb9oRP/MPi5H43JF3G5+sof81YhhUp79r9cZt5PHLuhWaUO
	VMxg==
Received: by 10.68.222.165 with SMTP id qn5mr748771pbc.88.1334285053667;
	Thu, 12 Apr 2012 19:44:13 -0700 (PDT)
Received: from frey.local (ip68-110-79-242.ph.ph.cox.net. [68.110.79.242])
	by mx.google.com with ESMTPS id a9sm7346437pbr.73.2012.04.12.19.44.11
	(version=TLSv1/SSLv3 cipher=OTHER);
	Thu, 12 Apr 2012 19:44:12 -0700 (PDT)
Sender: Chris Larson <kergoth@gmail.com>
Date: Thu, 12 Apr 2012 19:44:09 -0700
From: Christopher Larson <clarson@kergoth.com>
To: Robert Yang <liezhi.yang@windriver.com>
Message-ID: <54D86FE786BF497FAAE0A3B629E36154@gmail.com>
In-Reply-To: <4F8778E1.3010403@windriver.com>
References: <4F83EE3C.8040904@windriver.com>
	<CABcZANm628Wm0TYo45eSjLsVjzpseV=4__he=s=Lz_r1ekyJBw@mail.gmail.com>
	<4F843FC1.1080309@windriver.com>
	<CABcZAN=LTh8GDhz5Zs0SsOkrfmsGK+-6t4+DsC23_Z-qHMk7xw@mail.gmail.com>
	<4F8778E1.3010403@windriver.com>
X-Mailer: sparrow 1.5 (build 1043.1)
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: questions about bitbake world
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
X-List-Received-Date: Fri, 13 Apr 2012 02:53:35 -0000
Content-Type: multipart/alternative; boundary="4f8792f9_66334873_1816d"

--4f8792f9_66334873_1816d
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Define EXCLUDE_FROM_WORLD = "1" in the recipe.

-- 
Christopher Larson


On Thursday, April 12, 2012 at 5:52 PM, Robert Yang wrote:

> 
> Thanks, is there a way to skip the pkg if I don't want to build it
> when bitbake world, please?
> 
> // Robert
> 
> On 04/10/2012 10:15 PM, Chris Larson wrote:
> > On Tue, Apr 10, 2012 at 7:12 AM, Robert Yang<liezhi.yang@windriver.com (mailto:liezhi.yang@windriver.com)> wrote:
> > > On 04/10/2012 09:58 PM, Chris Larson wrote:
> > > > 
> > > > On Tue, Apr 10, 2012 at 1:24 AM, Robert Yang<liezhi.yang@windriver.com (mailto:liezhi.yang@windriver.com)>
> > > > wrote:
> > > > > 
> > > > > In the following code:
> > > > > 
> > > > > def buildWorldTargetList(self):
> > > > > ...
> > > > > for f in self.status.possible_world:
> > > > > terminal = True
> > > > > pn = self.status.pkg_fn[f]
> > > > > 
> > > > > for p in pn_provides[pn]:
> > > > > if p.startswith('virtual/'):
> > > > > parselog.debug(2, "World build skipping %s due to %s
> > > > > provider starting with virtual/", f, p)
> > > > > terminal = False
> > > > > break
> > > > > ...
> > > > > 
> > > > > Does it mean that if a recipe contains:
> > > > > 
> > > > > PROVIDES = "virtual/something"
> > > > > 
> > > > > Then it would not be built until a pkg depends on it? Why we design it in
> > > > > this
> > > > > way, please?
> > > > > 
> > > > 
> > > > 
> > > > 
> > > > The original intent with world was that when two recipes provided the
> > > > same thing, we'd still only want to build one of them, not both, as
> > > > building both can cause problems with stepping on one another in
> > > > sysroot, etc.
> > > > 
> > > 
> > > 
> > > 
> > > Thanks for your reply, but it seems that it builts none currently.
> > 
> > Fair point, I think in certain cases we also only wanted to build
> > things if they got pulled in via a dependency. For example, iirc
> > native and cross both exclude themselves from world via a variable set
> > in the classes. I don't recall if such was the case here, however.
> > 
> 
> 
> 



--4f8792f9_66334873_1816d
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


                <div style=3D=22font-family: Helvetica; font-size: 13px; =
=22>Define EXCLUDE=5F=46ROM=5FWORLD =3D =221=22 in the recipe.<br></div>
                <div><div><br></div><div>--&nbsp;</div><div>Christopher L=
arson</div><div><br></div></div>
                =20
                <p style=3D=22color: =23A0A0A8;=22>On Thursday, April 12,=
 2012 at 5:52 PM, Robert Yang wrote:</p>
                <blockquote type=3D=22cite=22 style=3D=22border-left-styl=
e:solid;border-width:1px;margin-left:0px;padding-left:10px;=22>
                    <span><div><div><div><br></div><div>Thanks, is there =
a way to skip the pkg if I don't want to build it</div><div>when bitbake =
world, please=3F</div><div><br></div><div>// Robert</div><div><br></div><=
div>On 04/10/2012 10:15 PM, Chris Larson wrote:</div><blockquote type=3D=22=
cite=22><div><div>On Tue, Apr 10, 2012 at 7:12 AM, Robert Yang&lt;<a href=
=3D=22mailto:liezhi.yang=40windriver.com=22>liezhi.yang=40windriver.com</=
a>&gt;  wrote:</div><blockquote type=3D=22cite=22><div><div>On 04/10/2012=
 09:58 PM, Chris Larson wrote:</div><blockquote type=3D=22cite=22><div><d=
iv><br></div><div>On Tue, Apr 10, 2012 at 1:24 AM, Robert Yang&lt;<a href=
=3D=22mailto:liezhi.yang=40windriver.com=22>liezhi.yang=40windriver.com</=
a>&gt;</div><div>  wrote:</div><blockquote type=3D=22cite=22><div><div><b=
r></div><div>In the following code:</div><div><br></div><div>def buildWor=
ldTargetList(self):</div><div>...</div><div>        for f in self.status.=
possible=5Fworld:</div><div>            terminal =3D True</div><div>     =
       pn =3D self.status.pkg=5Ffn=5Bf=5D</div><div><br></div><div>      =
      for p in pn=5Fprovides=5Bpn=5D:</div><div>                if p.star=
tswith('virtual/'):</div><div>                    parselog.debug(2, =22Wo=
rld build skipping %s due to %s</div><div>provider starting with virtual/=
=22, f, p)</div><div>                    terminal =3D =46alse</div><div> =
                   break</div><div>...</div><div><br></div><div>Does it m=
ean that if a recipe contains:</div><div><br></div><div>PROVIDES =3D =22v=
irtual/something=22</div><div><br></div><div>Then it would not be built u=
ntil a pkg depends on it=3F Why we design it in</div><div>this</div><div>=
way, please=3F</div></div></blockquote><div><br></div><div><br></div><div=
>The original intent with world was that when two recipes provided the</d=
iv><div>same thing, we'd still only want to build one of them, not both, =
as</div><div>building both can cause problems with stepping on one anothe=
r in</div><div>sysroot, etc.</div></div></blockquote><div><br></div><div>=
<br></div><div>Thanks for your reply, but it seems that it builts none cu=
rrently.</div></div></blockquote><div><br></div><div>=46air point, I thin=
k in certain cases we also only wanted to build</div><div>things if they =
got pulled in via a dependency. =46or example, iirc</div><div>native and =
cross both exclude themselves from world via a variable set</div><div>in =
the classes. I don't recall if such was the case here, however.</div></di=
v></blockquote></div></div></span>
                =20
                =20
                =20
                =20
                </blockquote>
                =20
                <div>
                    <br>
                </div>
            

--4f8792f9_66334873_1816d--
