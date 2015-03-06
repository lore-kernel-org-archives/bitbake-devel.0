Return-Path: <alexandru.damian@intel.com>
Received: from mail-ob0-f172.google.com (mail-ob0-f172.google.com
	[209.85.214.172])
	by mail.openembedded.org (Postfix) with ESMTP id 174AD6017E
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  6 Mar 2015 18:38:04 +0000 (UTC)
Received: by obcwp18 with SMTP id wp18so11019603obc.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 06 Mar 2015 10:38:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type;
	bh=TCBfHhbJQtOo7BsM3ZcFF5xbM8dfU0rvc+8jQM3sg+U=;
	b=IJ42pfPnP9QjSI4Jf4nucw06i50g/JCPcQhFqeG+90iT8LZBXh1iCS7xIiKaEjYuA8
	F97c2NNOZTjvmRiNZOcZs/DPnyQxpzG8XQe6q72CF0yswaLu1shOVmCPQaYMgXUWNcnU
	lQm32DpzuAuKMW9Xsx2JEhbpzdirOIpgux6lq0JLbRw04z2NbRrc+Wuq619adPwrkkra
	/iCNaZIEV94wFo2e+LX7ZP4/dND0UMk1FdbRdugt8enARIvmmRH7WmXgQba0ZfFUarsE
	uf7qAxYNOHZDLh8jgEdabEXmBjZg145BGQxa9AwSgt8kgrGWs7RrZM4ukBEs8SWePfRy
	D2yw==
X-Gm-Message-State: ALoCoQlrLwZyxDBfRzyYPssLXgjL/GfTTuZ9ELTpOPhK3Qnz9taQvgJ4jjABUMAz9npiJzLoxDdr
X-Received: by 10.182.186.70 with SMTP id fi6mr12090774obc.28.1425667085576;
	Fri, 06 Mar 2015 10:38:05 -0800 (PST)
MIME-Version: 1.0
Received: by 10.76.131.135 with HTTP; Fri, 6 Mar 2015 10:37:45 -0800 (PST)
In-Reply-To: <54f5a36c.a241420a.3b1f.4864SMTPIN_ADDED_BROKEN@mx.google.com>
References: <54f5a36c.a241420a.3b1f.4864SMTPIN_ADDED_BROKEN@mx.google.com>
From: "Damian, Alexandru" <alexandru.damian@intel.com>
Date: Fri, 6 Mar 2015 18:37:45 +0000
Message-ID: <CAJ2CSBvOUfvYEqqpLKmNwXcDb=Aj0LuhZRhu1EVB=fVk8c2XOQ@mail.gmail.com>
To: Himanshu Pandey <pandey_himanshu80@rediffmail.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 01/12] toastergui: fix spacing and input field sizes
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
X-List-Received-Date: Fri, 06 Mar 2015 18:38:06 -0000
Content-Type: multipart/alternative; boundary=089e013cbfb83441c40510a2fced

--089e013cbfb83441c40510a2fced
Content-Type: text/plain; charset=UTF-8

Take a look a the IMAGE_INSTALL variable - it needs to have "bash" in its
value to get "bash" in the image.

On Tue, Mar 3, 2015 at 12:04 PM, Himanshu Pandey <
pandey_himanshu80@rediffmail.com> wrote:

