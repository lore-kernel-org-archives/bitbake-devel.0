Return-Path: <kumar.ugesh003@yahoo.com>
Received: from sonic305-19.consmr.mail.sg3.yahoo.com
	(sonic305-19.consmr.mail.sg3.yahoo.com [106.10.241.82])
	by mail.openembedded.org (Postfix) with ESMTP id E81F16C63A
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 26 Nov 2018 07:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
	t=1543217797; bh=uTcch5i8s39Jg1j2IfCZCgEeeSoolkichXvNv4+F5qk=;
	h=Date:From:Reply-To:To:Cc:Subject:References:From:Subject;
	b=cGP25ywTijV2OW0XM9qQ1BBBd3ZMb0+TlL4nUANrXAOLm8WQMrjIrv4z1RZ17pg4teNe87N+8po77KBmUMCX+hKX/PcPDaeB/DWIMkcR8VtAXGOBBlvYolR8+kJ5IR+CxVHQaxgHd00OEhvNbccu+nrpLxOQrJjZXQslgNaLars7tOFbywSJztkZ3OAIwYla1MUenfbM9/LwzIxPA98blVpKbiKAOB+PjTYgBqeplH0Rj/rdTDOcbwF34iNGNeRU2weIM0+7Z4uxzRuXCRXnZCNRSS1Lb+w+lQAqxumxnoD2kvpvwIHWwu6eLcPl1y22QqE4xBRwGgelAcfMKKBkCg==
X-YMail-OSG: .TPKdsYVM1khEbwkAmSAHaFYJWvkDI67jNUmQFIXPMxpUBmvtl5zm0Os3DR1WxO
	jo5V13rUAlMISLM3BcQgug8IFldHDwOxJ7ToqiCzpHaIiZ91K0Lo8lN5dXEFRaLCfWnUsW7gbWKG
	PlzlK1Qn0jRiJR77WaH3o3lsFAloDu8SQmZHmtANJY9p9p0TLhzjJcipxKTOyRrlcuiY9EOzO87L
	Wp3m1oItW4to9VTVG0VLvmR7MPMfyFYwVrAD1yGxFlLydo93Q9Alio8txq8ycZl5zrihW04L79KR
	58pHu9Idoo53TDn6KACtGs46nPIbXee2rXBXaHt08txRZgAOIZmDipY9lCeWKgvOM.LCdGuKuQw4
	HP_3P8Y8PMkL8aLhiKeSMkGciJRYxZJkL9Oy7_YH6T26xJ3xz3EJZvSNErUgZQk.RyEIupPbEy27
	m0RZ7qkAluBdelTP0n4NYQdscHE8IFK2z9gnIP04uVOQg4pUfdHdbr3qoz6hfavwvJAXzcNhEcsb
	4dihYfszVzqhm3xwnuM61HPecVFw3MB_qgCDCe_xpCoizGLUDtoATKWDO_ty3ch8F4r4qWyAj1e8
	Pwg9EDTByj.Rks5uZT7SvWK7Pey.Sao69_Q6w9hk6LaRCzDsC1aAr7UIuWnCZL8RZ8Z4t5L2kTGM
	iqCTJUOWUYvE.tkiSr1BwRRiJwTaGlrxUBaJkQYaTfx3Kxl3bi2paqXAHlSiCpMM4KkPX4D65eAq
	b1q8A.ZWEu4YWhZsiXwNakro5MQ7D1dYibD9okNq.yJU1q4LxnGUuhNFGsvYsLPxylK0YJJSz5F_
	0xZ4eSaHZay586reuvyJdzTQOM6rwe.w.Z_xnqYvw9J8wGYB2MofUzJSC2qlIs6w8R8psHnjm9dL
	d.PDZOGfutLZgAjSlfxnqrSuxCCAyFC_6kKoa9UxV0R6_mo6RLdIlOq2h45cT1qzZydo.zQqsrON
	KP1_RONaoqjfFMwCn16jhntj1BqYwHFWtCXy8uxc61wuDryb38fBJAJXrQXTH.EvlFYJWAU0knJ1
	oESM01jowX.LwiJpezl2pa8CLpJlxAevZIA--
Received: from sonic.gate.mail.ne1.yahoo.com by
	sonic305.consmr.mail.sg3.yahoo.com with HTTP;
	Mon, 26 Nov 2018 07:36:37 +0000
Date: Mon, 26 Nov 2018 07:36:33 +0000 (UTC)
From: Ugesh Reddy <kumar.ugesh003@yahoo.com>
Reply-To: "kumar.ugesh003@yahoo.com" <kumar.ugesh003@yahoo.com>
To: Bitbake-devel <bitbake-devel@lists.openembedded.org>
Message-ID: <119490492.5831423.1543217793985@mail.yahoo.com>
MIME-Version: 1.0
References: <119490492.5831423.1543217793985.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.12729 YahooMailAndroidMobile YMobile/1.0
	(com.yahoo.mobile.client.android.mail/5.34.0; Android/8.1.0;
	OPM1.171019.011; beryllium; Xiaomi; POCO F1; 5.71; 2116x1080; )
