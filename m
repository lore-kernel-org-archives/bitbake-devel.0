Received: from mail-lb0-f175.google.com ([209.85.217.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1TjcnH-0000sx-2x
	for bitbake-devel@lists.openembedded.org;
	Fri, 14 Dec 2012 22:27:43 +0100
Received: by mail-lb0-f175.google.com with SMTP id gg13so3180710lbb.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Dec 2012 13:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type;
	bh=FkwmFqyr9QAsmSoHeYwYyumsKPMckr/S+K0oRu14Jng=;
	b=nYLD5ABmBNZvO5DaWBebtebNIN/Nb7UaoOU0WBv4eYivgfo4DKmT5g0ukCi1JBUA1R
	jrSQ0c8ySwGV5RC3U1QABJowflmN1yNi3y36tc0S1Fm5CpQ8x4kLUqpcAHXk4fAT94dQ
	+OsEONKE8thFbG6SbcTUDIFII50rRfzAUzTugeBP/lUIoetADrHs4mhM38p0hNiwod5E
	thEuRmwdsbqNwBVlGDDhFj4z3yHjB3n+dBGfYjqikVuSDFEc+lnxPgSNl/RiE77qzexE
	qF3ifM6UjuobPYwdGx7xx1wavCibqpIYaD+USEt1J/2GW57USyJXQmo70OxSATB4J+y9
	TisQ==
Received: by 10.152.103.99 with SMTP id fv3mr3693647lab.16.1355519586251; Fri,
	14 Dec 2012 13:13:06 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.112.34.10 with HTTP; Fri, 14 Dec 2012 13:12:46 -0800 (PST)
In-Reply-To: <CANge7vURMxSYh=-O0ZHUWqopVjCkUwFMxhC8-bqHTy6J8mF2Mw@mail.gmail.com>
References: <CANge7vVgnJTskixvCtbWThgq8uqrS9fag8DcHL7HLb732ckDNg@mail.gmail.com>
	<1355507217.32519.33.camel@ted>
	<CANge7vVQnTVasye41HJiB9JOMno4fTX5mn=p499y7kus5O4NQw@mail.gmail.com>
	<CANge7vURMxSYh=-O0ZHUWqopVjCkUwFMxhC8-bqHTy6J8mF2Mw@mail.gmail.com>
From: Chris Larson <clarson@kergoth.com>
Date: Fri, 14 Dec 2012 14:12:46 -0700
X-Google-Sender-Auth: 2hUeYXiaCS0IL7nWAqAZhv9jW0s
Message-ID: <CABcZANmUyaCd0kx0FSq5Ye=OXKiKdziGfAyiy3dH9BxrJtEh6g@mail.gmail.com>
To: Jon Szymaniak <jon.szymaniak@gmail.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: hg fetcher failures for SRCREV set to a tag
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
X-List-Received-Date: Fri, 14 Dec 2012 21:27:43 -0000
Content-Type: multipart/alternative; boundary=f46d040716556cb37704d0d67f28

--f46d040716556cb37704d0d67f28
Content-Type: text/plain; charset=UTF-8

On Fri, Dec 14, 2012 at 12:09 PM, Jon Szymaniak <jon.szymaniak@gmail.com>wrote:

> >> tl;dr: Doesn't the "update" in lines 142-147 of hg.py cause issues when
> >> SRCREV is a tag?
> >>
> >>
> >> Hi all,
> >>
> >> I didn't have any luck with this post on the Yocto mailing list. Since
> it seems
> >> more like a bitbake issue (I'm very hesitant to cry "bug" at this
> point),
> >> I hope I'm in the right place.
> >>
> >> I've been running into "Fetcher failures" for my recipes using
> >> mercurial recently, which report that I'm asking for an unknown
> revision,
> >> despite it being valid. A trimmed log is at the end of this post.
> >>
> >> After looking at hg.py, it seems the issue is that the
> >> 'hg update -r MY_TAG' that follows the 'hg clone -r MY_TAG ...' is
> doomed to
> >> fail because that tag isn't visible until the next rev, where the
> action of
> >> tagging it is committed.
> >>
> >> For example, if I clone v1.1.0, I won't see that tag because the tag is
> added
> >> to .hgtags in commit 41:58b..
> >>
> >>       tip                             41:58b8f368be68
> >>       v1.1.0                        40:a925b596c163
> >>       v1.0.4                        39:6bf84da2571e
> >>
> >> Therefore once I've cloned with "-r v1.1.0", I can't do an update
> >> specifying tag v1.1.0.
> >>
> >> Does this sound right, or am I way off here?
> >>
> >> I'm not sure if using a tag rather than the revision number is
> unorthodox or
> >> abnormal for bb's, so below's my use case, for a my-app_0.1.2.bb
> >>
> >> require my-app.inc
> >> PR = "${INC_PR}.0"
> >> SRCREV = "v${PV}"
> >>
> >> Therefore to bring in a new version, I can simply copy this file to a
> >> my-app_1.1.0.bb, and adjust PR back to 0 if needed.
> >>
> >> We have a policy not to move version tags, so tag-->revision should be
> 1:1. Is
> >> what I'm seeing a non-issue simply because one shouldn't use tags in
> SRCREV?
> >>
> >
> > FWIW, the hg fetcher is a little unloved. We don't have many developers
> > who use it or are familiar with how hg works. If there are some ways we
> > can fix things I'd be interested in patches.
> >
> > I'm afraid I haven't had a chance to look at the details of the above
> > yet though.
> >
> > Cheers,
> >
> > Richard
> >
>
> Hi Richard,
>
> Thanks for pinging back on this. (Sorry I just double-sent this to
> you. Forgot to include the list! :P)
>
> I think a fairly simple solution might be to just clone the entire
> repo by not adding "-r REV" to options[] for an 'hg clone' invocation.
> The 'hg update' that follows on lines 142-147 should set the repo to
> the desired revision.


This does sound like the best bet, to me.
-- 
Christopher Larson

--f46d040716556cb37704d0d67f28
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On Fri, Dec 1=
4, 2012 at 12:09 PM, Jon Szymaniak <span dir=3D"ltr">&lt;<a href=3D"mailto:=
jon.szymaniak@gmail.com" target=3D"_blank">jon.szymaniak@gmail.com</a>&gt;<=
/span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"HOEnZb adM"><div class=3D"h5">=
&gt;&gt; tl;dr: Doesn&#39;t the &quot;update&quot; in lines 142-147 of hg.p=
y cause issues when<br>


&gt;&gt; SRCREV is a tag?<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Hi all,<br>
&gt;&gt;<br>
&gt;&gt; I didn&#39;t have any luck with this post on the Yocto mailing lis=
t. Since it seems<br>
&gt;&gt; more like a bitbake issue (I&#39;m very hesitant to cry &quot;bug&=
quot; at this point),<br>
&gt;&gt; I hope I&#39;m in the right place.<br>
&gt;&gt;<br>
&gt;&gt; I&#39;ve been running into &quot;Fetcher failures&quot; for my rec=
ipes using<br>
&gt;&gt; mercurial recently, which report that I&#39;m asking for an unknow=
n revision,<br>
&gt;&gt; despite it being valid. A trimmed log is at the end of this post.<=
br>
&gt;&gt;<br>
&gt;&gt; After looking at hg.py, it seems the issue is that the<br>
&gt;&gt; &#39;hg update -r MY_TAG&#39; that follows the &#39;hg clone -r MY=
_TAG ...&#39; is doomed to<br>
&gt;&gt; fail because that tag isn&#39;t visible until the next rev, where =
the action of<br>
&gt;&gt; tagging it is committed.<br>
&gt;&gt;<br>
&gt;&gt; For example, if I clone v1.1.0, I won&#39;t see that tag because t=
he tag is added<br>
&gt;&gt; to .hgtags in commit 41:58b..<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 tip =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 41:58b8f368be68<br=
>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 v1.1.0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A040:a925b596c163<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 v1.0.4 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A039:6bf84da2571e<br>
&gt;&gt;<br>
&gt;&gt; Therefore once I&#39;ve cloned with &quot;-r v1.1.0&quot;, I can&#=
39;t do an update<br>
&gt;&gt; specifying tag v1.1.0.<br>
&gt;&gt;<br>
&gt;&gt; Does this sound right, or am I way off here?<br>
&gt;&gt;<br>
&gt;&gt; I&#39;m not sure if using a tag rather than the revision number is=
 unorthodox or<br>
&gt;&gt; abnormal for bb&#39;s, so below&#39;s my use case, for a <a href=
=3D"http://my-app_0.1.2.bb" target=3D"_blank">my-app_0.1.2.bb</a><br>
&gt;&gt;<br>
&gt;&gt; require my-app.inc<br>
&gt;&gt; PR =3D &quot;${INC_PR}.0&quot;<br>
&gt;&gt; SRCREV =3D &quot;v${PV}&quot;<br>
&gt;&gt;<br>
&gt;&gt; Therefore to bring in a new version, I can simply copy this file t=
o a<br>
&gt;&gt; <a href=3D"http://my-app_1.1.0.bb" target=3D"_blank">my-app_1.1.0.=
bb</a>, and adjust PR back to 0 if needed.<br>
&gt;&gt;<br>
&gt;&gt; We have a policy not to move version tags, so tag--&gt;revision sh=
ould be 1:1. Is<br>
&gt;&gt; what I&#39;m seeing a non-issue simply because one shouldn&#39;t u=
se tags in SRCREV?<br>
&gt;&gt;<br>
&gt;<br>
&gt; FWIW, the hg fetcher is a little unloved. We don&#39;t have many devel=
opers<br>
&gt; who use it or are familiar with how hg works. If there are some ways w=
e<br>
&gt; can fix things I&#39;d be interested in patches.<br>
&gt;<br>
&gt; I&#39;m afraid I haven&#39;t had a chance to look at the details of th=
e above<br>
&gt; yet though.<br>
&gt;<br>
&gt; Cheers,<br>
&gt;<br>
&gt; Richard<br>
&gt;<br>
<br>
</div></div>Hi Richard,<br>
<br>
Thanks for pinging back on this. (Sorry I just double-sent this to<br>
you. Forgot to include the list! :P)<br>
<br>
I think a fairly simple solution might be to just clone the entire<br>
repo by not adding &quot;-r REV&quot; to options[] for an &#39;hg clone&#39=
; invocation.<br>
The &#39;hg update&#39; that follows on lines 142-147 should set the repo t=
o<br>
the desired revision.</blockquote></div><br>This does sound like the best b=
et, to me.<br>-- <br>Christopher Larson<br>
</div>

--f46d040716556cb37704d0d67f28--