> Hi,
>
> When I compile my image using the command bitbake:
>
> bitbake core-image-lb
>
> it shows:
>
> meta-lb           = "<unknown>:<unknown>"
>
> Also I have included the package "bash" in conf/local.conf for this image.
> But the image is neither compiling the bash package nor it is installing it.
>
> Where shall I include the bash package in my image.
>
> Regards,
> Himanshu
>
> From: Alex DAMIAN <alexandru.damian@intel.com>
> Sent: Tue, 24 Feb 2015 22:51:46
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [PATCH 01/12] toastergui: fix spacing and input
> field sizes
>
> From: Belen Barros Pena <belen.barros.pena@intel.com>
>
> The revision label was missing the projec-form class (which
> controls the spacing in the form), and the revision text
> field was a bit too long, so changed it from span4 to
> span3.
> ---
> lib/toaster/toastergui/templates/importlayer.html | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/lib/toaster/toastergui/templates/importlayer.html
> b/lib/toaster/toastergui/templates/importlayer.html
> index 1196e0c..19d2fc4 100644
> --- a/lib/toaster/toastergui/templates/importlayer.html
> +++ b/lib/toaster/toastergui/templates/importlayer.html
> @@ -75,11 +75,11 @@
>                         <input type="text"  id="layer-subdir">
>
>                           <div class="control-group"
> id="layer-revision-ctrl">
> -                            <label class="control-label"
> for="layer-git-ref">Revision
> +                            <label class="control-label project-form"
> for="layer-git-ref">Revision
>                               <span class="icon-question-sign get-help"
> title="You can provide a Git branch, a tag or a commit SHA as the
> revision"></span>
>                             </label>
>                             <div class="controls">
> -                              <input type="text" class="span4"
> id="layer-git-ref" required>
> +                              <input type="text" class="span3"
> id="layer-git-ref" required>
>                                 <span class="help-inline"
> style="diaply:none;" id="invalid-layer-revision-hint"></span>
>                             </div>
>                           </div>
> --
> 1.9.1
>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>
>
> <http://sigads.rediff.com/RealMedia/ads/click_nx.ads/www.rediffmail.com/signatureline.htm@Middle?>
> Get your own *FREE* website, *FREE* domain & *FREE* mobile app with
> Company email.
> *Know More >*
> <http://track.rediff.com/click?url=___http://businessemail.rediff.com?sc_cid=sign-1-10-13___&cmp=host&lnk=sign-1-10-13&nsrv1=host>




-- 
Alex Damian
Yocto Project
SSG / OTC

--089e013cbfb83441c40510a2fced
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:tahoma,s=
ans-serif">Take a look a the IMAGE_INSTALL variable - it needs to have &quo=
t;bash&quot; in its value to get &quot;bash&quot; in the image.<br></div></=
div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Tue, Mar 3=
, 2015 at 12:04 PM, Himanshu  Pandey <span dir=3D"ltr">&lt;<a href=3D"mailt=
o:pandey_himanshu80@rediffmail.com" target=3D"_blank">pandey_himanshu80@red=
iffmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi,<div=
><br></div><div>When I compile my image using the command bitbake:</div><di=
v><br></div><div>bitbake core-image-lb</div><div><br></div><div>it shows:</=
div><div><br></div><div>meta-lb =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D &quo=
t;&lt;unknown&gt;:&lt;unknown&gt;&quot;<br><br>Also I have included the pac=
kage &quot;bash&quot; in conf/local.conf for this image. But the image is n=
either compiling the bash package nor it is installing it.</div><div><br></=
div><div>Where shall I include the bash package in my image.</div><div><br>=
</div><div>Regards,</div><div>Himanshu=C2=A0<br><br>From: Alex DAMIAN &lt;<=
a href=3D"mailto:alexandru.damian@intel.com" target=3D"_blank">alexandru.da=
mian@intel.com</a>&gt;<br>Sent: Tue, 24 Feb 2015 22:51:46 <br>To: <a href=
=3D"mailto:bitbake-devel@lists.openembedded.org" target=3D"_blank">bitbake-=
devel@lists.openembedded.org</a><br>Subject: [bitbake-devel] [PATCH 01/12] =
toastergui: fix spacing and input field sizes<div><div class=3D"h5"><br>Fro=
m: Belen Barros Pena &lt;<a href=3D"mailto:belen.barros.pena@intel.com" tar=
get=3D"_blank">belen.barros.pena@intel.com</a>&gt;<br>
<br>
The revision label was missing the projec-form class (which<br>
controls the spacing in the form), and the revision text<br>
field was a bit too long, so changed it from span4 to<br>
span3.<br>
---<br>
 lib/toaster/toastergui/templates/importlayer.html | 4 ++--<br>
 1 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/lib/toaster/toastergui/templates/importlayer.html b/lib/toaste=
r/toastergui/templates/importlayer.html<br>
index 1196e0c..19d2fc4 100644<br>
--- a/lib/toaster/toastergui/templates/importlayer.html<br>
+++ b/lib/toaster/toastergui/templates/importlayer.html<br>
@@ -75,11 +75,11 @@<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &lt;input type=3D&quot;text&quot; =C2=A0id=3D&quot;layer-subdir&=
quot;&gt;<br>
 <br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &lt;div class=3D&quot;control-group&quot; id=3D&quot;laye=
