Return-Path: <kumar.ugesh003@yahoo.com>
Received: from sonic301-48.consmr.mail.sg3.yahoo.com
	(sonic301-48.consmr.mail.sg3.yahoo.com [106.10.242.111])
	by mail.openembedded.org (Postfix) with ESMTP id 0790374F62
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 May 2018 16:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
	t=1525881825; bh=rN2aqRq+NFPbZDRFD5rXf/mSA7hSphoFWFeVMnRiUL0=;
	h=Date:From:Reply-To:To:Cc:In-Reply-To:References:Subject:From:Subject;
	b=iTsc1EmjJ6mMUmkR5gi1cy4a+cJs+t8xBlFNhH59GoqSNH4L9wWophE+8exh3FaSOWSTO6gqNLeiwd8TOaw53mgW6/gbB1GwKQCCn/eOJh4C1zjFj/Ti+2Dxe33NON88q2X2lSUnuTXeGDCgtF5/vVpvM4uwzFRMG8wizBgYJeUteC6Kt0lm5TcSct0ZSngNwzJ5UuElBwKXCb17U8D++URV/P8Gy1tDhd1Pd1I1XfWsaAZfvthQpIlXmJnRMMCOmiVY+jV69ax7M/nGMsk7jDQtWZgu8GoAi3RNTF3bxHfcQtoNunV6QMa1G1Vgb/QjVZZR5mLL+Dyo7k0ZU4hZmQ==
X-YMail-OSG: eWTtr2wVM1nfYGmDGpWVS.Q8UVC8.m26VcQMsTAAonYTAy65dKdX2UZIaE4t8wz
	jRSs.38PBWqd8Rj6NsIrHGPhVQiGY2sXYiMG8NCvBQbd03mKP4687qurTCNr0fibr4SUysKlEx4G
	0lw8jOsKwug2GXznQXUuHmkfHsBJ.wMIwFkR96eG2vI_PDUZjW.N606u6WkZPkZnvdl9YLCsylbg
	pbXe4YOEZPfxQ_bVkmRTQlYrEk5cstwybbnDPauPkm_cVN5Iha0MgL5C2lKrDv3qUr7V82NyKEzJ
	pz12rawwTdxanBEuSus671VJh_lJaDJgalzfO.uv.UtOtC4gWu__mWyv0lK0b1uYcBWFLxN8g8ZV
	8DeRoQKb03a625INd8DEUao9aMaTzFQlgjKlxBOQNEPVOu0YMHUkRXdlbdKbHwuEFlyMtp3m_7y2
	foDT.xcOEMIWsZ3T0FO6ssfnuavGg_We4wfMWNu4140nWRVuc.zEUSjlvDGTsk.w.kANhxRDo9vV
	C6rlAabF97FBhgrMcVEd.Rd8-
Received: from sonic.gate.mail.ne1.yahoo.com by
	sonic301.consmr.mail.sg3.yahoo.com with HTTP;
	Wed, 9 May 2018 16:03:45 +0000
Date: Wed, 9 May 2018 15:59:42 +0000 (UTC)
From: Ugesh Reddy <kumar.ugesh003@yahoo.com>
Reply-To: "kumar.ugesh003@yahoo.com" <kumar.ugesh003@yahoo.com>
To: "ross.burton@intel.com" <ross.burton@intel.com>
Message-ID: <838865895.1728045.1525881582620@mail.yahoo.com>
In-Reply-To: <CAJTo0LZGEBwiZr7csd3vxYaThN7-fTjexeRfkT+1ksX-AerbvA@mail.gmail.com>
References: <1184471455.1381374.1525832300014.ref@mail.yahoo.com>
	<1184471455.1381374.1525832300014@mail.yahoo.com>
	<CAJTo0LZGEBwiZr7csd3vxYaThN7-fTjexeRfkT+1ksX-AerbvA@mail.gmail.com>
MIME-Version: 1.0
X-Mailer: WebService/1.1.11848 YahooMailAndroidMobile YMobile/1.0
	(com.yahoo.mobile.client.android.mail/5.24.8; Android/6.0;
	MPB24.65-34-3; titan_umtsds; motorola; XT1068; 4.69; 1184x720; )
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: .bb script file for auto tools
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
X-List-Received-Date: Wed, 09 May 2018 16:03:46 -0000
Content-Type: multipart/alternative; 
	boundary="----=_Part_1728044_1441909714.1525881582617"

