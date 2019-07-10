Return-Path: <alan.kozlay@ves.solutions>
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
	[209.85.214.172])
	by mail.openembedded.org (Postfix) with ESMTP id C10DB7EF25
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jul 2019 15:59:09 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id w24so1462797plp.2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jul 2019 08:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ves-solutions-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=dYIzQEPhU96BI9OSFqD+gynfocSuVOPvDWs5yErAwwA=;
	b=SQkm+WVAo1LCVx86ArQUsml0+FZFpf3FPei52dES0fPO2/6fwhZ+5Sm1kidXzIzzJG
	umMT4TphhYgkmO6cKUU+gQRC/J7MHLaTy93UWAgQXsrJgghDVUHeE429ymJaCQhoQ4RN
	vtIB4BtW5VCj4IQ+h5Ch5IgX/4xdsdP9kwGbu3sgMN7hQJK8R61o2OCz+c8/BJqMGFz2
	qx9UWFhW83OKCPXEUOMBysoKwgYoWzo1yL9UIeSVI1PpYqbJSzF6p7Xu+RpOpTPFn30d
	Ok9Bh4xwCTBsUZxS7neQ9U+kP2P0aaOOSB2DMXjE8lVOB4dtBpsVw21GF+bjQ0kCh94A
	soPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=dYIzQEPhU96BI9OSFqD+gynfocSuVOPvDWs5yErAwwA=;
	b=Lr8uXuMWm06DK1VwIE859Ph4NkjozSo08HXXsaEWLDEbXHdhseHsgT13K2ci1v798w
	o2uUozOuvw3zCe9k0mJTJlZtBmov0xSV+t3FZmk/pHr5PH2Sq/ju73ooD5Dbdarh4Ts8
	W4jx+rF6VbzeO3TUclJfIYM0feDCzo6xj+KJ7G0BbEikydWe5/NF9TqCB2KRgzAHdadU
	bQLWJ/9wdhZA6kcIVRkdRrtY3YMNU5k73U8WUroFYdosbPv5ZEEaDE6xRBX00KIa5D9K
	wLGlJdVWqjJdXPCeeLvPXnGqLOB2TtJbOhjQnO6fVyI/K592I56r+hKUyXsNh7u0Yhqt
	cqGQ==
X-Gm-Message-State: APjAAAW371chFzR+iYlLbfnLgeYrcPAqCVO1vJtnQjDqZKPlrq5KZtZu
	aswfAgnsLf5OolbUJkfTkF4moQpE8+j2kEPtq6AbFw==
X-Google-Smtp-Source: APXvYqwhNkJoUxfxlyT50m1RKNwaCJQTTzPBUlslMcCPCcX6qDOUye0lirFz87GgjGnv1E6eAoTqbg1+MIqIIBp50/8=
X-Received: by 2002:a17:902:8a8a:: with SMTP id
	p10mr40347301plo.88.1562774350675; 
	Wed, 10 Jul 2019 08:59:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAJE9sG=4MPryg2+h5a-jmhhpqPW=o6E26rte-JSPc31UioNbwQ@mail.gmail.com>
	<d12b286a3b55653e61d8d8e7672d87b374ae37d6.camel@linuxfoundation.org>
	<CAJE9sGmynaeD3uL-UBJnJt74rhv-sjSYjtQ=mNByQ69pVwaerg@mail.gmail.com>
	<a29ff39b8e26b1c9dd7d1f24e8991e93097225ec.camel@linuxfoundation.org>
In-Reply-To: <a29ff39b8e26b1c9dd7d1f24e8991e93097225ec.camel@linuxfoundation.org>
From: Alan Kozlay <alan.kozlay@ves-solutions.com>
Date: Wed, 10 Jul 2019 11:58:35 -0400
Message-ID: <CAJE9sGk59TaZiijPx5GqsJ7KVEeq3yW3ywTC7Z6phihCjua4mg@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: Should multiconfig save build time?
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
X-List-Received-Date: Wed, 10 Jul 2019 15:59:09 -0000
Content-Type: multipart/alternative; boundary="000000000000094d32058d55c277"

--000000000000094d32058d55c277
Content-Type: text/plain; charset="UTF-8"

Thanks for the feedback.

