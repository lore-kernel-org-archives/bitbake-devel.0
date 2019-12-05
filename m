Return-Path: <mailych@yahoo.com>
Received: from sonic307-20.consmr.mail.sg3.yahoo.com
	(sonic307-20.consmr.mail.sg3.yahoo.com [106.10.241.37])
	by mail.openembedded.org (Postfix) with ESMTP id CCC3D60273
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  5 Dec 2019 09:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
	t=1575538513; bh=hXhFkl+rwT7ZEaxnzeiRKdUh1eyQF858Kj8skLB2rB8=;
	h=Date:From:To:Subject:References:From:Subject;
	b=ORpToj5K74nR83VG1IsKYjJJQd4nPsf/900B3VTSmas9vlklMXW8aalUIG8n82zx/JKxcmyM9NdCDlKZYfskR9GmWez7EnE4G2Cm6N6H09sIzwLMZVllH5+aeoIcufr8DbzceMECWyMXR56tHocdN/O5TuVJw49Wwc0LM7yYWznSocvz8Xdj1uKMht7DIv0AUgX7jPynkMajiLq5cjrUWmx4ysVhPo8FryGZcydp47KuKEpN55s327fuU0mG+tnd3gzsJj7KheVtjwcQMmA9mYjMy89Sok6+lT2+nxhUE+HQHHG+5TSISnPQtpW0VGbOQQsqN6oBQcvpjI/h7YsS9Q==
X-YMail-OSG: d7arfFwVM1lA8LQVBmjWRP81_9GMKAnI8F7fyzhPVv2FNchCcV4nSNJMFbjel4U
	8viFLMmR9lfB7RK2Ka3KVRPrCUZAQdFsOwo.jPeF7IR3Ne7RykTC1wgKJgPM44aXWuQ6JH2w_Ddt
	aw3EOSvdlKCqwfJvaAaf_Q2p8kJwIShfurAr4DYGEwN4VkpKMnylBy8rwEa37NXUGVjHSQZlgr0I
	JOc0rCh5igkob6_ncsUoMdlO0s2EH21BM4akbok6rRd.5CK0.gSR9mrENVOkTHFxWZfajJG_82.A
	4BSrFwz2AL9xlMKzW9KdR0K7S6KHIhl_3fYVCOEN3xbAlKHi7Eu_v1PJ6gnHdUmLwYFUDBpPPRGP
	0csEfT2GyF1FXgaLX7Ue6Q.m89miU6MWWk3WuTcX9Z5ZLpdXCRsvCjYkWaLeh9fyMD2yIXVSivbb
	w6Fc1v9r4VNoXLR2A9o57HAnT9YfkUZFwdYR0pntJ2TrY9NHYGbnIb6fFTmhjRTMaxjb__B_hMg0
	Uv4m9Z7s0TwEpZCq1l216msWoFECsZFE3wkl80txi0uz_4LZ1p5dN6e7oppimXkd1Rhd6cx0NcaG
	fkQvDvUd1qE7sIY.hLd4Ri2UykEFTVvbys0__pC_60WYbd33odjqz9ygnpjccDTO8I5PBd_fm_cm
	3j5.mtXZm715CG9.u_MH9FQ9lOGLhV8n89RxlrPYGjuZO.naDyBdyAcSeRBQCW0fFD1oTRAkBe5F
	ZpRFE.QcWNaNaZf8PbKAXKNhxwWqY4aCyMhmlOkUautO5c.o1ZxB5NXeBPZ8HF3zJgQK6KTgp_LH
	BxzMgVv3i0Nxelxi4G1ZKilJi5bQ6bGJKIL8nkyGUY0wEPzcWSj.Nte95hZt15IBZWpKYXyXUxdn
	IvHxEvqkuXvEZfotu52nHFWaiG1E43Jt3yAhnhgL3MMVzPVbg2ktHPEDlWR7Lpo5uSyfnKqIkbWP
	g3PDta3WDt4LMQT.z144jzwGK.kRE.SnRi9EmWpF4al4Gc1xCho0oOmHCU0r7MShjTYuuexAh2jo
	b4cKuv.a87sesuQEcGth9PYsNfYNaGsTZAEfzLswjcYdDwMecPTTsCZDLPgI4DVFZdRYa1.ynJis
	79a93ZPwwiJdE.Ux8zidU8sH6UyBJKiPmtedA3im.0zkddhx0io1XrTgcH_TzNsmhmCDYFRtA4GM
	G6z.uNOxy4E5fappDE3roi0a5SYxSQ7pGw.KX.sd0ap2dFRIkU7uHHx1RA9HO_DFdeTcUEFzIYLx
	TOcn5jEv0iQfxWlwZ2LWwiXWx9gCk2bsq3bReUa2amy_8dxNMhOtfmsOJVuXirzmy4IVNCbE5Uta
	dy9nvt_0rsp0-
