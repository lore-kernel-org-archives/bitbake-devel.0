Return-Path: <ms98.cho@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD42CD4F25
	for <webhook@archiver.kernel.org>; Fri, 15 May 2026 16:03:24 +0000 (UTC)
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.38301.1778860999642749104
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 15 May 2026 09:03:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=qzpNW2j4;
 spf=pass (domain: gmail.com, ip: 74.125.224.48, mailfrom: ms98.cho@gmail.com)
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-651bf695701so12811563d50.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 15 May 2026 09:03:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778860999; cv=none;
        d=google.com; s=arc-20240605;
        b=fdjkpUTxe5iOw0o91iEhwKUxSPdbJ72NSONPBEACZGhzcPrbRa0+y7Js/zxJrNxxY2
         ZxRqRB6nHHA2gwF4EnCMpjDQrbHOIIAdX53SBRZEvhPTMoPMXPU8i6iL2oSKGJF+EllE
         eU1f0grRwWphkFE+KqgeXnasSKZUecqDfAsuiybQxA6pLrKUWioITl4YXDg+5jSix7DT
         Dnm0PrlzEiXpdlE48igBGoVTs53F9Eht2jFQPY+DZSkpUjE2q+WmDSJVkXMbdqJuL+E5
         bi2Hc7Iw6c+kZEaA2xM+rWDyyLycE8om7y43+KO7vwGrBXZOr2SdBMfOX6azw5Sac7LO
         ERFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6D3odlV7FCRjap0W19b5tGw34XJQ4m2WXaXc2QXn8Os=;
        fh=sphBPKtoj0zUW3fEDoBEWDQJmg3JZZjuuqC4GXtJNTg=;
        b=Nujt8boQyh4qUCefRkLjRKBm7fGFw3j6++hVdyrS+i3nA0cYLLEydhm8DNLURd/TeX
         aF6OCkYA/ZhohKiB1pnH+mlLDj1BxPQxHMa0kQuq+OWIL9ke1hsnQPNw6X6ZASS+p1n2
         mhgOLp+nRcTCgt39mIO1dLVjolzgYiyxoT4Gs1DhFXMmyzTSJrYJDgYpmvJRUODkjt5J
         S1M8S7+/KRn4LmvoUfd+iqGJxdaj2E7KYMsFCVvl7HnHHh0NuQXLgGYePXxcmeOYfsQ4
         tj/qs5CjTagpidE4umTWfswDD6F32erJQ5t4ABFue84NtJLJtG+CYw9EEdlOntEnGgwG
         V5GQ==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778860999; x=1779465799; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6D3odlV7FCRjap0W19b5tGw34XJQ4m2WXaXc2QXn8Os=;
        b=qzpNW2j4LD4yKkQaenwZKnMmuYCrzFYu5cM7t2iSnzI89924XKZUnK2k3cO+CmTJ0P
         YxpbRhnzAaLHia/B4FJhrxGouVAYSV6yIgSSu9GzgQ9v6x8DlqR468Rvh53m0VnTGZ1m
         mD05TCr31cAOxkGQVbiM9q9D9kXhVo49DPq+EVKbqTENYyhczak938FjgXQcDD72TDyO
         pM9bn87+Z5HIfWEQwbGpOYAm7a2wEjY+jzTb+3IuvTdl/DHRDOS5LzH2uYhsR1KcxPps
         T+ds124hkvzU13hVGVyEdEGi4FlGOkHxHCwyhCcWeZi2vYvS5pmpkPTD0u5VFenhBHrN
         UaVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778860999; x=1779465799;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6D3odlV7FCRjap0W19b5tGw34XJQ4m2WXaXc2QXn8Os=;
        b=aA6fKxkokBEwSC2/Hqnv6mnhP9z2Zsu/YeOa1phRnHjXL9QvmAgg+A+X7ivD3OIbkd
         7emkTh2GdqLcBLTMEIXOqURXRv7eVwvgqsVs7ZSt6ymIICsdwqhxtAx3wwUXTJvunbc3
         0Y518esQGr1bjKDENBQpZGQ+UXOjncp7ImeuirygaKxN9LL7CYhjuvOfZrB3RIz6QrH3
         pMhKV2qmha3j0nMiSvNZdeIWphIKwGLsUxX8ORAuK8rQD7gt4VfpuyMkayiflsQVBLnI
         QwVlbLspxa1+Kz9XtU7T3V+us0p6ue1hi7odhYIkhz0uzsmzKEVXI3c15L8IbCX9raK1
         9fXA==