On Wed, Jul 10, 2019 at 5:32 AM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Mon, 2019-07-08 at 14:27 -0400, Alan Kozlay wrote:
> > We're looking for things we can do to improve the multiconfig build
> > time.
> >
> > Even on our build servers it still takes a long time.
> > For instance, our build servers each have 64 core, 128G RAM with 4
> > NVMe SSD HDs in a striped raid (all configured with bells and
> > whistles to make it super fast).
> > A full fresh build on one of those servers still takes 6 hours.
>
> Given we have no idea what these mulitconfigs are, how much overlap
> there is or how you're running it, its hard to know whether 6 hours is
> good or bad.
>
> > I need to also clarify that we do indeed define different
> > DISTRO_FEATURES between multiconfigs, so multiconfig is necessary.
> >
> > (1) We're attempting to use the ccache (via ccache.bbclass), but it's
> > causing some build errors that we're investigating.
>
> That shouldn't cause errors and would likely be some ccache problem.
>
> > (2) Can we at least set the root native work directory to be the same
> > for all multiconfigs?
>
> It depends if the configurations are different or not. WORKDIR isn't
> your problem here, you really need the builds to have the same sysroot-
> components dir for the native case too, else this won't work. Its more
> about the output from the task than the directory they were built in.
>
> > Would each multiconfig honor the previously built native tools?
> > Or, would it just rebuild them, anyway?
> > Is this safe or tested or supported?
>
> multiconfig is configured so that if it sees overlapping stamp files it
> would handle that correctly. The tricky part is you'd have to split
> some directories which aren't usually split such as sysroot-components.
> I've never seen that attempted and am not sure if it would work or not.
>
> > (3) We're considering a network shared sstate-cache.  But it's not
> > entirely clear if a multiconfig build is benefited by the sstate-
> > cache directory.
> > Under what circumstances does a multiconfig leverage sstate-cache
> > when building for another multiconfig?
>
> Right now today for a single multiconfig build it won't.
>
> > What if the recipe would be affected by a change in DISTRO_FEATURES
> > between multiconfigs?
> > Are native packages included in the sstate-cache or just target
> > packages?
>
> native and target are included in sstate-cache.
>
> > We welcome all thoughts and ideas.
>
> With current bitbake you'd be best off splitting your multiconfig build
> into two parts a first stage where you build common shared components
> and a second where you leverage them.
>
> I appreciate that isn't a good solution but its what will work right
> now.
>
> The initial work in adapting bitbake to better handle situations like
> this is being done, as we speak and there are patches starting it in
> master-next.
>
> Right now those patches also won't change anything for you, they re-
> architect the codebase so we have a chance of implementing what you
> want. It is however at least a start. I'm working on this effectively
> alone with the day to day patch review, email and bugs to handle at the
> same time :(. As a project we know this is important but we struggle to
> find people willing to contribute development resources to make these
> kinds of changes happen.
>
> Next step is to write a regression test suite for runqueue. Once I've
> done that I'll start to think about optimisation work.
>
> Cheers,
>
> Richard
>
>
>

-- 
Alan Kozlay
VES Solutions, LLC
Alan Kozlay <alan.kozlay@ves.solutions>
DESK 443-595-7734
CELL 443-752-0323

--000000000000094d32058d55c277
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Thanks for the feedback.=C2=A0<br><input =
name=3D"virtru-metadata" type=3D"hidden" value=3D"{&quot;email-policy&quot;=
:{&quot;state&quot;:&quot;closed&quot;,&quot;expirationUnit&quot;:&quot;day=
s&quot;,&quot;disableCopyPaste&quot;:false,&quot;disablePrint&quot;:false,&=
quot;disableForwarding&quot;:false,&quot;enableNoauth&quot;:false,&quot;per=
sistentProtection&quot;:false,&quot;expandedWatermarking&quot;:false,&quot;=
expires&quot;:false,&quot;isManaged&quot;:false},&quot;attachments&quot;:{}=
,&quot;compose-id&quot;:&quot;13&quot;,&quot;compose-window&quot;:{&quot;se=
cure&quot;:false}}"></div><br><div class=3D"gmail_quote" style=3D""><div di=
r=3D"ltr" class=3D"gmail_attr">On Wed, Jul 10, 2019 at 5:32 AM Richard Purd=
ie &lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org">richard.purdie=
@linuxfoundation.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">On Mon, 2019-07-08 at 14:27 -0400, Alan Kozlay wrote:<b=
r>
&gt; We&#39;re looking for things we can do to improve the multiconfig buil=
d<br>
&gt; time.<br>
&gt; <br>
&gt; Even on our build servers it still takes a long time.<br>
&gt; For instance, our build servers each have 64 core, 128G RAM with 4<br>
&gt; NVMe SSD HDs in a striped raid (all configured with bells and<br>
&gt; whistles to make it super fast).<br>
&gt; A full fresh build on one of those servers still takes 6 hours.<br>
<br>
Given we have no idea what these mulitconfigs are, how much overlap<br>
there is or how you&#39;re running it, its hard to know whether 6 hours is<=
br>
good or bad.<br>
<br>
&gt; I need to also clarify that we do indeed define different<br>
&gt; DISTRO_FEATURES between multiconfigs, so multiconfig is necessary.<br>
&gt; <br>
&gt; (1) We&#39;re attempting to use the ccache (via ccache.bbclass), but i=
t&#39;s<br>
&gt; causing some build errors that we&#39;re investigating.<br>
<br>
That shouldn&#39;t cause errors and would likely be some ccache problem.<br=
>
<br>
&gt; (2) Can we at least set the root native work directory to be the same<=
br>
&gt; for all multiconfigs?<br>
<br>
It depends if the configurations are different or not. WORKDIR isn&#39;t<br=
>
your problem here, you really need the builds to have the same sysroot-<br>
components dir for the native case too, else this won&#39;t work. Its more<=
br>
about the output from the task than the directory they were built in.<br>
<br>
&gt; Would each multiconfig honor the previously built native tools?<br>
&gt; Or, would it just rebuild them, anyway?<br>
&gt; Is this safe or tested or supported?<br>
<br>
multiconfig is configured so that if it sees overlapping stamp files it<br>
would handle that correctly. The tricky part is you&#39;d have to split<br>
some directories which aren&#39;t usually split such as sysroot-components.=
 <br>
