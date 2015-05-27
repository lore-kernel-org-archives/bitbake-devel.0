Return-Path: <jatedev@gmail.com>
Received: from mail-pa0-f52.google.com (mail-pa0-f52.google.com
	[209.85.220.52])
	by mail.openembedded.org (Postfix) with ESMTP id 3ADD865D6E;
	Wed, 27 May 2015 23:32:26 +0000 (UTC)
Received: by pacwv17 with SMTP id wv17so8966256pac.2;
	Wed, 27 May 2015 16:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=MBH/n8Dy4TFgVYtE7SyitQ7VVICr5oT5rpB62cfGQsA=;
	b=kMdDrPuPBB6bptor+Shcg6bVF9W+IuaoqFUzTBhnGWyvL1/otsoyfxHfNkDhw7OzzU
	f8bCqHNZA1NF/WQqCyzFeedsC4nVNKX9I/xM+oDzppZaK0Ai2pu/AJGvznvTL1GOxw3z
	z9h9XLGmF+aFxdvw4Yw/OqJxnNTbN2hFn0sxcH1pNywnuqV9dAV4W8Z+LsT+4TykhyfS
	bgVKOaSknVK9yT9gqapaxEFzHlUKVSCPV41xX1SvrwpKxGU4KSGVsw+3uNA1YwSqQkOE
	vvIKIjzKozaqPuQWKXBypO1YxxpJJNA3q+d8gOXdu5qL7XhC7tFRh9fcqQj1M7aYavym
	FNhw==
MIME-Version: 1.0
X-Received: by 10.66.157.71 with SMTP id wk7mr62388126pab.99.1432769547981;
	Wed, 27 May 2015 16:32:27 -0700 (PDT)
Received: by 10.67.4.33 with HTTP; Wed, 27 May 2015 16:32:27 -0700 (PDT)
In-Reply-To: <1431596809.30971.197.camel@linuxfoundation.org>
References: <CAPphmgY46h8ajbqL66rynRf2-u28a0duxPFV3MqPjb_iB_RvaA@mail.gmail.com>
	<1431596809.30971.197.camel@linuxfoundation.org>
Date: Wed, 27 May 2015 19:32:27 -0400
Message-ID: <CAPphmgbAvRSAZ54BWW7K25_o-v-EnLZWDs-XTGdAEtLbqQQ0xg@mail.gmail.com>
From: Jate Sujjavanich <jatedev@gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org,
	openembedded-core@lists.openembedded.org
Subject: Re: [PATCH v2][2/2] image.bbclass/rootfs.py: use PREFERRED_RPROVIDER to select package
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
X-List-Received-Date: Wed, 27 May 2015 23:32:29 -0000
Content-Type: multipart/alternative; boundary=047d7bacc460f3d802051718a77c

--047d7bacc460f3d802051718a77c
Content-Type: text/plain; charset=UTF-8

I have taken a look at the code, and there two places that I have found so
far that contain the RPROVIDES_* for each package. One is the taskdata at
the bitbake level, and the other is the pkgdata directory within the
sysroot for the machine's build. The taskdata seems more readily accessible
in memory. However, I've neither figured out a way to access it from the
image recipe namespace, nor do I know if it's intended to be accessed at
the recipe level. On the other hand, the pkgdata directory holds
information about all built packages, and I've written some code derived
from packageinfo.bbclass (used in hob) that loads all the package
information into memory.

For the case provided in bug 6149, the code could access the
PREFERRED_PROVIDER for the missing sshd package, search the pkgdata, and
then replace 'sshd' within PACKAGE_INSTALL with 'dropbear' as specified
within RPROVIDES_dropbear = "ssh sshd".

A problem is the inefficiency of parsing through the pkgdata files. Maybe a
rewrite of IMAGE_INSTALL be done during the calculations taskdata.py
instead, or maybe the name of the package rproviding the item needs to be
saved and referred to during the image generation.


- Jate


