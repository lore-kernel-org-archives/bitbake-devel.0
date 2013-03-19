Received: from mail-la0-f52.google.com ([209.85.215.52])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1UI031-0001WI-MB
	for bitbake-devel@lists.openembedded.org;
	Tue, 19 Mar 2013 18:10:16 +0100
Received: by mail-la0-f52.google.com with SMTP id fs12so1333855lab.39
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Mar 2013 09:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type;
	bh=8lAObvWFjf41JcoQTWbrviWiIuF+NveBWasFIWrodgY=;
	b=NZ/8z6R1KBs2NAn7JBfNkc6u5XKaZUIsWLi9W85KoV0kqaRYCSXXnOP/ZGTglQN/8r
	7Ln6ciiWpF7zUSGP4CBJ/QTwSfVfc1YGjVUW+auzzBL7XqqGWvNKayJOpxRqmwGhR9zj
	dLiKs7vPAuOoIkkQkHUf73XRjkZmvcYxApFVQUDZ9kqYJ7mW/qvly06gJwjnAUhGds3x
	P1b7KhqQ7YELwb1IimShAo0usM6UMgdMrhKkmZLKWNrUpnrv99Ay4Mpk3gKXv2r+BSJr
	0dRqlkPhwO45ZG5vX2JWUvm4ahcUgROmCpuu3j060JCeJRiVTX8egeiT1dkmUYNFgNXb
	gVRw==
X-Received: by 10.112.30.104 with SMTP id r8mr8427811lbh.82.1363711993466;
	Tue, 19 Mar 2013 09:53:13 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.112.25.195 with HTTP; Tue, 19 Mar 2013 09:52:53 -0700 (PDT)
In-Reply-To: <1363699850.16482.102.camel@ted>
References: <51476713.8050506@windriver.com> <1363692919.16482.95.camel@ted>
	<51485D95.7010301@windriver.com> <1363699850.16482.102.camel@ted>
From: Chris Larson <clarson@kergoth.com>
Date: Tue, 19 Mar 2013 09:52:53 -0700
X-Google-Sender-Auth: Ib8vigS8-hiMMicWKLYHMFkqpz8
Message-ID: <CABcZAN=YB2Qag+T+pS7tXe=Uhk4VMkrvY2Z+0HmxyRXx+JqSfw@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: Bitbake / oe-core anomaly with multilibs
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
X-List-Received-Date: Tue, 19 Mar 2013 17:10:16 -0000
Content-Type: multipart/alternative; boundary=f46d04016b39f25bed04d849f0cd

--f46d04016b39f25bed04d849f0cd
Content-Type: text/plain; charset=UTF-8