Cc: "Ugesh Munirajulu \(RBEI\\/ECG-EP3\)" <ugesh.munirajulu@in.bosch.com>
Subject: Copying the files to sysroot
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
X-List-Received-Date: Mon, 26 Nov 2018 07:36:38 -0000
Content-Type: multipart/alternative; 
	boundary="----=_Part_5831422_277298323.1543217793983"

------=_Part_5831422_277298323.1543217793983
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello All,

I have the yocto bsp for iMx8 eval board and compiled it successfully. I ha=
ve introduced the new custom layer and written .bb file for my recipe and t=
he component is compiled successfully and want to install the my include in=
 sysroot/usr/include/component at the end. I don't have the clue how to do =
that . Could you please some one guide me.

=C2=A0

I want the below to be achieved from .bb files.

1. I want to copy the header includes to sysroot/usr/include/component

2. Another recipe shall be able to refer the header from sysroot/usr/includ=
e/component




Regards,

Ugesh

------=_Part_5831422_277298323.1543217793983
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div id=3D"ymail_android_signature">Hello All,</div><div id=3D"yMail_cursor=
ElementTracker_1543217671697"><br></div><div id=3D"yMail_cursorElementTrack=
er_1543217672288"><p style=3D"margin: 0px; padding: 0px; border: 0px; font-=
size: 15px; font-family: arial, helvetica, &quot;helvetica neue&quot;, verd=
ana, sans-serif; vertical-align: baseline; overflow-wrap: break-word; color=
: rgb(81, 98, 111); background-color: rgb(255, 255, 255);" id=3D"yMail_curs=
orElementTracker_1543217680825">I have the yocto bsp for iMx8 eval board an=
d compiled it successfully. I have introduced the new custom layer and writ=
ten .bb file for my recipe and the component is compiled successfully and w=
ant to install the my include in sysroot/usr/include/component at the end. =
I don't have the clue how to do that . Could you please some one guide me.<=
/p><p style=3D"margin: 0px; padding: 0px; border: 0px; font-size: 15px; fon=
t-family: arial, helvetica, &quot;helvetica neue&quot;, verdana, sans-serif=
; vertical-align: baseline; overflow-wrap: break-word; color: rgb(81, 98, 1=
11); background-color: rgb(255, 255, 255); min-height: 8pt;">&nbsp;</p><p s=
tyle=3D"margin: 0px; padding: 0px; border: 0px; font-size: 15px; font-famil=
y: arial, helvetica, &quot;helvetica neue&quot;, verdana, sans-serif; verti=
cal-align: baseline; overflow-wrap: break-word; color: rgb(81, 98, 111); ba=
ckground-color: rgb(255, 255, 255);">I want the below to be achieved from .=
bb files.</p><p style=3D"margin: 0px; padding: 0px; border: 0px; font-size:=
 15px; font-family: arial, helvetica, &quot;helvetica neue&quot;, verdana, =
sans-serif; vertical-align: baseline; overflow-wrap: break-word; color: rgb=
(81, 98, 111); background-color: rgb(255, 255, 255);">1. I want to copy the=
 header includes to sysroot/usr/include/component</p><p style=3D"margin: 0p=
x; padding: 0px; border: 0px; font-size: 15px; font-family: arial, helvetic=
a, &quot;helvetica neue&quot;, verdana, sans-serif; vertical-align: baselin=
e; overflow-wrap: break-word; color: rgb(81, 98, 111); background-color: rg=
b(255, 255, 255);" id=3D"yMail_cursorElementTracker_1543217678730">2. Anoth=
er recipe shall be able to refer the header from sysroot/usr/include/compon=
ent</p><p style=3D"margin: 0px; padding: 0px; border: 0px; font-size: 15px;=
 font-family: arial, helvetica, &quot;helvetica neue&quot;, verdana, sans-s=
erif; vertical-align: baseline; overflow-wrap: break-word; color: rgb(81, 9=
8, 111); background-color: rgb(255, 255, 255);" id=3D"yMail_cursorElementTr=
acker_1543217689960"><br></p><p style=3D"margin: 0px; padding: 0px; border:=
 0px; font-size: 15px; font-family: arial, helvetica, &quot;helvetica neue&=
quot;, verdana, sans-serif; vertical-align: baseline; overflow-wrap: break-=
word; color: rgb(81, 98, 111); background-color: rgb(255, 255, 255);" id=3D=
"yMail_cursorElementTracker_1543217690540">Regards,</p><p style=3D"margin: =
0px; padding: 0px; border: 0px; font-size: 15px; font-family: arial, helvet=
ica, &quot;helvetica neue&quot;, verdana, sans-serif; vertical-align: basel=
ine; overflow-wrap: break-word; color: rgb(81, 98, 111); background-color: =
rgb(255, 255, 255);" id=3D"yMail_cursorElementTracker_1543217696559">Ugesh<=
/p></div>

------=_Part_5831422_277298323.1543217793983--
