Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418CCCDB47E
	for <webhook@archiver.kernel.org>; Fri, 13 Oct 2023 21:27:13 +0000 (UTC)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
 by mx.groups.io with SMTP id smtpd.web11.50585.1697232432689882278
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 13 Oct 2023 14:27:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=UExEKRTC;
 spf=pass (domain: gmail.com, ip: 209.85.219.177, mailfrom: ticotimo@gmail.com)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-d9ac31cb021so2653281276.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 13 Oct 2023 14:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697232432; x=1697837232; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e8I1aG/U3nCjuKpLBZ/bCTrPZJ9Z45IJiMvslftXTCw=;
        b=UExEKRTCj90rbWjKFinmN6+tzGZGVijiV5yIf/2BvZjiHlEWPWS40YZBpIudUalM47
         1bj1fIHBkA1LVoAaGHL2P2UwMvS6nloTIQBZR8I6TXQmSllJTEFf9Isg12fMO65LGhb0
         BugZv5WX2HWaC/GPDAwCsUCvvefbvfibl3vtq7lQXIQiVyKeKFFHPAyhbLOnv/9oxAS8
         W18YrRpyIYmBv9dgXVt+0F4+nURMSak9hsYobEkkPZVyh+Kdw1WgzJ5hSH6VX/HreXN6
         ma//DKAFmlOdUQ2DSe9/B3tke2ejgsAjAuYze9FXMgwhcmit0BVCwbqQh9eH4/0OexxR
         DPtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697232432; x=1697837232;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e8I1aG/U3nCjuKpLBZ/bCTrPZJ9Z45IJiMvslftXTCw=;
        b=H9AQVMb4KeTOmi1fwQJWB6Xvs4k+gLhM5scJrp9JmGAj+pXqyWfsJuOxYyCgfoOJrX
         YTVXrhW2rVonOKqubN1LyEJ5u+7oNln9mPSynGkLtP3cBVkx9Xo66RdEpGpyrCEAAiMv
         5IYxsoYsyxSKlM8aW75XYfE89nJfUfni857Ur5eGK8YyNWuihjs1wBfxOiifIyUgG4o6
         iPGVnIRkBp5NqNeLvVL0dZeRkgfgrXi0u7bi9c/txCtPbJqIw/IMCSRXl8a1CUN57+3R
         ODMnnsPccXt84BB4Eld6MKD/hWjAmIXzlGRi4ARUNw6emkcgc2l9WtKO1ci0Vg+Ur/J+
         z3iA==
X-Gm-Message-State: AOJu0Yxw1iYheh5cI4y+QAuL4qsAQ4EUnMK/fOxvYzYxrTc0qYEVacAI
	CVCIXiJpV+1GFOv8r5z+zdZbgk50vkLinEhuylqKj+6MO6M=
X-Google-Smtp-Source: AGHT+IF3MLedDLTe3NKXT+LUk+XzDUOYU5I61CwR06ZTEuN3pSQ7IeJLYF7hXwQpS15JNLfyDFU0INBko4HvDH57igE=
X-Received: by 2002:a25:1105:0:b0:d9a:4772:48c6 with SMTP id
 5-20020a251105000000b00d9a477248c6mr12207185ybr.38.1697232431659; Fri, 13 Oct
 2023 14:27:11 -0700 (PDT)
MIME-Version: 1.0
References: <20231012174219.62435-1-marlon.rodriguez-garcia@savoirfairelinux.com>
 <20231012174219.62435-2-marlon.rodriguez-garcia@savoirfairelinux.com>
In-Reply-To: <20231012174219.62435-2-marlon.rodriguez-garcia@savoirfairelinux.com>
From: Tim Orling <ticotimo@gmail.com>
Date: Fri, 13 Oct 2023 14:27:00 -0700
Message-ID: <CANx9H-CoOfmX+-BJj-zWGTcMwpy8RJo=JoDx3uz6V6esSuhNhA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 2/3] toaster: updated bootstrap version
To: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfairelinux.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="00000000000030be3006079fb825"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 13 Oct 2023 21:27:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15242