Received: from sonic.gate.mail.ne1.yahoo.com by
	sonic307.consmr.mail.sg3.yahoo.com with HTTP;
	Thu, 5 Dec 2019 09:35:13 +0000
Date: Thu, 5 Dec 2019 09:35:09 +0000 (UTC)
From: Yoonus <mailych@yahoo.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Message-ID: <622579253.3909060.1575538509713@mail.yahoo.com>
MIME-Version: 1.0
References: <622579253.3909060.1575538509713.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.14728 YMailNorrin Mozilla/5.0 (Windows NT 6.1; Win64;
	x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120
	Safari/537.36
Subject: BitBake - How to run do_install_prepend() for single machine conf
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
X-List-Received-Date: Thu, 05 Dec 2019 09:35:13 -0000
Content-Type: multipart/alternative; 
	boundary="----=_Part_3909059_553992535.1575538509712"

------=_Part_3909059_553992535.1575538509712
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,
I have a bb file with following functions.=C2=A0do_install_prepend() is for=
 default/base machine configuration.do_install_prepend_m1() is for m1 machi=
ne configuration.do_install_prepend_m2() is for m2 machine configuration.do=
_install_prepend_m3() is for m3 machine configuration.
m1 is derived from default configuration. m2 and m3 are derived from m1.
When I run bb file for m3 machine configuration, I see, it runs do_install_=
prepend_m3(), do_install_prepend_m1() and do_install_prepend(). All 3 funct=
ions are called.
Is there a way to modify this bb, so that, only do_install_prepend_m3() is =
run? If do_install_prepend_m3() is not present, then it should run do_insta=
ll_prepend_m1().If that is not present, it should run do_install_prepend().=
 That is, I only want to run one function.

do_install_prepend () {=C2=A0 echo "default install_prepend"}
do_install_prepend_m1 () {=C2=A0 echo "m1 install_prepend"}
do_install_prepend_m2 () {=C2=A0 echo "m2 install_prepend"}
do_install_prepend_m3 () {=C2=A0 echo "m3 install_prepend"}

Thanks for your help.

------=_Part_3909059_553992535.1575538509712
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body><div class=3D"yahoo-style-wrap" style=3D"font-fami=
ly:garamond, new york, times, serif;font-size:16px;"><div dir=3D"ltr" data-=
setdir=3D"false"><div><div><font face=3D"courier new, courier, monaco, mono=
space, sans-serif" size=3D"2">Hi,</font></div><div><font face=3D"courier ne=
w, courier, monaco, monospace, sans-serif" size=3D"2"><br></font></div><div=
><font face=3D"courier new, courier, monaco, monospace, sans-serif" size=3D=
"2">I have a bb file with following functions.&nbsp;</font></div><div><font=
 face=3D"courier new, courier, monaco, monospace, sans-serif" size=3D"2">do=
_install_prepend() is for default/base machine configuration.</font></div><=
div><font face=3D"courier new, courier, monaco, monospace, sans-serif" size=
=3D"2">do_install_prepend_m1() is for m1 machine configuration.</font></div=
><div><font face=3D"courier new, courier, monaco, monospace, sans-serif" si=
ze=3D"2">do_install_prepend_m2() is for m2 machine configuration.</font></d=
iv><div><font face=3D"courier new, courier, monaco, monospace, sans-serif" =
size=3D"2">do_install_prepend_m3() is for m3 machine configuration.</font><=
/div><div><font face=3D"courier new, courier, monaco, monospace, sans-serif=
" size=3D"2"><br></font></div><div><font face=3D"courier new, courier, mona=
co, monospace, sans-serif" size=3D"2">m1 is derived from default configurat=
ion. m2 and m3 are derived from m1.</font></div><div><font face=3D"courier =
new, courier, monaco, monospace, sans-serif" size=3D"2"><br></font></div><d=
iv><font face=3D"courier new, courier, monaco, monospace, sans-serif" size=
=3D"2">When I run bb file for m3 machine configuration, I see, it runs do_i=
nstall_prepend_m3(), do_install_prepend_m1() and do_install_prepend(). All =
3 functions are called.</font></div><div><font face=3D"courier new, courier=
, monaco, monospace, sans-serif" size=3D"2"><br></font></div><div><font fac=
e=3D"courier new, courier, monaco, monospace, sans-serif" size=3D"2">Is the=
re a way to modify this bb, so that, only do_install_prepend_m3() is run? I=
f do_install_prepend_m3() is not present, then it should run do_install_pre=
pend_m1().</font></div><div><font face=3D"courier new, courier, monaco, mon=
ospace, sans-serif" size=3D"2">If that is not present, it should run do_ins=
tall_prepend(). That is, I only want to run one function.</font></div><div>=
<font face=3D"courier new, courier, monaco, monospace, sans-serif" size=3D"=
2"><br></font></div><div><font face=3D"courier new, courier, monaco, monosp=
ace, sans-serif" size=3D"2"><br></font></div><div><font face=3D"courier new=
, courier, monaco, monospace, sans-serif" size=3D"2">do_install_prepend () =
{</font></div><div><font face=3D"courier new, courier, monaco, monospace, s=
ans-serif" size=3D"2">&nbsp; echo "default install_prepend"</font></div><di=
v><font face=3D"courier new, courier, monaco, monospace, sans-serif" size=
=3D"2">}</font></div><div><font face=3D"courier new, courier, monaco, monos=
pace, sans-serif" size=3D"2"><br></font></div><div><font face=3D"courier ne=
w, courier, monaco, monospace, sans-serif" size=3D"2">do_install_prepend_m1=
 () {</font></div><div><font face=3D"courier new, courier, monaco, monospac=
e, sans-serif" size=3D"2">&nbsp; echo "m1 install_prepend"</font></div><div=
><font face=3D"courier new, courier, monaco, monospace, sans-serif" size=3D=
"2">}</font></div><div><font face=3D"courier new, courier, monaco, monospac=
e, sans-serif" size=3D"2"><br></font></div><div><font face=3D"courier new, =
courier, monaco, monospace, sans-serif" size=3D"2">do_install_prepend_m2 ()=
 {</font></div><div><font face=3D"courier new, courier, monaco, monospace, =
sans-serif" size=3D"2">&nbsp; echo "m2 install_prepend"</font></div><div><f=
ont face=3D"courier new, courier, monaco, monospace, sans-serif" size=3D"2"=
>}</font></div><div><font face=3D"courier new, courier, monaco, monospace, =
sans-serif" size=3D"2"><br></font></div><div><font face=3D"courier new, cou=
rier, monaco, monospace, sans-serif" size=3D"2">do_install_prepend_m3 () {<=
/font></div><div><font face=3D"courier new, courier, monaco, monospace, san=
s-serif" size=3D"2">&nbsp; echo "m3 install_prepend"</font></div><div><font=
 face=3D"courier new, courier, monaco, monospace, sans-serif" size=3D"2">}<=
/font></div><div><font face=3D"courier new, courier, monaco, monospace, san=
s-serif" size=3D"2"><br></font></div><div><font face=3D"courier new, courie=
r, monaco, monospace, sans-serif" size=3D"2"><br></font></div><div><font fa=
ce=3D"courier new, courier, monaco, monospace, sans-serif" size=3D"2">Thank=
s for your help.</font></div></div><br></div></div></body></html>

------=_Part_3909059_553992535.1575538509712--