I&#39;ve never seen that attempted and am not sure if it would work or not.=
<br>
<br>
&gt; (3) We&#39;re considering a network shared sstate-cache.=C2=A0 But it&=
#39;s not<br>
&gt; entirely clear if a multiconfig build is benefited by the sstate-<br>
&gt; cache directory.<br>
&gt; Under what circumstances does a multiconfig leverage sstate-cache<br>
&gt; when building for another multiconfig?<br>
<br>
Right now today for a single multiconfig build it won&#39;t.<br>
<br>
&gt; What if the recipe would be affected by a change in DISTRO_FEATURES<br=
>
&gt; between multiconfigs?<br>
&gt; Are native packages included in the sstate-cache or just target<br>
&gt; packages?<br>
<br>
native and target are included in sstate-cache.<br>
<br>
&gt; We welcome all thoughts and ideas.<br>
<br>
With current bitbake you&#39;d be best off splitting your multiconfig build=
<br>
into two parts a first stage where you build common shared components<br>
and a second where you leverage them.<br>
<br>
I appreciate that isn&#39;t a good solution but its what will work right<br=
>
now.<br>
<br>
The initial work in adapting bitbake to better handle situations like<br>
this is being done, as we speak and there are patches starting it in<br>
master-next.<br>
<br>
Right now those patches also won&#39;t change anything for you, they re-<br=
>
architect the codebase so we have a chance of implementing what you<br>
want. It is however at least a start. I&#39;m working on this effectively<b=
r>
alone with the day to day patch review, email and bugs to handle at the<br>
same time :(. As a project we know this is important but we struggle to<br>
find people willing to contribute development resources to make these<br>
kinds of changes happen.<br>
<br>
Next step is to write a regression test suite for runqueue. Once I&#39;ve<b=
r>
done that I&#39;ll start to think about optimisation work.<br>
<br>
Cheers,<br>
<br>
Richard<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><span><di=
v><div dir=3D"ltr"><div><div>Alan Kozlay<br></div><div dir=3D"ltr">VES Solu=
tions, LLC<br><span>Alan Kozlay &lt;alan.kozlay@ves.solutions&gt;</span><di=
v>DESK 443-595-7734<br></div><div>CELL 443-752-0323</div></div></div></div>=
</div></span></div></div></div></div></div>

--000000000000094d32058d55c277--