------=_Part_1728044_1441909714.1525881582617
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello,=C2=A0The devtool hides out the information and trying to learn bitba=
ke and wanted understand each entry in the .BB files.So I would to write it=
 instead of tool.
Could you guide me?
  On Wed, 9 May 2018 at 5:14 p.m., Burton, Ross<ross.burton@intel.com> wro=
te:   The easy way is to just use devtool to create the recipe for you.=C2=
=A0 The important bit is just "inherit autotools" to handle autoreconf/con=
figure/make/make install for you.
Ross
On 9 May 2018 at 03:18, Ugesh Reddy via bitbake-devel <bitbake-devel@lists=
.openembedded.org> wrote:

Hello All,
=C2=A0I am new to bitbake and having the basic understanding on bitbake. M=
y project uses auto tools and it has Makefile.am and configure.ac when it r=
uns with autogen.sh it could able to generate Makefile and configure with g=
enerated files the bin program is generated. I would like to do the same wi=
th bitbake. The below are the structure
=C2=A0 =C2=A0As mentioned in the below linkhttps://github.com/ DynamicDevi=
ces/bbexample

When it executed like below it works fine=C2=A0$ cd bbexample=C2=A0$ ./aut=
ogen.sh=C2=A0$ ./configure=C2=A0$ make
How can i write the .bb file for the same ?
Regards,Ugesh



=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=
=C2=A0=C2=A0 =C2=A0
| =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |


--=20
______________________________ _________________
bitbake-devel mailing list
bitbake-devel@lists. openembedded.org
http://lists.openembedded.org/ mailman/listinfo/bitbake-devel



  

------=_Part_1728044_1441909714.1525881582617
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello,<div id=3D"yMail_cursorElementTracker_1525881354960">&nbsp;The devtoo=
l hides out the information and trying to learn bitbake and wanted understa=
nd each entry in the .BB files.So I would to write it instead of tool.</div=
><div id=3D"yMail_cursorElementTracker_1525881480048"><br></div><div id=3D"=
yMail_cursorElementTracker_1525881480127">Could you guide me?</div><div id=
=3D"yMail_cursorElementTracker_1525881491761"><br></div><div id=3D"yMail_c=
ursorElementTracker_1525881491872"><br id=3D"yMail_cursorElementTracker_152=
5881346914"><br><div id=3D"ymail_android_signature"><a href=3D"https://over=
view.mail.yahoo.com/mobile/?.src=3DAndroid"></a></div> <br> <blockquote sty=
le=3D"margin: 0 0 20px 0;"> <div style=3D"font-family:Roboto, sans-serif; c=
olor:#6D00F6;"> <div>On Wed, 9 May 2018 at 5:14 p.m., Burton, Ross</div><di=
v>&lt;ross.burton@intel.com&gt; wrote:</div> </div> <div style=3D"padding: =
10px 0 0 20px; margin: 10px 0 0 0; border-left: 1px solid #6D00F6;"> <div i=
d=3D"yiv5248776238"><div><div dir=3D"ltr">The easy way is to just use devto=
ol to create the recipe for you.&nbsp; The important bit is just "inherit a=
utotools" to handle autoreconf/configure/make/make install for you.<div><br=
 clear=3D"none"></div><div>Ross</div></div><div class=3D"yiv5248776238gmail=
_extra"><br clear=3D"none"><div class=3D"yiv5248776238gmail_quote">On 9 May=
 2018 at 03:18, Ugesh Reddy via bitbake-devel <span dir=3D"ltr">&lt;<a rel=