--00000000000030be3006079fb825
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 12, 2023 at 10:42=E2=80=AFAM Marlon Rodriguez Garcia <
marlon.rodriguez-garcia@savoirfairelinux.com> wrote:

> Updated bootstrap from version 3.3.6 to 3.3.7 to fix compatibility errors
> https://github.com/twbs/bootstrap/issues/16834
>
>
There are also outstanding vulnerabilities on 3.3.7 which mean we should
move to 3.4.1 (not 4.x, that is too much of a change in the syntax and
usage).
https://nvd.nist.gov/vuln/search/results?form_type=3DAdvanced&results_type=
=3Doverview&isCpeNameSearch=3Dtrue&seach_type=3Dall&query=3Dcpe:2.3:a:getbo=
otstrap:bootstrap:3.3.7:*:*:*:*:*:*:*



> Signed-off-by: Marlon Rodriguez Garcia <
> marlon.rodriguez-garcia@savoirfairelinux.com>
> ---
>

In follow up versions of patches, please use e.g. [PATCH v2]
https://docs.yoctoproject.org/contributor-guide/submit-changes.html#taking-=
patch-review-into-account

Comments about changes in PATCH v2 should go here.
e.g.
Changes in v2:
<summary of what is different since v1>


>  .../toastergui/static/js/bootstrap.min.js     | Bin 36864 -> 37049 bytes
>

You did not also replace bootstrap.js

I also think we should instead change:
bootstrap.min.js to bootstrap-3.4.1.min.js
bootstrap.js to bootstrap-3.4.1.js

I realize upstream bundles do not contain versions in the file names, but
it will help us remember what version we are on.


 1 file changed, 0 insertions(+), 0 deletions(-)