X-Gm-Message-State: AOJu0YzwUlxK5Nt9+x1YC9xY4S1J7bBkiIkCnmrC0ho8U3FalPqX0yVl
	zXPBDNwJxzem7sFmVzxdKtk4V1D3SHDV5C7T9ea46ZQsMjz8Q5f+H7r0eoXoxY+2KAKGn0rMpcT
	OkEC5BMWXXvB9Koiildnpui2+grdIxzsovjhFZcY=
X-Gm-Gg: Acq92OHELDxbwfXUBWlbRe2YC+7Ns6tBOGDXR81mpTl3WoRFid+a7/EwrhZ4g1KUbQB
	+0277BKjbi0RKEh/cokTbVvxANXpdzDWrblfXa3fjaAdhpKp3eQvRnlhlfTQeWPCJzaPSJZQT9J
	bxTwfltxT2azl+ipWQC17Rq3xkh7Di/qB2KTZoDmdtmpRBHQlPciwRuLyL9xlMpSe82kX/ONUb4
	e6HoSLWkPp0JT75v1J4jIeEMHtOgMXbIgk2PsO8ErvsLBLYrXsJLVvErbYjF4r2A59MKjjFQTDc
	inslT9ZXbVJcQAOgssL+ZffIZeYOHHxYwm8ir1E=
X-Received: by 2002:a05:690c:6b12:b0:7bd:d4f4:261b with SMTP id
 00721157ae682-7c95b33d4b2mr50441637b3.29.1778860998278; Fri, 15 May 2026
 09:03:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260514051143.67992-1-ms98.cho@gmail.com> <20260514200526.98596-1-ms98.cho@gmail.com>
 <DIJ7EROQQXAI.3RDRH6003P8C3@bootlin.com>
In-Reply-To: <DIJ7EROQQXAI.3RDRH6003P8C3@bootlin.com>
From: Minsung Cho <ms98.cho@gmail.com>
Date: Fri, 15 May 2026 09:03:07 -0700
X-Gm-Features: AVHnY4IFL8jgkrMMNQL1ZCgmyTn-ejrilvgYNBc8BDXFBCEF1LmgGmMkn1vfIbM
Message-ID: <CAMGcssHbYC8O+1YPAh_Y4JpLvQsccUfppQKQMrgY_8DEOniYog@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v2] fetch2/crate: support configurable
 registry and index URLs
To: mathieu.dubois-briand@bootlin.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000e8452e0651dd598d"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 15 May 2026 16:03:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19529

--000000000000e8452e0651dd598d
Content-Type: text/plain; charset="UTF-8"

Hi Mathieu,

Thanks for testing this and digging into the failure.

