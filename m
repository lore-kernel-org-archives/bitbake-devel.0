Return-Path: <marlon.rodriguez-garcia@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91AEC41513
	for <webhook@archiver.kernel.org>; Thu, 12 Oct 2023 17:42:43 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.18959.1697132558360311028
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 12 Oct 2023 10:42:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=N5Em5BBZ;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: marlon.rodriguez-garcia@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 95DE29C2A80
	for <bitbake-devel@lists.openembedded.org>; Thu, 12 Oct 2023 13:42:37 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id xQKNrD4utIUj; Thu, 12 Oct 2023 13:42:36 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id C3AD79C2D13;
	Thu, 12 Oct 2023 13:42:36 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com C3AD79C2D13
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1697132556; bh=CyDydiW0wwYubiDubc1Snf9ONXxvdksQ1r+7u3IJ2Yw=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=N5Em5BBZztvNw0zERh7ECb3pXUscYSOVkz4/7CQX5+oP07fhgj1LtJSsE9nbigOj5
	 60PE6Oi/4tEDLZP2eqtetUxnSA8+exUTXxPxCigY8FcgsMpZ+0DR1C+DBlx0sUZ68/
	 ZM3yMgKux6SyvvN1tjcpxqBTPzujmX1WjiR617gH9rohTFb1Tyu6ID6JvPrGZa3KdQ
	 P4HuPGGvXj7iUWHaZI6qzR9C4oOvcdxJd7sK+/f3rdMcAhXTEm/W9H8AQlUWaI6CSJ
	 bJ7nvmQZ7pYRzN2QwkJqBdfArVz/uhIW6ZRVMe54yMJk1fLa9NHDEn7/FT2b7gy/Ie
	 +ApKnwnudfDDQ==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id K06rtUJRUqcR; Thu, 12 Oct 2023 13:42:36 -0400 (EDT)
Received: from savoirfairelinux.mtl.sfl (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id B44159C2A80;
	Thu, 12 Oct 2023 13:42:36 -0400 (EDT)
From: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfairelinux.com>
Subject: [PATCH 2/3] toaster: updated bootstrap version
Date: Thu, 12 Oct 2023 13:42:18 -0400
Message-Id: <20231012174219.62435-2-marlon.rodriguez-garcia@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012174219.62435-1-marlon.rodriguez-garcia@savoirfairelinux.com>
References: <20231012174219.62435-1-marlon.rodriguez-garcia@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 12 Oct 2023 17:42:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15214

Updated bootstrap from version 3.3.6 to 3.3.7 to fix compatibility errors
https://github.com/twbs/bootstrap/issues/16834

Signed-off-by: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfai=
relinux.com>
---
 .../toastergui/static/js/bootstrap.min.js     | Bin 36864 -> 37049 bytes
 1 file changed, 0 insertions(+), 0 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/bootstrap.min.js b/lib/toas=
ter/toastergui/static/js/bootstrap.min.js
index c4a924160de6bd6104dad160d379dfb7ffbe6185..2446398cfe6177172771488ec=
9bbef5429050afd 100644
GIT binary patch
delta 835
zcmZva&rcIU6vwmuVQJB#2B86ev@2P6Vck>(s!P`%@D~R$iXr?6hjw>%yVCBK-Knji
z4RA1mgeZCO;srbzZ^{^>9!$J)l7B!$VgiXV@jt+6gK)sPOlIc$=3D6&Diz1daIr&pfm
zEllEFYY)R*g4>Mg>1JU`jFW8!d(N0TpXM_XPCEv|f@Hcp&YG?uI0zRVD+*<w;Hg$&
zQS5;qzD*_pU;W=3D3*|V&oD0*sqLMAJRc05ditON&`kW_H&0<Vg(IBbQk?H@0Y&c+Te
zj5Hl(`k)-{Jt;;_t5C$__)!5VteQpYWX3MD6X%3V1?Da`8(Pf?TNjC$BF47G3Moy(
zj%gUk;aS~Qi!Lk3nxvbSwyTsMny#72q1}joM^>OB$HlyGAfEgVZ+dA_8-o$Db^Mjr
zPjSR}c-9g*oKD8~D3G<5mkdl#2AkZRshO6shsTJ-|94N;BA<hGSP}A=3Db&vQGtZ0BG
zw3F8Oorc|nGne_m35^z#M;4|$)4N@$RLJX;&_tnb46X;g)DkS_r{Kvj4}GI-TTG>F
z2CN~R#^}CNMEssjD2=3D{{UK|GTN|@Xl%LF|f2dnBlSYr*KE5~4ct_{8{1w2t5+5-YC
zYbE&5944*kEi+Q09PN@cG<@@V4%HlSoJzao;<TkATaO-i7Y#*AO=3DG(t$Hg4du^g|;
zdde#1a&ktpb=3D^gjxR`~X`Y>ZcpK;fp6;06~%f`n*NK8u|sGf)P+kY5ZYxmTt0Nw7D
zU-<l?C|$5s*(TqrGjzIWe@+u?w!cPhZT?pXB~^}NX=3D)bUEObgS9(C2GRw`Nr(@HA3
zM4tqz$k=3Dpp@~m7F7)d34UZc0Lvv7k$NkvW7e~@dAV~WOcX4iwOHO+n?$v*}EUrm`G
AnE(I)

delta 701
zcmY*WO;6NN6wR9tJA(oeg@GuMsRmjoO-E%yiZc~4MojP{8jK_^I_>L+cG_|JN+isH
zE(IebH*Q=3DQz=3DXZNg-W6>{Q<IZVf<JT*}E_%+JPAoS1<S6bMHClzPGE92P=3D`~4wQYF
z8batKOdvaQiiM>KiEbehfp;mUUF8ZQQOhPKylDFzv234LU^d1l<!R5>d!%X=3Dz6nF{
zIMD+Kmzy9Se;v!Rf)1*37&hY{>H5CE5tOCt$#Dd~o5twH{l}yIBf4m*{+OfsKF1b_
z%kq^9r{{E0b37mWgk!}Wloz1Vl8yC+ZCGkKdQ7vhcDLZ&XK&XaO)Qo1G<L~(Y^Z@l
zI6B_?JsJ(=3DVHCI1bBETV{bfvovfHEPYtF?JHo-+-bg*j@YcNx(NO@J+%^}m~)H4Ln
zyBWAT6NfKdOrp_&51kVH2@d=3DRQl@JoxfhjwW=3DV4x^RiS->>2np%rms@EZ^Ed;MZ^)
z)vl~1VP<j#R&TMLT6olP_c~DtzEKV^$JaHXa+8DT)DyZqHJ^kd`W#aa0`q+xF_RZe
z_?l}^HXL%WsjniQ2KYVd)|FY}m1Ie9ut8+0Di=3Di0Fnmn7+SsBwi7fbGUW=3DQ8B^Y$r
zdc(Xb{Y0Vp?R(u!_#|hZ#^6PD3pLTjx%o)LJY^qVN}wzhA8n_!JXY9Hgq72o5!(p=3D
z&?Cev!stTkv>P~1I;SakVCUq4Te96VIYSKTN;)IgsjRFH>iHZVFl!)eEL`BUu&i(0
Y-J$pP+5>m;xsa*sjiocRcM;<M0L}dC&j0`b

--=20
2.34.1