>
> diff --git a/lib/toaster/toastergui/static/js/bootstrap.min.js
> b/lib/toaster/toastergui/static/js/bootstrap.min.js
> index
> c4a924160de6bd6104dad160d379dfb7ffbe6185..2446398cfe6177172771488ec9bbef5=
429050afd
> 100644
> GIT binary patch
> delta 835
> zcmZva&rcIU6vwmuVQJB#2B86ev@2P6Vck>(s!P`%@D~R$iXr?6hjw>%yVCBK-Knji
> z4RA1mgeZCO;srbzZ^{^>9!$J)l7B!$VgiXV@jt+6gK)sPOlIc$=3D6&Diz1daIr&pfm
> zEllEFYY)R*g4>Mg>1JU`jFW8!d(N0TpXM_XPCEv|f@Hcp&YG?uI0zRVD+*<w;Hg$&
> zQS5;qzD*_pU;W=3D3*|V&oD0*sqLMAJRc05ditON&`kW_H&0<Vg(IBbQk?H@0Y&c+Te
> zj5Hl(`k)-{Jt;;_t5C$__)!5VteQpYWX3MD6X%3V1?Da`8(Pf?TNjC$BF47G3Moy(
> zj%gUk;aS~Qi!Lk3nxvbSwyTsMny#72q1}joM^>OB$HlyGAfEgVZ+dA_8-o$Db^Mjr
> zPjSR}c-9g*oKD8~D3G<5mkdl#2AkZRshO6shsTJ-|94N;BA<hGSP}A=3Db&vQGtZ0BG
> zw3F8Oorc|nGne_m35^z#M;4|$)4N@$RLJX;&_tnb46X;g)DkS_r{Kvj4}GI-TTG>F
> z2CN~R#^}CNMEssjD2=3D{{UK|GTN|@Xl%LF|f2dnBlSYr*KE5~4ct_{8{1w2t5+5-YC
> zYbE&5944*kEi+Q09PN@cG<@@V4%HlSoJzao;<TkATaO-i7Y#*AO=3DG(t$Hg4du^g|;
> zdde#1a&ktpb=3D^gjxR`~X`Y>ZcpK;fp6;06~%f`n*NK8u|sGf)P+kY5ZYxmTt0Nw7D
> zU-<l?C|$5s*(TqrGjzIWe@+u?w!cPhZT?pXB~^}NX=3D)bUEObgS9(C2GRw`Nr(@HA3
> zM4tqz$k=3Dpp@~m7F7)d34UZc0Lvv7k$NkvW7e~@dAV~WOcX4iwOHO+n?$v*}EUrm`G
> AnE(I)
>
> delta 701
> zcmY*WO;6NN6wR9tJA(oeg@GuMsRmjoO-E%yiZc~4MojP{8jK_^I_>L+cG_|JN+isH
> zE(IebH*Q=3DQz=3DXZNg-W6>{Q<IZVf<JT*}E_%+JPAoS1<S6bMHClzPGE92P=3D`~4wQYF
> z8batKOdvaQiiM>KiEbehfp;mUUF8ZQQOhPKylDFzv234LU^d1l<!R5>d!%X=3Dz6nF{
> zIMD+Kmzy9Se;v!Rf)1*37&hY{>H5CE5tOCt$#Dd~o5twH{l}yIBf4m*{+OfsKF1b_
> z%kq^9r{{E0b37mWgk!}Wloz1Vl8yC+ZCGkKdQ7vhcDLZ&XK&XaO)Qo1G<L~(Y^Z@l
> zI6B_?JsJ(=3DVHCI1bBETV{bfvovfHEPYtF?JHo-+-bg*j@YcNx(NO@J+%^}m~)H4Ln
> zyBWAT6NfKdOrp_&51kVH2@d=3DRQl@JoxfhjwW=3DV4x^RiS->>2np%rms@EZ^Ed;MZ^)
> z)vl~1VP<j#R&TMLT6olP_c~DtzEKV^$JaHXa+8DT)DyZqHJ^kd`W#aa0`q+xF_RZe
> z_?l}^HXL%WsjniQ2KYVd)|FY}m1Ie9ut8+0Di=3Di0Fnmn7+SsBwi7fbGUW=3DQ8B^Y$r
> zdc(Xb{Y0Vp?R(u!_#|hZ#^6PD3pLTjx%o)LJY^qVN}wzhA8n_!JXY9Hgq72o5!(p=3D
> z&?Cev!stTkv>P~1I;SakVCUq4Te96VIYSKTN;)IgsjRFH>iHZVFl!)eEL`BUu&i(0
> Y-J$pP+5>m;xsa*sjiocRcM;<M0L}dC&j0`b
>
> --
> 2.34.1
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15214):
> https://lists.openembedded.org/g/bitbake-devel/message/15214
> Mute This Topic: https://lists.openembedded.org/mt/101923495/924729
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> ticotimo@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--00000000000030be3006079fb825
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 12, 2023 at 10:42=E2=80=
=AFAM Marlon Rodriguez Garcia &lt;<a href=3D"mailto:marlon.rodriguez-garcia=
@savoirfairelinux.com">marlon.rodriguez-garcia@savoirfairelinux.com</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Updated =
bootstrap from version 3.3.6 to 3.3.7 to fix compatibility errors<br>
<a href=3D"https://github.com/twbs/bootstrap/issues/16834" rel=3D"noreferre=
r" target=3D"_blank">https://github.com/twbs/bootstrap/issues/16834</a><br>
<br></blockquote><div><br></div><div>There are also outstanding vulnerabili=
ties=C2=A0on 3.3.7 which mean we should move to 3.4.1 (not 4.x, that is too=
 much of a change in the syntax and usage).</div><div><a href=3D"https://nv=
d.nist.gov/vuln/search/results?form_type=3DAdvanced&amp;results_type=3Dover=
view&amp;isCpeNameSearch=3Dtrue&amp;seach_type=3Dall&amp;query=3Dcpe:2.3:a:=
getbootstrap:bootstrap:3.3.7:*:*:*:*:*:*:*">https://nvd.nist.gov/vuln/searc=
h/results?form_type=3DAdvanced&amp;results_type=3Doverview&amp;isCpeNameSea=
rch=3Dtrue&amp;seach_type=3Dall&amp;query=3Dcpe:2.3:a:getbootstrap:bootstra=
p:3.3.7:*:*:*:*:*:*:*</a><br></div><div><br></div><div>=C2=A0</div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
Signed-off-by: Marlon Rodriguez Garcia &lt;<a href=3D"mailto:marlon.rodrigu=
ez-garcia@savoirfairelinux.com" target=3D"_blank">marlon.rodriguez-garcia@s=
avoirfairelinux.com</a>&gt;<br>
---<br></blockquote><div><div><br></div><div>In follow up versions of patch=
es, please use e.g. [PATCH v2]</div><div><a href=3D"https://docs.yoctoproje=
ct.org/contributor-guide/submit-changes.html#taking-patch-review-into-accou=
nt">https://docs.yoctoproject.org/contributor-guide/submit-changes.html#tak=
ing-patch-review-into-account</a></div></div><div><br></div><div>Comments a=
bout changes in PATCH v2 should go here.</div><div>e.g.</div><div>Changes i=
n v2:</div><div>&lt;summary of what is different since v1&gt;</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0.../toastergui/static/js/bootstrap.min.js=C2=A0 =C2=A0 =C2=A0| Bin 36=
864 -&gt; 37049 bytes<br></blockquote><div><br></div><div>You did not also =
replace bootstrap.js</div><div><br></div><div><div>I also think we should i=
nstead change:</div><div>bootstrap.min.js to bootstrap-3.4.1.min.js</div><d=
iv>bootstrap.js to bootstrap-3.4.1.js</div><div><br></div><div>I realize up=
stream bundles do not contain versions in the file names, but it will help =
us remember what version we are on.</div><div><br></div></div><div><br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A01 file changed, 0 insertions(+), 0 deletions(-)<br>
<br>
diff --git a/lib/toaster/toastergui/static/js/bootstrap.min.js b/lib/toaste=
r/toastergui/static/js/bootstrap.min.js<br>
index c4a924160de6bd6104dad160d379dfb7ffbe6185..2446398cfe6177172771488ec9b=
bef5429050afd 100644<br>
GIT binary patch<br>
delta 835<br>
zcmZva&amp;rcIU6vwmuVQJB#2B86ev@2P6Vck&gt;(s!P`%@D~R$iXr?6hjw&gt;%yVCBK-Knj=
i<br>
z4RA1mgeZCO;srbzZ^{^&gt;9!$J)l7B!$VgiXV@jt+6gK)sPOlIc$=3D6&amp;Diz1daIr&amp=
;pfm<br>
zEllEFYY)R*g4&gt;Mg&gt;1JU`jFW8!d(N0TpXM_XPCEv|f@Hcp&amp;YG?uI0zRVD+*&lt;w;=
Hg$&amp;<br>
zQS5;qzD*_pU;W=3D3*|V&amp;oD0*sqLMAJRc05ditON&amp;`kW_H&amp;0&lt;Vg(IBbQk?H=
@0Y&amp;c+Te<br>
zj5Hl(`k)-{Jt;;_t5C$__)!5VteQpYWX3MD6X%3V1?Da`8(Pf?TNjC$BF47G3Moy(<br>
zj%gUk;aS~Qi!Lk3nxvbSwyTsMny#72q1}joM^&gt;OB$HlyGAfEgVZ+dA_8-o$Db^Mjr<br>
zPjSR}c-9g*oKD8~D3G&lt;5mkdl#2AkZRshO6shsTJ-|94N;BA&lt;hGSP}A=3Db&amp;vQGtZ=
0BG<br>
zw3F8Oorc|nGne_m35^z#M;4|$)4N@$RLJX;&amp;_tnb46X;g)DkS_r{Kvj4}GI-TTG&gt;F<b=
r>
z2CN~R#^}CNMEssjD2=3D{{UK|GTN|@Xl%LF|f2dnBlSYr*KE5~4ct_{8{1w2t5+5-YC<br>
zYbE&amp;5944*kEi+Q09PN@cG&lt;@@V4%HlSoJzao;&lt;TkATaO-i7Y#*AO=3DG(t$Hg4du^=
g|;<br>
zdde#1a&amp;ktpb=3D^gjxR`~X`Y&gt;ZcpK;fp6;06~%f`n*NK8u|sGf)P+kY5ZYxmTt0Nw7D=
<br>
zU-&lt;l?C|$5s*(TqrGjzIWe@+u?w!cPhZT?pXB~^}NX=3D)bUEObgS9(C2GRw`Nr(@HA3<br>
zM4tqz$k=3Dpp@~m7F7)d34UZc0Lvv7k$NkvW7e~@dAV~WOcX4iwOHO+n?$v*}EUrm`G<br>
AnE(I)<br>
<br>
delta 701<br>
zcmY*WO;6NN6wR9tJA(oeg@GuMsRmjoO-E%yiZc~4MojP{8jK_^I_&gt;L+cG_|JN+isH<br>
zE(IebH*Q=3DQz=3DXZNg-W6&gt;{Q&lt;IZVf&lt;JT*}E_%+JPAoS1&lt;S6bMHClzPGE92P=
=3D`~4wQYF<br>
z8batKOdvaQiiM&gt;KiEbehfp;mUUF8ZQQOhPKylDFzv234LU^d1l&lt;!R5&gt;d!%X=3Dz6n=
F{<br>
zIMD+Kmzy9Se;v!Rf)1*37&amp;hY{&gt;H5CE5tOCt$#Dd~o5twH{l}yIBf4m*{+OfsKF1b_<b=
r>
z%kq^9r{{E0b37mWgk!}Wloz1Vl8yC+ZCGkKdQ7vhcDLZ&amp;XK&amp;XaO)Qo1G&lt;L~(Y^Z=
@l<br>
zI6B_?JsJ(=3DVHCI1bBETV{bfvovfHEPYtF?JHo-+-bg*j@YcNx(NO@J+%^}m~)H4Ln<br>
zyBWAT6NfKdOrp_&amp;51kVH2@d=3DRQl@JoxfhjwW=3DV4x^RiS-&gt;&gt;2np%rms@EZ^Ed=
;MZ^)<br>
z)vl~1VP&lt;j#R&amp;TMLT6olP_c~DtzEKV^$JaHXa+8DT)DyZqHJ^kd`W#aa0`q+xF_RZe<b=
r>
z_?l}^HXL%WsjniQ2KYVd)|FY}m1Ie9ut8+0Di=3Di0Fnmn7+SsBwi7fbGUW=3DQ8B^Y$r<br>
zdc(Xb{Y0Vp?R(u!_#|hZ#^6PD3pLTjx%o)LJY^qVN}wzhA8n_!JXY9Hgq72o5!(p=3D<br>
z&amp;?Cev!stTkv&gt;P~1I;SakVCUq4Te96VIYSKTN;)IgsjRFH&gt;iHZVFl!)eEL`BUu&am=
p;i(0<br>
Y-J$pP+5&gt;m;xsa*sjiocRcM;&lt;M0L}dC&amp;j0`b<br>
<br>
-- <br>
2.34.1<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#15214): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/15214" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/15214</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/101923495/924=
729" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/101923495/924729</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:ticotimo@gmail.com" target=3D"_bla=
nk">ticotimo@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div></div>

--00000000000030be3006079fb825--