r-revision-ctrl&quot;&gt;<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&lt;label class=3D&quot;control-label&quot; for=3D&=
quot;layer-git-ref&quot;&gt;Revision<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&lt;label class=3D&quot;control-label project-form&=
quot; for=3D&quot;layer-git-ref&quot;&gt;Revision<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;span class=3D&quot;icon-question-sign g=
et-help&quot; title=3D&quot;You can provide a Git branch, a tag or a commit=
 SHA as the revision&quot;&gt;&lt;/span&gt;<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 &lt;/label&gt;<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 &lt;div class=3D&quot;controls&quot;&gt;<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;input type=3D&quot;text&quot; class=3D&q=
uot;span4&quot; id=3D&quot;layer-git-ref&quot; required&gt;<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;input type=3D&quot;text&quot; class=3D&q=
uot;span3&quot; id=3D&quot;layer-git-ref&quot; required&gt;<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;span class=3D&quot;help-inline&q=
uot; style=3D&quot;diaply:none;&quot; id=3D&quot;invalid-layer-revision-hin=
t&quot;&gt;&lt;/span&gt;<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 &lt;/div&gt;<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &lt;/div&gt;<br>
-- <br>
1.9.1<br>
<br></div></div><span class=3D"HOEnZb"><font color=3D"#888888">
-- <br>
_______________________________________________<br>
bitbake-devel mailing list<br>
<a href=3D"mailto:bitbake-devel@lists.openembedded.org" target=3D"_blank">b=
itbake-devel@lists.openembedded.org</a><br>
<a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-devel" ta=
rget=3D"_blank">http://lists.openembedded.org/mailman/listinfo/bitbake-deve=
l</a><br>
</font></span></div><span class=3D"HOEnZb"><font color=3D"#888888"><br><a h=
ref=3D"http://sigads.rediff.com/RealMedia/ads/click_nx.ads/www.rediffmail.c=
om/signatureline.htm@Middle?" target=3D"_blank"><img src=3D"http://sigads.r=
ediff.com/RealMedia/ads/adstream_nx.ads/www.rediffmail.com/signatureline.ht=
m@Middle"></a><table cellpadding=3D"0" cellspacing=3D"0"><tbody><tr><td><di=
v style=3D"font-family:Arial,Helvetica,sans-serif;font-size:14px">Get your =
own <span style=3D"padding-bottom:0px;background-color:#cc0000;padding-left=
:3px;padding-RIGHT:3px;font-family:Arial,Helvetica,sans-serif;color:#ffffff=
;font-size:12px;padding-top:0px"><b>FREE</b></span> website,  <span style=
=3D"padding-bottom:0px;background-color:#c00;padding-left:3px;padding-RIGHT=
:3px;font-family:Arial,Helvetica,sans-serif;color:#ffffff;font-size:12px;pa=
dding-top:0px"><b>FREE</b></span> domain &amp; <span style=3D"padding-botto=
m:0px;background-color:#c00;padding-left:3px;padding-RIGHT:3px;font-family:=
Arial,Helvetica,sans-serif;color:#ffffff;font-size:12px;padding-top:0px"><b=
>FREE</b></span> mobile app with Company email. =C2=A0</div></td><td><a hre=
f=3D"http://track.rediff.com/click?url=3D___http://businessemail.rediff.com=
?sc_cid=3Dsign-1-10-13___&amp;cmp=3Dhost&amp;lnk=3Dsign-1-10-13&amp;nsrv1=
=3Dhost" style=3D"font-family:Arial,Helvetica,sans-serif;color:#fff;font-si=
ze:14px;color:#0000cc" target=3D"_blank"><b>Know More &gt;</b></a></td></tr=
></tbody></table></font></span></blockquote></div><br><br clear=3D"all"><br=
>-- <br><div class=3D"gmail_signature"><div dir=3D"ltr">Alex Damian<div>Yoc=
to Project<br></div><div>SSG / OTC=C2=A0</div></div></div>
</div>

--089e013cbfb83441c40510a2fced--