On Tue, Mar 19, 2013 at 6:30 AM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Tue, 2013-03-19 at 07:44 -0500, Mark Hatle wrote:
> > On 3/19/13 6:35 AM, Richard Purdie wrote:
> > > On Mon, 2013-03-18 at 14:12 -0500, Mark Hatle wrote:
> > >> I found a strange situation today and I'm looking for an explanation
> to see if
> > >> it's a bug or not.
> > >>
> > >> Between a .bb and .bbappend file, I end up with a situation where
> > >> "reproducer.bb" and "reproducer.bbappend" get the following:
> > >>
> > >> RDEPENDS_${PN} += "hello1"
> > >> RDEPENDS_reproducer += "hello2"
> > >>
> > >> When evaluatated (bitbake -e reproducer) I get:
> > >>
> > >> #
> > >> # $RDEPENDS_reproducer [2 operations]
> > >> #   append
> > >> /home/mhatle/git/oss/oe-core/local/recipes-sample/hello/
> reproducer_1.0.bb:16
> > >> #     "hello2"
> > >> #   rename from RDEPENDS_${PN} data.py:161 [expandKeys]
> > >> #     " hello1"
> > >> # computed:
> > >> #   " hello1"
> > >> RDEPENDS_reproducer="hello1"
> > >>
> > >> So that tells me that it was initially set to "hello2", and then the
> ${PN}
> > >> expansion occurred, causing it to be set to "hello1".
> > >>
> > >> So my first question is, should this be "hello1", "hello2", "hello1
> hello2" or
> > >> "hello2 hello1"?
> > >
> > > expandKeys tramples existing values so that result doesn't surprise me
> > > even if its not what you expect.
> > >
> > >> The second issue is a bit stranger.. if I change the build from
> "reproducer" to
> > >> "lib32-reproducer", I get a different result:
> > >>
> > >> # $RDEPENDS_lib32-reproducer [3 operations]
> > >> #   rename from RDEPENDS_${PN} data.py:161 [expandKeys]
> > >> #     " hello1"
> > >> #   rename from RDEPENDS_reproducer classextend.py:95
> [rename_package_variables]
> > >> #     " hello2"
> > >> #   set classextend.py:71 [map_depends_variable]
> > >> #     "lib32-hello2"
> > >> # computed:
> > >> #   "lib32-hello2"
> > >> RDEPENDS_lib32-reproducer="lib32-hello2"
> > >>
> > >> This time the system pulled in the ${PN} version first (obviously
> expanded it),
> > >> and then turned out and found the RDEPENDS_reproducer, and remapped
> it to
> > >> RDEPENDS_lib32-reproducer replacing the origin ${PN} version.
> > >>
> > >> So I have two concerns, the first is the value is 'different' from the
> > >> non-multilib version, and second, what should the expected output be
> for this item?
> > >
> > > Again, I'm not surprised. The multilib remapping code gets executed at
> > > the end, after expandKeys and in this case last wins. So I can see why
> > > the system is doing it, even if you don't like the end result.
> > >
> > > Setting multiple conflicting keys like this is dangerous :(
> > >
> > > We've tried to fix this before and ended up just digging deeper holes
> > > with more problems.
> >
> > Is there any way we can issue a warning from the parser or something
> when it
> > finds conflicting keys?  My concern isn't that conflicting keys are
> causing a
> > problem -- but more that someone may not realize this is a problem, and
> they are
> > getting incorrect results.
> >
> > I know since posting this query, I've had a few people comment to me
> that they
> > saw the same problem and it took them a very long time to diagnose it
> and figure
> > out it "just didn't work".
>
> We could probably have data.expandKeys() check for existing values and
> then error if its overwriting something else. I have no idea how often
> the metadata does that for "correct" reasons...


I expect if the metadata really wants that, it could use a
RecipePreFinalise hook.
-- 
Christopher Larson

--f46d04016b39f25bed04d849f0cd
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Tue, Mar 19, 2013 at 6:30 AM, Richard Purdie <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_blank">richard.=
purdie@linuxfoundation.org</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"HOEnZb adM"><div class=3D"h5">=
On Tue, 2013-03-19 at 07:44 -0500, Mark Hatle wrote:<br>
&gt; On 3/19/13 6:35 AM, Richard Purdie wrote:<br>
&gt; &gt; On Mon, 2013-03-18 at 14:12 -0500, Mark Hatle wrote:<br>
&gt; &gt;&gt; I found a strange situation today and I&#39;m looking for an =
explanation to see if<br>
&gt; &gt;&gt; it&#39;s a bug or not.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Between a .bb and .bbappend file, I end up with a situation w=
here<br>
&gt; &gt;&gt; &quot;<a href=3D"http://reproducer.bb" target=3D"_blank">repr=
oducer.bb</a>&quot; and &quot;reproducer.bbappend&quot; get the following:<=
br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; RDEPENDS_${PN} +=3D &quot;hello1&quot;<br>
&gt; &gt;&gt; RDEPENDS_reproducer +=3D &quot;hello2&quot;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; When evaluatated (bitbake -e reproducer) I get:<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; #<br>
&gt; &gt;&gt; # $RDEPENDS_reproducer [2 operations]<br>
&gt; &gt;&gt; # =C2=A0 append<br>
&gt; &gt;&gt; /home/mhatle/git/oss/oe-core/local/recipes-sample/hello/<a hr=
ef=3D"http://reproducer_1.0.bb:16" target=3D"_blank">reproducer_1.0.bb:16</=
a><br>
&gt; &gt;&gt; # =C2=A0 =C2=A0 &quot;hello2&quot;<br>
&gt; &gt;&gt; # =C2=A0 rename from RDEPENDS_${PN} data.py:161 [expandKeys]<=
br>
&gt; &gt;&gt; # =C2=A0 =C2=A0 &quot; hello1&quot;<br>
&gt; &gt;&gt; # computed:<br>
&gt; &gt;&gt; # =C2=A0 &quot; hello1&quot;<br>
&gt; &gt;&gt; RDEPENDS_reproducer=3D&quot;hello1&quot;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; So that tells me that it was initially set to &quot;hello2&qu=
ot;, and then the ${PN}<br>
&gt; &gt;&gt; expansion occurred, causing it to be set to &quot;hello1&quot=
;.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; So my first question is, should this be &quot;hello1&quot;, &=
quot;hello2&quot;, &quot;hello1 hello2&quot; or<br>
&gt; &gt;&gt; &quot;hello2 hello1&quot;?<br>
&gt; &gt;<br>
&gt; &gt; expandKeys tramples existing values so that result doesn&#39;t su=
rprise me<br>
&gt; &gt; even if its not what you expect.<br>
&gt; &gt;<br>
&gt; &gt;&gt; The second issue is a bit stranger.. if I change the build fr=
om &quot;reproducer&quot; to<br>
&gt; &gt;&gt; &quot;lib32-reproducer&quot;, I get a different result:<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; # $RDEPENDS_lib32-reproducer [3 operations]<br>
&gt; &gt;&gt; # =C2=A0 rename from RDEPENDS_${PN} data.py:161 [expandKeys]<=
br>
&gt; &gt;&gt; # =C2=A0 =C2=A0 &quot; hello1&quot;<br>
&gt; &gt;&gt; # =C2=A0 rename from RDEPENDS_reproducer classextend.py:95 [r=
ename_package_variables]<br>
&gt; &gt;&gt; # =C2=A0 =C2=A0 &quot; hello2&quot;<br>
&gt; &gt;&gt; # =C2=A0 set classextend.py:71 [map_depends_variable]<br>
&gt; &gt;&gt; # =C2=A0 =C2=A0 &quot;lib32-hello2&quot;<br>
&gt; &gt;&gt; # computed:<br>
&gt; &gt;&gt; # =C2=A0 &quot;lib32-hello2&quot;<br>
&gt; &gt;&gt; RDEPENDS_lib32-reproducer=3D&quot;lib32-hello2&quot;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; This time the system pulled in the ${PN} version first (obvio=
usly expanded it),<br>
&gt; &gt;&gt; and then turned out and found the RDEPENDS_reproducer, and re=
mapped it to<br>
&gt; &gt;&gt; RDEPENDS_lib32-reproducer replacing the origin ${PN} version.=
<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; So I have two concerns, the first is the value is &#39;differ=
ent&#39; from the<br>
&gt; &gt;&gt; non-multilib version, and second, what should the expected ou=
tput be for this item?<br>
&gt; &gt;<br>
&gt; &gt; Again, I&#39;m not surprised. The multilib remapping code gets ex=
ecuted at<br>
&gt; &gt; the end, after expandKeys and in this case last wins. So I can se=
e why<br>
&gt; &gt; the system is doing it, even if you don&#39;t like the end result=
.<br>
&gt; &gt;<br>
&gt; &gt; Setting multiple conflicting keys like this is dangerous :(<br>
&gt; &gt;<br>
&gt; &gt; We&#39;ve tried to fix this before and ended up just digging deep=
er holes<br>
&gt; &gt; with more problems.<br>
&gt;<br>
&gt; Is there any way we can issue a warning from the parser or something w=
hen it<br>
&gt; finds conflicting keys? =C2=A0My concern isn&#39;t that conflicting ke=
ys are causing a<br>
&gt; problem -- but more that someone may not realize this is a problem, an=
d they are<br>
&gt; getting incorrect results.<br>
&gt;<br>
&gt; I know since posting this query, I&#39;ve had a few people comment to =
me that they<br>
&gt; saw the same problem and it took them a very long time to diagnose it =
and figure<br>
&gt; out it &quot;just didn&#39;t work&quot;.<br>
<br>
</div></div>We could probably have data.expandKeys() check for existing val=
ues and<br>
then error if its overwriting something else. I have no idea how often<br>
the metadata does that for &quot;correct&quot; reasons...</blockquote></div=
><br>I expect if the metadata really wants that, it could use a RecipePreFi=
nalise hook.<br>-- <br>Christopher Larson</div></div>

--f46d04016b39f25bed04d849f0cd--