=3D"nofollow" shape=3D"rect" ymailto=3D"mailto:bitbake-devel@lists.openemb=
edded.org" target=3D"_blank" href=3D"mailto:bitbake-devel@lists.openembedde=
d.org">bitbake-devel@lists.openembedded.org</a>&gt;</span> wrote:<br clear=
=3D"none"><blockquote class=3D"yiv5248776238gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;"><div class=3D"yiv52=
48776238yqt6169368907 yQTDBase" id=3D"yiv5248776238yqt55152"><div><div styl=
e=3D"font-family:Helvetica Neue, Helvetica, Arial, sans-serif;font-size:16p=
x;"><div style=3D"font-family:Helvetica Neue, Helvetica, Arial, sans-serif;=
font-size:16px;"><div id=3D"yiv5248776238m_-799902520484865810ydp388441fayi=
v6951807158"><div style=3D"font-family:Helvetica Neue, Helvetica, Arial, sa=
ns-serif;font-size:16px;"><div>Hello All,</div><div><br clear=3D"none"></di=
v><div>&nbsp;I am new to bitbake and having the basic understanding on bitb=
ake. My project uses auto tools and it has Makefile.am and <a rel=3D"nofoll=
ow" shape=3D"rect" target=3D"_blank" href=3D"http://configure.ac">configure=
.ac</a> when it runs with autogen.sh it could able to generate Makefile and=
 configure with generated files the bin program is generated. I would like =
to do the same with bitbake. The below are the structure</div><div><br clea=
r=3D"none"></div><div>&nbsp; &nbsp;As mentioned in the below link</div><div=
><a rel=3D"nofollow" shape=3D"rect" target=3D"_blank" href=3D"https://githu=
b.com/DynamicDevices/bbexample">https://github.com/ DynamicDevices/bbexampl=
e</a><br clear=3D"none"></div><div><br clear=3D"none"></div><div>When it ex=
ecuted like below it works fine</div><div><span></span><div>&nbsp;$ cd bbex=
ample</div><div>&nbsp;$ ./autogen.sh</div><div>&nbsp;$ ./configure</div><di=
v>&nbsp;$ make</div><br clear=3D"none"></div><div>How can i write the .bb f=
ile for the same ?</div><div><br clear=3D"none"></div><div>Regards,</div><d=
iv>Ugesh</div><div><br clear=3D"none"></div><div><br clear=3D"none"></div><=
div><br clear=3D"none"></div><div><br clear=3D"none"></div><div>&nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</div><d=
iv>&nbsp; &nbsp;</div><div><table class=3D"yiv5248776238m_-7999025204848658=
10ydp9ae10bc2highlight yiv5248776238m_-799902520484865810ydp9ae10bc2tab-siz=
e yiv5248776238m_-799902520484865810ydp9ae10bc2js-file-line-container" styl=
e=3D"border-collapse:collapse;color:rgb(36,41,46);font-family:-apple-system=
, BlinkMacSystemFont,;"><tbody><tr><td colspan=3D"1" rowspan=3D"1" class=3D=
"yiv5248776238m_-799902520484865810ydp9ae10bc2blob-code yiv5248776238m_-799=
902520484865810ydp9ae10bc2blob-code-inner yiv5248776238m_-79990252048486581=
0ydp9ae10bc2js-file-line" id=3D"yiv5248776238m_-799902520484865810ydp9ae10b=
c2LC1" style=3D"padding:0px 10px;line-height:20px;vertical-align:top;font-f=
amily:SFMono-Regular, Consolas,;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;</td></tr></tbody></table></div></div></div></div>=
</div></div></div><br clear=3D"none">-- <br clear=3D"none">
______________________________ _________________<br clear=3D"none">
bitbake-devel mailing list<br clear=3D"none">
<a rel=3D"nofollow" shape=3D"rect" ymailto=3D"mailto:bitbake-devel@lists.o=
penembedded.org" target=3D"_blank" href=3D"mailto:bitbake-devel@lists.opene=
mbedded.org">bitbake-devel@lists. openembedded.org</a><br clear=3D"none">
<a rel=3D"nofollow" shape=3D"rect" target=3D"_blank" href=3D"http://lists.=
openembedded.org/mailman/listinfo/bitbake-devel">http://lists.openembedded.=
org/ mailman/listinfo/bitbake-devel</a><br clear=3D"none">
<br clear=3D"none"></blockquote></div><br clear=3D"none"></div></div></div=
> </div> </blockquote></div>

------=_Part_1728044_1441909714.1525881582617--
