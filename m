Return-Path: <kweihmann@outlook.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07520D44158
	for <webhook@archiver.kernel.org>; Tue, 19 Nov 2024 12:56:30 +0000 (UTC)
Subject: Re: [PATCH] cooker: Drop support for BB_DANGLINGAPPENDS_WARNONLY
To: bitbake-devel@lists.openembedded.org
From: "Konrad Weihmann" <kweihmann@outlook.com>
X-Originating-Location: Berlin, Land Berlin, DE (78.55.154.173)
X-Originating-Platform: Linux Chrome 130
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Tue, 19 Nov 2024 04:56:29 -0800
References: <20241119103446.1983984-1-richard.purdie@linuxfoundation.org>
In-Reply-To: <20241119103446.1983984-1-richard.purdie@linuxfoundation.org>
Message-ID: <6663.1732020989399254787@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="Uom28UzDQqbiOxvV9G0v"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 19 Nov 2024 12:56:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16812

--Uom28UzDQqbiOxvV9G0v
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

It might be poorly designed but it helps a lot in the following situation
We have poky or any other "lower" layer providing a recipe-x_1.2.3.
Then we have a layer on top doing a recipe-x_1.2.3.bbappend (to applying ba=
ckported patches or configuration options or anything version specific).
Now there is an update to the lower to version 1.2.4.
With the removal we get a failing build, with the WARN only we get just a w=
arning, version 1.2.4 is picked.
Final decision if the build is good can be done in testing and/or post insp=
ection.
With the functionality removed I would need to add a patch to the upper lay=
er with a BBMASK
which then in any CI system I know would build with the older lower layer, =
basically removing the
entire append (which can't be right).
Alternative would be to schedule two changes at the same time (updated lowe=
r layer and patched upper layer).
To be honest I've not seen an automated CI system that works like that, lea=
ving it all with
manual assembly of the inputs - requiring a ton of extra work.

Another alternative would be to loosen the bbappend mask to cover all versi=
on of the base recipe, but
that makes it impossible (without huge efforts) to apply patches for just a=
 single version.
All in all the functionality might have been poorly designed but very helpf=
ul and
I don't see BBMASK as an equivalent replacement.

my 2 cents

--Uom28UzDQqbiOxvV9G0v
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>
<div>It might be poorly designed but it helps a lot in the following situat=
ion</div>
<div>We have poky or any other "lower" layer providing a recipe-x_1.2.3.<br=
 />Then we have a layer on top doing a recipe-x_1.2.3.bbappend (to applying=
 backported patches or configuration options or anything version specific).=
</div>
<div>Now there is an update to the lower to version 1.2.4.<br />With the re=
moval we get a failing build, with the WARN only we get just a warning, ver=
sion 1.2.4 is picked.<br />Final decision if the build is good can be done =
in testing and/or post inspection.</div>
<div>With the functionality removed I would need to add a patch to the uppe=
r layer with a BBMASK<br />which then in any CI system I know would build w=
ith the older lower layer, basically removing the<br />entire append (which=
 can't be right).<br />Alternative would be to schedule two changes at the =
same time (updated lower layer and patched upper layer).</div>
<div>To be honest I've not seen an automated CI system that works like that=
, leaving it all with<br />manual assembly of the inputs - requiring a ton =
of extra work.</div>
<div>&nbsp;</div>
<div>Another alternative would be to loosen the bbappend mask to cover all =
version of the base recipe, but<br />that makes it impossible (without huge=
 efforts) to apply patches for just a single version.</div>
<div>All in all the functionality might have been poorly designed but very =
helpful and<br />I don't see BBMASK as an equivalent replacement.</div>
<div>&nbsp;</div>
<div>my 2 cents</div>
</div>

--Uom28UzDQqbiOxvV9G0v--