On Thu, May 14, 2015 at 5:46 AM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Wed, 2015-05-13 at 18:47 -0400, Jate Sujjavanich wrote:
> > +python rootfs_process_preferred_rproviders() {
> > +    inst_pkgs = d.getVar("PACKAGE_INSTALL", True).split()
> > +    pref_pkgs = list()
> > +    for pkg in inst_pkgs:
> > +        prefervar = d.getVar("PREFERRED_RPROVIDER_%s" % pkg, True)
> > +        if prefervar:
> > +            inst_pkgs.remove(pkg)
> > +            pref_pkgs.append(prefervar)
> > +            bb.note("Selecting %s to provide %s due to
> > PREFERRED_RPROVIDER" % (prefervar, pkg))
> > +    inst_pkgs.extend(pref_pkgs)
> > +    d.setVar("PACKAGE_INSTALL", ' '.join(inst_pkgs))
> > +}
> > +do_rootfs[prefuncs] += "rootfs_process_preferred_rproviders"
> > +
> >  # We have to delay the runtime_mapping_rename until just before
> > rootfs runs
> >  # otherwise, the multilib renaming could step in and squash any
> > fixups that
> >  # may have occurred.
>
> This kind of approach to the problem basically doesn't scale. Yes, it
> will rewrite things in PACKAGE_INSTALL however if package A depends on
> package B using one of these names, the mechanism will simply not work.
> This will in turn generate a whole new world of bug reports with no way
> to really fix the problems.
>
> This is why we have other mechanisms for handling the runtime provider
> names, usually through parametrisation with variables so that when you
> rewrite an entry, *all* entries get rewritten and what the package
> manager sees is consistent.
>
> I would also note that in the past, bitbake once did have
> PREFERRED_RPROVIDER support. We dropped it as it caused problems. I
> suspect I would have written up some rationale for that when we did it
> which would be in the list archives.
>
> Cheers,
>
> Richard
>
>
>

--047d7bacc460f3d802051718a77c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>I have taken a look at the code, and there two p=
laces that I have found so far that contain the RPROVIDES_* for each packag=
e. One is the taskdata at the bitbake level, and the other is the pkgdata d=
irectory within the sysroot for the machine&#39;s build. The taskdata seems=
 more readily accessible in memory. However, I&#39;ve neither figured out a=
 way to access it from the image recipe namespace, nor do I know if it&#39;=
s intended to be accessed at the recipe level. On the other hand, the pkgda=
ta directory holds information about all built packages, and I&#39;ve writt=
en some code derived from packageinfo.bbclass (used in hob) that loads all =
the package information into memory.<br><br>For the case provided in bug 61=
49, the code could access the PREFERRED_PROVIDER for the missing sshd packa=
ge, search the pkgdata, and then replace &#39;sshd&#39; within PACKAGE_INST=
ALL with &#39;dropbear&#39; as specified within RPROVIDES_dropbear =3D &quo=
t;ssh sshd&quot;.<br><br></div>A problem is the inefficiency of parsing thr=
ough the pkgdata files. Maybe a rewrite of IMAGE_INSTALL be done during the=
 calculations taskdata.py instead, or maybe the name of the package rprovid=
ing the item needs to be saved and referred to during the image generation.=
<br><br></div><br>- Jate<br><div><br></div></div><div class=3D"gmail_extra"=
><br><div class=3D"gmail_quote">On Thu, May 14, 2015 at 5:46 AM, Richard Pu=
rdie <span dir=3D"ltr">&lt;<a href=3D"mailto:richard.purdie@linuxfoundation=
.org" target=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt;</span> w=
rote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex"><span class=3D"">On Wed, 2015-05-13=
 at 18:47 -0400, Jate Sujjavanich wrote:<br>
&gt; +python rootfs_process_preferred_rproviders() {<br>
&gt; +=C2=A0 =C2=A0 inst_pkgs =3D d.getVar(&quot;PACKAGE_INSTALL&quot;, Tru=
e).split()<br>
&gt; +=C2=A0 =C2=A0 pref_pkgs =3D list()<br>
&gt; +=C2=A0 =C2=A0 for pkg in inst_pkgs:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 prefervar =3D d.getVar(&quot;PREFERRED_RP=
ROVIDER_%s&quot; % pkg, True)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if prefervar:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 inst_pkgs.remove(pkg)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pref_pkgs.append(prefervar)=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.note(&quot;Selecting %s =
to provide %s due to<br>
&gt; PREFERRED_RPROVIDER&quot; % (prefervar, pkg))<br>
&gt; +=C2=A0 =C2=A0 inst_pkgs.extend(pref_pkgs)<br>
&gt; +=C2=A0 =C2=A0 d.setVar(&quot;PACKAGE_INSTALL&quot;, &#39; &#39;.join(=
inst_pkgs))<br>
&gt; +}<br>
&gt; +do_rootfs[prefuncs] +=3D &quot;rootfs_process_preferred_rproviders&qu=
ot;<br>
&gt; +<br>
&gt;=C2=A0 # We have to delay the runtime_mapping_rename until just before<=
br>
&gt; rootfs runs<br>
&gt;=C2=A0 # otherwise, the multilib renaming could step in and squash any<=
br>
&gt; fixups that<br>
&gt;=C2=A0 # may have occurred.<br>
<br>
</span>This kind of approach to the problem basically doesn&#39;t scale. Ye=
s, it<br>
will rewrite things in PACKAGE_INSTALL however if package A depends on<br>
package B using one of these names, the mechanism will simply not work.<br>
This will in turn generate a whole new world of bug reports with no way<br>
to really fix the problems.<br>
<br>
This is why we have other mechanisms for handling the runtime provider<br>
names, usually through parametrisation with variables so that when you<br>
rewrite an entry, *all* entries get rewritten and what the package<br>
manager sees is consistent.<br>
<br>
I would also note that in the past, bitbake once did have<br>
PREFERRED_RPROVIDER support. We dropped it as it caused problems. I<br>
suspect I would have written up some rationale for that when we did it<br>
which would be in the list archives.<br>
<br>
Cheers,<br>
<br>
Richard<br>
<br>
<br>
</blockquote></div><br></div>

--047d7bacc460f3d802051718a77c--