I reproduced it locally with master + Chen Qi's filter_regex series + this
patch. The KeyError comes from the conflict resolution in
latest_versionstring(), not from either patch on its own. The merged tree
kept the old prefix check (ud.versionsurl.startswith('
https://index.crates.io/')), but this patch intentionally drops that in
favour of an explicit ud.crate_index_format == 'sparse' check, since the
whole point is to support custom sparse registries whose index URL isn't on
index.crates.io. The local sparse registry test serves its index from
127.0.0.1, so the prefix check sends NDJSON to the JSON API parser.

The right merge keeps the format check and threads filter_regex through
both helpers:

def latest_versionstring(self, ud, d, filter_regex=None):
if getattr(ud, 'crate_index_format', None) == 'sparse':
return self._latest_versionstring_from_index(ud, d, filter_regex)
return self._latest_versionstring_from_api(ud, d, filter_regex)

With that, CrateTest passes here (12 tests, 5 skipped), including
test_crate_fetches_from_local_sparse_registry.

I've got a v3 ready with exactly that resolution, rebased on the
filter_regex series. Agreed it's cleaner to wait until that series lands or
gets dropped, then I'll send the refreshed v3. I'll watch the thread.

Thanks,
Minsung

On Fri, May 15, 2026 04:12 AM, Mathieu Dubois-Briand <
mathieu.dubois-briand@bootlin.com> wrote:

> On Thu May 14, 2026 at 10:05 PM CEST, minsung.cho via
> lists.openembedded.org wrote:
> > The crate fetcher previously hardcoded the crates.io download URL and
> > only supported a fixed /crate/versions API shape for custom registries.
> > This prevented recipes from using private registries or mirrors with
> > different download paths or Cargo sparse indexes.
> >
> > Add BB_CRATE_REGISTRY_URL[host] and BB_CRATE_INDEX_URL[host] templates
> > with {crate}, {version}, and {index_path} placeholders. Keep the
> > existing crates.io defaults, allow custom API-style version endpoints,
> > and mark sparse indexes explicitly so latest-version checks parse Cargo
> > index NDJSON instead of JSON API responses.
> >
> > Add non-network tests for default crates.io URLs, custom registry
> > templates, sparse index paths, trailing slash handling, and both
> > latest-version parser paths. Also make the fetch test cleanup chmod
> > invocation portable by placing -R before the mode.
> >
> > [YOCTO #16276]
> >
> > Signed-off-by: minsung.cho <ms98.cho@gmail.com>
> > ---
>
> Hi,
>
> Thanks for your patch.
>
> I note it does conflict with some other patches currently in testing,
> and once these conflicts solved, I get some bitbake-selftest errors:
>
> ERROR: test_crate_fetches_from_local_sparse_registry
> (bb.tests.fetch.CrateTest.test_crate_fetches_from_local_sparse_registry)
> ----------------------------------------------------------------------
> Traceback (most recent call last):
>   File
> "/srv/pokybuild/yocto-worker/oe-selftest-debian/build/layers/bitbake/lib/bb/tests/fetch.py",
> line 2829, in test_crate_fetches_from_local_sparse_registry
>     self.assertEqual(ud.method.latest_versionstring(ud, self.d),
>                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File
> "/srv/pokybuild/yocto-worker/oe-selftest-debian/build/layers/bitbake/lib/bb/fetch2/crate.py",
> line 197, in latest_versionstring
>     return self._latest_versionstring_from_api(ud, d)
>            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File
> "/srv/pokybuild/yocto-worker/oe-selftest-debian/build/layers/bitbake/lib/bb/fetch2/crate.py",
> line 204, in _latest_versionstring_from_api
>     versions = [(0, i["num"], "") for i in json_data["versions"]]
>                                            ~~~~~~~~~^^^^^^^^^^^^
> KeyError: 'versions'
>
> https://autobuilder.yoctoproject.org/valkyrie/#/builders/35/builds/3864
> https://autobuilder.yoctoproject.org/valkyrie/#/builders/48/builds/3727
> https://autobuilder.yoctoproject.org/valkyrie/#/builders/23/builds/3960
>
> Maybe the easiest solution is to wait a few days until said patches are
> either merged or rejected, then send a refreshed version.
>
> If you want to have a look at the current situation, here is the branch
> that was used for above builds:
>
> https://git.yoctoproject.org/poky-ci-archive/log/?h=bitbake/autobuilder.yoctoproject.org/valkyrie/a-full-3832
>
> Thanks,
> Mathieu
>
> --
> Mathieu Dubois-Briand, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>
>

--000000000000e8452e0651dd598d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div dir=3D"auto">Hi Mathieu,<br><br>Thanks for testi=
ng this and digging into the failure.<br><br>I reproduced it locally with m=
aster + Chen Qi&#39;s filter_regex series + this patch. The KeyError comes =
from the conflict resolution in latest_versionstring(), not from either pat=
ch on its own. The merged tree kept the old prefix check (ud.versionsurl.st=
artswith(&#39;<a href=3D"https://index.crates.io/&#39;)" target=3D"_blank">=
https://index.crates.io/&#39;)</a>), but this patch intentionally drops tha=
t in favour of an explicit ud.crate_index_format =3D=3D &#39;sparse&#39; ch=
eck, since the whole point is to support custom sparse registries whose ind=
ex URL isn&#39;t on <a href=3D"http://index.crates.io" target=3D"_blank">in=
dex.crates.io</a>. The local sparse registry test serves its index from 127=
.0.0.1, so the prefix check sends NDJSON to the JSON API parser.<br><br>The=
 right merge keeps the format check and threads filter_regex through both h=
elpers:<br><br>    def latest_versionstring(self, ud, d, filter_regex=3DNon=
e):<br>        if getattr(ud, &#39;crate_index_format&#39;, None) =3D=3D &#=
39;sparse&#39;:<br>            return self._latest_versionstring_from_index=
(ud, d, filter_regex)<br>        return self._latest_versionstring_from_api=
(ud, d, filter_regex)<br><br>With that, CrateTest passes here (12 tests, 5 =
skipped), including test_crate_fetches_from_local_sparse_registry.<br><br>I=
&#39;ve got a v3 ready with exactly that resolution, rebased on the filter_=
regex series. Agreed it&#39;s cleaner to wait until that series lands or ge=
ts dropped, then I&#39;ll send the refreshed v3. I&#39;ll watch the thread.=
<br><br>Thanks,<br>Minsung<br></div></div></div><br><div class=3D"gmail_ext=
ra"><div>On Fri, May 15, 2026 04:12 AM, Mathieu Dubois-Briand &lt;<a href=
=3D"mailto:mathieu.dubois-briand@bootlin.com" target=3D"_blank">mathieu.dub=
ois-briand@bootlin.com</a>&gt; wrote:<br><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">On Thu May 14, 2026 at 10:05 PM CEST, minsung.cho via <a hr=
ef=3D"http://lists.openembedded.org" rel=3D"noreferrer" target=3D"_blank">l=
ists.openembedded.org</a> wrote:<br>
&gt; The crate fetcher previously hardcoded the <a href=3D"http://crates.io=
" rel=3D"noreferrer" target=3D"_blank">crates.io</a> download URL and<br>
&gt; only supported a fixed /crate/versions API shape for custom registries=
.<br>
&gt; This prevented recipes from using private registries or mirrors with<b=
r>
&gt; different download paths or Cargo sparse indexes.<br>
&gt;<br>
&gt; Add BB_CRATE_REGISTRY_URL[host] and BB_CRATE_INDEX_URL[host] templates=
<br>
&gt; with {crate}, {version}, and {index_path} placeholders. Keep the<br>
&gt; existing <a href=3D"http://crates.io" rel=3D"noreferrer" target=3D"_bl=
ank">crates.io</a> defaults, allow custom API-style version endpoints,<br>
&gt; and mark sparse indexes explicitly so latest-version checks parse Carg=
o<br>
&gt; index NDJSON instead of JSON API responses.<br>
&gt;<br>
&gt; Add non-network tests for default <a href=3D"http://crates.io" rel=3D"=
noreferrer" target=3D"_blank">crates.io</a> URLs, custom registry<br>
&gt; templates, sparse index paths, trailing slash handling, and both<br>
&gt; latest-version parser paths. Also make the fetch test cleanup chmod<br=
>
&gt; invocation portable by placing -R before the mode.<br>
&gt;<br>
&gt; [YOCTO #16276]<br>
&gt;<br>
&gt; Signed-off-by: minsung.cho &lt;<a href=3D"mailto:ms98.cho@gmail.com" t=
arget=3D"_blank">ms98.cho@gmail.com</a>&gt;<br>
&gt; ---<br>
<br>
Hi,<br>
<br>
Thanks for your patch.<br>
<br>
I note it does conflict with some other patches currently in testing,<br>
and once these conflicts solved, I get some bitbake-selftest errors:<br>
<br>
ERROR: test_crate_fetches_from_local_sparse_registry (bb.tests.fetch.CrateT=
est.test_crate_fetches_from_local_sparse_registry)<br>
----------------------------------------------------------------------<br>
Traceback (most recent call last):<br>
=C2=A0 File &quot;/srv/pokybuild/yocto-worker/oe-selftest-debian/build/laye=
rs/bitbake/lib/bb/tests/fetch.py&quot;, line 2829, in test_crate_fetches_fr=
om_local_sparse_registry<br>
=C2=A0 =C2=A0 self.assertEqual(ud.method.latest_versionstring(ud, self.d),<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^<br>
=C2=A0 File &quot;/srv/pokybuild/yocto-worker/oe-selftest-debian/build/laye=
rs/bitbake/lib/bb/fetch2/crate.py&quot;, line 197, in latest_versionstring<=
br>
=C2=A0 =C2=A0 return self._latest_versionstring_from_api(ud, d)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^<br>
=C2=A0 File &quot;/srv/pokybuild/yocto-worker/oe-selftest-debian/build/laye=
rs/bitbake/lib/bb/fetch2/crate.py&quot;, line 204, in _latest_versionstring=
_from_api<br>
=C2=A0 =C2=A0 versions =3D [(0, i[&quot;num&quot;], &quot;&quot;) for i in =
json_data[&quot;versions&quot;]]<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0~~~~~~~~~^^^^^^^^^^^^<br>
KeyError: &#39;versions&#39;<br>
<br>
<a href=3D"https://autobuilder.yoctoproject.org/valkyrie/#/builders/35/buil=
ds/3864" rel=3D"noreferrer" target=3D"_blank">https://autobuilder.yoctoproj=
ect.org/valkyrie/#/builders/35/builds/3864</a><br>
<a href=3D"https://autobuilder.yoctoproject.org/valkyrie/#/builders/48/buil=
ds/3727" rel=3D"noreferrer" target=3D"_blank">https://autobuilder.yoctoproj=
ect.org/valkyrie/#/builders/48/builds/3727</a><br>
<a href=3D"https://autobuilder.yoctoproject.org/valkyrie/#/builders/23/buil=
ds/3960" rel=3D"noreferrer" target=3D"_blank">https://autobuilder.yoctoproj=
ect.org/valkyrie/#/builders/23/builds/3960</a><br>
<br>
Maybe the easiest solution is to wait a few days until said patches are<br>
either merged or rejected, then send a refreshed version.<br>
<br>
If you want to have a look at the current situation, here is the branch<br>
that was used for above builds:<br>
<a href=3D"https://git.yoctoproject.org/poky-ci-archive/log/?h=3Dbitbake/au=
tobuilder.yoctoproject.org/valkyrie/a-full-3832" rel=3D"noreferrer" target=
=3D"_blank">https://git.yoctoproject.org/poky-ci-archive/log/?h=3Dbitbake/a=
utobuilder.yoctoproject.org/valkyrie/a-full-3832</a><br>
<br>
Thanks,<br>
Mathieu<br>
<br>
-- <br>
Mathieu Dubois-Briand, Bootlin<br>
Embedded Linux and Kernel engineering<br>
<a href=3D"https://bootlin.com" rel=3D"noreferrer" target=3D"_blank">https:=
//bootlin.com</a><br>
<br>
</blockquote></div></div>

--000000000000e8452e0651dd598d--

