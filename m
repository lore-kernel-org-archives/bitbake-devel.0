Return-Path: <alan.kozlay@ves.solutions>
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
	[209.85.210.179])
	by mail.openembedded.org (Postfix) with ESMTP id 40E437EA7A
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Jun 2019 17:31:41 +0000 (UTC)
Received: by mail-pf1-f179.google.com with SMTP id q10so3318360pff.9
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Jun 2019 10:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ves-solutions-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:from:date:message-id:subject:to;
	bh=zeLpm8yeXXCsgCLAVYKehjzQHqXiqkdqsYrl1MfvBR8=;
	b=ya2vPOQJTVp7/vFcfhsZY0bThSXBxFaPjZH/MIVODtLRUG278XMCk/+Vkcyl7wP4xP
	ThVNAZwCnFTtstIMPinWil9vM9UfItc1QHqbQfEiBhYO/a1s13alyC3VxS1ur7I+2L1K
	dX1+SBapCW6Ln1r0f5HjrIVVhiz3mlxPH44MrIfyig35H0laDgLL1fMfCEPR4S5jnlc8
	4EU2Pafx9fp4gcQsI3UhfmugUfKzeJGRfwzHbKTUkxQB+a6c/AzE/acfb37hzdwihJwY
	icgd8QSeWKdmUccztVRM6SWx5h3+kL+uYgbkycHmhC/lBEggAW8tCUEuuuFFHB1spkjD
	iw2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
	bh=zeLpm8yeXXCsgCLAVYKehjzQHqXiqkdqsYrl1MfvBR8=;
	b=QdpaRG5ZpTyEE4EDUZh6w5LLiQHKmjNzWCMapDrEapYvsiPP0xw5BlkGDcjjqZHEdg
	5VGuuLMEX66smcj6zvZBVHeCLr0gPbC+lQ7CmO802e29urQIyQcRLSjtNz4GgLNNweQW
	TlgWW6YF8orDhNfnRmGSQzMBD3ppICQsOXyoI7uO/KBmxUGWq+x9QvH3VYp09098+NAX
	pUsZGhipqqaQKTatVobs0fRG45qxuQwNFQLQ/9B5Kp+cBRMjP12JdZBgfTX2/7Cg42Q4
	5YVgYPCez/c1GHO/6cF/j6aNd3ykllncLaY/pZ2WLl/iln4WnK59O5JJSY+uU6q3SlUb
	kOAg==
X-Gm-Message-State: APjAAAXY28OPD8jQ5y5vAwxJKZYs6F34VWmjEpl9OysMQuEHRtRrpxz1
	PTGDnhXgiXCS1qeYJxABA4Mp2AXR1C0w+cT4hyjdwEGR3MI=
X-Google-Smtp-Source: APXvYqzqZBJcqpX4Ez9YVHRN6G4STDsf5ZEX2Ff91iDniV4kb8Eoo06tNC4dz53wwkLNmcZ1VeXgz/GLCIxZwNERzEI=
X-Received: by 2002:a63:d84e:: with SMTP id k14mr10426966pgj.234.1561743101971;
	Fri, 28 Jun 2019 10:31:41 -0700 (PDT)
MIME-Version: 1.0
From: Alan Kozlay <alan.kozlay@ves-solutions.com>
Date: Fri, 28 Jun 2019 13:31:06 -0400
Message-ID: <CAJE9sG=4MPryg2+h5a-jmhhpqPW=o6E26rte-JSPc31UioNbwQ@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: Should multiconfig save build time?
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
X-List-Received-Date: Fri, 28 Jun 2019 17:31:41 -0000
Content-Type: multipart/alternative; boundary="000000000000d2f16e058c65a68f"

--000000000000d2f16e058c65a68f
Content-Type: text/plain; charset="UTF-8"

All,

We have need to generate 6 slighly different images, with different
dedicated applications and use cases, but they're all destined for the same
hardware.
We have multiconfig set to build these 6 variants.  Clearly, they'll all
share a majority of underlying packages.
While the bitbake initialization takes a long time (*with multiconfig*), we
were under the impression that it could save time during the actual build
process because it could have the potential to reuse packages already built
from mc A for mc B if the inputs to the recipes are unchanged (if same
xxx_FEATURES, same arch, etc.).

This was a guess on our part since we initially didn't assign different tmp
directories for each conf.  So, the <WORKDIR> didn't change between mc
builds.  That actually was causing some issues until we realized that
separate tmp dirs was recommended for them.
Since they all now have separate tmp dirs, they clearly are not going to
share work dirs, so, now we're questioning our original assumption about
any build-time speed benefit.

So, is mc expected to be any faster than, say, 6 separate invocations of
non-mc bitbake whilst switching out the local.conf between them?

Thanks,
-Alan

-- 
Alan Kozlay
VES Solutions, LLC
Alan Kozlay <alan.kozlay@ves.solutions>
DESK 443-595-7734
CELL 443-752-0323

--000000000000d2f16e058c65a68f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">All,<div><br></div><div>We have need to generate 6 slighly=
 different images, with different dedicated applications and use cases, but=
 they&#39;re all destined for the same hardware.</div><div>We have multicon=
fig set to build these 6 variants.=C2=A0 Clearly, they&#39;ll all share a m=
ajority of underlying packages.</div><div>While the bitbake initialization =
takes a long time (<i>with multiconfig</i>), we were under the impression t=
hat it could save time during the actual build process because it could hav=
e the potential to reuse packages already built from mc A for mc B if the i=
nputs to the recipes are unchanged (if same xxx_FEATURES, same arch, etc.).=
</div><div><br></div><div>This was a guess on our part since we initially d=
idn&#39;t assign different tmp directories for each conf.=C2=A0 So, the &lt=
;WORKDIR&gt; didn&#39;t change between mc builds.=C2=A0 That actually was c=
ausing some issues until we realized that separate tmp dirs was recommended=
 for them.</div><div>Since they all now have separate tmp dirs, they clearl=
y are not going to share work dirs, so, now we&#39;re questioning our origi=
nal assumption about any build-time speed benefit.</div><div><br></div><div=
>So, is mc expected to be any faster than, say, 6 separate invocations of n=
on-mc bitbake whilst switching out the local.conf between them?=C2=A0</div>=
<div><br></div><div>Thanks,</div><div>-Alan<br clear=3D"all"><div><br></div=
>-- <br><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_=
signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><span><div><div dir=3D"lt=
r"><div><div>Alan Kozlay<br></div><div dir=3D"ltr">VES Solutions, LLC<br><s=
pan>Alan Kozlay &lt;alan.kozlay@ves.solutions&gt;</span><div>DESK 443-595-7=
734<br></div><div>CELL 443-752-0323</div></div></div></div></div></span></d=
iv></div></div></div><input name=3D"virtru-metadata" type=3D"hidden" value=
=3D"{&quot;email-policy&quot;:{&quot;state&quot;:&quot;closed&quot;,&quot;e=
xpirationUnit&quot;:&quot;days&quot;,&quot;disableCopyPaste&quot;:false,&qu=
ot;disablePrint&quot;:false,&quot;disableForwarding&quot;:false,&quot;enabl=
eNoauth&quot;:false,&quot;persistentProtection&quot;:false,&quot;expandedWa=
termarking&quot;:false,&quot;expires&quot;:false,&quot;isManaged&quot;:fals=
e},&quot;attachments&quot;:{},&quot;compose-id&quot;:&quot;1&quot;,&quot;co=
mpose-window&quot;:{&quot;secure&quot;:false}}"></div></div>

--000000000000d2f16e058c65a68f--
